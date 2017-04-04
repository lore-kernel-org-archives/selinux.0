Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v342cXJ8015193
 for <selinux@tycho.nsa.gov>; Mon, 3 Apr 2017 22:38:33 -0400
Received: by mail-wr0-f169.google.com with SMTP id k6so189449369wre.2
 for <selinux@tycho.nsa.gov>; Mon, 03 Apr 2017 19:38:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHFUiBO6wYvSURpf72Qy7z1TkMtPrEd6ajC8Ox-RFPBC3jj_ZA@mail.gmail.com>
References: <CAHFUiBOa186qydQ5VBeEmcMMinQnpkwBPMx91Aq-GAq4TvSm-g@mail.gmail.com>
 <CAFftDdrVEKxgp69KrUrfyzD8hPuYOBtKgGhb_JWKCKrmd2PqhQ@mail.gmail.com>
 <CAHFUiBNnbdfvqneUo5dH4+4e_1Df6HrbmBGaQQ76SQpi6AXvBg@mail.gmail.com>
 <CAFftDdpRxYsMHyDKmRtCswovHRgda1nW2ELUVVKPVtBrL9HL8Q@mail.gmail.com>
 <CAHFUiBO6wYvSURpf72Qy7z1TkMtPrEd6ajC8Ox-RFPBC3jj_ZA@mail.gmail.com>
From: Rahmadi Trimananda <rtrimana@uci.edu>
Date: Mon, 3 Apr 2017 19:38:29 -0700
Message-ID: <CAHFUiBOq1Nbosujm9dQhkWA2rH4Kikh=HvSf_r7QrYEPnToTGA@mail.gmail.com>
Subject: Re: Running Java and JVM on SELinux
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a11468efed43785054c4e2b7b
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11468efed43785054c4e2b7b
Content-Type: text/plain; charset=UTF-8

More info about javac.. according to some blogs/forums, javac/java has to
be of type textrel_shlib_t, and I can see that it has the right type.

iotuser@raspberrypi:~/policy $ ls
/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac -Z
system_u:object_r:textrel_shlib_t:SystemLow
/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac

On Mon, Apr 3, 2017 at 7:35 PM, Rahmadi Trimananda <rtrimana@uci.edu> wrote:

> I have more error messages from /var/log/audit/audit.log if this is of any
> use for you. And yeah, it works in permissive mode (sudo setenforce 0).
> BTW, what do you mean by "run javac in strace"?
>
> iotuser@raspberrypi:~/policy $ sudo cat /var/log/audit/audit.log | grep
> javac
> type=AVC msg=audit(1491260813.624:793): avc:  denied  { mmap_zero } for
>  pid=1656 comm="javac" scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> tclass=memprotect permissive=0
> type=SYSCALL msg=audit(1491260813.624:793): arch=40000028 syscall=11
> per=800000 success=no exit=-13 a0=b8c548 a1=b92cc8 a2=ae2408 a3=9c663500
> items=0 ppid=989 pid=1656 auid=1001 uid=1001 gid=1001 euid=1001 suid=1001
> fsuid=1001 egid=1001 sgid=1001 fsgid=1001 tty=pts0 ses=3 comm="javac"
> exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac"
> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> type=ANOM_ABEND msg=audit(1491260813.634:794): auid=1001 uid=1001 gid=1001
> ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 pid=1656
> comm="javac" exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac"
> sig=11
> type=AVC msg=audit(1491261632.611:875): avc:  denied  { mmap_zero } for
>  pid=1759 comm="javac" scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> tclass=memprotect permissive=0
> type=SYSCALL msg=audit(1491261632.611:875): arch=40000028 syscall=11
> per=800000 success=no exit=-13 a0=b47a68 a1=bca488 a2=ae2408 a3=9c663500
> items=0 ppid=989 pid=1759 auid=1001 uid=1001 gid=1001 euid=1001 suid=1001
> fsuid=1001 egid=1001 sgid=1001 fsgid=1001 tty=pts0 ses=3 comm="javac"
> exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac"
> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> type=ANOM_ABEND msg=audit(1491261632.621:876): auid=1001 uid=1001 gid=1001
> ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 pid=1759
> comm="javac" exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac"
> sig=11
> type=AVC msg=audit(1491262641.248:924): avc:  denied  { mmap_zero } for
>  pid=1792 comm="javac" scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> tclass=memprotect permissive=0
> type=SYSCALL msg=audit(1491262641.248:924): arch=40000028 syscall=11
> per=800000 success=no exit=-13 a0=a3ede8 a1=b88d68 a2=ae2408 a3=9c663500
> items=0 ppid=989 pid=1792 auid=1001 uid=1001 gid=1001 euid=1001 suid=1001
> fsuid=1001 egid=1001 sgid=1001 fsgid=1001 tty=pts0 ses=3 comm="javac"
> exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac"
> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> type=ANOM_ABEND msg=audit(1491262641.248:925): auid=1001 uid=1001 gid=1001
> ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 pid=1792
> comm="javac" exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac"
> sig=11
> type=AVC msg=audit(1491263457.665:1069): avc:  denied  { mmap_zero } for
>  pid=1945 comm="javac" scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> tclass=memprotect permissive=0
> type=SYSCALL msg=audit(1491263457.665:1069): arch=40000028 syscall=11
> per=800000 success=no exit=-13 a0=b975e8 a1=b8b708 a2=ae2408 a3=9c663500
> items=0 ppid=989 pid=1945 auid=1001 uid=1001 gid=1001 euid=1001 suid=1001
> fsuid=1001 egid=1001 sgid=1001 fsgid=1001 tty=pts0 ses=3 comm="javac"
> exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac"
> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> type=ANOM_ABEND msg=audit(1491263457.665:1070): auid=1001 uid=1001
> gid=1001 ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> pid=1945 comm="javac" exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac"
> sig=11
> type=AVC msg=audit(1491263668.304:1140): avc:  denied  { mmap_zero } for
>  pid=1977 comm="javac" scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> tclass=memprotect permissive=0
> type=SYSCALL msg=audit(1491263668.304:1140): arch=40000028 syscall=11
> per=800000 success=no exit=-13 a0=b89d88 a1=b48ac8 a2=ae2408 a3=9c663500
> items=0 ppid=989 pid=1977 auid=1001 uid=1001 gid=1001 euid=1001 suid=1001
> fsuid=1001 egid=1001 sgid=1001 fsgid=1001 tty=pts0 ses=3 comm="javac"
> exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac"
> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> type=ANOM_ABEND msg=audit(1491263668.304:1141): auid=1001 uid=1001
> gid=1001 ses=3 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> pid=1977 comm="javac" exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac"
> sig=11
> type=AVC msg=audit(1491273121.724:1264): avc:  denied  { mmap_zero } for
>  pid=2176 comm="javac" scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> tclass=memprotect permissive=1
> type=SYSCALL msg=audit(1491273121.724:1264): arch=40000028 syscall=11
> per=800000 success=yes exit=0 a0=fd27c8 a1=f44a68 a2=fb4408 a3=55428f00
> items=0 ppid=2125 pid=2176 auid=1001 uid=1001 gid=1001 euid=1001 suid=1001
> fsuid=1001 egid=1001 sgid=1001 fsgid=1001 tty=pts3 ses=11 comm="javac"
> exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac"
> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> type=PROCTITLE msg=audit(1491273121.724:1264): proctitle="javac"
> type=AVC msg=audit(1491273200.654:1273): avc:  denied  { mmap_zero } for
>  pid=2190 comm="javac" scontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> tcontext=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> tclass=memprotect permissive=0
> type=SYSCALL msg=audit(1491273200.654:1273): arch=40000028 syscall=11
> per=800000 success=no exit=-13 a0=1019f28 a1=1020668 a2=fb4408 a3=55428f00
> items=0 ppid=2125 pid=2190 auid=1001 uid=1001 gid=1001 euid=1001 suid=1001
> fsuid=1001 egid=1001 sgid=1001 fsgid=1001 tty=pts3 ses=11 comm="javac"
> exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac"
> subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 key=(null)
> type=ANOM_ABEND msg=audit(1491273200.654:1274): auid=1001 uid=1001
> gid=1001 ses=11 subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> pid=2190 comm="javac" exe="/usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin
> javac" sig=11
>
> On Mon, Apr 3, 2017 at 7:17 PM, William Roberts <bill.c.roberts@gmail.com>
> wrote:
>
>>
>>
>> On Apr 3, 2017 19:12, "Rahmadi Trimananda" <rtrimana@uci.edu> wrote:
>>
>> This is the result of "dmesg | grep avc". Please let me know if you need
>> more information about my system (RaspberryPi 2 running Raspbian Jessie).
>>
>> [    2.275229] audit: type=1400 audit(2.249:3): avc:  denied  { associate
>> } for  pid=1 comm="systemd" name="pts" scontext=system_u:object_r:devpts_t:s0
>> tcontext=system_u:object_r:device_t:s0 tclass=filesystem permissive=1
>> [    2.577155] audit: type=1400 audit(2.549:4): avc:  denied  {
>> wake_alarm } for  pid=1 comm="systemd" capability=35
>>  scontext=system_u:system_r:init_t:s0 tcontext=system_u:system_r:init_t:s0
>> tclass=capability2 permissive=1
>> [    2.601211] audit: type=1400 audit(2.569:5): avc:  denied  { execstack
>> } for  pid=95 comm="systemd-fstab-g" scontext=system_u:system_r:init_t:s0
>> tcontext=system_u:system_r:init_t:s0 tclass=process permissive=1
>> [    2.601321] audit: type=1400 audit(2.569:6): avc:  denied  { execmem }
>> for  pid=95 comm="systemd-fstab-g" scontext=system_u:system_r:init_t:s0
>> tcontext=system_u:system_r:init_t:s0 tclass=process permissive=1
>> [    2.605393] audit: type=1400 audit(2.579:7): avc:  denied  { execmod }
>> for  pid=95 comm="systemd-fstab-g" path="/usr/lib/arm-linux-gnueabihf/libarmmem.so"
>> dev="mmcblk0p2" ino=144391 scontext=system_u:system_r:init_t:s0
>> tcontext=system_u:object_r:lib_t:s0 tclass=file permissive=1
>> [    3.201440] audit: type=1400 audit(3.169:8): avc:  denied  { execstack
>> } for  pid=107 comm="mount" scontext=system_u:system_r:mount_t:s0
>> tcontext=system_u:system_r:mount_t:s0 tclass=process permissive=1
>> [    3.201499] audit: type=1400 audit(3.169:9): avc:  denied  { execmem }
>> for  pid=107 comm="mount" scontext=system_u:system_r:mount_t:s0
>> tcontext=system_u:system_r:mount_t:s0 tclass=process permissive=1
>> [    3.217575] audit: type=1400 audit(3.189:10): avc:  denied  {
>> execstack } for  pid=108 comm="kmod" scontext=system_u:system_r:insmod_t:s0
>> tcontext=system_u:system_r:insmod_t:s0 tclass=process permissive=1
>> [    5.291711] audit: type=1400 audit(1491249900.889:59): avc:  denied  {
>> mmap_zero } for  pid=243 comm="alsactl" scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
>> tcontext=system_u:system_r:alsa_t:s0-s0:c0.c1023 tclass=memprotect
>> permissive=1
>> [    5.304205] audit: type=1400 audit(1491249900.909:60): avc:  denied  {
>> execstack } for  pid=243 comm="alsactl" scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
>> tcontext=system_u:system_r:alsa_t:s0-s0:c0.c1023 tclass=process
>> permissive=1
>> [    5.304582] audit: type=1400 audit(1491249900.909:61): avc:  denied  {
>> execmem } for  pid=243 comm="alsactl" scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
>> tcontext=system_u:system_r:alsa_t:s0-s0:c0.c1023 tclass=process
>> permissive=1
>> [    5.306197] audit: type=1400 audit(1491249900.909:62): avc:  denied  {
>> use } for  pid=120 comm="systemd-journal" path="/dev/pts/0" dev="devpts"
>> ino=3 scontext=system_u:system_r:syslogd_t:s0
>> tcontext=system_u:system_r:plymouthd_t:s0 tclass=fd permissive=1
>> [    5.355105] audit: type=1400 audit(1491249900.959:63): avc:  denied  {
>> execmod } for  pid=243 comm="alsactl" path="/usr/lib/arm-linux-gnueabihf/libarmmem.so"
>> dev="mmcblk0p2" ino=144391 scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
>> tcontext=system_u:object_r:lib_t:s0 tclass=file permissive=1
>> [    5.357519] audit: type=1400 audit(1491249900.959:64): avc:  denied  {
>> write } for  pid=243 comm="alsactl" name="/" dev="tmpfs" ino=5104
>> scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
>> tcontext=system_u:object_r:var_lock_t:s0 tclass=dir permissive=1
>> [    5.357705] audit: type=1400 audit(1491249900.959:65): avc:  denied  {
>> add_name } for  pid=243 comm="alsactl" name="asound.state.lock"
>> scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
>> tcontext=system_u:object_r:var_lock_t:s0 tclass=dir permissive=1
>> [    5.358083] audit: type=1400 audit(1491249900.959:66): avc:  denied  {
>> create } for  pid=243 comm="alsactl" name="asound.state.lock"
>> scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
>> tcontext=system_u:object_r:var_lock_t:s0 tclass=file permissive=1
>> [    5.358671] audit: type=1400 audit(1491249900.959:67): avc:  denied  {
>> read write open } for  pid=243 comm="alsactl" path="/run/lock/asound.state.lock"
>> dev="tmpfs" ino=1816 scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
>> tcontext=system_u:object_r:var_lock_t:s0 tclass=file permissive=1
>> [    5.358893] audit: type=1400 audit(1491249900.959:68): avc:  denied  {
>> getattr } for  pid=243 comm="alsactl" path="/run/lock/asound.state.lock"
>> dev="tmpfs" ino=1816 scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
>> tcontext=system_u:object_r:var_lock_t:s0 tclass=file permissive=1
>>
>>
>>
>> I don't see anything that would prevent running javac offhand, perhaps
>> others more versed in the desktop side can help tomorrow morning.
>>
>> Make sure you run javac so we can see any avc messages generated for it.
>> Also run javac in strace and see where it's dying. Does this work in
>> permissive mode? Ie sudo setenforce 0?
>>
>>
>> On Mon, Apr 3, 2017 at 6:54 PM, William Roberts <bill.c.roberts@gmail.com
>> > wrote:
>>
>>> Do you see any "avc: denied" messages in dmesg/syslog? If so send them.
>>>
>>> On Apr 3, 2017 16:28, "Rahmadi Trimananda" <rtrimana@uci.edu> wrote:
>>>
>>>> Hi All,
>>>>
>>>> I am trying to run javac and java on my Raspbian while SELinux is
>>>> enabled. However, I keep getting "Segmentation fault", even when I just run
>>>> "javac" or "java". This happens in enforcing mode, but it doesn't happen
>>>> with "gcc". I am wondering why, because both are in /usr/bin directory and
>>>> both binaries have the same context.
>>>>
>>>> Can somebody please help?
>>>>
>>>> Thank you so much!
>>>>
>>>> Regards,
>>>> Rahmadi
>>>>
>>>>
>>>> _______________________________________________
>>>> Selinux mailing list
>>>> Selinux@tycho.nsa.gov
>>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>>> To get help, send an email containing "help" to
>>>> Selinux-request@tycho.nsa.gov.
>>>>
>>>
>>
>>
>> --
>> Kind regards,
>> Rahmadi Trimananda
>>
>> Ph.D. student @ University of California, Irvine
>> "Stay hungry, stay foolish!" - Steve Jobs -
>>
>>
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



-- 
Kind regards,
Rahmadi Trimananda

Ph.D. student @ University of California, Irvine
"Stay hungry, stay foolish!" - Steve Jobs -

--001a11468efed43785054c4e2b7b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">More info about javac.. according to some blogs/forums, ja=
vac/java has to be of type textrel_shlib_t, and I can see that it has the r=
ight type.<div><br></div><div><div>iotuser@raspberrypi:~/policy $ ls /usr/l=
ib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/javac -Z</div><div>system_u:object_r=
:textrel_shlib_t:SystemLow /usr/lib/jvm/jdk-8-oracle-arm32-vfp-hflt/bin/jav=
ac</div></div></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quot=
e">On Mon, Apr 3, 2017 at 7:35 PM, Rahmadi Trimananda <span dir=3D"ltr">&lt=
;<a href=3D"mailto:rtrimana@uci.edu" target=3D"_blank">rtrimana@uci.edu</a>=
&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0=
 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr">I hav=
e more error messages from /var/log/audit/audit.log if this is of any use f=
or you. And yeah, it works in permissive mode (sudo setenforce 0). BTW, wha=
t do you mean by &quot;run javac in strace&quot;?<div><br></div><div><div>i=
otuser@raspberrypi:~/policy $ sudo cat /var/log/audit/audit.log | grep java=
c</div><div>type=3DAVC msg=3Daudit(1491260813.624:793): avc: =C2=A0denied =
=C2=A0{ mmap_zero } for =C2=A0pid=3D1656 comm=3D&quot;javac&quot; scontext=
=3Dunconfined_u:<wbr>unconfined_r:unconfined_t:s0-<wbr>s0:c0.c1023 tcontext=
=3Dunconfined_u:<wbr>unconfined_r:unconfined_t:s0-<wbr>s0:c0.c1023 tclass=
=3Dmemprotect permissive=3D0</div><div>type=3DSYSCALL msg=3Daudit(149126081=
3.624:793): arch=3D40000028 syscall=3D11 per=3D800000 success=3Dno exit=3D-=
13 a0=3Db8c548 a1=3Db92cc8 a2=3Dae2408 a3=3D9c663500 items=3D0 ppid=3D989 p=
id=3D1656 auid=3D1001 uid=3D1001 gid=3D1001 euid=3D1001 suid=3D1001 fsuid=
=3D1001 egid=3D1001 sgid=3D1001 fsgid=3D1001 tty=3Dpts0 ses=3D3 comm=3D&quo=
t;javac&quot; exe=3D&quot;/usr/lib/jvm/jdk-8-<wbr>oracle-arm32-vfp-hflt/bin=
/<wbr>javac&quot; subj=3Dunconfined_u:unconfined_<wbr>r:unconfined_t:s0-s0:=
c0.c1023 key=3D(null)</div><div>type=3DANOM_ABEND msg=3Daudit(1491260813.63=
4:794): auid=3D1001 uid=3D1001 gid=3D1001 ses=3D3 subj=3Dunconfined_u:uncon=
fined_<wbr>r:unconfined_t:s0-s0:c0.c1023 pid=3D1656 comm=3D&quot;javac&quot=
; exe=3D&quot;/usr/lib/jvm/jdk-8-<wbr>oracle-arm32-vfp-hflt/bin/<wbr>javac&=
quot; sig=3D11</div><div>type=3DAVC msg=3Daudit(1491261632.611:875): avc: =
=C2=A0denied =C2=A0{ mmap_zero } for =C2=A0pid=3D1759 comm=3D&quot;javac&qu=
ot; scontext=3Dunconfined_u:<wbr>unconfined_r:unconfined_t:s0-<wbr>s0:c0.c1=
023 tcontext=3Dunconfined_u:<wbr>unconfined_r:unconfined_t:s0-<wbr>s0:c0.c1=
023 tclass=3Dmemprotect permissive=3D0</div><div>type=3DSYSCALL msg=3Daudit=
(1491261632.611:875): arch=3D40000028 syscall=3D11 per=3D800000 success=3Dn=
o exit=3D-13 a0=3Db47a68 a1=3Dbca488 a2=3Dae2408 a3=3D9c663500 items=3D0 pp=
id=3D989 pid=3D1759 auid=3D1001 uid=3D1001 gid=3D1001 euid=3D1001 suid=3D10=
01 fsuid=3D1001 egid=3D1001 sgid=3D1001 fsgid=3D1001 tty=3Dpts0 ses=3D3 com=
m=3D&quot;javac&quot; exe=3D&quot;/usr/lib/jvm/jdk-8-<wbr>oracle-arm32-vfp-=
hflt/bin/<wbr>javac&quot; subj=3Dunconfined_u:unconfined_<wbr>r:unconfined_=
t:s0-s0:c0.c1023 key=3D(null)</div><div>type=3DANOM_ABEND msg=3Daudit(14912=
61632.621:876): auid=3D1001 uid=3D1001 gid=3D1001 ses=3D3 subj=3Dunconfined=
_u:unconfined_<wbr>r:unconfined_t:s0-s0:c0.c1023 pid=3D1759 comm=3D&quot;ja=
vac&quot; exe=3D&quot;/usr/lib/jvm/jdk-8-<wbr>oracle-arm32-vfp-hflt/bin/<wb=
r>javac&quot; sig=3D11</div><div>type=3DAVC msg=3Daudit(1491262641.248:924)=
: avc: =C2=A0denied =C2=A0{ mmap_zero } for =C2=A0pid=3D1792 comm=3D&quot;j=
avac&quot; scontext=3Dunconfined_u:<wbr>unconfined_r:unconfined_t:s0-<wbr>s=
0:c0.c1023 tcontext=3Dunconfined_u:<wbr>unconfined_r:unconfined_t:s0-<wbr>s=
0:c0.c1023 tclass=3Dmemprotect permissive=3D0</div><div>type=3DSYSCALL msg=
=3Daudit(1491262641.248:924): arch=3D40000028 syscall=3D11 per=3D800000 suc=
cess=3Dno exit=3D-13 a0=3Da3ede8 a1=3Db88d68 a2=3Dae2408 a3=3D9c663500 item=
s=3D0 ppid=3D989 pid=3D1792 auid=3D1001 uid=3D1001 gid=3D1001 euid=3D1001 s=
uid=3D1001 fsuid=3D1001 egid=3D1001 sgid=3D1001 fsgid=3D1001 tty=3Dpts0 ses=
=3D3 comm=3D&quot;javac&quot; exe=3D&quot;/usr/lib/jvm/jdk-8-<wbr>oracle-ar=
m32-vfp-hflt/bin/<wbr>javac&quot; subj=3Dunconfined_u:unconfined_<wbr>r:unc=
onfined_t:s0-s0:c0.c1023 key=3D(null)</div><div>type=3DANOM_ABEND msg=3Daud=
it(1491262641.248:925): auid=3D1001 uid=3D1001 gid=3D1001 ses=3D3 subj=3Dun=
confined_u:unconfined_<wbr>r:unconfined_t:s0-s0:c0.c1023 pid=3D1792 comm=3D=
&quot;javac&quot; exe=3D&quot;/usr/lib/jvm/jdk-8-<wbr>oracle-arm32-vfp-hflt=
/bin/<wbr>javac&quot; sig=3D11</div><div>type=3DAVC msg=3Daudit(1491263457.=
665:1069)<wbr>: avc: =C2=A0denied =C2=A0{ mmap_zero } for =C2=A0pid=3D1945 =
comm=3D&quot;javac&quot; scontext=3Dunconfined_u:<wbr>unconfined_r:unconfin=
ed_t:s0-<wbr>s0:c0.c1023 tcontext=3Dunconfined_u:<wbr>unconfined_r:unconfin=
ed_t:s0-<wbr>s0:c0.c1023 tclass=3Dmemprotect permissive=3D0</div><div>type=
=3DSYSCALL msg=3Daudit(1491263457.665:1069)<wbr>: arch=3D40000028 syscall=
=3D11 per=3D800000 success=3Dno exit=3D-13 a0=3Db975e8 a1=3Db8b708 a2=3Dae2=
408 a3=3D9c663500 items=3D0 ppid=3D989 pid=3D1945 auid=3D1001 uid=3D1001 gi=
d=3D1001 euid=3D1001 suid=3D1001 fsuid=3D1001 egid=3D1001 sgid=3D1001 fsgid=
=3D1001 tty=3Dpts0 ses=3D3 comm=3D&quot;javac&quot; exe=3D&quot;/usr/lib/jv=
m/jdk-8-<wbr>oracle-arm32-vfp-hflt/bin/<wbr>javac&quot; subj=3Dunconfined_u=
:unconfined_<wbr>r:unconfined_t:s0-s0:c0.c1023 key=3D(null)</div><div>type=
=3DANOM_ABEND msg=3Daudit(1491263457.665:1070)<wbr>: auid=3D1001 uid=3D1001=
 gid=3D1001 ses=3D3 subj=3Dunconfined_u:unconfined_<wbr>r:unconfined_t:s0-s=
0:c0.c1023 pid=3D1945 comm=3D&quot;javac&quot; exe=3D&quot;/usr/lib/jvm/jdk=
-8-<wbr>oracle-arm32-vfp-hflt/bin/<wbr>javac&quot; sig=3D11</div><div>type=
=3DAVC msg=3Daudit(1491263668.304:1140)<wbr>: avc: =C2=A0denied =C2=A0{ mma=
p_zero } for =C2=A0pid=3D1977 comm=3D&quot;javac&quot; scontext=3Dunconfine=
d_u:<wbr>unconfined_r:unconfined_t:s0-<wbr>s0:c0.c1023 tcontext=3Dunconfine=
d_u:<wbr>unconfined_r:unconfined_t:s0-<wbr>s0:c0.c1023 tclass=3Dmemprotect =
permissive=3D0</div><div>type=3DSYSCALL msg=3Daudit(1491263668.304:1140)<wb=
r>: arch=3D40000028 syscall=3D11 per=3D800000 success=3Dno exit=3D-13 a0=3D=
b89d88 a1=3Db48ac8 a2=3Dae2408 a3=3D9c663500 items=3D0 ppid=3D989 pid=3D197=
7 auid=3D1001 uid=3D1001 gid=3D1001 euid=3D1001 suid=3D1001 fsuid=3D1001 eg=
id=3D1001 sgid=3D1001 fsgid=3D1001 tty=3Dpts0 ses=3D3 comm=3D&quot;javac&qu=
ot; exe=3D&quot;/usr/lib/jvm/jdk-8-<wbr>oracle-arm32-vfp-hflt/bin/<wbr>java=
c&quot; subj=3Dunconfined_u:unconfined_<wbr>r:unconfined_t:s0-s0:c0.c1023 k=
ey=3D(null)</div><div>type=3DANOM_ABEND msg=3Daudit(1491263668.304:1141)<wb=
r>: auid=3D1001 uid=3D1001 gid=3D1001 ses=3D3 subj=3Dunconfined_u:unconfine=
d_<wbr>r:unconfined_t:s0-s0:c0.c1023 pid=3D1977 comm=3D&quot;javac&quot; ex=
e=3D&quot;/usr/lib/jvm/jdk-8-<wbr>oracle-arm32-vfp-hflt/bin/<wbr>javac&quot=
; sig=3D11</div><div>type=3DAVC msg=3Daudit(1491273121.724:1264)<wbr>: avc:=
 =C2=A0denied =C2=A0{ mmap_zero } for =C2=A0pid=3D2176 comm=3D&quot;javac&q=
uot; scontext=3Dunconfined_u:<wbr>unconfined_r:unconfined_t:s0-<wbr>s0:c0.c=
1023 tcontext=3Dunconfined_u:<wbr>unconfined_r:unconfined_t:s0-<wbr>s0:c0.c=
1023 tclass=3Dmemprotect permissive=3D1</div><div>type=3DSYSCALL msg=3Daudi=
t(1491273121.724:1264)<wbr>: arch=3D40000028 syscall=3D11 per=3D800000 succ=
ess=3Dyes exit=3D0 a0=3Dfd27c8 a1=3Df44a68 a2=3Dfb4408 a3=3D55428f00 items=
=3D0 ppid=3D2125 pid=3D2176 auid=3D1001 uid=3D1001 gid=3D1001 euid=3D1001 s=
uid=3D1001 fsuid=3D1001 egid=3D1001 sgid=3D1001 fsgid=3D1001 tty=3Dpts3 ses=
=3D11 comm=3D&quot;javac&quot; exe=3D&quot;/usr/lib/jvm/jdk-8-<wbr>oracle-a=
rm32-vfp-hflt/bin/<wbr>javac&quot; subj=3Dunconfined_u:unconfined_<wbr>r:un=
confined_t:s0-s0:c0.c1023 key=3D(null)</div><div>type=3DPROCTITLE msg=3Daud=
it(1491273121.724:1264)<wbr>: proctitle=3D&quot;javac&quot;</div><div>type=
=3DAVC msg=3Daudit(1491273200.654:1273)<wbr>: avc: =C2=A0denied =C2=A0{ mma=
p_zero } for =C2=A0pid=3D2190 comm=3D&quot;javac&quot; scontext=3Dunconfine=
d_u:<wbr>unconfined_r:unconfined_t:s0-<wbr>s0:c0.c1023 tcontext=3Dunconfine=
d_u:<wbr>unconfined_r:unconfined_t:s0-<wbr>s0:c0.c1023 tclass=3Dmemprotect =
permissive=3D0</div><div>type=3DSYSCALL msg=3Daudit(1491273200.654:1273)<wb=
r>: arch=3D40000028 syscall=3D11 per=3D800000 success=3Dno exit=3D-13 a0=3D=
1019f28 a1=3D1020668 a2=3Dfb4408 a3=3D55428f00 items=3D0 ppid=3D2125 pid=3D=
2190 auid=3D1001 uid=3D1001 gid=3D1001 euid=3D1001 suid=3D1001 fsuid=3D1001=
 egid=3D1001 sgid=3D1001 fsgid=3D1001 tty=3Dpts3 ses=3D11 comm=3D&quot;java=
c&quot; exe=3D&quot;/usr/lib/jvm/jdk-8-<wbr>oracle-arm32-vfp-hflt/bin/<wbr>=
javac&quot; subj=3Dunconfined_u:unconfined_<wbr>r:unconfined_t:s0-s0:c0.c10=
23 key=3D(null)</div><div>type=3DANOM_ABEND msg=3Daudit(1491273200.654:1274=
)<wbr>: auid=3D1001 uid=3D1001 gid=3D1001 ses=3D11 subj=3Dunconfined_u:unco=
nfined_<wbr>r:unconfined_t:s0-s0:c0.c1023 pid=3D2190 comm=3D&quot;javac&quo=
t; exe=3D&quot;/usr/lib/jvm/jdk-8-<wbr>oracle-arm32-vfp-hflt/bin javac&quot=
; sig=3D11</div></div></div><div class=3D"HOEnZb"><div class=3D"h5"><div cl=
ass=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Apr 3, 2017 at 7=
:17 PM, William Roberts <span dir=3D"ltr">&lt;<a href=3D"mailto:bill.c.robe=
rts@gmail.com" target=3D"_blank">bill.c.roberts@gmail.com</a>&gt;</span> wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex"><div dir=3D"auto"><span><div><br><di=
v class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Apr 3, 2017 19:12=
, &quot;Rahmadi Trimananda&quot; &lt;<a href=3D"mailto:rtrimana@uci.edu" ta=
rget=3D"_blank">rtrimana@uci.edu</a>&gt; wrote:<br type=3D"attribution"><bl=
ockquote class=3D"m_-2720424961895022m_75545402670596028quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr=
">This is the result of &quot;dmesg | grep avc&quot;. Please let me know if=
 you need more information about my system (RaspberryPi 2 running Raspbian =
Jessie).<div><br></div><div><div>[ =C2=A0 =C2=A02.275229] audit: type=3D140=
0 audit(2.249:3): avc: =C2=A0denied =C2=A0{ associate } for =C2=A0pid=3D1 c=
omm=3D&quot;systemd&quot; name=3D&quot;pts&quot; scontext=3Dsystem_u:object=
_r:dev<wbr>pts_t:s0 tcontext=3Dsystem_u:object_r:dev<wbr>ice_t:s0 tclass=3D=
filesystem permissive=3D1</div><div>[ =C2=A0 =C2=A02.577155] audit: type=3D=
1400 audit(2.549:4): avc: =C2=A0denied =C2=A0{ wake_alarm } for =C2=A0pid=
=3D1 comm=3D&quot;systemd&quot; capability=3D35 =C2=A0scontext=3Dsystem_u:s=
ystem_r:in<wbr>it_t:s0 tcontext=3Dsystem_u:system_r:ini<wbr>t_t:s0 tclass=
=3Dcapability2 permissive=3D1</div><div>[ =C2=A0 =C2=A02.601211] audit: typ=
e=3D1400 audit(2.569:5): avc: =C2=A0denied =C2=A0{ execstack } for =C2=A0pi=
d=3D95 comm=3D&quot;systemd-fstab-g&quot; scontext=3Dsystem_u:system_r:ini<=
wbr>t_t:s0 tcontext=3Dsystem_u:system_r:ini<wbr>t_t:s0 tclass=3Dprocess per=
missive=3D1</div><div>[ =C2=A0 =C2=A02.601321] audit: type=3D1400 audit(2.5=
69:6): avc: =C2=A0denied =C2=A0{ execmem } for =C2=A0pid=3D95 comm=3D&quot;=
systemd-fstab-g&quot; scontext=3Dsystem_u:system_r:ini<wbr>t_t:s0 tcontext=
=3Dsystem_u:system_r:ini<wbr>t_t:s0 tclass=3Dprocess permissive=3D1</div><d=
iv>[ =C2=A0 =C2=A02.605393] audit: type=3D1400 audit(2.579:7): avc: =C2=A0d=
enied =C2=A0{ execmod } for =C2=A0pid=3D95 comm=3D&quot;systemd-fstab-g&quo=
t; path=3D&quot;/usr/lib/arm-linux-gnuea<wbr>bihf/libarmmem.so&quot; dev=3D=
&quot;mmcblk0p2&quot; ino=3D144391 scontext=3Dsystem_u:system_r:ini<wbr>t_t=
:s0 tcontext=3Dsystem_u:object_r:lib<wbr>_t:s0 tclass=3Dfile permissive=3D1=
</div><div>[ =C2=A0 =C2=A03.201440] audit: type=3D1400 audit(3.169:8): avc:=
 =C2=A0denied =C2=A0{ execstack } for =C2=A0pid=3D107 comm=3D&quot;mount&qu=
ot; scontext=3Dsystem_u:system_r:mou<wbr>nt_t:s0 tcontext=3Dsystem_u:system=
_r:mou<wbr>nt_t:s0 tclass=3Dprocess permissive=3D1</div><div>[ =C2=A0 =C2=
=A03.201499] audit: type=3D1400 audit(3.169:9): avc: =C2=A0denied =C2=A0{ e=
xecmem } for =C2=A0pid=3D107 comm=3D&quot;mount&quot; scontext=3Dsystem_u:s=
ystem_r:mou<wbr>nt_t:s0 tcontext=3Dsystem_u:system_r:mou<wbr>nt_t:s0 tclass=
=3Dprocess permissive=3D1</div><div>[ =C2=A0 =C2=A03.217575] audit: type=3D=
1400 audit(3.189:10): avc: =C2=A0denied =C2=A0{ execstack } for =C2=A0pid=
=3D108 comm=3D&quot;kmod&quot; scontext=3Dsystem_u:system_r:ins<wbr>mod_t:s=
0 tcontext=3Dsystem_u:system_r:ins<wbr>mod_t:s0 tclass=3Dprocess permissive=
=3D1</div><div>[ =C2=A0 =C2=A05.291711] audit: type=3D1400 audit(1491249900=
.889:59): avc: =C2=A0denied =C2=A0{ mmap_zero } for =C2=A0pid=3D243 comm=3D=
&quot;alsactl&quot; scontext=3Dsystem_u:system_r:als<wbr>a_t:s0-s0:c0.c1023=
 tcontext=3Dsystem_u:system_r:als<wbr>a_t:s0-s0:c0.c1023 tclass=3Dmemprotec=
t permissive=3D1</div><div>[ =C2=A0 =C2=A05.304205] audit: type=3D1400 audi=
t(1491249900.909:60): avc: =C2=A0denied =C2=A0{ execstack } for =C2=A0pid=
=3D243 comm=3D&quot;alsactl&quot; scontext=3Dsystem_u:system_r:als<wbr>a_t:=
s0-s0:c0.c1023 tcontext=3Dsystem_u:system_r:als<wbr>a_t:s0-s0:c0.c1023 tcla=
ss=3Dprocess permissive=3D1</div><div>[ =C2=A0 =C2=A05.304582] audit: type=
=3D1400 audit(1491249900.909:61): avc: =C2=A0denied =C2=A0{ execmem } for =
=C2=A0pid=3D243 comm=3D&quot;alsactl&quot; scontext=3Dsystem_u:system_r:als=
<wbr>a_t:s0-s0:c0.c1023 tcontext=3Dsystem_u:system_r:als<wbr>a_t:s0-s0:c0.c=
1023 tclass=3Dprocess permissive=3D1</div><div>[ =C2=A0 =C2=A05.306197] aud=
it: type=3D1400 audit(1491249900.909:62): avc: =C2=A0denied =C2=A0{ use } f=
or =C2=A0pid=3D120 comm=3D&quot;systemd-journal&quot; path=3D&quot;/dev/pts=
/0&quot; dev=3D&quot;devpts&quot; ino=3D3 scontext=3Dsystem_u:system_r:sys<=
wbr>logd_t:s0 tcontext=3Dsystem_u:system_r:ply<wbr>mouthd_t:s0 tclass=3Dfd =
permissive=3D1</div><div>[ =C2=A0 =C2=A05.355105] audit: type=3D1400 audit(=
1491249900.959:63): avc: =C2=A0denied =C2=A0{ execmod } for =C2=A0pid=3D243=
 comm=3D&quot;alsactl&quot; path=3D&quot;/usr/lib/arm-linux-gnuea<wbr>bihf/=
libarmmem.so&quot; dev=3D&quot;mmcblk0p2&quot; ino=3D144391 scontext=3Dsyst=
em_u:system_r:als<wbr>a_t:s0-s0:c0.c1023 tcontext=3Dsystem_u:object_r:lib<w=
br>_t:s0 tclass=3Dfile permissive=3D1</div><div>[ =C2=A0 =C2=A05.357519] au=
dit: type=3D1400 audit(1491249900.959:64): avc: =C2=A0denied =C2=A0{ write =
} for =C2=A0pid=3D243 comm=3D&quot;alsactl&quot; name=3D&quot;/&quot; dev=
=3D&quot;tmpfs&quot; ino=3D5104 scontext=3Dsystem_u:system_r:als<wbr>a_t:s0=
-s0:c0.c1023 tcontext=3Dsystem_u:object_r:var<wbr>_lock_t:s0 tclass=3Ddir p=
ermissive=3D1</div><div>[ =C2=A0 =C2=A05.357705] audit: type=3D1400 audit(1=
491249900.959:65): avc: =C2=A0denied =C2=A0{ add_name } for =C2=A0pid=3D243=
 comm=3D&quot;alsactl&quot; name=3D&quot;asound.state.lock&quot; scontext=
=3Dsystem_u:system_r:als<wbr>a_t:s0-s0:c0.c1023 tcontext=3Dsystem_u:object_=
r:var<wbr>_lock_t:s0 tclass=3Ddir permissive=3D1</div><div>[ =C2=A0 =C2=A05=
.358083] audit: type=3D1400 audit(1491249900.959:66): avc: =C2=A0denied =C2=
=A0{ create } for =C2=A0pid=3D243 comm=3D&quot;alsactl&quot; name=3D&quot;a=
sound.state.lock&quot; scontext=3Dsystem_u:system_r:als<wbr>a_t:s0-s0:c0.c1=
023 tcontext=3Dsystem_u:object_r:var<wbr>_lock_t:s0 tclass=3Dfile permissiv=
e=3D1</div><div>[ =C2=A0 =C2=A05.358671] audit: type=3D1400 audit(149124990=
0.959:67): avc: =C2=A0denied =C2=A0{ read write open } for =C2=A0pid=3D243 =
comm=3D&quot;alsactl&quot; path=3D&quot;/run/lock/asound.state.l<wbr>ock&qu=
ot; dev=3D&quot;tmpfs&quot; ino=3D1816 scontext=3Dsystem_u:system_r:als<wbr=
>a_t:s0-s0:c0.c1023 tcontext=3Dsystem_u:object_r:var<wbr>_lock_t:s0 tclass=
=3Dfile permissive=3D1</div><div>[ =C2=A0 =C2=A05.358893] audit: type=3D140=
0 audit(1491249900.959:68): avc: =C2=A0denied =C2=A0{ getattr } for =C2=A0p=
id=3D243 comm=3D&quot;alsactl&quot; path=3D&quot;/run/lock/asound.state.l<w=
br>ock&quot; dev=3D&quot;tmpfs&quot; ino=3D1816 scontext=3Dsystem_u:system_=
r:als<wbr>a_t:s0-s0:c0.c1023 tcontext=3Dsystem_u:object_r:var<wbr>_lock_t:s=
0 tclass=3Dfile permissive=3D1</div></div></div></blockquote></div></div></=
div><div dir=3D"auto"><br></div><div dir=3D"auto"><br></div></span><div dir=
=3D"auto">I don&#39;t see anything that would prevent running javac offhand=
, perhaps others more versed in the desktop side can help tomorrow morning.=
</div><div dir=3D"auto"><br></div><div dir=3D"auto">Make sure you run javac=
 so we can see any avc messages generated for it. Also run javac in strace =
and see where it&#39;s dying. Does this work in permissive mode? Ie sudo se=
tenforce 0?</div><span><div dir=3D"auto"><br></div><div dir=3D"auto"><div c=
lass=3D"gmail_extra"><div class=3D"gmail_quote"><blockquote class=3D"m_-272=
0424961895022m_75545402670596028quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex"><div class=3D"gmail_extra"><div class=
=3D"m_-2720424961895022m_75545402670596028elided-text"><br><div class=3D"gm=
ail_quote">On Mon, Apr 3, 2017 at 6:54 PM, William Roberts <span dir=3D"ltr=
">&lt;<a href=3D"mailto:bill.c.roberts@gmail.com" target=3D"_blank">bill.c.=
roberts@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><=
div dir=3D"auto">Do you see any &quot;avc: denied&quot; messages in dmesg/s=
yslog? If so send them.</div><div class=3D"gmail_extra"><br><div class=3D"g=
mail_quote"><div><div class=3D"m_-2720424961895022m_75545402670596028m_4915=
809492275190614h5">On Apr 3, 2017 16:28, &quot;Rahmadi Trimananda&quot; &lt=
;<a href=3D"mailto:rtrimana@uci.edu" target=3D"_blank">rtrimana@uci.edu</a>=
&gt; wrote:<br type=3D"attribution"></div></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex"><div><div class=3D"m_-2720424961895022m_75545402670596028m_491580949227=
5190614h5"><div dir=3D"ltr">Hi All,<div><br></div><div>I am trying to run j=
avac and java on my Raspbian while SELinux is enabled. However, I keep gett=
ing &quot;Segmentation fault&quot;, even when I just run &quot;javac&quot; =
or &quot;java&quot;. This happens in enforcing mode, but it doesn&#39;t hap=
pen with &quot;gcc&quot;. I am wondering why, because both are in /usr/bin =
directory and both binaries have the same context.</div><div><br></div><div=
>Can somebody please help?</div><div><br></div><div>Thank you so much!</div=
><div><br></div><div>Regards,</div><div>Rahmadi</div><div class=3D"gmail_ex=
tra"><br>
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
=3D"#888888">-- <br><div class=3D"m_-2720424961895022m_75545402670596028m_4=
915809492275190614gmail_signature" data-smartmail=3D"gmail_signature"><div =
dir=3D"ltr">Kind regards,<div>Rahmadi Trimananda</div><div><br></div><div>P=
h.D. student @ University of California, Irvine</div><div>&quot;Stay hungry=
, stay foolish!&quot; - Steve Jobs -</div></div></div>
</font></div>
</blockquote></div><br></div></div></span></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"m_-2720424961895022gmail_signature" data-smartmail=3D"gmail_signature">=
<div dir=3D"ltr">Kind regards,<div>Rahmadi Trimananda</div><div><br></div><=
div>Ph.D. student @ University of California, Irvine</div><div>&quot;Stay h=
ungry, stay foolish!&quot; - Steve Jobs -</div></div></div>
</div>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr">Kind regards,<div>Rahmadi Trimananda</div><div><br></div><div>Ph.D=
. student @ University of California, Irvine</div><div>&quot;Stay hungry, s=
tay foolish!&quot; - Steve Jobs -</div></div></div>
</div>

--001a11468efed43785054c4e2b7b--
