<?php
// iSecure website form handler -> SMTP2GO
// The API key lives OUTSIDE public_html so it can never be served as text.
declare(strict_types=1);

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
    exit;
}

$config = @include __DIR__ . '/../isecure-mail-config.php';
$apiKey = is_array($config) && !empty($config['smtp2go_api_key']) ? $config['smtp2go_api_key'] : getenv('SMTP2GO_API_KEY');
if (!$apiKey) {
    error_log('iSecure form: SMTP2GO api key missing');
    http_response_code(500);
    echo json_encode(['error' => 'Mail is not configured']);
    exit;
}

$TO     = 'stelios@vjbgroup.com.au';
$SENDER = 'iSecure Website <isecure@vjbgroup.com.au>';

$FORMS = [
    'contact'  => ['subject' => 'Website enquiry',     'fields' => ['name','email','phone','company','suburb','type','help','message']],
    'careers'  => ['subject' => 'Careers application', 'fields' => ['name','email','phone','company','role','message']],
    'feedback' => ['subject' => 'Website feedback',    'fields' => ['name','company','suburb','service','rating','message']],
];

$raw  = file_get_contents('php://input');
$body = json_decode($raw, true);
if (!is_array($body)) $body = $_POST;

// honeypot: pretend success, send nothing
if (!empty($body['website']) || !empty($body['hp'])) {
    echo json_encode(['ok' => true]);
    exit;
}

$key  = $body['form'] ?? 'contact';
$form = $FORMS[$key] ?? $FORMS['contact'];

$name    = trim((string)($body['name'] ?? ''));
$message = trim((string)($body['message'] ?? ''));
if ($name === '' || $message === '') {
    http_response_code(400);
    echo json_encode(['error' => 'Name and message are required']);
    exit;
}

$rows = [];
foreach ($form['fields'] as $f) {
    $v = trim((string)($body[$f] ?? ''));
    if ($v !== '') $rows[ucfirst($f)] = $v;
}

$text = '';
$html = '<h2 style="font-family:sans-serif">' . htmlspecialchars($form['subject']) . '</h2>'
      . '<table style="font-family:sans-serif;border-collapse:collapse">';
foreach ($rows as $label => $value) {
    $text .= "$label: $value\n";
    $html .= '<tr><td style="padding:6px 14px 6px 0;vertical-align:top;color:#555"><strong>'
          .  htmlspecialchars($label) . '</strong></td><td style="padding:6px 0">'
          .  nl2br(htmlspecialchars($value)) . '</td></tr>';
}
$html .= '</table><p style="font-family:sans-serif;color:#888;font-size:12px">Sent from the iSecure website.</p>';

$payload = [
    'api_key'   => $apiKey,
    'to'        => [$TO],
    'sender'    => $SENDER,
    'subject'   => $form['subject'] . ' from ' . $name,
    'text_body' => $text,
    'html_body' => $html,
];

$email = trim((string)($body['email'] ?? ''));
if ($email !== '' && filter_var($email, FILTER_VALIDATE_EMAIL)) {
    $payload['custom_headers'] = [['header' => 'Reply-To', 'value' => $email]];
}

$ch = curl_init('https://api.smtp2go.com/v3/email/send');
curl_setopt_array($ch, [
    CURLOPT_POST           => true,
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_TIMEOUT        => 20,
    CURLOPT_HTTPHEADER     => ['Content-Type: application/json'],
    CURLOPT_POSTFIELDS     => json_encode($payload),
]);
$res  = curl_exec($ch);
$code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
$err  = curl_error($ch);
curl_close($ch);

$out = json_decode((string)$res, true);
$sent = isset($out['data']['succeeded']) ? (int)$out['data']['succeeded'] : 0;

if ($code !== 200 || $sent < 1) {
    error_log('iSecure form: SMTP2GO failed http=' . $code . ' curl=' . $err . ' body=' . substr((string)$res, 0, 500));
    http_response_code(502);
    echo json_encode(['error' => 'Could not send']);
    exit;
}

echo json_encode(['ok' => true]);
