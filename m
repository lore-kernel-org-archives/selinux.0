Message-ID: <46FBF096.2030404@redhat.com>
Date: Thu, 27 Sep 2007 14:04:06 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: libselinux segfault, if file_contexts file does not exist
Content-Type: multipart/mixed;
 boundary="------------030502010304020501000503"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030502010304020501000503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


https://bugzilla.redhat.com/show_bug.cgi?id=308851
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFG+/CWrlYvE4MpobMRAi7+AKCzBc906xJDXvve+tvemuBY8tFe4QCgk78j
CZzAvmikWfld43QZSJbdIRA=
=D2ho
-----END PGP SIGNATURE-----

--------------030502010304020501000503
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/matchpathcon.c libselinux-2.0.35/src/matchpathcon.c
--- nsalibselinux/src/matchpathcon.c	2007-09-18 16:27:25.000000000 -0400
+++ libselinux-2.0.35/src/matchpathcon.c	2007-09-27 13:50:55.000000000 -0400
@@ -305,8 +306,10 @@
 
 void matchpathcon_fini(void)
 {
-	selabel_close(hnd);
-	hnd = NULL;
+	if (hnd) {
+		selabel_close(hnd);
+		hnd = NULL;
+	}
 }
 
 int matchpathcon(const char *name, mode_t mode, security_context_t * con)

--------------030502010304020501000503
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iD8DBQBG+/CWrlYvE4MpobMRAr07AKDAGTia0mne9cQuaMSn+6iklr9ejwCfaX2DJKKE1SVN
1cDmZ4NRiNCD7Tg=
--------------030502010304020501000503--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
