Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBDIS68L003511
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2010 13:28:06 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id oBDIS4CJ006315
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2010 18:28:05 GMT
Message-ID: <4D0665B1.2040005@redhat.com>
Date: Mon, 13 Dec 2010 13:28:01 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "'Chad Sellers'" <csellers@tresys.com>, SELinux <selinux@tycho.nsa.gov>
Subject: I think it is time to turn off default user handling in libselinux
Content-Type: multipart/mixed;
 boundary="------------010809030204010109040509"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010809030204010109040509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch will turn this handling off.  Meaning you will not end up
with some bizarro context and fail to login if the login program can not
figure how to log you in.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0GZbEACgkQrlYvE4MpobOF7QCgsD1XYuNC6B5MyIezCZvN9mYL
UX4AoOe9GsP3bhuvMBPea9LXeV/7tCPS
=B9Pk
-----END PGP SIGNATURE-----

--------------010809030204010109040509
Content-Type: text/plain;
 name="libselinux-defaultuser.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libselinux-defaultuser.patch"

diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
index a50fca8..37d80f2 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -286,7 +286,6 @@ static int get_failsafe_context(const char *user, security_context_t * newcon)
 	if (buf[plen - 1] == '\n')
 		buf[plen - 1] = 0;
 
-      retry:
 	nlen = strlen(user) + 1 + plen + 1;
 	*newcon = malloc(nlen);
 	if (!(*newcon))
@@ -306,10 +305,6 @@ static int get_failsafe_context(const char *user, security_context_t * newcon)
 	if (security_check_context(*newcon) && errno != ENOENT) {
 		free(*newcon);
 		*newcon = 0;
-		if (strcmp(user, SELINUX_DEFAULTUSER)) {
-			user = SELINUX_DEFAULTUSER;
-			goto retry;
-		}
 		return -1;
 	}
 
@@ -418,13 +413,8 @@ int get_ordered_context_list(const char *user,
 
 	/* Determine the set of reachable contexts for the user. */
 	rc = security_compute_user(fromcon, user, &reachable);
-	if (rc < 0) {
-		/* Retry with the default SELinux user identity. */
-		user = SELINUX_DEFAULTUSER;
-		rc = security_compute_user(fromcon, user, &reachable);
-		if (rc < 0)
-			goto failsafe;
-	}
+	if (rc < 0)
+		goto failsafe;
 	nreach = 0;
 	for (ptr = reachable; *ptr; ptr++)
 		nreach++;

--------------010809030204010109040509
Content-Type: application/pgp-signature;
 name="libselinux-defaultuser.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libselinux-defaultuser.patch.sig"

iEYEABECAAYFAk0GZbEACgkQrlYvE4MpobNJKACdFKpaGufjxhSnTaZVYNrbbTAqrmIAn24P
TaTPU3hWh2JPZhTsosWrYw6P
--------------010809030204010109040509--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
