Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4QGQZRb027082
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2004 12:26:35 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4QGQYAR026884
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2004 16:26:34 GMT
Received: from turing-police.cc.vt.edu (turing-police.cc.vt.edu [128.173.14.107])
        by jazzband.ncsc.mil  with ESMTP id i4QGQXHn026877 for <selinux@tycho.nsa.gov>; Wed, 26 May 2004 16:26:34 GMT
Message-Id: <200405261626.i4QGQ1GQ001031@turing-police.cc.vt.edu>
To: russell@coker.com.au
Cc: fedora-selinux-list@redhat.com, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: mysql issues... 
In-Reply-To: Your message of "Wed, 26 May 2004 14:17:40 +1000."
             <200405261417.40958.russell@coker.com.au>
From: Valdis.Kletnieks@vt.edu
References: <200405250215.i4P2FFAe027848@turing-police.cc.vt.edu>
            <200405261417.40958.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-1555143134P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Wed, 26 May 2004 12:26:01 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-1555143134P
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-15587842340"

This is a multipart MIME message.

--==_Exmh_-15587842340
Content-Type: text/plain; charset=us-ascii

On Wed, 26 May 2004 14:17:40 +1000, Russell Coker said:

> How should we determine who gets mysql client access?  Should we have a 
> tunable determining whether we allow userdomain?

That might be a good solution.. 

> Why have mysql_cmd_t instead of just allowing user_t directly?  What is the 
> benefit in having a domain for client access?

Thinko on my part - I invented the cmd_t because I'd been fighting various
issues for about 14 hours at that point, and didn't parse through mysqld.te,
apache.te, and mysqld.fc sufficiently to realize that the var_run_t was
identical in semantics (somehow, I was convince that var_run_t included
something I didn't want in cmd_t, but that was wrong).

How do people feel about the attached patch to add a tunable?

--==_Exmh_-15587842340
Content-Type: text/plain ; name="mysql.selinux.patch"; charset=us-ascii
Content-Description: mysql.selinux.patch
Content-Disposition: attachment; filename="mysql.selinux.patch"

--- macros/user_macros.te.dist	2004-05-11 11:03:38.000000000 -0400
+++ macros/user_macros.te	2004-05-26 12:22:18.852047888 -0400
@@ -242,6 +242,14 @@
 r_dir_file($1_t, mnt_t)
 ')
 
+ifdef(`user_mysql',`
+#
+# Allow users to access the mysql socket
+#
+allow $1_t mysqld_var_run_t:dir search;
+allow $1_t mysqld_var_run_t:sock_file write;
+')
+
 #
 # Rules used to associate a homedir as a mountpoint
 #
--- tunable.te.dist	2004-05-11 11:03:38.000000000 -0400
+++ tunable.te	2004-05-26 12:19:33.221383912 -0400
@@ -99,3 +99,6 @@
 
 # Allow user to rw usb devices
 define(`user_rw_usb')
+
+# Allow users to access mysql
+define(`user_mysql')

--==_Exmh_-15587842340--


--==_Exmh_-1555143134P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFAtMUZcC3lWbTT17ARAk2qAJ9/n2VOMtjGzebszdD03nlkXUSE+gCfSvyk
/Mrnt0BKZoBxa+IL5P2nEYw=
=ckki
-----END PGP SIGNATURE-----

--==_Exmh_-1555143134P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
