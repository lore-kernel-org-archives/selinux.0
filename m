Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p36LDc01008666
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2011 17:13:38 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p36LDbd4008769
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2011 21:13:38 GMT
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p36LDbqa021600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2011 17:13:37 -0400
Received: from localhost.localdomain (redsox.boston.devel.redhat.com [10.16.60.53])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p36LDbi7031012
	for <selinux@tycho.nsa.gov>; Wed, 6 Apr 2011 17:13:37 -0400
Message-ID: <4D9CD781.6010601@redhat.com>
Date: Wed, 06 Apr 2011 17:13:37 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Resend: This patch causes the mount points created in load_policy
 to have a proper name
References: <4D9CD6DF.2020005@redhat.com>
In-Reply-To: <4D9CD6DF.2020005@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------060102050007020207090409"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060102050007020207090409
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 04/06/2011 05:10 PM, Daniel J Walsh wrote:
> "proc" and "selinuxfs"
> 



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk2c14AACgkQrlYvE4MpobMC7gCglauBYIKMfBRUcQPaMGKTzYZV
udUAn3X/rgUgJ55401IVwyCHC051bGQA
=47TI
-----END PGP SIGNATURE-----

--------------060102050007020207090409
Content-Type: text/plain;
 name="libselinux-mount.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="libselinux-mount.patch"

diff --git a/libselinux/src/load_policy.c b/libselinux/src/load_policy.c
index 36ce029..83d2143 100644
--- a/libselinux/src/load_policy.c
+++ b/libselinux/src/load_policy.c
@@ -329,7 +329,7 @@ int selinux_init_load_policy(int *enforce)
 	selinux_getenforcemode(&seconfig);
 
 	/* Check for an override of the mode via the kernel command line. */
-	rc = mount("none", "/proc", "proc", 0, 0);
+	rc = mount("proc", "/proc", "proc", 0, 0);
 	cfg = fopen("/proc/cmdline", "r");
 	if (cfg) {
 		char *tmp;
@@ -369,7 +369,7 @@ int selinux_init_load_policy(int *enforce)
 	 * Check for the existence of SELinux via selinuxfs, and 
 	 * mount it if present for use in the calls below.  
 	 */
-	if (mount("none", SELINUXMNT, "selinuxfs", 0, 0) < 0 && errno != EBUSY) {
+	if (mount("selinuxfs", SELINUXMNT, "selinuxfs", 0, 0) < 0 && errno != EBUSY) {
 		if (errno == ENODEV) {
 			/*
 			 * SELinux was disabled in the kernel, either

--------------060102050007020207090409
Content-Type: application/pgp-signature;
 name="libselinux-mount.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="libselinux-mount.patch.sig"

iEYEABECAAYFAk2c14AACgkQrlYvE4MpobOZsQCfX+hWeC599nMi1DQOWMtvKC1mj8AAoNC2
5t91MpjJL58JwG27SecZm5h/
--------------060102050007020207090409--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
