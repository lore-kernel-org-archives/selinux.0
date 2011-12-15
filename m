Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id pBFFduj1028296
	for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2011 10:39:56 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id pBFFdttO000748
	for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2011 15:39:55 GMT
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id pBFFdsE6008582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2011 10:39:54 -0500
Received: from [10.16.62.208] (dhcp-10-16-62-208.boston.devel.redhat.com [10.16.62.208])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id pBFFdsjT017633
	for <selinux@tycho.nsa.gov>; Thu, 15 Dec 2011 10:39:54 -0500
Message-ID: <4EEA14CA.6020906@redhat.com>
Date: Thu, 15 Dec 2011 10:39:54 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Libsemanage genhomedircon to allow fallback users with no level
Content-Type: multipart/mixed;
 boundary="------------080508000908090404060504"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080508000908090404060504
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

If you build a distribution without MLS turned on, libsemanage will
crash if given a user without a level.  This patch allows users
without levels to be passed in.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk7qFMoACgkQrlYvE4MpobNIhwCbB/baCifURS4ldfZYo4eplezu
GwQAn0zyfeS4po8AK7zhJTtTjfUWWrKq
=oOTr
-----END PGP SIGNATURE-----

--------------080508000908090404060504
Content-Type: text/plain;
 name="libsemanage-fallbackuser.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libsemanage-fallbackuser.patch"

diff --git a/libsemanage/src/genhomedircon.c b/libsemanage/src/genhomedircon.c
index 847d87e..d2646ae 100644
--- a/libsemanage/src/genhomedircon.c
+++ b/libsemanage/src/genhomedircon.c
@@ -660,9 +717,12 @@ static int set_fallback_user(genhomedircon_settings_t *s, const char *user,
 {
 	char *fallback_user = strdup(user);
 	char *fallback_user_prefix = strdup(prefix);
-	char *fallback_user_level = strdup(level);
+	char *fallback_user_level = NULL;
+	if (level) 
+		fallback_user_level = strdup(level);
 
-	if (fallback_user == NULL || fallback_user_prefix == NULL || fallback_user_level == NULL) {
+	if (fallback_user == NULL || fallback_user_prefix == NULL ||
+	    (fallback_user_level == NULL && level != NULL)) {
 		free(fallback_user);
 		free(fallback_user_prefix);
 		free(fallback_user_level);

--------------080508000908090404060504--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
