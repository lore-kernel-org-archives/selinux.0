Message-Id: <200404162308.i3GN8Bf5000929@turing-police.cc.vt.edu>
To: SELinux@tycho.nsa.gov
Subject: Oddness with password aging and related..
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1478204908P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 16 Apr 2004 19:08:11 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1478204908P
Content-Type: text/plain; charset=us-ascii

Running a Fedora Core 2-test2 patched up with the -devel tree as of
this morning (in particular, Fedora rpm policy-1.11.2-8), in enforcing mode.

Did the folliowing:

1) useradd a test user.
2) passwd testuser   and assign a password
3) chage -d 0 testuser     to force a password change at login.

On attempting to login at a virtual console or ssh session, it prompts for the
userid/password, and then:
% ssh -l testuser orange

testuser@orange's password: 
Authentication successful.
You are required to change your password immediately (root enforced)
Your password has expired, the session cannot proceed.

Apr 16 17:59:42 orange kernel: audit(1082152782.796:0): avc:  denied  { getattr } for  pid=879 exe=/bin/login path=/usr/lib/cracklib_dict.pwd dev=dm-3 ino=250121 scontext=system_u:system_r:local_login_t tcontext=system_u:object_r:crack_db_t tclass=file

GDM does something similar:
Apr 16 18:00:13 orange kernel: audit(1082152813.521:0): avc:  denied  { getattr } for  pid=918 exe=/usr/bin/gdm-binary path=/usr/lib/cracklib_dict.pwd dev=dm-3 ino=250121 scontext=system_u:system_r:xdm_t tcontext=system_u:object_r:crack_db_t tclass=file

relevant(?) lines in /etc/pam.d/system-auth:
password    requisite     /lib/security/$ISA/pam_cracklib.so retry=3 type=
password    sufficient    /lib/security/$ISA/pam_unix.so nullok use_authtok md5 shadow remember=5
password    required      /lib/security/$ISA/pam_deny.so

Any suggestions/patches? (even a "Fedora is behind, it's fixed in the version
on the nsa site" would be fine. ;)


--==_Exmh_1478204908P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAgGdbcC3lWbTT17ARAkBIAKDwNC7mVZe6EY7gc+DaUjcMtvHNgACg1tSc
dNtwrC7zXT9mEXlnmGbxQIs=
=0bWB
-----END PGP SIGNATURE-----

--==_Exmh_1478204908P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
