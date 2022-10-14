"use strict";(self.webpackChunksi_mm_mulator_website=self.webpackChunksi_mm_mulator_website||[]).push([[980],{3905:(e,t,a)=>{a.d(t,{Zo:()=>d,kt:()=>p});var o=a(7294);function r(e,t,a){return t in e?Object.defineProperty(e,t,{value:a,enumerable:!0,configurable:!0,writable:!0}):e[t]=a,e}function i(e,t){var a=Object.keys(e);if(Object.getOwnPropertySymbols){var o=Object.getOwnPropertySymbols(e);t&&(o=o.filter((function(t){return Object.getOwnPropertyDescriptor(e,t).enumerable}))),a.push.apply(a,o)}return a}function n(e){for(var t=1;t<arguments.length;t++){var a=null!=arguments[t]?arguments[t]:{};t%2?i(Object(a),!0).forEach((function(t){r(e,t,a[t])})):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(a)):i(Object(a)).forEach((function(t){Object.defineProperty(e,t,Object.getOwnPropertyDescriptor(a,t))}))}return e}function s(e,t){if(null==e)return{};var a,o,r=function(e,t){if(null==e)return{};var a,o,r={},i=Object.keys(e);for(o=0;o<i.length;o++)a=i[o],t.indexOf(a)>=0||(r[a]=e[a]);return r}(e,t);if(Object.getOwnPropertySymbols){var i=Object.getOwnPropertySymbols(e);for(o=0;o<i.length;o++)a=i[o],t.indexOf(a)>=0||Object.prototype.propertyIsEnumerable.call(e,a)&&(r[a]=e[a])}return r}var l=o.createContext({}),u=function(e){var t=o.useContext(l),a=t;return e&&(a="function"==typeof e?e(t):n(n({},t),e)),a},d=function(e){var t=u(e.components);return o.createElement(l.Provider,{value:t},e.children)},c={inlineCode:"code",wrapper:function(e){var t=e.children;return o.createElement(o.Fragment,{},t)}},m=o.forwardRef((function(e,t){var a=e.components,r=e.mdxType,i=e.originalType,l=e.parentName,d=s(e,["components","mdxType","originalType","parentName"]),m=u(a),p=r,M=m["".concat(l,".").concat(p)]||m[p]||c[p]||i;return a?o.createElement(M,n(n({ref:t},d),{},{components:a})):o.createElement(M,n({ref:t},d))}));function p(e,t){var a=arguments,r=t&&t.mdxType;if("string"==typeof e||r){var i=a.length,n=new Array(i);n[0]=m;var s={};for(var l in t)hasOwnProperty.call(t,l)&&(s[l]=t[l]);s.originalType=e,s.mdxType="string"==typeof e?e:r,n[1]=s;for(var u=2;u<i;u++)n[u]=a[u];return o.createElement.apply(null,n)}return o.createElement.apply(null,a)}m.displayName="MDXCreateElement"},3677:(e,t,a)=>{a.r(t),a.d(t,{assets:()=>l,contentTitle:()=>n,default:()=>c,frontMatter:()=>i,metadata:()=>s,toc:()=>u});var o=a(7462),r=(a(7294),a(3905));const i={sidebar_position:1},n="About siMMMulator",s={unversionedId:"about_simmmulator",id:"about_simmmulator",title:"About siMMMulator",description:"What is siMMMulator?",source:"@site/docs/about_simmmulator.md",sourceDirName:".",slug:"/about_simmmulator",permalink:"/siMMMulator/docs/about_simmmulator",draft:!1,editUrl:"https://github.com/facebookexperimental/siMMMulator/tree/gh-pages/docs/about_simmmulator.md",tags:[],version:"current",sidebarPosition:1,frontMatter:{sidebar_position:1},sidebar:"mySidebar",next:{title:"Setting Up siMMMulator",permalink:"/siMMMulator/docs/set_up"}},l={},u=[{value:"What is siMMMulator?",id:"what-is-simmmulator",level:2},{value:"What are Marketing Mix Models?",id:"what-are-marketing-mix-models",level:3},{value:"Why use siMMMulator?",id:"why-use-simmmulator",level:2},{value:"Applications of siMMMulator:",id:"applications-of-simmmulator",level:2},{value:"Looking for code to build a MMM?",id:"looking-for-code-to-build-a-mmm",level:2},{value:"Extra Docs",id:"extra-docs",level:2}],d={toc:u};function c(e){let{components:t,...i}=e;return(0,r.kt)("wrapper",(0,o.Z)({},d,i,{components:t,mdxType:"MDXLayout"}),(0,r.kt)("h1",{id:"about-simmmulator"},"About siMMMulator"),(0,r.kt)("h2",{id:"what-is-simmmulator"},"What is siMMMulator?"),(0,r.kt)("p",null,"siMMMulator is an open source R-package that allows users to generate simulated data to plug into Marketing Mix Models (MMMs). The package features a variety of functions to help users build a data set from scratch."),(0,r.kt)("h3",{id:"what-are-marketing-mix-models"},"What are Marketing Mix Models?"),(0,r.kt)("p",null,"Marketing Mix Models (MMMs) are used by marketers to understand what the ROI of their advertising spend on various channels are. This helps inform future investment decisions. MMMs usually incorporate many advertising channels in addition to non-advertising factors such as factors in the business environment. For more information on MMMs see the ",(0,r.kt)("a",{parentName:"p",href:"https://facebookexperimental.github.io/Robyn/docs/analysts-guide-to-MMM/"},"Analysts Guide to MMM"),"."),(0,r.kt)("p",null,"To try building your own MMM, see ",(0,r.kt)("a",{parentName:"p",href:"https://facebookexperimental.github.io/Robyn/"},"Robyn"),", an automated open source MMM."),(0,r.kt)("h2",{id:"why-use-simmmulator"},"Why use siMMMulator?"),(0,r.kt)("p",null,"siMMMulator provides users of MMMs with a way to generate a dataset with a ground-truth ROI so that they may validate their models."),(0,r.kt)("p",null,"MMMs are difficult to validate because:"),(0,r.kt)("ul",null,(0,r.kt)("li",{parentName:"ul"},'There is typically not a "ground-truth" outcome in a real data set that we can test the MMMs on. In a typical modeling problem, we would have a data set with the outcome we are trying to predict for. For example, if we were trying to build a model to predict the price of a home, we may have a data set with many different homes and the price they sold for. Then we would split up our data set into a training and testing data set. We would train our model on the training set. Then we would feed the test data set into the model to see how closely the model recovers the price of a home. This would give us an idea of how accurate our model is. However, with MMMs, marketers are trying to predict ROIs of various advertising media channels. The "true ROI" is not known, so we do not have a set to compare our model\'s predictions to.'),(0,r.kt)("li",{parentName:"ul"},"MMMs are usually built with time series data. This means the past predicts the present, which predicts the future. Since the different data points are connected to one another, it makes it difficult for us to decide which data to even select if we were going to make a testing data set."),(0,r.kt)("li",{parentName:"ul"},"Finally, MMMs are usually built on weekly or monthly sales data. Newer advertisers may not have sufficient data points to make an accurate model or do model validation.")),(0,r.kt)("p",null,"siMMMulator and simulated data helps to solve this problem because it provides a data set where:"),(0,r.kt)("ul",null,(0,r.kt)("li",{parentName:"ul"},"We know the true ROIs (the outcome the model is trying to predict for) so we have a comparison as to how closely our MMMs can recover this value. We know what the true ROI is because we simulated the data from the ground-up and just added statistical noise"),(0,r.kt)("li",{parentName:"ul"},"Marketers can generate as much data as they'd like, bypassing problems of insufficient data"),(0,r.kt)("li",{parentName:"ul"},"Users can generate data based on how their own business operates, making siMMMulator flexible and adaptable")),(0,r.kt)("h2",{id:"applications-of-simmmulator"},"Applications of siMMMulator:"),(0,r.kt)("ul",null,(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("strong",{parentName:"li"},"Validate MMMs")," : See how accurate MMMs are by seeing how well they can recover the true ROI of the data set"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("strong",{parentName:"li"},"Compare MMMs"),": Understand which MMM works better depending on which data sets (i.e. business scenarios) were generated"),(0,r.kt)("li",{parentName:"ul"},(0,r.kt)("strong",{parentName:"li"},"Quantify an Innovation to an MMM"),": See how much more accurate an MMM is after a particular innovation")),(0,r.kt)("p",null,"siMMMulator can work with most MMMs."),(0,r.kt)("h2",{id:"looking-for-code-to-build-a-mmm"},"Looking for code to build a MMM?"),(0,r.kt)("p",null,"Check out ",(0,r.kt)("a",{parentName:"p",href:"https://facebookexperimental.github.io/Robyn/"},"Robyn"),". Robyn is an experimental, semi-automated and open-sourced Marketing Mix Modeling (MMM) package from Meta Marketing Science. It uses various machine learning techniques (Ridge regression, multi-objective evolutionary algorithm for hyperparameter optimisation, time-series decomposition for trend & season etc.) to define media channel efficiency and effectivity, explore adstock rates and saturation curves. Robyn is built for granular datasets with many independent variables and therefore especially suitable for digital and direct response advertisers with rich data sources."),(0,r.kt)("h2",{id:"extra-docs"},"Extra Docs"),(0,r.kt)("p",null,(0,r.kt)("a",{target:"_blank",href:a(2346).Z},"Download a one-sheeter for siMMMulator")),(0,r.kt)("p",null,(0,r.kt)("a",{target:"_blank",href:a(6728).Z},"Download a presentation for siMMMulator")))}c.isMDXComponent=!0},2346:(e,t,a)=>{a.d(t,{Z:()=>o});const o=a.p+"assets/files/one-sheeter-465be45f78aa40d2aecf941a78d6e7ed.pdf"},6728:(e,t,a)=>{a.d(t,{Z:()=>o});const o=a.p+"assets/files/presentation-1b43c5bc2aa53cf92dc5cae13b0a6f97.pdf"}}]);