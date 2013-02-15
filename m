Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r1FG8FlJ002629
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2013 11:08:15 -0500
Date: Fri, 15 Feb 2013 17:07:49 +0100
From: Luis Ressel <aranea@aixah.de>
To: SELinux <selinux@tycho.nsa.gov>
Cc: Eric Paris <eparis@parisplace.org>
Subject: Re: Mount of cgroup filesystems fails when booting in SELinux
 enforcing mode
Message-ID: <20130215170749.624be7b1@gentp.lnet>
In-Reply-To: <511E5568.90103@tycho.nsa.gov>
References: <20130214222502.2f7d657c@gentp.lnet>
	<511E38E7.4040609@tycho.nsa.gov>
	<20130215150649.22c20d5c@gentp.lnet>
	<511E45F6.4030300@tycho.nsa.gov>
	<20130215160240.47e8d1da@gentp.lnet>
	<511E5568.90103@tycho.nsa.gov>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA512;
 boundary="Sig_/bRyZqo0_MZiUAgEV1Ow._fu"; protocol="application/pgp-signature"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Sig_/bRyZqo0_MZiUAgEV1Ow._fu
Content-Type: multipart/mixed; boundary="MP_/XbjjDJ1FcepOQgJW9TtoCIY"

--MP_/XbjjDJ1FcepOQgJW9TtoCIY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Fri, 15 Feb 2013 10:34:00 -0500
Stephen Smalley <sds@tycho.nsa.gov> wrote:

> Output from the printk was what?
> Also of interest would be avd->allowed, avd->auditdeny, from_access.

I attached a syslog snippet.

> In this situation, if you just let it fall through to=20
> audit_inode_permission() rather than bailing on !audited, you should
> get an avc audit message.  audit_inode_permission() calls
> slow_avc_audit() for you.

I already tried that; It doesn't yield a message either.

> Are you sure your audit messages aren't just going to audit.log
> rather than syslog?  That would be the case if auditd has started.

I don't use auditd, and there are some other audit messages in kern.log
and avc.log (at least if I disable dontaudit rules).

> Need to figure out why the kernel isn't auditing the denial for you=20
> (that's a kernel bug), but the policy bug here is likely that you
> aren't allowing the process to search the cgroup dir.  Don't know
> anything about your policy.

I'm using the refpolicy 2.20120725 with some Gentoo-specific patches:
http://mirror.mcs.anl.gov/pub/gentoo/distfiles/patchbundle-selinux-base-pol=
icy-2.20120725-r9.tar.bz
=20

--MP_/XbjjDJ1FcepOQgJW9TtoCIY
Content-Type: text/x-log
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=debug2.log

Feb 15 17:01:23 virt kernel: [    0.361809] SELinux: 2048 avtab hash slots,=
 11172 rules.
Feb 15 17:01:23 virt kernel: [    0.365897] SELinux: 2048 avtab hash slots,=
 11172 rules.
Feb 15 17:01:23 virt kernel: [    0.366308] SELinux:  6 users, 27 roles, 13=
25 types, 41 bools
Feb 15 17:01:23 virt kernel: [    0.366314] SELinux:  81 classes, 11172 rul=
es
Feb 15 17:01:23 virt kernel: [    0.369135] SELinux:  Completing initializa=
tion.
Feb 15 17:01:23 virt kernel: [    0.369139] SELinux:  Setting up existing s=
uperblocks.
Feb 15 17:01:23 virt kernel: [    0.369159] SELinux: initialized (dev sysfs=
, type sysfs), uses genfs_contexts
Feb 15 17:01:23 virt kernel: [    0.369169] SELinux: initialized (dev rootf=
s, type rootfs), uses genfs_contexts
Feb 15 17:01:23 virt kernel: [    0.369178] SELinux: initialized (dev bdev,=
 type bdev), uses genfs_contexts
Feb 15 17:01:23 virt kernel: [    0.369188] SELinux: initialized (dev proc,=
 type proc), uses genfs_contexts
Feb 15 17:01:23 virt kernel: [    0.369211] SELinux: initialized (dev tmpfs=
, type tmpfs), uses transition SIDs
Feb 15 17:01:23 virt kernel: [    0.369225] SELinux: initialized (dev devtm=
pfs, type devtmpfs), uses transition SIDs
Feb 15 17:01:23 virt kernel: [    0.369349] SELinux: initialized (dev sockf=
s, type sockfs), uses task SIDs
Feb 15 17:01:23 virt kernel: [    0.369357] SELinux: initialized (dev debug=
fs, type debugfs), uses genfs_contexts
Feb 15 17:01:23 virt kernel: [    0.369648] SELinux: initialized (dev pipef=
s, type pipefs), uses task SIDs
Feb 15 17:01:23 virt kernel: [    0.369657] SELinux: initialized (dev anon_=
inodefs, type anon_inodefs), uses genfs_contexts
Feb 15 17:01:23 virt kernel: [    0.369664] SELinux: initialized (dev devpt=
s, type devpts), uses transition SIDs
Feb 15 17:01:23 virt kernel: [    0.369674] SELinux: initialized (dev huget=
lbfs, type hugetlbfs), uses transition SIDs
Feb 15 17:01:23 virt kernel: [    0.369681] SELinux: initialized (dev mqueu=
e, type mqueue), uses transition SIDs
Feb 15 17:01:23 virt kernel: [    0.369689] SELinux: initialized (dev selin=
uxfs, type selinuxfs), uses genfs_contexts
Feb 15 17:01:23 virt kernel: [    0.369712] SELinux: initialized (dev sda, =
type ext4), uses xattr
Feb 15 17:01:23 virt kernel: [    0.369823] SELinux: initialized (dev sysfs=
, type sysfs), uses genfs_contexts
Feb 15 17:01:23 virt kernel: [    0.372785] type=3D1403 audit(1360944081.37=
2:2): policy loaded auid=3D4294967295 ses=3D4294967295
Feb 15 17:01:23 virt kernel: [    0.374173] avc_has_perm_noaudit(46, 5, 7, =
8388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    0.374364] allowed: 0, auditdeny: -8650769=
, from_access: 0avc_has_perm_noaudit(46, 5, 7, 8388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    0.375184] allowed: 0, auditdeny: -8650769=
, from_access: 0avc_has_perm_noaudit(46, 5, 7, 8388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    0.383584] allowed: 0, auditdeny: -8650769=
, from_access: 0avc_has_perm_noaudit(46, 5, 7, 8388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    0.391980] allowed: 0, auditdeny: -8650769=
, from_access: 0<4>[    0.423450] kbd_mode (710) used greatest stack depth:=
 5664 bytes left
Feb 15 17:01:23 virt kernel: [    0.452719] loadkeys (711) used greatest st=
ack depth: 5096 bytes left
Feb 15 17:01:23 virt kernel: [    0.453328] init-early.sh (709) used greate=
st stack depth: 4416 bytes left
Feb 15 17:01:23 virt kernel: [    0.488124] avc_has_perm_noaudit(63, 31, 7,=
 4, 0, &avd)
Feb 15 17:01:23 virt kernel: [    0.488360] allowed: 8716371, auditdeny: -3=
7, from_access: 1<7>[    0.503648] SELinux: initialized (dev tmpfs, type tm=
pfs), uses transition SIDs
Feb 15 17:01:23 virt kernel: [    0.503664] avc_has_perm_noaudit(63, 50, 7,=
 4, 0, &avd)
Feb 15 17:01:23 virt kernel: [    0.503860] allowed: 8716304, auditdeny: -3=
7, from_access: 1avc_has_perm_noaudit(63, 33, 7, 4, 0, &avd)
Feb 15 17:01:23 virt kernel: [    0.983790] allowed: 8716371, auditdeny: -3=
7, from_access: 1avc_has_perm_noaudit(63, 33, 10, 6, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.005856] allowed: 0, auditdeny: -262744,=
 from_access: 0avc_has_perm_noaudit(63, 36, 7, 4, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.062238] allowed: 8716371, auditdeny: -3=
2775296, from_access: 1avc_has_perm_noaudit(63, 33, 10, 6, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.072475] allowed: 0, auditdeny: -262744,=
 from_access: 0<7>[    1.073087] SELinux: initialized (dev tmpfs, type tmpf=
s), uses transition SIDs
Feb 15 17:01:23 virt kernel: [    1.073094] avc_has_perm_noaudit(63, 33, 7,=
 4, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.073452] allowed: 8716371, auditdeny: -3=
7, from_access: 1avc_has_perm_noaudit(63, 33, 10, 6, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.158504] allowed: 0, auditdeny: -262744,=
 from_access: 0<7>[    1.158572] SELinux: initialized (dev securityfs, type=
 securityfs), uses genfs_contexts
Feb 15 17:01:23 virt kernel: [    1.158578] avc_has_perm_noaudit(63, 2, 7, =
4, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.158579] allowed: 8716371, auditdeny: -8=
650805, from_access: 1avc_has_perm_noaudit(63, 33, 10, 6, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.165915] allowed: 0, auditdeny: -262744,=
 from_access: 0avc_has_perm_noaudit(63, 34, 7, 4, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.166064] allowed: 8716304, auditdeny: -3=
7, from_access: 1avc_has_perm_noaudit(63, 33, 10, 6, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.226628] allowed: 0, auditdeny: -262744,=
 from_access: 0<7>[    1.226759] SELinux: initialized (dev tmpfs, type tmpf=
s), uses transition SIDs
Feb 15 17:01:23 virt kernel: [    1.226766] avc_has_perm_noaudit(63, 28, 7,=
 4, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.226767] allowed: 8716371, auditdeny: -8=
650805, from_access: 1avc_has_perm_noaudit(63, 33, 10, 6, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.231707] allowed: 0, auditdeny: -262744,=
 from_access: 0avc_has_perm_noaudit(1, 3, 7, 8388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.231804] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.231805] cgroup_addrm_files: failed to add tas=
ks, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.231807] avc_has_perm_noaudit(1, 3, 7, 8=
388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.231808] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.231809] cgroup_addrm_files: failed to add cgr=
oup.procs, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.231810] avc_has_perm_noaudit(1, 3, 7, 8=
388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.231811] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.231811] cgroup_addrm_files: failed to add not=
ify_on_release, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.231812] avc_has_perm_noaudit(1, 3, 7, 8=
388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.231813] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.231814] cgroup_addrm_files: failed to add cgr=
oup.event_control, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.231815] avc_has_perm_noaudit(1, 3, 7, 8=
388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.231816] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.231817] cgroup_addrm_files: failed to add cgr=
oup.clone_children, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.231818] avc_has_perm_noaudit(1, 3, 7, 8=
388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.231818] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.231819] cgroup_addrm_files: failed to add rel=
ease_agent, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.231825] SELinux: initialized (dev cgrou=
p, type cgroup), uses genfs_contexts
Feb 15 17:01:23 virt kernel: [    1.231851] avc_has_perm_noaudit(63, 69, 7,=
 4, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.231852] allowed: 8716304, auditdeny: -3=
7, from_access: 1avc_has_perm_noaudit(63, 33, 10, 6, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.233988] allowed: 0, auditdeny: -262744,=
 from_access: 0avc_has_perm_noaudit(1, 3, 7, 8388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.234100] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.234102] cgroup_addrm_files: failed to add tas=
ks, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.234103] avc_has_perm_noaudit(1, 3, 7, 8=
388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.234104] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.234105] cgroup_addrm_files: failed to add cgr=
oup.procs, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.234106] avc_has_perm_noaudit(1, 3, 7, 8=
388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.234107] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.234108] cgroup_addrm_files: failed to add not=
ify_on_release, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.234109] avc_has_perm_noaudit(1, 3, 7, 8=
388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.234109] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.234110] cgroup_addrm_files: failed to add cgr=
oup.event_control, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.234111] avc_has_perm_noaudit(1, 3, 7, 8=
388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.234112] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.234113] cgroup_addrm_files: failed to add cgr=
oup.clone_children, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.234114] avc_has_perm_noaudit(1, 3, 7, 8=
388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.234114] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.234115] cgroup_addrm_files: failed to add rel=
ease_agent, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.234118] SELinux: initialized (dev cgrou=
p, type cgroup), uses genfs_contexts
Feb 15 17:01:23 virt kernel: [    1.234124] avc_has_perm_noaudit(63, 69, 7,=
 4, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.234125] allowed: 8716304, auditdeny: -3=
7, from_access: 1avc_has_perm_noaudit(63, 33, 10, 6, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.235315] allowed: 0, auditdeny: -262744,=
 from_access: 0avc_has_perm_noaudit(1, 3, 7, 8388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.235379] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.235380] cgroup_addrm_files: failed to add tas=
ks, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.235381] avc_has_perm_noaudit(1, 3, 7, 8=
388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.235382] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.235383] cgroup_addrm_files: failed to add cgr=
oup.procs, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.235384] avc_has_perm_noaudit(1, 3, 7, 8=
388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.235385] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.235386] cgroup_addrm_files: failed to add not=
ify_on_release, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.235387] avc_has_perm_noaudit(1, 3, 7, 8=
388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.235388] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.235389] cgroup_addrm_files: failed to add cgr=
oup.event_control, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.235390] avc_has_perm_noaudit(1, 3, 7, 8=
388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.235391] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.235391] cgroup_addrm_files: failed to add cgr=
oup.clone_children, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.235392] avc_has_perm_noaudit(1, 3, 7, 8=
388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.235393] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.235394] cgroup_addrm_files: failed to add rel=
ease_agent, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.235396] SELinux: initialized (dev cgrou=
p, type cgroup), uses genfs_contexts
Feb 15 17:01:23 virt kernel: [    1.235401] avc_has_perm_noaudit(63, 69, 7,=
 4, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.235402] allowed: 8716304, auditdeny: -3=
7, from_access: 1avc_has_perm_noaudit(63, 33, 10, 6, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.236562] allowed: 0, auditdeny: -262744,=
 from_access: 0avc_has_perm_noaudit(1, 3, 7, 8388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.236619] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.236620] cgroup_addrm_files: failed to add tas=
ks, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.236621] avc_has_perm_noaudit(1, 3, 7, 8=
388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.236622] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.236623] cgroup_addrm_files: failed to add cgr=
oup.procs, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.236624] avc_has_perm_noaudit(1, 3, 7, 8=
388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.236625] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.236625] cgroup_addrm_files: failed to add not=
ify_on_release, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.236626] avc_has_perm_noaudit(1, 3, 7, 8=
388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.236627] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.236628] cgroup_addrm_files: failed to add cgr=
oup.event_control, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.236629] avc_has_perm_noaudit(1, 3, 7, 8=
388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.236630] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.236631] cgroup_addrm_files: failed to add cgr=
oup.clone_children, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.236632] avc_has_perm_noaudit(1, 3, 7, 8=
388608, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.236632] allowed: 65536, auditdeny: -838=
8609, from_access: 0<4>[    1.236633] cgroup_addrm_files: failed to add rel=
ease_agent, err=3D-13
Feb 15 17:01:23 virt kernel: [    1.236635] SELinux: initialized (dev cgrou=
p, type cgroup), uses genfs_contexts
Feb 15 17:01:23 virt kernel: [    1.236640] avc_has_perm_noaudit(63, 69, 7,=
 4, 0, &avd)
Feb 15 17:01:23 virt kernel: [    1.236641] allowed: 8716304, auditdeny: -3=
7, from_access: 1systemd-udevd[904]: starting version 197
Feb 15 17:01:23 virt kernel: [    1.746764] hpet1: lost 2 rtc interrupts
Feb 15 17:01:23 virt kernel: [    2.454130] avc_has_perm_noaudit(63, 50, 7,=
 4, 0, &avd)
Feb 15 17:01:23 virt kernel: [    2.454133] allowed: 8716304, auditdeny: -3=
7, from_access: 1<7>[    3.555584] SELinux: initialized (dev binfmt_misc, t=
ype binfmt_misc), uses genfs_contexts
Feb 15 17:01:23 virt kernel: [    3.555613] avc_has_perm_noaudit(63, 120, 7=
, 4, 0, &avd)
Feb 15 17:01:23 virt kernel: [    3.555614] allowed: 8716304, auditdeny: -3=
7, from_access: 1avc_has_perm_noaudit(63, 2, 7, 4, 0, &avd)
Feb 15 17:01:31 virt kernel: [    3.569335] allowed: 8716371, auditdeny: -8=
650805, from_access: 1avc_has_perm_noaudit(134, 28, 7, 8388608, 0, &avd)
Feb 15 17:01:31 virt kernel: [   11.700595] allowed: 0, auditdeny: -8650769=
, from_access: 0avc_has_perm_noaudit(134, 28, 7, 8388608, 0, &avd)
Feb 15 17:01:32 virt kernel: [   11.701646] allowed: 0, auditdeny: -8650769=
, from_access: 0avc_has_perm_noaudit(134, 28, 7, 8388608, 0, &avd)
Feb 15 17:01:32 virt kernel: [   12.822528] allowed: 0, auditdeny: -8650769=
, from_access: 0avc_has_perm_noaudit(134, 28, 7, 8388608, 0, &avd)
Feb 15 17:01:32 virt kernel: [   12.822649] allowed: 0, auditdeny: -8650769=
, from_access: 0avc_has_perm_noaudit(134, 28, 7, 8388608, 0, &avd)
Feb 15 17:01:32 virt kernel: [   12.832442] allowed: 0, auditdeny: -8650769=
, from_access: 0avc_has_perm_noaudit(134, 28, 7, 8388608, 0, &avd)

--MP_/XbjjDJ1FcepOQgJW9TtoCIY--

--Sig_/bRyZqo0_MZiUAgEV1Ow._fu
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCgAGBQJRHl1iAAoJEOBVC/zizycOeCwP/RktBuo3DcYRgoLzeKI20tdL
zHneF9Tghqga1QHniQDhe5eFhAidtMX4pfgyt1RI2NA9XSF9qgDyND8sjjC9FeT9
CoEfWEkD0GHVFLh/WGFIbiek4AtimyEzkdD2l8JGggBtWJOkRJFzk5V9VHC7oU+S
2Fkeh5pWVdgTpbQQCc6PH2Rmm4xs6NGAiXkTkMWEKIn98M88e+8ansYAc/ufID43
rzQsecrgHn4axsZ3ll7iD7D6CTf3YOj5w1AL7yzAWQoOnY02Q/Sbzq/Eyeun01nf
u4V768U2WIi0mwByPy88DcgxcN6gbdoMEP70PMPfGXHhEO9J7sRKXrk/VBW731g7
9/47IdWpMs+g9PDJKQUMzqgsFcNq/WULvvZ62g+6SOMXr/XP10PamijqUKWb0pjM
P82ed0CY5xwv+xfSr1sTJF3y5mxN+3b+lAJQFdzAaoEwLdt7QvNghWxGVisDZYi9
IQM6zoiMRwXepWosIxqEuhK3pXpRDN/W4sdtiZyfsekDZHEwoL87W2024iPKzc/v
LhAI+7xMjDowKi/C4BD/FTjCtcVXDXSN7qrZihimMMJZchTecprC28QeteZnnTf1
WfYI1YFHsljAZc1rl7wuDmQ22557Tvkvhz+a4QvXdDRUFYxC3drIRD+GoJSI8Kui
2Q/zNXfhb43jOs5YoeEW
=+uCd
-----END PGP SIGNATURE-----

--Sig_/bRyZqo0_MZiUAgEV1Ow._fu--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
