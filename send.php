<?php
// iSecure website form handler -> SMTP2GO
// API key lives OUTSIDE public_html so it can never be served as text.
declare(strict_types=1);
header('Content-Type: application/json');

const TO        = 'info@isecureu.com.au';
const SENDER    = 'iSecure Website <isecure@vjbgroup.com.au>';
const ALLOWED   = ['isecureu.com.au', 'www.isecureu.com.au'];
const MIN_FILL_MS = 3000;   // humans take longer than this to fill a form
const MAX_PER_HOUR = 5;     // per IP
const MAX_LEN     = 5000;

function fail(int $code, string $msg): never {
    http_response_code($code);
    echo json_encode(['error' => $msg]);
    exit;
}

// --- origin: only accept posts that came from our own pages -------------
$origin = $_SERVER['HTTP_ORIGIN'] ?? '';
$ref    = $_SERVER['HTTP_REFERER'] ?? '';
$host   = '';
if ($origin !== '')   $host = parse_url($origin, PHP_URL_HOST) ?: '';
elseif ($ref !== '')  $host = parse_url($ref, PHP_URL_HOST) ?: '';
if (!in_array(strtolower($host), ALLOWED, true)) {
    fail(403, 'Forbidden');
}
header('Access-Control-Allow-Origin: https://' . $host);
header('Vary: Origin');

if (($_SERVER['REQUEST_METHOD'] ?? '') === 'OPTIONS') { http_response_code(204); exit; }
if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST')    fail(405, 'Method not allowed');

$config = @include __DIR__ . '/../isecure-mail-config.php';
$apiKey = is_array($config) && !empty($config['smtp2go_api_key'])
        ? $config['smtp2go_api_key'] : getenv('SMTP2GO_API_KEY');
if (!$apiKey) { error_log('iSecure form: api key missing'); fail(500, 'Mail is not configured'); }

$body = json_decode((string)file_get_contents('php://input'), true);
if (!is_array($body)) $body = $_POST;

// --- honeypot: accept, send nothing ------------------------------------
if (!empty($body['website']) || !empty($body['hp'])) { echo json_encode(['ok' => true]); exit; }

// --- time trap: submitted impossibly fast, or field absent (direct post)
$elapsed = isset($body['elapsed']) ? (int)$body['elapsed'] : -1;
if ($elapsed < MIN_FILL_MS) { fail(400, 'Please try again'); }

// --- per-IP rate limit (file based; no database on this host) ----------
$ip  = $_SERVER['REMOTE_ADDR'] ?? '0.0.0.0';
$dir = __DIR__ . '/../isecure-ratelimit';
if (!is_dir($dir)) @mkdir($dir, 0700, true);
$f = $dir . '/' . hash('sha256', $ip) . '.json';
$now = time();
$hits = [];
if (is_readable($f)) {
    $prev = json_decode((string)@file_get_contents($f), true);
    if (is_array($prev)) $hits = array_values(array_filter($prev, fn($t) => ($now - (int)$t) < 3600));
}
if (count($hits) >= MAX_PER_HOUR) {
    error_log('iSecure form: rate limited ' . $ip);
    fail(429, 'Too many messages. Please call 1300 012 029.');
}
$hits[] = $now;
@file_put_contents($f, json_encode($hits), LOCK_EX);

// --- validate ----------------------------------------------------------
$FORMS = [
  'contact'  => ['subject' => 'Website enquiry',     'fields' => ['name','email','phone','company','suburb','type','help','message']],
  'careers'  => ['subject' => 'Careers application', 'fields' => ['name','email','phone','company','role','message']],
  'feedback' => ['subject' => 'Website feedback',    'fields' => ['name','company','suburb','service','rating','message']],
];
$form    = $FORMS[$body['form'] ?? 'contact'] ?? $FORMS['contact'];
$name    = trim((string)($body['name'] ?? ''));
$message = trim((string)($body['message'] ?? ''));
if ($name === '' || $message === '') fail(400, 'Name and message are required');
if (mb_strlen($name) > 200 || mb_strlen($message) > MAX_LEN) fail(400, 'Message is too long');

$rows = [];
foreach ($form['fields'] as $k) {
    $v = trim((string)($body[$k] ?? ''));
    if ($v !== '') $rows[ucfirst($k)] = mb_substr($v, 0, MAX_LEN);
}

$text = ''; $html = '<h2 style="font-family:sans-serif">' . htmlspecialchars($form['subject']) . '</h2>'
       . '<table style="font-family:sans-serif;border-collapse:collapse">';
foreach ($rows as $label => $value) {
    $text .= "$label: $value\n";
    $html .= '<tr><td style="padding:6px 14px 6px 0;vertical-align:top;color:#555"><strong>'
          .  htmlspecialchars($label) . '</strong></td><td style="padding:6px 0">'
          .  nl2br(htmlspecialchars($value)) . '</td></tr>';
}
$html .= '</table><p style="font-family:sans-serif;color:#888;font-size:12px">Sent from the iSecure website.</p>';

$payload = [
  'api_key' => $apiKey, 'to' => [TO], 'sender' => SENDER,
  'subject' => $form['subject'] . ' from ' . $name,
  'text_body' => $text, 'html_body' => $html,
];
$email = trim((string)($body['email'] ?? ''));
if ($email !== '' && filter_var($email, FILTER_VALIDATE_EMAIL)) {
    $payload['custom_headers'] = [['header' => 'Reply-To', 'value' => $email]];
}

$ch = curl_init('https://api.smtp2go.com/v3/email/send');
curl_setopt_array($ch, [
  CURLOPT_POST => true, CURLOPT_RETURNTRANSFER => true, CURLOPT_TIMEOUT => 20,
  CURLOPT_HTTPHEADER => ['Content-Type: application/json'],
  CURLOPT_POSTFIELDS => json_encode($payload),
]);
$res = curl_exec($ch); $code = curl_getinfo($ch, CURLINFO_HTTP_CODE); $err = curl_error($ch); curl_close($ch);
$out = json_decode((string)$res, true);
if ($code !== 200 || (int)($out['data']['succeeded'] ?? 0) < 1) {
    error_log('iSecure form: SMTP2GO failed http=' . $code . ' curl=' . $err . ' body=' . substr((string)$res, 0, 500));
    fail(502, 'Could not send');
}
echo json_encode(['ok' => true]);
