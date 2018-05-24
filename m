MIME-Version: 1.0
Sender: coolway2sachin@gmail.com
In-Reply-To: <CA+rE-2iGWee1L3rEH-nmqZ7Uda_F3V5JwFKS=H7DgTguXHdSPQ@mail.gmail.com>
References: <CA+rE-2iGWee1L3rEH-nmqZ7Uda_F3V5JwFKS=H7DgTguXHdSPQ@mail.gmail.com>
From: Sachin Grover <sachin.grover91@gmail.com>
Date: Thu, 24 May 2018 16:36:44 +0530
Message-ID: <CA+rE-2gMF=S7Y7Zmwb=UkEg_4GAd6yueSbxECGdz9+ptCQNZ_Q@mail.gmail.com>
To: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Content-Type: multipart/alternative; boundary="0000000000009b8b09056cf1a5e2"
Subject: Re: [Bug][KASAN] crash in xattr_getsecurity()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--0000000000009b8b09056cf1a5e2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

To clarify more, data and size both are coming from userspace, so I sent a
string in void * __user arg of  lgetxattr(). My string format is -
"abcdef/0ashasalksjas"
i.e. I sent a string with null character in between.
I sent size as 64840.
 Now according to your change:

context.str =3D str;               //context.str=3D "abcdef/0ashasalksjas"
context.len <http://opengrok.qualcomm.com/source/s?defs=3Dlen&project=3Dker=
nel_msm-4.9>
=3D scontext_len;      //context.len
<http://opengrok.qualcomm.com/source/s?defs=3Dlen&project=3Dkernel_msm-4.9>
=3D 64840


But the actual length of string was 6. Because of not taking the
actual length into consideration, memcpy function is failing in
xattr_getsecurity() func.


I am not the expert in selinux stack so want your input on this.




On Thu, May 24, 2018 at 11:42 AM, Sachin Grover <sachin.grover91@gmail.com>
wrote:

> Hi,
>
> Kernel panic is coming on calling lgetxattr() sys api with random user
> space value.
>
> [   25.833951] Call trace:
> [   25.833954] [<ffffff86adc8af40>] dump_backtrace+0x0/0x2a8
> [   25.833957] [<ffffff86adc8b484>] show_stack+0x20/0x28
> [   25.833959] [<ffffff86ae02b744>] dump_stack+0xa8/0xe0
> [   25.833962] [<ffffff86ade79ed0>] xattr_getsecurity+0xac/0xd4
> [   25.833964] [<ffffff86ade79f90>] vfs_getxattr+0x98/0xcc
> [   25.833966] [<ffffff86ade7a548>] getxattr+0x9c/0x1d4
> [   25.833969] [<ffffff86ade7a6f4>] path_getxattr+0x74/0xc4
> [   25.833971] [<ffffff86ade7afd8>] SyS_lgetxattr+0x3c/0x48
> [   25.833973] [<ffffff86adc83770>] el0_svc_naked+0x24/0x28
>
> setxattr() is getting size and value from the userspace, if I am giving
> size as 64840, my code is entering this part and crashing on doing memcpy
> under  xattr_getsecurity().
>
> rc <http://opengrok.qualcomm.com/source/s?defs=3Drc&project=3Dkernel_msm-=
4.9> =3D string_to_context_struct(&policydb, &sidtab, scontext2,
> 				      scontext_len <http://opengrok.qualcomm.com/source/s?defs=3Dscon=
text_len&project=3Dkernel_msm-4.9>, &context <http://opengrok.qualcomm.com/=
source/s?defs=3Dcontext&project=3Dkernel_msm-4.9>, def_sid <http://opengrok=
.qualcomm.com/source/s?defs=3Ddef_sid&project=3Dkernel_msm-4.9>);
> 	*if* (rc <http://opengrok.qualcomm.com/source/s?defs=3Drc&project=3Dkern=
el_msm-4.9> =3D=3D -EINVAL <http://opengrok.qualcomm.com/source/s?defs=3DEI=
NVAL&project=3Dkernel_msm-4.9> && force <http://opengrok.qualcomm.com/sourc=
e/s?defs=3Dforce&project=3Dkernel_msm-4.9>) {
> 	context <http://opengrok.qualcomm.com/source/s?defs=3Dcontext&project=3D=
kernel_msm-4.9>.str =3D str;
> 	context <http://opengrok.qualcomm.com/source/s?defs=3Dcontext&project=3D=
kernel_msm-4.9>.len <http://opengrok.qualcomm.com/source/s?defs=3Dlen&proje=
ct=3Dkernel_msm-4.9> =3D scontext_len <http://opengrok.qualcomm.com/source/=
s?defs=3Dscontext_len&project=3Dkernel_msm-4.9>;
> 		str =3D NULL <http://opengrok.qualcomm.com/source/s?defs=3DNULL&project=
=3Dkernel_msm-4.9>;
>
>
>
> //rc value is coming as EINVAL(-22). In pass case rc value is always 0.
>
>
> Please let me know if this fix is good enough.
>
>
> rc <http://opengrok.qualcomm.com/source/s?defs=3Drc&project=3Dkernel_msm-=
4.9> =3D string_to_context_struct(&policydb, &sidtab, scontext2,
> 				      scontext_len <http://opengrok.qualcomm.com/source/s?defs=3Dscon=
text_len&project=3Dkernel_msm-4.9>, &context <http://opengrok.qualcomm.com/=
source/s?defs=3Dcontext&project=3Dkernel_msm-4.9>, def_sid <http://opengrok=
.qualcomm.com/source/s?defs=3Ddef_sid&project=3Dkernel_msm-4.9>);
> 	*if* (rc <http://opengrok.qualcomm.com/source/s?defs=3Drc&project=3Dkern=
el_msm-4.9> =3D=3D -EINVAL <http://opengrok.qualcomm.com/source/s?defs=3DEI=
NVAL&project=3Dkernel_msm-4.9> && force <http://opengrok.qualcomm.com/sourc=
e/s?defs=3Dforce&project=3Dkernel_msm-4.9>) {
> 	context <http://opengrok.qualcomm.com/source/s?defs=3Dcontext&project=3D=
kernel_msm-4.9>.str =3D str;
> -      context <http://opengrok.qualcomm.com/source/s?defs=3Dcontext&proj=
ect=3Dkernel_msm-4.9>.len <http://opengrok.qualcomm.com/source/s?defs=3Dlen=
&project=3Dkernel_msm-4.9> =3D scontext_len <http://opengrok.qualcomm.com/s=
ource/s?defs=3Dscontext_len&project=3Dkernel_msm-4.9>;
>
> +      context.len =3D strlen(str);
>
> 		str =3D NULL <http://opengrok.qualcomm.com/source/s?defs=3DNULL&project=
=3Dkernel_msm-4.9>;
>
>
> Regards,
>
> Sachin Grover
>
>
>

--0000000000009b8b09056cf1a5e2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">To clarify more, data and size both are coming from usersp=
ace, so I sent a string in void * __user arg of=C2=A0

<span style=3D"color:rgb(34,34,34);font-family:arial,sans-serif;font-size:1=
2.8px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:nor=
mal;font-weight:400;letter-spacing:normal;text-align:start;text-indent:0px;=
text-transform:none;white-space:normal;word-spacing:0px;background-color:rg=
b(255,255,255);text-decoration-style:initial;text-decoration-color:initial;=
float:none;display:inline">lgetxattr(). My string format is - &quot;abcdef/=
0ashasalksjas&quot;</span><div><span style=3D"font-size:12.8px">i.e. I sent=
 a string with null character in between.</span></div><div><span style=3D"f=
ont-size:12.8px">I sent size as 64840.</span></div><div><span style=3D"font=
-size:12.8px">=C2=A0Now according to your change:</span></div><div><span st=
yle=3D"font-size:12.8px">

<pre style=3D"white-space:pre-wrap;font-style:normal;font-variant-ligatures=
:normal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text=
-align:start;text-indent:0px;text-transform:none;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial;border:0px;margin:0px;color:rgb(0,0,0)">context.str =3D str;     =
          //context.str=3D <span style=3D"color:rgb(34,34,34);font-family:a=
rial,sans-serif;font-size:12.8px;font-style:normal;font-variant-ligatures:n=
ormal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-a=
lign:start;text-indent:0px;text-transform:none;white-space:normal;word-spac=
ing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;tex=
t-decoration-color:initial;float:none;display:inline">&quot;abcdef/0ashasal=
ksjas&quot;</span>
context.<a href=3D"http://opengrok.qualcomm.com/source/s?defs=3Dlen&amp;pro=
ject=3Dkernel_msm-4.9" target=3D"_blank" style=3D"color:rgb(32,32,98);text-=
decoration:none">len</a> =3D scontext_len;      //context<span style=3D"fon=
t-family:arial,sans-serif">.</span><a href=3D"http://opengrok.qualcomm.com/=
source/s?defs=3Dlen&amp;project=3Dkernel_msm-4.9" target=3D"_blank" style=
=3D"font-family:arial,sans-serif;color:rgb(32,32,98);text-decoration-line:n=
one">len</a> =3D 64840</pre><pre style=3D"white-space:pre-wrap;font-style:n=
ormal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:40=
0;letter-spacing:normal;text-align:start;text-indent:0px;text-transform:non=
e;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:=
initial;text-decoration-color:initial;border:0px;margin:0px;color:rgb(0,0,0=
)"><br></pre><pre style=3D"white-space:pre-wrap;font-style:normal;font-vari=
ant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacin=
g:normal;text-align:start;text-indent:0px;text-transform:none;word-spacing:=
0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-de=
coration-color:initial;border:0px;margin:0px;color:rgb(0,0,0)">But the actu=
al length of string was 6. Because of not taking the actual length into con=
sideration, memcpy function is failing in xattr_getsecurity() func.</pre><p=
re style=3D"white-space:pre-wrap;font-style:normal;font-variant-ligatures:n=
ormal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-a=
lign:start;text-indent:0px;text-transform:none;word-spacing:0px;background-=
color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:=
initial;border:0px;margin:0px;color:rgb(0,0,0)"><br></pre><pre style=3D"whi=
te-space:pre-wrap;font-style:normal;font-variant-ligatures:normal;font-vari=
ant-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text=
-indent:0px;text-transform:none;word-spacing:0px;background-color:rgb(255,2=
55,255);text-decoration-style:initial;text-decoration-color:initial;border:=
0px;margin:0px;color:rgb(0,0,0)">I am not the expert in selinux stack so wa=
nt your input on this.<br>

</pre>

<br></span></div><div><span style=3D"font-size:12.8px"><br></span></div></d=
iv><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, May 24=
, 2018 at 11:42 AM, Sachin Grover <span dir=3D"ltr">&lt;<a href=3D"mailto:s=
achin.grover91@gmail.com" target=3D"_blank">sachin.grover91@gmail.com</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div>Hi=
,</div><div><br></div><div>Kernel panic is coming on calling lgetxattr() sy=
s api with random user space value.</div><div><br></div><div>[=C2=A0 =C2=A0=
25.833951] Call trace:</div><div>[=C2=A0 =C2=A025.833954] [&lt;ffffff86adc8=
af40&gt;] dump_backtrace+0x0/0x2a8</div><div>[=C2=A0 =C2=A025.833957] [&lt;=
ffffff86adc8b484&gt;] show_stack+0x20/0x28</div><div>[=C2=A0 =C2=A025.83395=
9] [&lt;ffffff86ae02b744&gt;] dump_stack+0xa8/0xe0</div><div>[=C2=A0 =C2=A0=
25.833962] [&lt;ffffff86ade79ed0&gt;] xattr_getsecurity+0xac/0xd4</div><div=
>[=C2=A0 =C2=A025.833964] [&lt;ffffff86ade79f90&gt;] vfs_getxattr+0x98/0xcc=
</div><div>[=C2=A0 =C2=A025.833966] [&lt;ffffff86ade7a548&gt;] getxattr+0x9=
c/0x1d4</div><div>[=C2=A0 =C2=A025.833969] [&lt;ffffff86ade7a6f4&gt;] path_=
getxattr+0x74/0xc4</div><div>[=C2=A0 =C2=A025.833971] [&lt;ffffff86ade7afd8=
&gt;] SyS_lgetxattr+0x3c/0x48</div><div>[=C2=A0 =C2=A025.833973] [&lt;fffff=
f86adc83770&gt;] el0_svc_naked+0x24/0x28</div><div><br></div><div>setxattr(=
) is getting size and value from the userspace, if I am giving size as 6484=
0, my code is entering this part and crashing on doing memcpy under=C2=A0

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
lor:rgb(32,32,98)" target=3D"_blank">rc</a> =3D string_to_context_struct(&a=
mp;<wbr>policydb, &amp;sidtab, scontext2,
				      <a href=3D"http://opengrok.qualcomm.com/source/s?defs=3Dscontext_=
len&amp;project=3Dkernel_msm-4.9" style=3D"text-decoration:none;color:rgb(3=
2,32,98)" target=3D"_blank">scontext_len</a>, &amp;<a href=3D"http://opengr=
ok.qualcomm.com/source/s?defs=3Dcontext&amp;project=3Dkernel_msm-4.9" style=
=3D"text-decoration:none;color:rgb(32,32,98)" target=3D"_blank">context</a>=
, <a href=3D"http://opengrok.qualcomm.com/source/s?defs=3Ddef_sid&amp;proje=
ct=3Dkernel_msm-4.9" style=3D"text-decoration:none;color:rgb(32,32,98)" tar=
get=3D"_blank">def_sid</a>);
	<b>if</b> (<a href=3D"http://opengrok.qualcomm.com/source/s?defs=3Drc&amp;=
project=3Dkernel_msm-4.9" style=3D"text-decoration:none;color:rgb(32,32,98)=
" target=3D"_blank">rc</a> =3D=3D -<a href=3D"http://opengrok.qualcomm.com/=
source/s?defs=3DEINVAL&amp;project=3Dkernel_msm-4.9" style=3D"text-decorati=
on:none;color:rgb(32,32,98)" target=3D"_blank">EINVAL</a> &amp;&amp; <a hre=
f=3D"http://opengrok.qualcomm.com/source/s?defs=3Dforce&amp;project=3Dkerne=
l_msm-4.9" style=3D"text-decoration:none;color:rgb(32,32,98)" target=3D"_bl=
ank">force</a>) {
	<a href=3D"http://opengrok.qualcomm.com/source/s?defs=3Dcontext&amp;projec=
t=3Dkernel_msm-4.9" style=3D"text-decoration:none;color:rgb(32,32,98)" targ=
et=3D"_blank">context</a>.str =3D str;
	<a href=3D"http://opengrok.qualcomm.com/source/s?defs=3Dcontext&amp;projec=
t=3Dkernel_msm-4.9" style=3D"text-decoration:none;color:rgb(32,32,98)" targ=
et=3D"_blank">context</a>.<a href=3D"http://opengrok.qualcomm.com/source/s?=
defs=3Dlen&amp;project=3Dkernel_msm-4.9" style=3D"text-decoration:none;colo=
r:rgb(32,32,98)" target=3D"_blank">len</a> =3D <a href=3D"http://opengrok.q=
ualcomm.com/source/s?defs=3Dscontext_len&amp;project=3Dkernel_msm-4.9" styl=
e=3D"text-decoration:none;color:rgb(32,32,98)" target=3D"_blank">scontext_l=
en</a>;
		str =3D <a href=3D"http://opengrok.qualcomm.com/source/s?defs=3DNULL&amp;=
project=3Dkernel_msm-4.9" style=3D"text-decoration:none;color:rgb(32,32,98)=
" target=3D"_blank">NULL</a>;</pre><pre style=3D"border:0px;margin:0px;colo=
r:rgb(0,0,0);font-style:normal;font-variant-ligatures:normal;font-variant-c=
aps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-inde=
nt:0px;text-transform:none;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial"><br></pre><=
pre style=3D"border:0px;margin:0px;color:rgb(0,0,0);font-style:normal;font-=
variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-sp=
acing:normal;text-align:start;text-indent:0px;text-transform:none;word-spac=
ing:0px;background-color:rgb(255,255,255);text-decoration-style:initial;tex=
t-decoration-color:initial"><br></pre><pre style=3D"border:0px;margin:0px;c=
olor:rgb(0,0,0);font-style:normal;font-variant-ligatures:normal;font-varian=
t-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-i=
ndent:0px;text-transform:none;word-spacing:0px;background-color:rgb(255,255=
,255);text-decoration-style:initial;text-decoration-color:initial">//rc val=
ue is coming as EINVAL(-22). In pass case rc value is always 0.</pre><pre s=
tyle=3D"border:0px;margin:0px;color:rgb(0,0,0);font-style:normal;font-varia=
nt-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing=
:normal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0=
px;background-color:rgb(255,255,255);text-decoration-style:initial;text-dec=
oration-color:initial"><br></pre><pre style=3D"border:0px;margin:0px;color:=
rgb(0,0,0);font-style:normal;font-variant-ligatures:normal;font-variant-cap=
s:normal;font-weight:400;letter-spacing:normal;text-align:start;text-indent=
:0px;text-transform:none;word-spacing:0px;background-color:rgb(255,255,255)=
;text-decoration-style:initial;text-decoration-color:initial">Please let me=
 know if this fix is good enough.</pre><pre style=3D"border:0px;margin:0px;=
color:rgb(0,0,0);font-style:normal;font-variant-ligatures:normal;font-varia=
nt-caps:normal;font-weight:400;letter-spacing:normal;text-align:start;text-=
indent:0px;text-transform:none;word-spacing:0px;background-color:rgb(255,25=
5,255);text-decoration-style:initial;text-decoration-color:initial"><br></p=
re><pre style=3D"border:0px;margin:0px;color:rgb(0,0,0);font-style:normal;f=
ont-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lette=
r-spacing:normal;text-align:start;text-indent:0px;text-transform:none;word-=
spacing:0px;background-color:rgb(255,255,255);text-decoration-style:initial=
;text-decoration-color:initial"><pre style=3D"font-style:normal;font-varian=
t-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:=
normal;text-align:start;text-indent:0px;text-transform:none;word-spacing:0p=
x;background-color:rgb(255,255,255);text-decoration-style:initial;text-deco=
ration-color:initial;border:0px;margin:0px;color:rgb(0,0,0)"><a href=3D"htt=
p://opengrok.qualcomm.com/source/s?defs=3Drc&amp;project=3Dkernel_msm-4.9" =
style=3D"color:rgb(32,32,98);text-decoration:none" target=3D"_blank">rc</a>=
 =3D string_to_context_struct(&amp;<wbr>policydb, &amp;sidtab, scontext2,
				      <a href=3D"http://opengrok.qualcomm.com/source/s?defs=3Dscontext_=
len&amp;project=3Dkernel_msm-4.9" style=3D"color:rgb(32,32,98);text-decorat=
ion:none" target=3D"_blank">scontext_len</a>, &amp;<a href=3D"http://opengr=
ok.qualcomm.com/source/s?defs=3Dcontext&amp;project=3Dkernel_msm-4.9" style=
=3D"color:rgb(32,32,98);text-decoration:none" target=3D"_blank">context</a>=
, <a href=3D"http://opengrok.qualcomm.com/source/s?defs=3Ddef_sid&amp;proje=
ct=3Dkernel_msm-4.9" style=3D"color:rgb(32,32,98);text-decoration:none" tar=
get=3D"_blank">def_sid</a>);
	<b>if</b> (<a href=3D"http://opengrok.qualcomm.com/source/s?defs=3Drc&amp;=
project=3Dkernel_msm-4.9" style=3D"color:rgb(32,32,98);text-decoration:none=
" target=3D"_blank">rc</a> =3D=3D -<a href=3D"http://opengrok.qualcomm.com/=
source/s?defs=3DEINVAL&amp;project=3Dkernel_msm-4.9" style=3D"color:rgb(32,=
32,98);text-decoration:none" target=3D"_blank">EINVAL</a> &amp;&amp; <a hre=
f=3D"http://opengrok.qualcomm.com/source/s?defs=3Dforce&amp;project=3Dkerne=
l_msm-4.9" style=3D"color:rgb(32,32,98);text-decoration:none" target=3D"_bl=
ank">force</a>) {
	<a href=3D"http://opengrok.qualcomm.com/source/s?defs=3Dcontext&amp;projec=
t=3Dkernel_msm-4.9" style=3D"color:rgb(32,32,98);text-decoration:none" targ=
et=3D"_blank">context</a>.str =3D str;
-      <a href=3D"http://opengrok.qualcomm.com/source/s?defs=3Dcontext&amp;=
project=3Dkernel_msm-4.9" style=3D"color:rgb(32,32,98);text-decoration:none=
" target=3D"_blank">context</a>.<a href=3D"http://opengrok.qualcomm.com/sou=
rce/s?defs=3Dlen&amp;project=3Dkernel_msm-4.9" style=3D"color:rgb(32,32,98)=
;text-decoration:none" target=3D"_blank">len</a> =3D <a href=3D"http://open=
grok.qualcomm.com/source/s?defs=3Dscontext_len&amp;project=3Dkernel_msm-4.9=
" style=3D"color:rgb(32,32,98);text-decoration:none" target=3D"_blank">scon=
text_len</a>;</pre><pre style=3D"font-style:normal;font-variant-ligatures:n=
ormal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-a=
lign:start;text-indent:0px;text-transform:none;word-spacing:0px;background-=
color:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:=
initial;border:0px;margin:0px;color:rgb(0,0,0)">+      context.len =3D strl=
en(str);<br></pre><pre style=3D"font-style:normal;font-variant-ligatures:no=
rmal;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-al=
ign:start;text-indent:0px;text-transform:none;word-spacing:0px;background-c=
olor:rgb(255,255,255);text-decoration-style:initial;text-decoration-color:i=
nitial;border:0px;margin:0px;color:rgb(0,0,0)">		str =3D <a href=3D"http://=
opengrok.qualcomm.com/source/s?defs=3DNULL&amp;project=3Dkernel_msm-4.9" st=
yle=3D"color:rgb(32,32,98);text-decoration:none" target=3D"_blank">NULL</a>=
;</pre>

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
</blockquote></div><br></div>

--0000000000009b8b09056cf1a5e2--
