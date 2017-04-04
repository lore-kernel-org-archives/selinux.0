Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v34Fi62M032156
 for <selinux@tycho.nsa.gov>; Tue, 4 Apr 2017 11:44:07 -0400
Received: by mail-wr0-f175.google.com with SMTP id k6so214177243wre.2
 for <selinux@tycho.nsa.gov>; Tue, 04 Apr 2017 08:44:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1491317258.31785.11.camel@tycho.nsa.gov>
References: <CAHFUiBOa186qydQ5VBeEmcMMinQnpkwBPMx91Aq-GAq4TvSm-g@mail.gmail.com>
 <CAFftDdrVEKxgp69KrUrfyzD8hPuYOBtKgGhb_JWKCKrmd2PqhQ@mail.gmail.com>
 <CAHFUiBNnbdfvqneUo5dH4+4e_1Df6HrbmBGaQQ76SQpi6AXvBg@mail.gmail.com>
 <1491317258.31785.11.camel@tycho.nsa.gov>
From: Rahmadi Trimananda <rtrimana@uci.edu>
Date: Tue, 4 Apr 2017 08:44:00 -0700
Message-ID: <CAHFUiBOJPfFx--UhsokUXX8yR8Jqq-Q46SVX1bwvTHWZiPu-=w@mail.gmail.com>
Subject: Re: Running Java and JVM on SELinux
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: William Roberts <bill.c.roberts@gmail.com>,
 Russell Coker <russell@coker.com.au>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f403045f1652168ef2054c5925c8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--f403045f1652168ef2054c5925c8
Content-Type: text/plain; charset=UTF-8

Thanks Guys! Actually I tried the OpenJDK Java and Javac and it solves the
problem. I'll try to deal with the other permission problems later as I
build up my knowledge.

I'll ask more questions in a separate thread about policies as I found less
examples online about generating local policies.
Thanks!

On Tue, Apr 4, 2017 at 7:47 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Mon, 2017-04-03 at 19:12 -0700, Rahmadi Trimananda wrote:
> > This is the result of "dmesg | grep avc". Please let me know if you
> > need more information about my system (RaspberryPi 2 running Raspbian
> > Jessie).
> >
> > [    2.275229] audit: type=1400 audit(2.249:3): avc:  denied  {
> > associate } for  pid=1 comm="systemd" name="pts"
> > scontext=system_u:object_r:devpts_t:s0
> > tcontext=system_u:object_r:device_t:s0 tclass=filesystem permissive=1
> > [    2.577155] audit: type=1400 audit(2.549:4): avc:  denied  {
> > wake_alarm } for  pid=1 comm="systemd" capability=35
> >  scontext=system_u:system_r:init_t:s0
> > tcontext=system_u:system_r:init_t:s0 tclass=capability2 permissive=1
>
> These two are harmless and allowed in Fedora policy.
>
> > [    2.601211] audit: type=1400 audit(2.569:5): avc:  denied  {
> > execstack } for  pid=95 comm="systemd-fstab-g"
> > scontext=system_u:system_r:init_t:s0
> > tcontext=system_u:system_r:init_t:s0 tclass=process permissive=1
> > [    2.601321] audit: type=1400 audit(2.569:6): avc:  denied  {
> > execmem } for  pid=95 comm="systemd-fstab-g"
> > scontext=system_u:system_r:init_t:s0
> > tcontext=system_u:system_r:init_t:s0 tclass=process permissive=1
>
> These two are undesirable for security.  Suggests that your userspace
> binaries are legacy or built insecurely, with RWE segments.
>
> > [    2.605393] audit: type=1400 audit(2.579:7): avc:  denied  {
> > execmod } for  pid=95 comm="systemd-fstab-g" path="/usr/lib/arm-
> > linux-gnueabihf/libarmmem.so" dev="mmcblk0p2" ino=144391
> > scontext=system_u:system_r:init_t:s0
> > tcontext=system_u:object_r:lib_t:s0 tclass=file permissive=1
>
> This implies that this particular .so file should be assigned the
> textrel_shlib_t type instead.
>
> > [    3.201440] audit: type=1400 audit(3.169:8): avc:  denied  {
> > execstack } for  pid=107 comm="mount"
> > scontext=system_u:system_r:mount_t:s0
> > tcontext=system_u:system_r:mount_t:s0 tclass=process permissive=1
> > [    3.201499] audit: type=1400 audit(3.169:9): avc:  denied  {
> > execmem } for  pid=107 comm="mount"
> > scontext=system_u:system_r:mount_t:s0
> > tcontext=system_u:system_r:mount_t:s0 tclass=process permissive=1
> > [    3.217575] audit: type=1400 audit(3.189:10): avc:  denied  {
> > execstack } for  pid=108 comm="kmod"
> > scontext=system_u:system_r:insmod_t:s0
> > tcontext=system_u:system_r:insmod_t:s0 tclass=process permissive=1
>
> These fall into the same category as the init_t denials above; not
> desirable; indicate legacy or insecurely built userspace.
>
> > [    5.291711] audit: type=1400 audit(1491249900.889:59): avc:
> >  denied  { mmap_zero } for  pid=243 comm="alsactl"
> > scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
> > tcontext=system_u:system_r:alsa_t:s0-s0:c0.c1023 tclass=memprotect
> > permissive=1
>
> This along with your java denials raises a question about your kernel
> config, particularly the value of CONFIG_LSM_MMAP_MIN_ADDR.  Should
> match the value of /proc/sys/vm/mmap_min_addr in general.  Defaults to
> 32K for ARM, 64K for others.
>
> > [    5.304205] audit: type=1400 audit(1491249900.909:60): avc:
> >  denied  { execstack } for  pid=243 comm="alsactl"
> > scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
> > tcontext=system_u:system_r:alsa_t:s0-s0:c0.c1023 tclass=process
> > permissive=1
> > [    5.304582] audit: type=1400 audit(1491249900.909:61): avc:
> >  denied  { execmem } for  pid=243 comm="alsactl"
> > scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
> > tcontext=system_u:system_r:alsa_t:s0-s0:c0.c1023 tclass=process
> > permissive=1
>
> More evidence of insecure userspace.
>
> > [    5.306197] audit: type=1400 audit(1491249900.909:62): avc:
> >  denied  { use } for  pid=120 comm="systemd-journal"
> > path="/dev/pts/0" dev="devpts" ino=3
> > scontext=system_u:system_r:syslogd_t:s0
> > tcontext=system_u:system_r:plymouthd_t:s0 tclass=fd permissive=1
>
> Harmless, allow.
>
> > [    5.355105] audit: type=1400 audit(1491249900.959:63): avc:
> >  denied  { execmod } for  pid=243 comm="alsactl" path="/usr/lib/arm-
> > linux-gnueabihf/libarmmem.so" dev="mmcblk0p2" ino=144391
> > scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
> > tcontext=system_u:object_r:lib_t:s0 tclass=file permissive=1
>
> Label with textrel_shlib_t.
>
> > [    5.357519] audit: type=1400 audit(1491249900.959:64): avc:
> >  denied  { write } for  pid=243 comm="alsactl" name="/" dev="tmpfs"
> > ino=5104 scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
> > tcontext=system_u:object_r:var_lock_t:s0 tclass=dir permissive=1
> > [    5.357705] audit: type=1400 audit(1491249900.959:65): avc:
> >  denied  { add_name } for  pid=243 comm="alsactl"
> > name="asound.state.lock" scontext=system_u:system_r:alsa_t:s0-
> > s0:c0.c1023 tcontext=system_u:object_r:var_lock_t:s0 tclass=dir
> > permissive=1
> > [    5.358083] audit: type=1400 audit(1491249900.959:66): avc:
> >  denied  { create } for  pid=243 comm="alsactl"
> > name="asound.state.lock" scontext=system_u:system_r:alsa_t:s0-
> > s0:c0.c1023 tcontext=system_u:object_r:var_lock_t:s0 tclass=file
> > permissive=1
> > [    5.358671] audit: type=1400 audit(1491249900.959:67): avc:
> >  denied  { read write open } for  pid=243 comm="alsactl"
> > path="/run/lock/asound.state.lock" dev="tmpfs" ino=1816
> > scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
> > tcontext=system_u:object_r:var_lock_t:s0 tclass=file permissive=1
> > [    5.358893] audit: type=1400 audit(1491249900.959:68): avc:
> >  denied  { getattr } for  pid=243 comm="alsactl"
> > path="/run/lock/asound.state.lock" dev="tmpfs" ino=1816
> > scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
> > tcontext=system_u:object_r:var_lock_t:s0 tclass=file permissive=1
>
> Allowed by current refpolicy,
> commit efce2657e248b5b0ff61fc05e5cae036760a1294
> Author: Sven Vermeulen <sven.vermeulen@siphos.be>
> Date:   Sat Jul 5 18:19:14 2014 +0200
>
>     Enable asound.state.lock support
>
>     asound.state.lock file when managing alsa state operations.
>
>     Signed-off-by: Sven Vermeulen <sven.vermeulen@siphos.be>
>
> diff --git a/alsa.te b/alsa.te
> index 814b426..6f7f2f9 100644
> --- a/alsa.te
> +++ b/alsa.te
> @@ -24,6 +24,9 @@ files_tmpfs_file(alsa_tmpfs_t)
>  type alsa_var_lib_t;
>  files_type(alsa_var_lib_t)
>
> +type alsa_var_lock_t;
> +files_lock_file(alsa_var_lock_t)
> +
>  type alsa_home_t;
>  userdom_user_home_content(alsa_home_t)
>
> @@ -57,6 +60,9 @@ fs_tmpfs_filetrans(alsa_t, alsa_tmpfs_t, file)
>  manage_dirs_pattern(alsa_t, alsa_var_lib_t, alsa_var_lib_t)
>  manage_files_pattern(alsa_t, alsa_var_lib_t, alsa_var_lib_t)
>
> +allow alsa_t alsa_var_lock_t:file manage_file_perms;
> +files_lock_filetrans(alsa_t, alsa_var_lock_t, file);
> +
>  kernel_read_system_state(alsa_t)
>
>  corecmd_exec_bin(alsa_t)
>
> >
> > On Mon, Apr 3, 2017 at 6:54 PM, William Roberts <bill.c.roberts@gmail
> > .com> wrote:
> > > Do you see any "avc: denied" messages in dmesg/syslog? If so send
> > > them.
> > >
> > > On Apr 3, 2017 16:28, "Rahmadi Trimananda" <rtrimana@uci.edu>
> > > wrote:
> > > > Hi All,
> > > >
> > > > I am trying to run javac and java on my Raspbian while SELinux is
> > > > enabled. However, I keep getting "Segmentation fault", even when
> > > > I just run "javac" or "java". This happens in enforcing mode, but
> > > > it doesn't happen with "gcc". I am wondering why, because both
> > > > are in /usr/bin directory and both binaries have the same
> > > > context.
> > > >
> > > > Can somebody please help?
> > > >
> > > > Thank you so much!
> > > >
> > > > Regards,
> > > > Rahmadi
> > > >
> > > >
> > > > _______________________________________________
> > > > Selinux mailing list
> > > > Selinux@tycho.nsa.gov
> > > > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > > > To get help, send an email containing "help" to Selinux-request@t
> > > > ycho.nsa.gov.
> >
> >
> >
> > --
> > Kind regards,
> > Rahmadi Trimananda
> >
> > Ph.D. student @ University of California, Irvine
> > "Stay hungry, stay foolish!" - Steve Jobs -
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to Selinux-request@tycho
> > .nsa.gov.
>



-- 
Kind regards,
Rahmadi Trimananda

Ph.D. student @ University of California, Irvine
"Stay hungry, stay foolish!" - Steve Jobs -

--f403045f1652168ef2054c5925c8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Guys! Actually I tried the OpenJDK Java and Javac a=
nd it solves the problem. I&#39;ll try to deal with the other permission pr=
oblems later as I build up my knowledge.<div><br></div><div>I&#39;ll ask mo=
re questions in a separate thread about policies as I found less examples o=
nline about generating local policies.</div><div>Thanks!</div></div><div cl=
ass=3D"gmail_extra"><br><div class=3D"gmail_quote">On Tue, Apr 4, 2017 at 7=
:47 AM, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.n=
sa.gov" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex"><span class=3D"">On Mon, 2017-04-03 at 19:12 -0700=
, Rahmadi Trimananda wrote:<br>
&gt; This is the result of &quot;dmesg | grep avc&quot;. Please let me know=
 if you<br>
&gt; need more information about my system (RaspberryPi 2 running Raspbian<=
br>
&gt; Jessie).<br>
&gt;<br>
&gt; [ =C2=A0 =C2=A02.275229] audit: type=3D1400 audit(2.249:3): avc: =C2=
=A0denied =C2=A0{<br>
&gt; associate } for =C2=A0pid=3D1 comm=3D&quot;systemd&quot; name=3D&quot;=
pts&quot;<br>
&gt; scontext=3Dsystem_u:object_r:<wbr>devpts_t:s0<br>
&gt; tcontext=3Dsystem_u:object_r:<wbr>device_t:s0 tclass=3Dfilesystem perm=
issive=3D1<br>
&gt; [ =C2=A0 =C2=A02.577155] audit: type=3D1400 audit(2.549:4): avc: =C2=
=A0denied =C2=A0{<br>
&gt; wake_alarm } for =C2=A0pid=3D1 comm=3D&quot;systemd&quot; capability=
=3D35<br>
&gt; =C2=A0scontext=3Dsystem_u:system_r:<wbr>init_t:s0<br>
&gt; tcontext=3Dsystem_u:system_r:<wbr>init_t:s0 tclass=3Dcapability2 permi=
ssive=3D1<br>
<br>
</span>These two are harmless and allowed in Fedora policy.<br>
<span class=3D""><br>
&gt; [ =C2=A0 =C2=A02.601211] audit: type=3D1400 audit(2.569:5): avc: =C2=
=A0denied =C2=A0{<br>
&gt; execstack } for =C2=A0pid=3D95 comm=3D&quot;systemd-fstab-g&quot;<br>
&gt; scontext=3Dsystem_u:system_r:<wbr>init_t:s0<br>
&gt; tcontext=3Dsystem_u:system_r:<wbr>init_t:s0 tclass=3Dprocess permissiv=
e=3D1<br>
&gt; [ =C2=A0 =C2=A02.601321] audit: type=3D1400 audit(2.569:6): avc: =C2=
=A0denied =C2=A0{<br>
&gt; execmem } for =C2=A0pid=3D95 comm=3D&quot;systemd-fstab-g&quot;<br>
&gt; scontext=3Dsystem_u:system_r:<wbr>init_t:s0<br>
&gt; tcontext=3Dsystem_u:system_r:<wbr>init_t:s0 tclass=3Dprocess permissiv=
e=3D1<br>
<br>
</span>These two are undesirable for security.=C2=A0 Suggests that your use=
rspace<br>
binaries are legacy or built insecurely, with RWE segments.<br>
<span class=3D""><br>
&gt; [ =C2=A0 =C2=A02.605393] audit: type=3D1400 audit(2.579:7): avc: =C2=
=A0denied =C2=A0{<br>
&gt; execmod } for =C2=A0pid=3D95 comm=3D&quot;systemd-fstab-g&quot; path=
=3D&quot;/usr/lib/arm-<br>
&gt; linux-gnueabihf/libarmmem.so&quot; dev=3D&quot;mmcblk0p2&quot; ino=3D1=
44391<br>
&gt; scontext=3Dsystem_u:system_r:<wbr>init_t:s0<br>
&gt; tcontext=3Dsystem_u:object_r:<wbr>lib_t:s0 tclass=3Dfile permissive=3D=
1<br>
<br>
</span>This implies that this particular .so file should be assigned the<br=
>
textrel_shlib_t type instead.<br>
<span class=3D""><br>
&gt; [ =C2=A0 =C2=A03.201440] audit: type=3D1400 audit(3.169:8): avc: =C2=
=A0denied =C2=A0{<br>
&gt; execstack } for =C2=A0pid=3D107 comm=3D&quot;mount&quot;<br>
&gt; scontext=3Dsystem_u:system_r:<wbr>mount_t:s0<br>
&gt; tcontext=3Dsystem_u:system_r:<wbr>mount_t:s0 tclass=3Dprocess permissi=
ve=3D1<br>
&gt; [ =C2=A0 =C2=A03.201499] audit: type=3D1400 audit(3.169:9): avc: =C2=
=A0denied =C2=A0{<br>
&gt; execmem } for =C2=A0pid=3D107 comm=3D&quot;mount&quot;<br>
&gt; scontext=3Dsystem_u:system_r:<wbr>mount_t:s0<br>
&gt; tcontext=3Dsystem_u:system_r:<wbr>mount_t:s0 tclass=3Dprocess permissi=
ve=3D1<br>
&gt; [ =C2=A0 =C2=A03.217575] audit: type=3D1400 audit(3.189:10): avc: =C2=
=A0denied =C2=A0{<br>
&gt; execstack } for =C2=A0pid=3D108 comm=3D&quot;kmod&quot;<br>
&gt; scontext=3Dsystem_u:system_r:<wbr>insmod_t:s0<br>
&gt; tcontext=3Dsystem_u:system_r:<wbr>insmod_t:s0 tclass=3Dprocess permiss=
ive=3D1<br>
<br>
</span>These fall into the same category as the init_t denials above; not<b=
r>
desirable; indicate legacy or insecurely built userspace.<br>
<span class=3D""><br>
&gt; [ =C2=A0 =C2=A05.291711] audit: type=3D1400 audit(1491249900.889:59): =
avc:<br>
&gt; =C2=A0denied =C2=A0{ mmap_zero } for =C2=A0pid=3D243 comm=3D&quot;alsa=
ctl&quot;<br>
&gt; scontext=3Dsystem_u:system_r:<wbr>alsa_t:s0-s0:c0.c1023<br>
&gt; tcontext=3Dsystem_u:system_r:<wbr>alsa_t:s0-s0:c0.c1023 tclass=3Dmempr=
otect<br>
&gt; permissive=3D1<br>
<br>
</span>This along with your java denials raises a question about your kerne=
l<br>
config, particularly the value of CONFIG_LSM_MMAP_MIN_ADDR.=C2=A0 Should<br=
>
match the value of /proc/sys/vm/mmap_min_addr in general.=C2=A0 Defaults to=
<br>
32K for ARM, 64K for others.<br>
<span class=3D""><br>
&gt; [ =C2=A0 =C2=A05.304205] audit: type=3D1400 audit(1491249900.909:60): =
avc:<br>
&gt; =C2=A0denied =C2=A0{ execstack } for =C2=A0pid=3D243 comm=3D&quot;alsa=
ctl&quot;<br>
&gt; scontext=3Dsystem_u:system_r:<wbr>alsa_t:s0-s0:c0.c1023<br>
&gt; tcontext=3Dsystem_u:system_r:<wbr>alsa_t:s0-s0:c0.c1023 tclass=3Dproce=
ss<br>
&gt; permissive=3D1<br>
&gt; [ =C2=A0 =C2=A05.304582] audit: type=3D1400 audit(1491249900.909:61): =
avc:<br>
&gt; =C2=A0denied =C2=A0{ execmem } for =C2=A0pid=3D243 comm=3D&quot;alsact=
l&quot;<br>
&gt; scontext=3Dsystem_u:system_r:<wbr>alsa_t:s0-s0:c0.c1023<br>
&gt; tcontext=3Dsystem_u:system_r:<wbr>alsa_t:s0-s0:c0.c1023 tclass=3Dproce=
ss<br>
&gt; permissive=3D1<br>
<br>
</span>More evidence of insecure userspace.<br>
<span class=3D""><br>
&gt; [ =C2=A0 =C2=A05.306197] audit: type=3D1400 audit(1491249900.909:62): =
avc:<br>
&gt; =C2=A0denied =C2=A0{ use } for =C2=A0pid=3D120 comm=3D&quot;systemd-jo=
urnal&quot;<br>
&gt; path=3D&quot;/dev/pts/0&quot; dev=3D&quot;devpts&quot; ino=3D3<br>
&gt; scontext=3Dsystem_u:system_r:<wbr>syslogd_t:s0<br>
&gt; tcontext=3Dsystem_u:system_r:<wbr>plymouthd_t:s0 tclass=3Dfd permissiv=
e=3D1<br>
<br>
</span>Harmless, allow.<br>
<span class=3D""><br>
&gt; [ =C2=A0 =C2=A05.355105] audit: type=3D1400 audit(1491249900.959:63): =
avc:<br>
&gt; =C2=A0denied =C2=A0{ execmod } for =C2=A0pid=3D243 comm=3D&quot;alsact=
l&quot; path=3D&quot;/usr/lib/arm-<br>
&gt; linux-gnueabihf/libarmmem.so&quot; dev=3D&quot;mmcblk0p2&quot; ino=3D1=
44391<br>
&gt; scontext=3Dsystem_u:system_r:<wbr>alsa_t:s0-s0:c0.c1023<br>
&gt; tcontext=3Dsystem_u:object_r:<wbr>lib_t:s0 tclass=3Dfile permissive=3D=
1<br>
<br>
</span>Label with textrel_shlib_t.<br>
<span class=3D""><br>
&gt; [ =C2=A0 =C2=A05.357519] audit: type=3D1400 audit(1491249900.959:64): =
avc:<br>
&gt; =C2=A0denied =C2=A0{ write } for =C2=A0pid=3D243 comm=3D&quot;alsactl&=
quot; name=3D&quot;/&quot; dev=3D&quot;tmpfs&quot;<br>
&gt; ino=3D5104 scontext=3Dsystem_u:system_r:<wbr>alsa_t:s0-s0:c0.c1023<br>
&gt; tcontext=3Dsystem_u:object_r:<wbr>var_lock_t:s0 tclass=3Ddir permissiv=
e=3D1<br>
&gt; [ =C2=A0 =C2=A05.357705] audit: type=3D1400 audit(1491249900.959:65): =
avc:<br>
&gt; =C2=A0denied =C2=A0{ add_name } for =C2=A0pid=3D243 comm=3D&quot;alsac=
tl&quot;<br>
&gt; name=3D&quot;asound.state.lock&quot; scontext=3Dsystem_u:system_r:<wbr=
>alsa_t:s0-<br>
&gt; s0:c0.c1023 tcontext=3Dsystem_u:object_r:<wbr>var_lock_t:s0 tclass=3Dd=
ir<br>
&gt; permissive=3D1<br>
&gt; [ =C2=A0 =C2=A05.358083] audit: type=3D1400 audit(1491249900.959:66): =
avc:<br>
&gt; =C2=A0denied =C2=A0{ create } for =C2=A0pid=3D243 comm=3D&quot;alsactl=
&quot;<br>
&gt; name=3D&quot;asound.state.lock&quot; scontext=3Dsystem_u:system_r:<wbr=
>alsa_t:s0-<br>
&gt; s0:c0.c1023 tcontext=3Dsystem_u:object_r:<wbr>var_lock_t:s0 tclass=3Df=
ile<br>
&gt; permissive=3D1<br>
&gt; [ =C2=A0 =C2=A05.358671] audit: type=3D1400 audit(1491249900.959:67): =
avc:<br>
&gt; =C2=A0denied =C2=A0{ read write open } for =C2=A0pid=3D243 comm=3D&quo=
t;alsactl&quot;<br>
&gt; path=3D&quot;/run/lock/asound.state.<wbr>lock&quot; dev=3D&quot;tmpfs&=
quot; ino=3D1816<br>
&gt; scontext=3Dsystem_u:system_r:<wbr>alsa_t:s0-s0:c0.c1023<br>
&gt; tcontext=3Dsystem_u:object_r:<wbr>var_lock_t:s0 tclass=3Dfile permissi=
ve=3D1<br>
&gt; [ =C2=A0 =C2=A05.358893] audit: type=3D1400 audit(1491249900.959:68): =
avc:<br>
&gt; =C2=A0denied =C2=A0{ getattr } for =C2=A0pid=3D243 comm=3D&quot;alsact=
l&quot;<br>
&gt; path=3D&quot;/run/lock/asound.state.<wbr>lock&quot; dev=3D&quot;tmpfs&=
quot; ino=3D1816<br>
&gt; scontext=3Dsystem_u:system_r:<wbr>alsa_t:s0-s0:c0.c1023<br>
&gt; tcontext=3Dsystem_u:object_r:<wbr>var_lock_t:s0 tclass=3Dfile permissi=
ve=3D1<br>
<br>
</span>Allowed by current refpolicy,<br>
commit efce2657e248b5b0ff61fc05e5cae0<wbr>36760a1294<br>
Author: Sven Vermeulen &lt;<a href=3D"mailto:sven.vermeulen@siphos.be">sven=
.vermeulen@siphos.be</a>&gt;<br>
Date:=C2=A0=C2=A0=C2=A0Sat Jul 5 18:19:14 2014 +0200<br>
<br>
=C2=A0=C2=A0=C2=A0=C2=A0Enable asound.state.lock support<br>
=C2=A0=C2=A0=C2=A0=C2=A0<br>
=C2=A0=C2=A0=C2=A0=C2=A0asound.state.lock file when managing alsa state ope=
rations.<br>
=C2=A0=C2=A0=C2=A0=C2=A0<br>
=C2=A0=C2=A0=C2=A0=C2=A0Signed-off-by: Sven Vermeulen &lt;<a href=3D"mailto=
:sven.vermeulen@siphos.be">sven.vermeulen@siphos.be</a>&gt;<br>
<br>
diff --git a/alsa.te b/alsa.te<br>
index 814b426..6f7f2f9 100644<br>
--- a/alsa.te<br>
+++ b/alsa.te<br>
@@ -24,6 +24,9 @@ files_tmpfs_file(alsa_tmpfs_t)<br>
=C2=A0type alsa_var_lib_t;<br>
=C2=A0files_type(alsa_var_lib_t)<br>
=C2=A0<br>
+type alsa_var_lock_t;<br>
+files_lock_file(alsa_var_<wbr>lock_t)<br>
+<br>
=C2=A0type alsa_home_t;<br>
=C2=A0userdom_user_home_content(<wbr>alsa_home_t)<br>
=C2=A0<br>
@@ -57,6 +60,9 @@ fs_tmpfs_filetrans(alsa_t, alsa_tmpfs_t, file)<br>
=C2=A0manage_dirs_pattern(alsa_t, alsa_var_lib_t, alsa_var_lib_t)<br>
=C2=A0manage_files_pattern(alsa_t, alsa_var_lib_t, alsa_var_lib_t)<br>
=C2=A0<br>
+allow alsa_t alsa_var_lock_t:file manage_file_perms;<br>
+files_lock_filetrans(alsa_t, alsa_var_lock_t, file);<br>
+<br>
=C2=A0kernel_read_system_state(<wbr>alsa_t)<br>
=C2=A0<br>
=C2=A0corecmd_exec_bin(alsa_t)<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; On Mon, Apr 3, 2017 at 6:54 PM, William Roberts &lt;bill.c.roberts@gma=
il<br>
&gt; .com&gt; wrote:<br>
&gt; &gt; Do you see any &quot;avc: denied&quot; messages in dmesg/syslog? =
If so send<br>
&gt; &gt; them.<br>
&gt; &gt;<br>
&gt; &gt; On Apr 3, 2017 16:28, &quot;Rahmadi Trimananda&quot; &lt;<a href=
=3D"mailto:rtrimana@uci.edu">rtrimana@uci.edu</a>&gt;<br>
&gt; &gt; wrote:<br>
&gt; &gt; &gt; Hi All,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; I am trying to run javac and java on my Raspbian while SELin=
ux is<br>
&gt; &gt; &gt; enabled. However, I keep getting &quot;Segmentation fault&qu=
ot;, even when<br>
&gt; &gt; &gt; I just run &quot;javac&quot; or &quot;java&quot;. This happe=
ns in enforcing mode, but<br>
&gt; &gt; &gt; it doesn&#39;t happen with &quot;gcc&quot;. I am wondering w=
hy, because both<br>
&gt; &gt; &gt; are in /usr/bin directory and both binaries have the same<br=
>
&gt; &gt; &gt; context.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Can somebody please help?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Thank you so much!<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Regards,<br>
&gt; &gt; &gt; Rahmadi<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; ______________________________<wbr>_________________<br>
&gt; &gt; &gt; Selinux mailing list<br>
&gt; &gt; &gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.g=
ov</a><br>
&gt; &gt; &gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leav=
e@tycho.nsa.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; &gt; &gt; To get help, send an email containing &quot;help&quot; to Se=
linux-request@t<br>
&gt; &gt; &gt; <a href=3D"http://ycho.nsa.gov" rel=3D"noreferrer" target=3D=
"_blank">ycho.nsa.gov</a>.<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --=C2=A0<br>
&gt; Kind regards,<br>
&gt; Rahmadi Trimananda<br>
&gt;<br>
&gt; Ph.D. student @ University of California, Irvine<br>
&gt; &quot;Stay hungry, stay foolish!&quot; - Steve Jobs -<br>
&gt; ______________________________<wbr>_________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to Selinux-requ=
est@tycho<br>
&gt; .<a href=3D"http://nsa.gov" rel=3D"noreferrer" target=3D"_blank">nsa.g=
ov</a>.<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=
=3D"ltr">Kind regards,<div>Rahmadi Trimananda</div><div><br></div><div>Ph.D=
. student @ University of California, Irvine</div><div>&quot;Stay hungry, s=
tay foolish!&quot; - Steve Jobs -</div></div></div>
</div>

--f403045f1652168ef2054c5925c8--
