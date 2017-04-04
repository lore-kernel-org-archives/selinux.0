Message-ID: <1491317258.31785.11.camel@tycho.nsa.gov>
Subject: Re: Running Java and JVM on SELinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Rahmadi Trimananda <rtrimana@uci.edu>, William Roberts
 <bill.c.roberts@gmail.com>, Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Date: Tue, 04 Apr 2017 10:47:38 -0400
In-Reply-To: <CAHFUiBNnbdfvqneUo5dH4+4e_1Df6HrbmBGaQQ76SQpi6AXvBg@mail.gmail.com>
References: <CAHFUiBOa186qydQ5VBeEmcMMinQnpkwBPMx91Aq-GAq4TvSm-g@mail.gmail.com>
 <CAFftDdrVEKxgp69KrUrfyzD8hPuYOBtKgGhb_JWKCKrmd2PqhQ@mail.gmail.com>
 <CAHFUiBNnbdfvqneUo5dH4+4e_1Df6HrbmBGaQQ76SQpi6AXvBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-04-03 at 19:12 -0700, Rahmadi Trimananda wrote:
> This is the result of "dmesg | grep avc". Please let me know if you
> need more information about my system (RaspberryPi 2 running Raspbian
> Jessie).
> 
> [    2.275229] audit: type=1400 audit(2.249:3): avc:  denied  {
> associate } for  pid=1 comm="systemd" name="pts"
> scontext=system_u:object_r:devpts_t:s0
> tcontext=system_u:object_r:device_t:s0 tclass=filesystem permissive=1
> [    2.577155] audit: type=1400 audit(2.549:4): avc:  denied  {
> wake_alarm } for  pid=1 comm="systemd" capability=35
>  scontext=system_u:system_r:init_t:s0
> tcontext=system_u:system_r:init_t:s0 tclass=capability2 permissive=1

These two are harmless and allowed in Fedora policy.

> [    2.601211] audit: type=1400 audit(2.569:5): avc:  denied  {
> execstack } for  pid=95 comm="systemd-fstab-g"
> scontext=system_u:system_r:init_t:s0
> tcontext=system_u:system_r:init_t:s0 tclass=process permissive=1
> [    2.601321] audit: type=1400 audit(2.569:6): avc:  denied  {
> execmem } for  pid=95 comm="systemd-fstab-g"
> scontext=system_u:system_r:init_t:s0
> tcontext=system_u:system_r:init_t:s0 tclass=process permissive=1

These two are undesirable for security.  Suggests that your userspace
binaries are legacy or built insecurely, with RWE segments.

> [    2.605393] audit: type=1400 audit(2.579:7): avc:  denied  {
> execmod } for  pid=95 comm="systemd-fstab-g" path="/usr/lib/arm-
> linux-gnueabihf/libarmmem.so" dev="mmcblk0p2" ino=144391
> scontext=system_u:system_r:init_t:s0
> tcontext=system_u:object_r:lib_t:s0 tclass=file permissive=1

This implies that this particular .so file should be assigned the
textrel_shlib_t type instead.

> [    3.201440] audit: type=1400 audit(3.169:8): avc:  denied  {
> execstack } for  pid=107 comm="mount"
> scontext=system_u:system_r:mount_t:s0
> tcontext=system_u:system_r:mount_t:s0 tclass=process permissive=1
> [    3.201499] audit: type=1400 audit(3.169:9): avc:  denied  {
> execmem } for  pid=107 comm="mount"
> scontext=system_u:system_r:mount_t:s0
> tcontext=system_u:system_r:mount_t:s0 tclass=process permissive=1
> [    3.217575] audit: type=1400 audit(3.189:10): avc:  denied  {
> execstack } for  pid=108 comm="kmod"
> scontext=system_u:system_r:insmod_t:s0
> tcontext=system_u:system_r:insmod_t:s0 tclass=process permissive=1

These fall into the same category as the init_t denials above; not
desirable; indicate legacy or insecurely built userspace.

> [    5.291711] audit: type=1400 audit(1491249900.889:59): avc:
>  denied  { mmap_zero } for  pid=243 comm="alsactl"
> scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:alsa_t:s0-s0:c0.c1023 tclass=memprotect
> permissive=1

This along with your java denials raises a question about your kernel
config, particularly the value of CONFIG_LSM_MMAP_MIN_ADDR.  Should
match the value of /proc/sys/vm/mmap_min_addr in general.  Defaults to
32K for ARM, 64K for others.

> [    5.304205] audit: type=1400 audit(1491249900.909:60): avc:
>  denied  { execstack } for  pid=243 comm="alsactl"
> scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:alsa_t:s0-s0:c0.c1023 tclass=process
> permissive=1
> [    5.304582] audit: type=1400 audit(1491249900.909:61): avc:
>  denied  { execmem } for  pid=243 comm="alsactl"
> scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
> tcontext=system_u:system_r:alsa_t:s0-s0:c0.c1023 tclass=process
> permissive=1

More evidence of insecure userspace.

> [    5.306197] audit: type=1400 audit(1491249900.909:62): avc:
>  denied  { use } for  pid=120 comm="systemd-journal"
> path="/dev/pts/0" dev="devpts" ino=3
> scontext=system_u:system_r:syslogd_t:s0
> tcontext=system_u:system_r:plymouthd_t:s0 tclass=fd permissive=1

Harmless, allow.

> [    5.355105] audit: type=1400 audit(1491249900.959:63): avc:
>  denied  { execmod } for  pid=243 comm="alsactl" path="/usr/lib/arm-
> linux-gnueabihf/libarmmem.so" dev="mmcblk0p2" ino=144391
> scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:lib_t:s0 tclass=file permissive=1

Label with textrel_shlib_t.

> [    5.357519] audit: type=1400 audit(1491249900.959:64): avc:
>  denied  { write } for  pid=243 comm="alsactl" name="/" dev="tmpfs"
> ino=5104 scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:var_lock_t:s0 tclass=dir permissive=1
> [    5.357705] audit: type=1400 audit(1491249900.959:65): avc:
>  denied  { add_name } for  pid=243 comm="alsactl"
> name="asound.state.lock" scontext=system_u:system_r:alsa_t:s0-
> s0:c0.c1023 tcontext=system_u:object_r:var_lock_t:s0 tclass=dir
> permissive=1
> [    5.358083] audit: type=1400 audit(1491249900.959:66): avc:
>  denied  { create } for  pid=243 comm="alsactl"
> name="asound.state.lock" scontext=system_u:system_r:alsa_t:s0-
> s0:c0.c1023 tcontext=system_u:object_r:var_lock_t:s0 tclass=file
> permissive=1
> [    5.358671] audit: type=1400 audit(1491249900.959:67): avc:
>  denied  { read write open } for  pid=243 comm="alsactl"
> path="/run/lock/asound.state.lock" dev="tmpfs" ino=1816
> scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:var_lock_t:s0 tclass=file permissive=1
> [    5.358893] audit: type=1400 audit(1491249900.959:68): avc:
>  denied  { getattr } for  pid=243 comm="alsactl"
> path="/run/lock/asound.state.lock" dev="tmpfs" ino=1816
> scontext=system_u:system_r:alsa_t:s0-s0:c0.c1023
> tcontext=system_u:object_r:var_lock_t:s0 tclass=file permissive=1

Allowed by current refpolicy,
commit efce2657e248b5b0ff61fc05e5cae036760a1294
Author: Sven Vermeulen <sven.vermeulen@siphos.be>
Date:   Sat Jul 5 18:19:14 2014 +0200

    Enable asound.state.lock support
    
    asound.state.lock file when managing alsa state operations.
    
    Signed-off-by: Sven Vermeulen <sven.vermeulen@siphos.be>

diff --git a/alsa.te b/alsa.te
index 814b426..6f7f2f9 100644
--- a/alsa.te
+++ b/alsa.te
@@ -24,6 +24,9 @@ files_tmpfs_file(alsa_tmpfs_t)
 type alsa_var_lib_t;
 files_type(alsa_var_lib_t)
 
+type alsa_var_lock_t;
+files_lock_file(alsa_var_lock_t)
+
 type alsa_home_t;
 userdom_user_home_content(alsa_home_t)
 
@@ -57,6 +60,9 @@ fs_tmpfs_filetrans(alsa_t, alsa_tmpfs_t, file)
 manage_dirs_pattern(alsa_t, alsa_var_lib_t, alsa_var_lib_t)
 manage_files_pattern(alsa_t, alsa_var_lib_t, alsa_var_lib_t)
 
+allow alsa_t alsa_var_lock_t:file manage_file_perms;
+files_lock_filetrans(alsa_t, alsa_var_lock_t, file);
+
 kernel_read_system_state(alsa_t)
 
 corecmd_exec_bin(alsa_t)

> 
> On Mon, Apr 3, 2017 at 6:54 PM, William Roberts <bill.c.roberts@gmail
> .com> wrote:
> > Do you see any "avc: denied" messages in dmesg/syslog? If so send
> > them.
> > 
> > On Apr 3, 2017 16:28, "Rahmadi Trimananda" <rtrimana@uci.edu>
> > wrote:
> > > Hi All,
> > > 
> > > I am trying to run javac and java on my Raspbian while SELinux is
> > > enabled. However, I keep getting "Segmentation fault", even when
> > > I just run "javac" or "java". This happens in enforcing mode, but
> > > it doesn't happen with "gcc". I am wondering why, because both
> > > are in /usr/bin directory and both binaries have the same
> > > context.
> > > 
> > > Can somebody please help?
> > > 
> > > Thank you so much!
> > > 
> > > Regards,
> > > Rahmadi
> > > 
> > > 
> > > _______________________________________________
> > > Selinux mailing list
> > > Selinux@tycho.nsa.gov
> > > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > > To get help, send an email containing "help" to Selinux-request@t
> > > ycho.nsa.gov.
> 
> 
> 
> -- 
> Kind regards,
> Rahmadi Trimananda
> 
> Ph.D. student @ University of California, Irvine
> "Stay hungry, stay foolish!" - Steve Jobs -
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho
> .nsa.gov.
