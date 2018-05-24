Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4O6DCPK014611
 for <selinux@tycho.nsa.gov>; Thu, 24 May 2018 02:13:12 -0400
Received: by mail-qk0-f174.google.com with SMTP id s12-v6so381839qke.0
 for <selinux@tycho.nsa.gov>; Wed, 23 May 2018 23:12:47 -0700 (PDT)
MIME-Version: 1.0
Sender: coolway2sachin@gmail.com
From: Sachin Grover <sachin.grover91@gmail.com>
Date: Thu, 24 May 2018 11:42:29 +0530
Message-ID: <CA+rE-2iGWee1L3rEH-nmqZ7Uda_F3V5JwFKS=H7DgTguXHdSPQ@mail.gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary="0000000000004ff206056ced89ac"
Subject: [Bug][KASAN] crash in xattr_getsecurity()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--0000000000004ff206056ced89ac
Content-Type: text/plain; charset="UTF-8"

Hi,

Kernel panic is coming on calling lgetxattr() sys api with random user
space value.

[   25.833951] Call trace:
[   25.833954] [<ffffff86adc8af40>] dump_backtrace+0x0/0x2a8
[   25.833957] [<ffffff86adc8b484>] show_stack+0x20/0x28
[   25.833959] [<ffffff86ae02b744>] dump_stack+0xa8/0xe0
[   25.833962] [<ffffff86ade79ed0>] xattr_getsecurity+0xac/0xd4
[   25.833964] [<ffffff86ade79f90>] vfs_getxattr+0x98/0xcc
[   25.833966] [<ffffff86ade7a548>] getxattr+0x9c/0x1d4
[   25.833969] [<ffffff86ade7a6f4>] path_getxattr+0x74/0xc4
[   25.833971] [<ffffff86ade7afd8>] SyS_lgetxattr+0x3c/0x48
[   25.833973] [<ffffff86adc83770>] el0_svc_naked+0x24/0x28

setxattr() is getting size and value from the userspace, if I am giving
size as 64840, my code is entering this part and crashing on doing memcpy
under  xattr_getsecurity().

rc <http://opengrok.qualcomm.com/source/s?defs=rc&project=kernel_msm-4.9>
= string_to_context_struct(&policydb, &sidtab, scontext2,
				      scontext_len
<http://opengrok.qualcomm.com/source/s?defs=scontext_len&project=kernel_msm-4.9>,
&context <http://opengrok.qualcomm.com/source/s?defs=context&project=kernel_msm-4.9>,
def_sid <http://opengrok.qualcomm.com/source/s?defs=def_sid&project=kernel_msm-4.9>);
	*if* (rc <http://opengrok.qualcomm.com/source/s?defs=rc&project=kernel_msm-4.9>
== -EINVAL <http://opengrok.qualcomm.com/source/s?defs=EINVAL&project=kernel_msm-4.9>
&& force <http://opengrok.qualcomm.com/source/s?defs=force&project=kernel_msm-4.9>)
{
	context <http://opengrok.qualcomm.com/source/s?defs=context&project=kernel_msm-4.9>.str
= str;
	context <http://opengrok.qualcomm.com/source/s?defs=context&project=kernel_msm-4.9>.len
<http://opengrok.qualcomm.com/source/s?defs=len&project=kernel_msm-4.9>
= scontext_len <http://opengrok.qualcomm.com/source/s?defs=scontext_len&project=kernel_msm-4.9>;
		str = NULL <http://opengrok.qualcomm.com/source/s?defs=NULL&project=kernel_msm-4.9>;



//rc value is coming as EINVAL(-22). In pass case rc value is always 0.


Please let me know if this fix is good enough.


rc <http://opengrok.qualcomm.com/source/s?defs=rc&project=kernel_msm-4.9>
= string_to_context_struct(&policydb, &sidtab, scontext2,
				      scontext_len
<http://opengrok.qualcomm.com/source/s?defs=scontext_len&project=kernel_msm-4.9>,
&context <http://opengrok.qualcomm.com/source/s?defs=context&project=kernel_msm-4.9>,
def_sid <http://opengrok.qualcomm.com/source/s?defs=def_sid&project=kernel_msm-4.9>);
	*if* (rc <http://opengrok.qualcomm.com/source/s?defs=rc&project=kernel_msm-4.9>
== -EINVAL <http://opengrok.qualcomm.com/source/s?defs=EINVAL&project=kernel_msm-4.9>
&& force <http://opengrok.qualcomm.com/source/s?defs=force&project=kernel_msm-4.9>)
{
	context <http://opengrok.qualcomm.com/source/s?defs=context&project=kernel_msm-4.9>.str
= str;
-      context <http://opengrok.qualcomm.com/source/s?defs=context&project=kernel_msm-4.9>.len
<http://opengrok.qualcomm.com/source/s?defs=len&project=kernel_msm-4.9>
= scontext_len <http://opengrok.qualcomm.com/source/s?defs=scontext_len&project=kernel_msm-4.9>;

+      context.len = strlen(str);

		str = NULL <http://opengrok.qualcomm.com/source/s?defs=NULL&project=kernel_msm-4.9>;


Regards,

Sachin Grover

--0000000000004ff206056ced89ac
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>Kernel panic is coming o=
n calling lgetxattr() sys api with random user space value.</div><div><br><=
/div><div>[=C2=A0 =C2=A025.833951] Call trace:</div><div>[=C2=A0 =C2=A025.8=
33954] [&lt;ffffff86adc8af40&gt;] dump_backtrace+0x0/0x2a8</div><div>[=C2=
=A0 =C2=A025.833957] [&lt;ffffff86adc8b484&gt;] show_stack+0x20/0x28</div><=
div>[=C2=A0 =C2=A025.833959] [&lt;ffffff86ae02b744&gt;] dump_stack+0xa8/0xe=
0</div><div>[=C2=A0 =C2=A025.833962] [&lt;ffffff86ade79ed0&gt;] xattr_getse=
curity+0xac/0xd4</div><div>[=C2=A0 =C2=A025.833964] [&lt;ffffff86ade79f90&g=
t;] vfs_getxattr+0x98/0xcc</div><div>[=C2=A0 =C2=A025.833966] [&lt;ffffff86=
ade7a548&gt;] getxattr+0x9c/0x1d4</div><div>[=C2=A0 =C2=A025.833969] [&lt;f=
fffff86ade7a6f4&gt;] path_getxattr+0x74/0xc4</div><div>[=C2=A0 =C2=A025.833=
971] [&lt;ffffff86ade7afd8&gt;] SyS_lgetxattr+0x3c/0x48</div><div>[=C2=A0 =
=C2=A025.833973] [&lt;ffffff86adc83770&gt;] el0_svc_naked+0x24/0x28</div><d=
iv><br></div><div>setxattr() is getting size and value from the userspace, =
if I am giving size as 64840, my code is entering this part and crashing on=
 doing memcpy under=C2=A0

<span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:s=
mall;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norm=
al;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;t=
ext-transform:none;white-space:normal;word-spacing:0px;background-color:rgb=
(255,255,255);text-decoration-style:initial;text-decoration-color:initial;f=
loat:none;display:inline">xattr_getsecurity().</span></div><div><span style=
=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:small;font-s=
tyle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-wei=
ght:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial;float:none;d=
isplay:inline"><br></span></div><div><span style=3D"color:rgb(34,34,34);fon=
t-family:arial,sans-serif;font-size:small;font-style:normal;font-variant-li=
gatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norm=
al;text-align:start;text-indent:0px;text-transform:none;white-space:normal;=
word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:in=
itial;text-decoration-color:initial;float:none;display:inline">

<pre style=3D"border:0px;margin:0px;color:rgb(0,0,0);font-style:normal;font=
-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-s=
pacing:normal;text-align:start;text-indent:0px;text-transform:none;word-spa=
cing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;te=
xt-decoration-color:initial"><a href=3D"http://opengrok.qualcomm.com/source=
/s?defs=3Drc&amp;project=3Dkernel_msm-4.9" style=3D"text-decoration:none;co=
lor:rgb(32,32,98)">rc</a> =3D string_to_context_struct(&amp;policydb, &amp;=
sidtab, scontext2,
				      <a href=3D"http://opengrok.qualcomm.com/source/s?defs=3Dscontext_=
len&amp;project=3Dkernel_msm-4.9" style=3D"text-decoration:none;color:rgb(3=
2,32,98)">scontext_len</a>, &amp;<a href=3D"http://opengrok.qualcomm.com/so=
urce/s?defs=3Dcontext&amp;project=3Dkernel_msm-4.9" style=3D"text-decoratio=
n:none;color:rgb(32,32,98)">context</a>, <a href=3D"http://opengrok.qualcom=
m.com/source/s?defs=3Ddef_sid&amp;project=3Dkernel_msm-4.9" style=3D"text-d=
ecoration:none;color:rgb(32,32,98)">def_sid</a>);
	<b>if</b> (<a href=3D"http://opengrok.qualcomm.com/source/s?defs=3Drc&amp;=
project=3Dkernel_msm-4.9" style=3D"text-decoration:none;color:rgb(32,32,98)=
">rc</a> =3D=3D -<a href=3D"http://opengrok.qualcomm.com/source/s?defs=3DEI=
NVAL&amp;project=3Dkernel_msm-4.9" style=3D"text-decoration:none;color:rgb(=
32,32,98)">EINVAL</a> &amp;&amp; <a href=3D"http://opengrok.qualcomm.com/so=
urce/s?defs=3Dforce&amp;project=3Dkernel_msm-4.9" style=3D"text-decoration:=
none;color:rgb(32,32,98)">force</a>) {
	<a href=3D"http://opengrok.qualcomm.com/source/s?defs=3Dcontext&amp;projec=
t=3Dkernel_msm-4.9" style=3D"text-decoration:none;color:rgb(32,32,98)">cont=
ext</a>.str =3D str;
	<a href=3D"http://opengrok.qualcomm.com/source/s?defs=3Dcontext&amp;projec=
t=3Dkernel_msm-4.9" style=3D"text-decoration:none;color:rgb(32,32,98)">cont=
ext</a>.<a href=3D"http://opengrok.qualcomm.com/source/s?defs=3Dlen&amp;pro=
ject=3Dkernel_msm-4.9" style=3D"text-decoration:none;color:rgb(32,32,98)">l=
en</a> =3D <a href=3D"http://opengrok.qualcomm.com/source/s?defs=3Dscontext=
_len&amp;project=3Dkernel_msm-4.9" style=3D"text-decoration:none;color:rgb(=
32,32,98)">scontext_len</a>;
		str =3D <a href=3D"http://opengrok.qualcomm.com/source/s?defs=3DNULL&amp;=
project=3Dkernel_msm-4.9" style=3D"text-decoration:none;color:rgb(32,32,98)=
">NULL</a>;</pre><pre style=3D"border:0px;margin:0px;color:rgb(0,0,0);font-=
style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-we=
ight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transf=
orm:none;word-spacing:0px;background-color:rgb(255,255,255);text-decoration=
-style:initial;text-decoration-color:initial"><br></pre><pre style=3D"borde=
r:0px;margin:0px;color:rgb(0,0,0);font-style:normal;font-variant-ligatures:=
normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-=
align:start;text-indent:0px;text-transform:none;word-spacing:0px;background=
-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color=
:initial"><br></pre><pre style=3D"border:0px;margin:0px;color:rgb(0,0,0);fo=
nt-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font=
-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tra=
nsform:none;word-spacing:0px;background-color:rgb(255,255,255);text-decorat=
ion-style:initial;text-decoration-color:initial">//rc value is coming as EI=
NVAL(-22). In pass case rc value is always 0.</pre><pre style=3D"border:0px=
;margin:0px;color:rgb(0,0,0);font-style:normal;font-variant-ligatures:norma=
l;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align=
:start;text-indent:0px;text-transform:none;word-spacing:0px;background-colo=
r:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:init=
ial"><br></pre><pre style=3D"border:0px;margin:0px;color:rgb(0,0,0);font-st=
yle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weig=
ht:400;letter-spacing:normal;text-align:start;text-indent:0px;text-transfor=
m:none;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-s=
tyle:initial;text-decoration-color:initial">Please let me know if this fix =
is good enough.</pre><pre style=3D"border:0px;margin:0px;color:rgb(0,0,0);f=
ont-style:normal;font-variant-ligatures:normal;font-variant-caps:normal;fon=
t-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;text-tr=
ansform:none;word-spacing:0px;background-color:rgb(255,255,255);text-decora=
tion-style:initial;text-decoration-color:initial"><br></pre><pre style=3D"b=
order:0px;margin:0px;color:rgb(0,0,0);font-style:normal;font-variant-ligatu=
res:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;t=
ext-align:start;text-indent:0px;text-transform:none;word-spacing:0px;backgr=
ound-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-c=
olor:initial">
<pre style=3D"font-style:normal;font-variant-ligatures:normal;font-variant-=
caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-ind=
ent:0px;text-transform:none;word-spacing:0px;background-color:rgb(255,255,2=
55);text-decoration-style:initial;text-decoration-color:initial;border:0px;=
margin:0px;color:rgb(0,0,0)"><a href=3D"http://opengrok.qualcomm.com/source=
/s?defs=3Drc&amp;project=3Dkernel_msm-4.9" style=3D"color:rgb(32,32,98);tex=
t-decoration:none">rc</a> =3D string_to_context_struct(&amp;policydb, &amp;=
sidtab, scontext2,
				      <a href=3D"http://opengrok.qualcomm.com/source/s?defs=3Dscontext_=
len&amp;project=3Dkernel_msm-4.9" style=3D"color:rgb(32,32,98);text-decorat=
ion:none">scontext_len</a>, &amp;<a href=3D"http://opengrok.qualcomm.com/so=
urce/s?defs=3Dcontext&amp;project=3Dkernel_msm-4.9" style=3D"color:rgb(32,3=
2,98);text-decoration:none">context</a>, <a href=3D"http://opengrok.qualcom=
m.com/source/s?defs=3Ddef_sid&amp;project=3Dkernel_msm-4.9" style=3D"color:=
rgb(32,32,98);text-decoration:none">def_sid</a>);
	<b>if</b> (<a href=3D"http://opengrok.qualcomm.com/source/s?defs=3Drc&amp;=
project=3Dkernel_msm-4.9" style=3D"color:rgb(32,32,98);text-decoration:none=
">rc</a> =3D=3D -<a href=3D"http://opengrok.qualcomm.com/source/s?defs=3DEI=
NVAL&amp;project=3Dkernel_msm-4.9" style=3D"color:rgb(32,32,98);text-decora=
tion:none">EINVAL</a> &amp;&amp; <a href=3D"http://opengrok.qualcomm.com/so=
urce/s?defs=3Dforce&amp;project=3Dkernel_msm-4.9" style=3D"color:rgb(32,32,=
98);text-decoration:none">force</a>) {
	<a href=3D"http://opengrok.qualcomm.com/source/s?defs=3Dcontext&amp;projec=
t=3Dkernel_msm-4.9" style=3D"color:rgb(32,32,98);text-decoration:none">cont=
ext</a>.str =3D str;
-      <a href=3D"http://opengrok.qualcomm.com/source/s?defs=3Dcontext&amp;=
project=3Dkernel_msm-4.9" style=3D"color:rgb(32,32,98);text-decoration:none=
">context</a>.<a href=3D"http://opengrok.qualcomm.com/source/s?defs=3Dlen&a=
mp;project=3Dkernel_msm-4.9" style=3D"color:rgb(32,32,98);text-decoration:n=
one">len</a> =3D <a href=3D"http://opengrok.qualcomm.com/source/s?defs=3Dsc=
ontext_len&amp;project=3Dkernel_msm-4.9" style=3D"color:rgb(32,32,98);text-=
decoration:none">scontext_len</a>;</pre><pre style=3D"font-style:normal;fon=
t-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-align:start;text-indent:0px;text-transform:none;word-sp=
acing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;t=
ext-decoration-color:initial;border:0px;margin:0px;color:rgb(0,0,0)">+     =
 context.len =3D strlen(str);<br></pre><pre style=3D"font-style:normal;font=
-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-s=
pacing:normal;text-align:start;text-indent:0px;text-transform:none;word-spa=
cing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;te=
xt-decoration-color:initial;border:0px;margin:0px;color:rgb(0,0,0)">		str =
=3D <a href=3D"http://opengrok.qualcomm.com/source/s?defs=3DNULL&amp;projec=
t=3Dkernel_msm-4.9" style=3D"color:rgb(32,32,98);text-decoration:none">NULL=
</a>;</pre>

<br></pre><pre style=3D"border:0px;margin:0px;color:rgb(0,0,0);font-style:n=
ormal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:40=
0;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:non=
e;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:=
initial;text-decoration-color:initial">Regards,</pre><pre style=3D"border:0=
px;margin:0px;color:rgb(0,0,0);font-style:normal;font-variant-ligatures:nor=
mal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-ali=
gn:start;text-indent:0px;text-transform:none;word-spacing:0px;background-co=
lor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:in=
itial">Sachin Grover</pre>

<br></span></div></div>

--0000000000004ff206056ced89ac--
