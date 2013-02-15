Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r1FIiVgX014529
	for <selinux@tycho.nsa.gov>; Fri, 15 Feb 2013 13:44:31 -0500
Date: Fri, 15 Feb 2013 19:44:14 +0100
From: Luis Ressel <aranea@aixah.de>
To: SELinux <selinux@tycho.nsa.gov>
Cc: Eric Paris <eparis@parisplace.org>
Subject: Re: Mount of cgroup filesystems fails when booting in SELinux
 enforcing mode
Message-ID: <20130215194414.611081d4@gentp.lnet>
In-Reply-To: <511E7C2A.1070101@tycho.nsa.gov>
References: <20130214222502.2f7d657c@gentp.lnet>
	<511E38E7.4040609@tycho.nsa.gov>
	<20130215150649.22c20d5c@gentp.lnet>
	<511E45F6.4030300@tycho.nsa.gov>
	<20130215160240.47e8d1da@gentp.lnet>
	<511E5568.90103@tycho.nsa.gov>
	<20130215170749.624be7b1@gentp.lnet>
	<511E7C2A.1070101@tycho.nsa.gov>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA512;
 boundary="Sig_/oXq.dbMRWsqE=483d_FLAL2"; protocol="application/pgp-signature"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Sig_/oXq.dbMRWsqE=483d_FLAL2
Content-Type: multipart/mixed; boundary="MP_/T7k_qIdbGHvybn1BybdSJ+G"

--MP_/T7k_qIdbGHvybn1BybdSJ+G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Fri, 15 Feb 2013 13:19:22 -0500
Stephen Smalley <sds@tycho.nsa.gov> wrote:

> Easier to read if you use %x for the access vectors - perms, allowed,=20
> auditdeny, put everything into a single printk statement so that
> there is no potential for interleaving of the output and put a
> newline (\n) at the end of that printk so we don't end up with mixed
> output on lines. You could also compute the set of denied permissions
> (perms & ~allowed) and the set of permissions to be audited (denied &
> auditdeny) and display those for convenience. But anyway, let's look
> at this one:
>=20
> avc_has_perm_noaudit(1, 3, 7, 8388608, 0, &avd)
> allowed: 65536, auditdeny: -8388609, from_access: 0
> cgroup_addrm_files: failed to add cgroup.procs, err=3D-13
>=20
> Mapping to slightly more readable output, that would be:
> avc_has_perm_noaudit(1, 3, 7, 0x800000, 0, &avd)
> allowed: 0x10000, auditdeny: 0xff7fffff, from_access: 0

You're absolutely right, the formatting was quite ugly.

> So in this situation, the requested permission is in fact not
> allowed, but it is masked out of auditdeny, so it will not be
> audited. Presumably you booted this time with a policy that has
> dontaudit rules; otherwise your auditdeny vectors would have all
> permission bits set. The kernel is functioning correctly there but
> your policy is denying access and silencing the audit message.

Again, you're right. On this boot, dontaudit rules were actually
enabled. Now, here's another log where they are disabled again.

> If we try to map this to more readable output using=20
> security/selinux/flask.h and security/selinux/av_permissions.h, we
> have:
>=20
> avc_has_perm_noaudit(SECINITSID_KERNEL, SECINITSID_UNLABELED,=20
> SECCLASS_DIR, DIR__SEARCH, 0, &avd)
> allowed: DIR__MOUNTON, auditdeny: <everything except DIR__SEARCH>
>=20
> We can map the SIDs because the SIDs in that case happen to be=20
> predefined SIDs as opposed to dynamically allocated ones; otherwise
> we need security_sid_to_context() to look them up, which is what=20
> avc_audit() will do for us.  So this was a directory search denial=20
> between the kernel context and the unlabeled context.

Thanks for clarifying this! I somehow missed those static SIDs...

--MP_/T7k_qIdbGHvybn1BybdSJ+G
Content-Type: text/x-log
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=debug3.log

Feb 15 19:32:44 virt kernel: [    0.501773] SELinux: 2048 avtab hash slots,=
 9297 rules.
Feb 15 19:32:44 virt kernel: [    0.502579] SELinux: 2048 avtab hash slots,=
 9297 rules.
Feb 15 19:32:44 virt kernel: [    0.502668] SELinux:  6 users, 27 roles, 13=
25 types, 41 bools
Feb 15 19:32:44 virt kernel: [    0.502670] SELinux:  81 classes, 9297 rules
Feb 15 19:32:44 virt kernel: [    0.503399] SELinux:  Completing initializa=
tion.
Feb 15 19:32:44 virt kernel: [    0.503401] SELinux:  Setting up existing s=
uperblocks.
Feb 15 19:32:44 virt kernel: [    0.503405] SELinux: initialized (dev sysfs=
, type sysfs), uses genfs_contexts
Feb 15 19:32:44 virt kernel: [    0.503409] SELinux: initialized (dev rootf=
s, type rootfs), uses genfs_contexts
Feb 15 19:32:44 virt kernel: [    0.503412] SELinux: initialized (dev bdev,=
 type bdev), uses genfs_contexts
Feb 15 19:32:44 virt kernel: [    0.503415] SELinux: initialized (dev proc,=
 type proc), uses genfs_contexts
Feb 15 19:32:44 virt kernel: [    0.503422] SELinux: initialized (dev tmpfs=
, type tmpfs), uses transition SIDs
Feb 15 19:32:44 virt kernel: [    0.503427] SELinux: initialized (dev devtm=
pfs, type devtmpfs), uses transition SIDs
Feb 15 19:32:44 virt kernel: [    0.503466] SELinux: initialized (dev sockf=
s, type sockfs), uses task SIDs
Feb 15 19:32:44 virt kernel: [    0.503469] SELinux: initialized (dev debug=
fs, type debugfs), uses genfs_contexts
Feb 15 19:32:44 virt kernel: [    0.503617] SELinux: initialized (dev pipef=
s, type pipefs), uses task SIDs
Feb 15 19:32:44 virt kernel: [    0.503620] SELinux: initialized (dev anon_=
inodefs, type anon_inodefs), uses genfs_contexts
Feb 15 19:32:44 virt kernel: [    0.503623] SELinux: initialized (dev devpt=
s, type devpts), uses transition SIDs
Feb 15 19:32:44 virt kernel: [    0.503626] SELinux: initialized (dev huget=
lbfs, type hugetlbfs), uses transition SIDs
Feb 15 19:32:44 virt kernel: [    0.503628] SELinux: initialized (dev mqueu=
e, type mqueue), uses transition SIDs
Feb 15 19:32:44 virt kernel: [    0.503630] SELinux: initialized (dev selin=
uxfs, type selinuxfs), uses genfs_contexts
Feb 15 19:32:44 virt kernel: [    0.503642] SELinux: initialized (dev sda, =
type ext4), uses xattr
Feb 15 19:32:44 virt kernel: [    0.503692] SELinux: initialized (dev sysfs=
, type sysfs), uses genfs_contexts
Feb 15 19:32:44 virt kernel: [    0.504938] type=3D1403 audit(1360953160.50=
4:2): policy loaded auid=3D4294967295 ses=3D4294967295
Feb 15 19:32:44 virt kernel: [    0.505903] type=3D1400 audit(1360953160.50=
5:3): avc:  denied  { read write } for  pid=3D1 comm=3D"init" path=3D"/dev/=
console" dev=3D"rootfs" ino=3D1562 scontext=3Dsystem_u:system_r:init_t tcon=
text=3Dsystem_u:object_r:root_t tclass=3Dchr_file
Feb 15 19:32:44 virt kernel: [    0.506963] type=3D1400 audit(1360953160.50=
6:4): avc:  denied  { read write } for  pid=3D1 comm=3D"init" path=3D"/dev/=
console" dev=3D"rootfs" ino=3D1562 scontext=3Dsystem_u:system_r:init_t tcon=
text=3Dsystem_u:object_r:root_t tclass=3Dchr_file
Feb 15 19:32:44 virt kernel: [    0.564095] type=3D1400 audit(1360953160.56=
4:5): avc:  denied  { read write } for  pid=3D1 comm=3D"init" path=3D"/dev/=
console" dev=3D"rootfs" ino=3D1562 scontext=3Dsystem_u:system_r:init_t tcon=
text=3Dsystem_u:object_r:root_t tclass=3Dchr_file
Feb 15 19:32:44 virt kernel: [    0.567995] type=3D1400 audit(1360953160.56=
7:6): avc:  denied  { rlimitinh } for  pid=3D1 comm=3D"init" scontext=3Dsys=
tem_u:system_r:kernel_t tcontext=3Dsystem_u:system_r:init_t tclass=3Dprocess
Feb 15 19:32:44 virt kernel: [    0.569326] type=3D1400 audit(1360953160.56=
9:7): avc:  denied  { siginh } for  pid=3D1 comm=3D"init" scontext=3Dsystem=
_u:system_r:kernel_t tcontext=3Dsystem_u:system_r:init_t tclass=3Dprocess
Feb 15 19:32:44 virt kernel: [    0.570239] type=3D1400 audit(1360953160.57=
0:8): avc:  denied  { noatsecure } for  pid=3D1 comm=3D"init" scontext=3Dsy=
stem_u:system_r:kernel_t tcontext=3Dsystem_u:system_r:init_t tclass=3Dproce=
ss
Feb 15 19:32:44 virt kernel: [    0.571689] type=3D1400 audit(1360953160.57=
1:9): avc:  denied  { getattr } for  pid=3D1 comm=3D"init" name=3D"/" dev=
=3D"selinuxfs" ino=3D1 scontext=3Dsystem_u:system_r:init_t tcontext=3Dsyste=
m_u:object_r:security_t tclass=3Dfilesystem
Feb 15 19:32:44 virt kernel: [    0.572730] avc_has_perm_noaudit(2f, 5, 7, =
800000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    0.572730] allowed: 0, auditdeny: ffffffff=
, from_access: 0
Feb 15 19:32:44 virt kernel: [    0.572730] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    0.573614] avc_has_perm_noaudit(2f, 5, 7, =
800000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    0.573614] allowed: 0, auditdeny: ffffffff=
, from_access: 0
Feb 15 19:32:44 virt kernel: [    0.573614] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    0.574514] type=3D1400 audit(1360953160.57=
4:10): avc:  denied  { search } for  pid=3D1 comm=3D"init" name=3D"proc" de=
v=3D"sda" ino=3D131360 scontext=3Dsystem_u:system_r:init_t tcontext=3Dsyste=
m_u:object_r:file_t tclass=3Ddir
Feb 15 19:32:44 virt kernel: [    0.575461] avc_has_perm_noaudit(2f, 5, 7, =
800000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    0.575461] allowed: 0, auditdeny: ffffffff=
, from_access: 0
Feb 15 19:32:44 virt kernel: [    0.575461] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    0.576334] avc_has_perm_noaudit(2f, 5, 7, =
800000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    0.576334] allowed: 0, auditdeny: ffffffff=
, from_access: 0
Feb 15 19:32:44 virt kernel: [    0.576334] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    0.579972] avc_has_perm_noaudit(2f, 5, 7, =
800000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    0.579972] allowed: 0, auditdeny: ffffffff=
, from_access: 0
Feb 15 19:32:44 virt kernel: [    0.579972] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    0.583312] avc_has_perm_noaudit(2f, 5, 7, =
800000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    0.583312] allowed: 0, auditdeny: ffffffff=
, from_access: 0
Feb 15 19:32:44 virt kernel: [    0.583312] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    0.677117] kbd_mode (710) used greatest st=
ack depth: 5664 bytes left
Feb 15 19:32:44 virt kernel: [    0.743231] loadkeys (711) used greatest st=
ack depth: 5096 bytes left
Feb 15 19:32:44 virt kernel: [    0.743821] init-early.sh (709) used greate=
st stack depth: 4416 bytes left
Feb 15 19:32:44 virt kernel: [    0.829588] avc_has_perm_noaudit(40, 1f, 7,=
 4, 0, &avd)
Feb 15 19:32:44 virt kernel: [    0.829588] allowed: 850053, auditdeny: fff=
fffff, from_access: 1
Feb 15 19:32:44 virt kernel: [    0.829588] denied: 4, audited: 4
Feb 15 19:32:44 virt kernel: [    0.846962] SELinux: initialized (dev tmpfs=
, type tmpfs), uses transition SIDs
Feb 15 19:32:44 virt kernel: [    0.846986] avc_has_perm_noaudit(40, 33, 7,=
 4, 0, &avd)
Feb 15 19:32:44 virt kernel: [    0.846986] allowed: 850010, auditdeny: fff=
fffff, from_access: 1
Feb 15 19:32:44 virt kernel: [    0.846986] denied: 4, audited: 4
Feb 15 19:32:44 virt kernel: [    1.104186] tsc: Refined TSC clocksource ca=
libration: 2491.780 MHz
Feb 15 19:32:44 virt kernel: [    1.420375] avc_has_perm_noaudit(40, 21, 7,=
 4, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.420375] allowed: 850053, auditdeny: fff=
fffff, from_access: 1
Feb 15 19:32:44 virt kernel: [    1.420375] denied: 4, audited: 4
Feb 15 19:32:44 virt kernel: [    1.490189] avc_has_perm_noaudit(40, 21, a,=
 6, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.490189] allowed: 0, auditdeny: ffffffff=
, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.490189] denied: 6, audited: 6
Feb 15 19:32:44 virt kernel: [    1.491187] avc_has_perm_noaudit(40, 24, 7,=
 4, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.491187] allowed: 850053, auditdeny: fff=
fffff, from_access: 1
Feb 15 19:32:44 virt kernel: [    1.491187] denied: 4, audited: 4
Feb 15 19:32:44 virt kernel: [    1.501860] avc_has_perm_noaudit(40, 21, a,=
 6, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.501860] allowed: 0, auditdeny: ffffffff=
, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.501860] denied: 6, audited: 6
Feb 15 19:32:44 virt kernel: [    1.502919] SELinux: initialized (dev tmpfs=
, type tmpfs), uses transition SIDs
Feb 15 19:32:44 virt kernel: [    1.502926] avc_has_perm_noaudit(40, 21, 7,=
 4, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.502926] allowed: 850053, auditdeny: fff=
fffff, from_access: 1
Feb 15 19:32:44 virt kernel: [    1.502926] denied: 4, audited: 4
Feb 15 19:32:44 virt kernel: [    1.586961] avc_has_perm_noaudit(40, 21, a,=
 6, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.586961] allowed: 0, auditdeny: ffffffff=
, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.586961] denied: 6, audited: 6
Feb 15 19:32:44 virt kernel: [    1.587066] SELinux: initialized (dev secur=
ityfs, type securityfs), uses genfs_contexts
Feb 15 19:32:44 virt kernel: [    1.587073] avc_has_perm_noaudit(40, 2, 7, =
4, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.587073] allowed: 850053, auditdeny: fff=
fffff, from_access: 1
Feb 15 19:32:44 virt kernel: [    1.587073] denied: 4, audited: 4
Feb 15 19:32:44 virt kernel: [    1.652930] avc_has_perm_noaudit(40, 21, a,=
 6, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.652930] allowed: 0, auditdeny: ffffffff=
, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.652930] denied: 6, audited: 6
Feb 15 19:32:44 virt kernel: [    1.653046] avc_has_perm_noaudit(40, 22, 7,=
 4, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.653046] allowed: 850010, auditdeny: fff=
fffff, from_access: 1
Feb 15 19:32:44 virt kernel: [    1.653046] denied: 4, audited: 4
Feb 15 19:32:44 virt kernel: [    1.661059] avc_has_perm_noaudit(40, 21, a,=
 6, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.661059] allowed: 0, auditdeny: ffffffff=
, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.661059] denied: 6, audited: 6
Feb 15 19:32:44 virt kernel: [    1.661201] SELinux: initialized (dev tmpfs=
, type tmpfs), uses transition SIDs
Feb 15 19:32:44 virt kernel: [    1.661209] avc_has_perm_noaudit(40, 1c, 7,=
 4, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.661209] allowed: 850053, auditdeny: fff=
fffff, from_access: 1
Feb 15 19:32:44 virt kernel: [    1.661209] denied: 4, audited: 4
Feb 15 19:32:44 virt kernel: [    1.666659] avc_has_perm_noaudit(40, 21, a,=
 6, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.666659] allowed: 0, auditdeny: ffffffff=
, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.666659] denied: 6, audited: 6
Feb 15 19:32:44 virt kernel: [    1.666768] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.666768] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.666768] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.666775] cgroup_addrm_files: failed to a=
dd tasks, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.666777] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.666777] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.666777] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.666781] cgroup_addrm_files: failed to a=
dd cgroup.procs, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.666782] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.666782] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.666782] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.666786] cgroup_addrm_files: failed to a=
dd notify_on_release, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.666788] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.666788] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.666788] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.666791] cgroup_addrm_files: failed to a=
dd cgroup.event_control, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.666793] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.666793] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.666793] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.666797] cgroup_addrm_files: failed to a=
dd cgroup.clone_children, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.666798] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.666798] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.666798] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.666802] cgroup_addrm_files: failed to a=
dd release_agent, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.666808] SELinux: initialized (dev cgrou=
p, type cgroup), uses genfs_contexts
Feb 15 19:32:44 virt kernel: [    1.666833] avc_has_perm_noaudit(40, 46, 7,=
 4, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.666833] allowed: 850010, auditdeny: fff=
fffff, from_access: 1
Feb 15 19:32:44 virt kernel: [    1.666833] denied: 4, audited: 4
Feb 15 19:32:44 virt kernel: [    1.669184] avc_has_perm_noaudit(40, 21, a,=
 6, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.669184] allowed: 0, auditdeny: ffffffff=
, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.669184] denied: 6, audited: 6
Feb 15 19:32:44 virt kernel: [    1.669260] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.669260] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.669260] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.669266] cgroup_addrm_files: failed to a=
dd tasks, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.669268] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.669268] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.669268] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.669272] cgroup_addrm_files: failed to a=
dd cgroup.procs, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.669274] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.669274] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.669274] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.669277] cgroup_addrm_files: failed to a=
dd notify_on_release, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.669279] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.669279] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.669279] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.669283] cgroup_addrm_files: failed to a=
dd cgroup.event_control, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.669284] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.669284] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.669284] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.669288] cgroup_addrm_files: failed to a=
dd cgroup.clone_children, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.669289] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.669289] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.669289] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.669293] cgroup_addrm_files: failed to a=
dd release_agent, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.669296] SELinux: initialized (dev cgrou=
p, type cgroup), uses genfs_contexts
Feb 15 19:32:44 virt kernel: [    1.669302] avc_has_perm_noaudit(40, 46, 7,=
 4, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.669302] allowed: 850010, auditdeny: fff=
fffff, from_access: 1
Feb 15 19:32:44 virt kernel: [    1.669302] denied: 4, audited: 4
Feb 15 19:32:44 virt kernel: [    1.670658] avc_has_perm_noaudit(40, 21, a,=
 6, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.670658] allowed: 0, auditdeny: ffffffff=
, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.670658] denied: 6, audited: 6
Feb 15 19:32:44 virt kernel: [    1.670730] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.670730] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.670730] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.670736] cgroup_addrm_files: failed to a=
dd tasks, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.670738] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.670738] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.670738] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.670742] cgroup_addrm_files: failed to a=
dd cgroup.procs, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.670743] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.670743] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.670743] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.670747] cgroup_addrm_files: failed to a=
dd notify_on_release, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.670748] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.670748] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.670748] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.670752] cgroup_addrm_files: failed to a=
dd cgroup.event_control, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.670754] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.670754] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.670754] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.670757] cgroup_addrm_files: failed to a=
dd cgroup.clone_children, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.670759] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.670759] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.670759] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.670763] cgroup_addrm_files: failed to a=
dd release_agent, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.670765] SELinux: initialized (dev cgrou=
p, type cgroup), uses genfs_contexts
Feb 15 19:32:44 virt kernel: [    1.670771] avc_has_perm_noaudit(40, 46, 7,=
 4, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.670771] allowed: 850010, auditdeny: fff=
fffff, from_access: 1
Feb 15 19:32:44 virt kernel: [    1.670771] denied: 4, audited: 4
Feb 15 19:32:44 virt kernel: [    1.672179] avc_has_perm_noaudit(40, 21, a,=
 6, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.672179] allowed: 0, auditdeny: ffffffff=
, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.672179] denied: 6, audited: 6
Feb 15 19:32:44 virt kernel: [    1.672260] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.672260] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.672260] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.672266] cgroup_addrm_files: failed to a=
dd tasks, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.672268] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.672268] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.672268] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.672272] cgroup_addrm_files: failed to a=
dd cgroup.procs, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.672273] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.672273] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.672273] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.672279] cgroup_addrm_files: failed to a=
dd notify_on_release, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.672281] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.672281] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.672281] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.672286] cgroup_addrm_files: failed to a=
dd cgroup.event_control, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.672287] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.672287] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.672287] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.672291] cgroup_addrm_files: failed to a=
dd cgroup.clone_children, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.672293] avc_has_perm_noaudit(1, 3, 7, 8=
00000, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.672293] allowed: 10000, auditdeny: ffff=
ffff, from_access: 0
Feb 15 19:32:44 virt kernel: [    1.672293] denied: 800000, audited: 800000
Feb 15 19:32:44 virt kernel: [    1.672297] cgroup_addrm_files: failed to a=
dd release_agent, err=3D-13
Feb 15 19:32:44 virt kernel: [    1.672299] SELinux: initialized (dev cgrou=
p, type cgroup), uses genfs_contexts
Feb 15 19:32:44 virt kernel: [    1.672306] avc_has_perm_noaudit(40, 46, 7,=
 4, 0, &avd)
Feb 15 19:32:44 virt kernel: [    1.672306] allowed: 850010, auditdeny: fff=
fffff, from_access: 1
Feb 15 19:32:44 virt kernel: [    1.672306] denied: 4, audited: 4
Feb 15 19:32:44 virt kernel: [    3.174413] avc_has_perm_noaudit(40, 33, 7,=
 4, 0, &avd)
Feb 15 19:32:44 virt kernel: [    3.174413] allowed: 850010, auditdeny: fff=
fffff, from_access: 1
Feb 15 19:32:44 virt kernel: [    3.174413] denied: 4, audited: 4
Feb 15 19:32:44 virt kernel: [    4.240111] SELinux: initialized (dev binfm=
t_misc, type binfmt_misc), uses genfs_contexts
Feb 15 19:32:44 virt kernel: [    4.240133] avc_has_perm_noaudit(40, 7a, 7,=
 4, 0, &avd)
Feb 15 19:32:44 virt kernel: [    4.240133] allowed: 850010, auditdeny: fff=
fffff, from_access: 1
Feb 15 19:32:44 virt kernel: [    4.240133] denied: 4, audited: 4
Feb 15 19:32:44 virt kernel: [    4.309095] avc_has_perm_noaudit(40, 2, 7, =
4, 0, &avd)
Feb 15 19:32:44 virt kernel: [    4.309095] allowed: 850053, auditdeny: fff=
fffff, from_access: 1
Feb 15 19:32:44 virt kernel: [    4.309095] denied: 4, audited: 4
Feb 15 19:33:09 virt kernel: [   29.071179] audit_printk_skb: 643 callbacks=
 suppressed
Feb 15 19:33:09 virt kernel: [   29.071188] type=3D1400 audit(1360953189.08=
1:225): avc:  denied  { rlimitinh } for  pid=3D1369 comm=3D"login" scontext=
=3Dsystem_u:system_r:getty_t tcontext=3Dsystem_u:system_r:local_login_t tcl=
ass=3Dprocess
Feb 15 19:33:09 virt kernel: [   29.071209] type=3D1400 audit(1360953189.08=
1:226): avc:  denied  { siginh } for  pid=3D1369 comm=3D"login" scontext=3D=
system_u:system_r:getty_t tcontext=3Dsystem_u:system_r:local_login_t tclass=
=3Dprocess
Feb 15 19:33:09 virt kernel: [   29.071256] type=3D1400 audit(1360953189.08=
1:227): avc:  denied  { noatsecure } for  pid=3D1369 comm=3D"login" scontex=
t=3Dsystem_u:system_r:getty_t tcontext=3Dsystem_u:system_r:local_login_t tc=
lass=3Dprocess
Feb 15 19:33:09 virt kernel: [   29.262718] type=3D1400 audit(1360953189.27=
2:228): avc:  denied  { read write } for  pid=3D1376 comm=3D"unix_chkpwd" p=
ath=3D"/dev/tty1" dev=3D"devtmpfs" ino=3D1496 scontext=3Dsystem_u:system_r:=
chkpwd_t tcontext=3Dsystem_u:object_r:tty_device_t tclass=3Dchr_file
Feb 15 19:33:09 virt kernel: [   29.262781] type=3D1400 audit(1360953189.27=
2:229): avc:  denied  { rlimitinh } for  pid=3D1376 comm=3D"unix_chkpwd" sc=
ontext=3Dsystem_u:system_r:local_login_t tcontext=3Dsystem_u:system_r:chkpw=
d_t tclass=3Dprocess
Feb 15 19:33:09 virt kernel: [   29.262800] type=3D1400 audit(1360953189.27=
2:230): avc:  denied  { siginh } for  pid=3D1376 comm=3D"unix_chkpwd" scont=
ext=3Dsystem_u:system_r:local_login_t tcontext=3Dsystem_u:system_r:chkpwd_t=
 tclass=3Dprocess
Feb 15 19:33:09 virt kernel: [   29.262874] type=3D1400 audit(1360953189.27=
2:231): avc:  denied  { noatsecure } for  pid=3D1376 comm=3D"unix_chkpwd" s=
context=3Dsystem_u:system_r:local_login_t tcontext=3Dsystem_u:system_r:chkp=
wd_t tclass=3Dprocess
Feb 15 19:33:09 virt kernel: [   29.265504] avc_has_perm_noaudit(88, 1c, 7,=
 800000, 0, &avd)
Feb 15 19:33:09 virt kernel: [   29.265504] allowed: 0, auditdeny: ffffffff=
, from_access: 0
Feb 15 19:33:09 virt kernel: [   29.265504] denied: 800000, audited: 800000
Feb 15 19:33:09 virt kernel: [   29.265535] type=3D1400 audit(1360953189.27=
5:232): avc:  denied  { search } for  pid=3D1376 comm=3D"unix_chkpwd" name=
=3D"/" dev=3D"sysfs" ino=3D1 scontext=3Dsystem_u:system_r:chkpwd_t tcontext=
=3Dsystem_u:object_r:sysfs_t tclass=3Ddir
Feb 15 19:33:09 virt kernel: [   29.265578] type=3D1400 audit(1360953189.27=
5:233): avc:  denied  { getattr } for  pid=3D1376 comm=3D"unix_chkpwd" name=
=3D"/" dev=3D"selinuxfs" ino=3D1 scontext=3Dsystem_u:system_r:chkpwd_t tcon=
text=3Dsystem_u:object_r:security_t tclass=3Dfilesystem
Feb 15 19:33:09 virt kernel: [   29.266882] avc_has_perm_noaudit(88, 1c, 7,=
 800000, 0, &avd)
Feb 15 19:33:09 virt kernel: [   29.266882] allowed: 0, auditdeny: ffffffff=
, from_access: 0
Feb 15 19:33:09 virt kernel: [   29.266882] denied: 800000, audited: 800000
Feb 15 19:33:09 virt kernel: [   29.266909] type=3D1400 audit(1360953189.27=
6:234): avc:  denied  { search } for  pid=3D1376 comm=3D"unix_chkpwd" name=
=3D"/" dev=3D"sysfs" ino=3D1 scontext=3Dsystem_u:system_r:chkpwd_t tcontext=
=3Dsystem_u:object_r:sysfs_t tclass=3Ddir
Feb 15 19:33:10 virt kernel: [   30.709703] avc_has_perm_noaudit(88, 1c, 7,=
 800000, 0, &avd)
Feb 15 19:33:10 virt kernel: [   30.709703] allowed: 0, auditdeny: ffffffff=
, from_access: 0
Feb 15 19:33:10 virt kernel: [   30.709703] denied: 800000, audited: 800000
Feb 15 19:33:10 virt kernel: [   30.709847] avc_has_perm_noaudit(88, 1c, 7,=
 800000, 0, &avd)
Feb 15 19:33:10 virt kernel: [   30.709847] allowed: 0, auditdeny: ffffffff=
, from_access: 0
Feb 15 19:33:10 virt kernel: [   30.709847] denied: 800000, audited: 800000
Feb 15 19:33:10 virt kernel: [   30.723471] avc_has_perm_noaudit(88, 1c, 7,=
 800000, 0, &avd)
Feb 15 19:33:10 virt kernel: [   30.723471] allowed: 0, auditdeny: ffffffff=
, from_access: 0
Feb 15 19:33:10 virt kernel: [   30.723471] denied: 800000, audited: 800000
Feb 15 19:33:10 virt kernel: [   30.723934] avc_has_perm_noaudit(88, 1c, 7,=
 800000, 0, &avd)
Feb 15 19:33:10 virt kernel: [   30.723934] allowed: 0, auditdeny: ffffffff=
, from_access: 0
Feb 15 19:33:10 virt kernel: [   30.723934] denied: 800000, audited: 800000
Feb 15 19:34:00 virt kernel: [   80.574008] audit_printk_skb: 51 callbacks =
suppressed
Feb 15 19:34:00 virt kernel: [   80.574016] type=3D1400 audit(1360953240.58=
3:252): avc:  denied  { rlimitinh } for  pid=3D1386 comm=3D"rc" scontext=3D=
system_u:system_r:init_t tcontext=3Dsystem_u:system_r:initrc_t tclass=3Dpro=
cess
Feb 15 19:34:00 virt kernel: [   80.574154] type=3D1400 audit(1360953240.58=
4:253): avc:  denied  { siginh } for  pid=3D1386 comm=3D"rc" scontext=3Dsys=
tem_u:system_r:init_t tcontext=3Dsystem_u:system_r:initrc_t tclass=3Dprocess
Feb 15 19:34:00 virt kernel: [   80.574189] type=3D1400 audit(1360953240.58=
4:254): avc:  denied  { noatsecure } for  pid=3D1386 comm=3D"rc" scontext=
=3Dsystem_u:system_r:init_t tcontext=3Dsystem_u:system_r:initrc_t tclass=3D=
process

--MP_/T7k_qIdbGHvybn1BybdSJ+G--

--Sig_/oXq.dbMRWsqE=483d_FLAL2
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBCgAGBQJRHoILAAoJEOBVC/zizycOLPQP/A4I5zkGINpX362eVFpkM1Z+
HgHjzYN/kskD6+FzhTvFI9Wzs5fmcKhn0AkdsaSJ92jmIMatTtZLYGkYW3jHg3m5
RYupwqNgGwt7syJXUyGY1vRdz2X5Icyalh6ms+12jqEVpfoczi10weyqNp7JjOWH
4vDAGm2bJvYxHMX/3z/PGxS/e2DKXsZsYT8JzoprLjAnOFqX5TTCT7wAeUWTEevs
qmy3if74jL37IKZbgeLS2uR8lX5P/gMLYb2eFS3VXoYw3zcI9Hq2g+iH9cTO4lWF
eKh3Zmy+pOM79SOLgGSbUuGZG0dQZmmoXGV7ob7PFdi9e5O+SGK9qxU8qnZb3Aof
RgDe6DVEa2XDHNMkTb4+zDtfu9B9CS3we8zNyNmGby/VPTolz5iaVnCQNyL/DLh7
06DKwlGfuKfNgMaOditNLyqHx1KI4MFkxtYX85OzCS01YBkCly6AshwxCkc9Sg+y
gQnzEaVYLccSA/VR4/0odAKpWzDKQI+SeabhTTvZoDeD8Jb7eXzWpnbkvSuOP4KT
Yz+lAwrSG2zVQgsgis7J6QmtHZb+KdgxQn5oVbeJl1bADHpsgagDF086z8/nVgTT
fmh+QtKzUaFDj3lo6kVgqU0R5BT+5O4seBqNvAK/W6rz1PtY1i/dhE6UFMnM9/nN
bW2w3R6JTMU9Hxh0OQIL
=C+zK
-----END PGP SIGNATURE-----

--Sig_/oXq.dbMRWsqE=483d_FLAL2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
