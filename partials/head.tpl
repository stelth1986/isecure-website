<!DOCTYPE html>
<html lang="en-AU">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>{{TITLE}}</title>
<meta name="description" content="{{DESC}}">
<link rel="icon" href="{{ROOT}}assets/isecure-favicon.png">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Sora:ital,wght@0,300;0,400;0,600;0,700&family=Figtree:wght@400;500;600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="{{ROOT}}css/site.css?v=13">
</head>
<body>

<!-- floating pill header with mega menu -->
<div class="headwrap" id="headwrap">
  <div class="headbar">
    <a href="{{ROOT}}index.html" class="brand" aria-label="iSecure home">
      <img class="lockup" src="{{ROOT}}assets/isecure-logo-horizontal.png" alt="iSecure">
    </a>
    <nav class="mainnav" aria-label="Main navigation">
      <a href="{{ROOT}}index.html">Home</a>
      <a href="{{ROOT}}about-us/">About us</a>
      <button type="button" data-mega="services" aria-expanded="false" aria-haspopup="true">Services
        <svg class="chev" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m6 9 6 6 6-6"/></svg>
      </button>
      <button type="button" data-mega="locations" aria-expanded="false" aria-haspopup="true">Locations
        <svg class="chev" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m6 9 6 6 6-6"/></svg>
      </button>
      <a href="{{ROOT}}gallery/">Gallery</a>
      <a href="{{ROOT}}careers/">Careers</a>
    </nav>
    <div class="header-cta">
      <a class="btn btn-phone" href="tel:1300012029">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 22 16.92z"/></svg>
        1300 012 029
      </a>
      <a class="btn btn-primary" href="{{ROOT}}contact-us/">Get a fast quote <span class="arr">&rarr;</span></a>
      <button class="hamburger" id="hamburger" aria-label="Open menu">
        <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M4 6h16M4 12h16M4 18h16"/></svg>
      </button>
    </div>
  </div>

  <!-- services mega panel -->
  <div class="mega" data-mega="services" role="menu" aria-label="Services menu">
    <div class="mega-grid">
      <div class="mega-items">
        <a class="mega-item" href="{{ROOT}}cctv/">
          <span class="icon-tile"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"><path d="M16.75 13.96 19 15.25a2 2 0 0 0 3-1.73V6.48a2 2 0 0 0-3-1.73l-2.25 1.29"/><rect x="2" y="6" width="14" height="12" rx="2"/></svg></span>
          <span><span class="t">CCTV surveillance</span><span class="s">HD cameras, night vision and live viewing on your phone.</span></span>
        </a>
        <a class="mega-item" href="{{ROOT}}alarm-systems/">
          <span class="icon-tile"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"><path d="M6 8a6 6 0 0 1 12 0c0 7 3 9 3 9H3s3-2 3-9"/><path d="M10.3 21a1.94 1.94 0 0 0 3.4 0"/></svg></span>
          <span><span class="t">Alarm systems</span><span class="s">Back-to-base alarms for homes and businesses.</span></span>
        </a>
        <a class="mega-item" href="{{ROOT}}access-control/">
          <span class="icon-tile"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"><rect x="3" y="11" width="18" height="11" rx="2"/><path d="M7 11V7a5 5 0 0 1 10 0v4"/></svg></span>
          <span><span class="t">Access control</span><span class="s">Keypads, fobs and managed credentials for every door.</span></span>
        </a>
        <a class="mega-item" href="{{ROOT}}intercom/">
          <span class="icon-tile"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"><path d="M14 9a2 2 0 0 1-2 2H6l-4 4V4a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2z"/><path d="M18 9h2a2 2 0 0 1 2 2v11l-4-4h-6a2 2 0 0 1-2-2v-1"/></svg></span>
          <span><span class="t">Intercom systems</span><span class="s">See and speak to visitors before you open the door.</span></span>
        </a>
        <a class="mega-item" href="{{ROOT}}monitoring/">
          <span class="icon-tile"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="3"/><path d="M12 2v3M12 19v3M2 12h3M19 12h3M4.9 4.9l2.1 2.1M17 17l2.1 2.1M4.9 19.1 7 17M17 7l2.1-2.1"/></svg></span>
          <span><span class="t">Alarm monitoring</span><span class="s">Our 24/7 centre watches and responds instantly.</span></span>
        </a>
        <a class="mega-item" href="{{ROOT}}video-monitoring/">
          <span class="icon-tile"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"><path d="M2 12s3.5-7 10-7 10 7 10 7-3.5 7-10 7-10-7-10-7"/><circle cx="12" cy="12" r="3"/></svg></span>
          <span><span class="t">Video monitoring</span><span class="s">Your cameras watched live by trained operators.</span></span>
        </a>
        <a class="mega-item" href="{{ROOT}}patrols/">
          <span class="icon-tile"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"><path d="M2 12h4l3-9 4 18 3-9h6"/></svg></span>
          <span><span class="t">Area patrols</span><span class="s">All hours patrols and alarm response for businesses.</span></span>
        </a>
        <a class="mega-item" href="{{ROOT}}guard-services/">
          <span class="icon-tile"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="8" r="4"/><path d="M4 21v-1a7 7 0 0 1 14 0v1"/></svg></span>
          <span><span class="t">Guard services</span><span class="s">Licensed guards for venues, retail, events and corporate.</span></span>
        </a>
        <a class="mega-item all" href="{{ROOT}}services/">All services &rarr;</a>
      </div>
      <div class="mega-feature">
        <img src="{{ROOT}}media/dsc-6207.webp" alt="Shelves of alarm sensors and detectors in the iSecure warehouse">
        <div class="mf-body">
          <span class="t"><span class="live-dot"></span> One accountable team</span>
          <span class="s">Supplied, installed and monitored by iSecure, 24 hours a day.</span>
          <a class="btn btn-primary" href="{{ROOT}}contact-us/">Get a fast quote <span class="arr">&rarr;</span></a>
        </div>
      </div>
    </div>
  </div>

  <!-- locations mega panel -->
  <div class="mega" data-mega="locations" role="menu" aria-label="Locations menu">
    <div class="mega-grid">
      <div class="mega-items">
        <a class="mega-item" href="{{ROOT}}sydney/">
          <span class="icon-tile"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"><path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"/><circle cx="12" cy="10" r="3"/></svg></span>
          <span><span class="t">New South Wales</span><span class="s">Our home base: Greater Sydney and the Central Coast, from Kingsgrove.</span></span>
        </a>
        <a class="mega-item" href="{{ROOT}}queensland/">
          <span class="icon-tile"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"><path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"/><circle cx="12" cy="10" r="3"/></svg></span>
          <span><span class="t">Queensland</span><span class="s">Brisbane and south-east Queensland coverage.</span></span>
        </a>
        <a class="mega-item" href="{{ROOT}}victoria/">
          <span class="icon-tile"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"><path d="M20 10c0 4.993-5.539 10.193-7.399 11.799a1 1 0 0 1-1.202 0C9.539 20.193 4 14.993 4 10a8 8 0 0 1 16 0"/><circle cx="12" cy="10" r="3"/></svg></span>
          <span><span class="t">Victoria</span><span class="s">Melbourne and Victoria through Protect 24x7.</span></span>
        </a>
        <a class="mega-item" href="{{ROOT}}locations/">
          <span class="icon-tile"><svg width="22" height="22" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"><path d="M20 13c0 5-3.5 7.5-7.66 8.95a1 1 0 0 1-.67-.01C7.5 20.5 4 18 4 13V6a1 1 0 0 1 1-1c2 0 4.5-1.2 6.24-2.72a1.17 1.17 0 0 1 1.52 0C14.51 3.81 17 5 19 5a1 1 0 0 1 1 1z"/></svg></span>
          <span><span class="t">Nationwide coverage</span><span class="s">One partner for every site, in every state.</span></span>
        </a>
        <a class="mega-item all" href="{{ROOT}}locations/">All locations &rarr;</a>
      </div>
      <div class="mega-feature">
        <img src="{{ROOT}}media/dsc-5674.webp" alt="The iSecure logo and ASIAL member sticker on a van door">
        <div class="mf-body">
          <span class="t">Based in Kingsgrove, Sydney</span>
          <span class="s">Protecting properties across Australia for more than 30 years.</span>
          <a class="btn btn-primary" href="{{ROOT}}contact-us/">Talk to us <span class="arr">&rarr;</span></a>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- mobile drawer -->
<div class="drawer-scrim" id="drawerScrim"></div>
<aside class="drawer" id="drawer" aria-label="Mobile menu">
  <div class="drawer-top">
    <img src="{{ROOT}}assets/isecure-logo-horizontal.png" alt="iSecure" style="height:32px;width:auto">
    <button class="drawer-close" id="drawerClose" aria-label="Close menu">
      <svg width="26" height="26" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round"><path d="M18 6 6 18M6 6l12 12"/></svg>
    </button>
  </div>
  <nav>
    <a href="{{ROOT}}index.html">Home</a>
    <a href="{{ROOT}}about-us/">About us</a>
    <button type="button" data-sub="subServices" aria-expanded="false">Services
      <svg class="chev" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m6 9 6 6 6-6"/></svg>
    </button>
    <div class="sub" id="subServices">
      <a href="{{ROOT}}cctv/">CCTV surveillance</a>
      <a href="{{ROOT}}alarm-systems/">Alarm systems</a>
      <a href="{{ROOT}}access-control/">Access control</a>
      <a href="{{ROOT}}intercom/">Intercom systems</a>
      <a href="{{ROOT}}monitoring/">Alarm monitoring</a>
      <a href="{{ROOT}}video-monitoring/">Video monitoring</a>
      <a href="{{ROOT}}patrols/">Area patrols</a>
      <a href="{{ROOT}}guard-services/">Guard services</a>
      <a href="{{ROOT}}services/">All services</a>
    </div>
    <button type="button" data-sub="subLocations" aria-expanded="false">Locations
      <svg class="chev" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m6 9 6 6 6-6"/></svg>
    </button>
    <div class="sub" id="subLocations">
      <a href="{{ROOT}}sydney/">New South Wales</a>
      <a href="{{ROOT}}queensland/">Queensland</a>
      <a href="{{ROOT}}victoria/">Victoria</a>
      <a href="{{ROOT}}locations/">All locations</a>
    </div>
    <a href="{{ROOT}}gallery/">Gallery</a>
    <a href="{{ROOT}}careers/">Careers</a>
    <a href="{{ROOT}}contact-us/">Contact</a>
  </nav>
  <div class="drawer-cta">
    <a class="btn btn-primary" href="{{ROOT}}contact-us/">Get a fast quote <span class="arr">&rarr;</span></a>
    <a class="btn btn-secondary on-dark" href="tel:1300012029">Call 1300 012 029</a>
  </div>
</aside>
