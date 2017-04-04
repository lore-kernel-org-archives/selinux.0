Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v342CkWF008696
 for <selinux@tycho.nsa.gov>; Mon, 3 Apr 2017 22:12:46 -0400
Received: by mail-wr0-f173.google.com with SMTP id k6so188966491wre.2
 for <selinux@tycho.nsa.gov>; Mon, 03 Apr 2017 19:12:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdrVEKxgp69KrUrfyzD8hPuYOBtKgGhb_JWKCKrmd2PqhQ@mail.gmail.com>
References: <CAHFUiBOa186qydQ5VBeEmcMMinQnpkwBPMx91Aq-GAq4TvSm-g@mail.gmail.com>
 <CAFftDdrVEKxgp69KrUrfyzD8hPuYOBtKgGhb_JWKCKrmd2PqhQ@mail.gmail.com>
From: Rahmadi Trimananda <rtrimana@uci.edu>
Date: Mon, 3 Apr 2017 19:12:31 -0700
Message-ID: <CAHFUiBNnbdfvqneUo5dH4+4e_1Df6HrbmBGaQQ76SQpi6AXvBg@mail.gmail.com>
Subject: Re: Running Java and JVM on SELinux
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a1144332ef9f58b054c4dce5d
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1144332ef9f58b054c4dce5d
Content-Type: text/plain; charset=UTF-8

This is the result of "dmesg | grep avc". Please let me know if you need
more information about my system (RaspberryPi 2 running Raspbian Jessie).

[    2.275229] audit: type=1400 audit(2.249:3): avc:  denied  { associate }
for  pid=1 comm="systemd" name="pts" scontext=system_u:object_r:devpts_t:s0
tcontext=system_u:object_r:device_t:s0 tclass=filesystem permissive=1
[    2.577155] audit: type=1400 audit(2.549:4): avc:  denied  { wake_alarm
} for  pid=1 comm="systemd" capability=35
 scontext=system_u:system_r:init_t:s0 tcontext=system_u:system_r:init_t:s0
tclass=capability2 permissive=1
[    2.601211] audit: type=1400 audit(2.569:5): avc:  denied  { execstack }
for  pid=95 comm="systemd-fstab-g" scontext=system_u:system_r:init_t:s0
tcontext=system_u:system_r:init_t:s0 tclass=process permissive=1
[    2.601321] audit: type=1400 audit(2.569:6): avc:  denied  { execmem }
for  pid=95 comm="systemd-fstab-g" scontext=system_u:system_r:init_t:s0
tcontext=system_u:system_r:init_t:s0 tclass=process permissive=1
[    2.605393] audit: type=1400 audit(2.579:7): avc:  denied  { execmod }
for  pid=95 comm="systemd-fstab-g"
path="/usr/lib/arm-linux-gnueabihf/libarmmem.so" dev="mmcblk0p2" ino=144391
scontext=system_u:system_r:init_t:s0 tcontext=system_u:object_r:lib_t:s0
tclass=file permissive=1
[    3.201440] audit: type=1400 audit(3.169:8): avc:  denied  { execstack }
for  pid=107 comm="mount" scontext=system_u:system_r:mount_t:s0
tcontext=system_u:system_r:mount_t:s0 tclass=process permissive=1
[    3.201499] audit: type=1400 audit(3.169:9): avc:  denied  { execmem }
for  pid=107 comm="mount" scontext=system_u:system_r:mount_t:s0
tcontext=system_u:system_r:mount_t:s0 tclass=process permissive=1
[    3.217575] audit: type=1400 audit(3.189:10): avc:  denied  { execstack
} for  pid=108 comm="kmod" scontext=system_u:system_r:insmod_t:s0
tcontext=system_u:system_r:insmod_t:s0 tclass=process permissive=1
[    5.291711] audit: type=1400 audit(1491249900.889:59): avc:  denied  {
mmap_zero } for  pid=243 comm="alsactl"
scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
tcontext=system_u:system_r:alsa_t:s0-s0:c0.c1023 tclass=memprotect
permissive=1
[    5.304205] audit: type=1400 audit(1491249900.909:60): avc:  denied  {
execstack } for  pid=243 comm="alsactl"
scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
tcontext=system_u:system_r:alsa_t:s0-s0:c0.c1023 tclass=process permissive=1
[    5.304582] audit: type=1400 audit(1491249900.909:61): avc:  denied  {
execmem } for  pid=243 comm="alsactl"
scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
tcontext=system_u:system_r:alsa_t:s0-s0:c0.c1023 tclass=process permissive=1
[    5.306197] audit: type=1400 audit(1491249900.909:62): avc:  denied  {
use } for  pid=120 comm="systemd-journal" path="/dev/pts/0" dev="devpts"
ino=3 scontext=system_u:system_r:syslogd_t:s0
tcontext=system_u:system_r:plymouthd_t:s0 tclass=fd permissive=1
[    5.355105] audit: type=1400 audit(1491249900.959:63): avc:  denied  {
execmod } for  pid=243 comm="alsactl"
path="/usr/lib/arm-linux-gnueabihf/libarmmem.so" dev="mmcblk0p2" ino=144391
scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
tcontext=system_u:object_r:lib_t:s0 tclass=file permissive=1
[    5.357519] audit: type=1400 audit(1491249900.959:64): avc:  denied  {
write } for  pid=243 comm="alsactl" name="/" dev="tmpfs" ino=5104
scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
tcontext=system_u:object_r:var_lock_t:s0 tclass=dir permissive=1
[    5.357705] audit: type=1400 audit(1491249900.959:65): avc:  denied  {
add_name } for  pid=243 comm="alsactl" name="asound.state.lock"
scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
tcontext=system_u:object_r:var_lock_t:s0 tclass=dir permissive=1
[    5.358083] audit: type=1400 audit(1491249900.959:66): avc:  denied  {
create } for  pid=243 comm="alsactl" name="asound.state.lock"
scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
tcontext=system_u:object_r:var_lock_t:s0 tclass=file permissive=1
[    5.358671] audit: type=1400 audit(1491249900.959:67): avc:  denied  {
read write open } for  pid=243 comm="alsactl"
path="/run/lock/asound.state.lock" dev="tmpfs" ino=1816
scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
tcontext=system_u:object_r:var_lock_t:s0 tclass=file permissive=1
[    5.358893] audit: type=1400 audit(1491249900.959:68): avc:  denied  {
getattr } for  pid=243 comm="alsactl" path="/run/lock/asound.state.lock"
dev="tmpfs" ino=1816 scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
tcontext=system_u:object_r:var_lock_t:s0 tclass=file permissive=1

On Mon, Apr 3, 2017 at 6:54 PM, William Roberts <bill.c.roberts@gmail.com>
wrote:

> Do you see any "avc: denied" messages in dmesg/syslog? If so send them.
>
> On Apr 3, 2017 16:28, "Rahmadi Trimananda" <rtrimana@uci.edu> wrote:
>
>> Hi All,
>>
>> I am trying to run javac and java on my Raspbian while SELinux is
>> enabled. However, I keep getting "Segmentation fault", even when I just run
>> "javac" or "java". This happens in enforcing mode, but it doesn't happen
>> with "gcc". I am wondering why, because both are in /usr/bin directory and
>> both binaries have the same context.
>>
>> Can somebody please help?
>>
>> Thank you so much!
>>
>> Regards,
>> Rahmadi
>>
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.
>>
>


-- 
Kind regards,
Rahmadi Trimananda

Ph.D. student @ University of California, Irvine
"Stay hungry, stay foolish!" - Steve Jobs -

--001a1144332ef9f58b054c4dce5d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This is the result of &quot;dmesg | grep avc&quot;. Please=
 let me know if you need more information about my system (RaspberryPi 2 ru=
nning Raspbian Jessie).<div><br></div><div><div>[ =C2=A0 =C2=A02.275229] au=
dit: type=3D1400 audit(2.249:3): avc: =C2=A0denied =C2=A0{ associate } for =
=C2=A0pid=3D1 comm=3D&quot;systemd&quot; name=3D&quot;pts&quot; scontext=3D=
system_u:object_r:devpts_t:s0 tcontext=3Dsystem_u:object_r:device_t:s0 tcla=
ss=3Dfilesystem permissive=3D1</div><div>[ =C2=A0 =C2=A02.577155] audit: ty=
pe=3D1400 audit(2.549:4): avc: =C2=A0denied =C2=A0{ wake_alarm } for =C2=A0=
pid=3D1 comm=3D&quot;systemd&quot; capability=3D35 =C2=A0scontext=3Dsystem_=
u:system_r:init_t:s0 tcontext=3Dsystem_u:system_r:init_t:s0 tclass=3Dcapabi=
lity2 permissive=3D1</div><div>[ =C2=A0 =C2=A02.601211] audit: type=3D1400 =
audit(2.569:5): avc: =C2=A0denied =C2=A0{ execstack } for =C2=A0pid=3D95 co=
mm=3D&quot;systemd-fstab-g&quot; scontext=3Dsystem_u:system_r:init_t:s0 tco=
ntext=3Dsystem_u:system_r:init_t:s0 tclass=3Dprocess permissive=3D1</div><d=
iv>[ =C2=A0 =C2=A02.601321] audit: type=3D1400 audit(2.569:6): avc: =C2=A0d=
enied =C2=A0{ execmem } for =C2=A0pid=3D95 comm=3D&quot;systemd-fstab-g&quo=
t; scontext=3Dsystem_u:system_r:init_t:s0 tcontext=3Dsystem_u:system_r:init=
_t:s0 tclass=3Dprocess permissive=3D1</div><div>[ =C2=A0 =C2=A02.605393] au=
dit: type=3D1400 audit(2.579:7): avc: =C2=A0denied =C2=A0{ execmod } for =
=C2=A0pid=3D95 comm=3D&quot;systemd-fstab-g&quot; path=3D&quot;/usr/lib/arm=
-linux-gnueabihf/libarmmem.so&quot; dev=3D&quot;mmcblk0p2&quot; ino=3D14439=
1 scontext=3Dsystem_u:system_r:init_t:s0 tcontext=3Dsystem_u:object_r:lib_t=
:s0 tclass=3Dfile permissive=3D1</div><div>[ =C2=A0 =C2=A03.201440] audit: =
type=3D1400 audit(3.169:8): avc: =C2=A0denied =C2=A0{ execstack } for =C2=
=A0pid=3D107 comm=3D&quot;mount&quot; scontext=3Dsystem_u:system_r:mount_t:=
s0 tcontext=3Dsystem_u:system_r:mount_t:s0 tclass=3Dprocess permissive=3D1<=
/div><div>[ =C2=A0 =C2=A03.201499] audit: type=3D1400 audit(3.169:9): avc: =
=C2=A0denied =C2=A0{ execmem } for =C2=A0pid=3D107 comm=3D&quot;mount&quot;=
 scontext=3Dsystem_u:system_r:mount_t:s0 tcontext=3Dsystem_u:system_r:mount=
_t:s0 tclass=3Dprocess permissive=3D1</div><div>[ =C2=A0 =C2=A03.217575] au=
dit: type=3D1400 audit(3.189:10): avc: =C2=A0denied =C2=A0{ execstack } for=
 =C2=A0pid=3D108 comm=3D&quot;kmod&quot; scontext=3Dsystem_u:system_r:insmo=
d_t:s0 tcontext=3Dsystem_u:system_r:insmod_t:s0 tclass=3Dprocess permissive=
=3D1</div><div>[ =C2=A0 =C2=A05.291711] audit: type=3D1400 audit(1491249900=
.889:59): avc: =C2=A0denied =C2=A0{ mmap_zero } for =C2=A0pid=3D243 comm=3D=
&quot;alsactl&quot; scontext=3Dsystem_u:system_r:alsa_t:s0-s0:c0.c1023 tcon=
text=3Dsystem_u:system_r:alsa_t:s0-s0:c0.c1023 tclass=3Dmemprotect permissi=
ve=3D1</div><div>[ =C2=A0 =C2=A05.304205] audit: type=3D1400 audit(14912499=
00.909:60): avc: =C2=A0denied =C2=A0{ execstack } for =C2=A0pid=3D243 comm=
=3D&quot;alsactl&quot; scontext=3Dsystem_u:system_r:alsa_t:s0-s0:c0.c1023 t=
context=3Dsystem_u:system_r:alsa_t:s0-s0:c0.c1023 tclass=3Dprocess permissi=
ve=3D1</div><div>[ =C2=A0 =C2=A05.304582] audit: type=3D1400 audit(14912499=
00.909:61): avc: =C2=A0denied =C2=A0{ execmem } for =C2=A0pid=3D243 comm=3D=
&quot;alsactl&quot; scontext=3Dsystem_u:system_r:alsa_t:s0-s0:c0.c1023 tcon=
text=3Dsystem_u:system_r:alsa_t:s0-s0:c0.c1023 tclass=3Dprocess permissive=
=3D1</div><div>[ =C2=A0 =C2=A05.306197] audit: type=3D1400 audit(1491249900=
.909:62): avc: =C2=A0denied =C2=A0{ use } for =C2=A0pid=3D120 comm=3D&quot;=
systemd-journal&quot; path=3D&quot;/dev/pts/0&quot; dev=3D&quot;devpts&quot=
; ino=3D3 scontext=3Dsystem_u:system_r:syslogd_t:s0 tcontext=3Dsystem_u:sys=
tem_r:plymouthd_t:s0 tclass=3Dfd permissive=3D1</div><div>[ =C2=A0 =C2=A05.=
355105] audit: type=3D1400 audit(1491249900.959:63): avc: =C2=A0denied =C2=
=A0{ execmod } for =C2=A0pid=3D243 comm=3D&quot;alsactl&quot; path=3D&quot;=
/usr/lib/arm-linux-gnueabihf/libarmmem.so&quot; dev=3D&quot;mmcblk0p2&quot;=
 ino=3D144391 scontext=3Dsystem_u:system_r:alsa_t:s0-s0:c0.c1023 tcontext=
=3Dsystem_u:object_r:lib_t:s0 tclass=3Dfile permissive=3D1</div><div>[ =C2=
=A0 =C2=A05.357519] audit: type=3D1400 audit(1491249900.959:64): avc: =C2=
=A0denied =C2=A0{ write } for =C2=A0pid=3D243 comm=3D&quot;alsactl&quot; na=
me=3D&quot;/&quot; dev=3D&quot;tmpfs&quot; ino=3D5104 scontext=3Dsystem_u:s=
ystem_r:alsa_t:s0-s0:c0.c1023 tcontext=3Dsystem_u:object_r:var_lock_t:s0 tc=
lass=3Ddir permissive=3D1</div><div>[ =C2=A0 =C2=A05.357705] audit: type=3D=
1400 audit(1491249900.959:65): avc: =C2=A0denied =C2=A0{ add_name } for =C2=
=A0pid=3D243 comm=3D&quot;alsactl&quot; name=3D&quot;asound.state.lock&quot=
; scontext=3Dsystem_u:system_r:alsa_t:s0-s0:c0.c1023 tcontext=3Dsystem_u:ob=
ject_r:var_lock_t:s0 tclass=3Ddir permissive=3D1</div><div>[ =C2=A0 =C2=A05=
.358083] audit: type=3D1400 audit(1491249900.959:66): avc: =C2=A0denied =C2=
=A0{ create } for =C2=A0pid=3D243 comm=3D&quot;alsactl&quot; name=3D&quot;a=
sound.state.lock&quot; scontext=3Dsystem_u:system_r:alsa_t:s0-s0:c0.c1023 t=
context=3Dsystem_u:object_r:var_lock_t:s0 tclass=3Dfile permissive=3D1</div=
><div>[ =C2=A0 =C2=A05.358671] audit: type=3D1400 audit(1491249900.959:67):=
 avc: =C2=A0denied =C2=A0{ read write open } for =C2=A0pid=3D243 comm=3D&qu=
ot;alsactl&quot; path=3D&quot;/run/lock/asound.state.lock&quot; dev=3D&quot=
;tmpfs&quot; ino=3D1816 scontext=3Dsystem_u:system_r:alsa_t:s0-s0:c0.c1023 =
tcontext=3Dsystem_u:object_r:var_lock_t:s0 tclass=3Dfile permissive=3D1</di=
v><div>[ =C2=A0 =C2=A05.358893] audit: type=3D1400 audit(1491249900.959:68)=
: avc: =C2=A0denied =C2=A0{ getattr } for =C2=A0pid=3D243 comm=3D&quot;alsa=
ctl&quot; path=3D&quot;/run/lock/asound.state.lock&quot; dev=3D&quot;tmpfs&=
quot; ino=3D1816 scontext=3Dsystem_u:system_r:alsa_t:s0-s0:c0.c1023 tcontex=
t=3Dsystem_u:object_r:var_lock_t:s0 tclass=3Dfile permissive=3D1</div></div=
></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Ap=
r 3, 2017 at 6:54 PM, William Roberts <span dir=3D"ltr">&lt;<a href=3D"mail=
to:bill.c.roberts@gmail.com" target=3D"_blank">bill.c.roberts@gmail.com</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"auto">Do y=
ou see any &quot;avc: denied&quot; messages in dmesg/syslog? If so send the=
m.</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote"><div><div=
 class=3D"h5">On Apr 3, 2017 16:28, &quot;Rahmadi Trimananda&quot; &lt;<a h=
ref=3D"mailto:rtrimana@uci.edu" target=3D"_blank">rtrimana@uci.edu</a>&gt; =
wrote:<br type=3D"attribution"></div></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><=
div><div class=3D"h5"><div dir=3D"ltr">Hi All,<div><br></div><div>I am tryi=
ng to run javac and java on my Raspbian while SELinux is enabled. However, =
I keep getting &quot;Segmentation fault&quot;, even when I just run &quot;j=
avac&quot; or &quot;java&quot;. This happens in enforcing mode, but it does=
n&#39;t happen with &quot;gcc&quot;. I am wondering why, because both are i=
n /usr/bin directory and both binaries have the same context.</div><div><br=
></div><div>Can somebody please help?</div><div><br></div><div>Thank you so=
 much!</div><div><br></div><div>Regards,</div><div>Rahmadi</div><div class=
=3D"gmail_extra"><br>
</div></div>
<br></div></div>______________________________<wbr>_________________<br>
Selinux mailing list<br>
<a href=3D"mailto:Selinux@tycho.nsa.gov" target=3D"_blank">Selinux@tycho.ns=
a.gov</a><br>
To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.nsa.gov=
" target=3D"_blank">Selinux-leave@tycho.nsa.gov</a>.<br>
To get help, send an email containing &quot;help&quot; to <a href=3D"mailto=
:Selinux-request@tycho.nsa.gov" target=3D"_blank">Selinux-request@tycho.nsa=
.gov</a>.<br></blockquote></div></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">Ki=
nd regards,<div>Rahmadi Trimananda</div><div><br></div><div>Ph.D. student @=
 University of California, Irvine</div><div>&quot;Stay hungry, stay foolish=
!&quot; - Steve Jobs -</div></div></div>
</div>

--001a1144332ef9f58b054c4dce5d--
