"use strict";(()=>{(self.webpackChunkapp=self.webpackChunkapp||[]).push([[979],{979:(G,C,t)=>{t.r(C),t.d(C,{TechDocsCustomHome:()=>B});var e=t(2784),g=t(64279),y=t(79692),h=t(64304),T=t(88285),r=t(38334),S=t(67266),D=t(30705),v=t(30204),a=t(49558),x=t(94339),P=t(16111),Z=t(24579),A=t(14503);const O=n=>{const{entities:l}=n,d=(0,D.tg)(S.b),i=(0,v.u)(v.p);return l?e.createElement(a.Oh,{"data-testid":"docs-explore"},l!=null&&l.length?l.map((s,m)=>{var u,c;return e.createElement(x.Z,{key:m},e.createElement(P.Z,null,e.createElement(a.hu,{title:(u=s.metadata.title)!=null?u:s.metadata.name})),e.createElement(Z.Z,null,s.metadata.description),e.createElement(A.Z,null,e.createElement(a.Qj,{to:d({namespace:(0,r.t)((c=s.metadata.namespace)!=null?c:"default",i),kind:(0,r.t)(s.kind,i),name:(0,r.t)(s.metadata.name,i)}),color:"primary","data-testid":"read_docs"},"Read Docs")))}):null):null};var Y=t(76635),F=t(76372);const R={DocsTable:r.D,DocsCardGrid:O},V=({config:n,entities:l,index:d})=>{const s=(0,y.Z)({panelContainer:{marginBottom:"2rem",...n.panelCSS?n.panelCSS:{}}})(),{loading:m,isOwnedEntity:u}=(0,h.ZW)(),c=R[n.panelType],p=l.filter(o=>n.filterPredicate==="ownedByUser"?m?!1:u(o):typeof n.filterPredicate=="function"&&n.filterPredicate(o));return e.createElement(e.Fragment,null,e.createElement(a.yW,{title:n.title,description:n.description},d===0?e.createElement(a.qt,null,"Discover documentation in your ecosystem."):null),e.createElement("div",{className:s.panelContainer},e.createElement(c,{"data-testid":"techdocs-custom-panel",entities:p})))},B=n=>{const{tabsConfig:l}=n,[d,i]=(0,e.useState)(0),s=(0,v.u)(h.Ah),{value:m,loading:u,error:c}=(0,g.default)(async()=>(await s.getEntities({filter:{"metadata.annotations.backstage.io/techdocs-ref":T.n3},fields:["apiVersion","kind","metadata","relations","spec.owner","spec.type"]})).items.filter(E=>{var f;return!!((f=E.metadata.annotations)!=null&&f["backstage.io/techdocs-ref"])})),p=l[d];return u?e.createElement(r.T,null,e.createElement(a.VY,null,e.createElement(a.Ex,null))):c?e.createElement(r.T,null,e.createElement(a.VY,null,e.createElement(a.GB,{severity:"error",title:"Could not load available documentation."},e.createElement(a.Oi,{language:"text",text:c.toString()})))):e.createElement(r.T,null,e.createElement(a.aR,{selectedIndex:d,onChange:o=>i(o),tabs:l.map(({label:o},E)=>({id:E.toString(),label:o}))}),e.createElement(a.VY,{"data-testid":"techdocs-content"},p.panels.map((o,E)=>e.createElement(V,{key:E,config:o,entities:m||[],index:E}))))}}}]);})();

//# sourceMappingURL=979.3f4f2b47.chunk.js.map