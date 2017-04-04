Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v34303Kq021254
 for <selinux@tycho.nsa.gov>; Mon, 3 Apr 2017 23:00:03 -0400
Received: by mail-oi0-f53.google.com with SMTP id f193so148598763oib.2
 for <selinux@tycho.nsa.gov>; Mon, 03 Apr 2017 19:59:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdor2dnN=gKPuDYrYaHxsvinx6Mszzjnq9+Cs049p+i0=g@mail.gmail.com>
References: <CAHFUiBOa186qydQ5VBeEmcMMinQnpkwBPMx91Aq-GAq4TvSm-g@mail.gmail.com>
 <CAFftDdrVEKxgp69KrUrfyzD8hPuYOBtKgGhb_JWKCKrmd2PqhQ@mail.gmail.com>
 <CAHFUiBNnbdfvqneUo5dH4+4e_1Df6HrbmBGaQQ76SQpi6AXvBg@mail.gmail.com>
 <CAFftDdpRxYsMHyDKmRtCswovHRgda1nW2ELUVVKPVtBrL9HL8Q@mail.gmail.com>
 <CAHFUiBO6wYvSURpf72Qy7z1TkMtPrEd6ajC8Ox-RFPBC3jj_ZA@mail.gmail.com>
 <CAFftDdor2dnN=gKPuDYrYaHxsvinx6Mszzjnq9+Cs049p+i0=g@mail.gmail.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Mon, 3 Apr 2017 19:59:57 -0700
Message-ID: <CAFftDdrY1H8q+Mcd8SFPZF-sY_EOVAodUi6te_psrCxnqWqguw@mail.gmail.com>
Subject: Re: Running Java and JVM on SELinux
To: Rahmadi Trimananda <rtrimana@uci.edu>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a113e586e9e4624054c4e7827
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113e586e9e4624054c4e7827
Content-Type: text/plain; charset=UTF-8

On Apr 3, 2017 19:57, "William Roberts" <bill.c.roberts@gmail.com> wrote:



On Apr 3, 2017 19:35, "Rahmadi Trimananda" <rtrimana@uci.edu> wrote:

I have more error messages from /var/log/audit/audit.log if this is of any
use for you. And yeah, it works in permissive mode (sudo setenforce 0).
BTW, what do you mean by "run javac in strace"?

iotuser@raspberrypi:~/policy $ sudo cat /var/log/audit/audit.log | grep
javac
type=AVC msg=audit(1491260813.624:793): avc:  denied  { mmap_zero } for
 pid=1656 comm="javac" scontext=unconfined_u:unconfin
ed_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfin
ed_r:unconfined_t:s0-s0:c0.c1023 tclass=memprotect permissive=0
type=SYSCALL msg=audit(1491260813.624:793): arch=40000028 syscall=11
per=800000 success=no exit=-13 a0=b8c548 a1=b92cc8 a2=ae2408 a3=9c663500
items=0 ppid=989 pid=1656 auid=1001 uid=1001 gid=1001 euid=1001 suid=1001
fsuid=1001 egid=1001 sgid=1001 fsgid=1001 tty=pts0 ses=3 comm="javac"
exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac"
subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
type=ANOM_ABEND msg=audit(1491260813.634:794): auid=1001 uid=1001 gid=1001
ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 pid=1656
comm="javac" exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac" sig=11
type=AVC msg=audit(1491261632.611:875): avc:  denied  { mmap_zero } for
 pid=1759 comm="javac" scontext=unconfined_u:unconfin
ed_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfin
ed_r:unconfined_t:s0-s0:c0.c1023 tclass=memprotect permissive=0
type=SYSCALL msg=audit(1491261632.611:875): arch=40000028 syscall=11
per=800000 success=no exit=-13 a0=b47a68 a1=bca488 a2=ae2408 a3=9c663500
items=0 ppid=989 pid=1759 auid=1001 uid=1001 gid=1001 euid=1001 suid=1001
fsuid=1001 egid=1001 sgid=1001 fsgid=1001 tty=pts0 ses=3 comm="javac"
exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac"
subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
type=ANOM_ABEND msg=audit(1491261632.621:876): auid=1001 uid=1001 gid=1001
ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 pid=1759
comm="javac" exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac" sig=11
type=AVC msg=audit(1491262641.248:924): avc:  denied  { mmap_zero } for
 pid=1792 comm="javac" scontext=unconfined_u:unconfin
ed_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfin
ed_r:unconfined_t:s0-s0:c0.c1023 tclass=memprotect permissive=0
type=SYSCALL msg=audit(1491262641.248:924): arch=40000028 syscall=11
per=800000 success=no exit=-13 a0=a3ede8 a1=b88d68 a2=ae2408 a3=9c663500
items=0 ppid=989 pid=1792 auid=1001 uid=1001 gid=1001 euid=1001 suid=1001
fsuid=1001 egid=1001 sgid=1001 fsgid=1001 tty=pts0 ses=3 comm="javac"
exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac"
subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
type=ANOM_ABEND msg=audit(1491262641.248:925): auid=1001 uid=1001 gid=1001
ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 pid=1792
comm="javac" exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac" sig=11
type=AVC msg=audit(1491263457.665:1069): avc:  denied  { mmap_zero } for
 pid=1945 comm="javac" scontext=unconfined_u:unconfin
ed_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfin
ed_r:unconfined_t:s0-s0:c0.c1023 tclass=memprotect permissive=0
type=SYSCALL msg=audit(1491263457.665:1069): arch=40000028 syscall=11
per=800000 success=no exit=-13 a0=b975e8 a1=b8b708 a2=ae2408 a3=9c663500
items=0 ppid=989 pid=1945 auid=1001 uid=1001 gid=1001 euid=1001 suid=1001
fsuid=1001 egid=1001 sgid=1001 fsgid=1001 tty=pts0 ses=3 comm="javac"
exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac"
subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
type=ANOM_ABEND msg=audit(1491263457.665:1070): auid=1001 uid=1001 gid=1001
ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 pid=1945
comm="javac" exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac" sig=11
type=AVC msg=audit(1491263668.304:1140): avc:  denied  { mmap_zero } for
 pid=1977 comm="javac" scontext=unconfined_u:unconfin
ed_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfin
ed_r:unconfined_t:s0-s0:c0.c1023 tclass=memprotect permissive=0
type=SYSCALL msg=audit(1491263668.304:1140): arch=40000028 syscall=11
per=800000 success=no exit=-13 a0=b89d88 a1=b48ac8 a2=ae2408 a3=9c663500
items=0 ppid=989 pid=1977 auid=1001 uid=1001 gid=1001 euid=1001 suid=1001
fsuid=1001 egid=1001 sgid=1001 fsgid=1001 tty=pts0 ses=3 comm="javac"
exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac"
subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
type=ANOM_ABEND msg=audit(1491263668.304:1141): auid=1001 uid=1001 gid=1001
ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 pid=1977
comm="javac" exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac" sig=11
type=AVC msg=audit(1491273121.724:1264): avc:  denied  { mmap_zero } for
 pid=2176 comm="javac" scontext=unconfined_u:unconfin
ed_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfin
ed_r:unconfined_t:s0-s0:c0.c1023 tclass=memprotect permissive=1
type=SYSCALL msg=audit(1491273121.724:1264): arch=40000028 syscall=11
per=800000 success=yes exit=0 a0=fd27c8 a1=f44a68 a2=fb4408 a3=55428f00
items=0 ppid=2125 pid=2176 auid=1001 uid=1001 gid=1001 euid=1001 suid=1001
fsuid=1001 egid=1001 sgid=1001 fsgid=1001 tty=pts3 ses=11 comm="javac"
exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac"
subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
type=PROCTITLE msg=audit(1491273121.724:1264): proctitle="javac"
type=AVC msg=audit(1491273200.654:1273): avc:  denied  { mmap_zero } for
 pid=2190 comm="javac" scontext=unconfined_u:unconfin
ed_r:unconfined_t:s0-s0:c0.c1023 tcontext=unconfined_u:unconfin
ed_r:unconfined_t:s0-s0:c0.c1023 tclass=memprotect permissive=0
type=SYSCALL msg=audit(1491273200.654:1273): arch=40000028 syscall=11
per=800000 success=no exit=-13 a0=1019f28 a1=1020668 a2=fb4408 a3=55428f00
items=0 ppid=2125 pid=2190 auid=1001 uid=1001 gid=1001 euid=1001 suid=1001
fsuid=1001 egid=1001 sgid=1001 fsgid=1001 tty=pts3 ses=11 comm="javac"
exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac"
subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
type=ANOM_ABEND msg=audit(1491273200.654:1274): auid=1001 uid=1001 gid=1001
ses=11 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 pid=2190
comm="javac" exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin javac" sig=11


That's what we're looking for. Looks like MLS issues, but I'd let someone
from the desktop world weigh in. Since you have syscall auditing enabled
you don't need strace. But as far as running javac in strace, something
like: strace javac foo.java would be an example command.



Actually I take back that MLS issue, I have no idea, wait for those
qualified for real answers.





On Mon, Apr 3, 2017 at 7:17 PM, William Roberts <bill.c.roberts@gmail.com>
wrote:

>
>
> On Apr 3, 2017 19:12, "Rahmadi Trimananda" <rtrimana@uci.edu> wrote:
>
> This is the result of "dmesg | grep avc". Please let me know if you need
> more information about my system (RaspberryPi 2 running Raspbian Jessie).
>
> [    2.275229] audit: type=1400 audit(2.249:3): avc:  denied  { associate
> } for  pid=1 comm="systemd" name="pts" scontext=system_u:object_r:devpts_t:s0
> tcontext=system_u:object_r:device_t:s0 tclass=filesystem permissive=1
> [    2.577155] audit: type=1400 audit(2.549:4): avc:  denied  { wake_alarm
> } for  pid=1 comm="systemd" capability=35  scontext=system_u:system_r:init_t:s0
> tcontext=system_u:system_r:init_t:s0 tclass=capability2 permissive=1
> [    2.601211] audit: type=1400 audit(2.569:5): avc:  denied  { execstack
> } for  pid=95 comm="systemd-fstab-g" scontext=system_u:system_r:init_t:s0
> tcontext=system_u:system_r:init_t:s0 tclass=process permissive=1
> [    2.601321] audit: type=1400 audit(2.569:6): avc:  denied  { execmem }
> for  pid=95 comm="systemd-fstab-g" scontext=system_u:system_r:init_t:s0
> tcontext=system_u:system_r:init_t:s0 tclass=process permissive=1
> [    2.605393] audit: type=1400 audit(2.579:7): avc:  denied  { execmod }
> for  pid=95 comm="systemd-fstab-g" path="/usr/lib/arm-linux-gnueabihf/libarmmem.so"
> dev="mmcblk0p2" ino=144391 scontext=system_u:system_r:init_t:s0
> tcontext=system_u:object_r:lib_t:s0 tclass=file permissive=1
> [    3.201440] audit: type=1400 audit(3.169:8): avc:  denied  { execstack
> } for  pid=107 comm="mount" scontext=system_u:system_r:mount_t:s0
> tcontext=system_u:system_r:mount_t:s0 tclass=process permissive=1
> [    3.201499] audit: type=1400 audit(3.169:9): avc:  denied  { execmem }
> for  pid=107 comm="mount" scontext=system_u:system_r:mount_t:s0
> tcontext=system_u:system_r:mount_t:s0 tclass=process permissive=1
> [    3.217575] audit: type=1400 audit(3.189:10): avc:  denied  { execstack
> } for  pid=108 comm="kmod" scontext=system_u:system_r:insmod_t:s0
> tcontext=system_u:system_r:insmod_t:s0 tclass=process permissive=1
> [    5.291711] audit: type=1400 audit(1491249900.889:59): avc:  denied  {
> mmap_zero } for  pid=243 comm="alsactl" scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:alsa_t:s0-s0:c0.c1023 tclass=memprotect
> permissive=1
> [    5.304205] audit: type=1400 audit(1491249900.909:60): avc:  denied  {
> execstack } for  pid=243 comm="alsactl" scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:alsa_t:s0-s0:c0.c1023 tclass=process
> permissive=1
> [    5.304582] audit: type=1400 audit(1491249900.909:61): avc:  denied  {
> execmem } for  pid=243 comm="alsactl" scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:alsa_t:s0-s0:c0.c1023 tclass=process
> permissive=1
> [    5.306197] audit: type=1400 audit(1491249900.909:62): avc:  denied  {
> use } for  pid=120 comm="systemd-journal" path="/dev/pts/0" dev="devpts"
> ino=3 scontext=system_u:system_r:syslogd_t:s0
> tcontext=system_u:system_r:plymouthd_t:s0 tclass=fd permissive=1
> [    5.355105] audit: type=1400 audit(1491249900.959:63): avc:  denied  {
> execmod } for  pid=243 comm="alsactl" path="/usr/lib/arm-linux-gnueabihf/libarmmem.so"
> dev="mmcblk0p2" ino=144391 scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:lib_t:s0 tclass=file permissive=1
> [    5.357519] audit: type=1400 audit(1491249900.959:64): avc:  denied  {
> write } for  pid=243 comm="alsactl" name="/" dev="tmpfs" ino=5104
> scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:var_lock_t:s0 tclass=dir permissive=1
> [    5.357705] audit: type=1400 audit(1491249900.959:65): avc:  denied  {
> add_name } for  pid=243 comm="alsactl" name="asound.state.lock"
> scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:var_lock_t:s0 tclass=dir permissive=1
> [    5.358083] audit: type=1400 audit(1491249900.959:66): avc:  denied  {
> create } for  pid=243 comm="alsactl" name="asound.state.lock"
> scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:var_lock_t:s0 tclass=file permissive=1
> [    5.358671] audit: type=1400 audit(1491249900.959:67): avc:  denied  {
> read write open } for  pid=243 comm="alsactl" path="/run/lock/asound.state.lock"
> dev="tmpfs" ino=1816 scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:var_lock_t:s0 tclass=file permissive=1
> [    5.358893] audit: type=1400 audit(1491249900.959:68): avc:  denied  {
> getattr } for  pid=243 comm="alsactl" path="/run/lock/asound.state.lock"
> dev="tmpfs" ino=1816 scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:var_lock_t:s0 tclass=file permissive=1
>
>
>
> I don't see anything that would prevent running javac offhand, perhaps
> others more versed in the desktop side can help tomorrow morning.
>
> Make sure you run javac so we can see any avc messages generated for it.
> Also run javac in strace and see where it's dying. Does this work in
> permissive mode? Ie sudo setenforce 0?
>
>
> On Mon, Apr 3, 2017 at 6:54 PM, William Roberts <bill.c.roberts@gmail.com>
> wrote:
>
>> Do you see any "avc: denied" messages in dmesg/syslog? If so send them.
>>
>> On Apr 3, 2017 16:28, "Rahmadi Trimananda" <rtrimana@uci.edu> wrote:
>>
>>> Hi All,
>>>
>>> I am trying to run javac and java on my Raspbian while SELinux is
>>> enabled. However, I keep getting "Segmentation fault", even when I just run
>>> "javac" or "java". This happens in enforcing mode, but it doesn't happen
>>> with "gcc". I am wondering why, because both are in /usr/bin directory and
>>> both binaries have the same context.
>>>
>>> Can somebody please help?
>>>
>>> Thank you so much!
>>>
>>> Regards,
>>> Rahmadi
>>>
>>>
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to
>>> Selinux-request@tycho.nsa.gov.
>>>
>>
>
>
> --
> Kind regards,
> Rahmadi Trimananda
>
> Ph.D. student @ University of California, Irvine
> "Stay hungry, stay foolish!" - Steve Jobs -
>
>
>


-- 
Kind regards,
Rahmadi Trimananda

Ph.D. student @ University of California, Irvine
"Stay hungry, stay foolish!" - Steve Jobs -

--001a113e586e9e4624054c4e7827
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><div class=3D"gmail_extra"><br><div class=3D"gma=
il_quote">On Apr 3, 2017 19:57, &quot;William Roberts&quot; &lt;<a href=3D"=
mailto:bill.c.roberts@gmail.com">bill.c.roberts@gmail.com</a>&gt; wrote:<br=
 type=3D"attribution"><blockquote class=3D"quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"auto"><div class=
=3D"quoted-text"><div><br><div class=3D"gmail_extra"><br><div class=3D"gmai=
l_quote">On Apr 3, 2017 19:35, &quot;Rahmadi Trimananda&quot; &lt;<a href=
=3D"mailto:rtrimana@uci.edu" target=3D"_blank">rtrimana@uci.edu</a>&gt; wro=
te:<br type=3D"attribution"><blockquote class=3D"m_-4287135457563687767quot=
e" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">=
<div dir=3D"ltr">I have more error messages from /var/log/audit/audit.log i=
f this is of any use for you. And yeah, it works in permissive mode (sudo s=
etenforce 0). BTW, what do you mean by &quot;run javac in strace&quot;?<div=
><br></div><div><div>iotuser@raspberrypi:~/policy $ sudo cat /var/log/audit=
/audit.log | grep javac</div><div>type=3DAVC msg=3Daudit(1491260813.624:793=
): avc: =C2=A0denied =C2=A0{ mmap_zero } for =C2=A0pid=3D1656 comm=3D&quot;=
javac&quot; scontext=3Dunconfined_u:unconfin<wbr>ed_r:unconfined_t:s0-s0:c0=
.<wbr>c1023 tcontext=3Dunconfined_u:unconfin<wbr>ed_r:unconfined_t:s0-s0:c0=
.<wbr>c1023 tclass=3Dmemprotect permissive=3D0</div><div>type=3DSYSCALL msg=
=3Daudit(1491260813.624:793): arch=3D40000028 syscall=3D11 per=3D800000 suc=
cess=3Dno exit=3D-13 a0=3Db8c548 a1=3Db92cc8 a2=3Dae2408 a3=3D9c663500 item=
s=3D0 ppid=3D989 pid=3D1656 auid=3D1001 uid=3D1001 gid=3D1001 euid=3D1001 s=
uid=3D1001 fsuid=3D1001 egid=3D1001 sgid=3D1001 fsgid=3D1001 tty=3Dpts0 ses=
=3D3 comm=3D&quot;javac&quot; exe=3D&quot;/usr/lib/jvm/jdk-8-oracle<wbr>-ar=
m32-vfp-hflt/bin/javac&quot; subj=3Dunconfined_u:unconfined_r<wbr>:unconfin=
ed_t:s0-s0:c0.c1023 key=3D(null)</div><div>type=3DANOM_ABEND msg=3Daudit(14=
91260813.634:794): auid=3D1001 uid=3D1001 gid=3D1001 ses=3D3 subj=3Dunconfi=
ned_u:unconfined_r<wbr>:unconfined_t:s0-s0:c0.c1023 pid=3D1656 comm=3D&quot=
;javac&quot; exe=3D&quot;/usr/lib/jvm/jdk-8-oracle<wbr>-arm32-vfp-hflt/bin/=
javac&quot; sig=3D11</div><div>type=3DAVC msg=3Daudit(1491261632.611:875): =
avc: =C2=A0denied =C2=A0{ mmap_zero } for =C2=A0pid=3D1759 comm=3D&quot;jav=
ac&quot; scontext=3Dunconfined_u:unconfin<wbr>ed_r:unconfined_t:s0-s0:c0.<w=
br>c1023 tcontext=3Dunconfined_u:unconfin<wbr>ed_r:unconfined_t:s0-s0:c0.<w=
br>c1023 tclass=3Dmemprotect permissive=3D0</div><div>type=3DSYSCALL msg=3D=
audit(1491261632.611:875): arch=3D40000028 syscall=3D11 per=3D800000 succes=
s=3Dno exit=3D-13 a0=3Db47a68 a1=3Dbca488 a2=3Dae2408 a3=3D9c663500 items=
=3D0 ppid=3D989 pid=3D1759 auid=3D1001 uid=3D1001 gid=3D1001 euid=3D1001 su=
id=3D1001 fsuid=3D1001 egid=3D1001 sgid=3D1001 fsgid=3D1001 tty=3Dpts0 ses=
=3D3 comm=3D&quot;javac&quot; exe=3D&quot;/usr/lib/jvm/jdk-8-oracle<wbr>-ar=
m32-vfp-hflt/bin/javac&quot; subj=3Dunconfined_u:unconfined_r<wbr>:unconfin=
ed_t:s0-s0:c0.c1023 key=3D(null)</div><div>type=3DANOM_ABEND msg=3Daudit(14=
91261632.621:876): auid=3D1001 uid=3D1001 gid=3D1001 ses=3D3 subj=3Dunconfi=
ned_u:unconfined_r<wbr>:unconfined_t:s0-s0:c0.c1023 pid=3D1759 comm=3D&quot=
;javac&quot; exe=3D&quot;/usr/lib/jvm/jdk-8-oracle<wbr>-arm32-vfp-hflt/bin/=
javac&quot; sig=3D11</div><div>type=3DAVC msg=3Daudit(1491262641.248:924): =
avc: =C2=A0denied =C2=A0{ mmap_zero } for =C2=A0pid=3D1792 comm=3D&quot;jav=
ac&quot; scontext=3Dunconfined_u:unconfin<wbr>ed_r:unconfined_t:s0-s0:c0.<w=
br>c1023 tcontext=3Dunconfined_u:unconfin<wbr>ed_r:unconfined_t:s0-s0:c0.<w=
br>c1023 tclass=3Dmemprotect permissive=3D0</div><div>type=3DSYSCALL msg=3D=
audit(1491262641.248:924): arch=3D40000028 syscall=3D11 per=3D800000 succes=
s=3Dno exit=3D-13 a0=3Da3ede8 a1=3Db88d68 a2=3Dae2408 a3=3D9c663500 items=
=3D0 ppid=3D989 pid=3D1792 auid=3D1001 uid=3D1001 gid=3D1001 euid=3D1001 su=
id=3D1001 fsuid=3D1001 egid=3D1001 sgid=3D1001 fsgid=3D1001 tty=3Dpts0 ses=
=3D3 comm=3D&quot;javac&quot; exe=3D&quot;/usr/lib/jvm/jdk-8-oracle<wbr>-ar=
m32-vfp-hflt/bin/javac&quot; subj=3Dunconfined_u:unconfined_r<wbr>:unconfin=
ed_t:s0-s0:c0.c1023 key=3D(null)</div><div>type=3DANOM_ABEND msg=3Daudit(14=
91262641.248:925): auid=3D1001 uid=3D1001 gid=3D1001 ses=3D3 subj=3Dunconfi=
ned_u:unconfined_r<wbr>:unconfined_t:s0-s0:c0.c1023 pid=3D1792 comm=3D&quot=
;javac&quot; exe=3D&quot;/usr/lib/jvm/jdk-8-oracle<wbr>-arm32-vfp-hflt/bin/=
javac&quot; sig=3D11</div><div>type=3DAVC msg=3Daudit(1491263457.665:1069)<=
wbr>: avc: =C2=A0denied =C2=A0{ mmap_zero } for =C2=A0pid=3D1945 comm=3D&qu=
ot;javac&quot; scontext=3Dunconfined_u:unconfin<wbr>ed_r:unconfined_t:s0-s0=
:c0.<wbr>c1023 tcontext=3Dunconfined_u:unconfin<wbr>ed_r:unconfined_t:s0-s0=
:c0.<wbr>c1023 tclass=3Dmemprotect permissive=3D0</div><div>type=3DSYSCALL =
msg=3Daudit(1491263457.665:1069)<wbr>: arch=3D40000028 syscall=3D11 per=3D8=
00000 success=3Dno exit=3D-13 a0=3Db975e8 a1=3Db8b708 a2=3Dae2408 a3=3D9c66=
3500 items=3D0 ppid=3D989 pid=3D1945 auid=3D1001 uid=3D1001 gid=3D1001 euid=
=3D1001 suid=3D1001 fsuid=3D1001 egid=3D1001 sgid=3D1001 fsgid=3D1001 tty=
=3Dpts0 ses=3D3 comm=3D&quot;javac&quot; exe=3D&quot;/usr/lib/jvm/jdk-8-ora=
cle<wbr>-arm32-vfp-hflt/bin/javac&quot; subj=3Dunconfined_u:unconfined_r<wb=
r>:unconfined_t:s0-s0:c0.c1023 key=3D(null)</div><div>type=3DANOM_ABEND msg=
=3Daudit(1491263457.665:1070)<wbr>: auid=3D1001 uid=3D1001 gid=3D1001 ses=
=3D3 subj=3Dunconfined_u:unconfined_r<wbr>:unconfined_t:s0-s0:c0.c1023 pid=
=3D1945 comm=3D&quot;javac&quot; exe=3D&quot;/usr/lib/jvm/jdk-8-oracle<wbr>=
-arm32-vfp-hflt/bin/javac&quot; sig=3D11</div><div>type=3DAVC msg=3Daudit(1=
491263668.304:1140)<wbr>: avc: =C2=A0denied =C2=A0{ mmap_zero } for =C2=A0p=
id=3D1977 comm=3D&quot;javac&quot; scontext=3Dunconfined_u:unconfin<wbr>ed_=
r:unconfined_t:s0-s0:c0.<wbr>c1023 tcontext=3Dunconfined_u:unconfin<wbr>ed_=
r:unconfined_t:s0-s0:c0.<wbr>c1023 tclass=3Dmemprotect permissive=3D0</div>=
<div>type=3DSYSCALL msg=3Daudit(1491263668.304:1140)<wbr>: arch=3D40000028 =
syscall=3D11 per=3D800000 success=3Dno exit=3D-13 a0=3Db89d88 a1=3Db48ac8 a=
2=3Dae2408 a3=3D9c663500 items=3D0 ppid=3D989 pid=3D1977 auid=3D1001 uid=3D=
1001 gid=3D1001 euid=3D1001 suid=3D1001 fsuid=3D1001 egid=3D1001 sgid=3D100=
1 fsgid=3D1001 tty=3Dpts0 ses=3D3 comm=3D&quot;javac&quot; exe=3D&quot;/usr=
/lib/jvm/jdk-8-oracle<wbr>-arm32-vfp-hflt/bin/javac&quot; subj=3Dunconfined=
_u:unconfined_r<wbr>:unconfined_t:s0-s0:c0.c1023 key=3D(null)</div><div>typ=
e=3DANOM_ABEND msg=3Daudit(1491263668.304:1141)<wbr>: auid=3D1001 uid=3D100=
1 gid=3D1001 ses=3D3 subj=3Dunconfined_u:unconfined_r<wbr>:unconfined_t:s0-=
s0:c0.c1023 pid=3D1977 comm=3D&quot;javac&quot; exe=3D&quot;/usr/lib/jvm/jd=
k-8-oracle<wbr>-arm32-vfp-hflt/bin/javac&quot; sig=3D11</div><div>type=3DAV=
C msg=3Daudit(1491273121.724:1264)<wbr>: avc: =C2=A0denied =C2=A0{ mmap_zer=
o } for =C2=A0pid=3D2176 comm=3D&quot;javac&quot; scontext=3Dunconfined_u:u=
nconfin<wbr>ed_r:unconfined_t:s0-s0:c0.<wbr>c1023 tcontext=3Dunconfined_u:u=
nconfin<wbr>ed_r:unconfined_t:s0-s0:c0.<wbr>c1023 tclass=3Dmemprotect permi=
ssive=3D1</div><div>type=3DSYSCALL msg=3Daudit(1491273121.724:1264)<wbr>: a=
rch=3D40000028 syscall=3D11 per=3D800000 success=3Dyes exit=3D0 a0=3Dfd27c8=
 a1=3Df44a68 a2=3Dfb4408 a3=3D55428f00 items=3D0 ppid=3D2125 pid=3D2176 aui=
d=3D1001 uid=3D1001 gid=3D1001 euid=3D1001 suid=3D1001 fsuid=3D1001 egid=3D=
1001 sgid=3D1001 fsgid=3D1001 tty=3Dpts3 ses=3D11 comm=3D&quot;javac&quot; =
exe=3D&quot;/usr/lib/jvm/jdk-8-oracle<wbr>-arm32-vfp-hflt/bin/javac&quot; s=
ubj=3Dunconfined_u:unconfined_r<wbr>:unconfined_t:s0-s0:c0.c1023 key=3D(nul=
l)</div><div>type=3DPROCTITLE msg=3Daudit(1491273121.724:1264)<wbr>: procti=
tle=3D&quot;javac&quot;</div><div>type=3DAVC msg=3Daudit(1491273200.654:127=
3)<wbr>: avc: =C2=A0denied =C2=A0{ mmap_zero } for =C2=A0pid=3D2190 comm=3D=
&quot;javac&quot; scontext=3Dunconfined_u:unconfin<wbr>ed_r:unconfined_t:s0=
-s0:c0.<wbr>c1023 tcontext=3Dunconfined_u:unconfin<wbr>ed_r:unconfined_t:s0=
-s0:c0.<wbr>c1023 tclass=3Dmemprotect permissive=3D0</div><div>type=3DSYSCA=
LL msg=3Daudit(1491273200.654:1273)<wbr>: arch=3D40000028 syscall=3D11 per=
=3D800000 success=3Dno exit=3D-13 a0=3D1019f28 a1=3D1020668 a2=3Dfb4408 a3=
=3D55428f00 items=3D0 ppid=3D2125 pid=3D2190 auid=3D1001 uid=3D1001 gid=3D1=
001 euid=3D1001 suid=3D1001 fsuid=3D1001 egid=3D1001 sgid=3D1001 fsgid=3D10=
01 tty=3Dpts3 ses=3D11 comm=3D&quot;javac&quot; exe=3D&quot;/usr/lib/jvm/jd=
k-8-oracle<wbr>-arm32-vfp-hflt/bin/javac&quot; subj=3Dunconfined_u:unconfin=
ed_r<wbr>:unconfined_t:s0-s0:c0.c1023 key=3D(null)</div><div>type=3DANOM_AB=
END msg=3Daudit(1491273200.654:1274)<wbr>: auid=3D1001 uid=3D1001 gid=3D100=
1 ses=3D11 subj=3Dunconfined_u:unconfined_r<wbr>:unconfined_t:s0-s0:c0.c102=
3 pid=3D2190 comm=3D&quot;javac&quot; exe=3D&quot;/usr/lib/jvm/jdk-8-oracle=
<wbr>-arm32-vfp-hflt/bin javac&quot; sig=3D11</div></div></div></blockquote=
></div></div></div><div dir=3D"auto"><br></div></div><div dir=3D"auto">That=
&#39;s what we&#39;re looking for. Looks like MLS issues, but I&#39;d let s=
omeone from the desktop world weigh in. Since you have syscall auditing ena=
bled you don&#39;t need strace. But as far as running javac in strace, some=
thing like: strace javac foo.java would be an example command.</div></div><=
/blockquote></div></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"=
><br></div><div dir=3D"auto">Actually I take back that MLS issue, I have no=
 idea, wait for those qualified for real answers.</div><div dir=3D"auto"><d=
iv class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><div dir=3D"auto"><div class=3D"elided-text"><div dir=3D"auto"><br></div>=
<div dir=3D"auto"><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
div class=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"m=
_-4287135457563687767quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex"><div class=3D"m_-4287135457563687767elided-text"><=
div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Apr 3, 201=
7 at 7:17 PM, William Roberts <span dir=3D"ltr">&lt;<a href=3D"mailto:bill.=
c.roberts@gmail.com" target=3D"_blank">bill.c.roberts@gmail.com</a>&gt;</sp=
an> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"auto"><span><div><=
br><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Apr 3, 2017=
 19:12, &quot;Rahmadi Trimananda&quot; &lt;<a href=3D"mailto:rtrimana@uci.e=
du" target=3D"_blank">rtrimana@uci.edu</a>&gt; wrote:<br type=3D"attributio=
n"><blockquote class=3D"m_-4287135457563687767m_7373467912643150967m_755454=
02670596028quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex"><div dir=3D"ltr">This is the result of &quot;dmesg | grep av=
c&quot;. Please let me know if you need more information about my system (R=
aspberryPi 2 running Raspbian Jessie).<div><br></div><div><div>[ =C2=A0 =C2=
=A02.275229] audit: type=3D1400 audit(2.249:3): avc: =C2=A0denied =C2=A0{ a=
ssociate } for =C2=A0pid=3D1 comm=3D&quot;systemd&quot; name=3D&quot;pts&qu=
ot; scontext=3Dsystem_u:object_r:dev<wbr>pts_t:s0 tcontext=3Dsystem_u:objec=
t_r:dev<wbr>ice_t:s0 tclass=3Dfilesystem permissive=3D1</div><div>[ =C2=A0 =
=C2=A02.577155] audit: type=3D1400 audit(2.549:4): avc: =C2=A0denied =C2=A0=
{ wake_alarm } for =C2=A0pid=3D1 comm=3D&quot;systemd&quot; capability=3D35=
 =C2=A0scontext=3Dsystem_u:system_r:in<wbr>it_t:s0 tcontext=3Dsystem_u:syst=
em_r:ini<wbr>t_t:s0 tclass=3Dcapability2 permissive=3D1</div><div>[ =C2=A0 =
=C2=A02.601211] audit: type=3D1400 audit(2.569:5): avc: =C2=A0denied =C2=A0=
{ execstack } for =C2=A0pid=3D95 comm=3D&quot;systemd-fstab-g&quot; scontex=
t=3Dsystem_u:system_r:ini<wbr>t_t:s0 tcontext=3Dsystem_u:system_r:ini<wbr>t=
_t:s0 tclass=3Dprocess permissive=3D1</div><div>[ =C2=A0 =C2=A02.601321] au=
dit: type=3D1400 audit(2.569:6): avc: =C2=A0denied =C2=A0{ execmem } for =
=C2=A0pid=3D95 comm=3D&quot;systemd-fstab-g&quot; scontext=3Dsystem_u:syste=
m_r:ini<wbr>t_t:s0 tcontext=3Dsystem_u:system_r:ini<wbr>t_t:s0 tclass=3Dpro=
cess permissive=3D1</div><div>[ =C2=A0 =C2=A02.605393] audit: type=3D1400 a=
udit(2.579:7): avc: =C2=A0denied =C2=A0{ execmod } for =C2=A0pid=3D95 comm=
=3D&quot;systemd-fstab-g&quot; path=3D&quot;/usr/lib/arm-linux-gnuea<wbr>bi=
hf/libarmmem.so&quot; dev=3D&quot;mmcblk0p2&quot; ino=3D144391 scontext=3Ds=
ystem_u:system_r:ini<wbr>t_t:s0 tcontext=3Dsystem_u:object_r:lib<wbr>_t:s0 =
tclass=3Dfile permissive=3D1</div><div>[ =C2=A0 =C2=A03.201440] audit: type=
=3D1400 audit(3.169:8): avc: =C2=A0denied =C2=A0{ execstack } for =C2=A0pid=
=3D107 comm=3D&quot;mount&quot; scontext=3Dsystem_u:system_r:mou<wbr>nt_t:s=
0 tcontext=3Dsystem_u:system_r:mou<wbr>nt_t:s0 tclass=3Dprocess permissive=
=3D1</div><div>[ =C2=A0 =C2=A03.201499] audit: type=3D1400 audit(3.169:9): =
avc: =C2=A0denied =C2=A0{ execmem } for =C2=A0pid=3D107 comm=3D&quot;mount&=
quot; scontext=3Dsystem_u:system_r:mou<wbr>nt_t:s0 tcontext=3Dsystem_u:syst=
em_r:mou<wbr>nt_t:s0 tclass=3Dprocess permissive=3D1</div><div>[ =C2=A0 =C2=
=A03.217575] audit: type=3D1400 audit(3.189:10): avc: =C2=A0denied =C2=A0{ =
execstack } for =C2=A0pid=3D108 comm=3D&quot;kmod&quot; scontext=3Dsystem_u=
:system_r:ins<wbr>mod_t:s0 tcontext=3Dsystem_u:system_r:ins<wbr>mod_t:s0 tc=
lass=3Dprocess permissive=3D1</div><div>[ =C2=A0 =C2=A05.291711] audit: typ=
e=3D1400 audit(1491249900.889:59): avc: =C2=A0denied =C2=A0{ mmap_zero } fo=
r =C2=A0pid=3D243 comm=3D&quot;alsactl&quot; scontext=3Dsystem_u:system_r:a=
ls<wbr>a_t:s0-s0:c0.c1023 tcontext=3Dsystem_u:system_r:als<wbr>a_t:s0-s0:c0=
.c1023 tclass=3Dmemprotect permissive=3D1</div><div>[ =C2=A0 =C2=A05.304205=
] audit: type=3D1400 audit(1491249900.909:60): avc: =C2=A0denied =C2=A0{ ex=
ecstack } for =C2=A0pid=3D243 comm=3D&quot;alsactl&quot; scontext=3Dsystem_=
u:system_r:als<wbr>a_t:s0-s0:c0.c1023 tcontext=3Dsystem_u:system_r:als<wbr>=
a_t:s0-s0:c0.c1023 tclass=3Dprocess permissive=3D1</div><div>[ =C2=A0 =C2=
=A05.304582] audit: type=3D1400 audit(1491249900.909:61): avc: =C2=A0denied=
 =C2=A0{ execmem } for =C2=A0pid=3D243 comm=3D&quot;alsactl&quot; scontext=
=3Dsystem_u:system_r:als<wbr>a_t:s0-s0:c0.c1023 tcontext=3Dsystem_u:system_=
r:als<wbr>a_t:s0-s0:c0.c1023 tclass=3Dprocess permissive=3D1</div><div>[ =
=C2=A0 =C2=A05.306197] audit: type=3D1400 audit(1491249900.909:62): avc: =
=C2=A0denied =C2=A0{ use } for =C2=A0pid=3D120 comm=3D&quot;systemd-journal=
&quot; path=3D&quot;/dev/pts/0&quot; dev=3D&quot;devpts&quot; ino=3D3 scont=
ext=3Dsystem_u:system_r:sys<wbr>logd_t:s0 tcontext=3Dsystem_u:system_r:ply<=
wbr>mouthd_t:s0 tclass=3Dfd permissive=3D1</div><div>[ =C2=A0 =C2=A05.35510=
5] audit: type=3D1400 audit(1491249900.959:63): avc: =C2=A0denied =C2=A0{ e=
xecmod } for =C2=A0pid=3D243 comm=3D&quot;alsactl&quot; path=3D&quot;/usr/l=
ib/arm-linux-gnuea<wbr>bihf/libarmmem.so&quot; dev=3D&quot;mmcblk0p2&quot; =
ino=3D144391 scontext=3Dsystem_u:system_r:als<wbr>a_t:s0-s0:c0.c1023 tconte=
xt=3Dsystem_u:object_r:lib<wbr>_t:s0 tclass=3Dfile permissive=3D1</div><div=
>[ =C2=A0 =C2=A05.357519] audit: type=3D1400 audit(1491249900.959:64): avc:=
 =C2=A0denied =C2=A0{ write } for =C2=A0pid=3D243 comm=3D&quot;alsactl&quot=
; name=3D&quot;/&quot; dev=3D&quot;tmpfs&quot; ino=3D5104 scontext=3Dsystem=
_u:system_r:als<wbr>a_t:s0-s0:c0.c1023 tcontext=3Dsystem_u:object_r:var<wbr=
>_lock_t:s0 tclass=3Ddir permissive=3D1</div><div>[ =C2=A0 =C2=A05.357705] =
audit: type=3D1400 audit(1491249900.959:65): avc: =C2=A0denied =C2=A0{ add_=
name } for =C2=A0pid=3D243 comm=3D&quot;alsactl&quot; name=3D&quot;asound.s=
tate.lock&quot; scontext=3Dsystem_u:system_r:als<wbr>a_t:s0-s0:c0.c1023 tco=
ntext=3Dsystem_u:object_r:var<wbr>_lock_t:s0 tclass=3Ddir permissive=3D1</d=
iv><div>[ =C2=A0 =C2=A05.358083] audit: type=3D1400 audit(1491249900.959:66=
): avc: =C2=A0denied =C2=A0{ create } for =C2=A0pid=3D243 comm=3D&quot;alsa=
ctl&quot; name=3D&quot;asound.state.lock&quot; scontext=3Dsystem_u:system_r=
:als<wbr>a_t:s0-s0:c0.c1023 tcontext=3Dsystem_u:object_r:var<wbr>_lock_t:s0=
 tclass=3Dfile permissive=3D1</div><div>[ =C2=A0 =C2=A05.358671] audit: typ=
e=3D1400 audit(1491249900.959:67): avc: =C2=A0denied =C2=A0{ read write ope=
n } for =C2=A0pid=3D243 comm=3D&quot;alsactl&quot; path=3D&quot;/run/lock/a=
sound.state.l<wbr>ock&quot; dev=3D&quot;tmpfs&quot; ino=3D1816 scontext=3Ds=
ystem_u:system_r:als<wbr>a_t:s0-s0:c0.c1023 tcontext=3Dsystem_u:object_r:va=
r<wbr>_lock_t:s0 tclass=3Dfile permissive=3D1</div><div>[ =C2=A0 =C2=A05.35=
8893] audit: type=3D1400 audit(1491249900.959:68): avc: =C2=A0denied =C2=A0=
{ getattr } for =C2=A0pid=3D243 comm=3D&quot;alsactl&quot; path=3D&quot;/ru=
n/lock/asound.state.l<wbr>ock&quot; dev=3D&quot;tmpfs&quot; ino=3D1816 scon=
text=3Dsystem_u:system_r:als<wbr>a_t:s0-s0:c0.c1023 tcontext=3Dsystem_u:obj=
ect_r:var<wbr>_lock_t:s0 tclass=3Dfile permissive=3D1</div></div></div></bl=
ockquote></div></div></div><div dir=3D"auto"><br></div><div dir=3D"auto"><b=
r></div></span><div dir=3D"auto">I don&#39;t see anything that would preven=
t running javac offhand, perhaps others more versed in the desktop side can=
 help tomorrow morning.</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
Make sure you run javac so we can see any avc messages generated for it. Al=
so run javac in strace and see where it&#39;s dying. Does this work in perm=
issive mode? Ie sudo setenforce 0?</div><span><div dir=3D"auto"><br></div><=
div dir=3D"auto"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><blo=
ckquote class=3D"m_-4287135457563687767m_7373467912643150967m_7554540267059=
6028quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex"><div class=3D"gmail_extra"><div class=3D"m_-4287135457563687767m_73=
73467912643150967m_75545402670596028elided-text"><br><div class=3D"gmail_qu=
ote">On Mon, Apr 3, 2017 at 6:54 PM, William Roberts <span dir=3D"ltr">&lt;=
<a href=3D"mailto:bill.c.roberts@gmail.com" target=3D"_blank">bill.c.robert=
s@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div di=
r=3D"auto">Do you see any &quot;avc: denied&quot; messages in dmesg/syslog?=
 If so send them.</div><div class=3D"gmail_extra"><br><div class=3D"gmail_q=
uote"><div><div class=3D"m_-4287135457563687767m_7373467912643150967m_75545=
402670596028m_4915809492275190614h5">On Apr 3, 2017 16:28, &quot;Rahmadi Tr=
imananda&quot; &lt;<a href=3D"mailto:rtrimana@uci.edu" target=3D"_blank">rt=
rimana@uci.edu</a>&gt; wrote:<br type=3D"attribution"></div></div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex"><div><div class=3D"m_-4287135457563687767m_7373467912=
643150967m_75545402670596028m_4915809492275190614h5"><div dir=3D"ltr">Hi Al=
l,<div><br></div><div>I am trying to run javac and java on my Raspbian whil=
e SELinux is enabled. However, I keep getting &quot;Segmentation fault&quot=
;, even when I just run &quot;javac&quot; or &quot;java&quot;. This happens=
 in enforcing mode, but it doesn&#39;t happen with &quot;gcc&quot;. I am wo=
ndering why, because both are in /usr/bin directory and both binaries have =
the same context.</div><div><br></div><div>Can somebody please help?</div><=
div><br></div><div>Thank you so much!</div><div><br></div><div>Regards,</di=
v><div>Rahmadi</div><div class=3D"gmail_extra"><br>
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
</blockquote></div><br><br clear=3D"all"><div><br></div></div><font color=
=3D"#888888">-- <br><div class=3D"m_-4287135457563687767m_73734679126431509=
67m_75545402670596028m_4915809492275190614gmail_signature" data-smartmail=
=3D"gmail_signature"><div dir=3D"ltr">Kind regards,<div>Rahmadi Trimananda<=
/div><div><br></div><div>Ph.D. student @ University of California, Irvine</=
div><div>&quot;Stay hungry, stay foolish!&quot; - Steve Jobs -</div></div><=
/div>
</font></div>
</blockquote></div><br></div></div></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"m_-4287135457563687767m_7373467912643150967gmail_signature" data-smartm=
ail=3D"gmail_signature"><div dir=3D"ltr">Kind regards,<div>Rahmadi Trimanan=
da</div><div><br></div><div>Ph.D. student @ University of California, Irvin=
e</div><div>&quot;Stay hungry, stay foolish!&quot; - Steve Jobs -</div></di=
v></div>
</div>
</div></blockquote></div><br></div></div></div></div>
</blockquote></div><br></div></div></div>

--001a113e586e9e4624054c4e7827--
