Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l12I3B7u000632
	for <selinux@tycho.nsa.gov>; Fri, 2 Feb 2007 13:03:11 -0500
Received: from mx.meyering.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l12I4EJx007105
	for <selinux@tycho.nsa.gov>; Fri, 2 Feb 2007 18:04:15 GMT
From: Jim Meyering <jim@meyering.net>
To: bug-coreutils@gnu.org
Cc: selinux@tycho.nsa.gov
Subject: selinux branch: new program: runcon
Date: Fri, 02 Feb 2007 19:03:39 +0100
Message-ID: <8764akxwqs.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Here's the delta:

---
 AUTHORS            |    1 +
 ChangeLog-selinux  |   11 +++
 README             |   10 +-
 man/Makefile.am    |    4 +-
 man/runcon.x       |   14 +++
 po/ChangeLog       |    4 +
 po/POTFILES.in     |    1 +
 src/Makefile.am    |    4 +-
 src/runcon.c       |  249 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/help-version |    3 +-
 10 files changed, 293 insertions(+), 8 deletions(-)
 create mode 100644 man/runcon.x
 create mode 100644 src/runcon.c

diff --git a/AUTHORS b/AUTHORS
index 11e02c5..9a8b2c9 100644
--- a/AUTHORS
+++ b/AUTHORS
@@ -61,6 +61,7 @@ pwd: Jim Meyering
 readlink: Dmitry V. Levin
 rm: Paul Rubin, David MacKenzie, Richard Stallman, Jim Meyering
 rmdir: David MacKenzie
+runcon: Russell Coker
 seq: Ulrich Drepper
 sha1sum: Ulrich Drepper, Scott Miller, David Madore
 sha224sum: Ulrich Drepper, Scott Miller, David Madore
diff --git a/ChangeLog-selinux b/ChangeLog-selinux
index 7a27296..63df994 100644
--- a/ChangeLog-selinux
+++ b/ChangeLog-selinux
@@ -1,3 +1,14 @@
+2007-02-02  Jim Meyering  <jim@meyering.net>
+
+	* src/runcon.c: New program.
+	* src/Makefile.am (bin_PROGRAMS): Add runcon.
+	(runcon_LDADD): Define.
+	* README: Add runcon to the list of programs.
+	* AUTHORS: Add this: runcon: Russell Coker
+	* tests/help-version: Add runcon as an exception.
+	* man/Makefile.am (dist_man_MANS): Add runcon.1.
+	(runcon.1): New dependency.
+
 2007-01-31  Jim Meyering  <jim@meyering.net>

 	mkfifo, mknod: Accept new "-Z, --context=C" option.
diff --git a/README b/README
index ad22de5..ef04add 100644
--- a/README
+++ b/README
@@ -10,11 +10,11 @@ The programs that can be built with this package are:
   [ base64 basename cat chcon chgrp chmod chown chroot cksum comm cp
   csplit cut date dd df dir dircolors dirname du echo env expand expr
   factor false fmt fold ginstall groups head hostid hostname id join
-  kill link ln logname ls md5sum mkdir mkfifo mknod mv nice nl nohup od
-  paste pathchk pinky pr printenv printf ptx pwd readlink rm rmdir seq
-  sha1sum sha224sum sha256sum sha384sum sha512sum shred shuf sleep sort
-  split stat stty su sum sync tac tail tee test touch tr true tsort tty
-  uname unexpand uniq unlink uptime users vdir wc who whoami yes
+  kill link ln logname ls md5sum mkdir mkfifo mknod mv nice nl nohup
+  od paste pathchk pinky pr printenv printf ptx pwd readlink rm rmdir
+  runcon seq sha1sum sha224sum sha256sum sha384sum sha512sum shred shuf
+  sleep sort split stat stty su sum sync tac tail tee test touch tr true
+  tsort tty uname unexpand uniq unlink uptime users vdir wc who whoami yes

 See the file NEWS for a list of major changes in the current release.

diff --git a/man/Makefile.am b/man/Makefile.am
index 1047b10..c9a74f6 100644
--- a/man/Makefile.am
+++ b/man/Makefile.am
@@ -25,7 +25,8 @@ dist_man_MANS = \
   link.1 ln.1 logname.1 \
   ls.1 md5sum.1 mkdir.1 mkfifo.1 mknod.1 mv.1 nl.1 nohup.1 od.1 \
   paste.1 pathchk.1 pr.1 printenv.1 printf.1 ptx.1 pwd.1 readlink.1 \
-  rm.1 rmdir.1 seq.1 sha1sum.1 sha224sum.1 sha256sum.1 sha384sum.1 sha512sum.1 \
+  rm.1 rmdir.1 runcon.1 seq.1 \
+  sha1sum.1 sha224sum.1 sha256sum.1 sha384sum.1 sha512sum.1 \
   shred.1 shuf.1 sleep.1 sort.1 split.1 stat.1 \
   su.1 sum.1 sync.1 tac.1 tail.1 tee.1 test.1 touch.1 tr.1 true.1 tsort.1 \
   tty.1 unexpand.1 uniq.1 unlink.1 vdir.1 wc.1 \
@@ -105,6 +106,7 @@ pwd.1:		$(common_dep)	$(srcdir)/pwd.x		../src/pwd.c
 readlink.1:	$(common_dep)	$(srcdir)/readlink.x	../src/readlink.c
 rm.1:		$(common_dep)	$(srcdir)/rm.x		../src/rm.c
 rmdir.1:	$(common_dep)	$(srcdir)/rmdir.x	../src/rmdir.c
+runcon.1:	$(common_dep)	$(srcdir)/runcon.x	../src/runcon.c
 seq.1:		$(common_dep)	$(srcdir)/seq.x		../src/seq.c
 sha1sum.1:	$(common_dep)	$(srcdir)/sha1sum.x	../src/md5sum.c
 sha224sum.1:	$(common_dep)	$(srcdir)/sha224sum.x	../src/md5sum.c
diff --git a/man/runcon.x b/man/runcon.x
new file mode 100644
index 0000000..d2df13e
--- /dev/null
+++ b/man/runcon.x
@@ -0,0 +1,14 @@
+[NAME]
+runcon \- run command with specified security context
+[DESCRIPTION]
+Run COMMAND with completely-specified CONTEXT, or with current or
+transitioned security context modified by one or more of LEVEL,
+ROLE, TYPE, and USER.
+.PP
+If none of \fI-c\fR, \fI-t\fR, \fI-u\fR, \fI-r\fR, or \fI-l\fR, is specified,
+the first argument is used as the complete context.  Any additional
+arguments after \fICOMMAND\fR are interpreted as arguments to the
+command.
+.PP
+Note that only carefully-chosen contexts are likely to successfully
+run.
diff --git a/po/ChangeLog b/po/ChangeLog
index ad54a09..709c42e 100644
--- a/po/ChangeLog
+++ b/po/ChangeLog
@@ -1,3 +1,7 @@
+2007-02-02  Jim Meyering  <jim@meyering.net>
+
+	* POTFILES.in: Add src/runcon.c.
+
 2007-01-13  Jim Meyering  <jim@meyering.net>

 	* POTFILES.in: Add src/chcon.c.
diff --git a/po/POTFILES.in b/po/POTFILES.in
index 8592947..c9679f1 100644
--- a/po/POTFILES.in
+++ b/po/POTFILES.in
@@ -91,6 +91,7 @@ src/readlink.c
 src/remove.c
 src/rm.c
 src/rmdir.c
+src/runcon.c
 src/seq.c
 src/setuidgid.c
 src/shred.c
diff --git a/src/Makefile.am b/src/Makefile.am
index ca9d968..670d51b 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -26,7 +26,8 @@ bin_PROGRAMS = [ chcon chgrp chown chmod cp dd dircolors du \
   nl od paste pr ptx sha1sum sha224sum sha256sum sha384sum sha512sum \
   shuf sort split sum tac tail tr tsort unexpand uniq wc \
   basename date dirname echo env expr factor false \
-  hostname id kill logname pathchk printenv printf pwd seq sleep tee \
+  hostname id kill logname pathchk printenv printf pwd \
+  runcon seq sleep tee \
   test true tty whoami yes \
   base64 \
   $(OPTIONAL_BIN_PROGS) $(DF_PROG)
@@ -67,6 +68,7 @@ mkdir_LDADD = $(LDADD) $(LIB_SELINUX)
 mkfifo_LDADD = $(LDADD) $(LIB_SELINUX)
 mknod_LDADD = $(LDADD) $(LIB_SELINUX)
 mv_LDADD = $(LDADD) $(LIB_EACCESS) $(LIB_SELINUX)
+runcon_LDADD = $(LDADD) $(LIB_SELINUX)
 pathchk_LDADD = $(LDADD) $(LIB_EACCESS)
 rm_LDADD = $(LDADD) $(LIB_EACCESS)
 test_LDADD = $(LDADD) $(LIB_EACCESS)
diff --git a/src/runcon.c b/src/runcon.c
new file mode 100644
index 0000000..ac0b906
--- /dev/null
+++ b/src/runcon.c
@@ -0,0 +1,249 @@
+/*
+ * runcon [ context |
+ *         ( [ -c ] [ -r role ] [-t type] [ -u user ] [ -l levelrange ] )
+ *         command [arg1 [arg2 ...] ]
+ *
+ * attempt to run the specified command with the specified context.
+ *
+ * -r role  : use the current context with the specified role
+ * -t type  : use the current context with the specified type
+ * -u user  : use the current context with the specified user
+ * -l level : use the current context with the specified level range
+ * -c       : compute process transition context before modifying
+ *
+ * Contexts are interpreted as follows:
+ *
+ * Number of       MLS
+ * components    system?
+ *
+ *     1            -         type
+ *     2            -         role:type
+ *     3            Y         role:type:range
+ *     3            N         user:role:type
+ *     4            Y         user:role:type:range
+ *     4            N         error
+ */
+
+#include <config.h>
+#include <stdio.h>
+#include <getopt.h>
+#include <selinux/selinux.h>
+#include <selinux/context.h>
+#ifdef HAVE_SELINUX_FLASK_H
+# include <selinux/flask.h>
+#else
+# define SECCLASS_PROCESS 0
+#endif
+#include <sys/types.h>
+#include "system.h"
+#include "error.h"
+#include "quote.h"
+#include "quotearg.h"
+
+/* The official name of this program (e.g., no `g' prefix).  */
+#define PROGRAM_NAME "runcon"
+
+#define AUTHORS "Russell Coker"
+
+static struct option long_options[] = {
+  {"role", required_argument, NULL, 'r'},
+  {"type", required_argument, NULL, 't'},
+  {"user", required_argument, NULL, 'u'},
+  {"range", required_argument, NULL, 'l'},
+  {"compute", no_argument, NULL, 'c'},
+  {GETOPT_HELP_OPTION_DECL},
+  {GETOPT_VERSION_OPTION_DECL},
+  {NULL, 0, NULL, 0}
+};
+
+/* The name the program was run with. */
+char *program_name;
+
+void
+usage (int status)
+{
+  if (status != EXIT_SUCCESS)
+    fprintf (stderr, _("Try `%s --help' for more information.\n"),
+	     program_name);
+  else
+    {
+      printf (_("\
+Usage: %s CONTEXT COMMAND [args]\n\
+  or:  %s [ -c ] [-u USER] [-r ROLE] [-t TYPE] [-l RANGE] COMMAND [args]\n\
+"), program_name, program_name);
+      fputs (_("\
+Run a program in a different security context.\n\
+With neither CONTEXT nor COMMAND, print the current security context.\n\
+\n\
+  CONTEXT            Complete security context\n\
+  -c, --compute      compute process transition context before modifying\n\
+  -t, --type=TYPE    type (for same role as parent)\n\
+  -u, --user=USER    user identity\n\
+  -r, --role=ROLE    role\n\
+  -l, --range=RANGE  levelrange\n\
+\n\
+"), stdout);
+      fputs (HELP_OPTION_DESCRIPTION, stdout);
+      fputs (VERSION_OPTION_DESCRIPTION, stdout);
+    }
+  exit (status);
+}
+
+int
+main (int argc, char **argv, char **envp)
+{
+  char *role = NULL;
+  char *range = NULL;
+  char *user = NULL;
+  char *type = NULL;
+  char *context = NULL;
+  security_context_t cur_context = NULL;
+  security_context_t file_context = NULL;
+  security_context_t new_context = NULL;
+  bool compute_trans = false;
+
+  context_t con;
+
+  initialize_main (&argc, &argv);
+  program_name = argv[0];
+  setlocale (LC_ALL, "");
+  bindtextdomain (PACKAGE, LOCALEDIR);
+  textdomain (PACKAGE);
+
+  atexit (close_stdout);
+
+  while (1)
+    {
+      int c;
+      int option_index = 0;
+      c = getopt_long (argc, argv, "r:t:u:l:c", long_options, &option_index);
+      if (c == -1)
+	break;
+      switch (c)
+	{
+	case 'r':
+	  if (role)
+	    error (EXIT_FAILURE, 0, _("multiple roles"));
+	  role = optarg;
+	  break;
+	case 't':
+	  if (type)
+	    error (EXIT_FAILURE, 0, _("multiple types"));
+	  type = optarg;
+	  break;
+	case 'u':
+	  if (user)
+	    error (EXIT_FAILURE, 0, _("multiple users"));
+	  user = optarg;
+	  break;
+	case 'l':
+	  if (range)
+	    error (EXIT_FAILURE, 0, _("multiple levelranges"));
+	  range = optarg;
+	  break;
+	case 'c':
+	  compute_trans = true;
+	  break;
+
+	case_GETOPT_HELP_CHAR;
+	case_GETOPT_VERSION_CHAR (PROGRAM_NAME, AUTHORS);
+	default:
+	  usage (EXIT_FAILURE);
+	  break;
+	}
+    }
+
+  if (argc - optind == 0)
+    {
+      if (getcon (&cur_context) < 0)
+	error (EXIT_FAILURE, errno, _("failed to get current context"));
+      fputs (cur_context, stdout);
+      fputc ('\n', stdout);
+      exit (EXIT_SUCCESS);
+    }
+
+  if (!(user || role || type || range || compute_trans))
+    {
+      if (optind >= argc)
+	{
+	  error (0, 0, _("you must specify -c, -t, -u, -l, -r, or context"));
+	  usage (1);
+	}
+      context = argv[optind++];
+    }
+
+  if (optind >= argc)
+    {
+      error (0, 0, _("no command specified"));
+      usage (1);
+    }
+
+  if (is_selinux_enabled () != 1)
+    error (EXIT_FAILURE, 0,
+	   _("runcon may be used only on a SELinux kernel."));
+
+  if (context)
+    {
+      con = context_new (context);
+      if (!con)
+	error (EXIT_FAILURE, errno, _("failed to create security context: %s"),
+	       quotearg_colon (context));
+    }
+  else
+    {
+      if (getcon (&cur_context) < 0)
+	error (EXIT_FAILURE, errno, _("failed to get current context"));
+
+      /* We will generate context based on process transition */
+      if (compute_trans)
+	{
+	  /* Get context of file to be executed */
+	  if (getfilecon (argv[optind], &file_context) == -1)
+	    error (EXIT_FAILURE, errno,
+		   _("failed to get security context of %s"),
+		   quote (argv[optind]));
+	  /* compute result of process transition */
+	  if (security_compute_create (cur_context, file_context,
+				       SECCLASS_PROCESS, &new_context) != 0)
+	    error (EXIT_FAILURE, errno,
+		   _("failed to compute a new context"));
+	  /* free contexts */
+	  freecon (file_context);
+	  freecon (cur_context);
+
+	  /* set cur_context equal to new_context */
+	  cur_context = new_context;
+	}
+
+      con = context_new (cur_context);
+      if (!con)
+	error (EXIT_FAILURE, errno, _("failed to create security context: %s"),
+	       quotearg_colon (cur_context));
+      if (user && context_user_set (con, user))
+	error (EXIT_FAILURE, errno, _("failed to set new user %s"), user);
+      if (type && context_type_set (con, type))
+	error (EXIT_FAILURE, errno, _("failed to set new type %s"), type);
+      if (range && context_range_set (con, range))
+	error (EXIT_FAILURE, errno, _("failed to set new range %s"), range);
+      if (role && context_role_set (con, role))
+	error (EXIT_FAILURE, errno, _("failed to set new role %s"), role);
+    }
+
+  if (security_check_context (context_str (con)) < 0)
+    error (EXIT_FAILURE, errno, _("invalid context: %s"),
+	   quotearg_colon (context_str (con)));
+
+  if (setexeccon (context_str (con)) != 0)
+    error (EXIT_FAILURE, errno, _("unable to set security context %s"),
+	   quote (context_str (con)));
+  if (cur_context != NULL)
+    freecon (cur_context);
+
+  execvp (argv[optind], argv + optind);
+
+  {
+    int exit_status = (errno == ENOENT ? EXIT_ENOENT : EXIT_CANNOT_INVOKE);
+    error (0, errno, "%s", argv[optind]);
+    exit (exit_status);
+  }
+}
diff --git a/tests/help-version b/tests/help-version
index d3c9bfb..3dea4d1 100755
--- a/tests/help-version
+++ b/tests/help-version
@@ -72,6 +72,7 @@ for lang in C fr da; do
     # Skip `test'; it doesn't accept --help or --version.
     test $i = test && continue;
     test $i = chcon && continue;
+    test $i = runcon && continue;

     # false fails even when invoked with --help or --version.
     if test $i = false; then
@@ -197,7 +198,7 @@ lbracket_args=": ]"

 for i in $all_programs; do
   # Skip these.
-  case $i in chroot|stty|tty|false|chcon) continue;; esac
+  case $i in chroot|stty|tty|false|chcon|runcon) continue;; esac

   rm -rf $tmp_in $tmp_in2 $tmp_dir $tmp_out
   echo > $tmp_in

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
