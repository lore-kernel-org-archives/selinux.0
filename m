Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oAHLRb0M015613
	for <selinux@tycho.nsa.gov>; Wed, 17 Nov 2010 16:27:38 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id oAHLRaVc009015
	for <selinux@tycho.nsa.gov>; Wed, 17 Nov 2010 21:27:37 GMT
Message-ID: <4CE448C6.3020305@redhat.com>
Date: Wed, 17 Nov 2010 16:27:34 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux <selinux@tycho.nsa.gov>
Subject: setools-cmdline patch
Content-Type: multipart/mixed;
 boundary="------------050106070700090609020902"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050106070700090609020902
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch cleans up some missing commandline options from seinfo,
sediff and seaudit-report

sediff actually had options listed in its getopt that did not exist.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkzkSMYACgkQrlYvE4MpobNEbwCfXB6Fkgc9rXd4rY4v5NTIWFdo
Df4AoIIw4upJNkWxso0zQ/oGBIwd4W2Q
=VEGb
-----END PGP SIGNATURE-----

--------------050106070700090609020902
Content-Type: text/plain;
 name="setools-cmdline.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="setools-cmdline.patch"

diff -up setools-3.3.7/man/seinfo.1.cmdline setools-3.3.7/man/seinfo.1
--- setools-3.3.7/man/seinfo.1.cmdline	2010-05-03 12:39:02.000000000 -0400
+++ setools-3.3.7/man/seinfo.1	2010-11-17 16:23:36.000000000 -0500
@@ -76,6 +76,10 @@ There is no expanded information for thi
 .IP "--nodecon[=ADDR]"
 Print a list of node contexts or, if ADDR is provided, print the statement for the node with address ADDR.
 There is no expanded information for this component.
+.IP "--polcap"
+Print policy capabilities.
+.IP "--permissive"
+Print permissive types.
 .IP "--portcon[=PORT]"
 Print a list of port contexts or, if PORT is provided, print the statement for port PORT.
 There is no expanded information for this component.
@@ -93,7 +97,7 @@ These details include the types assigned
 This option is not available for all component types; see the description of each component for the details this option will provide.
 .IP "--stats"
 Print policy statistics including policy type and version information and counts of all components and rules.
-.IP "-l"
+.IP "-l, --line-breaks"
 Print line breaks when displaying constraint statements.
 .IP "-h, --help"
 Print help information and exit.
diff -up setools-3.3.7/seaudit/seaudit-report.c.cmdline setools-3.3.7/seaudit/seaudit-report.c
--- setools-3.3.7/seaudit/seaudit-report.c.cmdline	2010-11-17 16:09:48.000000000 -0500
+++ setools-3.3.7/seaudit/seaudit-report.c	2010-11-17 16:11:06.000000000 -0500
@@ -100,7 +100,7 @@ static void seaudit_report_info_usage(co
 	printf("  -s, --stdin              read log data from standard input\n");
 	printf("  -m, --malformed          include malformed log messages\n");
 	printf("  -o FILE, --output=FILE   output to FILE\n");
-	printf("  --config=FILE            read configuration from FILE\n");
+	printf("  -c FILE, --config=FILE   read configuration from FILE\n");
 	printf("  --html                   set output format to HTML\n");
 	printf("  --stylesheet=FILE        HTML style sheet for formatting HTML report\n");
 	printf("                           (ignored if --html is not given)\n");
diff -up setools-3.3.7/sediff/sediff.c.cmdline setools-3.3.7/sediff/sediff.c
--- setools-3.3.7/sediff/sediff.c.cmdline	2007-08-02 17:16:33.000000000 -0400
+++ setools-3.3.7/sediff/sediff.c	2010-11-17 16:20:01.000000000 -0500
@@ -420,7 +420,7 @@ int main(int argc, char **argv)
 	poldiff_t *diff = NULL;
 	size_t total = 0;
 
-	while ((optc = getopt_long(argc, argv, "ctarubANDLMCRqhV", longopts, NULL)) != -1) {
+	while ((optc = getopt_long(argc, argv, "ctarubAqhV", longopts, NULL)) != -1) {
 		switch (optc) {
 		case 0:
 			break;

--------------050106070700090609020902
Content-Type: application/pgp-signature;
 name="setools-cmdline.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="setools-cmdline.patch.sig"

iEYEABECAAYFAkzkSMYACgkQrlYvE4MpobP9qQCeIK0QeWO+jssl+DfJRutHBWGASQYAn0wI
suCu2nmi+jwPH5YjqrBcOu4+
--------------050106070700090609020902--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
