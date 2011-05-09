Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p49KkjLE009045
	for <selinux@tycho.nsa.gov>; Mon, 9 May 2011 16:46:48 -0400
Received: from fep08-svc.tim.it (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id p49KkiCN018975
	for <selinux@tycho.nsa.gov>; Mon, 9 May 2011 20:46:45 GMT
Subject: [PATCH v2]: setfiles should provide an option to avoid abortion on
 a missing file
From: Guido Trentalancia <guido@trentalancia.com>
To: SELinux <selinux@tycho.nsa.gov>
Cc: Steve Lawrence <slawrence@tresys.com>
Date: Mon, 09 May 2011 22:46:39 +0200
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1304974002.2521.75.camel@vortex>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

RE-SUBMISSION (originally submitted on Sun, 20 Feb 2011 11:43:13 +0100)

This patch must be applied after applying the following patches:

- [PATCH 1/2 v2]: clean-up setfiles source code and document two options
- [PATCH 2/2 v2]: improve the manual page for setfiles

---

I believe setfiles should provide an option that allows it to continue
on failure when a file is missing (i.e. do not "abort on errors during
the file tree walk").

This would be very useful in the presence of temporary files that come
and go and such option should be used by all Reference Policy relabeling
targets.

Otherwise, while making any relabeling target in the Reference Policy,
we might end up with an annoying relabel failure due to some stupid
missing temporary file:

/sbin/setfiles reset /var/lock/subsys/wpa_supplicant context
system_u:object_r:xdm_lock_t:s0->system_u:object_r:var_lock_t:s0
/sbin/setfiles get context
on /var/cache/ccache/Fl_Native_.tmp.tesla.lan.6091.ii failed: 'No such
file or directory'
make: *** [restorelabels] Error 1

In the example above, the failure was due to a temporary file created
(and then removed) by a compilation process that was running on the
system during the relabeling process.

It's a very minor issue, but I believe it's quite useful...

Thanks to the good design the code is already there, it just needs to be
used. In fact, there is a flag named "abort_on_error" in setfiles and
this is set by default to TRUE and unfortunately is not (yet) tunable
from the command line.

The Makefile for the Reference Policy should eventually make use of the
new option to be implemented in all relabel targets (relabel,
checklabels, restorelabels).

In any case, the anomalous condition will be still reported (if
reporting is enabled).

The patch for setfiles that I propose is attached below (it adds a new
option "Q" which stays for quiet). I have also documented the "-p"
option in the SYNOPSIS section of the manual page (I had forgotten to do
that in a previously submitted patch and this patch should be applied
after applying those, as otherwise it won't apply cleanly).

diff -pruN selinux-policycoreutils-setfiles-clean-up-and-man-page/policycoreutils/setfiles/setfiles.8 selinux-policycoreutils-setfiles-do-not-abort/policycoreutils/setfiles/setfiles.8
--- selinux-policycoreutils-setfiles-clean-up-and-man-page/policycoreutils/setfiles/setfiles.8	2011-05-09 22:41:14.917246771 +0200
+++ selinux-policycoreutils-setfiles-do-not-abort/policycoreutils/setfiles/setfiles.8	2011-05-09 22:40:24.546029994 +0200
@@ -4,7 +4,7 @@ setfiles \- set file SELinux security co
 
 .SH "SYNOPSIS"
 .B setfiles
-.I [\-c policy] [\-d] [\-l] [\-n] [\-e directory] [\-o filename] [\-q] [\-f filename] [\-s] [\-v] [\-vv] [\-W] [\-F] spec_file pathname...
+.I [\-c policy] [\-d] [\-l] [\-n] [\-e directory] [\-o filename] [\-q] [\-Q] [\-f filename] [\-s] [\-p] [\-v] [\-vv] [\-W] [\-F] spec_file pathname...
 .SH "DESCRIPTION"
 This manual page describes the
 .BR setfiles
@@ -34,6 +34,9 @@ don't change any file labels.
 .TP 
 .B \-q
 suppress non-error output.
+.TP
+.B \-Q
+do not abort on errors during the file tree walk.
 .TP 
 .B \-r rootpath
 use an alternate root path.
diff -pruN selinux-policycoreutils-setfiles-clean-up-and-man-page/policycoreutils/setfiles/setfiles.c selinux-policycoreutils-setfiles-do-not-abort/policycoreutils/setfiles/setfiles.c
--- selinux-policycoreutils-setfiles-clean-up-and-man-page/policycoreutils/setfiles/setfiles.c	2011-05-09 22:41:11.890115871 +0200
+++ selinux-policycoreutils-setfiles-do-not-abort/policycoreutils/setfiles/setfiles.c	2011-05-09 22:40:24.547030054 +0200
@@ -47,10 +47,10 @@ void usage(const char *const name)
 			name);
 	} else {
 		fprintf(stderr,
-			"usage:  %s [-dnpqvW] [-o filename] [-r alt_root_path] spec_file pathname...\n"
+			"usage:  %s [-dnpqvQW] [-o filename] [-r alt_root_path] spec_file pathname...\n"
 			"usage:  %s -c policyfile spec_file\n"
-			"usage:  %s -f filename [-dnpqvW] [-o filename] spec_file\n"
-			"usage:  %s -s [-dnpqvW] [-o filename] spec_file\n", name, name,
+			"usage:  %s -f filename [-dnpqvQW] [-o filename] spec_file\n"
+			"usage:  %s -s [-dnpqvQW] [-o filename] spec_file\n", name, name,
 			name, name);
 	}
 	exit(1);
@@ -283,7 +283,7 @@ int main(int argc, char **argv)
 	exclude_non_seclabel_mounts();
 
 	/* Process any options. */
-	while ((opt = getopt(argc, argv, "c:de:f:lnpqrsvo:FRW0")) > 0) {
+	while ((opt = getopt(argc, argv, "c:de:f:lnpqrsvo:FQRW0")) > 0) {
 		switch (opt) {
 		case 'c':
 			{
@@ -358,6 +358,9 @@ int main(int argc, char **argv)
 			}
 			__fsetlocking(r_opts.outfile, FSETLOCKING_BYCALLER);
 			break;
+		case 'Q':
+			r_opts.abort_on_error = 0;
+			break;
 		case 'q':
 			r_opts.quiet = 1;
 			break;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
