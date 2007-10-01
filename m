Message-ID: <470120CD.5050009@redhat.com>
Date: Mon, 01 Oct 2007 12:31:09 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Todd C. Miller" <tmiller@tresys.com>
CC: Joshua Brindle <jbrindle@tresys.com>, Stephen Smalley <sds@tycho.nsa.gov>,
        selinux@tycho.nsa.gov
Subject: Re: [patch 0/4] libsemanage: genhomedircon regressions
References: <200709281804.l8SI4Cuj031486@cadmus.columbia.tresys.com>
In-Reply-To: <200709281804.l8SI4Cuj031486@cadmus.columbia.tresys.com>
Content-Type: multipart/mixed;
 boundary="------------030307070104030905090001"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030307070104030905090001
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch makes sure /root gets labeled even if it is using the default
context.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFHASDNrlYvE4MpobMRAuAAAJ0edHnaWRQ/RuE8llb+RQ9Zh43j6ACg2qXK
FsPmAB6fb4Ct9ytLVhxYijk=
=S8km
-----END PGP SIGNATURE-----

--------------030307070104030905090001
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude -N -u -r nsalibsemanage/src/genhomedircon.c libsemanage-2.0.11/src/genhomedircon.c
--- nsalibsemanage/src/genhomedircon.c	2007-10-01 09:54:35.000000000 -0400
+++ libsemanage-2.0.11/src/genhomedircon.c	2007-10-01 12:24:39.000000000 -0400
@@ -668,12 +668,11 @@
 
 	for (i = 0; i < nseusers; i++) {
 		seuname = semanage_seuser_get_sename(seuser_list[i]);
+		name = semanage_seuser_get_name(seuser_list[i]);
 
-		if (strcmp(seuname, s->fallback_user) == 0)
+		if (strcmp(name,"root") && strcmp(seuname, s->fallback_user) == 0)
 			continue;
 
-		name = semanage_seuser_get_name(seuser_list[i]);
-
 		if (strcmp(name, DEFAULT_LOGIN) == 0)
 			continue;
 

--------------030307070104030905090001
Content-Type: application/octet-stream;
 name="diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="diff.sig"

iD8DBQBHASDNrlYvE4MpobMRAvoTAJ9TOi/OV6+OTlMwyLRWlEtVHYJyrwCggndP+4f4AoZ6
LlwgSewkVUduOh8=
--------------030307070104030905090001--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
