Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6LDJh1h012690
	for <selinux@tycho.nsa.gov>; Sat, 21 Jul 2012 09:19:43 -0400
Received: from [192.168.1.64] (151.76.19.83) by cp-out9.libero.it (8.5.133)
        id 4FD1B523071DCDC3 for selinux@tycho.nsa.gov; Sat, 21 Jul 2012 15:19:39 +0200
Message-ID: <1342876779.7185.0.camel@vortex>
Subject: [PATCH]: allow setfiles to continue on errors (new option)
From: Guido Trentalancia <guido@trentalancia.com>
To: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Sat, 21 Jul 2012 15:19:39 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Add a command-line option to setfiles to disable program abortion
after 10 errors (e.g. invalid contexts).

Signed-off-by: Guido Trentalancia <guido@trentalancia.com>

---
 policycoreutils/setfiles/restore.o  |binary
 policycoreutils/setfiles/restorecon |binary
 policycoreutils/setfiles/setfiles   |binary
 policycoreutils/setfiles/setfiles.8 |    3 +++
 policycoreutils/setfiles/setfiles.c |   11 +++++++----
 policycoreutils/setfiles/setfiles.o |binary
 6 files changed, 10 insertions(+), 4 deletions(-)

diff -pruN selinux-20072012/policycoreutils/setfiles/setfiles.8 selinux-20072012-setfiles-continue-on-errors/policycoreutils/setfiles/setfiles.8
--- selinux-20072012/policycoreutils/setfiles/setfiles.8	2012-06-18 18:54:45.764500252 +0200
+++ selinux-20072012-setfiles-continue-on-errors/policycoreutils/setfiles/setfiles.8	2012-07-21 12:43:04.108000002 +0200
@@ -43,6 +43,9 @@ use an alternate root path
 .TP 
 .B \-e directory
 directory to exclude (repeat option for more than one directory.)
+.TP
+.B \-C
+continue on errors (instead of aborting after 10 errors).
 .TP 
 .B \-F
 Force reset of context to match file_context for customizable files
diff -pruN selinux-20072012/policycoreutils/setfiles/setfiles.c selinux-20072012-setfiles-continue-on-errors/policycoreutils/setfiles/setfiles.c
--- selinux-20072012/policycoreutils/setfiles/setfiles.c	2012-06-18 18:54:45.764500252 +0200
+++ selinux-20072012-setfiles-continue-on-errors/policycoreutils/setfiles/setfiles.c	2012-07-21 12:42:15.610999907 +0200
@@ -43,9 +43,9 @@ void usage(const char *const name)
 			name);
 	} else {
 		fprintf(stderr,
-			"usage:  %s [-dnpqvW] [-o filename] [-r alt_root_path ] spec_file pathname...\n"
+			"usage:  %s [-dnpqvCW] [-o filename] [-r alt_root_path ] spec_file pathname...\n"
 			"usage:  %s -c policyfile spec_file\n"
-			"usage:  %s -s [-dnpqvW] [-o filename ] spec_file\n", name, name,
+			"usage:  %s -s [-dnpqvCW] [-o filename ] spec_file\n", name, name,
 			name);
 	}
 	exit(1);
@@ -56,7 +56,7 @@ static int nerr = 0;
 void inc_err()
 {
 	nerr++;
-	if (nerr > 9 && !r_opts.debug) {
+	if (nerr > 9 && !r_opts.debug && r_opts.abort_on_error) {
 		fprintf(stderr, "Exiting after 10 errors.\n");
 		exit(1);
 	}
@@ -217,7 +217,7 @@ int main(int argc, char **argv)
 	exclude_non_seclabel_mounts();
 
 	/* Process any options. */
-	while ((opt = getopt(argc, argv, "c:de:f:ilnpqrsvo:FRW0")) > 0) {
+	while ((opt = getopt(argc, argv, "c:de:f:ilnpqrsvo:CFRW0")) > 0) {
 		switch (opt) {
 		case 'c':
 			{
@@ -274,6 +274,9 @@ int main(int argc, char **argv)
 		case 'l':
 			r_opts.logging = 1;
 			break;
+		case 'C':
+			r_opts.abort_on_error = 0;
+			break;
 		case 'F':
 			r_opts.force = 1;
 			break;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
