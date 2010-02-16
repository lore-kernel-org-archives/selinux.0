From: Alan Rouse <alan.rouse@ericsson.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Date: Tue, 16 Feb 2010 16:30:24 -0500
Subject: RE: SELinux Policy in OpenSUSE 11.2
Message-ID: <5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8@EUSAACMS0703.eamcs.ericsson.se>
References: <5A5E55DF96F73844AF7DFB0F48721F0F529A558532@EUSAACMS0703.eamcs.ericsson.se>
	 <1266347411.5252.107.camel@moss-pluto.epoch.ncsc.mil>
	 <5A5E55DF96F73844AF7DFB0F48721F0F529A5587DD@EUSAACMS0703.eamcs.ericsson.se>
 <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>
In-Reply-To: <1266349121.5252.131.camel@moss-pluto.epoch.ncsc.mil>
Content-Type: multipart/mixed;
	boundary="_002_5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8EUSAACMS0703e_"
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--_002_5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8EUSAACMS0703e_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I had been trying various things in this image.  So, just to be sure I have=
 a repeatable state, I've rebuilt my system from scratch as follows:

1. standard OpenSuse 11.2 install (using Gnome);  boot; start terminal; su =
-
2.  install packages:=20

selinux-tools=20
selinux-policy=20
libselinux*=20
libsemanage*=20
policycoreutils=20
checkpolicy  =20
make=20
m4=20
gcc=20
findutils-locate=20
git

3.  add "3 security=3Dselinux selinux=3D1 enforcing=3D0" to the grub boot l=
ine (boot to runlevel 3 with selinux in permissive mode) and reboot.
4.  git clone http://oss.tresys.com/git/refpolicy.git
5.  change build.conf:  "DIST =3D suse"  and "MONOLITHIC =3D n"
6.  make clean; make conf; make; make install-src;=20
7.  change /etc/refpolicy to point to the just-built policy version, and re=
boot
8.  restorecon -R /; reboot

sestatus -v gives:
SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   permissive
Mode from config file:          permissive
Policy version:                 24
Policy from config file:        refpolicy

Process contexts:
Current context:                system_u:system_r:sysadm_t
Init context:                   system_u:system_r:init_t
/sbin/mingetty                  system_u:system_r:sysadm_t

File contexts:
Controlling term:               system_u:object_r:tty_device_t
/etc/passwd                     system_u:object_r:etc_t
/etc/shadow                     system_u:object_r:shadow_t
/bin/bash                       system_u:object_r:shell_exec_t
/bin/login                      system_u:object_r:login_exec_t
/bin/sh                         system_u:object_r:bin_t -> system_u:object_=
r:shell_exec_t
/sbin/agetty                    system_u:object_r:getty_exec_t
/sbin/init                      system_u:object_r:init_exec_t
/sbin/mingetty                  system_u:object_r:getty_exec_t
/usr/sbin/sshd                  system_u:object_r:sshd_exec_t
/lib/libc.so.6                  system_u:object_r:lib_t -> system_u:object_=
r:lib_t
/lib/ld-linux.so.2              system_u:object_r:lib_t -> system_u:object_=
r:ld_so_t

pstree- Z gives:
init(`system_u:system_r:init_t')
 |-acpid(`system_u:system_r:sysadm_t')
 |-auditd(`system_u:system_r:sysadm_t')
 |  |-audispd(`system_u:system_r:sysadm_t')
 |  |  `-{audispd}(`system_u:system_r:sysadm_t')
 |  `-{auditd}(`system_u:system_r:sysadm_t')
 |-cron(`system_u:system_r:sysadm_t')
 |-cupsd(`system_u:system_r:sysadm_t')
 |-dbus-daemon(`system_u:system_r:sysadm_dbusd_t')
 |  `-{dbus-daemon}(`system_u:system_r:sysadm_dbusd_t')
 |-dhcpcd(`system_u:system_r:dhcpc_t')
 |-login(`system_u:system_r:sysadm_t')
 |  `-bash(`system_u:system_r:sysadm_t')
 |     `-pstree(`system_u:system_r:sysadm_t')
 |-master(`system_u:system_r:sysadm_t')
 |  |-pickup(`system_u:system_r:sysadm_t')
 |  `-qmgr(`system_u:system_r:sysadm_t')
 |-mingetty(`system_u:system_r:sysadm_t')
 |-mingetty(`system_u:system_r:sysadm_t')
 |-mingetty(`system_u:system_r:sysadm_t')
 |-mingetty(`system_u:system_r:sysadm_t')
 |-mingetty(`system_u:system_r:sysadm_t')
 |-nscd(`system_u:system_r:sysadm_t')
 |-rpcbind(`system_u:system_r:sysadm_t')
 |-rsyslogd(`system_u:system_r:sysadm_t')
 |  |-{rsyslogd}(`system_u:system_r:sysadm_t')
 |  |-{rsyslogd}(`system_u:system_r:sysadm_t')
 |  |-{rsyslogd}(`system_u:system_r:sysadm_t')
 |  `-{rsyslogd}(`system_u:system_r:sysadm_t')
 |-startpar(`system_u:system_r:sysadm_t')
 |-udevd(`system_u:system_r:sysadm_t')
 |  |-udevd(`system_u:system_r:sysadm_t')
 |  `-udevd(`system_u:system_r:sysadm_t')
 `-vmtoolsd(`system_u:system_r:sysadm_t')

Now, I tried setsebool -P init_upstart=3D1.  It gives an error message:
----------------
Libsemanage.get_home_dirs: nobody homedir /var/lib/nobody or its parent dir=
ectory conflicts with a file context already specified in the policy.  This=
 usually indicates an incorrectly defined system account.  If it is a syste=
m account please make sure its uid is less than 1000 or its log in shell is=
 /sbin/nologin.
----------------

So I did "usermod -s /sbin/nologin nobody" and repeated the setsebool (no e=
rror message returned, and "getsebool init_upstart" reports that it was on.=
  But after reboot it is off again...



-----Original Message-----
From: Stephen Smalley [mailto:sds@tycho.nsa.gov]=20
Sent: Tuesday, February 16, 2010 2:39 PM
To: Alan Rouse
Cc: 'selinux@tycho.nsa.gov'
Subject: RE: SELinux Policy in OpenSUSE 11.2

On Tue, 2010-02-16 at 14:19 -0500, Alan Rouse wrote:
> "sestatus -v" reports the following:
>=20
> SELinux status:                 enabled
> SELinuxfs mount:                /selinux
> Current mode:                   permissive
> Mode from config file:          permissive
> Policy version:                 24
> Policy from config file:        refpolicy
>=20
> Process contexts:
> Current context:                system_u:system_r:sysadm_t
> Init context:                   system_u:system_r:init_t
> /sbin/mingetty                  system_u:system_r:sysadm_t

Ok, so init is in the right security context, but getty is not.
refpolicy has a rule that says if init runs a shell, transition to sysadm_t=
 - that is for single-user mode.  But that gets disabled if using upstart s=
ince upstart runs everything via a shell.

Try:
setsebool -P init_upstart=3D1
reboot

pstree -Z output might also be interesting.

--
Stephen Smalley
National Security Agency


--_002_5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8EUSAACMS0703e_
Content-Type: text/plain; name="opensuse-selinux-0.5.txt"
Content-Description: opensuse-selinux-0.5.txt
Content-Disposition: attachment; filename="opensuse-selinux-0.5.txt";
	size=728; creation-date="Tue, 16 Feb 2010 14:36:09 GMT";
	modification-date="Tue, 16 Feb 2010 15:57:47 GMT"
Content-Transfer-Encoding: base64

MS4gIERlZmF1bHQgaW5zdGFsbCBvZiBPcGVuU3VzZSAxMS4yICh1c2VkIEdub21lIGRlc2t0b3Ap
DQoyLiAgQm9vdCBub3JtYWxseSB0byBkZXNrdG9wLCBvcGVuIHRlcm1pbmFsLCBzdSAtDQozLiAg
RG8gdGhpczoNCg0KenlwcGVyIGluc3RhbGwgc2VsaW51eC10b29scyBzZWxpbnV4LXBvbGljeSBs
aWJzZWxpbnV4KiBsaWJzZW1hbmFnZSogcG9saWN5Y29yZXV0aWxzIGNoZWNrcG9saWN5ICBtYWtl
IG00IGdjYyBmaW5kdXRpbHMtbG9jYXRlIGdpdA0KDQp2aSAvYm9vdC9ncnViL21lbnUubHN0IA0K
IC0tIGFuZCBhZGQgdG8gdGhlIERlc2t0b3Aga2VybmVsIGJvb3QgbGluZTogIjMgc2VjdXJpdHk9
c2VsaW51eCBzZWxpbnV4PTEgZW5mb3JjaW5nPTAiDQoNCjQuICBSZWJvb3QgYW5kIGxvZyBpbiBh
cyByb290DQoNCjUuICBEbyB0aGlzOg0KDQpnaXQgY2xvbmUgaHR0cDovL29zcy50cmVzeXMuY29t
L2dpdC9yZWZwb2xpY3kuZ2l0DQpjZCByZWZwb2xpY3kNCmVkaXQgYnVpbGQuY29uZjsgc2V0ICJE
SVNUID0gc3VzZSIgYW5kICJNT05PTElUSElDID0gbiINCm1ha2UgY2xlYW47IG1ha2UgY29uZjsg
bWFrZTsgbWFrZSBpbnN0YWxsLXNyYw0KdmkgL2V0Yy9zZWxpbnV4L2NvbmYNCiAtLSBzZXQgPXJl
ZnBvbGljeQ0KDQpyZWJvb3QNCg0KNi4gcmVzdG9yZWNvbiAtUiAvOyByZWJvb3QNCjcuIHNldHNl
Ym9vbCAtUCBpbml0X3Vwc3RhcnQ9MTsgcmVib290DQoNCg0KDQoNCg0KDQo=

--_002_5A5E55DF96F73844AF7DFB0F48721F0F529A5588F8EUSAACMS0703e_--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
