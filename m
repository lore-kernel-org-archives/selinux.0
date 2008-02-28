Message-ID: <47C703C9.9070102@redhat.com>
Date: Thu, 28 Feb 2008 13:56:09 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Eamon Walsh <ewalsh@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
CC: Tom London <selinux@gmail.com>
Subject: [Fwd: gnome login broken.... "null" avcs...]
Content-Type: multipart/mixed;
 boundary="------------020802090602000600090701"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020802090602000600090701
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


type=USER_AVC msg=audit(1204212885.241:38): user pid=2907 uid=0
auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023
msg='avc:  denied  null for request=<unknown> comm=compiz resid=24000cf
restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0
tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable :
exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'


How do we label this?


- -------- Original Message --------
Subject: gnome login broken.... "null" avcs...
Date: Thu, 28 Feb 2008 07:41:27 -0800
From: Tom London <selinux@gmail.com>
To: fedora-selinux <fedora-selinux-list@redhat.com>

After applying today's selinux-policy* packages, gnome/gdm login
fails: gdmgreeter runs, but X quickly dies after enter password and
you're back to the greeter.

Booting up in permissive lets me log in.

Here are the borkages:


#============= mono_t ==============
allow mono_t xdm_xserver_t:x_device read;

#============= unconfined_execmem_t ==============
allow unconfined_execmem_t xdm_xserver_t:x_device read;

#============= unconfined_t ==============
allow unconfined_t mono_t:x_resource write;
allow unconfined_t unconfined_execmem_t:x_resource { write read };
allow unconfined_t unlabeled_t:x_drawable { destroy getattr };
[root@localhost ~]#

I attach complete log file.

This something to do with new X keyboard confinement stuff?

tom
- --
Tom London

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkfHA8gACgkQrlYvE4MpobMNyQCg4UqiIbg9sFAbZRpAIJb89AdJ
J8oAni2eoCjg+pNAsXpUsOuY7uqCXScP
=nvTM
-----END PGP SIGNATURE-----

--------------020802090602000600090701
Content-Type: text/plain;
 name="log.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="log.txt"

type=DAEMON_START msg=audit(1204212488.528:4826): auditd start, ver=1.6.8 format=raw kernel=2.6.25-0.73.rc3.git1.fc9 auid=4294967295 pid=2192 res=success
type=CONFIG_CHANGE msg=audit(1204212488.734:4): audit_backlog_limit=320 old=64 by auid=4294967295 subj=system_u:system_r:auditctl_t:s0 res=1
type=LABEL_LEVEL_CHANGE msg=audit(1204212504.552:5): user pid=2398 uid=0 auid=4294967295 subj=system_u:system_r:cupsd_t:s0-s0:c0.c1023 msg='printer=Cups-PDF uri=cups-pdf:/ banners=none,none range=unknown: exe="/usr/sbin/cupsd" (hostname=localhost.localdomain, addr=127.0.0.1, terminal=? res=success)'
type=LABEL_LEVEL_CHANGE msg=audit(1204212504.676:6): user pid=2398 uid=0 auid=4294967295 subj=system_u:system_r:cupsd_t:s0-s0:c0.c1023 msg='printer=HP5MP uri=hp:/par/HP_LaserJet_5MP?device=/dev/parport0 banners=none,none range=unknown: exe="/usr/sbin/cupsd" (hostname=localhost.localdomain, addr=127.0.0.1, terminal=? res=success)'
type=LABEL_LEVEL_CHANGE msg=audit(1204212504.858:7): user pid=2398 uid=0 auid=4294967295 subj=system_u:system_r:cupsd_t:s0-s0:c0.c1023 msg='printer=hp_laserjet_1300 uri=hp:/usb/hp_LaserJet_1300?serial=00CNCB954325 banners=none,none range=unknown: exe="/usr/sbin/cupsd" (hostname=localhost.localdomain, addr=127.0.0.1, terminal=? res=success)'
type=LABEL_LEVEL_CHANGE msg=audit(1204212505.027:8): user pid=2398 uid=0 auid=4294967295 subj=system_u:system_r:cupsd_t:s0-s0:c0.c1023 msg='printer=hp_LaserJet_1300_USB_1 uri=usb://HP/LaserJet%201300 banners=none,none range=unknown: exe="/usr/sbin/cupsd" (hostname=localhost.localdomain, addr=127.0.0.1, terminal=? res=success)'
type=LABEL_LEVEL_CHANGE msg=audit(1204212505.147:9): user pid=2398 uid=0 auid=4294967295 subj=system_u:system_r:cupsd_t:s0-s0:c0.c1023 msg='printer=Kyocera_FS-C5030N_on_dc1 uri=socket://10.10.3.49:9100 banners=none,none range=unknown: exe="/usr/sbin/cupsd" (hostname=localhost.localdomain, addr=127.0.0.1, terminal=? res=success)'
type=LABEL_LEVEL_CHANGE msg=audit(1204212505.213:10): user pid=2398 uid=0 auid=4294967295 subj=system_u:system_r:cupsd_t:s0-s0:c0.c1023 msg='printer=SavinColor uri=ipp://10.10.3.47/ipp/ banners=none,none range=unknown: exe="/usr/sbin/cupsd" (hostname=localhost.localdomain, addr=127.0.0.1, terminal=? res=success)'
type=LABEL_LEVEL_CHANGE msg=audit(1204212505.295:11): user pid=2398 uid=0 auid=4294967295 subj=system_u:system_r:cupsd_t:s0-s0:c0.c1023 msg='printer=Innopath uri=file:/dev/null banners=none,none range=unknown: exe="/usr/sbin/cupsd" (hostname=localhost.localdomain, addr=127.0.0.1, terminal=? res=success)'
type=LABEL_LEVEL_CHANGE msg=audit(1204212505.296:12): user pid=2398 uid=0 auid=4294967295 subj=system_u:system_r:cupsd_t:s0-s0:c0.c1023 msg='printer=Local uri=file:/dev/null banners=none,none range=unknown: exe="/usr/sbin/cupsd" (hostname=localhost.localdomain, addr=127.0.0.1, terminal=? res=success)'
type=USER_AUTH msg=audit(1204212517.148:13): user pid=2570 uid=0 auid=4294967295 subj=system_u:system_r:local_login_t:s0-s0:c0.c1023 msg='op=PAM:authentication acct=root exe="/bin/login" (hostname=?, addr=?, terminal=tty1 res=success)'
type=USER_ACCT msg=audit(1204212517.158:14): user pid=2570 uid=0 auid=4294967295 subj=system_u:system_r:local_login_t:s0-s0:c0.c1023 msg='op=PAM:accounting acct=root exe="/bin/login" (hostname=?, addr=?, terminal=tty1 res=success)'
type=LOGIN msg=audit(1204212517.161:15): login pid=2570 uid=0 old auid=4294967295 new auid=0 old ses=4294967295 new ses=1
type=USER_ROLE_CHANGE msg=audit(1204212517.238:16): user pid=2570 uid=0 auid=0 subj=system_u:system_r:local_login_t:s0-s0:c0.c1023 msg='pam: default-context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c255 selected-context=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c255: exe="/bin/login" (hostname=?, addr=?, terminal=tty1 res=success)'
type=USER_START msg=audit(1204212517.438:17): user pid=2570 uid=0 auid=0 subj=system_u:system_r:local_login_t:s0-s0:c0.c1023 msg='op=PAM:session_open acct=root exe="/bin/login" (hostname=?, addr=?, terminal=tty1 res=success)'
type=CRED_ACQ msg=audit(1204212517.439:18): user pid=2570 uid=0 auid=0 subj=system_u:system_r:local_login_t:s0-s0:c0.c1023 msg='op=PAM:setcred acct=root exe="/bin/login" (hostname=?, addr=?, terminal=tty1 res=success)'
type=USER_LOGIN msg=audit(1204212517.441:19): user pid=2570 uid=0 auid=0 subj=system_u:system_r:local_login_t:s0-s0:c0.c1023 msg='uid=0: exe="/bin/login" (hostname=?, addr=?, terminal=tty1 res=success)'
type=MAC_STATUS msg=audit(1204212749.246:20): enforcing=0 old_enforcing=1 auid=0 ses=1
type=SYSCALL msg=audit(1204212749.246:20): arch=40000003 syscall=4 success=yes exit=1 a0=3 a1=bfa308f4 a2=1 a3=bfa308f4 items=0 ppid=2608 pid=2724 auid=0 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=tty1 ses=1 comm="setenforce" exe="/usr/sbin/setenforce" subj=unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c255 key=(null)
type=USER_AVC msg=audit(1204212749.248:21): user pid=2209 uid=81 auid=4294967295 subj=system_u:system_r:system_dbusd_t:s0-s0:c0.c1023 msg='avc:  received setenforce notice (enforcing=0) : exe="?" (sauid=81, hostname=?, addr=?, terminal=?)'
type=USER_AUTH msg=audit(1204212839.130:22): user pid=3079 uid=0 auid=4294967295 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='op=PAM:authentication acct=tbl exe="/usr/libexec/gdm-session-worker" (hostname=?, addr=?, terminal=:0 res=success)'
type=USER_ACCT msg=audit(1204212839.139:23): user pid=3079 uid=0 auid=4294967295 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='op=PAM:accounting acct=tbl exe="/usr/libexec/gdm-session-worker" (hostname=?, addr=?, terminal=:0 res=success)'
type=CRED_ACQ msg=audit(1204212839.142:24): user pid=3079 uid=500 auid=4294967295 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='op=PAM:setcred acct=tbl exe="/usr/libexec/gdm-session-worker" (hostname=?, addr=?, terminal=:0 res=success)'
type=LOGIN msg=audit(1204212839.660:25): login pid=3079 uid=500 old auid=4294967295 new auid=500 old ses=4294967295 new ses=2
type=USER_ROLE_CHANGE msg=audit(1204212839.779:26): user pid=3079 uid=500 auid=500 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='pam: default-context=unconfined_u:unconfined_r:unconfined_t:s0 selected-context=unconfined_u:unconfined_r:unconfined_t:s0: exe="/usr/libexec/gdm-session-worker" (hostname=?, addr=?, terminal=? res=success)'
type=USER_START msg=audit(1204212841.937:27): user pid=3079 uid=500 auid=500 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='op=PAM:session_open acct=tbl exe="/usr/libexec/gdm-session-worker" (hostname=?, addr=?, terminal=:0 res=success)'
type=USER_LOGIN msg=audit(1204212841.941:28): user pid=3079 uid=500 auid=500 subj=system_u:system_r:xdm_t:s0-s0:c0.c1023 msg='uid=500: exe="/usr/libexec/gdm-session-worker" (hostname=, addr=?, terminal=/dev/tty7 res=success)'
type=USER_AVC msg=audit(1204212866.270:29): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=GLX:MakeCurrent comm=compiz resid=b0 restype=WINDOW scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:x_rootwindow_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212866.623:30): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  { read } for request=X11:QueryPointer comm=rhythmbox xdevice="Virtual core pointer" scontext=unconfined_u:unconfined_r:unconfined_execmem_t:s0 tcontext=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 tclass=x_device : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212878.631:31): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2a00044 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:object_r:unconfined_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212878.633:32): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2a0009e restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:object_r:unconfined_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212878.634:33): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2a000d8 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:object_r:unconfined_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212884.002:34): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  { read } for request=X11:QueryPointer comm=mono xdevice="Virtual core pointer" scontext=unconfined_u:unconfined_r:mono_t:s0 tcontext=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 tclass=x_device : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212884.788:35): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2a000d8 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:object_r:unconfined_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212885.236:36): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=24000cb restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212885.238:37): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=24000cd restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212885.241:38): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=24000cf restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212885.251:39): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=24000d1 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212885.253:40): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=24000d3 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212885.255:41): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=24000d5 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212885.486:42): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2a00122 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:object_r:unconfined_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212885.787:43): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2a0017f restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:object_r:unconfined_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212885.807:44): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2a0019c restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:object_r:unconfined_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212895.471:45): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  { write } for request=SHAPE:SelectInput comm=compiz resid=2c00003 restype=<unknown> scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:unconfined_r:unconfined_execmem_t:s0 tclass=x_resource : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212898.797:46): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  { write } for request=SHAPE:SelectInput comm=compiz resid=3a0000c restype=<unknown> scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:unconfined_r:mono_t:s0 tclass=x_resource : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212903.492:47): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  { read } for request=SYNC:CreateAlarm comm=compiz resid=2c0003a restype=<unknown> scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:unconfined_r:unconfined_execmem_t:s0 tclass=x_resource : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212903.510:48): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=24000e5 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212904.598:49): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  { destroy } for request=X11:FreePixmap comm=compiz resid=24000e5 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212905.757:50): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=24000ea restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212908.242:51): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=24000ee restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AUTH msg=audit(1204212913.738:52): user pid=3683 uid=500 auid=500 subj=unconfined_u:unconfined_r:unconfined_t:s0 msg='op=PAM:authentication acct=root exe="/bin/su" (hostname=?, addr=?, terminal=pts/0 res=success)'
type=USER_ACCT msg=audit(1204212913.744:53): user pid=3683 uid=500 auid=500 subj=unconfined_u:unconfined_r:unconfined_t:s0 msg='op=PAM:accounting acct=root exe="/bin/su" (hostname=?, addr=?, terminal=pts/0 res=success)'
type=USER_START msg=audit(1204212914.021:54): user pid=3683 uid=500 auid=500 subj=unconfined_u:unconfined_r:unconfined_t:s0 msg='op=PAM:session_open acct=root exe="/bin/su" (hostname=?, addr=?, terminal=pts/0 res=success)'
type=CRED_ACQ msg=audit(1204212914.021:55): user pid=3683 uid=500 auid=500 subj=unconfined_u:unconfined_r:unconfined_t:s0 msg='op=PAM:setcred acct=root exe="/bin/su" (hostname=?, addr=?, terminal=pts/0 res=success)'
type=USER_AVC msg=audit(1204212918.919:56): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2a004f5 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:object_r:unconfined_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212919.653:57): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2400102 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212933.406:58): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  { getattr } for request=X11:GetGeometry comm=compiz resid=2400105 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212933.418:59): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2400105 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212935.274:60): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2400109 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212936.913:61): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2a008b6 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:object_r:unconfined_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212936.980:62): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2400113 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212947.245:63): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2400117 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212949.205:64): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2a00b05 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:object_r:unconfined_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212949.968:65): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2400128 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212955.934:66): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2a00c0b restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:object_r:unconfined_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212956.019:67): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=240012e restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212956.170:68): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2a00c4d restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:object_r:unconfined_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212956.240:69): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2400133 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212956.272:70): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2a00c8f restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:object_r:unconfined_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212956.474:71): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2400138 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212956.502:72): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2a00cd1 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:object_r:unconfined_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212956.761:73): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=240013d restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212956.795:74): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2a00d13 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:object_r:unconfined_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212957.039:75): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2400142 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212957.062:76): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2a00d55 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:object_r:unconfined_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212957.270:77): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2400147 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212957.298:78): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2a00d97 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:object_r:unconfined_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212957.741:79): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=240014c restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212957.762:80): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2a00dd9 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:object_r:unconfined_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212958.095:81): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2400151 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212958.124:82): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2a00e1b restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:object_r:unconfined_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212958.352:83): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2400156 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212958.374:84): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2a00e5d restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:object_r:unconfined_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212958.578:85): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=240015b restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212958.868:86): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2a00e9f restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:object_r:unconfined_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212959.125:87): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2400160 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212959.147:88): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2a00ee1 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:object_r:unconfined_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212959.374:89): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2400165 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212960.065:90): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2a00f23 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=unconfined_u:object_r:unconfined_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212960.100:91): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=240016a restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'
type=USER_AVC msg=audit(1204212964.634:92): user pid=2907 uid=0 auid=4294967295 subj=system_u:system_r:xdm_xserver_t:s0-s0:c0.c1023 msg='avc:  denied  null for request=<unknown> comm=compiz resid=2400172 restype=PIXMAP scontext=unconfined_u:unconfined_r:unconfined_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=x_drawable : exe="/usr/bin/Xorg" (sauid=0, hostname=?, addr=?, terminal=?)'

--------------020802090602000600090701
Content-Type: text/plain;
 name="file:///tmp/nsmail-2.tmp"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="file:///tmp/nsmail-2.tmp"

--
fedora-selinux-list mailing list
fedora-selinux-list@redhat.com
https://www.redhat.com/mailman/listinfo/fedora-selinux-list

--------------020802090602000600090701
Content-Type: application/octet-stream;
 name="log.txt.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="log.txt.sig"

iEYEABECAAYFAkfHA8kACgkQrlYvE4MpobNMRgCdHGefHiMbuIrc44eIOGsuq9BVensAn3NI
cAxuJwkn+6o8KigBQeaWpEZ1
--------------020802090602000600090701
Content-Type: application/octet-stream;
 name="file:///tmp/nsmail-2.tmp.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="file:///tmp/nsmail-2.tmp.sig"

iEYEABECAAYFAkfHA8kACgkQrlYvE4MpobO0nwCcDkKEQH2JjpGA4ww3UdFHAMYiy2cAn1jQ
KAeOhHoP+XrLWXLvXn7spYIP
--------------020802090602000600090701--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
