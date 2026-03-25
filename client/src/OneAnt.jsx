import { useState, useEffect, useCallback, useRef } from "react";

/* ═══════════════════════════════════════════════════════════
   API HELPERS
═══════════════════════════════════════════════════════════ */
const api = async (method, path, body) => {
  const res = await fetch(path, {
    method,
    credentials: "include",
    headers: body ? { "Content-Type": "application/json" } : undefined,
    body: body ? JSON.stringify(body) : undefined,
  });
  if (!res.ok) {
    const e = await res.json().catch(() => ({}));
    throw new Error(e.message || res.statusText);
  }
  return res.json().catch(() => null);
};
const get = p => api("GET", p);
const post = (p, b) => api("POST", p, b);
const put = (p, b) => api("PUT", p, b);
const patch = (p, b) => api("PATCH", p, b);
const del = p => api("DELETE", p);

/* ═══════════════════════════════════════════════════════════
   GLOBAL STYLES
═══════════════════════════════════════════════════════════ */
const CSS = `
@import url('https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700;800&family=DM+Serif+Display:ital@0;1&display=swap');

*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}
:root{
  --g1:#1c6b39; --g2:#26913d; --g3:#32b04a; --gl:#e9f6ed; --gd:#144f2a;
  --r:#e8293a;  --y:#ffde00;
  --bg:#f5f7f5; --card:#fff; --border:#deeae1; --border2:#c5dbc9;
  --t1:#111d14; --t2:#3d5c42; --t3:#7a9e80;
  --sh0:0 1px 3px rgba(0,0,0,.06); --sh1:0 4px 14px rgba(0,0,0,.08); --sh2:0 8px 28px rgba(0,0,0,.12);
  --font:'DM Sans',sans-serif; --serif:'DM Serif Display',serif;
  --r4:4px; --r8:8px; --r12:12px; --r16:16px; --r24:24px; --rpill:999px;
}
html,body,#root{min-height:100%}
body{font-family:var(--font);background:#fff;color:var(--t1);-webkit-font-smoothing:antialiased;font-size:14px}
::-webkit-scrollbar{width:5px;height:5px}
::-webkit-scrollbar-thumb{background:var(--border2);border-radius:3px}

/* ── Announce bar ── */
.ann{background:#bef264;color:#111;font-size:12.5px;font-weight:500;padding:8px 0;overflow:hidden;white-space:nowrap;position:relative}
.ann-track{display:flex;gap:0;animation:ticker 28s linear infinite}
.ann-item{display:inline-flex;align-items:center;gap:8px;padding:0 40px;white-space:nowrap}
.ann-sep{opacity:.35;margin:0 8px}
@keyframes ticker{0%{transform:translateX(0)}100%{transform:translateX(-50%)}}

/* ── Nav ── */
.nav{background:#fff;border-bottom:1.5px solid var(--border);position:sticky;top:0;z-index:90;box-shadow:var(--sh0)}
.nav-in{max-width:1320px;margin:0 auto;padding:0 24px;display:flex;align-items:center;gap:12px;height:62px}
.logo{display:flex;align-items:center;gap:2px;cursor:pointer;text-decoration:none;margin-right:4px}
.logo-icon{width:32px;height:32px;background:var(--r);border-radius:7px;display:flex;align-items:center;justify-content:center;font-size:18px;color:#fff;font-weight:800;flex-shrink:0}
.logo-word{font-size:19px;font-weight:800;color:var(--t1);letter-spacing:-.4px}
.logo-word b{color:var(--r)}
.nav-links{display:flex;align-items:center;gap:2px;margin-left:6px}
.nl{background:none;border:none;font-family:var(--font);font-size:13.5px;font-weight:500;color:var(--t2);padding:6px 13px;border-radius:var(--r8);cursor:pointer;display:flex;align-items:center;gap:5px;transition:all .15s}
.nl:hover,.nl.on{color:var(--g1);background:var(--gl)}
.nl.on{font-weight:600}
.spacer{flex:1}
.nav-search{position:relative}
.nav-search input{background:var(--bg);border:1.5px solid var(--border);border-radius:var(--r8);padding:8px 14px 8px 36px;font-family:var(--font);font-size:13.5px;color:var(--t1);outline:none;width:240px;transition:all .15s}
.nav-search input:focus{border-color:var(--g2);background:#fff;width:280px}
.nav-search input::placeholder{color:var(--t3)}
.nav-si{position:absolute;left:11px;top:50%;transform:translateY(-50%);color:var(--t3);font-size:15px;pointer-events:none}
.nav-acts{display:flex;align-items:center;gap:6px}
.btn-sell{background:var(--r);color:#fff;border:none;border-radius:var(--r8);padding:8px 16px;font-family:var(--font);font-size:13.5px;font-weight:700;cursor:pointer;display:flex;align-items:center;gap:6px;transition:all .15s;white-space:nowrap}
.btn-sell:hover{background:#c8202f;transform:translateY(-1px);box-shadow:var(--sh1)}
.btn-login{background:none;border:1.5px solid var(--border2);border-radius:var(--r8);padding:7px 15px;font-family:var(--font);font-size:13.5px;font-weight:600;color:var(--t1);cursor:pointer;display:flex;align-items:center;gap:5px;transition:all .15s}
.btn-login:hover{border-color:var(--g2);color:var(--g1);background:var(--gl)}
.icon-btn{background:none;border:none;cursor:pointer;padding:7px;border-radius:var(--r8);color:var(--t2);font-size:20px;display:flex;align-items:center;position:relative;transition:all .15s}
.icon-btn:hover{background:var(--gl);color:var(--g1)}
.badge{position:absolute;top:1px;right:1px;background:var(--r);color:#fff;border-radius:var(--rpill);min-width:15px;height:15px;font-size:9px;font-weight:800;display:flex;align-items:center;justify-content:center;border:2px solid #fff}

/* ── Category pills ── */
.catbar{background:#fff;border-bottom:1.5px solid var(--border)}
.catbar-in{max-width:1320px;margin:0 auto;padding:0 24px;display:flex;gap:2px;overflow-x:auto}
.catbar-in::-webkit-scrollbar{display:none}
.cpill{background:none;border:none;border-bottom:2.5px solid transparent;font-family:var(--font);font-size:13.5px;font-weight:500;color:var(--t2);padding:12px 16px;cursor:pointer;display:flex;align-items:center;gap:7px;white-space:nowrap;transition:all .15s}
.cpill:hover{color:var(--g1)}
.cpill.on{color:var(--g1);border-bottom-color:var(--g1);font-weight:700}
.cpill-ico{font-size:17px}

/* ── Layout ── */


/* ── Hero ── */
.hero{
  border-radius:var(--r16);overflow:hidden;position:relative;min-height:380px;
  background:linear-gradient(120deg,#1a5e30 0%,#2a8c43 55%,#1e7038 100%);
  display:flex;align-items:center;
}
.hero::after{content:'';position:absolute;inset:0;background:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='400' height='400'%3E%3Ccircle cx='200' cy='200' r='180' fill='none' stroke='rgba(255,255,255,.04)' stroke-width='60'/%3E%3Ccircle cx='200' cy='200' r='100' fill='none' stroke='rgba(255,255,255,.04)' stroke-width='40'/%3E%3C/svg%3E") right -60px center/500px no-repeat;pointer-events:none}
.hero-food{position:absolute;right:0;top:0;bottom:0;width:52%;background:radial-gradient(ellipse at center,rgba(255,255,255,.07) 0%,transparent 70%);display:flex;align-items:center;justify-content:center;font-size:100px;opacity:.18;pointer-events:none;letter-spacing:-8px}
.hero-body{position:relative;z-index:1;padding:48px 52px;max-width:520px}
.hero-tag{display:inline-flex;align-items:center;gap:6px;background:rgba(255,255,255,.15);border:1px solid rgba(255,255,255,.25);border-radius:var(--rpill);padding:4px 14px;font-size:11.5px;font-weight:600;color:rgba(255,255,255,.9);margin-bottom:18px;letter-spacing:.03em}
.hero-h{font-family:var(--serif);font-size:clamp(30px,3.8vw,50px);color:#fff;line-height:1.12;margin-bottom:14px}
.hero-h em{color:var(--y);font-style:normal}
.hero-sub{font-size:14.5px;color:rgba(255,255,255,.8);margin-bottom:28px;line-height:1.65;max-width:400px}
.hero-hl{display:inline-flex;align-items:center;background:var(--y);color:var(--t1);border-radius:var(--r4);padding:2px 10px;font-weight:800;font-size:14px;margin:0 2px}
.hero-btns{display:flex;gap:12px;flex-wrap:wrap}
.hero-btn-w{background:#fff;color:var(--g1);border:none;border-radius:var(--r8);padding:11px 26px;font-family:var(--font);font-size:14px;font-weight:700;cursor:pointer;display:flex;align-items:center;gap:7px;transition:all .2s;box-shadow:0 4px 14px rgba(0,0,0,.15)}
.hero-btn-w:hover{transform:translateY(-2px);box-shadow:0 6px 20px rgba(0,0,0,.2)}
.hero-btn-o{background:transparent;color:#fff;border:2px solid rgba(255,255,255,.55);border-radius:var(--r8);padding:10px 24px;font-family:var(--font);font-size:14px;font-weight:600;cursor:pointer;display:flex;align-items:center;gap:7px;transition:all .2s}
.hero-btn-o:hover{background:rgba(255,255,255,.12);border-color:#fff}
.hero-dots{display:flex;gap:7px;margin-top:28px}
.hdot{width:8px;height:8px;border-radius:var(--rpill);background:rgba(255,255,255,.35);cursor:pointer;transition:all .2s}
.hdot.on{background:#fff;width:22px}

/* ── Section head ── */
.sec-head{display:flex;align-items:center;justify-content:space-between;margin-bottom:14px}
.sec-title{font-size:15px;font-weight:700;letter-spacing:-.2px;color:#111}
.sec-title span{color:var(--g1)}
.sec-link{background:none;border:none;font-family:var(--font);font-size:12.5px;font-weight:500;color:#888;cursor:pointer;display:flex;align-items:center;gap:4px;text-decoration:underline}
.sec-link:hover{text-decoration:underline}
.sec-arrows{display:flex;gap:6px}
.sarr{width:30px;height:30px;border-radius:var(--rpill);border:1.5px solid #ddd;background:#fff;cursor:pointer;display:flex;align-items:center;justify-content:center;font-size:16px;transition:all .15s;color:#555;box-shadow:var(--sh0)}
.sarr:hover{background:var(--g1);color:#fff;border-color:var(--g1)}

/* ── Product cards ── */
.carousel{display:flex;gap:12px;overflow-x:auto;scroll-snap-type:x mandatory;padding-bottom:6px}
.carousel::-webkit-scrollbar{display:none}
.pgrid{display:grid;grid-template-columns:repeat(auto-fill,minmax(200px,1fr));gap:14px}
.pgrid-compact{display:grid;grid-template-columns:repeat(auto-fill,minmax(160px,1fr));gap:10px}
.pcard{background:#fff;border-radius:var(--r12);border:1.5px solid var(--border);overflow:hidden;cursor:pointer;transition:all .18s;position:relative;flex-shrink:0;scroll-snap-align:start;min-width:185px;max-width:185px}
.pcard:hover{border-color:var(--g2);transform:translateY(-3px);box-shadow:var(--sh2)}
.pcard-img{position:relative;aspect-ratio:1;background:var(--bg);overflow:hidden}
.pcard-img img{width:100%;height:100%;object-fit:cover;transition:transform .3s}
.pcard:hover .pcard-img img{transform:scale(1.06)}
.pcard-placeholder{width:100%;height:100%;display:flex;align-items:center;justify-content:center;font-size:48px}
.pbadge{position:absolute;top:8px;left:8px;background:var(--g1);color:#fff;border-radius:var(--r4);padding:2px 7px;font-size:10px;font-weight:700;display:flex;align-items:center;gap:3px;white-space:nowrap}
.pbadge.red{background:var(--r)}
.pbadge.orange{background:#f37316}
.pbadge.purple{background:#7c3aed}
.pwish{position:absolute;top:8px;right:8px;width:28px;height:28px;background:#fff;border-radius:var(--r8);border:none;cursor:pointer;display:flex;align-items:center;justify-content:center;font-size:14px;box-shadow:var(--sh0);transition:all .15s}
.pwish:hover{background:var(--gl);transform:scale(1.1)}
.pcard-body{padding:10px 12px 12px}
.pname{font-size:13px;font-weight:600;margin-bottom:1px;line-height:1.3;color:#111}
.pvol{font-size:11px;color:#999;margin-bottom:8px}
.prow{display:flex;align-items:center;justify-content:space-between;gap:4px}
.pprice{display:flex;flex-direction:column}
.pcur{font-size:14px;font-weight:800;color:#111}
.pori{font-size:10.5px;color:#aaa;text-decoration:line-through}
.pdis{font-size:10.5px;font-weight:700;color:var(--r)}
.qty-box{display:flex;align-items:center;border:1.5px solid var(--border2);border-radius:var(--r8);overflow:hidden}
.qb{width:26px;height:26px;background:none;border:none;cursor:pointer;font-size:15px;color:var(--g1);font-weight:700;display:flex;align-items:center;justify-content:center;transition:background .1s}
.qb:hover{background:var(--gl)}
.qn{width:24px;text-align:center;font-size:12.5px;font-weight:700;border-left:1px solid var(--border);border-right:1px solid var(--border);height:26px;display:flex;align-items:center;justify-content:center}
.add-btn{width:28px;height:28px;background:var(--g1);border:none;border-radius:var(--r8);cursor:pointer;color:#fff;font-size:18px;display:flex;align-items:center;justify-content:center;transition:all .15s;flex-shrink:0}
.add-btn:hover{background:var(--gd);transform:scale(1.08)}
.add-btn-full{width:100%;background:#e8293a;color:#fff;border:none;border-radius:6px;padding:8px 0;font-family:var(--font);font-size:12.5px;font-weight:700;cursor:pointer;display:flex;align-items:center;justify-content:center;gap:5px;margin-top:10px;transition:all .15s}
.add-btn-full:hover{background:#c8202f;transform:translateY(-1px)}
.gsave{font-size:10.5px;color:#1c6b39;margin-top:6px;font-weight:500;line-height:1.3}



/* ── Shared utilities ── */
.btn{display:inline-flex;align-items:center;justify-content:center;gap:6px;border:none;border-radius:var(--r8);font-family:var(--font);font-size:13.5px;font-weight:600;cursor:pointer;transition:all .15s;padding:9px 18px}
.btn-p{background:var(--g1);color:#fff}
.btn-p:hover{background:var(--gd);transform:translateY(-1px);box-shadow:var(--sh1)}
.btn-s{background:#fff;color:var(--t1);border:1.5px solid var(--border2)}
.btn-s:hover{border-color:var(--g1);color:var(--g1);background:var(--gl)}
.btn-g{background:none;color:var(--t2)}
.btn-g:hover{background:var(--gl);color:var(--g1)}
.btn-r{background:var(--r);color:#fff}
.btn-r:hover{background:#c8202f}
.btn-sm{padding:5px 12px;font-size:12.5px;border-radius:var(--r8)}
.btn:disabled{opacity:.5;cursor:not-allowed;transform:none!important}
.tag{display:inline-flex;align-items:center;gap:3px;padding:3px 9px;border-radius:var(--rpill);font-size:11.5px;font-weight:600}
.tg{background:var(--gl);color:var(--g1)}
.tr{background:#fdf0f1;color:var(--r)}
.to{background:#fff4e5;color:#c85a00}
.ty{background:#fffde5;color:#927200}
.tabs{display:flex;gap:2px;background:var(--bg);border-radius:var(--r8);padding:3px;width:fit-content;margin-bottom:20px}
.tab{padding:6px 16px;border-radius:6px;border:none;background:none;font-family:var(--font);font-size:13.5px;font-weight:500;cursor:pointer;color:var(--t2);transition:all .15s}
.tab.on{background:#fff;color:var(--t1);font-weight:700;box-shadow:var(--sh0)}
.field{display:flex;flex-direction:column;gap:5px;margin-bottom:14px}
.lbl{font-size:12.5px;font-weight:600;color:var(--t2)}
.inp{background:var(--bg);border:1.5px solid var(--border);border-radius:var(--r8);color:var(--t1);font-family:var(--font);font-size:13.5px;padding:10px 13px;outline:none;transition:border-color .15s;width:100%}
.inp:focus{border-color:var(--g2);background:#fff}
.inp::placeholder{color:var(--t3)}
select.inp{cursor:pointer}
textarea.inp{resize:vertical;min-height:72px}
.row{display:flex;align-items:center;gap:8px}
.grow{flex:1}
.two-col{display:grid;grid-template-columns:1fr 1fr;gap:12px}
.err{background:#fdf0f1;border:1px solid #f7c0c3;color:var(--r);border-radius:var(--r8);padding:9px 13px;font-size:12.5px;margin-bottom:12px}
.ok{background:var(--gl);border:1px solid var(--border2);color:var(--g1);border-radius:var(--r8);padding:9px 13px;font-size:12.5px;margin-bottom:12px}
.empty{text-align:center;padding:52px 20px;color:var(--t3)}
.ei{font-size:46px;margin-bottom:12px}
.et{font-size:14.5px;color:var(--t2);font-weight:500}
.loading{text-align:center;padding:40px}
.spin{display:inline-block;width:20px;height:20px;border:2.5px solid var(--border);border-top-color:var(--g1);border-radius:50%;animation:spin .7s linear infinite}
@keyframes spin{to{transform:rotate(360deg)}}
.mt12{margin-top:12px}
.mb0{margin-bottom:0!important}
.fs12{font-size:12px}
.fw7{font-weight:700}

/* ── Modal ── */
.overlay{position:fixed;inset:0;background:rgba(0,0,0,.48);backdrop-filter:blur(5px);z-index:200;display:flex;align-items:center;justify-content:center;padding:16px;animation:fi .15s}
.modal{background:#fff;border-radius:var(--r24);width:100%;max-width:480px;max-height:92vh;overflow-y:auto;box-shadow:0 20px 60px rgba(0,0,0,.2);animation:su .2s}
.mh{padding:22px 22px 0;display:flex;align-items:flex-start;justify-content:space-between}
.mt{font-size:18px;font-weight:800;letter-spacing:-.3px}
.mb{padding:18px 22px 22px}
@keyframes fi{from{opacity:0}to{opacity:1}}
@keyframes su{from{transform:translateY(14px);opacity:0}to{transform:none;opacity:1}}

/* ── Cart sidebar ── */
.cart-over{position:fixed;inset:0;background:rgba(0,0,0,.32);z-index:130}
.cart-side{position:fixed;right:0;top:0;bottom:0;width:390px;background:#fff;z-index:140;display:flex;flex-direction:column;box-shadow:-6px 0 30px rgba(0,0,0,.1);transform:translateX(100%);transition:transform .28s cubic-bezier(.4,0,.2,1)}
.cart-side.open{transform:translateX(0)}
.c-head{padding:18px 20px;border-bottom:1.5px solid var(--border);display:flex;align-items:center;justify-content:space-between}
.c-title{font-size:17px;font-weight:800}
.c-items{flex:1;overflow-y:auto;padding:14px 20px;display:flex;flex-direction:column;gap:12px}
.ci{display:flex;gap:12px;padding:12px;background:var(--bg);border-radius:var(--r12);border:1px solid var(--border)}
.ci-img{width:56px;height:56px;border-radius:var(--r8);background:#fff;overflow:hidden;flex-shrink:0;display:flex;align-items:center;justify-content:center;font-size:22px;border:1px solid var(--border)}
.ci-img img{width:100%;height:100%;object-fit:cover}
.ci-info{flex:1;min-width:0}
.ci-name{font-size:12.5px;font-weight:600;margin-bottom:2px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
.ci-vol{font-size:11px;color:var(--t3);margin-bottom:7px}
.ci-bottom{display:flex;align-items:center;justify-content:space-between}
.ci-price{font-size:14px;font-weight:800;color:var(--g1)}
.ci-rm{background:none;border:none;cursor:pointer;color:var(--t3);font-size:15px;transition:color .1s}
.ci-rm:hover{color:var(--r)}
.c-foot{padding:16px 20px;border-top:1.5px solid var(--border)}
.c-hint{font-size:11.5px;color:var(--g1);background:var(--gl);border-radius:var(--r8);padding:7px 11px;margin-bottom:12px}
.c-tot{display:flex;justify-content:space-between;align-items:center;margin-bottom:12px}
.c-tot-l{color:var(--t2);font-size:13.5px}
.c-tot-v{font-size:21px;font-weight:800}

/* ── Stats ── */
.stat-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(155px,1fr));gap:12px;margin-bottom:22px}
.stat-c{background:#fff;border:1.5px solid var(--border);border-radius:var(--r12);padding:16px}
.stat-l{font-size:11px;color:var(--t3);text-transform:uppercase;letter-spacing:.07em;font-weight:700;margin-bottom:7px}
.stat-v{font-size:24px;font-weight:800;line-height:1}
.stat-v.g{color:var(--g1)}

/* ── Table ── */
.tw{overflow-x:auto;border-radius:var(--r12);border:1.5px solid var(--border);background:#fff}
table{width:100%;border-collapse:collapse;font-size:13.5px}
thead{background:var(--bg)}
th{padding:11px 14px;text-align:left;font-size:11.5px;font-weight:700;color:var(--t3);text-transform:uppercase;letter-spacing:.06em;white-space:nowrap}
td{padding:13px 14px;border-top:1px solid var(--border);color:var(--t2)}
tr:hover td{background:var(--bg)}

/* ── Toast ── */
.toasts{position:fixed;bottom:22px;right:22px;z-index:300;display:flex;flex-direction:column;gap:9px}
.toast{display:flex;align-items:center;gap:9px;padding:11px 16px;border-radius:var(--r12);font-size:13.5px;font-weight:500;min-width:250px;animation:su .18s;box-shadow:var(--sh2);border:1px solid}
.toast-ok{background:#f0faf3;border-color:var(--border2);color:var(--g1)}
.toast-err{background:#fdf5f5;border-color:#f7c0c3;color:var(--r)}
.toast-i{background:#fff;border-color:var(--border);color:var(--t1)}

/* ── Responsive ── */
@media(max-width:768px){
  .hero-body{padding:32px 24px}
  .two-col{grid-template-columns:1fr}
  .cart-side{width:100%}
  .nav-search{display:none}
}
`;

/* ═══════════════════════════════════════════════════════════
   TOAST SYSTEM
═══════════════════════════════════════════════════════════ */
let _toast = () => { };
const toast = {
  ok: m => _toast(m, "ok"),
  err: m => _toast(m, "err"),
  i: m => _toast(m, "i"),
};
function Toasts() {
  const [list, setList] = useState([]);
  _toast = (msg, type) => {
    const id = Date.now();
    setList(l => [...l, { id, msg, type }]);
    setTimeout(() => setList(l => l.filter(x => x.id !== id)), 3500);
  };
  return (
    <div className="toasts">
      {list.map(t => (
        <div key={t.id} className={`toast toast-${t.type}`}>
          <span>{t.type === "ok" ? "✓" : t.type === "err" ? "✕" : "ℹ"}</span>{t.msg}
        </div>
      ))}
    </div>
  );
}

/* ═══════════════════════════════════════════════════════════
   MODAL
═══════════════════════════════════════════════════════════ */
function Modal({ title, onClose, children, width }) {
  useEffect(() => {
    const h = e => e.key === "Escape" && onClose();
    window.addEventListener("keydown", h);
    return () => window.removeEventListener("keydown", h);
  }, [onClose]);
  return (
    <div className="overlay" onClick={e => e.target === e.currentTarget && onClose()}>
      <div className="modal" style={width ? { maxWidth: width } : {}}>
        <div className="mh">
          <span className="mt">{title}</span>
          <button className="btn btn-g btn-sm" onClick={onClose} style={{ fontSize: 17, padding: "3px 7px" }}>✕</button>
        </div>
        <div className="mb">{children}</div>
      </div>
    </div>
  );
}

/* ═══════════════════════════════════════════════════════════
   AUTH MODAL
═══════════════════════════════════════════════════════════ */
function AuthModal({ onClose, onSuccess }) {
  const [step, setStep] = useState("phone");
  const [phone, setPhone] = useState(""); const [otp, setOtp] = useState("");
  const [loading, setLoading] = useState(false); const [err, setErr] = useState("");

  const send = async () => {
    if (!phone.trim()) { setErr("Enter your phone number"); return; }
    setLoading(true); setErr("");
    try { await post("/api/auth/phone/send-code", { phoneNumber: phone }); toast.ok("OTP sent!"); setStep("otp"); }
    catch (e) { setErr(e.message); } finally { setLoading(false); }
  };
  const verify = async () => {
    if (!otp.trim()) { setErr("Enter the OTP code"); return; }
    setLoading(true); setErr("");
    try { const d = await post("/api/auth/phone/verify-code", { phoneNumber: phone, code: otp }); toast.ok("Welcome to OneAnt! 🎉"); onSuccess(d); }
    catch (e) { setErr(e.message); } finally { setLoading(false); }
  };
  return (
    <Modal title="Sign In" onClose={onClose}>
      <p style={{ fontSize: 13, color: "var(--t2)", marginBottom: 18 }}>Enter your phone to receive a one-time code.</p>
      {err && <div className="err">{err}</div>}
      {step === "phone" ? (
        <>
          <div className="field"><label className="lbl">Phone Number</label>
            <input className="inp" placeholder="+1 604 555 0100" value={phone} onChange={e => setPhone(e.target.value)} onKeyDown={e => e.key === "Enter" && send()} />
          </div>
          <button className="btn btn-p" style={{ width: "100%", padding: "11px" }} onClick={send} disabled={loading}>
            {loading ? <span className="spin" /> : "Send Code →"}
          </button>
        </>
      ) : (
        <>
          <p style={{ fontSize: 12.5, color: "var(--t2)", marginBottom: 14 }}>
            Code sent to <b>{phone}</b>. <button className="btn btn-g btn-sm" onClick={() => setStep("phone")}>Change</button>
          </p>
          <div className="field"><label className="lbl">Verification Code</label>
            <input className="inp" placeholder="6-digit code" value={otp} onChange={e => setOtp(e.target.value)} onKeyDown={e => e.key === "Enter" && verify()} />
          </div>
          <button className="btn btn-p" style={{ width: "100%", padding: "11px" }} onClick={verify} disabled={loading}>
            {loading ? <span className="spin" /> : "Verify & Continue →"}
          </button>
        </>
      )}
    </Modal>
  );
}

/* ═══════════════════════════════════════════════════════════
   PRODUCT CARD  (main grid / carousel)
═══════════════════════════════════════════════════════════ */
function PCard({ p, onView, onAdd, cartQty, onQty }) {
  const disc = p.originalPrice && p.discountPrice
    ? Math.round((1 - parseFloat(p.discountPrice) / parseFloat(p.originalPrice)) * 100) : 0;
  const price = parseFloat(p.discountPrice || p.originalPrice || 0);
  const saving = parseFloat(p.originalPrice || 0) - price;
  // Rotate badge types to match Figma variety
  const badgeTypes = ["NEXT DAY DELIVERY", "NEXT DAY DELIVERY", "LIMITED TIME DEAL", "NEXT DAY DELIVERY"];
  const badgeColors = ["var(--g1)", "var(--g1)", "#f37316", "var(--g1)"];
  const badgeIdx = p.id % 4;
  const badgeLabel = disc > 0 ? `${disc}% OFF` : badgeTypes[badgeIdx];
  const badgeColor = disc > 0 ? "var(--r)" : badgeColors[badgeIdx];

  return (
    <div className="pcard" onClick={() => onView(p)}>
      <div className="pcard-img">
        <div className="pbadge" style={{ background: badgeColor }}>
          {badgeLabel === "NEXT DAY DELIVERY" ? "⚡ " : badgeLabel === "LIMITED TIME DEAL" ? "⏰ " : ""}{badgeLabel}
        </div>
        <button className="pwish" onClick={e => e.stopPropagation()}>&#x2661;</button>
        {p.imageUrl
          ? <img src={p.imageUrl} alt={p.name} onError={e => { e.target.style.display = "none" }} />
          : <div className="pcard-placeholder">&#x1F6CD;&#xFE0F;</div>}
      </div>
      <div className="pcard-body">
        <div className="pname">{p.name}</div>
        <div className="pvol">{p.subcategory?.name || p.category?.name || "General"}</div>
        <div className="prow">
          <div className="pprice">
            <span className="pcur">${price.toFixed(2)}</span>
            {disc > 0 && <><span className="pori">${parseFloat(p.originalPrice).toFixed(2)}</span> <span className="pdis">{disc}% off</span></>}
          </div>
          {cartQty > 0
            ? <div className="qty-box" onClick={e => e.stopPropagation()}>
              <button className="qb" onClick={() => onQty(p, cartQty - 1)}>&#8722;</button>
              <span className="qn">{cartQty}</span>
              <button className="qb" onClick={() => onQty(p, cartQty + 1)}>&#43;</button>
            </div>
            : <button className="add-btn" onClick={e => { e.stopPropagation(); onAdd(p) }}>&#43;</button>}
        </div>
        <button className="add-btn-full" onClick={e => { e.stopPropagation(); onAdd(p) }}>
          Add to Cart
        </button>
        {saving > 0.01 && <div className="gsave">Save up to ${saving.toFixed(2)} with group*</div>}
      </div>
    </div>
  );
}

/* ═══════════════════════════════════════════════════════════
   PRODUCT DETAIL MODAL
═══════════════════════════════════════════════════════════ */
function PDetail({ p, onClose, onAdd }) {
  const [tiers, setTiers] = useState([]);
  useEffect(() => { get(`/api/products/${p.id}/discount-tiers`).then(setTiers).catch(() => { }); }, [p.id]);
  const disc = p.originalPrice && p.discountPrice ? Math.round((1 - parseFloat(p.discountPrice) / parseFloat(p.originalPrice)) * 100) : 0;
  const price = parseFloat(p.discountPrice || p.originalPrice || 0);
  return (
    <Modal title="" onClose={onClose} width="540px">
      <div style={{ margin: "-18px -22px 16px", position: "relative" }}>
        {p.imageUrl
          ? <img src={p.imageUrl} alt={p.name} style={{ width: "100%", height: 210, objectFit: "cover", borderRadius: "20px 20px 0 0" }} />
          : <div style={{ height: 180, background: "var(--bg)", display: "flex", alignItems: "center", justifyContent: "center", fontSize: 60, borderRadius: "20px 20px 0 0" }}>🛍️</div>}
        {disc > 0 && <div className="pbadge red" style={{ position: "absolute", top: 12, left: 14, fontSize: 12, padding: "4px 10px" }}>{disc}% OFF</div>}
      </div>
      <div className="row" style={{ flexWrap: "wrap", gap: 5, marginBottom: 10 }}>
        {p.category?.name && <span className="tag tg">{p.category.name}</span>}
        {p.subcategory?.name && <span className="tag" style={{ background: "var(--bg)", color: "var(--t2)" }}>{p.subcategory.name}</span>}
      </div>
      <h2 style={{ fontSize: 21, fontWeight: 800, marginBottom: 8, letterSpacing: "-.4px" }}>{p.name}</h2>
      {p.description && <p style={{ fontSize: 13, color: "var(--t2)", marginBottom: 14, lineHeight: 1.65 }}>{p.description}</p>}
      <div style={{ display: "flex", gap: 20, marginBottom: 18, flexWrap: "wrap" }}>
        <div><div className="fs12" style={{ color: "var(--t3)", marginBottom: 2 }}>Price</div><div style={{ fontSize: 25, fontWeight: 800, color: "var(--r)" }}>${price.toFixed(2)}</div>{disc > 0 && <div style={{ fontSize: 11.5, color: "var(--t3)", textDecoration: "line-through" }}>${parseFloat(p.originalPrice).toFixed(2)}</div>}</div>
        {p.minimumParticipants && <div><div className="fs12" style={{ color: "var(--t3)", marginBottom: 2 }}>Group Size</div><div style={{ fontSize: 16, fontWeight: 700 }}>{p.minimumParticipants}–{p.maximumParticipants || "∞"}</div></div>}
        {p.offerValidTill && <div><div className="fs12" style={{ color: "var(--t3)", marginBottom: 2 }}>Valid Until</div><div style={{ fontSize: 13, fontWeight: 600 }}>{new Date(p.offerValidTill).toLocaleDateString()}</div></div>}
      </div>
      {tiers.length > 0 && <div style={{ marginBottom: 16 }}>
        <div className="lbl" style={{ marginBottom: 8 }}>💰 Group Discount Tiers</div>
        {tiers.map((t, i) => <div key={i} style={{ display: "flex", justifyContent: "space-between", padding: "9px 13px", background: "var(--gl)", borderRadius: "var(--r8)", border: "1px solid var(--border2)", marginBottom: 6 }}>
          <span style={{ fontSize: 12.5, fontWeight: 700 }}>👥 {t.participantCount}+ people</span>
          <span className="tag tg">{t.discountPercentage}% → ${parseFloat(t.finalPrice).toFixed(2)}</span>
        </div>)}
      </div>}
      <button className="btn btn-r" style={{ width: "100%", padding: "13px", fontSize: 14 }} onClick={() => { onAdd(p); onClose() }}>🛒 Add to Cart</button>
    </Modal>
  );
}


function CartSide({ open, onClose, user, cartItems, setCartItems }) {
  const [loading, setLoading] = useState(false);

  const fetchCart = useCallback(async () => {
    if (!user) return;
    setLoading(true);
    try { const d = await get("/api/cart"); setCartItems(d || []); }
    catch (e) { toast.err(e.message); } finally { setLoading(false); }
  }, [user, setCartItems]);

  useEffect(() => { if (open && user) fetchCart(); }, [open, user, fetchCart]);

  const rm = async id => {
    try { await del(`/api/cart/${id}`); setCartItems(c => c.filter(x => x.id !== id)); }
    catch (e) { toast.err(e.message); }
  };
  const upd = async (id, qty) => {
    if (qty < 1) { rm(id); return; }
    try { await patch(`/api/cart/${id}`, { quantity: qty }); setCartItems(c => c.map(x => x.id === id ? { ...x, quantity: qty } : x)); }
    catch (e) { toast.err(e.message); }
  };
  const clear = async () => {
    try { await del("/api/cart"); setCartItems([]); }
    catch (e) { toast.err(e.message); }
  };

  const total = cartItems.reduce((s, i) => s + parseFloat(i.product?.discountPrice || i.product?.originalPrice || 0) * (i.quantity || 1), 0);

  return (
    <>
      {open && <div className="cart-over" onClick={onClose} />}
      <div className={`cart-side ${open ? "open" : ""}`}>
        <div className="c-head">
          <span className="c-title">🛒 Cart</span>
          <div className="row" style={{ gap: 7 }}>
            <span className="tag tg">{cartItems.length} item{cartItems.length !== 1 ? "s" : ""}</span>
            {cartItems.length > 0 && <button className="btn btn-g btn-sm" onClick={clear} style={{ color: "var(--r)" }}>Clear</button>}
            <button className="btn btn-g btn-sm" onClick={onClose} style={{ fontSize: 16 }}>✕</button>
          </div>
        </div>
        {!user
          ? <div className="empty"><div className="ei">🛒</div><div className="et">Sign in to view cart</div></div>
          : loading ? <div className="loading"><span className="spin" /></div>
            : cartItems.length === 0 ? <div className="empty"><div className="ei">🛒</div><div className="et">Cart is empty</div></div>
              : <div className="c-items">{cartItems.map(item => (
                <div key={item.id} className="ci">
                  <div className="ci-img">{item.product?.imageUrl ? <img src={item.product.imageUrl} alt="" /> : "🛍️"}</div>
                  <div className="ci-info">
                    <div className="ci-name">{item.product?.name}</div>
                    <div className="ci-vol">{item.product?.category?.name || ""}</div>
                    <div className="ci-bottom">
                      <div className="qty-box">
                        <button className="qb" onClick={() => upd(item.id, (item.quantity || 1) - 1)}>−</button>
                        <span className="qn">{item.quantity || 1}</span>
                        <button className="qb" onClick={() => upd(item.id, (item.quantity || 1) + 1)}>+</button>
                      </div>
                      <div className="row" style={{ gap: 7 }}>
                        <span className="ci-price">${(parseFloat(item.product?.discountPrice || item.product?.originalPrice || 0) * (item.quantity || 1)).toFixed(2)}</span>
                        <button className="ci-rm" onClick={() => rm(item.id)}>✕</button>
                      </div>
                    </div>
                  </div>
                </div>
              ))}</div>}
        {cartItems.length > 0 && (
          <div className="c-foot">
            <div className="c-hint">🧑‍🤝‍🧑 Create a group to unlock bigger group savings!</div>
            <div className="c-tot"><span className="c-tot-l">Subtotal</span><span className="c-tot-v">${total.toFixed(2)}</span></div>
            <GroupFromCartBtn onDone={() => { fetchCart(); onClose() }} />
            <button className="btn btn-s" style={{ width: "100%", marginTop: 7 }} onClick={onClose}>Continue Shopping</button>
          </div>
        )}
      </div>
    </>
  );
}

function GroupFromCartBtn({ onDone }) {
  const [show, setShow] = useState(false); const [name, setName] = useState(""); const [loading, setLoading] = useState(false);
  const go = async () => {
    if (!name.trim()) { toast.err("Enter a group name"); return; }
    setLoading(true);
    try { await post("/api/user-groups/from-cart", { name }); toast.ok("Group created!"); setShow(false); onDone(); }
    catch (e) { toast.err(e.message); } finally { setLoading(false); }
  };
  return (
    <>
      <button className="btn btn-p" style={{ width: "100%", marginBottom: 7 }} onClick={() => setShow(true)}>🧑‍🤝‍🧑 Create Group from Cart</button>
      {show && <Modal title="Name Your Group" onClose={() => setShow(false)}>
        <div className="field"><label className="lbl">Group Name</label><input className="inp" placeholder="e.g. Office Grocery Run" value={name} onChange={e => setName(e.target.value)} onKeyDown={e => e.key === "Enter" && go()} /></div>
        <button className="btn btn-p" style={{ width: "100%" }} onClick={go} disabled={loading}>{loading ? <span className="spin" /> : "Create"}</button>
      </Modal>}
    </>
  );
}

/* ═══════════════════════════════════════════════════════════
   SLIDING DRAWER
═══════════════════════════════════════════════════════════ */
function Drawer({ open, onClose, title, emoji, children }) {
  useEffect(() => {
    document.body.style.overflow = open ? "hidden" : "";
    return () => { document.body.style.overflow = ""; };
  }, [open]);
  return (
    <>
      <div onClick={onClose} style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,.45)", zIndex: 160, opacity: open ? 1 : 0, pointerEvents: open ? "all" : "none", transition: "opacity .28s", backdropFilter: open ? "blur(3px)" : "none" }} />
      <div style={{ position: "fixed", bottom: 0, left: 0, right: 0, background: "#fff", zIndex: 170, borderRadius: "20px 20px 0 0", boxShadow: "0 -8px 40px rgba(0,0,0,.18)", transform: open ? "translateY(0)" : "translateY(100%)", transition: "transform .32s cubic-bezier(.4,0,.2,1)", maxHeight: "82vh", display: "flex", flexDirection: "column" }}>
        <div style={{ padding: "12px 0 4px", display: "flex", justifyContent: "center", cursor: "pointer" }} onClick={onClose}>
          <div style={{ width: 40, height: 4, borderRadius: 2, background: "var(--border2)" }} />
        </div>
        <div style={{ padding: "0 24px 14px", display: "flex", alignItems: "center", justifyContent: "space-between", borderBottom: "1px solid var(--border)", flexShrink: 0 }}>
          <div style={{ fontSize: 18, fontWeight: 800, letterSpacing: "-.3px" }}>{emoji} <span style={{ color: "var(--g1)" }}>{title}</span></div>
          <button onClick={onClose} style={{ background: "none", border: "none", cursor: "pointer", fontSize: 20, color: "var(--t3)", padding: "4px 8px", borderRadius: 8, lineHeight: 1 }}>&#10005;</button>
        </div>
        <div style={{ overflowY: "auto", padding: "20px 24px 32px", flex: 1 }}>
          {children}
        </div>
      </div>
    </>
  );
}

/* ═══════════════════════════════════════════════════════════
   CAROUSEL SECTION (with sliding drawer)
═══════════════════════════════════════════════════════════ */
function CarouselSection({ title, emoji, products, onView, onAdd, getQty, onQty }) {
  const ref = useRef(null);
  const [drawerOpen, setDrawerOpen] = useState(false);
  const scroll = dir => ref.current?.scrollBy({ left: dir * 240, behavior: "smooth" });
  if (!products.length) return null;
  return (
    <div style={{ padding: "0 24px", marginBottom: 28 }}>
      <div className="sec-head">
        <div className="sec-title">{emoji && <span style={{ marginRight: 4 }}>{emoji}</span>}<span style={{ color: "#111", fontWeight: 700 }}>{title}</span></div>
        <div className="row" style={{ gap: 6 }}>
          <button className="sec-link" onClick={() => setDrawerOpen(true)}>Show all</button>
          <div className="sec-arrows">
            <button className="sarr" onClick={() => scroll(-1)}>&lsaquo;</button>
            <button className="sarr" onClick={() => scroll(1)}>&rsaquo;</button>
          </div>
        </div>
      </div>
      <div className="carousel" ref={ref}>
        {products.map(p => (
          <PCard key={p.id} p={p} onView={onView} onAdd={onAdd} cartQty={getQty(p.id)} onQty={onQty} />
        ))}
      </div>
      <Drawer open={drawerOpen} onClose={() => setDrawerOpen(false)} title={title} emoji={emoji}>
        <p style={{ fontSize: 12.5, color: "var(--t3)", marginBottom: 16 }}>{products.length} products</p>
        <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fill,minmax(200px,1fr))", gap: 16 }}>
          {products.map(p => (
            <PCard key={p.id} p={p} onView={(p2) => { onView(p2); setDrawerOpen(false); }} onAdd={onAdd} cartQty={getQty(p.id)} onQty={onQty} />
          ))}
        </div>
      </Drawer>
    </div>
  );
}

/* ═══════════════════════════════════════════════════════════
   FAQ ACCORDION
═══════════════════════════════════════════════════════════ */
const FAQ_DATA = [
  { q: "What does the story of OneAnt entail?", a: "Every ant has a shared purpose, each contributing to a single bit of their hive's success. Thriving in a natural market, OneAnt was conceived as a platform to bring small-scale businesses and individual sellers to a more widespread marketplace. We are the numerous ants of OneAnt, real businesses flourish with unique offerings, and shoppers embrace a joyful experience of discovery, recommendations, and shared savings." },
  { q: "What is the OneAnt vision?", a: "To become the go-to group buying marketplace that empowers communities to save together while supporting local sellers and businesses." },
  { q: "What is the OneAnt mission?", a: "To make everyday shopping more affordable and social by connecting buyers and sellers in a community-driven group buying experience." },
  { q: "How does OneAnt work?", a: "Browse products, add items to your cart, join or create a buying group, and check out together. The more people in your group, the bigger the discount everyone gets!" },
];

function FAQ() {
  const [open, setOpen] = useState(null);
  return (
    <div style={{ background: "#fff", padding: "64px 24px", borderTop: "1px solid var(--border)" }}>
      <div style={{ maxWidth: 720, margin: "0 auto" }}>
        <h2 style={{ fontSize: 26, fontWeight: 800, textAlign: "center", marginBottom: 8, letterSpacing: "-.5px" }}>Frequently asked questions</h2>
        <p style={{ textAlign: "center", color: "var(--t2)", fontSize: 13.5, marginBottom: 36 }}>Find the answers to all your questions below. If you still have doubts or questions, please reach out to help@oneant.com</p>
        {FAQ_DATA.map((item, i) => (
          <div key={i} style={{ borderBottom: "1px solid var(--border)", marginBottom: 2 }}>
            <button onClick={() => setOpen(open === i ? null : i)} style={{ width: "100%", background: "none", border: "none", padding: "17px 0", display: "flex", alignItems: "center", justifyContent: "space-between", cursor: "pointer", gap: 12, textAlign: "left", fontFamily: "var(--font)", fontSize: 14, fontWeight: 600, color: "var(--t1)" }}>
              <span>{item.q}</span>
              <span style={{ fontSize: 18, color: "var(--t3)", flexShrink: 0, transition: "transform .2s", transform: open === i ? "rotate(45deg)" : "none" }}>+</span>
            </button>
            {open === i && <p style={{ fontSize: 13.5, color: "var(--t2)", lineHeight: 1.7, paddingBottom: 18, paddingRight: 32 }}>{item.a}</p>}
          </div>
        ))}
      </div>
    </div>
  );
}

/* ═══════════════════════════════════════════════════════════
   FOOTER
═══════════════════════════════════════════════════════════ */
function Footer() {
  return (
    <footer style={{ background: "#0d1a10", color: "rgba(255,255,255,.7)", padding: "16px 32px", display: "flex", alignItems: "center", justifyContent: "space-between", flexWrap: "wrap", gap: 10, fontSize: 12.5 }}>
      <div style={{ display: "flex", alignItems: "center", gap: 8 }}>
        {/* <div style={{width:26,height:26,background:"var(--r)",borderRadius:6,display:"flex",alignItems:"center",justifyContent:"center",fontSize:14}}>🐜</div>
        <span style={{fontWeight:700,color:"#fff",fontSize:14}}><b style={{color:"#fff"}}>1</b>ant</span> */}
        <div style={{ width: 30, height: 30, borderRadius: "50%", background: "#f03", display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0 }}>
          <span style={{ color: "#fff", fontWeight: 900, fontSize: 15, fontFamily: "var(--font)" }}>1</span>
        </div>
        <span style={{ fontWeight: 800, fontSize: 18, color: "#fff", letterSpacing: "-.3px" }}>ant</span>
        <span>© 2025 All Rights Reserved</span>
      </div>
      <div style={{ display: "flex", gap: 20, flexWrap: "wrap" }}>
        {["About Us", "Terms", "Privacy Policy"].map(l => (
          <a key={l} href="#" style={{ color: "rgba(255,255,255,.6)", textDecoration: "none", transition: "color .15s" }} onMouseEnter={e => e.target.style.color = "#fff"} onMouseLeave={e => e.target.style.color = "rgba(255,255,255,.6)"}>{l}</a>
        ))}
      </div>
      <div style={{ display: "flex", gap: 12 }}>
        {["in", "f", "tw", "yt"].map(s => (
          <div key={s} style={{ width: 28, height: 28, background: "rgba(255,255,255,.1)", borderRadius: 6, display: "flex", alignItems: "center", justifyContent: "center", cursor: "pointer", fontSize: 12, color: "rgba(255,255,255,.7)", transition: "background .15s" }}
            onMouseEnter={e => e.currentTarget.style.background = "rgba(255,255,255,.2)"}
            onMouseLeave={e => e.currentTarget.style.background = "rgba(255,255,255,.1)"}>
            {s === "in" ? "🔗" : s === "f" ? "📘" : s === "tw" ? "🐦" : "▶"}
          </div>
        ))}
      </div>
    </footer>
  );
}

/* ═══════════════════════════════════════════════════════════
   HOME PAGE
═══════════════════════════════════════════════════════════ */
function HomePage({ user, cartItems, setCartItems, onLogin }) {
  const [products, setProducts] = useState([]);
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [selCat, setSelCat] = useState(null);
  const [search, setSearch] = useState("");
  const [viewP, setViewP] = useState(null);
  const [heroDot, setHeroDot] = useState(0);

  useEffect(() => {
    Promise.all([get("/api/products"), get("/api/categories")])
      .then(([p, c]) => { setProducts(p || []); setCategories(c || []); })
      .catch(e => toast.err(e.message))
      .finally(() => setLoading(false));
  }, []);

  useEffect(() => {
    const t = setInterval(() => setHeroDot(d => (d + 1) % 3), 4000);
    return () => clearInterval(t);
  }, []);

  const addCart = product => {
    if (!user) { toast.i("Sign in to add to cart"); onLogin(); return; }
    post("/api/cart", { productId: product.id })
      .then(() => { toast.ok("Added to cart!"); get("/api/cart").then(d => setCartItems(d || [])).catch(() => { }); })
      .catch(e => toast.err(e.message));
  };

  const getQty = id => cartItems.find(i => i.productId === id || i.product?.id === id)?.quantity || 0;
  const updateQty = async (product, qty) => {
    const item = cartItems.find(i => i.productId === product.id || i.product?.id === product.id);
    if (!item) { if (qty > 0) addCart(product); return; }
    if (qty < 1) { await del(`/api/cart/${item.id}`); setCartItems(c => c.filter(x => x.id !== item.id)); return; }
    await patch(`/api/cart/${item.id}`, { quantity: qty });
    setCartItems(c => c.map(x => x.id === item.id ? { ...x, quantity: qty } : x));
  };

  const filtered = products.filter(p =>
    (!search || p.name?.toLowerCase().includes(search.toLowerCase())) &&
    (!selCat || p.categoryId === selCat)
  );
  const deals = products.filter(p => p.discountPrice && parseFloat(p.discountPrice) < parseFloat(p.originalPrice || 0));
  const ICONS = { Groceries: "🥦", Food: "🍕", Beverages: "🥤", Dairy: "🥛", Meat: "🥩", Bakery: "🍞", Snacks: "🍿", Household: "🏠", Beauty: "💄", Pets: "🐾" };

  const WHY = [
    { icon: "🛡️", title: "No Chain Stores & Only Direct Brands", sub: "Shop directly from makers" },
    { icon: "✅", title: "On-Demand & Fresh Products", sub: "Delivered same-day" },
    { icon: "0️⃣", title: "Pesticide Free & Zero Additives", sub: "100% natural produce" },
    { icon: "🎯", title: "Handpicked Assortment", sub: "Curated for quality" },
    { icon: "🚚", title: "Reliable Delivery & Time Promise", sub: "Never miss your window" },
  ];
  const HOW = [
    { n: "01", title: "Browse & Select", desc: "Set up a product from our wide range of items and add them to your cart." },
    { n: "02", title: "Share & Invite friends", desc: "Share exciting group offers or start your own in under 3 minutes." },
    { n: "03", title: "Pay & Receive", desc: "Pay for your products and get them delivered at your doorstep." },
  ];
  const REVIEWS = [
    { stars: 5, text: "Fantastic service! The food is always fresh, and I love that they offer free delivery over a certain amount.", name: "Jyoti Gupta" },
    { stars: 5, text: "I love their wild oats! Every Monday there's a discount on it. Perfect for cabin snacks or car canteens — definitely worth trying.", name: "Deepika Aggarwal" },
    { stars: 5, text: "OneAnt has the best customer service. They are quick to resolve difficulties.", name: "Tanisha Jain" },
  ];

  return (
    <div style={{ background: "#fff" }}>
      {/* Category bar
      <div className="catbar">
        <div className="catbar-in">
          <button className={`cpill ${!selCat?"on":""}`} onClick={()=>setSelCat(null)}>
            <span className="cpill-ico">🏪</span>All
          </button>
          {categories.map(c=>(
            <button key={c.id} className={`cpill ${selCat===c.id?"on":""}`} onClick={()=>setSelCat(c.id===selCat?null:c.id)}>
              <span className="cpill-ico">{c.icon||ICONS[c.name]||"📦"}</span>{c.name}
            </button>
          ))}
        </div>
      </div> */}

      {/* ── Hero full-width ── */}
      <div style={{
        position: "relative",
        width: "100%",
        minHeight: 480,
        background: "url('/src/assets/heroslider1.png') center/cover no-repeat",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        overflow: "hidden",
      }}>
        {/* dark overlay for text legibility */}
        <div style={{ position: "absolute", inset: 0, background: "rgba(0,0,0,.28)" }} />
        {/* centered content */}
        <div style={{ position: "relative", zIndex: 1, textAlign: "center", padding: "60px 24px", maxWidth: 900, margin: "0 auto" }}>
          <h1 style={{
            fontFamily: "var(--font)",
            fontSize: "clamp(36px,5vw,64px)",
            fontWeight: 800,
            color: "#fff",
            lineHeight: 1.1,
            marginBottom: 16,
            letterSpacing: "-1.5px",
            whiteSpace: "nowrap",
          }}>
            Join Groups, <span style={{ color: "#7fff7f" }}>Buy Together</span>
          </h1>
          <p style={{
            fontSize: 16,
            color: "rgba(255,255,255,.9)",
            marginBottom: 32,
            display: "flex",
            alignItems: "center",
            justifyContent: "center",
            gap: 6,
            flexWrap: "wrap",
          }}>
            Save up to{" "}
            <span style={{ background: "#c8f542", color: "#111", borderRadius: 4, padding: "2px 10px", fontWeight: 800, fontSize: 15 }}>80%</span>
            {" "}on everything you need only on OneAnt marketplace
          </p>
          <div style={{ display: "flex", gap: 14, justifyContent: "center", flexWrap: "wrap" }}>
            <button
              onClick={() => document.querySelector(".sec-deals")?.scrollIntoView({ behavior: "smooth" })}
              style={{ background: "#fff", color: "#111", border: "none", borderRadius: 10, padding: "13px 32px", fontFamily: "var(--font)", fontSize: 15, fontWeight: 700, cursor: "pointer", display: "flex", alignItems: "center", gap: 8, transition: "all .2s" }}
              onMouseEnter={e => e.currentTarget.style.transform = "translateY(-2px)"}
              onMouseLeave={e => e.currentTarget.style.transform = "none"}
            >
              Shop Groceries &#8594;
            </button>
            {!user && (
              <button
                onClick={onLogin}
                style={{ background: "transparent", color: "#fff", border: "2px solid rgba(255,255,255,.7)", borderRadius: 10, padding: "12px 32px", fontFamily: "var(--font)", fontSize: 15, fontWeight: 600, cursor: "pointer", display: "flex", alignItems: "center", gap: 8, transition: "all .2s" }}
                onMouseEnter={e => e.currentTarget.style.borderColor = "#fff"}
                onMouseLeave={e => e.currentTarget.style.borderColor = "rgba(255,255,255,.7)"}
              >
                &#128100; Log in
              </button>
            )}
          </div>
          <div style={{ display: "flex", gap: 8, justifyContent: "center", marginTop: 28 }}>
            {[0, 1, 2].map(i => (
              <div key={i} onClick={() => setHeroDot(i)} style={{ width: heroDot === i ? 24 : 8, height: 8, borderRadius: 99, background: heroDot === i ? "#fff" : "rgba(255,255,255,.4)", cursor: "pointer", transition: "all .2s" }} />
            ))}
          </div>
        </div>
      </div>


      {/* ── Daily Deals ── */}
      <div className="sec-deals">
        <CarouselSection title="Daily Deals" emoji="" products={products} onView={setViewP} onAdd={addCart} getQty={getQty} onQty={updateQty} />
      </div>

      {/* ── Festival Essentials ── */}
      <CarouselSection title="Festival Essentials" emoji="" products={products.slice().reverse()} onView={setViewP} onAdd={addCart} getQty={getQty} onQty={updateQty} />

      {/* ── All Products ── */}
      <CarouselSection title="All Products" emoji="" products={products} onView={setViewP} onAdd={addCart} getQty={getQty} onQty={updateQty} />

      {/* ── Promo Banner ── */}
      <div style={{ margin: "0 24px 32px", borderRadius: 16, overflow: "hidden", position: "relative", minHeight: 200, display: "flex", alignItems: "stretch" }}>
        {/* Left: text content */}
        <div style={{ flex: "0 0 48%", background: "#fff", padding: "40px 44px", display: "flex", flexDirection: "column", justifyContent: "center", zIndex: 1 }}>
          <p style={{ fontSize: 13, color: "#888", fontWeight: 500, marginBottom: 8, letterSpacing: ".02em" }}>Looking for something else?</p>
          <h2 style={{ fontSize: 24, fontWeight: 800, color: "#1c6b39", lineHeight: 1.25, marginBottom: 24, letterSpacing: "-.4px" }}>
            See what else<br />you can buy
          </h2>
          <button
            onClick={() => setShowInquiry(true)}
            style={{ background: "#1c6b39", color: "#fff", border: "none", borderRadius: 8, padding: "11px 26px", fontFamily: "var(--font)", fontSize: 14, fontWeight: 700, cursor: "pointer", display: "inline-flex", alignItems: "center", gap: 8, width: "fit-content", transition: "all .2s" }}
            onMouseEnter={e => e.currentTarget.style.background = "#144f2a"}
            onMouseLeave={e => e.currentTarget.style.background = "#1c6b39"}
          >
            Sign up Now &#8594;
          </button>
        </div>
        {/* Right: image */}
        <div style={{ flex: 1, position: "relative", overflow: "hidden" }}>
          <div style={{ position: "absolute", inset: 0, background: "url('/src/assets/Frame-1171274837.png') center/cover no-repeat" }} />
          {/* fade from white on the left edge */}
          <div style={{ position: "absolute", inset: 0, background: "linear-gradient(90deg,#fff 0%,transparent 25%)" }} />
        </div>
      </div>

      {/* ── Delivery CTA Strip ── */}
      <div style={{ margin: "0 24px 28px", borderRadius: 12, background: "linear-gradient(90deg,#e2f0e7,#c8e8d2)", border: "1px solid #b0d9be", padding: "18px 24px", display: "flex", alignItems: "center", justifyContent: "space-between", flexWrap: "wrap", gap: 12 }}>
        <div style={{ display: "flex", alignItems: "center", gap: 16 }}>
          <div style={{ width: 48, height: 48, borderRadius: 12, background: "rgba(255,255,255,.7)", display: "flex", alignItems: "center", justifyContent: "center", fontSize: 26, flexShrink: 0 }}>&#x1F343;</div>
          <div>
            <div style={{ fontSize: 14.5, fontWeight: 700, color: "#111" }}>Get groceries delivered</div>
            <div style={{ fontSize: 12.5, color: "#555", marginTop: 2 }}>or picked up today — and save more!</div>
          </div>
        </div>
        <div style={{ display: "flex", alignItems: "center", gap: 16 }}>
          <button style={{ background: "#1c6b39", color: "#fff", border: "none", borderRadius: 8, padding: "10px 22px", fontFamily: "var(--font)", fontSize: 13.5, fontWeight: 700, cursor: "pointer", whiteSpace: "nowrap", display: "flex", alignItems: "center", gap: 6 }} onMouseEnter={e => e.currentTarget.style.background = "#144f2a"} onMouseLeave={e => e.currentTarget.style.background = "#1c6b39"}>
            Sign up Now &#8594;
          </button>
          <div style={{ fontSize: 11, color: "#1c6b39", fontWeight: 700, textAlign: "center", lineHeight: 1.5, background: "rgba(255,255,255,.6)", borderRadius: 8, padding: "6px 10px" }}>
            &#x1F389; 20 &amp; 25% OFF<br />on the first order
          </div>
        </div>
      </div>

      {/* ── Get 60% Off ── */}
      <CarouselSection title="Get 60% Off*" emoji="" products={deals.slice(0, 6)} onView={setViewP} onAdd={addCart} getQty={getQty} onQty={updateQty} />

      {/* ── Why OneAnt ── */}
      <div style={{ background: "#fff", padding: "52px 24px", borderTop: "1px solid #eee" }}>
        <div style={{ maxWidth: 1000, margin: "0 auto" }}>
          <h2 style={{ fontSize: 22, fontWeight: 800, textAlign: "center", marginBottom: 32, letterSpacing: "-.3px" }}>Why OneAnt?</h2>
          <div style={{ display: "grid", gridTemplateColumns: "repeat(5,1fr)", gap: 16 }}>
            {WHY.map((w, i) => (
              <div key={i} style={{ textAlign: "center", padding: "20px 12px", borderRadius: 12, background: "#fafafa", border: "1px solid #eee" }}>
                <div style={{ width: 52, height: 52, background: "#fff", border: "1px solid #e0e0e0", borderRadius: 12, display: "flex", alignItems: "center", justifyContent: "center", fontSize: 22, margin: "0 auto 12px", boxShadow: "0 2px 8px rgba(0,0,0,.06)" }}>
                  {w.icon}
                </div>
                <div style={{ fontSize: 12.5, fontWeight: 700, color: "#111", marginBottom: 4, lineHeight: 1.35 }}>{w.title}</div>
                <div style={{ fontSize: 11, color: "#888" }}>{w.sub}</div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* ── How It Works ── */}
      <div style={{ background: "#fff", padding: "52px 24px", borderTop: "1px solid #eee" }}>
        <div style={{ maxWidth: 780, margin: "0 auto" }}>
          <h2 style={{ fontSize: 22, fontWeight: 800, textAlign: "center", marginBottom: 44, letterSpacing: "-.3px" }}>How It Works?</h2>
          <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr 1fr", gap: 24, position: "relative" }}>
            {/* SVG dotted curved connector */}
            <div style={{ position: "absolute", top: 26, left: "20%", right: "20%", pointerEvents: "none", zIndex: 0 }}>
              <svg width="100%" height="60" viewBox="0 0 400 60" fill="none" xmlns="http://www.w3.org/2000/svg" style={{ overflow: "visible" }}>
                <path d="M 0 30 Q 100 5 200 30 Q 300 55 400 30" stroke="#b0d9be" strokeWidth="2" strokeDasharray="6 5" fill="none" />
              </svg>
            </div>
            {HOW.map((h, i) => (
              <div key={i} style={{ textAlign: "center", position: "relative", zIndex: 1 }}>
                <div style={{ width: 54, height: 54, background: "#1c6b39", borderRadius: "50%", display: "flex", alignItems: "center", justifyContent: "center", margin: "0 auto 16px", fontSize: 15, fontWeight: 800, color: "#fff", boxShadow: "0 4px 14px rgba(28,107,57,.35)" }}>
                  {h.n}
                </div>
                <div style={{ fontSize: 13.5, fontWeight: 700, marginBottom: 6, color: "#111" }}>{h.title}</div>
                <div style={{ fontSize: 12.5, color: "#666", lineHeight: 1.6 }}>{h.desc}</div>
              </div>
            ))}
          </div>
          <div style={{ textAlign: "center", marginTop: 36 }}>
            <button style={{ background: "#1c6b39", color: "#fff", border: "none", borderRadius: 8, padding: "11px 30px", fontFamily: "var(--font)", fontSize: 14, fontWeight: 700, cursor: "pointer" }} onMouseEnter={e => e.currentTarget.style.background = "#144f2a"} onMouseLeave={e => e.currentTarget.style.background = "#1c6b39"}>
              Get Started &#8594;
            </button>
          </div>
        </div>
      </div>

      {/* ── Testimonials ── */}
      <div style={{ background: "#fff", padding: "52px 24px", borderTop: "1px solid #eee" }}>
        <div style={{ maxWidth: 960, margin: "0 auto" }}>
          <h2 style={{ fontSize: 22, fontWeight: 800, textAlign: "center", marginBottom: 32, letterSpacing: "-.3px" }}>Ants Love Shopping With Us!</h2>
          <div style={{ display: "grid", gridTemplateColumns: "repeat(3,1fr)", gap: 16 }}>
            {REVIEWS.map((r, i) => (
              <div key={i} style={{ background: "#fffde7", borderRadius: 12, padding: "18px 20px", border: "1px solid #ffe082" }}>
                <div style={{ display: "flex", gap: 2, marginBottom: 8 }}>
                  {Array(r.stars).fill(0).map((_, j) => <span key={j} style={{ color: "#f59e0b", fontSize: 15 }}>&#9733;</span>)}
                </div>
                <p style={{ fontSize: 12.5, color: "#333", lineHeight: 1.65, marginBottom: 12 }}>{r.text}</p>
                <div style={{ fontSize: 12, fontWeight: 700, color: "#555" }}>&#8212; {r.name}</div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* ── FAQ ── */}
      <FAQ />

      {/* ── Footer ── */}
      <Footer />

      {viewP && <PDetail p={viewP} onClose={() => setViewP(null)} onAdd={addCart} />}
    </div>
  );
}

/* ═══════════════════════════════════════════════════════════
   GROUPS PAGE
═══════════════════════════════════════════════════════════ */
function GroupsPage({ user }) {
  const [tab, setTab] = useState("mine"); const [groups, setGroups] = useState([]); const [joined, setJoined] = useState([]);
  const [loading, setLoading] = useState(true); const [showNew, setShowNew] = useState(false); const [sel, setSel] = useState(null);

  useEffect(() => {
    if (!user) return;
    Promise.all([get("/api/user-groups"), get("/api/user-groups/joined")])
      .then(([m, j]) => { setGroups(m || []); setJoined(j || []); }).catch(e => toast.err(e.message)).finally(() => setLoading(false));
  }, [user]);

  const del_ = async id => {
    if (!confirm("Delete this group?")) return;
    try { await del(`/api/user-groups/${id}`); setGroups(g => g.filter(x => x.id !== id)); toast.ok("Deleted"); } catch (e) { toast.err(e.message); }
  };

  if (!user) return <div className="empty" style={{ paddingTop: 80 }}><div className="ei">👥</div><div className="et">Sign in to manage groups</div></div>;
  const list = tab === "mine" ? groups : joined;

  return (
    <div style={{ maxWidth: 1100, margin: "0 auto", padding: "24px" }}>
      <div className="row" style={{ marginBottom: 22 }}>
        <div style={{ fontSize: 22, fontWeight: 800 }}>My Groups</div>
        <div className="grow" />
        <button className="btn btn-p" onClick={() => setShowNew(true)}>+ New Group</button>
      </div>
      <div className="tabs">
        <button className={`tab ${tab === "mine" ? "on" : ""}`} onClick={() => setTab("mine")}>My Groups ({groups.length})</button>
        <button className={`tab ${tab === "joined" ? "on" : ""}`} onClick={() => setTab("joined")}>Joined ({joined.length})</button>
      </div>
      {loading ? <div className="loading"><span className="spin" /></div> : list.length === 0 ? <div className="empty"><div className="ei">👥</div><div className="et">{tab === "mine" ? "No groups yet" : "Haven't joined any"}</div></div> : (
        <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fill,minmax(260px,1fr))", gap: 14 }}>
          {list.map(g => (
            <div key={g.id} style={{ background: "#fff", border: "1.5px solid var(--border)", borderRadius: "var(--r12)", padding: 18, cursor: "pointer", transition: "all .2s" }} onClick={() => setSel(g)}
              onMouseEnter={e => { e.currentTarget.style.borderColor = "var(--g2)"; e.currentTarget.style.boxShadow = "var(--sh1)" }}
              onMouseLeave={e => { e.currentTarget.style.borderColor = "var(--border)"; e.currentTarget.style.boxShadow = "none" }}>
              <div className="row" style={{ marginBottom: 10 }}>
                <div style={{ flex: 1 }}><div style={{ fontWeight: 700, fontSize: 15, marginBottom: 2 }}>{g.name}</div><div className="fs12" style={{ color: "var(--t3)" }}>{new Date(g.createdAt).toLocaleDateString()}</div></div>
                <span className={`tag ${g.isLocked ? "to" : "tg"}`}>{g.isLocked ? "🔒 Locked" : "✓ Open"}</span>
              </div>
              <div className="fs12" style={{ color: "var(--t2)", marginBottom: 12 }}>👥 {g.memberCount || 0} / 5 members</div>
              <div className="row" style={{ gap: 7 }} onClick={e => e.stopPropagation()}>
                {tab === "mine" && <button className="btn btn-r btn-sm" onClick={() => del_(g.id)}>Delete</button>}
              </div>
            </div>
          ))}
        </div>
      )}
      {showNew && <CreateGroupModal onClose={() => setShowNew(false)} onDone={g => { setGroups(x => [g, ...x]); setShowNew(false); }} />}
      {sel && <GroupDetailModal g={sel} onClose={() => setSel(null)} user={user} />}
    </div>
  );
}

function CreateGroupModal({ onClose, onDone }) {
  const [name, setName] = useState(""); const [desc, setDesc] = useState(""); const [pub, setPub] = useState(true);
  const [loading, setLoading] = useState(false); const [err, setErr] = useState("");
  const go = async () => {
    if (!name.trim()) { setErr("Name required"); return; }
    setLoading(true); setErr("");
    try { const g = await post("/api/user-groups", { name, description: desc, isPublic: pub }); toast.ok("Group created!"); onDone(g); }
    catch (e) { setErr(e.message); } finally { setLoading(false); }
  };
  return <Modal title="Create Group" onClose={onClose}>
    {err && <div className="err">{err}</div>}
    <div className="field"><label className="lbl">Name</label><input className="inp" placeholder="e.g. Weekend Groceries" value={name} onChange={e => setName(e.target.value)} /></div>
    <div className="field"><label className="lbl">Description (optional)</label><textarea className="inp" value={desc} onChange={e => setDesc(e.target.value)} /></div>
    <div className="field"><label className="lbl">Visibility</label><select className="inp" value={pub ? "public" : "private"} onChange={e => setPub(e.target.value === "public")}><option value="public">Public</option><option value="private">Private</option></select></div>
    <button className="btn btn-p" style={{ width: "100%" }} onClick={go} disabled={loading}>{loading ? <span className="spin" /> : "Create Group"}</button>
  </Modal>;
}

function GroupDetailModal({ g, onClose, user }) {
  const [details, setDetails] = useState(g); const [pending, setPending] = useState([]); const [approved, setApproved] = useState([]); const [par, setPar] = useState(null); const [loading, setLoading] = useState(true);
  useEffect(() => {
    Promise.all([get(`/api/user-groups/${g.id}`), get(`/api/user-groups/${g.id}/pending`).catch(() => []), get(`/api/user-groups/${g.id}/approved`).catch(() => []), get(`/api/user-groups/${g.id}/participation`).catch(() => null)])
      .then(([d, p, a, pa]) => { setDetails(d || g); setPending(p || []); setApproved(a || []); setPar(pa); }).catch(() => { }).finally(() => setLoading(false));
  }, [g]);
  const isOwner = details.userId === user?.id;
  const approve = async id => { try { await post(`/api/user-groups/${g.id}/approve/${id}`); setPending(p => p.filter(x => x.id !== id)); toast.ok("Approved"); } catch (e) { toast.err(e.message); } };
  const reject_ = async id => { try { await post(`/api/user-groups/${g.id}/reject/${id}`); setPending(p => p.filter(x => x.id !== id)); } catch (e) { toast.err(e.message); } };
  const join = async () => { try { await post(`/api/user-groups/${g.id}/join`); setPar({ status: "pending" }); toast.ok("Request sent!"); } catch (e) { toast.err(e.message); } };
  return <Modal title={details.name} onClose={onClose} width="520px">
    {loading ? <div className="loading"><span className="spin" /></div> : (<>
      <div className="row" style={{ gap: 7, marginBottom: 14, flexWrap: "wrap" }}>
        <span className={`tag ${details.isLocked ? "to" : "tg"}`}>{details.isLocked ? "🔒 Locked" : "✓ Open"}</span>
        <span className="tag" style={{ background: "var(--bg)", color: "var(--t2)" }}>👥 {approved.length}/5</span>
        {isOwner && <span className="tag tg">Owner</span>}
      </div>
      {details.description && <p style={{ fontSize: 12.5, color: "var(--t2)", marginBottom: 14 }}>{details.description}</p>}
      {approved.length > 0 && <div style={{ marginBottom: 14 }}><div className="lbl" style={{ marginBottom: 7 }}>Members</div>{approved.map(m => <div key={m.id} className="row" style={{ padding: "7px 0", borderBottom: "1px solid var(--border)" }}><div style={{ width: 26, height: 26, borderRadius: 8, background: "var(--gl)", display: "flex", alignItems: "center", justifyContent: "center", fontWeight: 700, fontSize: 11, color: "var(--g1)" }}>{(m.firstName || m.phoneNumber || "?")[0]?.toUpperCase()}</div><span style={{ fontSize: 12.5 }}>{m.firstName ? `${m.firstName} ${m.lastName || ""}` : m.phoneNumber}</span></div>)}</div>}
      {isOwner && pending.length > 0 && <div style={{ marginBottom: 14 }}><div className="lbl" style={{ marginBottom: 7 }}>Pending Requests</div>{pending.map(p => <div key={p.id} className="row" style={{ padding: "7px 0", borderBottom: "1px solid var(--border)" }}><span className="grow" style={{ fontSize: 12.5 }}>{p.firstName || p.phoneNumber}</span><button className="btn btn-p btn-sm" onClick={() => approve(p.id)}>Approve</button><button className="btn btn-s btn-sm" onClick={() => reject_(p.id)}>Reject</button></div>)}</div>}
      {!isOwner && !par && <button className="btn btn-p" style={{ width: "100%" }} onClick={join}>Request to Join</button>}
      {par && <div className={par.status === "approved" ? "ok" : "err"}>{par.status === "pending" ? "⏳ Join request pending" : par.status === "approved" ? "✓ You are a member" : par.status}</div>}
    </>)}
  </Modal>;
}

/* ═══════════════════════════════════════════════════════════
   ORDERS PAGE
═══════════════════════════════════════════════════════════ */
function OrdersPage({ user }) {
  const [orders, setOrders] = useState([]); const [loading, setLoading] = useState(true); const [sel, setSel] = useState(null);
  useEffect(() => { if (!user) return; get("/api/orders").then(d => setOrders(d || [])).catch(e => toast.err(e.message)).finally(() => setLoading(false)); }, [user]);
  if (!user) return <div className="empty" style={{ paddingTop: 80 }}><div className="ei">📦</div><div className="et">Sign in to view orders</div></div>;
  const stag = s => { const m = { pending: "ty", processing: "tag", shipped: "tg", delivered: "tg", cancelled: "tr" }; return <span className={`tag ${m[s] || ""}`}>{s}</span>; };
  return (
    <div style={{ maxWidth: 1100, margin: "0 auto", padding: "24px" }}>
      <div style={{ fontSize: 22, fontWeight: 800, marginBottom: 22 }}>My Orders</div>
      {loading ? <div className="loading"><span className="spin" /></div> : orders.length === 0 ? <div className="empty"><div className="ei">📦</div><div className="et">No orders yet</div></div> : (
        <div className="tw"><table><thead><tr><th>Order ID</th><th>Date</th><th>Items</th><th>Total</th><th>Status</th><th></th></tr></thead>
          <tbody>{orders.map(o => <tr key={o.id}><td style={{ color: "var(--t1)", fontWeight: 600 }}>#{o.id?.toString().slice(-6)}</td><td>{new Date(o.createdAt).toLocaleDateString()}</td><td>{o.items?.length || 0}</td><td style={{ fontWeight: 700, color: "var(--g1)" }}>${parseFloat(o.totalAmount || 0).toFixed(2)}</td><td>{stag(o.status || "pending")}</td><td><button className="btn btn-g btn-sm" onClick={() => setSel(o)}>View →</button></td></tr>)}</tbody>
        </table></div>
      )}
      {sel && <Modal title={`Order #${sel.id?.toString().slice(-6)}`} onClose={() => setSel(null)} width="520px">
        <div className="row" style={{ gap: 7, marginBottom: 14 }}>{stag(sel.status)}<span className="tag" style={{ background: "var(--bg)", color: "var(--t2)" }}>{new Date(sel.createdAt).toLocaleDateString()}</span></div>
        {sel.items?.map((item, i) => <div key={i} className="row" style={{ padding: "11px 0", borderBottom: "1px solid var(--border)" }}><span style={{ flex: 1, fontWeight: 600, fontSize: 13 }}>{item.product?.name || `Item ${i + 1}`}</span><span className="fs12" style={{ color: "var(--t3)" }}>×{item.quantity}</span><span style={{ fontWeight: 700, color: "var(--g1)" }}>${parseFloat(item.price || 0).toFixed(2)}</span></div>)}
        <div className="row" style={{ marginTop: 14, justifyContent: "space-between" }}><span style={{ color: "var(--t2)" }}>Total</span><span style={{ fontSize: 19, fontWeight: 800, color: "var(--g1)" }}>${parseFloat(sel.totalAmount || 0).toFixed(2)}</span></div>
      </Modal>}
    </div>
  );
}

/* ═══════════════════════════════════════════════════════════
   SELLER DASHBOARD
═══════════════════════════════════════════════════════════ */
function SellerDash({ user }) {
  const [tab, setTab] = useState("overview");
  const [metrics, setMetrics] = useState(null); const [products, setProducts] = useState([]); const [orders, setOrders] = useState([]);
  const [notifs, setNotifs] = useState([]); const [unread, setUnread] = useState(0); const [shops, setShops] = useState([]);
  const [loading, setLoading] = useState(true); const [showAdd, setShowAdd] = useState(false);

  useEffect(() => {
    if (!user?.isSeller) return;
    Promise.all([get("/api/seller/metrics"), get("/api/seller/products"), get("/api/seller/orders"), get("/api/seller/notifications"), get("/api/seller/notifications/unread-count"), get("/api/seller/shops")])
      .then(([m, p, o, n, uc, s]) => { setMetrics(m); setProducts(p || []); setOrders(o || []); setNotifs(n || []); setUnread(uc?.count || 0); setShops(s || []); }).catch(e => toast.err(e.message)).finally(() => setLoading(false));
  }, [user]);

  const markRead = async () => { try { await patch("/api/seller/notifications/mark-all-read"); setNotifs(n => n.map(x => ({ ...x, isRead: true }))); setUnread(0); } catch (e) { toast.err(e.message); } };
  const delProd = async id => { if (!confirm("Delete?")) return; try { await del(`/api/seller/products/${id}`); setProducts(p => p.filter(x => x.id !== id)); toast.ok("Deleted"); } catch (e) { toast.err(e.message); } };
  const updStatus = async (id, s) => { try { await patch(`/api/seller/orders/${id}/status`, { status: s }); setOrders(o => o.map(x => x.id === id ? { ...x, status: s } : x)); toast.ok("Updated"); } catch (e) { toast.err(e.message); } };

  if (!user) return <div className="empty" style={{ paddingTop: 80 }}><div className="ei">🔐</div><div className="et">Sign in first</div></div>;
  if (!user.isSeller) return <div className="empty" style={{ paddingTop: 80 }}><div className="ei">🏪</div><div className="et">Seller account required</div></div>;

  return (
    <div style={{ maxWidth: 1100, margin: "0 auto", padding: "24px" }}>
      <div className="row" style={{ marginBottom: 22 }}>
        <div style={{ fontSize: 22, fontWeight: 800 }}>Seller Dashboard</div>
        <div className="grow" />
        {unread > 0 && <span className="tag tr">{unread} new</span>}
      </div>
      <div className="tabs">
        {[["overview", "Overview"], ["products", "Products"], ["orders", "Orders"], ["notifications", `Notifications${unread > 0 ? ` (${unread})` : ""}`]].map(([k, l]) => <button key={k} className={`tab ${tab === k ? "on" : ""}`} onClick={() => setTab(k)}>{l}</button>)}
      </div>
      {loading ? <div className="loading"><span className="spin" /></div> : (<>
        {tab === "overview" && metrics && (<>
          <div className="stat-grid">
            {[["Revenue", `$${parseFloat(metrics.totalRevenue || 0).toFixed(0)}`, "g"], ["Orders", metrics.totalOrders, ""], ["Active Groups", metrics.activeGroups, ""], ["Products", metrics.totalProducts, ""], ["Growth", `+${metrics.growthPercentage?.toFixed(1)}%`, "g"], ["Potential", `$${parseFloat(metrics.potentialRevenue || 0).toFixed(0)}`, ""]].map(([l, v, c]) => <div key={l} className="stat-c"><div className="stat-l">{l}</div><div className={`stat-v ${c}`}>{v}</div></div>)}
          </div>
          {shops.length > 0 && <><div style={{ fontWeight: 700, marginBottom: 10 }}>Your Shops</div><div className="row" style={{ flexWrap: "wrap", gap: 10 }}>{shops.map(s => <div key={s.id} style={{ background: "#fff", border: "1.5px solid var(--border)", borderRadius: "var(--r8)", padding: "12px 16px" }}><div style={{ fontWeight: 700 }}>{s.name}</div><div className="fs12" style={{ color: "var(--t3)" }}>{s.shopType}</div></div>)}</div></>}
        </>)}
        {tab === "products" && (<>
          <div style={{ display: "flex", justifyContent: "flex-end", marginBottom: 14 }}><button className="btn btn-p" onClick={() => setShowAdd(true)}>+ Add Product</button></div>
          {products.length === 0 ? <div className="empty"><div className="ei">📦</div><div className="et">No products</div></div> : <div className="tw"><table><thead><tr><th>Product</th><th>Price</th><th>Min Participants</th><th>Valid Until</th><th></th></tr></thead><tbody>{products.map(p => <tr key={p.id}><td style={{ color: "var(--t1)", fontWeight: 600 }}>{p.name}</td><td style={{ color: "var(--g1)", fontWeight: 700 }}>${parseFloat(p.discountPrice || p.originalPrice || 0).toFixed(2)}</td><td>{p.minimumParticipants || "—"}</td><td>{p.offerValidTill ? new Date(p.offerValidTill).toLocaleDateString() : "—"}</td><td><button className="btn btn-r btn-sm" onClick={() => delProd(p.id)}>Delete</button></td></tr>)}</tbody></table></div>}
          {showAdd && <AddProductModal shops={shops} onClose={() => setShowAdd(false)} onDone={p => { setProducts(x => [p, ...x]); setShowAdd(false); }} />}
        </>)}
        {tab === "orders" && (orders.length === 0 ? <div className="empty"><div className="ei">📋</div><div className="et">No orders</div></div> : <div className="tw"><table><thead><tr><th>Order ID</th><th>Date</th><th>Total</th><th>Status</th><th>Update</th></tr></thead><tbody>{orders.map(o => <tr key={o.id}><td style={{ fontWeight: 600, color: "var(--t1)" }}>#{o.id?.toString().slice(-6)}</td><td>{new Date(o.createdAt).toLocaleDateString()}</td><td style={{ color: "var(--g1)", fontWeight: 700 }}>${parseFloat(o.totalAmount || 0).toFixed(2)}</td><td><span className={`tag ${o.status === "delivered" || o.status === "shipped" ? "tg" : "ty"}`}>{o.status}</span></td><td><select className="inp" style={{ padding: "4px 7px", fontSize: 12, width: "auto" }} value={o.status} onChange={e => updStatus(o.id, e.target.value)}>{["pending", "processing", "shipped", "delivered"].map(s => <option key={s} value={s}>{s}</option>)}</select></td></tr>)}</tbody></table></div>)}
        {tab === "notifications" && (<>
          {unread > 0 && <div style={{ display: "flex", justifyContent: "flex-end", marginBottom: 10 }}><button className="btn btn-s btn-sm" onClick={markRead}>Mark All Read</button></div>}
          {notifs.length === 0 ? <div className="empty"><div className="ei">🔔</div><div className="et">No notifications</div></div> : <div style={{ display: "flex", flexDirection: "column", gap: 9 }}>{notifs.map(n => <div key={n.id} style={{ background: "#fff", border: `1.5px solid ${n.isRead ? "var(--border)" : "var(--g2)"}`, borderRadius: "var(--r8)", padding: "13px 16px", opacity: n.isRead ? .7 : 1 }}><div className="row"><span style={{ fontSize: 16 }}>🔔</span><div className="grow"><div style={{ fontSize: 12.5, color: "var(--t1)" }}>{n.message}</div><div className="fs12" style={{ color: "var(--t3)" }}>{new Date(n.createdAt).toLocaleString()}</div></div>{!n.isRead && <span className="tag tg">New</span>}</div></div>)}</div>}
        </>)}
      </>)}
    </div>
  );
}

function AddProductModal({ shops, onClose, onDone }) {
  const [form, setForm] = useState({ shopId: shops[0]?.id || "", name: "", description: "", categoryId: "", originalPrice: "", discountPrice: "", minimumParticipants: 10, maximumParticipants: 1000, imageUrl: "", offerValidTill: "" });
  const [cats, setCats] = useState([]); const [loading, setLoading] = useState(false); const [err, setErr] = useState("");
  useEffect(() => { get("/api/categories").then(setCats).catch(() => { }); }, []);
  const s = (k, v) => setForm(f => ({ ...f, [k]: v }));
  const go = async () => {
    if (!form.name || !form.shopId) { setErr("Name and shop required"); return; }
    setLoading(true); setErr("");
    try { const p = await post("/api/seller/products", { ...form, categoryId: parseInt(form.categoryId) || undefined, minimumParticipants: parseInt(form.minimumParticipants), maximumParticipants: parseInt(form.maximumParticipants) }); toast.ok("Created!"); onDone(p); }
    catch (e) { setErr(e.message); } finally { setLoading(false); }
  };
  return <Modal title="Add Product" onClose={onClose} width="540px">
    {err && <div className="err">{err}</div>}
    <div className="two-col">
      <div className="field mb0"><label className="lbl">Shop</label><select className="inp" value={form.shopId} onChange={e => s("shopId", e.target.value)}>{shops.map(sh => <option key={sh.id} value={sh.id}>{sh.name}</option>)}</select></div>
      <div className="field mb0"><label className="lbl">Category</label><select className="inp" value={form.categoryId} onChange={e => s("categoryId", e.target.value)}><option value="">Select…</option>{cats.map(c => <option key={c.id} value={c.id}>{c.name}</option>)}</select></div>
    </div>
    <div className="field mt12"><label className="lbl">Product Name</label><input className="inp" value={form.name} onChange={e => s("name", e.target.value)} /></div>
    <div className="field"><label className="lbl">Description</label><textarea className="inp" value={form.description} onChange={e => s("description", e.target.value)} /></div>
    <div className="two-col">
      <div className="field mb0"><label className="lbl">Original Price ($)</label><input className="inp" type="number" step="0.01" value={form.originalPrice} onChange={e => s("originalPrice", e.target.value)} /></div>
      <div className="field mb0"><label className="lbl">Discount Price ($)</label><input className="inp" type="number" step="0.01" value={form.discountPrice} onChange={e => s("discountPrice", e.target.value)} /></div>
    </div>
    <div className="two-col mt12">
      <div className="field mb0"><label className="lbl">Min Participants</label><input className="inp" type="number" value={form.minimumParticipants} onChange={e => s("minimumParticipants", e.target.value)} /></div>
      <div className="field mb0"><label className="lbl">Max Participants</label><input className="inp" type="number" value={form.maximumParticipants} onChange={e => s("maximumParticipants", e.target.value)} /></div>
    </div>
    <div className="field mt12"><label className="lbl">Image URL</label><input className="inp" placeholder="https://…" value={form.imageUrl} onChange={e => s("imageUrl", e.target.value)} /></div>
    <div className="field"><label className="lbl">Offer Valid Until</label><input className="inp" type="date" value={form.offerValidTill} onChange={e => s("offerValidTill", e.target.value)} /></div>
    <button className="btn btn-p" style={{ width: "100%" }} onClick={go} disabled={loading}>{loading ? <span className="spin" /> : "Create Product"}</button>
  </Modal>;
}

/* ═══════════════════════════════════════════════════════════
   PROFILE PAGE
═══════════════════════════════════════════════════════════ */
function ProfilePage({ user, setUser }) {
  const [form, setForm] = useState({ firstName: user?.firstName || "", lastName: user?.lastName || "", email: user?.email || "", phoneNumber: user?.phoneNumber || "" });
  const [addrs, setAddrs] = useState([]); const [tab, setTab] = useState("profile");
  const [loading, setLoading] = useState(false); const [al, setAl] = useState(true); const [err, setErr] = useState(""); const [showA, setShowA] = useState(false);
  useEffect(() => { if (!user) return; get("/api/addresses").then(a => setAddrs(a || [])).catch(() => { }).finally(() => setAl(false)); }, [user]);
  const save = async () => { setLoading(true); setErr(""); try { const u = await put("/api/auth/update-profile", form); setUser(x => ({ ...x, ...u })); toast.ok("Saved!"); } catch (e) { setErr(e.message); } finally { setLoading(false); } };
  const delA = async id => { try { await del(`/api/addresses/${id}`); setAddrs(a => a.filter(x => x.id !== id)); toast.ok("Deleted"); } catch (e) { toast.err(e.message); } };
  const setDef = async id => { try { await post(`/api/addresses/${id}/setdefault`); setAddrs(a => a.map(x => ({ ...x, isDefault: x.id === id }))); toast.ok("Default set"); } catch (e) { toast.err(e.message); } };
  if (!user) return <div className="empty" style={{ paddingTop: 80 }}><div className="ei">👤</div><div className="et">Sign in first</div></div>;
  return (
    <div style={{ maxWidth: 600, margin: "0 auto", padding: "24px" }}>
      <div style={{ fontSize: 22, fontWeight: 800, marginBottom: 22 }}>My Account</div>
      <div className="tabs">
        <button className={`tab ${tab === "profile" ? "on" : ""}`} onClick={() => setTab("profile")}>Profile</button>
        <button className={`tab ${tab === "addresses" ? "on" : ""}`} onClick={() => setTab("addresses")}>Addresses</button>
      </div>
      {tab === "profile" && <div style={{ background: "#fff", border: "1.5px solid var(--border)", borderRadius: "var(--r16)", padding: 22 }}>
        <div className="row" style={{ marginBottom: 20 }}>
          <div style={{ width: 52, height: 52, borderRadius: 12, background: "linear-gradient(135deg,var(--g1),var(--g3))", color: "#fff", display: "flex", alignItems: "center", justifyContent: "center", fontWeight: 800, fontSize: 20 }}>{(user.firstName || user.phoneNumber || "?")[0]?.toUpperCase()}</div>
          <div><div style={{ fontWeight: 800, fontSize: 17 }}>{user.firstName ? `${user.firstName} ${user.lastName || ""}` : "User"}</div><div className="fs12" style={{ color: "var(--t3)" }}>{user.phoneNumber}</div>{user.isSeller && <span className="tag tg" style={{ marginTop: 4 }}>Seller</span>}</div>
        </div>
        {err && <div className="err">{err}</div>}
        <div className="two-col"><div className="field mb0"><label className="lbl">First Name</label><input className="inp" value={form.firstName} onChange={e => setForm(f => ({ ...f, firstName: e.target.value }))} /></div><div className="field mb0"><label className="lbl">Last Name</label><input className="inp" value={form.lastName} onChange={e => setForm(f => ({ ...f, lastName: e.target.value }))} /></div></div>
        <div className="field mt12"><label className="lbl">Email</label><input className="inp" type="email" value={form.email} onChange={e => setForm(f => ({ ...f, email: e.target.value }))} /></div>
        <div className="field"><label className="lbl">Phone</label><input className="inp" value={form.phoneNumber} onChange={e => setForm(f => ({ ...f, phoneNumber: e.target.value }))} /></div>
        <button className="btn btn-p" onClick={save} disabled={loading}>{loading ? <span className="spin" /> : "Save Changes"}</button>
      </div>}
      {tab === "addresses" && <>
        <div style={{ display: "flex", justifyContent: "flex-end", marginBottom: 14 }}><button className="btn btn-p" onClick={() => setShowA(true)}>+ Add Address</button></div>
        {al ? <div className="loading"><span className="spin" /></div> : addrs.length === 0 ? <div className="empty"><div className="ei">📍</div><div className="et">No addresses saved</div></div> :
          <div style={{ display: "flex", flexDirection: "column", gap: 10 }}>{addrs.map(a => <div key={a.id} style={{ background: "#fff", border: "1.5px solid var(--border)", borderRadius: "var(--r12)", padding: "15px 18px" }}>
            <div className="row" style={{ marginBottom: 3 }}><div style={{ flex: 1, fontWeight: 600 }}>{a.street}</div>{a.isDefault && <span className="tag tg">Default</span>}</div>
            <div className="fs12" style={{ color: "var(--t2)" }}>{a.city}, {a.province} {a.postalCode}</div>
            <div className="row" style={{ marginTop: 10, gap: 7 }}>{!a.isDefault && <button className="btn btn-s btn-sm" onClick={() => setDef(a.id)}>Set Default</button>}<button className="btn btn-r btn-sm" onClick={() => delA(a.id)}>Delete</button></div>
          </div>)}</div>}
        {showA && <AddAddrModal onClose={() => setShowA(false)} onDone={a => { setAddrs(x => [...x, a]); setShowA(false); }} />}
      </>}
    </div>
  );
}

function AddAddrModal({ onClose, onDone }) {
  const [form, setForm] = useState({ street: "", city: "", province: "BC", postalCode: "", country: "Canada" });
  const [loading, setLoading] = useState(false); const [err, setErr] = useState("");
  const s = (k, v) => setForm(f => ({ ...f, [k]: v }));
  const go = async () => { if (!form.street || !form.city || !form.postalCode) { setErr("All fields required"); return; } setLoading(true); setErr(""); try { const a = await post("/api/addresses", form); toast.ok("Address added!"); onDone(a); } catch (e) { setErr(e.message); } finally { setLoading(false); } };
  return <Modal title="Add Address" onClose={onClose}>
    {err && <div className="err">{err}</div>}
    <div className="field"><label className="lbl">Street Address</label><input className="inp" placeholder="123 Main St" value={form.street} onChange={e => s("street", e.target.value)} /></div>
    <div className="two-col"><div className="field mb0"><label className="lbl">City</label><input className="inp" placeholder="Vancouver" value={form.city} onChange={e => s("city", e.target.value)} /></div><div className="field mb0"><label className="lbl">Postal Code</label><input className="inp" placeholder="V6B 1A1" value={form.postalCode} onChange={e => s("postalCode", e.target.value)} /></div></div>
    <div className="field mt12"><label className="lbl">Province</label><select className="inp" value={form.province} onChange={e => s("province", e.target.value)}><option>BC</option><option>AB</option><option>ON</option><option>QC</option></select></div>
    <button className="btn btn-p" style={{ width: "100%" }} onClick={go} disabled={loading}>{loading ? <span className="spin" /> : "Add Address"}</button>
  </Modal>;
}

/* ═══════════════════════════════════════════════════════════
   MISC MODALS
═══════════════════════════════════════════════════════════ */
function SellerInquiry({ onClose }) {
  const [form, setForm] = useState({ name: "", phoneNumber: "" }); const [loading, setLoading] = useState(false); const [done, setDone] = useState(false); const [err, setErr] = useState("");
  const go = async () => { if (!form.name || !form.phoneNumber) { setErr("All fields required"); return; } setLoading(true); setErr(""); try { await post("/api/seller-inquiry", form); setDone(true); } catch (e) { setErr(e.message); } finally { setLoading(false); } };
  return <Modal title="Sell on OneAnt" onClose={onClose}>
    {done ? <div className="ok" style={{ textAlign: "center", padding: 22 }}>✓ Inquiry submitted! We'll be in touch soon.</div> : <>
      {err && <div className="err">{err}</div>}
      <p style={{ fontSize: 12.5, color: "var(--t2)", marginBottom: 16 }}>Interested in selling on OneAnt? Fill this out and we'll reach out shortly.</p>
      <div className="field"><label className="lbl">Full Name</label><input className="inp" value={form.name} onChange={e => setForm(f => ({ ...f, name: e.target.value }))} /></div>
      <div className="field"><label className="lbl">Phone Number</label><input className="inp" placeholder="+1 604 555 0100" value={form.phoneNumber} onChange={e => setForm(f => ({ ...f, phoneNumber: e.target.value }))} /></div>
      <button className="btn btn-p" style={{ width: "100%" }} onClick={go} disabled={loading}>{loading ? <span className="spin" /> : "Submit Inquiry"}</button></>}
  </Modal>;
}

function DeliveryCheck({ onClose }) {
  const [addr, setAddr] = useState(""); const [result, setResult] = useState(null); const [loading, setLoading] = useState(false); const [err, setErr] = useState("");
  const go = async () => { if (!addr.trim()) return; setLoading(true); setErr(""); setResult(null); try { const r = await post("/api/address/validate", { address: addr }); setResult(r); } catch (e) { setErr(e.message); } finally { setLoading(false); } };
  return <Modal title="📍 Check Delivery" onClose={onClose}>
    {err && <div className="err">{err}</div>}
    <div className="field"><label className="lbl">Your Address</label><input className="inp" placeholder="123 Main St, Vancouver, BC" value={addr} onChange={e => setAddr(e.target.value)} onKeyDown={e => e.key === "Enter" && go()} /></div>
    <button className="btn btn-p" style={{ width: "100%", marginBottom: 14 }} onClick={go} disabled={loading}>{loading ? <span className="spin" /> : "Check Availability"}</button>
    {result && <><div className={result.isValid ? "ok" : "err"}>{result.isValid ? "✓ We deliver to your area!" : "✕ Outside delivery zone"}</div>
      {result.isValid && result.deliveryInfo && <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 10 }}>
        <div style={{ background: "var(--bg)", borderRadius: "var(--r8)", padding: "11px 14px" }}><div className="fs12" style={{ color: "var(--t3)" }}>Distance</div><div style={{ fontWeight: 700 }}>{result.deliveryInfo.distance} km</div></div>
        <div style={{ background: "var(--gl)", borderRadius: "var(--r8)", padding: "11px 14px" }}><div className="fs12" style={{ color: "var(--t3)" }}>Delivery Fee</div><div style={{ fontWeight: 700, color: "var(--g1)" }}>{result.deliveryInfo.isFreeDelivery ? "FREE" : `$${result.deliveryInfo.deliveryFee}`}</div></div>
      </div>}</>}
  </Modal>;
}

/* ═══════════════════════════════════════════════════════════
   ROOT APP
═══════════════════════════════════════════════════════════ */
export default function App() {
  const [user, setUser] = useState(null);
  const [page, setPage] = useState("home");
  const [cartOpen, setCartOpen] = useState(false);
  const [cartItems, setCartItems] = useState([]);
  const [showAuth, setShowAuth] = useState(false);
  const [showInquiry, setShowInquiry] = useState(false);
  const [showDelivery, setShowDelivery] = useState(false);
  const [ready, setReady] = useState(false);

  useEffect(() => { get("/api/auth/user").then(u => { if (u?.id) setUser(u); }).catch(() => { }).finally(() => setReady(true)); }, []);
  useEffect(() => { if (user) get("/api/cart").then(d => setCartItems(d || [])).catch(() => { }); }, [user]);

  const logout = async () => { try { await post("/api/auth/logout"); setUser(null); setCartItems([]); toast.i("Signed out"); setPage("home"); } catch (e) { toast.err(e.message); } };

  const navItems = [["home", "Products"], ["groups", "Groups"], ["orders", "Orders"], ...(user?.isSeller ? [["seller", "Dashboard"]] : [])]

  // Ticker content
  const msgs = ["🎉 Flat OFF on your first order! Use Coupon FIRST20 at checkout", "🛍️ Grab 20% Flat OFF! Use Coupon FIRST20", "⚡ Join a group and save up to 80% today", "🚚 Free delivery on group orders over $50"];

  if (!ready) return <div style={{ display: "flex", alignItems: "center", justifyContent: "center", height: "100vh", background: "var(--bg)" }}><span className="spin" /></div>;

  return (
    <>
      <style>{CSS}</style>

      {/* Announcement ticker */}
      <div className="ann">
        <div className="ann-track">
          {[
            "Flat OFF on your first order! Use Coupon FIRST20 at checkout",
            "Grab 20% Flat OFF on your first order! Use Coupon FIRST20 at checkout",
            "Flat OFF on your first order! Use Coupon FIRST20 at checkout",
            "Grab 20% Flat OFF on your first order! Use Coupon FIRST20 at checkout",
            "Flat OFF on your first order! Use Coupon FIRST20 at checkout",
            "Grab 20% Flat OFF on your first order! Use Coupon FIRST20 at checkout",
          ].map((m, i) => (
            <span key={i} className="ann-item">
              {m}
              <span style={{ display: "inline-flex", alignItems: "center", justifyContent: "center", width: 22, height: 22, borderRadius: 4, border: "1.5px solid rgba(0,0,0,.25)", marginLeft: 16, marginRight: 16, fontSize: 12, opacity: .7 }}>&#x1F3F7;</span>
            </span>
          ))}
        </div>
      </div>

      {/* Navigation */}
      <nav className="nav">
        <div className="nav-in">
          {/* Logo */}
          <div className="logo" onClick={() => setPage("home")}>
            <div style={{ width: 38, height: 38, borderRadius: "50%", background: "#f03", display: "flex", alignItems: "center", justifyContent: "center", flexShrink: 0 }}>
              <span style={{ color: "#fff", fontWeight: 900, fontSize: 18, fontFamily: "var(--font)" }}>1</span>
            </div>
            <span style={{ fontWeight: 800, fontSize: 26, color: "#111", letterSpacing: "-.5px", fontFamily: "var(--font)" }}>ant</span>
          </div>

          {/* Nav links — Products & Services only */}
          <div className="nav-links">
            <button className={`nl ${page === "home" ? "on" : ""}`} onClick={() => setPage("home")}>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" style={{ flexShrink: 0 }}><path d="M12 2a10 10 0 1 0 0 20A10 10 0 0 0 12 2z" /><path d="M12 8v4l3 3" /></svg>
              Products
            </button>
            {/* <button className="nl" onClick={()=>setPage("groups")}>
              <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round" style={{flexShrink:0}}><rect x="2" y="7" width="20" height="14" rx="2"/><path d="M16 7V5a2 2 0 0 0-4 0v2"/><path d="M8 7V5a2 2 0 0 0-4 0v2"/></svg>
              Services
            </button> */}
          </div>

          <div className="spacer" />

          {/* Right actions */}
          <div className="nav-acts">
            {user ? (
              <>
                <button
                  onClick={() => setCartOpen(true)}
                  style={{ display: "flex", alignItems: "center", justifyContent: "center", width: 42, height: 42, borderRadius: 10, border: "1.5px solid #e0e0e0", background: "#fff", cursor: "pointer", position: "relative", transition: "all .15s" }}
                  onMouseEnter={e => e.currentTarget.style.borderColor = "var(--r)"}
                  onMouseLeave={e => e.currentTarget.style.borderColor = "#e0e0e0"}
                >
                  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#333" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="9" cy="21" r="1" /><circle cx="20" cy="21" r="1" /><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6" /></svg>
                  {cartItems.length > 0 && (
                    <span style={{ position: "absolute", top: -4, right: -4, background: "var(--r)", color: "#fff", borderRadius: 99, minWidth: 18, height: 18, fontSize: 10, fontWeight: 800, display: "flex", alignItems: "center", justifyContent: "center", border: "2px solid #fff", padding: "0 3px" }}>
                      {cartItems.length}
                    </span>
                  )}
                </button>
                <div onClick={() => setPage("profile")} style={{ width: 36, height: 36, borderRadius: 9, background: "linear-gradient(135deg,var(--g1),var(--g3))", color: "#fff", display: "flex", alignItems: "center", justifyContent: "center", fontWeight: 800, fontSize: 14, cursor: "pointer", flexShrink: 0 }}>
                  {(user.firstName || user.phoneNumber || "?")[0]?.toUpperCase()}
                </div>
                <button className="btn-login" onClick={logout}>Sign Out</button>
              </>
            ) : (
              <>
                <button
                  onClick={() => setShowInquiry(true)}
                  style={{ background: "var(--r)", color: "#fff", border: "none", borderRadius: 10, padding: "10px 20px", fontFamily: "var(--font)", fontSize: 14, fontWeight: 700, cursor: "pointer", display: "flex", alignItems: "center", gap: 8, transition: "all .15s", whiteSpace: "nowrap" }}
                  onMouseEnter={e => e.currentTarget.style.background = "#c8202f"}
                  onMouseLeave={e => e.currentTarget.style.background = "var(--r)"}
                >
                  <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z" /><polyline points="9 22 9 12 15 12 15 22" /></svg>
                  Sell on OneAnt
                </button>
                <button
                  onClick={() => setShowAuth(true)}
                  style={{ background: "none", border: "none", fontFamily: "var(--font)", fontSize: 14, fontWeight: 500, color: "#333", cursor: "pointer", display: "flex", alignItems: "center", gap: 7, padding: "8px 4px", transition: "color .15s" }}
                  onMouseEnter={e => e.currentTarget.style.color = "var(--r)"}
                  onMouseLeave={e => e.currentTarget.style.color = "#333"}
                >
                  <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="1.8" strokeLinecap="round" strokeLinejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" /><circle cx="12" cy="7" r="4" /></svg>
                  Log in
                </button>
                <button
                  onClick={() => setCartOpen(true)}
                  style={{ display: "flex", alignItems: "center", justifyContent: "center", width: 42, height: 42, borderRadius: 10, border: "1.5px solid #e0e0e0", background: "#fff", cursor: "pointer", position: "relative", transition: "all .15s" }}
                  onMouseEnter={e => e.currentTarget.style.borderColor = "var(--r)"}
                  onMouseLeave={e => e.currentTarget.style.borderColor = "#e0e0e0"}
                >
                  <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="#333" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><circle cx="9" cy="21" r="1" /><circle cx="20" cy="21" r="1" /><path d="M1 1h4l2.68 13.39a2 2 0 0 0 2 1.61h9.72a2 2 0 0 0 2-1.61L23 6H6" /></svg>
                  {cartItems.length > 0 && (
                    <span style={{ position: "absolute", top: -4, right: -4, background: "var(--r)", color: "#fff", borderRadius: 99, minWidth: 18, height: 18, fontSize: 10, fontWeight: 800, display: "flex", alignItems: "center", justifyContent: "center", border: "2px solid #fff", padding: "0 3px" }}>
                      {cartItems.length}
                    </span>
                  )}
                </button>
              </>
            )}
          </div>
        </div>
      </nav>

      {/* Pages */}
      {page === "home" && <HomePage user={user} cartItems={cartItems} setCartItems={setCartItems} onLogin={() => setShowAuth(true)} />}
      {page === "groups" && <GroupsPage user={user} />}
      {page === "orders" && <OrdersPage user={user} />}
      {page === "seller" && <SellerDash user={user} />}
      {page === "profile" && <ProfilePage user={user} setUser={setUser} />}

      <CartSide open={cartOpen} onClose={() => setCartOpen(false)} user={user} cartItems={cartItems} setCartItems={setCartItems} />

      {showAuth && <AuthModal onClose={() => setShowAuth(false)} onSuccess={d => { setUser(d?.user || d); setShowAuth(false); }} />}
      {showInquiry && <SellerInquiry onClose={() => setShowInquiry(false)} />}
      {showDelivery && <DeliveryCheck onClose={() => setShowDelivery(false)} />}

      <Toasts />
    </>
  );
}