"use strict";(()=>{(self.webpackChunkapp=self.webpackChunkapp||[]).push([[8258],{8258:(pt,j,P)=>{P.r(j),P.d(j,{s:()=>lt});var _=P(16424),st=Object.defineProperty,d=(A,H)=>st(A,"name",{value:H,configurable:!0});function z(A,H){for(var c=0;c<H.length;c++){const b=H[c];if(typeof b!="string"&&!Array.isArray(b)){for(const v in b)if(v!=="default"&&!(v in A)){const w=Object.getOwnPropertyDescriptor(b,v);w&&Object.defineProperty(A,v,w.get?w:{enumerable:!0,get:()=>b[v]})}}}return Object.freeze(Object.defineProperty(A,Symbol.toStringTag,{value:"Module"}))}d(z,"_mergeNamespaces");var ct={exports:{}};(function(A,H){(function(c){c((0,_.r)())})(function(c){var b="CodeMirror-hint",v="CodeMirror-hint-active";c.showHint=function(t,e,i){if(!e)return t.showHint(i);i&&i.async&&(e.async=!0);var n={hint:e};if(i)for(var o in i)n[o]=i[o];return t.showHint(n)},c.defineExtension("showHint",function(t){t=J(this,this.getCursor("start"),t);var e=this.listSelections();if(!(e.length>1)){if(this.somethingSelected()){if(!t.hint.supportsSelection)return;for(var i=0;i<e.length;i++)if(e[i].head.line!=e[i].anchor.line)return}this.state.completionActive&&this.state.completionActive.close();var n=this.state.completionActive=new w(this,t);n.options.hint&&(c.signal(this,"startCompletion",this),n.update(!0))}}),c.defineExtension("closeHint",function(){this.state.completionActive&&this.state.completionActive.close()});function w(t,e){if(this.cm=t,this.options=e,this.widget=null,this.debounce=0,this.tick=0,this.startPos=this.cm.getCursor("start"),this.startLen=this.cm.getLine(this.startPos.line).length-this.cm.getSelection().length,this.options.updateOnCursorActivity){var i=this;t.on("cursorActivity",this.activityFunc=function(){i.cursorActivity()})}}d(w,"Completion");var ht=window.requestAnimationFrame||function(t){return setTimeout(t,1e3/60)},at=window.cancelAnimationFrame||clearTimeout;w.prototype={close:function(){this.active()&&(this.cm.state.completionActive=null,this.tick=null,this.options.updateOnCursorActivity&&this.cm.off("cursorActivity",this.activityFunc),this.widget&&this.data&&c.signal(this.data,"close"),this.widget&&this.widget.close(),c.signal(this.cm,"endCompletion",this.cm))},active:function(){return this.cm.state.completionActive==this},pick:function(t,e){var i=t.list[e],n=this;this.cm.operation(function(){i.hint?i.hint(n.cm,t,i):n.cm.replaceRange(I(i),i.from||t.from,i.to||t.to,"complete"),c.signal(t,"pick",i),n.cm.scrollIntoView()}),this.options.closeOnPick&&this.close()},cursorActivity:function(){this.debounce&&(at(this.debounce),this.debounce=0);var t=this.startPos;this.data&&(t=this.data.from);var e=this.cm.getCursor(),i=this.cm.getLine(e.line);if(e.line!=this.startPos.line||i.length-e.ch!=this.startLen-this.startPos.ch||e.ch<t.ch||this.cm.somethingSelected()||!e.ch||this.options.closeCharacters.test(i.charAt(e.ch-1)))this.close();else{var n=this;this.debounce=ht(function(){n.update()}),this.widget&&this.widget.disable()}},update:function(t){if(this.tick!=null){var e=this,i=++this.tick;W(this.options.hint,this.cm,this.options,function(n){e.tick==i&&e.finishUpdate(n,t)})}},finishUpdate:function(t,e){this.data&&c.signal(this.data,"update");var i=this.widget&&this.widget.picked||e&&this.options.completeSingle;this.widget&&this.widget.close(),this.data=t,t&&t.list.length&&(i&&t.list.length==1?this.pick(t,0):(this.widget=new B(this,t),c.signal(t,"shown")))}};function J(t,e,i){var n=t.options.hintOptions,o={};for(var r in Z)o[r]=Z[r];if(n)for(var r in n)n[r]!==void 0&&(o[r]=n[r]);if(i)for(var r in i)i[r]!==void 0&&(o[r]=i[r]);return o.hint.resolve&&(o.hint=o.hint.resolve(t,e)),o}d(J,"parseOptions");function I(t){return typeof t=="string"?t:t.text}d(I,"getText");function Q(t,e){var i={Up:function(){e.moveFocus(-1)},Down:function(){e.moveFocus(1)},PageUp:function(){e.moveFocus(-e.menuSize()+1,!0)},PageDown:function(){e.moveFocus(e.menuSize()-1,!0)},Home:function(){e.setFocus(0)},End:function(){e.setFocus(e.length-1)},Enter:e.pick,Tab:e.pick,Esc:e.close},n=/Mac/.test(navigator.platform);n&&(i["Ctrl-P"]=function(){e.moveFocus(-1)},i["Ctrl-N"]=function(){e.moveFocus(1)});var o=t.options.customKeys,r=o?{}:i;function s(a,l){var u;typeof l!="string"?u=d(function(C){return l(C,e)},"bound"):i.hasOwnProperty(l)?u=i[l]:u=l,r[a]=u}if(d(s,"addBinding"),o)for(var f in o)o.hasOwnProperty(f)&&s(f,o[f]);var h=t.options.extraKeys;if(h)for(var f in h)h.hasOwnProperty(f)&&s(f,h[f]);return r}d(Q,"buildKeyMap");function R(t,e){for(;e&&e!=t;){if(e.nodeName.toUpperCase()==="LI"&&e.parentNode==t)return e;e=e.parentNode}}d(R,"getHintElement");function B(t,e){this.id="cm-complete-"+Math.floor(Math.random(1e6)),this.completion=t,this.data=e,this.picked=!1;var i=this,n=t.cm,o=n.getInputField().ownerDocument,r=o.defaultView||o.parentWindow,s=this.hints=o.createElement("ul");s.setAttribute("role","listbox"),s.setAttribute("aria-expanded","true"),s.id=this.id;var f=t.cm.options.theme;s.className="CodeMirror-hints "+f,this.selectedHint=e.selectedHint||0;for(var h=e.list,a=0;a<h.length;++a){var l=s.appendChild(o.createElement("li")),u=h[a],C=b+(a!=this.selectedHint?"":" "+v);u.className!=null&&(C=u.className+" "+C),l.className=C,a==this.selectedHint&&l.setAttribute("aria-selected","true"),l.id=this.id+"-"+a,l.setAttribute("role","option"),u.render?u.render(l,e,u):l.appendChild(o.createTextNode(u.displayText||I(u))),l.hintId=a}var k=t.options.container||o.body,y=n.cursorCoords(t.options.alignWithWord?e.from:null),x=y.left,T=y.bottom,$=!0,S=0,F=0;if(k!==o.body){var ut=["absolute","relative","fixed"].indexOf(r.getComputedStyle(k).position)!==-1,K=ut?k:k.offsetParent,q=K.getBoundingClientRect(),Y=o.body.getBoundingClientRect();S=q.left-Y.left-K.scrollLeft,F=q.top-Y.top-K.scrollTop}s.style.left=x-S+"px",s.style.top=T-F+"px";var M=r.innerWidth||Math.max(o.body.offsetWidth,o.documentElement.offsetWidth),L=r.innerHeight||Math.max(o.body.offsetHeight,o.documentElement.offsetHeight);k.appendChild(s),n.getInputField().setAttribute("aria-autocomplete","list"),n.getInputField().setAttribute("aria-owns",this.id),n.getInputField().setAttribute("aria-activedescendant",this.id+"-"+this.selectedHint);var g=t.options.moveOnOverlap?s.getBoundingClientRect():new DOMRect,tt=t.options.paddingForScrollbar?s.scrollHeight>s.clientHeight+1:!1,O;setTimeout(function(){O=n.getScrollInfo()});var ft=g.bottom-L;if(ft>0){var U=g.bottom-g.top,dt=y.top-(y.bottom-g.top);if(dt-U>0)s.style.top=(T=y.top-U-F)+"px",$=!1;else if(U>L){s.style.height=L-5+"px",s.style.top=(T=y.bottom-g.top-F)+"px";var et=n.getCursor();e.from.ch!=et.ch&&(y=n.cursorCoords(et),s.style.left=(x=y.left-S)+"px",g=s.getBoundingClientRect())}}var N=g.right-M;if(tt&&(N+=n.display.nativeBarWidth),N>0&&(g.right-g.left>M&&(s.style.width=M-5+"px",N-=g.right-g.left-M),s.style.left=(x=y.left-N-S)+"px"),tt)for(var E=s.firstChild;E;E=E.nextSibling)E.style.paddingRight=n.display.nativeBarWidth+"px";if(n.addKeyMap(this.keyMap=Q(t,{moveFocus:function(p,m){i.changeActive(i.selectedHint+p,m)},setFocus:function(p){i.changeActive(p)},menuSize:function(){return i.screenAmount()},length:h.length,close:function(){t.close()},pick:function(){i.pick()},data:e})),t.options.closeOnUnfocus){var it;n.on("blur",this.onBlur=function(){it=setTimeout(function(){t.close()},100)}),n.on("focus",this.onFocus=function(){clearTimeout(it)})}n.on("scroll",this.onScroll=function(){var p=n.getScrollInfo(),m=n.getWrapperElement().getBoundingClientRect();O||(O=n.getScrollInfo());var ot=T+O.top-p.top,D=ot-(r.pageYOffset||(o.documentElement||o.body).scrollTop);if($||(D+=s.offsetHeight),D<=m.top||D>=m.bottom)return t.close();s.style.top=ot+"px",s.style.left=x+O.left-p.left+"px"}),c.on(s,"dblclick",function(p){var m=R(s,p.target||p.srcElement);m&&m.hintId!=null&&(i.changeActive(m.hintId),i.pick())}),c.on(s,"click",function(p){var m=R(s,p.target||p.srcElement);m&&m.hintId!=null&&(i.changeActive(m.hintId),t.options.completeOnSingleClick&&i.pick())}),c.on(s,"mousedown",function(){setTimeout(function(){n.focus()},20)});var nt=this.getSelectedHintRange();return(nt.from!==0||nt.to!==0)&&this.scrollToActive(),c.signal(e,"select",h[this.selectedHint],s.childNodes[this.selectedHint]),!0}d(B,"Widget"),B.prototype={close:function(){if(this.completion.widget==this){this.completion.widget=null,this.hints.parentNode&&this.hints.parentNode.removeChild(this.hints),this.completion.cm.removeKeyMap(this.keyMap);var t=this.completion.cm.getInputField();t.removeAttribute("aria-activedescendant"),t.removeAttribute("aria-owns");var e=this.completion.cm;this.completion.options.closeOnUnfocus&&(e.off("blur",this.onBlur),e.off("focus",this.onFocus)),e.off("scroll",this.onScroll)}},disable:function(){this.completion.cm.removeKeyMap(this.keyMap);var t=this;this.keyMap={Enter:function(){t.picked=!0}},this.completion.cm.addKeyMap(this.keyMap)},pick:function(){this.completion.pick(this.data,this.selectedHint)},changeActive:function(t,e){if(t>=this.data.list.length?t=e?this.data.list.length-1:0:t<0&&(t=e?0:this.data.list.length-1),this.selectedHint!=t){var i=this.hints.childNodes[this.selectedHint];i&&(i.className=i.className.replace(" "+v,""),i.removeAttribute("aria-selected")),i=this.hints.childNodes[this.selectedHint=t],i.className+=" "+v,i.setAttribute("aria-selected","true"),this.completion.cm.getInputField().setAttribute("aria-activedescendant",i.id),this.scrollToActive(),c.signal(this.data,"select",this.data.list[this.selectedHint],i)}},scrollToActive:function(){var t=this.getSelectedHintRange(),e=this.hints.childNodes[t.from],i=this.hints.childNodes[t.to],n=this.hints.firstChild;e.offsetTop<this.hints.scrollTop?this.hints.scrollTop=e.offsetTop-n.offsetTop:i.offsetTop+i.offsetHeight>this.hints.scrollTop+this.hints.clientHeight&&(this.hints.scrollTop=i.offsetTop+i.offsetHeight-this.hints.clientHeight+n.offsetTop)},screenAmount:function(){return Math.floor(this.hints.clientHeight/this.hints.firstChild.offsetHeight)||1},getSelectedHintRange:function(){var t=this.completion.options.scrollMargin||0;return{from:Math.max(0,this.selectedHint-t),to:Math.min(this.data.list.length-1,this.selectedHint+t)}}};function V(t,e){if(!t.somethingSelected())return e;for(var i=[],n=0;n<e.length;n++)e[n].supportsSelection&&i.push(e[n]);return i}d(V,"applicableHelpers");function W(t,e,i,n){if(t.async)t(e,n,i);else{var o=t(e,i);o&&o.then?o.then(n):n(o)}}d(W,"fetchHints");function X(t,e){var i=t.getHelpers(e,"hint"),n;if(i.length){var o=d(function(r,s,f){var h=V(r,i);function a(l){if(l==h.length)return s(null);W(h[l],r,f,function(u){u&&u.list.length>0?s(u):a(l+1)})}d(a,"run"),a(0)},"resolved");return o.async=!0,o.supportsSelection=!0,o}else return(n=t.getHelper(t.getCursor(),"hintWords"))?function(r){return c.hint.fromList(r,{words:n})}:c.hint.anyword?function(r,s){return c.hint.anyword(r,s)}:function(){}}d(X,"resolveAutoHints"),c.registerHelper("hint","auto",{resolve:X}),c.registerHelper("hint","fromList",function(t,e){var i=t.getCursor(),n=t.getTokenAt(i),o,r=c.Pos(i.line,n.start),s=i;n.start<i.ch&&/\w/.test(n.string.charAt(i.ch-n.start-1))?o=n.string.substr(0,i.ch-n.start):(o="",r=i);for(var f=[],h=0;h<e.words.length;h++){var a=e.words[h];a.slice(0,o.length)==o&&f.push(a)}if(f.length)return{list:f,from:r,to:s}}),c.commands.autocomplete=c.showHint;var Z={hint:c.hint.auto,completeSingle:!0,alignWithWord:!0,closeCharacters:/[\s()\[\]{};:>,]/,closeOnPick:!0,closeOnUnfocus:!0,updateOnCursorActivity:!0,completeOnSingleClick:!0,container:null,customKeys:null,extraKeys:null,paddingForScrollbar:!0,moveOnOverlap:!0};c.defineOption("hintOptions",null)})})();var G=ct.exports;const rt=(0,_.g)(G),lt=z({__proto__:null,default:rt},[G])}}]);})();

//# sourceMappingURL=8258.47889156.chunk.js.map