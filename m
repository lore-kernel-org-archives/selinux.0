Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s3D4X0TO008540
 for <selinux@tycho.nsa.gov>; Sun, 13 Apr 2014 00:33:00 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so6832247wgh.28
 for <selinux@tycho.nsa.gov>; Sat, 12 Apr 2014 21:32:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <39915653.12e6.14558fbb04d.Coremail.geshifei@126.com>
References: <39915653.12e6.14558fbb04d.Coremail.geshifei@126.com>
Date: Sat, 12 Apr 2014 21:32:58 -0700
Message-ID: <CAFftDdp62ODXRM114tCppwterddQqRJeE_ASPeNc4+7A-uqjzg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=2Fdata_used_as_two_filesystem_mountpoint=EF=BC=8Cthen_s?=
 =?UTF-8?Q?eandroid_how_to_lable_file_secontext=3F?=
From: William Roberts <bill.c.roberts@gmail.com>
To: ge <geshifei@126.com>
Content-Type: multipart/alternative; boundary=f46d043894cfbce93f04f6e50f51
Cc: "selinux@tycho nsa. gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--f46d043894cfbce93f04f6e50f51
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Context option on mount can be used...or via genfscon statements if
applicable
On Apr 12, 2014 7:53 PM, "ge" <geshifei@126.com> wrote:

> =EF=BB=BFhi=EF=BC=8Ceveryone.
> I meet with a problem(seandroid 4.4)=EF=BC=9AAs we know,/data was mounted
> as ext4 partition in original version. Additional I mount /data as a
> psuedo filesystme.
>
> the sepolicy of  external/sepolicy/fs_use is changed as follow:
> ...
> *fs_use_xattr ext4 u:object_r:labeledfs:s0;*
> ...
> *fs_use_trans psuedosystem u:object_r:* *psuedosystem* *:s0*
>
> I found that after power on mobile phone,every app is running ok,and
> secontext of files in /data(psuedo filesystem layer) is
> "*u:object_r:* *psuedosystem* *:s0*" , and  secontext of files
>  in /data(ext4 layer) is correct with sepolicy,such as
>  "u:object_r:app_data_file:s0".
>
> but when I install a new app,the secontext of app's dirs and files in
> ext4
> partition is inherited from app installed dir /data/data,sosecontext is
>  "u:object_r:system_data_file:s0",the right should be
> "u:object_r:app_data_file:s0".
>
> I think this problem maybe caused by :when mount /data on psuedo
> filesystem,the
> /data represent ext4 filesystem is hide.So set selinux xattr,kernel only
> can operate
> psuedo filesystem file.
>
> could someone tell me when install a new package ,how seandroid label
> package dir
> and files with external/sepolicy/fs_use above? If seandroid call
> systemcall "setxattr" to set
> selinux context, i will modify the psuedo file system not operate psuedo
> filesystem file
> but lower ext4 file in /data.
>
> thanks for your help.
>
>
>

--f46d043894cfbce93f04f6e50f51
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Context option on mount can be used...or via genfscon statem=
ents if applicable</p>
<div class=3D"gmail_quote">On Apr 12, 2014 7:53 PM, &quot;ge&quot; &lt;<a h=
ref=3D"mailto:geshifei@126.com">geshifei@126.com</a>&gt; wrote:<br type=3D"=
attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">
<div style=3D"line-height:1.7;font-size:14px;font-family:arial"><span style=
=3D"font-size:18px">=EF=BB=BFhi=EF=BC=8Ceveryone.</span><br><div><font size=
=3D"4"><span style=3D"line-height:30px">I meet with a problem(</span></font=
><span style=3D"font-size:large;line-height:30px">seandroid 4.4</span><font=
 size=3D"4">)=EF=BC=9AA</font><span style=3D"font-size:large;line-height:30=
px">s we know,/data was mounted=C2=A0</span></div>
<div><span style=3D"font-size:large;line-height:30px">as=C2=A0</span><span =
style=3D"font-size:large;line-height:30px">ext4 partition in original versi=
on. Additional=C2=A0</span><span style=3D"line-height:30px;font-size:large"=
>I mount /data as a=C2=A0</span></div>
<div><span style=3D"line-height:30px;font-size:large">psuedo filesystme.=C2=
=A0</span></div><div><br></div><div><span style=3D"font-family:&#39;Times N=
ew Roman&#39;;font-size:18px;line-height:26px">the sepolicy of =C2=A0extern=
al/sepolicy/fs_use is changed as follow:</span></div>
<div><span style=3D"font-family:&#39;Times New Roman&#39;;font-size:18px;li=
ne-height:26px">...</span></div><div><span style=3D"color:rgb(51,51,51);fon=
t-family:Arial;line-height:26px;background-color:rgb(240,247,254)"><b>fs_us=
e_xattr ext4 u:object_r:labeledfs:s0;</b></span>
</div><div><span style=3D"font-family:&#39;Times New Roman&#39;;font-size:1=
8px;line-height:26px">...</span>
</div><div><strong style=3D"color:rgb(51,51,51);font-family:Arial;line-heig=
ht:26px;background-color:rgb(240,247,254)">fs_use_trans psuedosystem u:obje=
ct_r:</strong>
<strong style=3D"color:rgb(51,51,51);font-family:Arial;line-height:26px;bac=
kground-color:rgb(240,247,254)">psuedosystem</strong>=C2=A0<strong style=3D=
"color:rgb(51,51,51);font-family:Arial;line-height:26px;background-color:rg=
b(240,247,254)">:s0</strong>
</div><div><strong style=3D"color:rgb(51,51,51);font-family:Arial;line-heig=
ht:26px;background-color:rgb(240,247,254)"><br></strong></div><div><font co=
lor=3D"#333333" face=3D"Arial"><span style=3D"line-height:26px;font-size:16=
px">I found that after power on mobile phone,every app is running ok,and =
=C2=A0</span></font></div>
<div><font color=3D"#333333" face=3D"Arial"><span style=3D"line-height:26px=
;font-size:16px">secontext=C2=A0</span></font><font color=3D"#333333" face=
=3D"Arial"><span style=3D"line-height:26px;font-size:16px">of files=C2=A0</=
span></font><font color=3D"#333333" face=3D"Arial"><span style=3D"line-heig=
ht:26px;font-size:16px">in /data(psuedo filesystem</span></font><span style=
=3D"font-size:16px;line-height:26px;color:rgb(51,51,51);font-family:Arial">=
=C2=A0layer) is=C2=A0</span></div>
<div><span style=3D"font-size:16px;line-height:26px;color:rgb(51,51,51);fon=
t-family:Arial">&quot;</span><strong style=3D"color:rgb(51,51,51);font-fami=
ly:Arial;line-height:26px;background-color:rgb(240,247,254)">u:object_r:</s=
trong>=C2=A0<strong style=3D"color:rgb(51,51,51);font-family:Arial;line-hei=
ght:26px;background-color:rgb(240,247,254)">psuedosystem</strong>=C2=A0<str=
ong style=3D"color:rgb(51,51,51);font-family:Arial;line-height:26px;backgro=
und-color:rgb(240,247,254)">:s0</strong><span style=3D"color:rgb(51,51,51);=
font-family:Arial;font-size:16px;line-height:26px">&quot; ,=C2=A0</span><sp=
an style=3D"color:rgb(51,51,51);font-family:Arial;font-size:16px;line-heigh=
t:26px">and =C2=A0</span><span style=3D"font-size:16px;line-height:26px;col=
or:rgb(51,51,51);font-family:Arial">secontext=C2=A0</span><font color=3D"#3=
33333" face=3D"Arial"><span style=3D"line-height:26px;font-size:16px">of fi=
les</span></font></div>
<div><font color=3D"#333333" face=3D"Arial"><span style=3D"line-height:26px=
;font-size:16px">=C2=A0</span></font><font color=3D"#333333" face=3D"Arial"=
><span style=3D"line-height:26px;font-size:16px">in /data(ext4 layer</span>=
</font><span style=3D"font-size:16px;line-height:26px;color:rgb(51,51,51);f=
ont-family:Arial">) is correct with sepolicy,</span><span style=3D"color:rg=
b(51,51,51);font-family:Arial;font-size:16px;line-height:26px">such as</spa=
n></div>
<div><span style=3D"color:rgb(51,51,51);font-family:Arial;font-size:16px;li=
ne-height:26px">=C2=A0&quot;u:object_r:app_data_file:s0&quot;.</span></div>=
<div><span style=3D"font-size:16px;line-height:26px;color:rgb(51,51,51);fon=
t-family:Arial"><br>
</span></div><div><span style=3D"font-size:16px;line-height:26px;color:rgb(=
51,51,51);font-family:Arial">but when I install a new app,the=C2=A0</span><=
span style=3D"color:rgb(51,51,51);font-family:Arial;font-size:16px;line-hei=
ght:26px">secontext of</span><span style=3D"color:rgb(51,51,51);font-family=
:Arial;font-size:16px;line-height:26px">=C2=A0</span><span style=3D"color:r=
gb(51,51,51);font-family:Arial;font-size:16px;line-height:26px">app&#39;s d=
irs and files in=C2=A0</span><span style=3D"color:rgb(51,51,51);font-family=
:Arial;font-size:16px;line-height:26px">ext4=C2=A0</span></div>
<div><span style=3D"color:rgb(51,51,51);font-family:Arial;font-size:16px;li=
ne-height:26px">partition</span><span style=3D"color:rgb(51,51,51);font-fam=
ily:Arial;font-size:16px;line-height:26px">=C2=A0</span><span style=3D"colo=
r:rgb(51,51,51);font-family:Arial;font-size:16px;line-height:26px">is=C2=A0=
</span><span style=3D"color:rgb(51,51,51);line-height:22px">inherited=C2=A0=
</span><span style=3D"color:rgb(51,51,51);line-height:22px">from app instal=
led dir /data/data,sosecontext is</span></div>
<div><span style=3D"color:rgb(51,51,51);line-height:22px">=C2=A0</span><spa=
n style=3D"color:rgb(51,51,51);font-family:Arial;font-size:16px;line-height=
:26px">&quot;u:object_r:system_data_file:s0&quot;,the right should be=C2=A0=
</span><span style=3D"color:rgb(51,51,51);font-family:Arial;font-size:16px;=
line-height:26px">&quot;u:object_r:app_data_file:s0&quot;.</span></div>
<div><span style=3D"color:rgb(51,51,51);font-family:Arial;font-size:16px;li=
ne-height:26px"><br></span></div><div><font color=3D"#333333" face=3D"Arial=
" size=3D"3"><span style=3D"line-height:26px">I think this problem maybe ca=
used by :when mount /data on psuedo filesystem,the</span></font></div>
<div><font color=3D"#333333" face=3D"Arial" size=3D"3"><span style=3D"line-=
height:26px">/data represent ext4 filesystem is hide.So set selinux xattr,k=
ernel only can operate=C2=A0</span></font></div><div><font color=3D"#333333=
" face=3D"Arial" size=3D"3"><span style=3D"line-height:26px">psuedo filesys=
tem file.</span></font></div>
<div><font color=3D"#333333" face=3D"Arial" size=3D"3"><span style=3D"line-=
height:26px"><br></span></font></div><div><font color=3D"#333333" face=3D"A=
rial" size=3D"3"><span style=3D"line-height:26px">could someone tell me whe=
n install a new package ,how seandroid label package dir=C2=A0</span></font=
></div>
<div><font color=3D"#333333" face=3D"Arial" size=3D"3"><span style=3D"line-=
height:26px">and files with=C2=A0</span></font><span style=3D"font-family:&=
#39;Times New Roman&#39;;font-size:18px;line-height:26px">external/sepolicy=
/fs_use above</span><span style=3D"line-height:26px;color:rgb(51,51,51);fon=
t-family:Arial;font-size:medium">? If seandroid call systemcall &quot;setxa=
ttr&quot; to set</span></div>
<div><span style=3D"line-height:26px;color:rgb(51,51,51);font-family:Arial;=
font-size:medium">selinux context, i will modify the psuedo file system not=
 operate psuedo filesystem file=C2=A0</span></div><div><span style=3D"line-=
height:26px;color:rgb(51,51,51);font-family:Arial;font-size:medium">but low=
er ext4 file in /data.</span></div>
<div><span style=3D"line-height:26px;color:rgb(51,51,51);font-family:Arial;=
font-size:medium"><br></span></div><div><font color=3D"#333333" face=3D"Ari=
al" size=3D"3"><span style=3D"line-height:26px">thanks for your help.</span=
></font></div>
</div><br><br><span title=3D"neteasefooter"><span></span></span></blockquot=
e></div>

--f46d043894cfbce93f04f6e50f51--
