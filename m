Date: Wed, 25 Nov 2009 21:27:27 +0100
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: SELinux@tycho.nsa.gov
Subject: MCS read only cats implemented
Message-ID: <20091125202727.GD1649@myhost.felk.cvut.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Epv4kl9IRBfg3rk"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--4Epv4kl9IRBfg3rk
Content-Type: multipart/mixed; boundary="J5MfuwkIyy7RmF4Q"
Content-Disposition: inline


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Michal Svoboda wrote:
> Okay then I will implement this and see how it works.

So I implemented the modification. I am sending the patch for review and
also in case anyone else is interested in the feature. The patch is
against debian lenny's policy source files version 2:0.0.20080702-16,
which slightly differ from what's in refpolicy git master now, but there
should be no problem with porting the modification.

Just to summarize, what the modification does is that you now can use
a range of low and high MCS cats on filesystem objects. Now, if the
user's process dominates the high cat of the file, he's given full
access (as far as TE permits), if he dominates the low cat, he's
constrained to read-only operation (even if TE permits writing), and if
he does not dominate neither low nor high, he's denied access (as per
normal MCS behavior). If the file has low cat equal to high, the system
works as in the unmodified MCS.

Example:

files on 'server' in /data/svn/repo are given MCS level s0:c4-s0:c1,c4
(ie. c4 is the read only cat, and c1,c4 is read-write)

user has been given c4 (read-only access) via semanage:

$ svn checkout svn+ssh://user@server/data/svn/repo
A    repo/boo.txt
Checked out revision 5.
$ cd repo
$ ls
boo.txt
$ cat >> boo.txt
hello
^D
$ svn ci -m ello
Sending        boo.txt
Transmitting file data .svn: Commit failed (details follow):
svn: Can't open file '/data/svn/repo/db/txn-current-lock': Permission denied

user has been given c1,c4 (full access):

$ svn ci -m ello
Sending        boo.txt
Transmitting file data .
Committed revision 6.
$ svn update
At revision 6.

revoked c1,c4 from user (no access):

$ svn update
svn: Can't open file '/data/svn/repo/format': Permission denied


--J5MfuwkIyy7RmF4Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="duallevel.patch"
Content-Transfer-Encoding: quoted-printable

--- selinux-policy-src-original/policy/mcs	2009-05-14 08:06:49.000000000 +0=
200
+++ selinux-policy-src/policy/mcs	2009-11-25 20:52:15.404177100 +0100
@@ -58,10 +58,11 @@
 #
=20
 #
-# MCS policy for the file classes
+# Dual-level MCS policy for the file classes
 #
 # Constrain file access so that the high range of the process dominates
-# the high range of the file.  We use the high range of the process so
+# the low range of the file for read-only operations, and high range of
+# the file for modifications.  We use the high range of the process so
 # that processes can always simply run at s0.
 #
 # Note that getattr on files is always permitted.
@@ -72,19 +73,23 @@
 mlsconstrain file { write setattr append unlink link rename }
 	(( h1 dom h2 ) and ((l1 domby l2) or (t2 =3D=3D mcstrustedobject)));
=20
-mlsconstrain dir { create getattr setattr read write link unlink rename se=
arch add_name remove_name reparent rmdir lock ioctl }
+mlsconstrain dir { create setattr write link unlink rename add_name remove=
_name reparent rmdir lock ioctl }
 	(( h1 dom h2 ) or ( t2 =3D=3D domain ) or ( t1 =3D=3D mlsfileread ));
=20
+mlsconstrain dir { getattr read search }
+	(( h1 dom l2 ) or ( t2 =3D=3D domain ) or ( t1 =3D=3D mlsfileread ));
+
 # New filesystem object labels must be dominated by the relabeling subject
-# clearance, also the objects are single-level.
+# clearance.
 mlsconstrain file { create relabelto }
-	(( l2 eq h2 ) and ( h1 dom h2 ) and
+	(( l2 domby h2 ) and ( h1 dom h2 ) and
 	((l1 domby l2) or (t2 =3D=3D mcstrustedobject)));
=20
 # At this time we do not restrict "ps" type operations via MCS.  This
-# will probably change in future.
+# will probably change in future. We use l2 instead of h2 to distinguish
+# read and write operations.
 mlsconstrain file { read }
-	(( h1 dom h2 ) or ( t2 =3D=3D domain ) or ( t1 =3D=3D mlsfileread ));
+	(( h1 dom l2 ) or ( t2 =3D=3D domain ) or ( t1 =3D=3D mlsfileread ));
=20
 # new file labels must be dominated by the relabeling subject clearance
 mlsconstrain { dir lnk_file chr_file blk_file sock_file fifo_file } { rela=
belfrom }
@@ -92,7 +97,7 @@
=20
 # not mandatory at this time - can write down
 mlsconstrain { dir lnk_file chr_file blk_file sock_file fifo_file } { crea=
te relabelto }
-	(( h1 dom h2 ) and ( l2 eq h2 ));
+	(( h1 dom h2 ) and ( l2 domby h2 ));
=20
 mlsconstrain process { transition dyntransition }
 	(( ( h1 dom h2 ) and ((l1 domby l2) or (t1 =3D=3D mcssetlow)) ) or ( t1 =
=3D=3D mcssetcats ));

--J5MfuwkIyy7RmF4Q--

--4Epv4kl9IRBfg3rk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAksNky8ACgkQg/fU9pp1uX5DCQCgrsUUKDomVTBvkko/VQI8Gfa3
yC8AoIS8W8YgaF9Rka6GuN4+OwIPr9Nu
=rydV
-----END PGP SIGNATURE-----

--4Epv4kl9IRBfg3rk--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
