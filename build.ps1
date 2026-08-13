# Builds static pages: head.tpl + content/<page>.html + foot.tpl -> output
$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
$head = [IO.File]::ReadAllText("$root\partials\head.tpl")
$foot = [IO.File]::ReadAllText("$root\partials\foot.tpl")
$utf8 = New-Object System.Text.UTF8Encoding($false)

$pages = @(
  @{ out='index.html';               rel='';    src='home.html';          title="Security Systems Sydney | CCTV, Alarms and Monitoring | iSecure"; desc="Australian owned, family run security. CCTV, alarms, intercoms, access control and 24/7 back-to-base monitoring. 30+ years. Call 1300 012 029." },
  @{ out='about-us\index.html';      rel='../'; src='about-us.html';      title="About iSecure | Family Owned Security Company, Sydney"; desc="Family owned and Australian operated for 30+ years. NSW Master Licence 000103530, ASIAL member, 24/7 monitoring centre. Meet iSecure." },
  @{ out='services\index.html';      rel='../'; src='services.html';      title="Security Services | CCTV, Alarms, Access Control | iSecure"; desc="Every layer of security from one accountable team: cameras, alarms, intercoms, access control and 24/7 monitoring. Fast quotes: 1300 012 029." },
  @{ out='cctv\index.html';          rel='../'; src='cctv.html';          title="CCTV Installation Sydney | HD Camera Systems | iSecure"; desc="HD CCTV with night vision, smart alerts and remote viewing, installed by licensed technicians and monitored 24/7. Fast quotes: 1300 012 029." },
  @{ out='alarm-systems\index.html'; rel='../'; src='alarm-systems.html'; title="Alarm Systems Sydney | Back-to-Base Alarms | iSecure"; desc="Alarm systems with motion, entry and glass break sensors, monitored 24/7 by our own centre. Family owned, 30+ years. 1300 012 029." },
  @{ out='access-control\index.html';rel='../'; src='access-control.html';title="Access Control Systems Sydney | Keypads and Fobs | iSecure"; desc="Control who enters, where and when. Keypads, fobs and managed credentials for business and home, installed and supported by iSecure." },
  @{ out='intercom\index.html';      rel='../'; src='intercom.html';      title="Video Intercom Systems Sydney | Home and Building | iSecure"; desc="See and speak to visitors from anywhere, unlock remotely, and secure apartment buildings. iSecure video intercoms, installed properly." },
  @{ out='monitoring\index.html';    rel='../'; src='monitoring.html';    title="Alarm Monitoring | 24/7 Back-to-Base Centre | iSecure"; desc="Our monitoring centre is staffed 24/7, 365 days a year. Instant response and police notification. Put professionals behind your alarm." },
  @{ out='patrols\index.html';       rel='../'; src='patrols.html';       title="Mobile Patrols Sydney | All Hours Business Patrols | iSecure"; desc="All hours mobile patrols and alarm response for businesses. Scheduled and random checks, lock-ups and patrol reports. Call 1300 012 029." },
  @{ out='guard-services\index.html';rel='../'; src='guard-services.html';title="Security Guards Sydney | Venue, Retail, Event, Corporate | iSecure"; desc="Licensed, uniformed security guards for venues, retail, events and corporate sites, backed by a 24/7 monitoring centre. Call 1300 012 029." },
  @{ out='video-monitoring\index.html'; rel='../'; src='video-monitoring.html'; title="Video Monitoring | Live CCTV Monitoring | iSecure"; desc="Your cameras watched live by trained operators. Video verification, virtual patrols and rapid response, 24/7. Call 1300 012 029." },
  @{ out='gallery\index.html';          rel='../'; src='gallery.html';          title="Gallery | iSecure At Work"; desc="Real photos of the iSecure team on the job: installs, patrol vehicles, monitoring and the fleet." },
  @{ out='feedback\index.html';         rel='../'; src='feedback.html';         title="Feedback | iSecure"; desc="Tell us how we did. Feedback goes straight to the family that runs iSecure." },
  @{ out='locations\index.html';     rel='../'; src='locations.html';     title="Service Areas | Sydney, QLD, VIC and Nationwide | iSecure"; desc="Based in Sydney, protecting properties nationwide through our own network. One security partner for every site, one monitoring centre." },
  @{ out='sydney\index.html';        rel='../'; src='sydney.html';        title="Security Services NSW | Kingsgrove Based | iSecure"; desc="NSW security from a Sydney family: CCTV, alarms and 24/7 monitoring across Greater Sydney, the Central Coast and regional NSW. Call 1300 012 029." },
  @{ out='queensland\index.html';    rel='../'; src='queensland.html';    title="Security Services Queensland | Brisbane and SEQ | iSecure"; desc="iSecure standards for Queensland: cameras, alarms, access control and 24/7 back-to-base monitoring for Brisbane and the south-east." },
  @{ out='victoria\index.html';      rel='../'; src='victoria.html';      title="Security Services Victoria | Melbourne Coverage | iSecure"; desc="Security design, installation and 24/7 monitoring for Melbourne and Victoria through iSecure's nationwide network." },
  @{ out='act\index.html';           rel='../'; src='act.html';           title="Security Services Canberra ACT | CCTV and Alarms | iSecure"; desc="CCTV, alarms, access control and 24/7 monitoring for Canberra and the ACT. One provider for every site. Call 1300 012 029." },
  @{ out='wa\index.html';            rel='../'; src='wa.html';            title="Security Services Perth WA | CCTV and Monitoring | iSecure"; desc="Security design, installation and 24/7 back-to-base monitoring for Perth and Western Australia. Call 1300 012 029." },
  @{ out='nt\index.html';            rel='../'; src='nt.html';            title="Security Services Darwin NT | CCTV and Alarms | iSecure"; desc="Cameras, alarms, access control and 24/7 monitoring for Darwin and the Northern Territory, specified for Territory conditions." },
  @{ out='sa\index.html';            rel='../'; src='sa.html';            title="Security Services Adelaide SA | CCTV and Alarms | iSecure"; desc="CCTV, alarms, access control and 24/7 monitoring for Adelaide and South Australia. One provider, one invoice. 1300 012 029." },
  @{ out='tas\index.html';           rel='../'; src='tas.html';           title="Security Services Tasmania | Hobart and Launceston | iSecure"; desc="Security systems and 24/7 back-to-base monitoring for Hobart, Launceston and Tasmanian businesses. Call 1300 012 029." },
  @{ out='careers\index.html';       rel='../'; src='careers.html';       title="Careers | Security Technician and Monitoring Jobs | iSecure"; desc="Join a family owned Sydney security company: technicians, monitoring operators and apprentices. 30+ years of steady, serious work." },
  @{ out='contact-us\index.html';    rel='../'; src='contact-us.html';    title="Contact iSecure | Open 24 Hours | 1300 012 029"; desc="Call 1300 012 029 any hour, any day, or request a fast quote online. Kingsgrove based, servicing Sydney and nationwide." },
  @{ out='privacy\index.html';       rel='../'; src='privacy.html';       title="Privacy Policy | iSecure"; desc="How iSecure collects, uses and protects your personal information. Client privacy is of paramount importance to us." },
  @{ out='thank-you\index.html';     rel='../'; src='thank-you.html';     title="Thank You | iSecure"; desc="Your enquiry has landed with our team."; noindex=$true }
)

foreach ($p in $pages) {
  $content = [IO.File]::ReadAllText("$root\content\$($p.src)")
  $html = ($head + "`n" + $content + "`n" + $foot)
  $html = $html.Replace('{{TITLE}}', $p.title).Replace('{{DESC}}', $p.desc).Replace('{{ROOT}}', $p.rel)
  if ($p.noindex) { $html = $html.Replace('</title>', "</title>`n<meta name=`"robots`" content=`"noindex`">") }
  $outPath = Join-Path $root $p.out
  $dir = Split-Path $outPath -Parent
  if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force $dir | Out-Null }
  [IO.File]::WriteAllText($outPath, $html, $utf8)
  Write-Host "built $($p.out)"
}
Write-Host "done: $($pages.Count) pages"
