Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1MJDFNe026672
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 14:13:15 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1MJD829009449
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 19:13:08 GMT
Message-ID: <47BF1EBD.6050603@redhat.com>
Date: Fri, 22 Feb 2008 14:13:01 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Todd Miller <Tmiller@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Not that anyone would ever run in permissive mode but...
Content-Type: multipart/mixed;
 boundary="------------030803070300020008070400"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030803070300020008070400
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch is needed for sudo.

Also added setkeycreatecon, although this will not work the way the code
is currently.

Pam activity should probably be happening after setkeycreatecon and
setexeccon

But I am not sure how pam_keyinit should work here any ways.

Currently you loose access to your keying material when you su or sudo.

These things will not be labeled corectly as currently used.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAke/HrwACgkQrlYvE4MpobND4QCg4L9uaKuKhMxQwlhCBUY5icwT
wCkAoIzPvgXScs286cbO2g8RZG3WVWtN
=5+0w
-----END PGP SIGNATURE-----

--------------030803070300020008070400
Content-Type: text/plain;
 name="sudo-1.6.9p13-selinux.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sudo-1.6.9p13-selinux.patch"

diff -up sudo-1.6.9p13/selinux.c.selinux sudo-1.6.9p13/selinux.c
--- sudo-1.6.9p13/selinux.c.selinux	2008-02-20 12:00:48.000000000 -0500
+++ sudo-1.6.9p13/selinux.c	2008-02-22 13:34:08.000000000 -0500
@@ -314,9 +314,19 @@ selinux_exec(char *role, char *type, cha
 
     if (setexeccon(new_context)) {
 	warn("unable to set exec context to %s", new_context);
-	goto error;
+	if (security_getenforce() == 1) {
+		goto error;
+	}
     }
 
+    if (setkeycreatecon(new_context)) {
+	    warn("Error!  Unable to set key creation context to %s",
+		 new_context);
+	    if (security_getenforce() == 1) {
+		    goto error;
+	    }
+    } 
+
 #ifdef WITH_AUDIT
     if (send_audit_message(1, old_context, new_context, user_ttypath)) 
 	goto error;

--------------030803070300020008070400
Content-Type: application/octet-stream;
 name="sudo-1.6.9p13-selinux.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sudo-1.6.9p13-selinux.patch.sig"

iEYEABECAAYFAke/HrwACgkQrlYvE4MpobNUlACfeG5ppnTfHPAJyqnzA9kdLiT3rawAnjLF
vxpwDEHz3/tlFm2emRg+qMqj
--------------030803070300020008070400--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
