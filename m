Message-ID: <46F7DAA9.2040408@redhat.com>
Date: Mon, 24 Sep 2007 11:41:29 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Old libselinux bug.  We are leaking a file descriptor.
Content-Type: multipart/mixed;
 boundary="------------090904010609070603030701"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090904010609070603030701
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This bug causes dbus to leak file descriptors when autostarting confined
applications.

Should be able to remove

	ifdef(`hide_broken_symptoms', `
		dontaudit $2 $1_dbusd_t:netlink_selinux_socket { read write };
	');

- From policy.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG99qorlYvE4MpobMRAhGxAKDFGatnSzGeXfzRq2feuXR/NPlr3wCgx7CV
iam5zavHRuXTKFGXP9QJbdI=
=cILD
-----END PGP SIGNATURE-----

--------------090904010609070603030701
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/avc_internal.c libselinux-2.0.34/src/avc_internal.c
--- nsalibselinux/src/avc_internal.c	2007-07-16 14:20:46.000000000 -0400
+++ libselinux-2.0.34/src/avc_internal.c	2007-09-24 11:37:47.000000000 -0400
@@ -61,7 +61,8 @@
 		rc = fd;
 		goto out;
 	}
-
+	
+	fcntl(fd, F_SETFD, FD_CLOEXEC);
 	if (!blocking && fcntl(fd, F_SETFL, O_NONBLOCK)) {
 		close(fd);
 		rc = -1;

--------------090904010609070603030701
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iD8DBQBG99qorlYvE4MpobMRAgJOAJ9G43MOFNWV4HJhRUSA0jLElEvhyQCgkA9CdoGW1gKO
NyMS2Q9FbTgg3nk=
--------------090904010609070603030701--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
