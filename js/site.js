// iSecure site behaviour
(function(){
  var reduced = matchMedia('(prefers-reduced-motion: reduce)').matches;

  // header shrink
  var headwrap = document.getElementById('headwrap');
  if (headwrap) {
    addEventListener('scroll', function(){ headwrap.classList.toggle('scrolled', scrollY >= 64); }, {passive:true});
  }

  // mega menus
  var openMega = null, closeTimer = null;
  function setMega(name){
    document.querySelectorAll('.mega').forEach(function(p){
      var on = p.dataset.mega === name;
      p.classList.toggle('open', on);
    });
    document.querySelectorAll('nav.mainnav button[data-mega]').forEach(function(b){
      b.setAttribute('aria-expanded', b.dataset.mega === name ? 'true' : 'false');
    });
    openMega = name;
  }
  document.querySelectorAll('nav.mainnav button[data-mega]').forEach(function(btn){
    var name = btn.dataset.mega;
    btn.addEventListener('mouseenter', function(){ clearTimeout(closeTimer); closeTimer = setTimeout(function(){ setMega(name); }, 80); });
    btn.addEventListener('click', function(){ setMega(openMega === name ? null : name); });
    btn.addEventListener('focus', function(){ setMega(name); });
  });
  document.querySelectorAll('nav.mainnav > a').forEach(function(a){
    a.addEventListener('mouseenter', function(){ clearTimeout(closeTimer); closeTimer = setTimeout(function(){ setMega(null); }, 120); });
  });
  document.querySelectorAll('.mega').forEach(function(p){
    p.addEventListener('mouseenter', function(){ clearTimeout(closeTimer); });
    p.addEventListener('mouseleave', function(){ closeTimer = setTimeout(function(){ setMega(null); }, 200); });
  });
  if (headwrap) headwrap.addEventListener('mouseleave', function(){ closeTimer = setTimeout(function(){ setMega(null); }, 250); });
  document.addEventListener('click', function(e){ if (headwrap && !headwrap.contains(e.target)) setMega(null); });
  document.addEventListener('keydown', function(e){ if (e.key === 'Escape') { setMega(null); closeDrawer(); } });

  // mobile drawer
  var drawer = document.getElementById('drawer'), scrim = document.getElementById('drawerScrim');
  function openDrawer(){ if(!drawer) return; drawer.classList.add('open'); scrim.classList.add('open'); document.body.style.overflow='hidden'; }
  function closeDrawer(){ if(!drawer) return; drawer.classList.remove('open'); scrim.classList.remove('open'); document.body.style.overflow=''; }
  var hb = document.getElementById('hamburger');
  if (hb) hb.addEventListener('click', openDrawer);
  var dc = document.getElementById('drawerClose');
  if (dc) dc.addEventListener('click', closeDrawer);
  if (scrim) scrim.addEventListener('click', closeDrawer);
  document.querySelectorAll('.drawer button[data-sub]').forEach(function(btn){
    btn.addEventListener('click', function(){
      var sub = document.getElementById(btn.dataset.sub);
      var open = sub.classList.contains('open');
      sub.classList.toggle('open', !open);
      btn.setAttribute('aria-expanded', String(!open));
    });
  });

  // hero video management
  var heroVideo = document.getElementById('heroVideo');
  if (heroVideo) {
    if (reduced) { heroVideo.removeAttribute('autoplay'); heroVideo.pause(); }
    else {
      new IntersectionObserver(function(es){ es.forEach(function(e){ e.isIntersecting ? heroVideo.play().catch(function(){}) : heroVideo.pause(); }); }, {threshold:.1}).observe(heroVideo);
      document.addEventListener('visibilitychange', function(){ document.hidden ? heroVideo.pause() : heroVideo.play().catch(function(){}); });
    }
  }

  // scroll reveal
  var io = new IntersectionObserver(function(es){ es.forEach(function(e){ if (e.isIntersecting) { e.target.classList.add('in'); io.unobserve(e.target); } }); }, {threshold:.2});
  document.querySelectorAll('.reveal').forEach(function(el){ io.observe(el); });

  // stat counters
  var cio = new IntersectionObserver(function(es){
    es.forEach(function(e){
      if (!e.isIntersecting) return; cio.unobserve(e.target);
      var el = e.target, target = +el.dataset.count, suf = el.dataset.suffix || '', t0 = performance.now();
      if (reduced) { el.textContent = target + suf; return; }
      (function tick(t){
        var p = Math.min((t - t0) / 1200, 1), v = Math.round(target * (1 - Math.pow(1 - p, 3)));
        el.textContent = v + suf;
        if (p < 1) requestAnimationFrame(tick);
      })(t0);
    });
  }, {threshold:.5});
  document.querySelectorAll('[data-count]').forEach(function(el){ cio.observe(el); });

  // FAQ accordion
  document.querySelectorAll('.faq-q').forEach(function(btn){
    btn.addEventListener('click', function(){
      var item = btn.parentElement, open = item.classList.contains('open');
      document.querySelectorAll('.faq-item.open').forEach(function(i){ i.classList.remove('open'); i.querySelector('.faq-a').style.maxHeight = null; });
      if (!open) { item.classList.add('open'); var a = item.querySelector('.faq-a'); a.style.maxHeight = a.scrollHeight + 'px'; }
    });
  });

  // forms: post to the mail function, then show the success state
  var FORM_ENDPOINT = '/send.php';
  var FORM_LOADED = Date.now();
  document.querySelectorAll('form[data-form]').forEach(function(form){
    form.addEventListener('submit', function(e){
      e.preventDefault();
      var hp = form.querySelector('.hp input');
      if (hp && hp.value) return;
      var required = form.querySelectorAll('[required]');
      for (var i = 0; i < required.length; i++) {
        if (!required[i].value.trim()) { required[i].focus(); return; }
      }
      var btn = form.querySelector('[type="submit"]');
      var label = btn ? btn.textContent : '';
      if (btn) { btn.disabled = true; btn.textContent = 'Sending...'; }
      var err = form.querySelector('.form-error');
      if (err) err.style.display = 'none';

      var data = { form: form.dataset.form, elapsed: Date.now() - FORM_LOADED };
      new FormData(form).forEach(function(v, k){ data[k] = v; });

      fetch(FORM_ENDPOINT, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
      }).then(function(r){
        if (!r.ok) throw new Error('send failed');
        var name = (form.querySelector('[name="name"]') || {}).value || '';
        form.style.display = 'none';
        var ok = form.parentElement.querySelector('.form-success');
        if (ok) {
          var n = ok.querySelector('[data-name]');
          if (n) n.textContent = name ? name.split(' ')[0] : 'there';
          ok.style.display = 'block';
        }
      }).catch(function(){
        if (btn) { btn.disabled = false; btn.textContent = label; }
        if (err) { err.style.display = 'block'; }
        else { alert('Sorry, that did not send. Please call 1300 012 029 or email info@isecureu.com.au.'); }
      });
    });
  });
})();
