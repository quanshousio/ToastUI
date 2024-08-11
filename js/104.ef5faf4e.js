/*!
 * This source file is part of the Swift.org open source project
 *
 * Copyright (c) 2021 Apple Inc. and the Swift project authors
 * Licensed under Apache License v2.0 with Runtime Library Exception
 *
 * See https://swift.org/LICENSE.txt for license information
 * See https://swift.org/CONTRIBUTORS.txt for Swift project authors
 */
"use strict";(self["webpackChunkswift_docc_render"]=self["webpackChunkswift_docc_render"]||[]).push([[104],{6137:function(e,t,n){n.d(t,{Z:function(){return d}});var r=function(){var e=this,t=e._self._c;return t("span",{staticClass:"badge",class:{[`badge-${e.variant}`]:e.variant},attrs:{role:"presentation"}},[e._t("default",(function(){return[e._v(e._s(e.text?e.$t(e.text):""))]}))],2)},a=[];const i={beta:"aside-kind.beta",deprecated:"aside-kind.deprecated"};var s={name:"Badge",props:{variant:{type:String,default:()=>""}},computed:{text:({variant:e})=>i[e]}},o=s,l=n(1001),c=(0,l.Z)(o,r,a,!1,null,"04624022",null),d=c.exports},8846:function(e,t,n){n.d(t,{Z:function(){return d}});var r=function(){var e=this,t=e._self._c;return t("BaseContentNode",e._b({},"BaseContentNode",e.$props,!1))},a=[],i=n(9519),s={name:"ContentNode",components:{BaseContentNode:i["default"]},props:i["default"].props,methods:i["default"].methods,BlockType:i["default"].BlockType,InlineType:i["default"].InlineType},o=s,l=n(1001),c=(0,l.Z)(o,r,a,!1,null,"3a32ffd0",null),d=c.exports},7120:function(e,t,n){n.d(t,{Z:function(){return c}});var r=function(e,t){return e("p",{staticClass:"requirement-metadata",class:t.data.staticClass},[e("strong",[t._v(t._s(t.parent.$t("required")))]),t.props.defaultImplementationsCount?[t._v(" "+t._s(t.parent.$tc("metadata.default-implementation",t.props.defaultImplementationsCount))+" ")]:t._e()],2)},a=[],i={name:"RequirementMetadata",props:{defaultImplementationsCount:{type:Number,default:0}}},s=i,o=n(1001),l=(0,o.Z)(s,r,a,!0,null,null,null),c=l.exports},7913:function(e,t,n){n.d(t,{default:function(){return D}});var r,a,i,s,o,l,c=n(352),d={name:"ChangedToken",render(e){const{kind:t,tokens:n}=this;return e("span",{class:[`token-${t}`,"token-changed"]},n.map((t=>e(D,{props:t}))))},props:{kind:{type:String,required:!0},tokens:{type:Array,required:!0}}},p=d,u=n(1001),f=(0,u.Z)(p,r,a,!1,null,null,null),m=f.exports,h=n(4260),g=n(5953),k={name:"LinkableToken",mixins:[g.Z],render(e){const t=this.references[this.identifier];return t&&t.url?e(h.Z,{props:{url:t.url,kind:t.kind,role:t.role}},this.$slots.default):e("span",{},this.$slots.default)},props:{identifier:{type:String,required:!0,default:()=>""}}},y=k,v=(0,u.Z)(y,i,s,!1,null,null,null),b=v.exports,_=function(){var e=this,t=e._self._c;return t("span",[e._v(e._s(e.text))])},C=[],x={name:"RawText",props:{text:{type:String,required:!0}}},Z=x,B=(0,u.Z)(Z,_,C,!1,null,null,null),T=B.exports,S={name:"SyntaxToken",render(e){return e("span",{class:`token-${this.kind}`},this.text)},props:{kind:{type:String,required:!0},text:{type:String,required:!0}}},I=S,$=(0,u.Z)(I,o,l,!1,null,null,null),q=$.exports;const w={attribute:"attribute",externalParam:"externalParam",genericParameter:"genericParameter",identifier:"identifier",internalParam:"internalParam",keyword:"keyword",label:"label",number:"number",string:"string",text:"text",typeIdentifier:"typeIdentifier",added:"added",removed:"removed"};var L,A,P={name:"DeclarationToken",render:function(e){const{kind:t,text:n,tokens:r}=this;switch(t){case w.text:{const t={text:n};return e(T,{props:t})}case w.typeIdentifier:{const t={identifier:this.identifier};return e(b,{class:"type-identifier-link",props:t},[e(c.Z,n)])}case w.attribute:{const{identifier:r}=this;return r?e(b,{class:"attribute-link",props:{identifier:r}},[e(c.Z,n)]):e(q,{props:{kind:t,text:n}})}case w.added:case w.removed:return e(m,{props:{tokens:r,kind:t}});default:{const r={kind:t,text:n};return e(q,{props:r})}}},constants:{TokenKind:w},props:{kind:{type:String,required:!0},identifier:{type:String,required:!1},text:{type:String,required:!1},tokens:{type:Array,required:!1,default:()=>[]}}},F=P,O=(0,u.Z)(F,L,A,!1,null,"295ad0ff",null),D=O.exports},7747:function(e,t,n){n.d(t,{Z:function(){return $}});var r=function(){var e=this,t=e._self._c;return e.icon?t("div",{staticClass:"topic-icon-wrapper"},[t(e.icon,{tag:"component",staticClass:"topic-icon"})],1):e._e()},a=[],i=n(4392),s=n(9728),o=function(){var e=this,t=e._self._c;return t("SVGIcon",{staticClass:"api-reference-icon",attrs:{viewBox:"0 0 14 14",themeId:"api-reference"}},[t("title",[e._v(e._s(e.$t("api-reference")))]),t("path",{attrs:{d:"m1 1v12h12v-12zm11 11h-10v-10h10z"}}),t("path",{attrs:{d:"m3 4h8v1h-8zm0 2.5h8v1h-8zm0 2.5h8v1h-8z"}}),t("path",{attrs:{d:"m3 4h8v1h-8z"}}),t("path",{attrs:{d:"m3 6.5h8v1h-8z"}}),t("path",{attrs:{d:"m3 9h8v1h-8z"}})])},l=[],c=n(9742),d={name:"APIReferenceIcon",components:{SVGIcon:c.Z}},p=d,u=n(1001),f=(0,u.Z)(p,o,l,!1,null,null,null),m=f.exports,h=function(){var e=this,t=e._self._c;return t("SVGIcon",{attrs:{viewBox:"0 0 14 14",themeId:"endpoint"}},[t("title",[e._v(e._s(e.$t("icons.web-service-endpoint")))]),t("path",{attrs:{d:"m4.28287247 6.78376978 1.22533003 1.31609522h-5.1705c-.1863961 0-.3375.1511039-.3375.3375s.1511039.3375.3375.3375h5.163075l-1.21668384 1.3134977c-.12696481.1370676-.11877484.3511082.01829279.478073.00142736.0013222.0028661.002632.00431605.0039293.14230624.1273266.36044925.1169204.48998895-.0233743l1.74120628-1.8857694c.11975533-.12969798.11933084-.329771-.00097377-.45895964l-1.74777504-1.8768415c-.12904019-.13856932-.3454527-.14779814-.48582142-.02071766-.13786105.12481021-.14844085.33774733-.02363065.47560839.00105049.00116033.00210906.00231332.00317562.00345889z"}}),t("path",{attrs:{d:"m6.62601817 12.0481107 1.74780541 1.8768741c.12904019.1385694.3454527.1477982.48582142.0207177.13786105-.1248102.14844085-.3377473.02363065-.4756084-.00105049-.0011603-.00210906-.0023133-.00317562-.0034589l-1.22533003-1.3160952h5.507325c.1863961 0 .3375-.1511039.3375-.3375s-.1511039-.3375-.3375-.3375h-5.500575l1.21735452-1.3141767c.12696498-.1370631.11877882-.35110017-.01828431-.47806515-.00142872-.00132346-.00286884-.00263456-.00432021-.00393315-.14230043-.12732144-.36043854-.11689991-.48995303.02340745l-1.74130509 1.88641385c-.11972441.1297014-.11928576.3297493.00100629.4589244z"}}),t("path",{attrs:{d:"m.148635 6.750135h.72225c-.127575-.32265-.193725-.666225-.19575-1.0125.054675-1.728675 1.497825-3.086775 3.2265-3.0375.2781.000675.554175.037125.8235.108l.29025.07425.108-.2835c.398925-1.1502 1.4823-1.9224 2.7-1.92375 1.6362.050625 2.92005 1.41885 2.869425 3.054375 0 .003375-.000675.00675-.000675.010125v.3105l.289575.0405c1.0935.230175 1.86705 1.20555 1.843425 2.322.0459 1.23795-.903825 2.286225-2.13975 2.3625h-.493425l.675.675c1.53765-.16875 2.684475-1.492425 2.633175-3.0375.022275-1.352025-.8532-2.55555-2.1465-2.94975-.081675-1.906875-1.62945-3.42225-3.537-3.46275-1.381725.0081-2.6298.82755-3.186 2.0925-.2403-.0459-.48465-.06885-.729-.0675-2.101275-.049275-3.84615 1.611225-3.9015 3.7125.000675.1944.0189.3888.054.5805.0135.081.03375.162.054.243z"}})])},g=[],k={name:"EndpointIcon",components:{SVGIcon:c.Z}},y=k,v=(0,u.Z)(y,h,g,!1,null,null,null),b=v.exports,_=n(7366),C=n(4900),x=n(2944),Z=n(7192);const B={[Z.L.article]:i.Z,[Z.L.collection]:C.Z,[Z.L.collectionGroup]:m,[Z.L.learn]:_.Z,[Z.L.overview]:_.Z,[Z.L.project]:x.Z,[Z.L.tutorial]:x.Z,[Z.L.resources]:_.Z,[Z.L.sampleCode]:s.Z,[Z.L.restRequestSymbol]:b};var T={components:{SVGIcon:c.Z},props:{role:{type:String,required:!0}},computed:{icon:({role:e})=>B[e]}},S=T,I=(0,u.Z)(S,r,a,!1,null,"55f9d05d",null),$=I.exports},8104:function(e,t,n){n.r(t),n.d(t,{default:function(){return q}});var r=function(){var e=this,t=e._self._c;return t("div",{staticClass:"link-block",class:e.linkBlockClasses},[t(e.linkComponent,e._b({ref:"apiChangesDiff",tag:"component",staticClass:"link",class:e.linkClasses},"component",e.linkProps,!1),[e.topic.role&&!e.change?t("TopicLinkBlockIcon",{attrs:{role:e.topic.role}}):e._e(),e.topic.fragments?t("DecoratedTopicTitle",{attrs:{tokens:e.topic.fragments}}):t("WordBreak",{attrs:{tag:e.titleTag}},[e._v(e._s(e.topic.title))]),e.change?t("span",{staticClass:"visuallyhidden"},[e._v("- "+e._s(e.$t(e.changeName)))]):e._e()],1),e.hasAbstractElements?t("div",{staticClass:"abstract"},[e.topic.abstract?t("ContentNode",{attrs:{content:e.topic.abstract}}):e._e(),e.topic.ideTitle?t("div",{staticClass:"topic-keyinfo"},[e.topic.titleStyle===e.titleStyles.title?[t("strong",[e._v("Key:")]),e._v(" "+e._s(e.topic.name)+" ")]:e.topic.titleStyle===e.titleStyles.symbol?[t("strong",[e._v("Name:")]),e._v(" "+e._s(e.topic.ideTitle)+" ")]:e._e()],2):e._e(),e.topic.required||e.topic.defaultImplementations?t("RequirementMetadata",{staticClass:"topic-required",attrs:{defaultImplementationsCount:e.topic.defaultImplementations}}):e._e()],1):e._e(),e.showDeprecatedBadge?t("Badge",{attrs:{variant:"deprecated"}}):e.showBetaBadge?t("Badge",{attrs:{variant:"beta"}}):e._e(),e._l(e.tags,(function(n){return t("Badge",{key:`${n.type}-${n.text}`,attrs:{variant:n.type}},[e._v(" "+e._s(n.text)+" ")])}))],2)},a=[],i=n(7192),s=n(2449),o=n(6137),l=n(352),c=n(8846),d=n(7747),p=function(){var e=this,t=e._self._c;return t("code",{staticClass:"decorated-title"},[e._l(e.tokens,(function(n,r){return[t(e.componentFor(n),{key:r,tag:"component",class:[e.classFor(n),e.emptyTokenClass(n)]},[e._v(e._s(n.text))]),t("wbr",{key:`wbr-${r}`})]}))],2)},u=[],f=n(7913);const{TokenKind:m}=f["default"].constants,h={decorator:"decorator",identifier:"identifier",label:"label"};var g={name:"DecoratedTopicTitle",components:{WordBreak:l.Z},props:{tokens:{type:Array,required:!0,default:()=>[]}},constants:{TokenKind:m},methods:{emptyTokenClass:({text:e})=>({"empty-token":" "===e}),classFor({kind:e}){switch(e){case m.externalParam:case m.identifier:return h.identifier;case m.label:return h.label;default:return h.decorator}},componentFor(e){return/^\s+$/.test(e.text)?"span":l.Z}}},k=g,y=n(1001),v=(0,y.Z)(k,p,u,!1,null,"17c84f82",null),b=v.exports,_=n(7120),C=n(1842),x=n(5953);const Z={article:"article",symbol:"symbol"},B={title:"title",symbol:"symbol"},T={link:"link"};var S={name:"TopicsLinkBlock",components:{Badge:o.Z,WordBreak:l.Z,ContentNode:c.Z,TopicLinkBlockIcon:d.Z,DecoratedTopicTitle:b,RequirementMetadata:_.Z},mixins:[C.JY,C.PH,x.Z],constants:{ReferenceType:T,TopicKind:Z,TitleStyles:B},props:{isSymbolBeta:Boolean,isSymbolDeprecated:Boolean,topic:{type:Object,required:!0,validator:e=>(!("abstract"in e)||Array.isArray(e.abstract))&&"string"===typeof e.identifier&&(e.type===T.link&&!e.kind||"string"===typeof e.kind)&&(e.type===T.link&&!e.role||"string"===typeof e.role)&&"string"===typeof e.title&&"string"===typeof e.url&&(!("defaultImplementations"in e)||"number"===typeof e.defaultImplementations)&&(!("required"in e)||"boolean"===typeof e.required)}},data(){return{state:this.store.state}},computed:{linkComponent:({topic:e})=>e.type===T.link?"a":"router-link",linkProps({topic:e}){const t=(0,s.Q2)(e.url,this.$route.query);return e.type===T.link?{href:t}:{to:t}},linkBlockClasses:({changesClasses:e,hasAbstractElements:t,displaysMultipleLinesAfterAPIChanges:n,multipleLinesClass:r})=>({"has-inline-element":!t,[r]:n,...!t&&e}),linkClasses:({changesClasses:e,deprecated:t,hasAbstractElements:n})=>({deprecated:t,"has-adjacent-elements":n,...n&&e}),changesClasses:({getChangesClasses:e,change:t})=>e(t),titleTag({topic:e}){if(e.titleStyle===B.title)return e.ideTitle?"span":"code";if(e.role&&(e.role===i.L.collection||e.role===i.L.dictionarySymbol))return"span";switch(e.kind){case Z.symbol:return"code";default:return"span"}},titleStyles:()=>B,deprecated:({showDeprecatedBadge:e,topic:t})=>e||t.deprecated,showBetaBadge:({topic:e,isSymbolBeta:t})=>Boolean(!t&&e.beta),showDeprecatedBadge:({topic:e,isSymbolDeprecated:t})=>Boolean(!t&&e.deprecated),change({topic:{identifier:e},state:{apiChanges:t}}){return this.changeFor(e,t)},changeName:({change:e,getChangeName:t})=>t(e),hasAbstractElements:({topic:{abstract:e,required:t,defaultImplementations:n}}={})=>e&&e.length>0||t||n,tags:({topic:e})=>(e.tags||[]).slice(0,1),iconOverride:({topic:{images:e=[]}})=>{const t=e.find((({type:e})=>"icon"===e));return t?t.identifier:null}}},I=S,$=(0,y.Z)(I,r,a,!1,null,"0d9c6bcc",null),q=$.exports},4733:function(e,t,n){n.d(t,{_:function(){return r}});const r="displays-multiple-lines"},1842:function(e,t,n){n.d(t,{JY:function(){return c},PH:function(){return l}});var r=n(9426),a=n(4733),i=n(3112);const s="latest_",o={xcode:{value:"xcode",label:"Xcode"},other:{value:"other",label:"Other"}},l={constants:{multipleLinesClass:a._},data(){return{multipleLinesClass:a._}},computed:{displaysMultipleLinesAfterAPIChanges:({change:e,changeType:t,$refs:n})=>!(!e&&!t)&&(0,i.s)(n.apiChangesDiff)}},c={methods:{toVersionRange({platform:e,versions:t}){return`${e} ${t[0]} – ${e} ${t[1]}`},toOptionValue:e=>`${s}${e}`,toScope:e=>e.slice(s.length,e.length),getOptionsForDiffAvailability(e={}){return this.getOptionsForDiffAvailabilities([e])},getOptionsForDiffAvailabilities(e=[]){const t=e.reduce(((e,t={})=>Object.keys(t).reduce(((e,n)=>({...e,[n]:(e[n]||[]).concat(t[n])})),e)),{}),n=Object.keys(t),r=n.reduce(((e,n)=>{const r=t[n];return{...e,[n]:r.find((e=>e.platform===o.xcode.label))||r[0]}}),{}),a=e=>({label:this.toVersionRange(r[e]),value:this.toOptionValue(e),platform:r[e].platform}),{sdk:i,beta:s,minor:l,major:c,...d}=r,p=[].concat(i?a("sdk"):[]).concat(s?a("beta"):[]).concat(l?a("minor"):[]).concat(c?a("major"):[]).concat(Object.keys(d).map(a));return this.splitOptionsPerPlatform(p)},changesClassesFor(e,t){const n=this.changeFor(e,t);return this.getChangesClasses(n)},getChangesClasses:e=>({[`changed changed-${e}`]:!!e}),changeFor(e,t){const{change:n}=(t||{})[e]||{};return n},splitOptionsPerPlatform(e){return e.reduce(((e,t)=>{const n=t.platform===o.xcode.label?o.xcode.value:o.other.value;return e[n].push(t),e}),{[o.xcode.value]:[],[o.other.value]:[]})},getChangeName(e){return r.Ag[e]}},computed:{availableOptions({diffAvailability:e={},toOptionValue:t}){return new Set(Object.keys(e).map(t))}}}},3112:function(e,t,n){function r(e){if(!e)return!1;const t=window.getComputedStyle(e.$el||e),n=(e.$el||e).offsetHeight,r=t.lineHeight?parseFloat(t.lineHeight):1,a=t.paddingTop?parseFloat(t.paddingTop):0,i=t.paddingBottom?parseFloat(t.paddingBottom):0,s=t.borderTopWidth?parseFloat(t.borderTopWidth):0,o=t.borderBottomWidth?parseFloat(t.borderBottomWidth):0,l=n-(a+i+s+o),c=l/r;return c>=2}n.d(t,{s:function(){return r}})}}]);