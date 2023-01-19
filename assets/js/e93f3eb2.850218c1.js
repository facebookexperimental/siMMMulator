"use strict";(self.webpackChunksi_mm_mulator_website=self.webpackChunksi_mm_mulator_website||[]).push([[793],{3905:(e,t,r)=>{r.d(t,{Zo:()=>p,kt:()=>d});var n=r(7294);function a(e,t,r){return t in e?Object.defineProperty(e,t,{value:r,enumerable:!0,configurable:!0,writable:!0}):e[t]=r,e}function o(e,t){var r=Object.keys(e);if(Object.getOwnPropertySymbols){var n=Object.getOwnPropertySymbols(e);t&&(n=n.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),r.push.apply(r,n)}return r}function i(e){for(var t=1;t<arguments.length;t++){var r=null!=arguments[t]?arguments[t]:{};t%2?o(Object(r),!0).forEach((function(t){a(e,t,r[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(r)):o(Object(r)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(r,t))}))}return e}function l(e,t){if(null==e)return{};var r,n,a=function(e,t){if(null==e)return{};var r,n,a={},o=Object.keys(e);for(n=0;n<o.length;n++)r=o[n],t.indexOf(r)>=0||(a[r]=e[r]);return a}(e,t);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);for(n=0;n<o.length;n++)r=o[n],t.indexOf(r)>=0||Object.prototype.propertyIsEnumerable.call(e,r)&&(a[r]=e[r])}return a}var s=n.createContext({}),u=function(e){var t=n.useContext(s),r=t;return e&&(r="function"==typeof e?e(t):i(i({},t),e)),r},p=function(e){var t=u(e.components);return n.createElement(s.Provider,{value:t},e.children)},c="mdxType",m={inlineCode:"code",wrapper:function(e){var t=e.children;return n.createElement(n.Fragment,{},t)}},f=n.forwardRef((function(e,t){var r=e.components,a=e.mdxType,o=e.originalType,s=e.parentName,p=l(e,["components","mdxType","originalType","parentName"]),c=u(r),f=a,d=c["".concat(s,".").concat(f)]||c[f]||m[f]||o;return r?n.createElement(d,i(i({ref:t},p),{},{components:r})):n.createElement(d,i({ref:t},p))}));function d(e,t){var r=arguments,a=t&&t.mdxType;if("string"==typeof e||a){var o=r.length,i=new Array(o);i[0]=f;var l={};for(var s in t)hasOwnProperty.call(t,s)&&(l[s]=t[s]);l.originalType=e,l[c]="string"==typeof e?e:a,i[1]=l;for(var u=2;u<o;u++)i[u]=r[u];return n.createElement.apply(null,i)}return n.createElement.apply(null,r)}f.displayName="MDXCreateElement"},7661:(e,t,r)=>{r.r(t),r.d(t,{assets:()=>s,contentTitle:()=>i,default:()=>c,frontMatter:()=>o,metadata:()=>l,toc:()=>u});var n=r(7462),a=(r(7294),r(3905));const o={},i="Setting Up siMMMulator",l={unversionedId:"set_up",id:"set_up",title:"Setting Up siMMMulator",description:"Installing R",source:"@site/docs/set_up.md",sourceDirName:".",slug:"/set_up",permalink:"/siMMMulator/docs/set_up",draft:!1,editUrl:"https://github.com/facebookexperimental/siMMMulator/tree/gh-pages/docs/set_up.md",tags:[],version:"current",frontMatter:{},sidebar:"mySidebar",previous:{title:"About siMMMulator",permalink:"/siMMMulator/docs/about_simmmulator"},next:{title:"Step-by-Step Guide",permalink:"/siMMMulator/docs/step_by_step_guide"}},s={},u=[{value:"Installing R",id:"installing-r",level:3},{value:"How to Install siMMMulator R-Package:",id:"how-to-install-simmmulator-r-package",level:3}],p={toc:u};function c(e){let{components:t,...r}=e;return(0,a.kt)("wrapper",(0,n.Z)({},p,r,{components:t,mdxType:"MDXLayout"}),(0,a.kt)("h1",{id:"setting-up-simmmulator"},"Setting Up siMMMulator"),(0,a.kt)("h3",{id:"installing-r"},"Installing R"),(0,a.kt)("p",null,"siMMMulator is an R-code package. Make sure you have the latest version of R installed. To install R, you can follow a tutorial provided by DataCamp."),(0,a.kt)("h3",{id:"how-to-install-simmmulator-r-package"},"How to Install siMMMulator R-Package:"),(0,a.kt)("p",null,"Use ",(0,a.kt)("inlineCode",{parentName:"p"},"remotes")," package. "),(0,a.kt)("pre",null,(0,a.kt)("code",{parentName:"pre"},'# If you don\'t have remotes installed yet, first run this line: \ninstall.packages("remotes") \n\n# install siMMMulator \nremotes::install_github(\n    repo = "facebookexperimental/siMMMulator"\n)\n\nlibrary(siMMMulator)\n\n')))}c.isMDXComponent=!0}}]);