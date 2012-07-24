Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6ODRSFp016108
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2012 09:27:29 -0400
Message-ID: <1343136442.1114.23.camel@vortex>
Subject: [PATCH]: setfiles/restorecon minor improvements [was Re: [PATCH]:
 allow setfiles to continue on errors (new option)]
From: Guido Trentalancia <guido@trentalancia.com>
To: Pat McClory <pmcclory@tresys.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Date: Tue, 24 Jul 2012 15:27:22 +0200
In-Reply-To: <500D6E14.4030907@tresys.com>
References: <1342876779.7185.0.camel@vortex> <500D6E14.4030907@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello again Pat.

With a little bit more time available, I managed to come to a more
meaningful, possibly better patch for setfiles/restorecon that:

- improves the manual page for both setfiles and restorecon (formatting
including alphabetical re-ordering of options, undocumented options,
references and a few cosmetic changes);
- de-hardcodes a couple of constants in the source files and makes a
dynamic use of them to create the manual pages after the compilation and
prior to the installation: more specifically the constants are the
number of errors for the setfiles' validation process abort condition
and the sensitivity of the progress meter for both programs (uses
external programs grep and awk);
- improves the usage message for both programs and introduces a -h
(aliased with currently existing -?) option where not already available;
- print out the usage message for restorecon when it is called without
arguments;
- white-space/tab conversion to get proper indentation towards the end
of the main source file.

If you and/or others like any part of the patch or just believe it might
be useful, feel free to apply it. Also, if you believe anything is in
error, please let me know (as in further inline review, for example) and
I'll try to amend as required.

Signed-off-by: Guido Trentalancia <guido@trentalancia.com>

---
 policycoreutils/setfiles/Makefile     |   18 +++++--
 policycoreutils/setfiles/restorecon.8 |   73 +++++++++++++++++++-----------
 policycoreutils/setfiles/setfiles.8   |   81 ++++++++++++++++++++++------------
 policycoreutils/setfiles/setfiles.c   |   34 +++++++++-----
 4 files changed, 137 insertions(+), 69 deletions(-)

diff -pruN selinux/policycoreutils/setfiles/Makefile selinux-20072012-setfiles-minor-fixes/policycoreutils/setfiles/Makefile
--- selinux/policycoreutils/setfiles/Makefile	2012-06-18 18:54:45.764500252 +0200
+++ selinux-20072012-setfiles-minor-fixes/policycoreutils/setfiles/Makefile	2012-07-24 12:11:51.656514665 +0200
@@ -5,6 +5,9 @@ MANDIR = $(PREFIX)/share/man
 LIBDIR ?= $(PREFIX)/lib
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 
+PROGRESS_STEP=$(shell grep "^\#define STAR_COUNT" restore.h | awk -S '{ print $$3 }')
+ABORT_ON_ERRORS=$(shell grep "^\#define ABORT_ON_ERRORS" setfiles.c | awk -S '{ print $$3 }')
+
 CFLAGS = -g -Werror -Wall -W
 override CFLAGS += -I$(PREFIX)/include
 LDLIBS = -lselinux -lsepol -L$(LIBDIR)
@@ -14,25 +17,32 @@ ifeq ($(AUDITH), /usr/include/libaudit.h
 	LDLIBS += -laudit
 endif
 
-all: setfiles restorecon
+all: setfiles restorecon man
 
 setfiles:  setfiles.o restore.o
 
 restorecon: setfiles
 	ln -sf setfiles restorecon
 
+man:
+	@cp -af setfiles.8 setfiles.8.man
+	@cp -af restorecon.8 restorecon.8.man
+	@sed -i "s/STAR_COUNT/$(PROGRESS_STEP)/g" setfiles.8.man restorecon.8.man
+	@sed -i "s/ABORT_ON_ERRORS/$(ABORT_ON_ERRORS)/g" setfiles.8.man
+ 
 install: all
 	[ -d $(MANDIR)/man8 ] || mkdir -p $(MANDIR)/man8
 	-mkdir -p $(SBINDIR)
 	install -m 755 setfiles $(SBINDIR)
 	(cd $(SBINDIR) && ln -sf setfiles restorecon)
-	install -m 644 setfiles.8 restorecon.8 $(MANDIR)/man8
+	install -m 644 setfiles.8.man $(MANDIR)/man8/setfiles.8
+	install -m 644 restorecon.8.man $(MANDIR)/man8/restorecon.8
 
 clean:
-	rm -f setfiles restorecon *.o 
+	rm -f setfiles restorecon *.o setfiles.8.man restorecon.8.man
 
 indent:
 	../../scripts/Lindent $(wildcard *.[ch])
 
 relabel: install
-	/sbin/restorecon $(SBINDIR)/setfiles
+	$(SBINDIR)/restorecon $(SBINDIR)/setfiles
diff -pruN selinux/policycoreutils/setfiles/restorecon.8 selinux-20072012-setfiles-minor-fixes/policycoreutils/setfiles/restorecon.8
--- selinux/policycoreutils/setfiles/restorecon.8	2012-06-18 18:54:45.764500252 +0200
+++ selinux-20072012-setfiles-minor-fixes/policycoreutils/setfiles/restorecon.8	2012-07-24 14:38:51.235431700 +0200
@@ -4,10 +4,10 @@ restorecon \- restore file(s) default SE
 
 .SH "SYNOPSIS"
 .B restorecon
-.I [\-o outfilename ] [\-R] [\-n] [\-p] [\-v] [\-e directory ] pathname...
+.I [\-o outfilename] [\-R] [\-n] [\-p] [\-v] [\-e directory] pathname...
 .P
 .B restorecon
-.I \-f infilename [\-o outfilename ] [\-e directory ] [\-R] [\-n] [\-p] [\-v] [\-F]
+.I \-f infilename [\-o outfilename] [\-e directory] [\-R] [\-n] [\-p] [\-v] [\-F]
 
 .SH "DESCRIPTION"
 This manual page describes the
@@ -15,49 +15,70 @@ This manual page describes the
 program.
 .P
 This program is primarily used to set the security context
-(extended attributes) on one or more files. 
+(extended attributes) on one or more files.
 .P
-It can be run at any time to correct errors, to add support for
-new policy, or with the \-n option it can just check whether the file
-contexts are all as you expect.
+It can also be run at any other time to correct inconsistent labels, to add
+support for newly-installed policy or, by using the \-n option, to passively
+check whether the file contexts are all set as specified by the active policy
+(default behavior) or by some other policy (see the \-c option).
 
 .SH "OPTIONS"
-.TP 
-.B \-i
-ignore files that do not exist
-.TP 
+.TP
+.B \-e directory
+exclude a directory (repeat the option to exclude more than one directory).
+.TP
 .B \-f infilename
-infilename contains a list of files to be processed by application. Use \- for stdin.
+infilename contains a list of files to be processed. Use \- for stdin.
+.TP
+.B \-F
+force reset of context to match file_context for customizable files, or the
+user section, if it has changed.
+.TP
+.B \-h, \-?
+display usage information and exit.
 .TP 
-.B \-e directory
-directory to exclude (repeat option for more than one directory.)
+.B \-i
+ignore files that do not exist.
 .TP 
-.B \-R \-r
-change files and directories file labels recursively
+.B \-R, \-r
+change files and directories file labels recursively (descend directories).
 .TP 
 .B \-n
-don't change any file labels.
+don't change any file labels (passive check).
 .TP 
 .B \-o outfilename
 save list of files with incorrect context in outfilename.
 .TP
 .B \-p
-show progress by printing * every 1000 files.
-.TP 
+show progress by printing * every STAR_COUNT files.
+.TP
+.B \-R, \-r
+change files and directories file labels recursively (descend directories).
+.TP
 .B \-v
-show changes in file labels.
+show changes in file labels, if type or role are going to be changed.
 .TP 
 .B \-vv
-show changes in file labels, if type, role, or user are changing.
-.TP 
-.B \-F
-Force reset of context to match file_context for customizable files, or the user section, if it has changed. 
+show changes in file labels, if type, role or user are going to be changed.
 .TP 
+.B \-0
+the separator for the input items is assumed to be the null character
+(instead of the white space).  The quotes and the backslash characters are
+also treated as normal characters that can form valid input.
+This option finally also disables the end of file string, which is treated  
+like any other argument.  Useful when input items might contain white space, 
+quote marks or backslashes.  The
+.B \-print0
+option of GNU  
+.B find  
+produces input suitable for this mode.
+.TP
 .SH "ARGUMENTS"
 .B pathname...
-The pathname for the file(s) to be relabeled. 
+The pathname for the file(s) to be relabeled.
 .SH NOTE
-restorecon does not follow symbolic links.
+restorecon does not follow symbolic links and by default it does not
+operate recursively on directories.
 
 .SH "AUTHOR"
 This man page was written by Dan Walsh <dwalsh@redhat.com>.
@@ -66,6 +87,6 @@ man page written by Russell Coker <russe
 The program was written by Dan Walsh <dwalsh@redhat.com>.
 
 .SH "SEE ALSO"
+.BR setfiles (8),
 .BR load_policy (8),
 .BR checkpolicy (8)
-.BR setfiles (8)
diff -pruN selinux/policycoreutils/setfiles/setfiles.8 selinux-20072012-setfiles-minor-fixes/policycoreutils/setfiles/setfiles.8
--- selinux/policycoreutils/setfiles/setfiles.8	2012-06-18 18:54:45.764500252 +0200
+++ selinux-20072012-setfiles-minor-fixes/policycoreutils/setfiles/setfiles.8	2012-07-24 14:40:47.821710368 +0200
@@ -1,22 +1,24 @@
 .TH "setfiles" "8" "2002031409" "" ""
 .SH "NAME"
-setfiles \- set file SELinux security contexts.
+setfiles \- set SELinux file security contexts.
 
 .SH "SYNOPSIS"
 .B setfiles
-.I [\-c policy ] [\-d] [\-l] [\-n] [\-e directory ] [\-o filename ] [\-q] [\-s] [\-v] [\-vv] [\-W] [\-F] spec_file pathname...
+.I [\-c policy] [\-d] [\-l] [\-n] [\-e directory] [\-o filename] [\-q] [\-s] [\-v] [\-vv] [\-W] [\-F] spec_file pathname...
 .SH "DESCRIPTION"
 This manual page describes the
 .BR setfiles
 program.
 .P
 This program is primarily used to initialize the security context
-database (extended attributes) on one or more filesystems.  This
-program is initially run as part of the SE Linux installation process.
+fields (extended attributes) on one or more filesystems (or parts of
+them).  Usually it is initially run as part of the SELinux installation
+process (a step commonly known as labeling).
 .P
-It can also be run at any time to correct errors, to add support for
-new policy, or with the \-n option it can just check whether the file
-contexts are all as you expect.
+It can also be run at any other time to correct inconsistent labels, to add
+support for newly-installed policy or, by using the \-n option, to passively 
+check whether the file contexts are all set as specified by the active policy 
+(default behavior) or by some other policy (see the \-c option).
 
 .SH "OPTIONS"
 .TP 
@@ -24,47 +26,66 @@ contexts are all as you expect.
 check the validity of the contexts against the specified binary policy.
 .TP
 .B \-d
-show what specification matched each file.
-.TP 
+show what specification matched each file (do not abort validation
+after ABORT_ON_ERRORS errors).
+.TP
+.B \-e directory
+directory to exclude (repeat option for more than one directory).
+.TP
+.B \-f
+take a list of files to be processed from an input file.
+.TP
+.B \-F
+force reset of context to match file_context for customizable files.
+.TP
+.B \-h, \-?
+display usage information and exit.
+.TP
+.B \-i
+ignore files that do not exist.
+.TP
 .B \-l
 log changes in file labels to syslog.
 .TP
 .B \-n
-don't change any file labels.
+don't change any file labels (passive check).
+.TP
+.B \-o filename
+save list of files with incorrect context in filename.
 .TP
 .B \-p
-show progress by printing * every 1000 files.
+show progress by printing * every STAR_COUNT files.
 .TP 
 .B \-q
 suppress non-error output.
 .TP 
 .B \-r rootpath
-use an alternate root path
-.TP 
-.B \-e directory
-directory to exclude (repeat option for more than one directory.)
-.TP 
-.B \-F
-Force reset of context to match file_context for customizable files
-.TP 
-.B \-o filename
-save list of files with incorrect context in filename.
+use an alternate root path.
 .TP 
 .B \-s
-take a list of files from standard input instead of using a pathname on the
-command line.
+take a list of files from standard input instead of using a pathname from the
+command line (equivalent to \-f \-).
 .TP
 .B \-v
-show changes in file labels, if type or role are changing.
+show changes in file labels, if type or role are going to be changed.
 .TP 
 .B \-vv
-show changes in file labels, if type, role, or user are changing.
+show changes in file labels, if type, role or user are going to be changed.
 .TP 
 .B \-W
 display warnings about entries that had no matching files.
 .TP 
 .B \-0
-Input items are terminated by a null character instead of by whitespace,  and the quotes and backslash are not special (every character is taken literally).  Disables the end of file string, which  is  treated  like  any other argument.  Useful when input items might contain white space, quote  marks,  or  backslashes.The  GNU  find  -print0  option produces input suitable for this mode.
+the separator for the input items is assumed to be the null character
+(instead of the white space).  The quotes and the backslash characters are
+also treated as normal characters that can form valid input.
+This option finally also disables the end of file string, which is treated
+like any other argument.  Useful when input items might contain white space,
+quote marks or backslashes.  The
+.B \-print0
+option of GNU
+.B find
+produces input suitable for this mode.
 
 .SH "ARGUMENTS"
 .B spec_file
@@ -87,8 +108,13 @@ displayed but the file is still labeled
 specification other than <<none>>.
 .TP 
 .B pathname...
-The pathname for the root directory of each file system to be relabeled. 
+The pathname for the root directory of each file system to be relabeled
+or a specific directory within a filesystem that should be recursively
+descended and relabeled or the pathname of a file that should be
+relabeled.
 Not used if the
+.B \-f
+or the
 .B \-s
 option is used.
 
@@ -97,5 +123,6 @@ This man page was written by Russell Cok
 The program was written by Stephen Smalley <sds@epoch.ncsc.mil>
 
 .SH "SEE ALSO"
+.BR restorecon (8),
 .BR load_policy (8),
 .BR checkpolicy (8)
diff -pruN selinux/policycoreutils/setfiles/setfiles.c selinux-20072012-setfiles-minor-fixes/policycoreutils/setfiles/setfiles.c
--- selinux/policycoreutils/setfiles/setfiles.c	2012-06-18 18:54:45.764500252 +0200
+++ selinux-20072012-setfiles-minor-fixes/policycoreutils/setfiles/setfiles.c	2012-07-24 14:25:56.638828743 +0200
@@ -25,7 +25,11 @@ static struct restore_opts r_opts;
 
 #define STAT_BLOCK_SIZE 1
 
-
+/* setfiles will abort its operation after reaching the
+ * following number of errors (e.g. invalid contexts),
+ * unless it is used in "debug" mode (-d option).
+ */
+#define ABORT_ON_ERRORS	10
 
 #define SETFILES "setfiles"
 #define RESTORECON "restorecon"
@@ -39,14 +43,16 @@ void usage(const char *const name)
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
-			"usage:  %s -c policyfile spec_file\n"
-			"usage:  %s -s [-dnpqvW] [-o filename ] spec_file\n", name, name,
-			name);
+			"usage:  %s [-dilnpqvFW] [-e excludedir] [-o filename] [-r alt_root_path] spec_file pathname...\n"
+			"usage:  %s [-dilnpqvFW] [-e excludedir] [-o filename] [-r alt_root_path] spec_file -f filename...\n"
+			"usage:  %s -s [-dilnpqvFW] [-o filename] spec_file\n"
+			"usage:  %s -c policyfile spec_file\n",
+			name, name, name, name);
 	}
 	exit(1);
 }
@@ -56,7 +62,7 @@ static int nerr = 0;
 void inc_err()
 {
 	nerr++;
-	if (nerr > 9 && !r_opts.debug) {
+	if (nerr > ABORT_ON_ERRORS - 1 && !r_opts.debug) {
 		fprintf(stderr, "Exiting after 10 errors.\n");
 		exit(1);
 	}
@@ -217,7 +223,7 @@ int main(int argc, char **argv)
 	exclude_non_seclabel_mounts();
 
 	/* Process any options. */
-	while ((opt = getopt(argc, argv, "c:de:f:ilnpqrsvo:FRW0")) > 0) {
+	while ((opt = getopt(argc, argv, "c:de:f:hilno:pqrsvFRW0")) > 0) {
 		switch (opt) {
 		case 'c':
 			{
@@ -266,6 +272,8 @@ int main(int argc, char **argv)
 			input_filename = optarg;
 			break;			
 		case 'd':
+			if (iamrestorecon)
+				usage(argv[0]);
 			r_opts.debug = 1;
 			break;
 		case 'i':
@@ -344,6 +352,7 @@ int main(int argc, char **argv)
 		case '0':
 			null_terminated = 1;
 			break;
+		case 'h':
 		case '?':
 			usage(argv[0]);
 		}
@@ -381,7 +390,8 @@ int main(int argc, char **argv)
 
 		altpath = argv[optind];
 		optind++;
-	}
+	} else if (argc == 1)
+		usage(argv[0]);
 
 	/* Load the file contexts configuration and check it. */
 	r_opts.selabel_opt_validate = (ctx_validate ? (char *)1 : NULL);
@@ -433,7 +443,7 @@ int main(int argc, char **argv)
 	if (r_opts.outfile)
 		fclose(r_opts.outfile);
 
-       if (r_opts.progress && r_opts.count >= STAR_COUNT)
-               printf("\n");
+	if (r_opts.progress && r_opts.count >= STAR_COUNT)
+		printf("\n");
 	exit(errors);
 }

On Mon, 2012-07-23 at 11:30 -0400, Pat McClory wrote:
> On 07/21/2012 09:19 AM, Guido Trentalancia wrote:
> > Add a command-line option to setfiles to disable program abortion
> > after 10 errors (e.g. invalid contexts).
> >
> > Signed-off-by: Guido Trentalancia<guido@trentalancia.com>
> >
> > ---
> >   policycoreutils/setfiles/restore.o  |binary
> >   policycoreutils/setfiles/restorecon |binary
> >   policycoreutils/setfiles/setfiles   |binary
> >   policycoreutils/setfiles/setfiles.8 |    3 +++
> >   policycoreutils/setfiles/setfiles.c |   11 +++++++----
> >   policycoreutils/setfiles/setfiles.o |binary
> >   6 files changed, 10 insertions(+), 4 deletions(-)
> >
> 
> probably don't want object files and executables appearing in the diff.
> 
> > diff -pruN selinux-20072012/policycoreutils/setfiles/setfiles.8 selinux-20072012-setfiles-continue-on-errors/policycoreutils/setfiles/setfiles.8
> > --- selinux-20072012/policycoreutils/setfiles/setfiles.8	2012-06-18 18:54:45.764500252 +0200
> > +++ selinux-20072012-setfiles-continue-on-errors/policycoreutils/setfiles/setfiles.8	2012-07-21 12:43:04.108000002 +0200
> > @@ -43,6 +43,9 @@ use an alternate root path
> >   .TP
> >   .B \-e directory
> >   directory to exclude (repeat option for more than one directory.)
> > +.TP
> > +.B \-C
> > +continue on errors (instead of aborting after 10 errors).
> >   .TP
> >   .B \-F
> >   Force reset of context to match file_context for customizable files
> > diff -pruN selinux-20072012/policycoreutils/setfiles/setfiles.c selinux-20072012-setfiles-continue-on-errors/policycoreutils/setfiles/setfiles.c
> > --- selinux-20072012/policycoreutils/setfiles/setfiles.c	2012-06-18 18:54:45.764500252 +0200
> > +++ selinux-20072012-setfiles-continue-on-errors/policycoreutils/setfiles/setfiles.c	2012-07-21 12:42:15.610999907 +0200
> > @@ -43,9 +43,9 @@ void usage(const char *const name)
> >   			name);
> >   	} else {
> >   		fprintf(stderr,
> > -			"usage:  %s [-dnpqvW] [-o filename] [-r alt_root_path ] spec_file pathname...\n"
> > +			"usage:  %s [-dnpqvCW] [-o filename] [-r alt_root_path ] spec_file pathname...\n"
> >   			"usage:  %s -c policyfile spec_file\n"
> > -			"usage:  %s -s [-dnpqvW] [-o filename ] spec_file\n", name, name,
> > +			"usage:  %s -s [-dnpqvCW] [-o filename ] spec_file\n", name, name,
> >   			name);
> >   	}
> >   	exit(1);
> > @@ -56,7 +56,7 @@ static int nerr = 0;
> >   void inc_err()
> >   {
> >   	nerr++;
> > -	if (nerr>  9&&  !r_opts.debug) {
> > +	if (nerr>  9&&  !r_opts.debug&&  r_opts.abort_on_error) {
> >   		fprintf(stderr, "Exiting after 10 errors.\n");
> >   		exit(1);
> >   	}
> > @@ -217,7 +217,7 @@ int main(int argc, char **argv)
> >   	exclude_non_seclabel_mounts();
> >
> >   	/* Process any options. */
> > -	while ((opt = getopt(argc, argv, "c:de:f:ilnpqrsvo:FRW0"))>  0) {
> > +	while ((opt = getopt(argc, argv, "c:de:f:ilnpqrsvo:CFRW0"))>  0) {
> 
> I think it's confusing that there are now two options that control 
> whether or not to exit after 10 errors.  I think the man page should be 
> updated to reflect that -d implies -C.
> 
> >   		switch (opt) {
> >   		case 'c':
> >   			{
> > @@ -274,6 +274,9 @@ int main(int argc, char **argv)
> >   		case 'l':
> >   			r_opts.logging = 1;
> >   			break;
> > +		case 'C':
> > +			r_opts.abort_on_error = 0;
> > +			break;
> 
> b/c -C is only an option for setfiles, I think there should be an
> 
> if (iamrestorecon)
>      usage(argv[0]);
> 
> block in this case (like there is for -c)
> 
> >   		case 'F':
> >   			r_opts.force = 1;
> >   			break;
> >
> >



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
