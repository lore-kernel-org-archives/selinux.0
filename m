Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6M5Vu6O014130
	for <selinux@tycho.nsa.gov>; Sun, 22 Jul 2012 01:31:56 -0400
Received: from [192.168.1.64] (151.76.19.83) by cp-out9.libero.it (8.5.133)
        id 4FD1B52307331E1E for selinux@tycho.nsa.gov; Sun, 22 Jul 2012 07:31:50 +0200
Message-ID: <1342935110.30310.4.camel@vortex>
Subject: [PATCH]: document the "-f" option in the setfiles' manual page
From: Guido Trentalancia <guido@trentalancia.com>
To: selinux@tycho.nsa.gov
Date: Sun, 22 Jul 2012 07:31:50 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Document the -f option (take a list of files to be processed
from an input file instead of a list of paths from the
command-line) in the setfiles' manual page.

Minor cosmetic improvements to the same manual page and to the
setfiles' usage message.

Whitespace/tab conversion at the end of the setfiles source.

Signed-off-by: Guido Trentalancia <guido@trentalancia.com>

---
 policycoreutils/setfiles/setfiles.8 |   12 +++++++++---
 policycoreutils/setfiles/setfiles.c |   12 +++++++-----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff -pruN selinux-20072012/policycoreutils/setfiles/setfiles.8 selinux-20072012-setfiles-man-page-input-file/policycoreutils/setfiles/setfiles.8
--- selinux-20072012/policycoreutils/setfiles/setfiles.8	2012-07-21 15:14:27.864183912 +0200
+++ selinux-20072012-setfiles-man-page-input-file/policycoreutils/setfiles/setfiles.8	2012-07-22 07:19:57.663245105 +0200
@@ -12,11 +12,12 @@ program.
 .P
 This program is primarily used to initialize the security context
 database (extended attributes) on one or more filesystems.  This
-program is initially run as part of the SE Linux installation process.
+program is initially run as part of the SELinux installation process.
 .P
 It can also be run at any time to correct errors, to add support for
 new policy, or with the \-n option it can just check whether the file
-contexts are all as you expect.
+contexts are all initialized as specified in the active policy's file
+contexts specification.
 
 .SH "OPTIONS"
 .TP 
@@ -49,10 +50,13 @@ Force reset of context to match file_con
 .TP 
 .B \-o filename
 save list of files with incorrect context in filename.
+.TP
+.B \-f
+take a list of files to be processed from an input file.
 .TP 
 .B \-s
 take a list of files from standard input instead of using a pathname on the
-command line.
+command line (equivalent to \-f \-).
 .TP
 .B \-v
 show changes in file labels, if type or role are changing.
@@ -90,6 +94,8 @@ specification other than <<none>>.
 The pathname for the root directory of each file system to be relabeled. 
 Not used if the
 .B \-s
+or the
+.B \-f
 option is used.
 
 .SH "AUTHOR"
diff -pruN selinux-20072012/policycoreutils/setfiles/setfiles.c selinux-20072012-setfiles-man-page-input-file/policycoreutils/setfiles/setfiles.c
--- selinux-20072012/policycoreutils/setfiles/setfiles.c	2012-07-21 15:14:27.864183912 +0200
+++ selinux-20072012-setfiles-man-page-input-file/policycoreutils/setfiles/setfiles.c	2012-07-22 07:10:26.419375320 +0200
@@ -39,14 +39,16 @@ void usage(const char *const name)
 {
 	if (iamrestorecon) {
 		fprintf(stderr,
-			"usage:  %s [-iFnprRv0] [-e excludedir ] [-o filename ] [-f filename | pathname... ]\n",
-			name);
+			"usage:  %s [-iFnprRv0] [-e excludedir] [-o filename] pathname...\n"
+			"usage:  %s [-iFnprRv0] [-e excludedir] [-o filename] -f filename\n",
+			name, name);
 	} else {
 		fprintf(stderr,
-			"usage:  %s [-dnpqvW] [-o filename] [-r alt_root_path ] spec_file pathname...\n"
+			"usage:  %s [-dnpqvW] [-o filename] [-r alt_root_path] spec_file pathname...\n"
+			"usage:  %s [-dnpqvW] [-o filename] [-r alt_root_path] spec_file -f filename\n"
 			"usage:  %s -c policyfile spec_file\n"
-			"usage:  %s -s [-dnpqvW] [-o filename ] spec_file\n", name, name,
-			name);
+			"usage:  %s -s [-dnpqvW] [-o filename] spec_file\n",
+			name, name, name, name);
 	}
 	exit(1);
 }
@@ -433,7 +435,7 @@ int main(int argc, char **argv)
 	if (r_opts.outfile)
 		fclose(r_opts.outfile);
 
-       if (r_opts.progress && r_opts.count >= STAR_COUNT)
-               printf("\n");
+	if (r_opts.progress && r_opts.count >= STAR_COUNT)
+		printf("\n");
 	exit(errors);
 }



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
