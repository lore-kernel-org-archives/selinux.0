Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t0D1P7Dj014859
 for <selinux@tycho.nsa.gov>; Mon, 12 Jan 2015 20:25:07 -0500
From: John Brooks <john.brooks@jolla.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH 3/3] Tweak avtab hash table parameters for better
 performance
Date: Tue, 13 Jan 2015 01:25:00 +0000
Message-ID: <A906E10A-6726-4208-993B-4D6AB21B202E@jolla.com>
References: <1420668221-52637-1-git-send-email-john.brooks@jolla.com>
 <1420668221-52637-4-git-send-email-john.brooks@jolla.com>
 <54B408A9.4020702@tycho.nsa.gov>
In-Reply-To: <54B408A9.4020702@tycho.nsa.gov>
Content-Type: multipart/alternative;
 boundary="_000_A906E10A67264208993B4D6AB21B202Ejollacom_"
MIME-Version: 1.0
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--_000_A906E10A67264208993B4D6AB21B202Ejollacom_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

On Jan 12, 2015, at 10:47 AM, Stephen Smalley <sds@tycho.nsa.gov<mailto:sds=
@tycho.nsa.gov>> wrote:

On 01/07/2015 05:03 PM, John Brooks wrote:
@@ -341,8 +341,6 @@ int avtab_alloc(avtab_t *h, uint32_t nrules)
work  =3D work >> 1;
shift++;
}
- if (shift > 2)
- shift =3D shift - 2;
nslot =3D 1 << shift;
if (nslot > MAX_AVTAB_SIZE)
nslot =3D MAX_AVTAB_SIZE;


tweakavtab.txt:rules:  101401 entries and 68460/131072 buckets used,
longest chain length 7

Seems like we're wasting a large number of buckets in that scenario.

Good catch. It looks like this is caused by the segment I highlighted above=
, removing the shift adjustment.

changed-nslot.txt:rules:  100967 entries and 68321/131072 buckets used, lon=
gest chain length 8
original-nslot.txt:rules:  100967 entries and 31017/32768 buckets used, lon=
gest chain length 13

So, one bucket is allocated per 2-4 elements. The change I actually wanted =
to make is to the definition of MAX_AVTAB_SIZE: it should be 2x MAX_AVTAB_H=
ASH_BUCKETS to allow allocating a hash with maximum buckets, and that nslot=
 bounding should use MAX_AVTAB_HASH_BUCKETS.


Also, in the corresponding kernel code (security/selinux/ss/avtab.[hc]),
we've actually shrunk the hash bits from 13 to 11,

Interesting. I wonder what the kernel hash eval looks like - it might benef=
it from a better hash function as well.


I've also considered reworking the libsepol check_assertions() code to
not expand the avtab in order to provide better traceback to the
original source allow rule that violated the neverallow.  This would
require more work by check_assertion_helper to check each attribute
associated with the source and target, just as with
context_struct_compute_av.

Yeah; I expect there is a lot of room for algorithmic improvement here. I w=
ish I had time to understand and fix it. We could probably get this running=
 on the order of seconds instead of minutes, and using _much_ less memory.

Even after these patches, expand_module spends 60% in avtab_search_node (an=
d 13% malloc_consolidate, the rest is trivial). Next step would be to reduc=
e the number of elements or lookups.

One interesting note: this fully expanded table is built twice under expand=
_module, for hierarchy_check_constraints and check_assertions. We could cut=
 runtime almost in half by reusing the table.

--_000_A906E10A67264208993B4D6AB21B202Ejollacom_
Content-Type: text/html; charset="Windows-1252"
Content-ID: <42917870E03F5946999910A0A5D5BF98@mex05.mlsrvr.com>
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-lin=
e-break: after-white-space;" class=3D"">
On Jan 12, 2015, at 10:47 AM, Stephen Smalley &lt;<a href=3D"mailto:sds@tyc=
ho.nsa.gov" class=3D"">sds@tycho.nsa.gov</a>&gt; wrote:<br class=3D"">
<div>
<blockquote type=3D"cite" class=3D""><br class=3D"Apple-interchange-newline=
">
<div class=3D""><span style=3D"font-family: Helvetica; font-size: 12px; fon=
t-style: normal; font-variant: normal; font-weight: normal; letter-spacing:=
 normal; line-height: normal; orphans: auto; text-align: start; text-indent=
: 0px; text-transform: none; white-space: normal; widows: auto; word-spacin=
g: 0px; -webkit-text-stroke-width: 0px; float: none; display: inline !impor=
tant;" class=3D"">On
 01/07/2015 05:03 PM, John Brooks wrote:</span><br style=3D"font-family: He=
lvetica; font-size: 12px; font-style: normal; font-variant: normal; font-we=
ight: normal; letter-spacing: normal; line-height: normal; orphans: auto; t=
ext-align: start; text-indent: 0px; text-transform: none; white-space: norm=
al; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" class=
=3D"">
<blockquote type=3D"cite" style=3D"font-family: Helvetica; font-size: 12px;=
 font-style: normal; font-variant: normal; font-weight: normal; letter-spac=
ing: normal; line-height: normal; orphans: auto; text-align: start; text-in=
dent: 0px; text-transform: none; white-space: normal; widows: auto; word-sp=
acing: 0px; -webkit-text-stroke-width: 0px;" class=3D"">
@@ -341,8 &#43;341,6 @@ int avtab_alloc(avtab_t *h, uint32_t nrules)<br cla=
ss=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span>work &nbsp;=3D wor=
k &gt;&gt; 1;<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span>shift&#43;&#43;;<b=
r class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>}<br clas=
s=3D"">
-<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span>if (shi=
ft &gt; 2)<br class=3D"">
-<span class=3D"Apple-tab-span" style=3D"white-space: pre;"> </span><span c=
lass=3D"Apple-tab-span" style=3D"white-space: pre;"></span>shift =3D shift =
- 2;<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>nslot =3D=
 1 &lt;&lt; shift;<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span>if (nslot=
 &gt; MAX_AVTAB_SIZE)<br class=3D"">
<span class=3D"Apple-tab-span" style=3D"white-space: pre;"></span><span cla=
ss=3D"Apple-tab-span" style=3D"white-space: pre;"></span>nslot =3D MAX_AVTA=
B_SIZE;<br class=3D"">
<br class=3D"">
</blockquote>
<br style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; f=
ont-variant: normal; font-weight: normal; letter-spacing: normal; line-heig=
ht: normal; orphans: auto; text-align: start; text-indent: 0px; text-transf=
orm: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-te=
xt-stroke-width: 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant: normal; font-weight: normal; letter-spacing: normal; line-he=
ight: normal; orphans: auto; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; float: none; display: inline !important;" class=3D"=
">tweakavtab.txt:rules:
 &nbsp;101401 entries and 68460/131072 buckets used,</span><br style=3D"fon=
t-family: Helvetica; font-size: 12px; font-style: normal; font-variant: nor=
mal; font-weight: normal; letter-spacing: normal; line-height: normal; orph=
ans: auto; text-align: start; text-indent: 0px; text-transform: none; white=
-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width:=
 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant: normal; font-weight: normal; letter-spacing: normal; line-he=
ight: normal; orphans: auto; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; float: none; display: inline !important;" class=3D"=
">longest
 chain length 7</span><br style=3D"font-family: Helvetica; font-size: 12px;=
 font-style: normal; font-variant: normal; font-weight: normal; letter-spac=
ing: normal; line-height: normal; orphans: auto; text-align: start; text-in=
dent: 0px; text-transform: none; white-space: normal; widows: auto; word-sp=
acing: 0px; -webkit-text-stroke-width: 0px;" class=3D"">
<br style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; f=
ont-variant: normal; font-weight: normal; letter-spacing: normal; line-heig=
ht: normal; orphans: auto; text-align: start; text-indent: 0px; text-transf=
orm: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-te=
xt-stroke-width: 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant: normal; font-weight: normal; letter-spacing: normal; line-he=
ight: normal; orphans: auto; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; float: none; display: inline !important;" class=3D"=
">Seems
 like we're wasting a large number of buckets in that scenario.</span><br s=
tyle=3D"font-family: Helvetica; font-size: 12px; font-style: normal; font-v=
ariant: normal; font-weight: normal; letter-spacing: normal; line-height: n=
ormal; orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-st=
roke-width: 0px;" class=3D"">
</div>
</blockquote>
<div><br class=3D"">
</div>
<div>Good catch. It looks like this is caused by the segment I highlighted =
above, removing the shift adjustment.</div>
<div><br class=3D"">
</div>
<div>changed-nslot.txt:rules: &nbsp;100967 entries and 68321/131072 buckets=
 used, longest chain length 8</div>
<div>original-nslot.txt:rules: &nbsp;100967 entries and 31017/32768 buckets=
 used, longest chain length 13</div>
<div><br class=3D"">
</div>
<div>So, one bucket is allocated per 2-4 elements. The change I actually wa=
nted to make is to the definition of MAX_AVTAB_SIZE: it should be 2x MAX_AV=
TAB_HASH_BUCKETS to allow allocating a hash with maximum buckets, and that =
nslot bounding should use MAX_AVTAB_HASH_BUCKETS.</div>
<br class=3D"">
<blockquote type=3D"cite" class=3D"">
<div class=3D""><br style=3D"font-family: Helvetica; font-size: 12px; font-=
style: normal; font-variant: normal; font-weight: normal; letter-spacing: n=
ormal; line-height: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; word-spacing:=
 0px; -webkit-text-stroke-width: 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant: normal; font-weight: normal; letter-spacing: normal; line-he=
ight: normal; orphans: auto; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; float: none; display: inline !important;" class=3D"=
">Also,
 in the corresponding kernel code (security/selinux/ss/avtab.[hc]),</span><=
br style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; fo=
nt-variant: normal; font-weight: normal; letter-spacing: normal; line-heigh=
t: normal; orphans: auto; text-align: start; text-indent: 0px; text-transfo=
rm: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-tex=
t-stroke-width: 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant: normal; font-weight: normal; letter-spacing: normal; line-he=
ight: normal; orphans: auto; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; float: none; display: inline !important;" class=3D"=
">we've
 actually shrunk the hash bits from 13 to 11,</span><br style=3D"font-famil=
y: Helvetica; font-size: 12px; font-style: normal; font-variant: normal; fo=
nt-weight: normal; letter-spacing: normal; line-height: normal; orphans: au=
to; text-align: start; text-indent: 0px; text-transform: none; white-space:=
 normal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" =
class=3D"">
</div>
</blockquote>
<div><br class=3D"">
</div>
<div>Interesting. I wonder what the kernel hash eval looks like - it might =
benefit from a better hash function as well.</div>
<br class=3D"">
<blockquote type=3D"cite" class=3D"">
<div class=3D""><br style=3D"font-family: Helvetica; font-size: 12px; font-=
style: normal; font-variant: normal; font-weight: normal; letter-spacing: n=
ormal; line-height: normal; orphans: auto; text-align: start; text-indent: =
0px; text-transform: none; white-space: normal; widows: auto; word-spacing:=
 0px; -webkit-text-stroke-width: 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant: normal; font-weight: normal; letter-spacing: normal; line-he=
ight: normal; orphans: auto; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; float: none; display: inline !important;" class=3D"=
">I've
 also considered reworking the libsepol check_assertions() code to</span><b=
r style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; fon=
t-variant: normal; font-weight: normal; letter-spacing: normal; line-height=
: normal; orphans: auto; text-align: start; text-indent: 0px; text-transfor=
m: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text=
-stroke-width: 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant: normal; font-weight: normal; letter-spacing: normal; line-he=
ight: normal; orphans: auto; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; float: none; display: inline !important;" class=3D"=
">not
 expand the avtab in order to provide better traceback to the</span><br sty=
le=3D"font-family: Helvetica; font-size: 12px; font-style: normal; font-var=
iant: normal; font-weight: normal; letter-spacing: normal; line-height: nor=
mal; orphans: auto; text-align: start; text-indent: 0px; text-transform: no=
ne; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-stro=
ke-width: 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant: normal; font-weight: normal; letter-spacing: normal; line-he=
ight: normal; orphans: auto; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; float: none; display: inline !important;" class=3D"=
">original
 source allow rule that violated the neverallow. &nbsp;This would</span><br=
 style=3D"font-family: Helvetica; font-size: 12px; font-style: normal; font=
-variant: normal; font-weight: normal; letter-spacing: normal; line-height:=
 normal; orphans: auto; text-align: start; text-indent: 0px; text-transform=
: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-=
stroke-width: 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant: normal; font-weight: normal; letter-spacing: normal; line-he=
ight: normal; orphans: auto; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; float: none; display: inline !important;" class=3D"=
">require
 more work by check_assertion_helper to check each attribute</span><br styl=
e=3D"font-family: Helvetica; font-size: 12px; font-style: normal; font-vari=
ant: normal; font-weight: normal; letter-spacing: normal; line-height: norm=
al; orphans: auto; text-align: start; text-indent: 0px; text-transform: non=
e; white-space: normal; widows: auto; word-spacing: 0px; -webkit-text-strok=
e-width: 0px;" class=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant: normal; font-weight: normal; letter-spacing: normal; line-he=
ight: normal; orphans: auto; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; float: none; display: inline !important;" class=3D"=
">associated
 with the source and target, just as with</span><br style=3D"font-family: H=
elvetica; font-size: 12px; font-style: normal; font-variant: normal; font-w=
eight: normal; letter-spacing: normal; line-height: normal; orphans: auto; =
text-align: start; text-indent: 0px; text-transform: none; white-space: nor=
mal; widows: auto; word-spacing: 0px; -webkit-text-stroke-width: 0px;" clas=
s=3D"">
<span style=3D"font-family: Helvetica; font-size: 12px; font-style: normal;=
 font-variant: normal; font-weight: normal; letter-spacing: normal; line-he=
ight: normal; orphans: auto; text-align: start; text-indent: 0px; text-tran=
sform: none; white-space: normal; widows: auto; word-spacing: 0px; -webkit-=
text-stroke-width: 0px; float: none; display: inline !important;" class=3D"=
">context_struct_compute_av.</span></div>
</blockquote>
</div>
<br class=3D"">
<div class=3D"">Yeah; I expect there is a lot of room for algorithmic impro=
vement here. I wish I had time to understand and fix it. We could probably =
get this running on the order of seconds instead of minutes, and using _muc=
h_ less memory.</div>
<div class=3D""><br class=3D"">
</div>
<div class=3D"">Even after these patches, expand_module spends 60% in avtab=
_search_node (and 13% malloc_consolidate, the rest is trivial). Next step w=
ould be to reduce the number of elements or lookups.</div>
<div class=3D""><br class=3D"">
</div>
<div class=3D"">One interesting note: this fully expanded table is built tw=
ice under expand_module, for&nbsp;hierarchy_check_constraints and&nbsp;chec=
k_assertions. We could cut runtime almost in half by reusing the table.</di=
v>
</body>
</html>

--_000_A906E10A67264208993B4D6AB21B202Ejollacom_--
