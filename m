Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o6RJ06U8007208
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2010 15:00:06 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o6RJ0902007310
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2010 19:00:10 GMT
Received: from int-mx05.intmail.prod.int.phx2.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o6RJ03vt029068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2010 15:00:04 -0400
Received: from localhost.localdomain (vpn-9-212.rdu.redhat.com [10.11.9.212])
	by int-mx05.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o6RJ02oq000335
	for <selinux@tycho.nsa.gov>; Tue, 27 Jul 2010 15:00:03 -0400
Message-ID: <4C4F2CB2.5050804@redhat.com>
Date: Tue, 27 Jul 2010 15:00:02 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: I want to remove DEFAULTUSER handling from get_context_list
Content-Type: multipart/mixed;
 boundary="------------080805050007070906080201"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080805050007070906080201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The problem we are seeing, is people running sshd as unconfined_t, is
failing to log users in as unconfined_t.  The reason is the
get_context_list function is looking for all transitions from
unconfined_t.  Since unconfined_t can execute all domains, the kernel
returns ERANGE error.  Then get_context_list fails over to DEFAULTUSER
(user_u), which is some ancient code used in RHEL4.  Since we introduced
seusers, this code does not make much sense.  unconfined_u is not
allowed to transition to user_u so the code fails.  If we remove this
code it will fail over to FAILSAFE_CONTEXT which I set up as
unconfined_r:unconfined_t

And everything works.


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxPLLIACgkQrlYvE4MpobPyEwCff4shFQiYpROAfwtlKbg3I0EP
RH0An3QIg1lQUXcEhjcTjp1WvMRFmFUi
=+s4z
-----END PGP SIGNATURE-----

--------------080805050007070906080201
Content-Type: text/plain;
 name="libselinux-DEFAULTUSER.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libselinux-DEFAULTUSER.patch"

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

--------------080805050007070906080201
Content-Type: application/pgp-signature;
 name="libselinux-DEFAULTUSER.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libselinux-DEFAULTUSER.patch.sig"

iEYEABECAAYFAkxPLLIACgkQrlYvE4MpobO0PwCgyQTEftSOHtaBVeu8Ihp9Z6pysJMAn0xs
kArJKk2vndWiEd2uR7K6DY4j
--------------080805050007070906080201--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
