Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0KGtVIi005986
	for <selinux@tycho.nsa.gov>; Thu, 20 Jan 2005 11:55:31 -0500 (EST)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0KGrTbQ001931
	for <selinux@tycho.nsa.gov>; Thu, 20 Jan 2005 16:53:29 GMT
Message-Id: <200501201655.j0KGtNan001364@turing-police.cc.vt.edu>
To: SELinux <selinux@tycho.nsa.gov>, fedora-selinux-list@redhat.com
Subject: quota files oddity...
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1106240122_12559P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 20 Jan 2005 11:55:23 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1106240122_12559P
Content-Type: text/plain; charset=us-ascii

Running FC from the devel tree as of last night, and a 2.6.10-mm1-RT kernel.

OK.. So I go and put user and group quotas on all the R/W file systems (it's
a lot quicker to run 'repquota /full.fs' than to run 'du' and similar when you're
sitting at 99%.. ;)

Then quite some time later I run setfiles because I was pretty sure that I
had a lot of files that hadn't been installed by rpm and thus didn't have
the right contexts on them, and I get:

/usr/sbin/setfiles:  relabeling /aquota.user from system_u:object_r:quota_db_t to system_u:object_r:default_t
/aquota.user: Operation not permitted
/usr/sbin/setfiles:  unable to relabel /aquota.user to system_u:object_r:default_t
/usr/sbin/setfiles:  relabeling /aquota.group from system_u:object_r:quota_db_t to system_u:object_r:default_t
/aquota.group: Operation not permitted
/usr/sbin/setfiles:  unable to relabel /aquota.group to system_u:object_r:default_t

/usr/sbin/setfiles:  relabeling /boot/aquota.user from system_u:object_r:quota_db_t to system_u:object_r:boot_t
/boot/aquota.user: Operation not permitted
/usr/sbin/setfiles:  unable to relabel /boot/aquota.user to system_u:object_r:boot_t
/usr/sbin/setfiles:  relabeling /boot/aquota.group from system_u:object_r:quota_db_t to system_u:object_r:boot_t
/boot/aquota.group: Operation not permitted
/usr/sbin/setfiles:  unable to relabel /boot/aquota.group to system_u:object_r:boot_t

/usr/sbin/setfiles:  relabeling /usr/aquota.user from root:object_r:quota_db_t to system_u:object_r:usr_t
/usr/aquota.user: Operation not permitted
/usr/sbin/setfiles:  unable to relabel /usr/aquota.user to system_u:object_r:usr_t
/usr/sbin/setfiles:  relabeling /usr/aquota.group from system_u:object_r:quota_db_t to system_u:object_r:usr_t
/usr/aquota.group: Operation not permitted
/usr/sbin/setfiles:  unable to relabel /usr/aquota.group to system_u:object_r:usr_t

Is there any way to express:

$MOUNTPOINT/aquota\.(user|group)$ -- system_u:object_r:quota_db_t

in the .fc files, or do we need to settle for '/.*/aquota\.(user|group)' as
the regexp?

(And no, I have no idea how I ended up with 'root:object_r:quota_db_t' on
/usr/aquota.user, but the other ones were system_u....)



--==_Exmh_1106240122_12559P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB7+J6cC3lWbTT17ARAooQAKDM6kGj9sEtZw9xHJMK2T7A/JeBqACdEoWH
E5FE0JJts3B3Ry4bEPuiLLo=
=qV5r
-----END PGP SIGNATURE-----

--==_Exmh_1106240122_12559P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
