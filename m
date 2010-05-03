Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o43IERld004734
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2010 14:14:27 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o43IFWf2022292
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2010 18:15:32 GMT
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o43IEIs5030664
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2010 14:14:19 -0400
Received: from localhost.localdomain (vpn-10-159.rdu.redhat.com [10.11.10.159])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o43HjUva031787
	for <selinux@tycho.nsa.gov>; Mon, 3 May 2010 13:45:31 -0400
Message-ID: <4BDF0BBA.1040307@redhat.com>
Date: Mon, 03 May 2010 13:45:30 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Minor fixup of checkmodule man page.
Content-Type: multipart/mixed;
 boundary="------------010508010500000902080104"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010508010500000902080104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Quality Engineering is going through all commands on the system looking
for mismatches between man page/usage and actual code.

It found that checkmodule had a -d option that is unused and undocumented -h
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkvfC7oACgkQrlYvE4MpobNPrACg0uP02CWYPs9YcdU87jts9YqT
hMAAn2QA1UWZpGLvvU4yxStmhUU1Kg1+
=topF
-----END PGP SIGNATURE-----

--------------010508010500000902080104
Content-Type: text/plain;
 name="checkpolicy-getopt.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="checkpolicy-getopt.patch"

diff --git a/checkpolicy/checkmodule.8 b/checkpolicy/checkmodule.8
index 550b32b..a25f25c 100644
--- a/checkpolicy/checkmodule.8
+++ b/checkpolicy/checkmodule.8
@@ -3,7 +3,7 @@
 checkmodule \- SELinux policy module compiler
 .SH SYNOPSIS
 .B checkmodule
-.I "[-b] [-m] [-M] [-V] [-o output_file] [input_file]"
+.I "[-h] [-b] [-m] [-M] [-U handle_unknown ] [-V] [-o output_file] [input_file]"
 .SH "DESCRIPTION"
 This manual page describes the
 .BR checkmodule
@@ -25,6 +25,9 @@ the module package into the module store and load the resulting policy.
 Read an existing binary policy module file rather than a source policy
 module file.  This option is a development/debugging aid.
 .TP
+.B \-h
+Print usage.
+.TP
 .B \-m
 Generate a non-base policy module.
 .TP
diff --git a/checkpolicy/checkmodule.c b/checkpolicy/checkmodule.c
index ad5a3d4..47603e0 100644
--- a/checkpolicy/checkmodule.c
+++ b/checkpolicy/checkmodule.c
@@ -139,13 +139,14 @@ static int write_binary_policy(policydb_t * p, char *file, char *progname)
 
 static void usage(char *progname)
 {
-	printf("usage:  %s [-V] [-b] [-U handle_unknown] [-m] [-M] [-o FILE] [INPUT]\n", progname);
+	printf("usage:  %s [-h] [-V] [-b] [-U handle_unknown] [-m] [-M] [-o FILE] [INPUT]\n", progname);
 	printf("Build base and policy modules.\n");
 	printf("Options:\n");
 	printf("  INPUT      build module from INPUT (else read from \"%s\")\n",
 	       txtfile);
 	printf("  -V         show policy versions created by this program\n");
 	printf("  -b         treat input as a binary policy file\n");
+	printf("  -h         print usage\n");
 	printf("  -U OPTION  How to handle unknown classes and permissions\n");
 	printf("               deny: Deny unknown kernel checks\n");
 	printf("               reject: Reject loading of policy with unknowns\n");
@@ -169,7 +170,6 @@ int main(int argc, char **argv)
 		{"binary", no_argument, NULL, 'b'},
 		{"version", no_argument, NULL, 'V'},
 		{"handle-unknown", optional_argument, NULL, 'U'},
-		{"debug", no_argument, NULL, 'd'},
 		{"mls", no_argument, NULL, 'M'},
 		{NULL, 0, NULL, 0}
 	};

--------------010508010500000902080104
Content-Type: application/pgp-signature;
 name="checkpolicy-getopt.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="checkpolicy-getopt.patch.sig"

iEYEABECAAYFAkvfC7oACgkQrlYvE4MpobNXdgCgo1AzaxdHcWEZyjJgjgPnfC+/H0wAoJVw
U07hV9fqjVywcqs26Th5rxdT
--------------010508010500000902080104--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
