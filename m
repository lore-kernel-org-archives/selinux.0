Message-ID: <436A8156.5090003@cornell.edu>
Date: Thu, 03 Nov 2005 16:29:58 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Jonathan Kim <jkim@TrustedCS.com>, SELinux@tycho.nsa.gov,
   Chad Hanson <chanson@TrustedCS.com>
Subject: [ SEMANAGE] Resync seuser parser
References: <36282A1733C57546BE392885C0618592D975CA@chaos.tcs.tcs-sec.com>	 <1131048615.23420.142.camel@moss-spartans.epoch.ncsc.mil>	 <1131050021.23420.153.camel@moss-spartans.epoch.ncsc.mil> <1131050864.23420.165.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1131050864.23420.165.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------070407070601030105000503"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------070407070601030105000503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Must keep the parsers in sync (or at least, the semanage parser should 
supercede the other one). Patch attached.

This is now perfectly valid on my machine (see below).
Loaded correctly, modified correcly, written back out in the same order, 
and straightened out into something sane.

test_user:root
                phantom:

        phantom:s0

__default__

        :user_u root:   root       :


s0


Test output
-----
There are 4 seusers before the transaction.

Now testing list...
Name: root, Seuser: root, MLS: s0
Name: __default__, Seuser: user_u, MLS: (null)
Name: phantom, Seuser: phantom, MLS: s0
Name: test_user, Seuser: root, MLS: (null)

Now testing iterate...
Name: root, Seuser: root, MLS: s0
Name: __default__, Seuser: user_u, MLS: (null)
Name: phantom, Seuser: phantom, MLS: s0
Name: test_user, Seuser: root, MLS: (null)

In-Transaction pre-commit iterate (should show modifications)..
Name: root, Seuser: root, MLS: s0
Name: __default__, Seuser: user_u, MLS: (null)
Name: phantom, Seuser: phantom, MLS: s0
Name: test_user, Seuser: root, MLS: s0:c5,c6-s2:c1,c3,c5

There are 4 seusers after the transaction

Now testing list
Name: root, Seuser: root, MLS: s0
Name: __default__, Seuser: user_u, MLS: (null)
Name: phantom, Seuser: phantom, MLS: s0
Name: test_user, Seuser: root, MLS: s0:c5,c6-s2:c1,c3,c5

Now testing iterate...
Name: root, Seuser: root, MLS: s0
Name: __default__, Seuser: user_u, MLS: (null)
Name: phantom, Seuser: phantom, MLS: s0
Name: test_user, Seuser: root, MLS: s0:c5,c6-s2:c1,c3,c5

--------------070407070601030105000503
Content-Type: text/x-patch;
 name="libsemanage.seuser_resync.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.seuser_resync.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/seusers_file.c new/libsemanage/src/seusers_file.c
--- old/libsemanage/src/seusers_file.c	2005-11-03 12:48:03.000000000 -0500
+++ new/libsemanage/src/seusers_file.c	2005-11-03 16:21:49.000000000 -0500
@@ -81,8 +81,8 @@ static int seuser_parse(
 	if (is_selinux_mls_enabled()) {
 		if (parse_skip_space(handle, info) < 0)
 			goto err;
-		if (parse_assert_ch(handle, info, ':') < 0)
-			goto err;
+		if (parse_optional_ch(info, ':') == STATUS_NODATA)
+			goto out;
 		if (parse_skip_space(handle, info) < 0)
 			goto err;
 
@@ -95,7 +95,8 @@ static int seuser_parse(
 		free(str);
 		str = NULL;
 	} 
-
+	
+	out:
 	return STATUS_SUCCESS;
 
 	last:

--------------070407070601030105000503--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
