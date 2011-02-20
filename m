Subject: [PATCH]: setfiles should provide an option to avoid abortion on a
 missing file
From: Guido Trentalancia <guido@trentalancia.com>
To: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Cc: refpolicy@oss1.tresys.com
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 20 Feb 2011 11:43:13 +0100
Message-ID: <1298198593.2989.69.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello !

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

Thanks for your time !

diff -pru policycoreutils-clean-setfiles/setfiles/setfiles.8 policycoreutils-do-not-abort/setfiles/setfiles.8
--- policycoreutils-clean-setfiles/setfiles/setfiles.8	2011-02-20 11:11:25.156517094 +0100
+++ policycoreutils-do-not-abort/setfiles/setfiles.8	2011-02-20 11:12:19.370005988 +0100
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
diff -pru policycoreutils-clean-setfiles/setfiles/setfiles.c policycoreutils-do-not-abort/setfiles/setfiles.c
--- policycoreutils-clean-setfiles/setfiles/setfiles.c	2011-02-20 11:11:22.321019765 +0100
+++ policycoreutils-do-not-abort/setfiles/setfiles.c	2011-02-20 11:06:51.885588624 +0100
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
