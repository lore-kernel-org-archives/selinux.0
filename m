Message-ID: <4E207475.1040909@redhat.com>
Date: Fri, 15 Jul 2011 13:10:13 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Matthew Ife <deleriux@airattack-central.com>,
        SELinux <selinux@tycho.nsa.gov>
Subject: Re: As we move to systemd, we are loosing some functionality from
 init scripts.
References: <4E1CB8A5.2010707@redhat.com>  <1310577633.19434.6.camel@home.localdomain>  <4E1DD9A7.80007@redhat.com> <1310647915.28361.2.camel@moss-pluto>
In-Reply-To: <1310647915.28361.2.camel@moss-pluto>
Content-Type: multipart/mixed;
 boundary="------------090103030106070301080109"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090103030106070301080109
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I guess we can add something like the attached, and then implement
systemd checks on these.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk4gdHEACgkQrlYvE4MpobOg3gCfU23GCTQuktksXCu6j2mGdnh0
TRUAnRRo34V3/OIxe+ikn7mFrI3sLy38
=gJiT
-----END PGP SIGNATURE-----

--------------090103030106070301080109
Content-Type: text/x-patch;
 name="service.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="service.diff"

diff --git a/policy/flask/access_vectors b/policy/flask/access_vectors
index bf24160..468e0fd 100644
--- a/policy/flask/access_vectors
+++ b/policy/flask/access_vectors
@@ -862,3 +862,12 @@ inherits database
 	implement
 	execute
 }
+
+class service
+{
+	start
+	stop
+	status
+	reload
+	kill
+}
diff --git a/policy/flask/security_classes b/policy/flask/security_classes
index 14a4799..067ecfc 100644
--- a/policy/flask/security_classes
+++ b/policy/flask/security_classes
@@ -131,4 +131,8 @@ class db_view			# userspace
 class db_sequence		# userspace
 class db_language		# userspace
 
+# systemd services 
+class service 
+
+
 # FLASK

--------------090103030106070301080109
Content-Type: application/pgp-signature;
 name="service.diff.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="service.diff.sig"

iEYEABECAAYFAk4gdHUACgkQrlYvE4MpobMX1wCgzYpRBxqxCycrKpcshErMWgWqmGMAoIfE
Pg9JIZvs6TACwMpMOYP/dkEO
--------------090103030106070301080109--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
