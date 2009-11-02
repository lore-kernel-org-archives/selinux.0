Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nA2HTIgF030298
	for <selinux@tycho.nsa.gov>; Mon, 2 Nov 2009 12:29:18 -0500
Received: from moss-lions.epoch.ncsc.mil (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id nA2HSLNq000834
	for <selinux@tycho.nsa.gov>; Mon, 2 Nov 2009 17:28:21 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3) with ESMTP id nA2HREAp007048
	for <selinux@tycho.nsa.gov>; Mon, 2 Nov 2009 12:27:14 -0500
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.14.3/8.14.3/Submit) id nA2HREVZ007046
	for selinux@tycho.nsa.gov; Mon, 2 Nov 2009 12:27:14 -0500
Subject: Patch for Ticket #1 [1672486] (policycoreutils)
From: Guido Trentalancia <guido@trentalancia.com>
To: SELinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-S+dr3xlhgmP6mtSH0srn"
Date: Mon, 02 Nov 2009 18:14:23 +0100
Message-Id: <1257182063.2916.22.camel@tesla.lan>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-S+dr3xlhgmP6mtSH0srn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch is proposed to solve Ticket #1 [1672486] (command line
binaries should support --version and --help).

It adds handling of -h, -V and the long formats --help and --version to
all binaries that are produced from C code. It does not tackle the issue
for Python-based tools (e.g. semanage).

Manual pages have also been updated accordingly.

Guido Trentalancia

diff -pru policycoreutils/load_policy/load_policy.8
policycoreutils-new/load_policy/load_policy.8
--- policycoreutils/load_policy/load_policy.8   2009-11-01
22:23:01.000000000 +0100
+++ policycoreutils-new/load_policy/load_policy.8       2009-11-02
00:40:13.000000000 +0100
@@ -15,11 +15,25 @@ values in the policy file.
 
 .SH "OPTIONS"
 .TP
+.B \-V
+or
+.B \-\-version
+shows the current version of load_policy
+.TP
+.B \-h
+or
+.B \-\-help
+shows the usage information for load_policy
+.TP
 .B \-q
+or
+.B \-\-quiet
 suppress warning messages.
 .TP
 .B \-i
-inital policy load. Only use this if this is the first time policy is
being loaded since boot (usually called from initramfs).
+or
+.B \-\-init
+initial policy load. Only use this if this is the first time policy is
being loaded since boot (usually called from initramfs).
 
 .SH "EXIT STATUS"
 .TP
diff -pru policycoreutils/load_policy/load_policy.c
policycoreutils-new/load_policy/load_policy.c
--- policycoreutils/load_policy/load_policy.c   2009-11-01
22:23:01.000000000 +0100
+++ policycoreutils-new/load_policy/load_policy.c       2009-11-02
00:33:56.000000000 +0100
@@ -2,7 +2,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <errno.h>
-#include <getopt.h>
+#include <getopt.h>    /* for getopt_long() form of getopt() */
 #include <string.h>
 #include <selinux/selinux.h>
 #include <sepol/sepol.h>
@@ -13,19 +13,49 @@
 #else
 #define _(msgid) (msgid)
 #endif
+#define LOAD_POLICY_CONF_PROG_NAME "load_policy"        /* default
program
name */
 #ifndef PACKAGE
 #define PACKAGE "policycoreutils"      /* the name of this package lang
translation */
 #endif
 
 void usage(char *progname)
 {
-       fprintf(stderr, _("usage:  %s [-qi]\n"), progname);
+       fprintf(stderr, _("usage:  %s -h | -V | [-qi]\n"), progname);
+       fprintf(stderr, _("         -h     Show this message.\n"));
+       fprintf(stderr, _("         -V     Show the version.\n"));
+       fprintf(stderr, _("         -q     Suppress warning
messages.\n"));
+       fprintf(stderr, _("         -i     Inital policy load. Only use
this
if this is the first time policy is being loaded since boot.\n"));
        exit(1);
 }
 
+static char *opt_program_name(char *argv0, char *def)
+{
+       if (argv0) {
+               if ((def = strrchr(argv0, '/')))
+                       ++def;
+               else
+                       def = argv0;
+
+               /* hack for libtool */
+               if ((strlen(def) > strlen("lt-"))
+                   && !memcmp("lt-", def, strlen("lt-")))
+                       def += 3;
+       }
+
+       return (def);
+}
+
 int main(int argc, char **argv)
 {
        int ret, opt, quiet = 0, nargs, init=0, enforce=0;
+       char *program_name = NULL;
+        struct option long_options[] = {
+               {"quiet", no_argument, NULL, 'q'},
+               {"init", no_argument, NULL, 'i'},
+               {"version", no_argument, NULL, 'V'},
+                {"help", no_argument, NULL, 'h'},
+               {NULL, 0, NULL, 0}
+       };
 
 #ifdef USE_NLS
        setlocale(LC_ALL, "");
@@ -33,11 +63,13 @@ int main(int argc, char **argv)
        textdomain(PACKAGE);
 #endif
 
-       while ((opt = getopt(argc, argv, "bqi")) > 0) {
+       program_name = opt_program_name(argv[0],
LOAD_POLICY_CONF_PROG_NAME);
+
+       while ((opt = getopt_long(argc, argv, "bqiVh", long_options,
NULL)) !=
-1) {
                switch (opt) {
                case 'b':
                        fprintf(stderr, "%s:  Warning! The -b option is
no longer supported,
booleans are always preserved across reloads.  Continuing...\n",
-                               argv[0]);
+                               program_name);
                        break;
                case 'q':
                        quiet = 1;
@@ -46,8 +78,14 @@ int main(int argc, char **argv)
                case 'i':
                        init = 1;
                        break;
+               case 'V':
+                       fprintf(stdout,
+                                " %s version %s.\n", program_name,
VERSION);
+                       exit(EXIT_SUCCESS);
+               case 'h':
+                       usage(program_name);
                default:
-                       usage(argv[0]);
+                       usage(program_name);
                }
        }
 
diff -pru policycoreutils/load_policy/Makefile
policycoreutils-new/load_policy/Makefile
--- policycoreutils/load_policy/Makefile        2009-11-01
22:23:01.000000000
+0100
+++ policycoreutils-new/load_policy/Makefile    2009-11-02
00:05:54.000000000 +0100
@@ -4,8 +4,9 @@ SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 
+VERSION = $(shell cat ../VERSION)
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS
-DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS
-DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-DVERSION=\"$(VERSION)\"
 LDLIBS += -lsepol -lselinux -L$(PREFIX)/lib
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
diff -pru policycoreutils/newrole/newrole.1
policycoreutils-new/newrole/newrole.1
--- policycoreutils/newrole/newrole.1   2009-11-01 22:23:01.000000000
+0100
+++ policycoreutils-new/newrole/newrole.1       2009-11-02
00:05:54.000000000
+0100
@@ -58,10 +58,16 @@ The new shell will be the shell specifie
 file.
 .PP
 The
+.B -h
+or
+.B --help
+shows the usage information for newrole.
+.PP
+The
 .B -V
 or 
 .B --version
-shows the current version of newrole
+shows the current version of newrole.
 .PP
 .SH EXAMPLE
 .br
diff -pru policycoreutils/newrole/newrole.c
policycoreutils-new/newrole/newrole.c
--- policycoreutils/newrole/newrole.c   2009-11-01 22:23:01.000000000
+0100
+++ policycoreutils-new/newrole/newrole.c       2009-11-02
00:05:54.000000000
+0100
@@ -10,7 +10,7 @@
  *
  * USAGE:
  *
- * newrole [ -r role ] [ -t type ] [ -l level ] [ -V ] [ -- args ]
+ * newrole -h | -V | [ -r role ] [ -t type ] [ -l level ] [ -- args ]
  *
  * BUILD OPTIONS:
  *
@@ -91,7 +91,7 @@
 #endif
 
 /* USAGE_STRING describes the command-line args of this program. */
-#define USAGE_STRING "USAGE: newrole [ -r role ] [ -t type ] [ -l
level ] [ -p ] [ -V ] [ -- args ]"
+#define USAGE_STRING "USAGE: newrole -h | -V | [ -r role ] [ -t type ]
[ -l level ] [ -p ] [ -- args ]"
 
 #ifdef USE_PAM
 #define PAM_SERVICE_CONFIG "/etc/selinux/newrole_pam.conf";
@@ -877,21 +877,24 @@ static int parse_command_line_arguments(
                {"level", 1, 0, 'l'},
                {"preserve-environment", 0, 0, 'p'},
                {"version", 0, 0, 'V'},
+               {"help", 0, 0, 'h'},
                {NULL, 0, 0, 0}
        };
 
        *preserve_environment = 0;
        while (1) {
-               clflag = getopt_long(argc, argv, "r:t:l:pV",
long_options,
+               clflag = getopt_long(argc, argv, "r:t:l:pVh",
long_options,
                                     &flag_index);
                if (clflag == -1)
                        break;
 
                switch (clflag) {
+               case 'h':
+                       fprintf(stderr, "%s\n", USAGE_STRING);
+                       exit(EXIT_SUCCESS);
                case 'V':
                        printf("newrole: %s version %s\n", PACKAGE,
VERSION);
-                       exit(0);
-                       break;
+                       exit(EXIT_SUCCESS);
                case 'p':
                        *preserve_environment = 1;
                        break;
diff -pru policycoreutils/restorecond/Makefile
policycoreutils-new/restorecond/Makefile
--- policycoreutils/restorecond/Makefile        2009-11-01
22:23:01.000000000
+0100
+++ policycoreutils-new/restorecond/Makefile    2009-11-02
00:05:54.000000000 +0100
@@ -5,8 +5,9 @@ MANDIR = $(PREFIX)/share/man
 INITDIR = $(DESTDIR)/etc/rc.d/init.d
 SELINUXDIR = $(DESTDIR)/etc/selinux
 
+VERSION = $(shell cat ../VERSION)
 CFLAGS ?= -g -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
+override CFLAGS += -I$(PREFIX)/include -DVERSION=\"$(VERSION)\"
-D_FILE_OFFSET_BITS=64
 LDLIBS += -lselinux -L$(PREFIX)/lib
 
 all: restorecond
diff -pru policycoreutils/restorecond/restorecond.8
policycoreutils-new/restorecond/restorecond.8
--- policycoreutils/restorecond/restorecond.8   2009-11-01
22:23:01.000000000 +0100
+++ policycoreutils-new/restorecond/restorecond.8       2009-11-02
00:39:31.000000000 +0100
@@ -3,7 +3,7 @@
 restorecond \- daemon that watches for file creation and then sets the
default SELinux file context
 
 .SH "SYNOPSIS"
-.B restorecond  [\-d]
+.B restorecond  [\-d] [\-v] | \-h | \-V
 .P
 
 .SH "DESCRIPTION"
@@ -17,8 +17,25 @@ the correct file context associated with
 .SH "OPTIONS"
 .TP 
 .B \-d
+or
+.B \-\-debug
 Turns on debugging mode.   Application will stay in the foreground and
lots of
 debugs messages start printing.
+.TP
+.B \-v
+or
+.B \-\-verbose
+Turns on verbose mode. Missing files are reported.
+.TP
+.B \-h
+or
+.B \-\-help
+Shows the usage information.
+.TP
+.B \-V
+or
+.B \-\-version
+Shows the version information.
 
 .SH "AUTHOR"
 This man page was written by Dan Walsh <dwalsh@redhat.com>.
diff -pru policycoreutils/restorecond/restorecond.c
policycoreutils-new/restorecond/restorecond.c
--- policycoreutils/restorecond/restorecond.c   2009-11-01
22:23:01.000000000 +0100
+++ policycoreutils-new/restorecond/restorecond.c       2009-11-02
00:42:49.000000000 +0100
@@ -30,8 +30,10 @@
  * and makes sure that there security context matches the systems
defaults
  *
  * USAGE:
- * restorecond [-d] [-v]
- * 
+ * restorecond -h | -V | [-d] [-v]
+ *
+ * -h   Shows the usage information
+ * -V   Shows the version
  * -d   Run in debug mode
  * -v   Run in verbose mode (Report missing files)
  *
@@ -48,6 +50,7 @@
 #include <signal.h>
 #include <string.h>
 #include <unistd.h>
+#include <getopt.h>    /* for getopt_long() form of getopt() */
 #include <ctype.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -67,6 +70,8 @@ static int terminate = 0;
 #include <selinux/selinux.h>
 #include <utmp.h>
 
+#define RESTORECOND_CONF_PROG_NAME "restorecond"       /* default
program
name */
+
 /* size of the event structure, not counting name */
 #define EVENT_SIZE  (sizeof (struct inotify_event))
 /* reasonable guess as to size of 1024 events */
@@ -374,8 +379,25 @@ static void term_handler()
 
 static void usage(char *program)
 {
-       printf("%s [-d] [-v] \n", program);
-       exit(0);
+       printf("%s [-d] [-v] | -h | -V \n", program);
+       exit(EXIT_SUCCESS);
+}
+
+static char *opt_program_name(char *argv0, char *def)
+{
+       if (argv0) {
+               if ((def = strrchr(argv0, '/')))
+                       ++def;
+               else
+                       def = argv0;
+
+               /* hack for libtool */
+               if ((strlen(def) > strlen("lt-"))
+                   && !memcmp("lt-", def, strlen("lt-")))
+                       def += 3;
+       }
+
+       return (def);
 }
 
 void exitApp(const char *msg)
@@ -445,6 +467,14 @@ int main(int argc, char **argv)
 {
        int opt;
        struct sigaction sa;
+       char *program_name = NULL;
+       struct option long_options[] = {
+               {"help", no_argument, NULL, 'h'},
+               {"version", no_argument, NULL, 'V'},
+               {"debug", no_argument, NULL, 'd'},
+               {"verbose", no_argument, NULL, 'v'},
+               {NULL, 0, NULL, 0}
+       };
 
 #ifndef DEBUG
        /* Make sure we are root */
@@ -471,8 +501,17 @@ int main(int argc, char **argv)
        if (master_fd < 0)
                exitApp("inotify_init");
 
-       while ((opt = getopt(argc, argv, "dv")) > 0) {
+       program_name = opt_program_name(argv[0],
RESTORECOND_CONF_PROG_NAME);
+
+       while ((opt = getopt_long(argc, argv, "hVdv", long_options,
NULL)) !=
-1) {
                switch (opt) {
+               case 'h':
+                       usage(program_name);
+                       exit(EXIT_SUCCESS);
+               case 'V':
+                       fprintf(stdout,
+                                " %s version %s.\n", program_name,
VERSION);
+                       exit(EXIT_SUCCESS);
                case 'd':
                        debug_mode = 1;
                        break;
@@ -480,7 +519,7 @@ int main(int argc, char **argv)
                        verbose_mode = 1;
                        break;
                case '?':
-                       usage(argv[0]);
+                       usage(program_name);
                }
        }
        read_config(master_fd);
diff -pru policycoreutils/run_init/Makefile
policycoreutils-new/run_init/Makefile
--- policycoreutils/run_init/Makefile   2009-11-01 22:23:01.000000000
+0100
+++ policycoreutils-new/run_init/Makefile       2009-11-02
00:05:54.000000000
+0100
@@ -8,8 +8,9 @@ LOCALEDIR ?= /usr/share/locale
 PAMH = $(shell ls /usr/include/security/pam_appl.h 2>/dev/null)
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 
+VERSION = $(shell cat ../VERSION)
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -DUSE_NLS
-DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+override CFLAGS += -I$(PREFIX)/include -DUSE_NLS
-DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
-DVERSION=\"$(VERSION)\"
 LDLIBS += -lselinux -L$(PREFIX)/lib
 ifeq (${PAMH}, /usr/include/security/pam_appl.h)
        override CFLAGS += -DUSE_PAM
diff -pru policycoreutils/run_init/run_init.8
policycoreutils-new/run_init/run_init.8
--- policycoreutils/run_init/run_init.8 2009-11-01 22:23:01.000000000
+0100
+++ policycoreutils-new/run_init/run_init.8     2009-11-02
01:18:22.000000000 +0100
@@ -3,12 +3,19 @@
 run_init \- run an init script in the proper SELinux context
 .SH SYNOPSIS
 .B run_init 
-\fISCRIPT\fR [[\fIARGS\fR]...] 
+\fISCRIPT\fR [[\fIARGS\fR]...] | -h | -V 
 .br
 .SH DESCRIPTION
 .PP
 Run a init script under the proper context, which is specified in 
 /etc/selinux/POLICYTYPE/contexts/initrc_context.
+.SH OPTIONS
+.TP
+.B \-h,\-\-help
+Print the help message.
+.TP
+.B \-V,\-\-version
+Print the version information.
 .SH FILES
 /etc/passwd - user account information
 .br
diff -pru policycoreutils/run_init/run_init.c
policycoreutils-new/run_init/run_init.c
--- policycoreutils/run_init/run_init.c 2009-11-01 22:23:01.000000000
+0100
+++ policycoreutils-new/run_init/run_init.c     2009-11-02
01:18:27.000000000 +0100
@@ -8,7 +8,7 @@
  *
  * USAGE:
  *
- * run_init <script> <args>
+ * run_init <script> <args> | -h | -V
  *
  * BUILD OPTIONS:
  *
@@ -60,13 +60,17 @@
 #else
 #define _(msgid) (msgid)
 #endif
+#define RUN_INIT_CONF_PROG_NAME "run_init"     /* default program name
*/
 #ifndef PACKAGE
 #define PACKAGE "policycoreutils"      /* the name of this package lang
translation */
 #endif
 /* USAGE_STRING describes the command-line args of this program. */
-#define USAGE_STRING _("USAGE: run_init <script> <args ...>\n\
+#define USAGE_STRING _("USAGE: run_init <script> <args ...> | -h | -V\n
\
   where: <script> is the name of the init script to run,\n\
-         <args ...> are the arguments to that script.")
+         <args ...> are the arguments to that script.\n\
+  or:\n\
+         -h or --help     Print this usage information.\n\
+         -V or --version    Print version information.\n")
 
 #define CONTEXT_FILE "initrc_context"
 #ifdef USE_PAM
@@ -289,7 +293,7 @@ int authenticate_user()
 /*
  * get_init_context()
  *
- * Get the CONTEXT associated with the context for the init scripts.
*
+ * Get the CONTEXT associated with the context for the init scripts.
  *
  * in:         nothing
  * out:                The CONTEXT associated with the context.
@@ -338,15 +342,48 @@ int get_init_context(security_context_t 
 
 }                              /* get_init_context() */
 
+/*
+ * opt_program_name()
+ * 
+ * Find out exactly what the program name is
+ *
+ * in:
+ *              argv0  --  argv[0] from main
+ *              def   --   default program name
+ * out:         The exact program name to print out in usage and
version information 
+ */
+static char *opt_program_name(char *argv0, char *def)
+{
+       if (argv0) {
+               if ((def = strrchr(argv0, '/')))
+                       ++def;
+               else
+                       def = argv0;
+
+               /* hack for libtool */
+               if ((strlen(def) > strlen("lt-"))
+                   && !memcmp("lt-", def, strlen("lt-")))
+                       def += 3;
+       }
+
+       return (def);
+}
+
 /*****************************************************************************
  * main()
*

*****************************************************************************/
 int main(int argc, char *argv[])
 {
-
+       int opt;
+       char *program_name = NULL;
        extern char *optarg;    /* used by getopt() for arg strings */
        extern int opterr;      /* controls getopt() error messages */
        security_context_t new_context; /* context for the init script
context
*/
+       struct option long_options[] = {
+               {"version", no_argument, NULL, 'V'},
+               {"help", no_argument, NULL, 'h'},
+               {NULL, 0, NULL, 0}
+       };
 
 #ifdef USE_NLS
        setlocale(LC_ALL, "");
@@ -366,8 +403,27 @@ int main(int argc, char *argv[])
         * Step 1:  Handle command-line arguments. The first argument is
the 
         * name of the script to run. All other arguments are for the
script
         * itself, and will be passed directly to the script.
+        * Request for help or version information are handled
accordingly
+        * here.
         */
 
+       program_name = opt_program_name(argv[0],
RUN_INIT_CONF_PROG_NAME);
+
+       while ((opt = getopt_long(argc, argv, "Vh", long_options,
NULL)) !=
-1) {
+               switch (opt) {
+               case 'V':
+                       fprintf(stdout,
+                               " %s version %s.\n", program_name,
VERSION);
+                       exit(EXIT_SUCCESS);
+               case 'h':
+                       fprintf(stderr, "%s\n", USAGE_STRING);
+                       exit(EXIT_SUCCESS);
+               default:
+                       fprintf(stderr, "%s\n", USAGE_STRING);
+                       exit(-1);
+               }
+       }
+
        if (argc < 2) {
                fprintf(stderr, "%s\n", USAGE_STRING);
                exit(-1);
diff -pru policycoreutils/semodule/Makefile
policycoreutils-new/semodule/Makefile
--- policycoreutils/semodule/Makefile   2009-11-01 22:23:01.000000000
+0100
+++ policycoreutils-new/semodule/Makefile       2009-11-02
00:52:25.000000000
+0100
@@ -5,8 +5,9 @@ SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
 LIBDIR ?= ${PREFIX}/lib
 
+VERSION = $(shell cat ../VERSION)
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I$(INCLUDEDIR) -DVERSION=\"$(VERSION)\"
 LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
 SEMODULE_OBJS = semodule.o
 
diff -pru policycoreutils/semodule/semodule.8
policycoreutils-new/semodule/semodule.8
--- policycoreutils/semodule/semodule.8 2009-11-01 22:23:01.000000000
+0100
+++ policycoreutils-new/semodule/semodule.8     2009-11-02
01:17:48.000000000 +0100
@@ -52,6 +52,9 @@ prints help message and quit
 .TP
 .B  \-v,\-\-verbose     
 be verbose
+.TP
+.B  \-V,\-\-version
+shows the version information
 
 .SH EXAMPLE
 .nf
diff -pru policycoreutils/semodule/semodule.c
policycoreutils-new/semodule/semodule.c
--- policycoreutils/semodule/semodule.c 2009-11-01 22:23:01.000000000
+0100
+++ policycoreutils-new/semodule/semodule.c     2009-11-02
01:25:33.000000000 +0100
@@ -22,6 +22,8 @@
 
 #include <semanage/modules.h>
 
+#define SEMODULE_CONF_PROG_NAME "semodule"     /* default program name
*/
+
 enum client_modes { NO_MODE, INSTALL_M, UPGRADE_M, BASE_M, REMOVE_M,
        LIST_M, RELOAD
 };
@@ -49,6 +51,8 @@ static int disable_dontaudit;
 static semanage_handle_t *sh = NULL;
 static char *store;
 
+char *program_name = NULL;
+
 extern char *optarg;
 extern int optind;
 
@@ -114,9 +118,28 @@ static void usage(char *progname)
        printf("  -n,--noreload    do not reload policy after commit
\n");
        printf("  -h,--help        print this message and quit\n");
        printf("  -v,--verbose     be verbose\n");
+       printf("  -V,--version     print version information\n");
        printf("  -D,--disable_dontaudit        Remove dontaudits from
policy\n");
 }
 
+/* Gets the exact program name. */
+static char *opt_program_name(char *argv0, char *def)
+{
+       if (argv0) {
+               if ((def = strrchr(argv0, '/')))
+                       ++def;
+               else
+                       def = argv0;
+
+               /* hack for libtool */
+               if ((strlen(def) > strlen("lt-"))
+                   && !memcmp("lt-", def, strlen("lt-")))
+                       def += 3;
+       }
+
+       return (def);
+}
+
 /* Sets the global mode variable to new_mode, but only if no other
  * mode has been given. */
 static void set_mode(enum client_modes new_mode, char *arg)
@@ -152,6 +175,7 @@ static void parse_command_line(int argc,
                {"install", required_argument, NULL, 'i'},
                {"list-modules", 0, NULL, 'l'},
                {"verbose", 0, NULL, 'v'},
+               {"version", 0, NULL, 'V'},
                {"remove", required_argument, NULL, 'r'},
                {"upgrade", required_argument, NULL, 'u'},
                {"reload", 0, NULL, 'R'},
@@ -166,7 +190,7 @@ static void parse_command_line(int argc,
        no_reload = 0;
        create_store = 0;
        while ((i =
-               getopt_long(argc, argv, "s:b:hi:lvqr:u:RnBD", opts,
+               getopt_long(argc, argv, "s:b:hi:lvVqr:u:RnBD", opts,
                            NULL)) != -1) {
                switch (i) {
                case 'b':
@@ -174,7 +198,7 @@ static void parse_command_line(int argc,
                        create_store = 1;
                        break;
                case 'h':
-                       usage(argv[0]);
+                       usage(program_name);
                        exit(0);
                case 'i':
                        set_mode(INSTALL_M, optarg);
@@ -185,6 +209,10 @@ static void parse_command_line(int argc,
                case 'v':
                        verbose = 1;
                        break;
+               case 'V':
+                       fprintf(stdout,
+                                " %s version %s.\n", program_name,
VERSION);
+                        exit(EXIT_SUCCESS);
                case 'r':
                        set_mode(REMOVE_M, optarg);
                        break;
@@ -208,7 +236,7 @@ static void parse_command_line(int argc,
                        break;
                case '?':
                default:{
-                               usage(argv[0]);
+                               usage(program_name);
                                exit(1);
                        }
                }
@@ -216,12 +244,12 @@ static void parse_command_line(int argc,
        if ((build || reload) && num_commands) {
                fprintf(stderr,
                        "build or reload should not be used with other
commands\n");
-               usage(argv[0]);
+               usage(program_name);
                exit(1);
        }
        if (num_commands == 0 && reload == 0 && build == 0) {
                fprintf(stderr, "At least one mode must be
specified.\n");
-               usage(argv[0]);
+               usage(program_name);
                exit(1);
        }
 
@@ -243,7 +271,7 @@ static void parse_command_line(int argc,
                        while (optind < argc)
                                fprintf(stderr, " %s", argv[optind++]);
                        fprintf(stderr, "\n\n");
-                       usage(argv[0]);
+                       usage(program_name);
                        exit(1);
                }
                while (optind < argc)
@@ -257,6 +285,8 @@ int main(int argc, char *argv[])
        int result;
        int status = EXIT_FAILURE;
 
+       program_name = opt_program_name(argv[0],
SEMODULE_CONF_PROG_NAME);
+
        create_signal_handlers();
        parse_command_line(argc, argv);
 
@@ -266,7 +296,7 @@ int main(int argc, char *argv[])
        sh = semanage_handle_create();
        if (!sh) {
                fprintf(stderr, "%s:  Could not create semanage handle
\n",
-                       argv[0]);
+                       program_name);
                goto cleanup_nohandle;
        }
 
@@ -285,27 +315,27 @@ int main(int argc, char *argv[])
                if (!semanage_is_managed(sh)) {
                        fprintf(stderr,
                                "%s: SELinux policy is not managed or
store cannot be accessed.\n",
-                               argv[0]);
+                               program_name);
                        goto cleanup;
                }
 
                if (semanage_access_check(sh) < SEMANAGE_CAN_READ) {
                        fprintf(stderr, "%s: Cannot read policy
store.\n",
-                               argv[0]);
+                               program_name);
                        goto cleanup;
                }
        }
 
        if ((result = semanage_connect(sh)) < 0) {
                fprintf(stderr, "%s:  Could not connect to policy
handler\n",
-                       argv[0]);
+                       program_name);
                goto cleanup;
        }
 
        if (reload) {
                if ((result = semanage_reload_policy(sh)) < 0) {
                        fprintf(stderr, "%s:  Could not reload policy
\n",
-                               argv[0]);
+                               program_name);
                        goto cleanup;
                }
        }
@@ -313,7 +343,7 @@ int main(int argc, char *argv[])
        if (build) {
                if ((result = semanage_begin_transaction(sh)) < 0) {
                        fprintf(stderr, "%s:  Could not begin
transaction:  %s\n",
-                               argv[0], errno ? strerror(errno) : "");
+                               program_name, errno ? strerror(errno) :
"");
                        goto cleanup;
                }
        }
@@ -397,14 +427,14 @@ int main(int argc, char *argv[])
                default:{
                                fprintf(stderr,
                                        "%s:  Unknown mode
specified.\n",
-                                       argv[0]);
-                               usage(argv[0]);
+                                       program_name);
+                               usage(program_name);
                                goto cleanup;
                        }
                }
                commit += do_commit[mode];
                if (result < 0) {
-                       fprintf(stderr, "%s:  Failed on %s!\n", argv[0],
+                       fprintf(stderr, "%s:  Failed on %s!\n",
program_name,
                                mode_arg ? : "list");
                        goto cleanup;
                } else if (verbose) {
@@ -428,14 +458,14 @@ int main(int argc, char *argv[])
        }
 
        if (result < 0) {
-               fprintf(stderr, "%s:  Failed!\n", argv[0]);
+               fprintf(stderr, "%s:  Failed!\n", program_name);
                goto cleanup;
        } else if (commit && verbose) {
                printf("Ok: transaction number %d.\n", result);
        }
 
        if (semanage_disconnect(sh) < 0) {
-               fprintf(stderr, "%s:  Error disconnecting\n", argv[0]);
+               fprintf(stderr, "%s:  Error disconnecting\n",
program_name);
                goto cleanup;
        }
        status = EXIT_SUCCESS;
@@ -443,7 +473,7 @@ int main(int argc, char *argv[])
       cleanup:
        if (semanage_is_connected(sh)) {
                if (semanage_disconnect(sh) < 0) {
-                       fprintf(stderr, "%s:  Error disconnecting\n",
argv[0]);
+                       fprintf(stderr, "%s:  Error disconnecting\n",
program_name);
                }
        }
        semanage_handle_destroy(sh);
diff -pru policycoreutils/semodule_deps/Makefile
policycoreutils-new/semodule_deps/Makefile
--- policycoreutils/semodule_deps/Makefile      2009-11-01
22:23:01.000000000
+0100
+++ policycoreutils-new/semodule_deps/Makefile  2009-11-02
00:05:54.000000000 +0100
@@ -5,8 +5,9 @@ BINDIR ?= $(PREFIX)/bin
 LIBDIR ?= ${PREFIX}/lib
 MANDIR ?= $(PREFIX)/share/man
 
+VERSION = $(shell cat ../VERSION)
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I$(INCLUDEDIR) -DVERSION=\"$(VERSION)\"
 LDLIBS = $(LIBDIR)/libsepol.a
 
 all: semodule_deps
diff -pru policycoreutils/semodule_deps/semodule_deps.8
policycoreutils-new/semodule_deps/semodule_deps.8
--- policycoreutils/semodule_deps/semodule_deps.8       2009-11-01
22:23:01.000000000 +0100
+++ policycoreutils-new/semodule_deps/semodule_deps.8   2009-11-02
01:23:02.000000000 +0100
@@ -29,14 +29,20 @@ dependencies.
 
 .SH "OPTIONS"
 .TP
-.B \-v
+.B \-v,\-\-verbose
 verbose mode
 .TP
-.B \-g
+.B \-g,\-\-graphviz
 output dependency information in Graphviz dot format
 .TP
-.B \-b
+.B \-b,\-\-base
 include dependencies to the base module - by default these are excluded
+.TP
+.B \-h,\-\-help
+print usage information
+.TP
+.B \-V,\-\-version
+print version information
 
 .SH SEE ALSO
 .B checkmodule(8), semodule_package(8), semodule(8), semodule_link(8)
diff -pru policycoreutils/semodule_deps/semodule_deps.c
policycoreutils-new/semodule_deps/semodule_deps.c
--- policycoreutils/semodule_deps/semodule_deps.c       2009-11-01
22:23:01.000000000 +0100
+++ policycoreutils-new/semodule_deps/semodule_deps.c   2009-11-02
01:27:56.000000000 +0100
@@ -35,6 +35,8 @@
 extern char *optarg;
 extern int optind;
 
+#define SEMODULE_DEPS_CONF_PROG_NAME "semodule_deps"   /* default
program
name */
+
 /* This is really a horrible hack, but the base module
  * is referred to with the following name. The same
  * thing is done in the linker for displaying error
@@ -44,11 +46,29 @@ extern int optind;
 
 static void usage(char *program_name)
 {
-       printf("usage: %s [-v -g -b] basemodpkg modpkg1
[modpkg2 ... ]\n",
+       printf("usage: %s -h | -V | [-v] [-g] [-b] basemodpkg modpkg1
[modpkg2 ... ]\n",
               program_name);
        exit(1);
 }
 
+/* Get the exact program name */
+static char *opt_program_name(char *argv0, char *def)
+{
+       if (argv0) {
+               if ((def = strrchr(argv0, '/')))
+                       ++def;
+               else
+                       def = argv0;
+
+               /* hack for libtool */
+               if ((strlen(def) > strlen("lt-"))
+                    && !memcmp("lt-", def, strlen("lt-")))
+                       def += 3;
+       }
+
+       return (def);
+}
+
 /* Basic string hash and compare for the hashtables used in
  * generate_requires. Copied from symtab.c.
  */
@@ -319,12 +339,23 @@ int main(int argc, char **argv)
 {
        int ch, i, num_mods;
        int verbose = 0, exclude_base = 1, command = SHOW_DEPS;
+       char *program_name = NULL;
        char *basename;
        sepol_module_package_t *base, **mods;
        policydb_t *p;
        hashtab_t req;
+       struct option long_options[] = {
+               {"verbose", no_argument, NULL, 'v'},
+               {"graphviz", no_argument, NULL, 'g'},
+               {"base", no_argument, NULL, 'b'},
+               {"version", no_argument, NULL, 'V'},
+               {"help", no_argument, NULL, 'h'},
+               {NULL, 0, NULL, 0}
+       };
+
+       program_name = opt_program_name(argv[0],
SEMODULE_DEPS_CONF_PROG_NAME);
 
-       while ((ch = getopt(argc, argv, "vgb")) != EOF) {
+       while ((ch = getopt_long(argc, argv, "vgbVh", long_options,
NULL)) !=
-1) {
                switch (ch) {
                case 'v':
                        verbose = 1;
@@ -335,8 +366,15 @@ int main(int argc, char **argv)
                case 'b':
                        exclude_base = 0;
                        break;
+               case 'V':
+                       fprintf(stdout,
+                               " %s version %s.\n", program_name,
VERSION);
+                       exit(EXIT_SUCCESS);
+               case 'h':
+                       usage(program_name);
+                       exit(EXIT_SUCCESS);
                default:
-                       usage(argv[0]);
+                       usage(program_name);
                }
        }
 
@@ -344,16 +382,16 @@ int main(int argc, char **argv)
        if (argc < 3 || !(optind != (argc - 1))) {
                fprintf(stderr,
                        "%s:  You must provide the base module package
and at least one
other module package\n",
-                       argv[0]);
-               usage(argv[0]);
+                       program_name);
+               usage(program_name);
        }
 
        basename = argv[optind++];
-       base = load_module(basename, argv[0]);
+       base = load_module(basename, program_name);
        if (!base) {
                fprintf(stderr,
                        "%s:  Could not load base module from file %s
\n",
-                       argv[0], basename);
+                       program_name, basename);
                exit(1);
        }
 
@@ -362,23 +400,23 @@ int main(int argc, char **argv)
            (sepol_module_package_t **)
malloc(sizeof(sepol_module_package_t
*)
                                               * num_mods);
        if (!mods) {
-               fprintf(stderr, "%s:  Out of memory\n", argv[0]);
+               fprintf(stderr, "%s:  Out of memory\n", program_name);
                exit(1);
        }
        memset(mods, 0, sizeof(sepol_module_package_t *) * num_mods);
 
        for (i = 0; optind < argc; optind++, i++) {
-               mods[i] = load_module(argv[optind], argv[0]);
+               mods[i] = load_module(argv[optind], program_name);
                if (!mods[i]) {
                        fprintf(stderr,
                                "%s:  Could not load module from file %s
\n",
-                               argv[0], argv[optind]);
+                               program_name, argv[optind]);
                        exit(1);
                }
        }
 
        if (sepol_link_packages(NULL, base, mods, num_mods, verbose)) {
-               fprintf(stderr, "%s:  Error while linking packages\n",
argv[0]);
+               fprintf(stderr, "%s:  Error while linking packages\n",
program_name);
                exit(1);
        }
 
diff -pru policycoreutils/semodule_expand/semodule_expand.8
policycoreutils-new/semodule_expand/semodule_expand.8
--- policycoreutils/semodule_expand/semodule_expand.8   2009-11-01
22:23:01.000000000 +0100
+++
policycoreutils-new/semodule_expand/semodule_expand.8       2009-11-02
01:50:05.000000000 +0100
@@ -3,7 +3,7 @@
 semodule_expand \- Expand a SELinux policy module package.
 
 .SH SYNOPSIS
-.B semodule_expand [-V -c [version]] basemodpkg outputfile
+.B semodule_expand -h | [-V] [-v] [-a] [-c version] basemodpkg
outputfile
 .br
 .SH DESCRIPTION
 .PP
@@ -17,11 +17,20 @@ together a set of packages into a single
 
 .SH "OPTIONS"
 .TP
-.B \-V
+.B \-V,\-\-version
 show version
 .TP
-.B \-c [version]
+.B \-v,\-\-verbose
+be verbose
+.TP
+.B \-c,\-\-create version
 policy version to create
+.TP
+.B \-a
+suppress assertions and hierarchy checking
+.TP
+.B \-h,\-\-help
+print usage information
 
 .SH SEE ALSO
 .B checkmodule(8), semodule_package(8), semodule(8), semodule_link(8)
diff -pru policycoreutils/semodule_expand/semodule_expand.c
policycoreutils-new/semodule_expand/semodule_expand.c
--- policycoreutils/semodule_expand/semodule_expand.c   2009-11-01
22:23:01.000000000 +0100
+++
policycoreutils-new/semodule_expand/semodule_expand.c       2009-11-02
01:45:26.000000000 +0100
@@ -30,7 +30,7 @@ int policyvers = 0;
 
 static void usage(char *program_name)
 {
-       printf("usage: %s [-V -a -c [version]] basemodpkg outputfile\n",
+       printf("usage: %s -h | [-V] [-v] [-a] [-c version] basemodpkg
outputfile\n",
               program_name);
        exit(1);
 }
@@ -45,8 +45,15 @@ int main(int argc, char **argv)
        FILE *fp, *outfile;
        int check_assertions = 1;
        sepol_handle_t *handle;
+       struct option long_options[] = {
+               {"version", no_argument, NULL, 'V'},
+               {"verbose", no_argument, NULL, 'v'},
+               {"create", required_argument, NULL, 'c'},
+               {"help", no_argument, NULL, 'h'},
+               {NULL, 0, NULL, 0}
+       };
 
-       while ((ch = getopt(argc, argv, "c:Vva")) != EOF) {
+       while ((ch = getopt_long(argc, argv, "c:Vvha", long_options,
NULL)) !=
-1) {
                switch (ch) {
                case 'V':
                        show_version = 1;
@@ -76,6 +83,8 @@ int main(int argc, char **argv)
                                policyvers = n;
                                break;
                        }
+               case 'h':
+                       usage(argv[0]);
                case 'a':{
                                check_assertions = 0;
                                break;
diff -pru policycoreutils/semodule_link/semodule_link.8
policycoreutils-new/semodule_link/semodule_link.8
--- policycoreutils/semodule_link/semodule_link.8       2009-11-01
22:23:01.000000000 +0100
+++ policycoreutils-new/semodule_link/semodule_link.8   2009-11-02
01:56:07.000000000 +0100
@@ -16,14 +16,17 @@ semodule_package.
 
 .SH "OPTIONS"
 .TP
-.B \-V
+.B \-V,\-\-version
 show version
 .TP
-.B \-v
+.B \-v,\-\-verbose
 verbose mode
 .TP
-.B \-o <output file> 
+.B \-o,\-\-output <output file> 
 Linked policy module package generated by this tool.
+.TP
+.B \-h,\-\-help
+show usage information
 
 
 .SH SEE ALSO
diff -pru policycoreutils/semodule_link/semodule_link.c
policycoreutils-new/semodule_link/semodule_link.c
--- policycoreutils/semodule_link/semodule_link.c       2009-11-01
22:23:01.000000000 +0100
+++ policycoreutils-new/semodule_link/semodule_link.c   2009-11-02
01:54:46.000000000 +0100
@@ -81,10 +81,17 @@ int main(int argc, char **argv)
        sepol_module_package_t *base, **mods;
        FILE *outfile;
        struct sepol_policy_file *pf;
+       struct option long_options[] = {
+               {"version", no_argument, NULL, 'V'},
+               {"verbose", no_argument, NULL, 'v'},
+               {"output", required_argument, NULL, 'o'},
+               {"help", no_argument, NULL, 'h'},
+               {NULL, 0, NULL, 0}
+       };
 
        progname = argv[0];
 
-       while ((ch = getopt(argc, argv, "o:Vv")) != EOF) {
+       while ((ch = getopt_long(argc, argv, "o:Vvh", long_options,
NULL)) !=
-1) {
                switch (ch) {
                case 'V':
                        show_version = 1;
@@ -95,6 +102,7 @@ int main(int argc, char **argv)
                case 'o':
                        outname = optarg;
                        break;
+               case 'h':
                default:
                        usage(argv[0]);
                }
diff -pru policycoreutils/semodule_package/Makefile
policycoreutils-new/semodule_package/Makefile
--- policycoreutils/semodule_package/Makefile   2009-11-01
22:23:01.000000000 +0100
+++ policycoreutils-new/semodule_package/Makefile       2009-11-02
00:05:54.000000000 +0100
@@ -5,8 +5,9 @@ BINDIR ?= $(PREFIX)/bin
 LIBDIR ?= ${PREFIX}/lib
 MANDIR ?= $(PREFIX)/share/man
 
+VERSION = $(shell cat ../VERSION)
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I$(INCLUDEDIR) -DVERSION=\"$(VERSION)\"
 LDLIBS = -lsepol -lselinux -L$(LIBDIR)
 
 all: semodule_package
diff -pru policycoreutils/semodule_package/semodule_package.8
policycoreutils-new/semodule_package/semodule_package.8
--- policycoreutils/semodule_package/semodule_package.8 2009-11-01
22:23:01.000000000 +0100
+++
policycoreutils-new/semodule_package/semodule_package.8     2009-11-02
00:05:54.000000000 +0100
@@ -25,6 +25,12 @@ $ semodule_package -o local.pp -m local.
 
 .SH "OPTIONS"
 .TP
+.B \-h \-\-help
+Print usage information.
+.TP
+.B \-V \-\-version
+Print version information.
+.TP
 .B \-o \-\-outfile <output file> 
 Policy module package file generated by this tool.
 .TP
diff -pru policycoreutils/semodule_package/semodule_package.c
policycoreutils-new/semodule_package/semodule_package.c
--- policycoreutils/semodule_package/semodule_package.c 2009-11-01
22:23:01.000000000 +0100
+++
policycoreutils-new/semodule_package/semodule_package.c     2009-11-02
00:05:54.000000000 +0100
@@ -19,14 +19,18 @@
 #include <fcntl.h>
 #include <errno.h>
 
+#define SEMODULE_PACKAGE_CONF_PROG_NAME "semodule_package"     /*
default
program name */
+
 char *progname = NULL;
 extern char *optarg;
 
 static void usage(char *prog)
 {
-       printf("usage: %s -o <output file> -m <module> [-f <file
contexts>]\n",
+       printf("usage: %s -h | -V | -o <output file> -m <module> [-f
<file
contexts>]\n",
               prog);
        printf("Options:\n");
+       printf("  -h --help             Print this usage
information.\n");
+       printf("  -V --version          Print version information.\n"); 
        printf("  -o --outfile          Output file (required)\n");
        printf("  -m --module           Module file (required)\n");
        printf("  -f --fc               File contexts file\n");
@@ -37,6 +41,23 @@ static void usage(char *prog)
        exit(1);
 }
 
+static char *opt_program_name(char *argv0, char *def)
+{
+       if (argv0) {
+               if ((def = strrchr(argv0, '/')))
+                       ++def;
+               else
+                       def = argv0;
+
+               /* hack for libtool */
+               if ((strlen(def) > strlen("lt-"))
+                   && !memcmp("lt-", def, strlen("lt-")))
+                       def += 3;
+       }
+
+       return (def);
+}
+
 static int file_to_policy_file(char *filename, struct sepol_policy_file
**pf,
                               char *mode)
 {
@@ -107,13 +128,20 @@ int main(int argc, char **argv)
                {"nc", required_argument, NULL, 'n'},
                {"outfile", required_argument, NULL, 'o'},
                {"help", 0, NULL, 'h'},
+               {"version", 0, NULL, 'V'},
                {NULL, 0, NULL, 0}
        };
 
-       while ((i = getopt_long(argc, argv, "m:f:s:u:o:n:h", opts,
NULL)) !=
-1) {
+       progname = opt_program_name(argv[0],
SEMODULE_PACKAGE_CONF_PROG_NAME);
+
+       while ((i = getopt_long(argc, argv, "m:f:s:u:o:n:hV", opts,
NULL)) !=
-1) {
                switch (i) {
+               case 'V':
+                       fprintf(stdout,
+                                " %s version %s.\n", progname,
VERSION);
+                        exit(EXIT_SUCCESS);
                case 'h':
-                       usage(argv[0]);
+                       usage(progname);
                        exit(0);
                case 'm':
                        if (module) {
@@ -178,10 +206,8 @@ int main(int argc, char **argv)
                }
        }
 
-       progname = argv[0];
-
        if (!module || !outfile) {
-               usage(argv[0]);
+               usage(progname);
                exit(0);
        }
 
@@ -209,14 +235,14 @@ int main(int argc, char **argv)
                exit(1);
 
        if (sepol_module_package_create(&pkg)) {
-               fprintf(stderr, "%s:  Out of memory\n", argv[0]);
+               fprintf(stderr, "%s:  Out of memory\n", progname);
                exit(1);
        }
 
        if (sepol_policydb_read(sepol_module_package_get_policy(pkg),
mod)) {
                fprintf(stderr,
                        "%s:  Error while reading policy module from %s
\n",
-                       argv[0], module);
+                       progname, module);
                exit(1);
        }
 
@@ -239,7 +265,7 @@ int main(int argc, char **argv)
        if (sepol_module_package_write(pkg, out)) {
                fprintf(stderr,
                        "%s:  Error while writing module package to %s
\n",
-                       argv[0], argv[1]);
+                       progname, argv[1]);
                exit(1);
        }
 
diff -pru policycoreutils/sestatus/Makefile
policycoreutils-new/sestatus/Makefile
--- policycoreutils/sestatus/Makefile   2009-11-01 22:23:01.000000000
+0100
+++ policycoreutils-new/sestatus/Makefile       2009-11-02
00:05:54.000000000
+0100
@@ -5,8 +5,9 @@ MANDIR = $(PREFIX)/share/man
 ETCDIR ?= $(DESTDIR)/etc
 LIBDIR ?= ${PREFIX}/lib
 
+VERSION = $(shell cat ../VERSION)
 CFLAGS = -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
+override CFLAGS += -I$(PREFIX)/include -DVERSION=\"$(VERSION)\"
-D_FILE_OFFSET_BITS=64
 LDLIBS = -lselinux -L$(LIBDIR)
 
 all: sestatus
diff -pru policycoreutils/sestatus/sestatus.8
policycoreutils-new/sestatus/sestatus.8
--- policycoreutils/sestatus/sestatus.8 2009-11-01 22:23:01.000000000
+0100
+++ policycoreutils-new/sestatus/sestatus.8     2009-11-02
02:00:55.000000000 +0100
@@ -4,7 +4,7 @@ sestatus \- SELinux status tool
 
 .SH "SYNOPSIS"
 .B sestatus
-.I [\-v] [\-b]  
+.I -h | -V | [\-v] [\-b]  
 .P
 This tool is used to get the status of a system running SELinux.
 
@@ -28,12 +28,20 @@ Policy version:         16
 .SH "OPTIONS"
 .TP 
 
-.B \-v
+.B \-h,\-\-help
+.P
+ Print usage information.
+
+.B \-V,\-\-version
+.P
+ Print version information.
+
+.B \-v,\-\-verbose
 .P
  Checks the contexts of a files , and a processes listed in
the /etc/sestatus.conf file.  It also checks the context of the target,
in cases of
 symlinks.
 
-.B \-b
+.B \-b,\-\-show-bools
 .P
 Display the current state of booleans.
 
diff -pru policycoreutils/sestatus/sestatus.c
policycoreutils-new/sestatus/sestatus.c
--- policycoreutils/sestatus/sestatus.c 2009-11-01 22:23:01.000000000
+0100
+++ policycoreutils-new/sestatus/sestatus.c     2009-11-02
02:05:29.000000000 +0100
@@ -15,6 +15,7 @@
 #include <sys/stat.h>
 #include <dirent.h>
 #include <unistd.h>
+#include <getopt.h>
 #include <libgen.h>
 #include <ctype.h>
 
@@ -196,22 +197,38 @@ int main(int argc, char **argv)
        const char *pol_name;
        char *pol_path;
 
+       struct option long_options[] = {
+               {"version", no_argument, NULL, 'V'},
+               {"help", no_argument, NULL, 'h'},
+               {"verbose", no_argument, NULL, 'v'},
+               {"show-bools", no_argument, NULL, 'b'},
+               {NULL, 0, NULL, 0}
+       };
+
        while (1) {
-               opt = getopt(argc, argv, "vb");
+               opt = getopt_long(argc, argv, "vbVh", long_options,
NULL);
                if (opt == -1)
                        break;
                switch (opt) {
+               case 'V':
+                       fprintf(stdout,
+                               " %s version %s.\n", basename(argv[0]),
VERSION);
+                       exit(EXIT_SUCCESS);
                case 'v':
                        verbose = 1;
                        break;
                case 'b':
                        show_bools = 1;
                        break;
+               case 'h':
                default:
                        /* invalid option */
                        printf("\nUsage: %s [OPTION]\n\n",
basename(argv[0]));
+                       printf("  -h,--help     Print this help
message.\n");
+                       printf("  -V,--version     Print version
information.\n");
                        printf
-                           ("  -v  Verbose check of process and file
contexts.\n");
+                           ("  -v,--verbose     Verbose check of
process and file
contexts.\n");
+                       printf("  -b,--show-bools     Display the
current state of
booleans.\n");
                        printf("\nWithout options, show SELinux
status.\n");
                        return -1;
                }
diff -pru policycoreutils/setfiles/Makefile
policycoreutils-new/setfiles/Makefile
--- policycoreutils/setfiles/Makefile   2009-11-01 22:23:01.000000000
+0100
+++ policycoreutils-new/setfiles/Makefile       2009-11-02
00:05:54.000000000
+0100
@@ -5,8 +5,8 @@ MANDIR = $(PREFIX)/share/man
 LIBDIR ?= $(PREFIX)/lib
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 
-CFLAGS = -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include
+VERSION = $(shell cat ../VERSION)
+override CFLAGS += -I$(PREFIX)/include -DVERSION=\"$(VERSION)\"
 LDLIBS = -lselinux -lsepol -L$(LIBDIR)
 
 ifeq (${AUDITH}, /usr/include/libaudit.h)
diff -pru policycoreutils/setfiles/restorecon.8
policycoreutils-new/setfiles/restorecon.8
--- policycoreutils/setfiles/restorecon.8       2009-11-01
22:23:01.000000000
+0100
+++ policycoreutils-new/setfiles/restorecon.8   2009-11-02
02:09:30.000000000 +0100
@@ -22,6 +22,12 @@ new policy, or with the \-n option it ca
 contexts are all as you expect.
 
 .SH "OPTIONS"
+.TP
+.B \-h,\-\-help
+print usage information
+.TP
+.B \-V,\-\-version
+print version information
 .TP 
 .B \-i
 ignore files that do not exist
diff -pru policycoreutils/setfiles/setfiles.8
policycoreutils-new/setfiles/setfiles.8
--- policycoreutils/setfiles/setfiles.8 2009-11-01 22:23:01.000000000
+0100
+++ policycoreutils-new/setfiles/setfiles.8     2009-11-02
02:09:15.000000000 +0100
@@ -19,6 +19,12 @@ new policy, or with the \-n option it ca
 contexts are all as you expect.
 
 .SH "OPTIONS"
+.TP
+.B \-h,\-\-help
+print usage information
+.TP
+.B \-V,\-\-version
+print version information
 .TP 
 .B \-c
 check the validity of the contexts against the specified binary policy.
diff -pru policycoreutils/setfiles/setfiles.c
policycoreutils-new/setfiles/setfiles.c
--- policycoreutils/setfiles/setfiles.c 2009-11-01 22:23:01.000000000
+0100
+++ policycoreutils-new/setfiles/setfiles.c     2009-11-02
02:08:57.000000000 +0100
@@ -8,6 +8,7 @@
 #include <stdio_ext.h>
 #include <string.h>
 #include <errno.h>
+#include <getopt.h>
 #include <ctype.h>
 #include <regex.h>
 #include <sys/vfs.h>
@@ -317,14 +318,18 @@ void usage(const char *const name)
 {
        if (iamrestorecon) {
                fprintf(stderr,
+                       "usage:  %s -h,--help     print this usage
information\n"
+                       "usage:  %s -V,--version     print version
information\n"
                        "usage:  %s [-iFnrRv0] [-e excludedir ] [-o
filename ] [-f filename
| pathname... ]\n",
-                       name);
+                       name, name, name);
        } else {
                fprintf(stderr,
+                       "usage:  %s -h,--help     print this usage
information\n"
+                       "usage:  %s -V,--version     print version
information\n"
                        "usage:  %s [-dnpqvW] [-o filename] [-r
alt_root_path ] spec_file
pathname...\n"
                        "usage:  %s -c policyfile spec_file\n"
                        "usage:  %s -s [-dnqvW] [-o filename ] spec_file
\n", name, name,
-                       name);
+                       name, name, name);
        }
        exit(1);
 }
@@ -809,6 +814,12 @@ int main(int argc, char **argv)
                { SELABEL_OPT_PATH, NULL }
        };
 
+       struct option long_options[] = {
+               {"version", no_argument, NULL, 'V'},
+               {"help", no_argument, NULL, 'h'},
+               {NULL, 0, NULL, 0}
+       };
+
        memset(excludeArray, 0, sizeof(excludeArray));
        altpath = NULL;
 
@@ -866,7 +877,7 @@ int main(int argc, char **argv)
        exclude_non_seclabel_mounts();
 
        /* Process any options. */
-       while ((opt = getopt(argc, argv, "c:de:f:ilnpqrsvo:FRW0")) > 0)
{
+       while ((opt = getopt_long(argc, argv, "c:de:f:hilnpqrsvo:FRVW0",
long_options, NULL)) != -1) {
                switch (opt) {
                case 'c':
                        {
@@ -993,6 +1004,11 @@ int main(int argc, char **argv)
                case '0':
                        null_terminated = 1;
                        break;
+               case 'V':
+                       fprintf(stdout,
+                                " %s version %s.\n", progname,
VERSION);
+                       exit(EXIT_SUCCESS);
+               case 'h':
                case '?':
                        usage(argv[0]);
                }
diff -pru policycoreutils/setsebool/Makefile
policycoreutils-new/setsebool/Makefile
--- policycoreutils/setsebool/Makefile  2009-11-01 22:23:01.000000000
+0100
+++ policycoreutils-new/setsebool/Makefile      2009-11-02
00:05:54.000000000
+0100
@@ -5,8 +5,9 @@ SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
 LIBDIR ?= ${PREFIX}/lib
 
+VERSION = $(shell cat ../VERSION)
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I$(INCLUDEDIR) -DVERSION=\"$(VERSION)\"
 LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
 SETSEBOOL_OBJS = setsebool.o
 
diff -pru policycoreutils/setsebool/setsebool.8
policycoreutils-new/setsebool/setsebool.8
--- policycoreutils/setsebool/setsebool.8       2009-11-01
22:23:01.000000000
+0100
+++ policycoreutils-new/setsebool/setsebool.8   2009-11-02
02:12:43.000000000 +0100
@@ -11,6 +11,17 @@ setsebool \- set SELinux boolean value
 sets the current state of a particular SELinux boolean or a list of
booleans 
 to a given value. The value may be 1 or true or on to enable the
boolean, or 0 or false or off to disable it. 
 
+.SH "OPTIONS"
+.TP
+
+.B \-h,\-\-help
+.P
+ Print usage information.
+
+.B \-V,\-\-version
+.P
+ Print version information.
+
 Without the -P option, only the current boolean value is 
 affected; the boot-time default settings 
 are not changed. 
diff -pru policycoreutils/setsebool/setsebool.c
policycoreutils-new/setsebool/setsebool.c
--- policycoreutils/setsebool/setsebool.c       2009-11-01
22:23:01.000000000
+0100
+++ policycoreutils-new/setsebool/setsebool.c   2009-11-02
02:11:44.000000000 +0100
@@ -5,6 +5,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <errno.h>
+#include <getopt.h>
 #include <syslog.h>
 #include <pwd.h>
 #include <selinux/selinux.h>
@@ -14,38 +15,75 @@
 #include <semanage/boolean_record.h>
 #include <errno.h>
 
+#define SETSEBOOL_CONF_PROG_NAME "setsebool"   /* default program name
*/
+
 int permanent = 0;
 
 int setbool(char **list, size_t start, size_t end);
 
-void usage(void)
+void usage(char *progname)
 {
-       fputs
-           ("\nUsage:  setsebool [ -P ] boolean value | bool1=val1
bool2=val2...\n\n",
-            stderr);
+       fprintf(stderr, "\nUsage:  %s -h | -V | [ -P ] boolean value |
bool1=val1 bool2=val2...\n\n", progname);
        exit(1);
 }
 
+static char *opt_program_name(char *argv0, char *def)
+{
+       if (argv0) {
+               if ((def = strrchr(argv0, '/')))
+                       ++def;
+               else
+                       def = argv0;
+
+               /* hack for libtool */
+               if ((strlen(def) > strlen("lt-"))
+                    && !memcmp("lt-", def, strlen("lt-")))
+                       def += 3;
+       }
+
+       return (def);
+}
+
 int main(int argc, char **argv)
 {
        size_t rc, start;
+       int opt;
+       char *program_name = NULL;
+       struct option long_options[] = {
+               {"help", no_argument, NULL, 'h'},
+               {"version", no_argument, NULL, 'V'},
+               {NULL, 0, NULL, 0}
+       };
+
+       program_name = opt_program_name(argv[0],
SETSEBOOL_CONF_PROG_NAME);
+       start = 1;
+
+       while ((opt = getopt_long(argc, argv, "hPV", long_options,
NULL)) !=
-1) {
+               switch (opt) {
+               case 'V':
+                       fprintf(stdout,
+                               " %s version %s.\n", program_name,
VERSION);
+                       exit(EXIT_SUCCESS);
+               case 'h':
+                       usage(program_name);
+               case 'P':
+                       if (argc < 3)
+                               usage(program_name);
+                       permanent = 1;
+                       start = 2;
+               default:
+                       usage(program_name);
+               }
+       }
 
        if (argc < 2)
-               usage();
+               usage(program_name);
 
        if (is_selinux_enabled() <= 0) {
                fputs("setsebool:  SELinux is disabled.\n", stderr);
                return 1;
        }
 
-       if (strcmp(argv[1], "-P") == 0) {
-               permanent = 1;
-               if (argc < 3)
-                       usage();
-               start = 2;
-       } else
-               start = 1;
-
        /* Check to see which way we are being called. If a '=' is
passed,
           we'll enforce the list syntax. If not we'll enforce the
original
           syntax for backward compatibility. */
@@ -54,7 +92,7 @@ int main(int argc, char **argv)
                char *bool_list[1];
 
                if ((argc - start) != 2)
-                       usage();
+                       usage(program_name);
 
                /* Add 1 for the '=' */
                len = strlen(argv[start]) + strlen(argv[start + 1]) + 2;


--=-S+dr3xlhgmP6mtSH0srn
Content-Disposition: attachment; filename="policycoreutils-ticket1-1672486.patch"
Content-Type: text/x-patch; name="policycoreutils-ticket1-1672486.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

diff -pru policycoreutils/load_policy/load_policy.8 policycoreutils-new/load_policy/load_policy.8
--- policycoreutils/load_policy/load_policy.8	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/load_policy/load_policy.8	2009-11-02 00:40:13.000000000 +0100
@@ -15,11 +15,25 @@ values in the policy file.
 
 .SH "OPTIONS"
 .TP
+.B \-V
+or
+.B \-\-version
+shows the current version of load_policy
+.TP
+.B \-h
+or
+.B \-\-help
+shows the usage information for load_policy
+.TP
 .B \-q
+or
+.B \-\-quiet
 suppress warning messages.
 .TP
 .B \-i
-inital policy load. Only use this if this is the first time policy is being loaded since boot (usually called from initramfs).
+or
+.B \-\-init
+initial policy load. Only use this if this is the first time policy is being loaded since boot (usually called from initramfs).
 
 .SH "EXIT STATUS"
 .TP
diff -pru policycoreutils/load_policy/load_policy.c policycoreutils-new/load_policy/load_policy.c
--- policycoreutils/load_policy/load_policy.c	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/load_policy/load_policy.c	2009-11-02 00:33:56.000000000 +0100
@@ -2,7 +2,7 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <errno.h>
-#include <getopt.h>
+#include <getopt.h>	/* for getopt_long() form of getopt() */
 #include <string.h>
 #include <selinux/selinux.h>
 #include <sepol/sepol.h>
@@ -13,19 +13,49 @@
 #else
 #define _(msgid) (msgid)
 #endif
+#define LOAD_POLICY_CONF_PROG_NAME "load_policy"	 /* default program name */
 #ifndef PACKAGE
 #define PACKAGE "policycoreutils"	/* the name of this package lang translation */
 #endif
 
 void usage(char *progname)
 {
-	fprintf(stderr, _("usage:  %s [-qi]\n"), progname);
+	fprintf(stderr, _("usage:  %s -h | -V | [-qi]\n"), progname);
+	fprintf(stderr, _("         -h     Show this message.\n"));
+	fprintf(stderr, _("         -V     Show the version.\n"));
+	fprintf(stderr, _("         -q     Suppress warning messages.\n"));
+	fprintf(stderr, _("         -i     Inital policy load. Only use this if this is the first time policy is being loaded since boot.\n"));
 	exit(1);
 }
 
+static char *opt_program_name(char *argv0, char *def)
+{
+	if (argv0) {
+		if ((def = strrchr(argv0, '/')))
+			++def;
+		else
+			def = argv0;
+
+		/* hack for libtool */
+		if ((strlen(def) > strlen("lt-"))
+		    && !memcmp("lt-", def, strlen("lt-")))
+			def += 3;
+	}
+
+	return (def);
+}
+
 int main(int argc, char **argv)
 {
 	int ret, opt, quiet = 0, nargs, init=0, enforce=0;
+	char *program_name = NULL;
+        struct option long_options[] = {
+		{"quiet", no_argument, NULL, 'q'},
+		{"init", no_argument, NULL, 'i'},
+		{"version", no_argument, NULL, 'V'},
+                {"help", no_argument, NULL, 'h'},
+		{NULL, 0, NULL, 0}
+	};
 
 #ifdef USE_NLS
 	setlocale(LC_ALL, "");
@@ -33,11 +63,13 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 #endif
 
-	while ((opt = getopt(argc, argv, "bqi")) > 0) {
+	program_name = opt_program_name(argv[0], LOAD_POLICY_CONF_PROG_NAME);
+
+	while ((opt = getopt_long(argc, argv, "bqiVh", long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'b':
 			fprintf(stderr, "%s:  Warning! The -b option is no longer supported, booleans are always preserved across reloads.  Continuing...\n",
-				argv[0]);
+				program_name);
 			break;
 		case 'q':
 			quiet = 1;
@@ -46,8 +78,14 @@ int main(int argc, char **argv)
 		case 'i':
 			init = 1;
 			break;
+		case 'V':
+			fprintf(stdout,
+                                " %s version %s.\n", program_name, VERSION);
+			exit(EXIT_SUCCESS);
+		case 'h':
+			usage(program_name);
 		default:
-			usage(argv[0]);
+			usage(program_name);
 		}
 	}
 
diff -pru policycoreutils/load_policy/Makefile policycoreutils-new/load_policy/Makefile
--- policycoreutils/load_policy/Makefile	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/load_policy/Makefile	2009-11-02 00:05:54.000000000 +0100
@@ -4,8 +4,9 @@ SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 
+VERSION = $(shell cat ../VERSION)
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\"" -DVERSION=\"$(VERSION)\"
 LDLIBS += -lsepol -lselinux -L$(PREFIX)/lib
 
 TARGETS=$(patsubst %.c,%,$(wildcard *.c))
diff -pru policycoreutils/newrole/newrole.1 policycoreutils-new/newrole/newrole.1
--- policycoreutils/newrole/newrole.1	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/newrole/newrole.1	2009-11-02 00:05:54.000000000 +0100
@@ -58,10 +58,16 @@ The new shell will be the shell specifie
 file.
 .PP
 The
+.B -h
+or
+.B --help
+shows the usage information for newrole.
+.PP
+The
 .B -V
 or 
 .B --version
-shows the current version of newrole
+shows the current version of newrole.
 .PP
 .SH EXAMPLE
 .br
diff -pru policycoreutils/newrole/newrole.c policycoreutils-new/newrole/newrole.c
--- policycoreutils/newrole/newrole.c	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/newrole/newrole.c	2009-11-02 00:05:54.000000000 +0100
@@ -10,7 +10,7 @@
  *
  * USAGE:
  *
- * newrole [ -r role ] [ -t type ] [ -l level ] [ -V ] [ -- args ]
+ * newrole -h | -V | [ -r role ] [ -t type ] [ -l level ] [ -- args ]
  *
  * BUILD OPTIONS:
  *
@@ -91,7 +91,7 @@
 #endif
 
 /* USAGE_STRING describes the command-line args of this program. */
-#define USAGE_STRING "USAGE: newrole [ -r role ] [ -t type ] [ -l level ] [ -p ] [ -V ] [ -- args ]"
+#define USAGE_STRING "USAGE: newrole -h | -V | [ -r role ] [ -t type ] [ -l level ] [ -p ] [ -- args ]"
 
 #ifdef USE_PAM
 #define PAM_SERVICE_CONFIG "/etc/selinux/newrole_pam.conf";
@@ -877,21 +877,24 @@ static int parse_command_line_arguments(
 		{"level", 1, 0, 'l'},
 		{"preserve-environment", 0, 0, 'p'},
 		{"version", 0, 0, 'V'},
+		{"help", 0, 0, 'h'},
 		{NULL, 0, 0, 0}
 	};
 
 	*preserve_environment = 0;
 	while (1) {
-		clflag = getopt_long(argc, argv, "r:t:l:pV", long_options,
+		clflag = getopt_long(argc, argv, "r:t:l:pVh", long_options,
 				     &flag_index);
 		if (clflag == -1)
 			break;
 
 		switch (clflag) {
+		case 'h':
+			fprintf(stderr, "%s\n", USAGE_STRING);
+			exit(EXIT_SUCCESS);
 		case 'V':
 			printf("newrole: %s version %s\n", PACKAGE, VERSION);
-			exit(0);
-			break;
+			exit(EXIT_SUCCESS);
 		case 'p':
 			*preserve_environment = 1;
 			break;
diff -pru policycoreutils/restorecond/Makefile policycoreutils-new/restorecond/Makefile
--- policycoreutils/restorecond/Makefile	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/restorecond/Makefile	2009-11-02 00:05:54.000000000 +0100
@@ -5,8 +5,9 @@ MANDIR = $(PREFIX)/share/man
 INITDIR = $(DESTDIR)/etc/rc.d/init.d
 SELINUXDIR = $(DESTDIR)/etc/selinux
 
+VERSION = $(shell cat ../VERSION)
 CFLAGS ?= -g -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
+override CFLAGS += -I$(PREFIX)/include -DVERSION=\"$(VERSION)\" -D_FILE_OFFSET_BITS=64
 LDLIBS += -lselinux -L$(PREFIX)/lib
 
 all: restorecond
diff -pru policycoreutils/restorecond/restorecond.8 policycoreutils-new/restorecond/restorecond.8
--- policycoreutils/restorecond/restorecond.8	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/restorecond/restorecond.8	2009-11-02 00:39:31.000000000 +0100
@@ -3,7 +3,7 @@
 restorecond \- daemon that watches for file creation and then sets the default SELinux file context
 
 .SH "SYNOPSIS"
-.B restorecond  [\-d]
+.B restorecond  [\-d] [\-v] | \-h | \-V
 .P
 
 .SH "DESCRIPTION"
@@ -17,8 +17,25 @@ the correct file context associated with
 .SH "OPTIONS"
 .TP 
 .B \-d
+or
+.B \-\-debug
 Turns on debugging mode.   Application will stay in the foreground and lots of
 debugs messages start printing.
+.TP
+.B \-v
+or
+.B \-\-verbose
+Turns on verbose mode. Missing files are reported.
+.TP
+.B \-h
+or
+.B \-\-help
+Shows the usage information.
+.TP
+.B \-V
+or
+.B \-\-version
+Shows the version information.
 
 .SH "AUTHOR"
 This man page was written by Dan Walsh <dwalsh@redhat.com>.
diff -pru policycoreutils/restorecond/restorecond.c policycoreutils-new/restorecond/restorecond.c
--- policycoreutils/restorecond/restorecond.c	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/restorecond/restorecond.c	2009-11-02 00:42:49.000000000 +0100
@@ -30,8 +30,10 @@
  * and makes sure that there security context matches the systems defaults
  *
  * USAGE:
- * restorecond [-d] [-v]
- * 
+ * restorecond -h | -V | [-d] [-v]
+ *
+ * -h   Shows the usage information
+ * -V   Shows the version
  * -d   Run in debug mode
  * -v   Run in verbose mode (Report missing files)
  *
@@ -48,6 +50,7 @@
 #include <signal.h>
 #include <string.h>
 #include <unistd.h>
+#include <getopt.h>	/* for getopt_long() form of getopt() */
 #include <ctype.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -67,6 +70,8 @@ static int terminate = 0;
 #include <selinux/selinux.h>
 #include <utmp.h>
 
+#define RESTORECOND_CONF_PROG_NAME "restorecond"	/* default program name */
+
 /* size of the event structure, not counting name */
 #define EVENT_SIZE  (sizeof (struct inotify_event))
 /* reasonable guess as to size of 1024 events */
@@ -374,8 +379,25 @@ static void term_handler()
 
 static void usage(char *program)
 {
-	printf("%s [-d] [-v] \n", program);
-	exit(0);
+	printf("%s [-d] [-v] | -h | -V \n", program);
+	exit(EXIT_SUCCESS);
+}
+
+static char *opt_program_name(char *argv0, char *def)
+{
+	if (argv0) {
+		if ((def = strrchr(argv0, '/')))
+			++def;
+		else
+			def = argv0;
+
+		/* hack for libtool */
+		if ((strlen(def) > strlen("lt-"))
+		    && !memcmp("lt-", def, strlen("lt-")))
+			def += 3;
+	}
+
+	return (def);
 }
 
 void exitApp(const char *msg)
@@ -445,6 +467,14 @@ int main(int argc, char **argv)
 {
 	int opt;
 	struct sigaction sa;
+	char *program_name = NULL;
+	struct option long_options[] = {
+		{"help", no_argument, NULL, 'h'},
+		{"version", no_argument, NULL, 'V'},
+		{"debug", no_argument, NULL, 'd'},
+		{"verbose", no_argument, NULL, 'v'},
+		{NULL, 0, NULL, 0}
+	};
 
 #ifndef DEBUG
 	/* Make sure we are root */
@@ -471,8 +501,17 @@ int main(int argc, char **argv)
 	if (master_fd < 0)
 		exitApp("inotify_init");
 
-	while ((opt = getopt(argc, argv, "dv")) > 0) {
+	program_name = opt_program_name(argv[0], RESTORECOND_CONF_PROG_NAME);
+
+	while ((opt = getopt_long(argc, argv, "hVdv", long_options, NULL)) != -1) {
 		switch (opt) {
+		case 'h':
+			usage(program_name);
+			exit(EXIT_SUCCESS);
+		case 'V':
+			fprintf(stdout,
+                                " %s version %s.\n", program_name, VERSION);
+			exit(EXIT_SUCCESS);
 		case 'd':
 			debug_mode = 1;
 			break;
@@ -480,7 +519,7 @@ int main(int argc, char **argv)
 			verbose_mode = 1;
 			break;
 		case '?':
-			usage(argv[0]);
+			usage(program_name);
 		}
 	}
 	read_config(master_fd);
diff -pru policycoreutils/run_init/Makefile policycoreutils-new/run_init/Makefile
--- policycoreutils/run_init/Makefile	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/run_init/Makefile	2009-11-02 00:05:54.000000000 +0100
@@ -8,8 +8,9 @@ LOCALEDIR ?= /usr/share/locale
 PAMH = $(shell ls /usr/include/security/pam_appl.h 2>/dev/null)
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 
+VERSION = $(shell cat ../VERSION)
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\""
+override CFLAGS += -I$(PREFIX)/include -DUSE_NLS -DLOCALEDIR="\"$(LOCALEDIR)\"" -DPACKAGE="\"policycoreutils\"" -DVERSION=\"$(VERSION)\"
 LDLIBS += -lselinux -L$(PREFIX)/lib
 ifeq (${PAMH}, /usr/include/security/pam_appl.h)
 	override CFLAGS += -DUSE_PAM
diff -pru policycoreutils/run_init/run_init.8 policycoreutils-new/run_init/run_init.8
--- policycoreutils/run_init/run_init.8	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/run_init/run_init.8	2009-11-02 01:18:22.000000000 +0100
@@ -3,12 +3,19 @@
 run_init \- run an init script in the proper SELinux context
 .SH SYNOPSIS
 .B run_init 
-\fISCRIPT\fR [[\fIARGS\fR]...] 
+\fISCRIPT\fR [[\fIARGS\fR]...] | -h | -V 
 .br
 .SH DESCRIPTION
 .PP
 Run a init script under the proper context, which is specified in 
 /etc/selinux/POLICYTYPE/contexts/initrc_context.
+.SH OPTIONS
+.TP
+.B \-h,\-\-help
+Print the help message.
+.TP
+.B \-V,\-\-version
+Print the version information.
 .SH FILES
 /etc/passwd - user account information
 .br
diff -pru policycoreutils/run_init/run_init.c policycoreutils-new/run_init/run_init.c
--- policycoreutils/run_init/run_init.c	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/run_init/run_init.c	2009-11-02 01:18:27.000000000 +0100
@@ -8,7 +8,7 @@
  *
  * USAGE:
  *
- * run_init <script> <args>
+ * run_init <script> <args> | -h | -V
  *
  * BUILD OPTIONS:
  *
@@ -60,13 +60,17 @@
 #else
 #define _(msgid) (msgid)
 #endif
+#define RUN_INIT_CONF_PROG_NAME "run_init"	/* default program name */
 #ifndef PACKAGE
 #define PACKAGE "policycoreutils"	/* the name of this package lang translation */
 #endif
 /* USAGE_STRING describes the command-line args of this program. */
-#define USAGE_STRING _("USAGE: run_init <script> <args ...>\n\
+#define USAGE_STRING _("USAGE: run_init <script> <args ...> | -h | -V\n\
   where: <script> is the name of the init script to run,\n\
-         <args ...> are the arguments to that script.")
+         <args ...> are the arguments to that script.\n\
+  or:\n\
+         -h or --help     Print this usage information.\n\
+         -V or --version    Print version information.\n")
 
 #define CONTEXT_FILE "initrc_context"
 #ifdef USE_PAM
@@ -289,7 +293,7 @@ int authenticate_user()
 /*
  * get_init_context()
  *
- * Get the CONTEXT associated with the context for the init scripts.             *
+ * Get the CONTEXT associated with the context for the init scripts.
  *
  * in:		nothing
  * out:		The CONTEXT associated with the context.
@@ -338,15 +342,48 @@ int get_init_context(security_context_t 
 
 }				/* get_init_context() */
 
+/*
+ * opt_program_name()
+ * 
+ * Find out exactly what the program name is
+ *
+ * in:
+ *              argv0  --  argv[0] from main
+ *              def   --   default program name
+ * out:         The exact program name to print out in usage and version information 
+ */
+static char *opt_program_name(char *argv0, char *def)
+{
+	if (argv0) {
+		if ((def = strrchr(argv0, '/')))
+			++def;
+		else
+			def = argv0;
+
+		/* hack for libtool */
+		if ((strlen(def) > strlen("lt-"))
+		    && !memcmp("lt-", def, strlen("lt-")))
+			def += 3;
+	}
+
+	return (def);
+}
+
 /*****************************************************************************
  * main()                                                                    *
  *****************************************************************************/
 int main(int argc, char *argv[])
 {
-
+	int opt;
+	char *program_name = NULL;
 	extern char *optarg;	/* used by getopt() for arg strings */
 	extern int opterr;	/* controls getopt() error messages */
 	security_context_t new_context;	/* context for the init script context  */
+	struct option long_options[] = {
+		{"version", no_argument, NULL, 'V'},
+		{"help", no_argument, NULL, 'h'},
+		{NULL, 0, NULL, 0}
+	};
 
 #ifdef USE_NLS
 	setlocale(LC_ALL, "");
@@ -366,8 +403,27 @@ int main(int argc, char *argv[])
 	 * Step 1:  Handle command-line arguments. The first argument is the 
 	 * name of the script to run. All other arguments are for the script
 	 * itself, and will be passed directly to the script.
+	 * Request for help or version information are handled accordingly
+	 * here.
 	 */
 
+	program_name = opt_program_name(argv[0], RUN_INIT_CONF_PROG_NAME);
+
+	while ((opt = getopt_long(argc, argv, "Vh", long_options, NULL)) != -1) {
+		switch (opt) {
+		case 'V':
+			fprintf(stdout,
+				" %s version %s.\n", program_name, VERSION);
+			exit(EXIT_SUCCESS);
+		case 'h':
+			fprintf(stderr, "%s\n", USAGE_STRING);
+			exit(EXIT_SUCCESS);
+		default:
+			fprintf(stderr, "%s\n", USAGE_STRING);
+			exit(-1);
+		}
+	}
+
 	if (argc < 2) {
 		fprintf(stderr, "%s\n", USAGE_STRING);
 		exit(-1);
diff -pru policycoreutils/semodule/Makefile policycoreutils-new/semodule/Makefile
--- policycoreutils/semodule/Makefile	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/semodule/Makefile	2009-11-02 00:52:25.000000000 +0100
@@ -5,8 +5,9 @@ SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
 LIBDIR ?= ${PREFIX}/lib
 
+VERSION = $(shell cat ../VERSION)
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I$(INCLUDEDIR) -DVERSION=\"$(VERSION)\"
 LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
 SEMODULE_OBJS = semodule.o
 
diff -pru policycoreutils/semodule/semodule.8 policycoreutils-new/semodule/semodule.8
--- policycoreutils/semodule/semodule.8	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/semodule/semodule.8	2009-11-02 01:17:48.000000000 +0100
@@ -52,6 +52,9 @@ prints help message and quit
 .TP
 .B  \-v,\-\-verbose     
 be verbose
+.TP
+.B  \-V,\-\-version
+shows the version information
 
 .SH EXAMPLE
 .nf
diff -pru policycoreutils/semodule/semodule.c policycoreutils-new/semodule/semodule.c
--- policycoreutils/semodule/semodule.c	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/semodule/semodule.c	2009-11-02 01:25:33.000000000 +0100
@@ -22,6 +22,8 @@
 
 #include <semanage/modules.h>
 
+#define SEMODULE_CONF_PROG_NAME "semodule"	/* default program name */
+
 enum client_modes { NO_MODE, INSTALL_M, UPGRADE_M, BASE_M, REMOVE_M,
 	LIST_M, RELOAD
 };
@@ -49,6 +51,8 @@ static int disable_dontaudit;
 static semanage_handle_t *sh = NULL;
 static char *store;
 
+char *program_name = NULL;
+
 extern char *optarg;
 extern int optind;
 
@@ -114,9 +118,28 @@ static void usage(char *progname)
 	printf("  -n,--noreload	   do not reload policy after commit\n");
 	printf("  -h,--help        print this message and quit\n");
 	printf("  -v,--verbose     be verbose\n");
+	printf("  -V,--version     print version information\n");
 	printf("  -D,--disable_dontaudit	Remove dontaudits from policy\n");
 }
 
+/* Gets the exact program name. */
+static char *opt_program_name(char *argv0, char *def)
+{
+	if (argv0) {
+		if ((def = strrchr(argv0, '/')))
+			++def;
+		else
+			def = argv0;
+
+		/* hack for libtool */
+		if ((strlen(def) > strlen("lt-"))
+		    && !memcmp("lt-", def, strlen("lt-")))
+			def += 3;
+	}
+
+	return (def);
+}
+
 /* Sets the global mode variable to new_mode, but only if no other
  * mode has been given. */
 static void set_mode(enum client_modes new_mode, char *arg)
@@ -152,6 +175,7 @@ static void parse_command_line(int argc,
 		{"install", required_argument, NULL, 'i'},
 		{"list-modules", 0, NULL, 'l'},
 		{"verbose", 0, NULL, 'v'},
+		{"version", 0, NULL, 'V'},
 		{"remove", required_argument, NULL, 'r'},
 		{"upgrade", required_argument, NULL, 'u'},
 		{"reload", 0, NULL, 'R'},
@@ -166,7 +190,7 @@ static void parse_command_line(int argc,
 	no_reload = 0;
 	create_store = 0;
 	while ((i =
-		getopt_long(argc, argv, "s:b:hi:lvqr:u:RnBD", opts,
+		getopt_long(argc, argv, "s:b:hi:lvVqr:u:RnBD", opts,
 			    NULL)) != -1) {
 		switch (i) {
 		case 'b':
@@ -174,7 +198,7 @@ static void parse_command_line(int argc,
 			create_store = 1;
 			break;
 		case 'h':
-			usage(argv[0]);
+			usage(program_name);
 			exit(0);
 		case 'i':
 			set_mode(INSTALL_M, optarg);
@@ -185,6 +209,10 @@ static void parse_command_line(int argc,
 		case 'v':
 			verbose = 1;
 			break;
+		case 'V':
+			fprintf(stdout,
+                                " %s version %s.\n", program_name, VERSION);
+                        exit(EXIT_SUCCESS);
 		case 'r':
 			set_mode(REMOVE_M, optarg);
 			break;
@@ -208,7 +236,7 @@ static void parse_command_line(int argc,
 			break;
 		case '?':
 		default:{
-				usage(argv[0]);
+				usage(program_name);
 				exit(1);
 			}
 		}
@@ -216,12 +244,12 @@ static void parse_command_line(int argc,
 	if ((build || reload) && num_commands) {
 		fprintf(stderr,
 			"build or reload should not be used with other commands\n");
-		usage(argv[0]);
+		usage(program_name);
 		exit(1);
 	}
 	if (num_commands == 0 && reload == 0 && build == 0) {
 		fprintf(stderr, "At least one mode must be specified.\n");
-		usage(argv[0]);
+		usage(program_name);
 		exit(1);
 	}
 
@@ -243,7 +271,7 @@ static void parse_command_line(int argc,
 			while (optind < argc)
 				fprintf(stderr, " %s", argv[optind++]);
 			fprintf(stderr, "\n\n");
-			usage(argv[0]);
+			usage(program_name);
 			exit(1);
 		}
 		while (optind < argc)
@@ -257,6 +285,8 @@ int main(int argc, char *argv[])
 	int result;
 	int status = EXIT_FAILURE;
 
+	program_name = opt_program_name(argv[0], SEMODULE_CONF_PROG_NAME);
+
 	create_signal_handlers();
 	parse_command_line(argc, argv);
 
@@ -266,7 +296,7 @@ int main(int argc, char *argv[])
 	sh = semanage_handle_create();
 	if (!sh) {
 		fprintf(stderr, "%s:  Could not create semanage handle\n",
-			argv[0]);
+			program_name);
 		goto cleanup_nohandle;
 	}
 
@@ -285,27 +315,27 @@ int main(int argc, char *argv[])
 		if (!semanage_is_managed(sh)) {
 			fprintf(stderr,
 				"%s: SELinux policy is not managed or store cannot be accessed.\n",
-				argv[0]);
+				program_name);
 			goto cleanup;
 		}
 
 		if (semanage_access_check(sh) < SEMANAGE_CAN_READ) {
 			fprintf(stderr, "%s: Cannot read policy store.\n",
-				argv[0]);
+				program_name);
 			goto cleanup;
 		}
 	}
 
 	if ((result = semanage_connect(sh)) < 0) {
 		fprintf(stderr, "%s:  Could not connect to policy handler\n",
-			argv[0]);
+			program_name);
 		goto cleanup;
 	}
 
 	if (reload) {
 		if ((result = semanage_reload_policy(sh)) < 0) {
 			fprintf(stderr, "%s:  Could not reload policy\n",
-				argv[0]);
+				program_name);
 			goto cleanup;
 		}
 	}
@@ -313,7 +343,7 @@ int main(int argc, char *argv[])
 	if (build) {
 		if ((result = semanage_begin_transaction(sh)) < 0) {
 			fprintf(stderr, "%s:  Could not begin transaction:  %s\n",
-				argv[0], errno ? strerror(errno) : "");
+				program_name, errno ? strerror(errno) : "");
 			goto cleanup;
 		}
 	}
@@ -397,14 +427,14 @@ int main(int argc, char *argv[])
 		default:{
 				fprintf(stderr,
 					"%s:  Unknown mode specified.\n",
-					argv[0]);
-				usage(argv[0]);
+					program_name);
+				usage(program_name);
 				goto cleanup;
 			}
 		}
 		commit += do_commit[mode];
 		if (result < 0) {
-			fprintf(stderr, "%s:  Failed on %s!\n", argv[0],
+			fprintf(stderr, "%s:  Failed on %s!\n", program_name,
 				mode_arg ? : "list");
 			goto cleanup;
 		} else if (verbose) {
@@ -428,14 +458,14 @@ int main(int argc, char *argv[])
 	}
 
 	if (result < 0) {
-		fprintf(stderr, "%s:  Failed!\n", argv[0]);
+		fprintf(stderr, "%s:  Failed!\n", program_name);
 		goto cleanup;
 	} else if (commit && verbose) {
 		printf("Ok: transaction number %d.\n", result);
 	}
 
 	if (semanage_disconnect(sh) < 0) {
-		fprintf(stderr, "%s:  Error disconnecting\n", argv[0]);
+		fprintf(stderr, "%s:  Error disconnecting\n", program_name);
 		goto cleanup;
 	}
 	status = EXIT_SUCCESS;
@@ -443,7 +473,7 @@ int main(int argc, char *argv[])
       cleanup:
 	if (semanage_is_connected(sh)) {
 		if (semanage_disconnect(sh) < 0) {
-			fprintf(stderr, "%s:  Error disconnecting\n", argv[0]);
+			fprintf(stderr, "%s:  Error disconnecting\n", program_name);
 		}
 	}
 	semanage_handle_destroy(sh);
diff -pru policycoreutils/semodule_deps/Makefile policycoreutils-new/semodule_deps/Makefile
--- policycoreutils/semodule_deps/Makefile	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/semodule_deps/Makefile	2009-11-02 00:05:54.000000000 +0100
@@ -5,8 +5,9 @@ BINDIR ?= $(PREFIX)/bin
 LIBDIR ?= ${PREFIX}/lib
 MANDIR ?= $(PREFIX)/share/man
 
+VERSION = $(shell cat ../VERSION)
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I$(INCLUDEDIR) -DVERSION=\"$(VERSION)\"
 LDLIBS = $(LIBDIR)/libsepol.a
 
 all: semodule_deps
diff -pru policycoreutils/semodule_deps/semodule_deps.8 policycoreutils-new/semodule_deps/semodule_deps.8
--- policycoreutils/semodule_deps/semodule_deps.8	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/semodule_deps/semodule_deps.8	2009-11-02 01:23:02.000000000 +0100
@@ -29,14 +29,20 @@ dependencies.
 
 .SH "OPTIONS"
 .TP
-.B \-v
+.B \-v,\-\-verbose
 verbose mode
 .TP
-.B \-g
+.B \-g,\-\-graphviz
 output dependency information in Graphviz dot format
 .TP
-.B \-b
+.B \-b,\-\-base
 include dependencies to the base module - by default these are excluded
+.TP
+.B \-h,\-\-help
+print usage information
+.TP
+.B \-V,\-\-version
+print version information
 
 .SH SEE ALSO
 .B checkmodule(8), semodule_package(8), semodule(8), semodule_link(8)
diff -pru policycoreutils/semodule_deps/semodule_deps.c policycoreutils-new/semodule_deps/semodule_deps.c
--- policycoreutils/semodule_deps/semodule_deps.c	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/semodule_deps/semodule_deps.c	2009-11-02 01:27:56.000000000 +0100
@@ -35,6 +35,8 @@
 extern char *optarg;
 extern int optind;
 
+#define SEMODULE_DEPS_CONF_PROG_NAME "semodule_deps"	/* default program name */
+
 /* This is really a horrible hack, but the base module
  * is referred to with the following name. The same
  * thing is done in the linker for displaying error
@@ -44,11 +46,29 @@ extern int optind;
 
 static void usage(char *program_name)
 {
-	printf("usage: %s [-v -g -b] basemodpkg modpkg1 [modpkg2 ... ]\n",
+	printf("usage: %s -h | -V | [-v] [-g] [-b] basemodpkg modpkg1 [modpkg2 ... ]\n",
 	       program_name);
 	exit(1);
 }
 
+/* Get the exact program name */
+static char *opt_program_name(char *argv0, char *def)
+{
+	if (argv0) {
+		if ((def = strrchr(argv0, '/')))
+			++def;
+		else
+			def = argv0;
+
+		/* hack for libtool */
+		if ((strlen(def) > strlen("lt-"))
+		     && !memcmp("lt-", def, strlen("lt-")))
+			def += 3;
+	}
+
+	return (def);
+}
+
 /* Basic string hash and compare for the hashtables used in
  * generate_requires. Copied from symtab.c.
  */
@@ -319,12 +339,23 @@ int main(int argc, char **argv)
 {
 	int ch, i, num_mods;
 	int verbose = 0, exclude_base = 1, command = SHOW_DEPS;
+	char *program_name = NULL;
 	char *basename;
 	sepol_module_package_t *base, **mods;
 	policydb_t *p;
 	hashtab_t req;
+	struct option long_options[] = {
+		{"verbose", no_argument, NULL, 'v'},
+		{"graphviz", no_argument, NULL, 'g'},
+		{"base", no_argument, NULL, 'b'},
+		{"version", no_argument, NULL, 'V'},
+		{"help", no_argument, NULL, 'h'},
+		{NULL, 0, NULL, 0}
+	};
+
+	program_name = opt_program_name(argv[0], SEMODULE_DEPS_CONF_PROG_NAME);
 
-	while ((ch = getopt(argc, argv, "vgb")) != EOF) {
+	while ((ch = getopt_long(argc, argv, "vgbVh", long_options, NULL)) != -1) {
 		switch (ch) {
 		case 'v':
 			verbose = 1;
@@ -335,8 +366,15 @@ int main(int argc, char **argv)
 		case 'b':
 			exclude_base = 0;
 			break;
+		case 'V':
+			fprintf(stdout,
+				" %s version %s.\n", program_name, VERSION);
+			exit(EXIT_SUCCESS);
+		case 'h':
+			usage(program_name);
+			exit(EXIT_SUCCESS);
 		default:
-			usage(argv[0]);
+			usage(program_name);
 		}
 	}
 
@@ -344,16 +382,16 @@ int main(int argc, char **argv)
 	if (argc < 3 || !(optind != (argc - 1))) {
 		fprintf(stderr,
 			"%s:  You must provide the base module package and at least one other module package\n",
-			argv[0]);
-		usage(argv[0]);
+			program_name);
+		usage(program_name);
 	}
 
 	basename = argv[optind++];
-	base = load_module(basename, argv[0]);
+	base = load_module(basename, program_name);
 	if (!base) {
 		fprintf(stderr,
 			"%s:  Could not load base module from file %s\n",
-			argv[0], basename);
+			program_name, basename);
 		exit(1);
 	}
 
@@ -362,23 +400,23 @@ int main(int argc, char **argv)
 	    (sepol_module_package_t **) malloc(sizeof(sepol_module_package_t *)
 					       * num_mods);
 	if (!mods) {
-		fprintf(stderr, "%s:  Out of memory\n", argv[0]);
+		fprintf(stderr, "%s:  Out of memory\n", program_name);
 		exit(1);
 	}
 	memset(mods, 0, sizeof(sepol_module_package_t *) * num_mods);
 
 	for (i = 0; optind < argc; optind++, i++) {
-		mods[i] = load_module(argv[optind], argv[0]);
+		mods[i] = load_module(argv[optind], program_name);
 		if (!mods[i]) {
 			fprintf(stderr,
 				"%s:  Could not load module from file %s\n",
-				argv[0], argv[optind]);
+				program_name, argv[optind]);
 			exit(1);
 		}
 	}
 
 	if (sepol_link_packages(NULL, base, mods, num_mods, verbose)) {
-		fprintf(stderr, "%s:  Error while linking packages\n", argv[0]);
+		fprintf(stderr, "%s:  Error while linking packages\n", program_name);
 		exit(1);
 	}
 
diff -pru policycoreutils/semodule_expand/semodule_expand.8 policycoreutils-new/semodule_expand/semodule_expand.8
--- policycoreutils/semodule_expand/semodule_expand.8	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/semodule_expand/semodule_expand.8	2009-11-02 01:50:05.000000000 +0100
@@ -3,7 +3,7 @@
 semodule_expand \- Expand a SELinux policy module package.
 
 .SH SYNOPSIS
-.B semodule_expand [-V -c [version]] basemodpkg outputfile
+.B semodule_expand -h | [-V] [-v] [-a] [-c version] basemodpkg outputfile
 .br
 .SH DESCRIPTION
 .PP
@@ -17,11 +17,20 @@ together a set of packages into a single
 
 .SH "OPTIONS"
 .TP
-.B \-V
+.B \-V,\-\-version
 show version
 .TP
-.B \-c [version]
+.B \-v,\-\-verbose
+be verbose
+.TP
+.B \-c,\-\-create version
 policy version to create
+.TP
+.B \-a
+suppress assertions and hierarchy checking
+.TP
+.B \-h,\-\-help
+print usage information
 
 .SH SEE ALSO
 .B checkmodule(8), semodule_package(8), semodule(8), semodule_link(8)
diff -pru policycoreutils/semodule_expand/semodule_expand.c policycoreutils-new/semodule_expand/semodule_expand.c
--- policycoreutils/semodule_expand/semodule_expand.c	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/semodule_expand/semodule_expand.c	2009-11-02 01:45:26.000000000 +0100
@@ -30,7 +30,7 @@ int policyvers = 0;
 
 static void usage(char *program_name)
 {
-	printf("usage: %s [-V -a -c [version]] basemodpkg outputfile\n",
+	printf("usage: %s -h | [-V] [-v] [-a] [-c version] basemodpkg outputfile\n",
 	       program_name);
 	exit(1);
 }
@@ -45,8 +45,15 @@ int main(int argc, char **argv)
 	FILE *fp, *outfile;
 	int check_assertions = 1;
 	sepol_handle_t *handle;
+	struct option long_options[] = {
+		{"version", no_argument, NULL, 'V'},
+		{"verbose", no_argument, NULL, 'v'},
+		{"create", required_argument, NULL, 'c'},
+		{"help", no_argument, NULL, 'h'},
+		{NULL, 0, NULL, 0}
+	};
 
-	while ((ch = getopt(argc, argv, "c:Vva")) != EOF) {
+	while ((ch = getopt_long(argc, argv, "c:Vvha", long_options, NULL)) != -1) {
 		switch (ch) {
 		case 'V':
 			show_version = 1;
@@ -76,6 +83,8 @@ int main(int argc, char **argv)
 				policyvers = n;
 				break;
 			}
+		case 'h':
+			usage(argv[0]);
 		case 'a':{
 				check_assertions = 0;
 				break;
diff -pru policycoreutils/semodule_link/semodule_link.8 policycoreutils-new/semodule_link/semodule_link.8
--- policycoreutils/semodule_link/semodule_link.8	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/semodule_link/semodule_link.8	2009-11-02 01:56:07.000000000 +0100
@@ -16,14 +16,17 @@ semodule_package.
 
 .SH "OPTIONS"
 .TP
-.B \-V
+.B \-V,\-\-version
 show version
 .TP
-.B \-v
+.B \-v,\-\-verbose
 verbose mode
 .TP
-.B \-o <output file> 
+.B \-o,\-\-output <output file> 
 Linked policy module package generated by this tool.
+.TP
+.B \-h,\-\-help
+show usage information
 
 
 .SH SEE ALSO
diff -pru policycoreutils/semodule_link/semodule_link.c policycoreutils-new/semodule_link/semodule_link.c
--- policycoreutils/semodule_link/semodule_link.c	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/semodule_link/semodule_link.c	2009-11-02 01:54:46.000000000 +0100
@@ -81,10 +81,17 @@ int main(int argc, char **argv)
 	sepol_module_package_t *base, **mods;
 	FILE *outfile;
 	struct sepol_policy_file *pf;
+	struct option long_options[] = {
+		{"version", no_argument, NULL, 'V'},
+		{"verbose", no_argument, NULL, 'v'},
+		{"output", required_argument, NULL, 'o'},
+		{"help", no_argument, NULL, 'h'},
+		{NULL, 0, NULL, 0}
+	};
 
 	progname = argv[0];
 
-	while ((ch = getopt(argc, argv, "o:Vv")) != EOF) {
+	while ((ch = getopt_long(argc, argv, "o:Vvh", long_options, NULL)) != -1) {
 		switch (ch) {
 		case 'V':
 			show_version = 1;
@@ -95,6 +102,7 @@ int main(int argc, char **argv)
 		case 'o':
 			outname = optarg;
 			break;
+		case 'h':
 		default:
 			usage(argv[0]);
 		}
diff -pru policycoreutils/semodule_package/Makefile policycoreutils-new/semodule_package/Makefile
--- policycoreutils/semodule_package/Makefile	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/semodule_package/Makefile	2009-11-02 00:05:54.000000000 +0100
@@ -5,8 +5,9 @@ BINDIR ?= $(PREFIX)/bin
 LIBDIR ?= ${PREFIX}/lib
 MANDIR ?= $(PREFIX)/share/man
 
+VERSION = $(shell cat ../VERSION)
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I$(INCLUDEDIR) -DVERSION=\"$(VERSION)\"
 LDLIBS = -lsepol -lselinux -L$(LIBDIR)
 
 all: semodule_package
diff -pru policycoreutils/semodule_package/semodule_package.8 policycoreutils-new/semodule_package/semodule_package.8
--- policycoreutils/semodule_package/semodule_package.8	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/semodule_package/semodule_package.8	2009-11-02 00:05:54.000000000 +0100
@@ -25,6 +25,12 @@ $ semodule_package -o local.pp -m local.
 
 .SH "OPTIONS"
 .TP
+.B \-h \-\-help
+Print usage information.
+.TP
+.B \-V \-\-version
+Print version information.
+.TP
 .B \-o \-\-outfile <output file> 
 Policy module package file generated by this tool.
 .TP
diff -pru policycoreutils/semodule_package/semodule_package.c policycoreutils-new/semodule_package/semodule_package.c
--- policycoreutils/semodule_package/semodule_package.c	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/semodule_package/semodule_package.c	2009-11-02 00:05:54.000000000 +0100
@@ -19,14 +19,18 @@
 #include <fcntl.h>
 #include <errno.h>
 
+#define SEMODULE_PACKAGE_CONF_PROG_NAME "semodule_package"	/* default program name */
+
 char *progname = NULL;
 extern char *optarg;
 
 static void usage(char *prog)
 {
-	printf("usage: %s -o <output file> -m <module> [-f <file contexts>]\n",
+	printf("usage: %s -h | -V | -o <output file> -m <module> [-f <file contexts>]\n",
 	       prog);
 	printf("Options:\n");
+	printf("  -h --help             Print this usage information.\n");
+	printf("  -V --version          Print version information.\n"); 
 	printf("  -o --outfile		Output file (required)\n");
 	printf("  -m --module		Module file (required)\n");
 	printf("  -f --fc		File contexts file\n");
@@ -37,6 +41,23 @@ static void usage(char *prog)
 	exit(1);
 }
 
+static char *opt_program_name(char *argv0, char *def)
+{
+	if (argv0) {
+		if ((def = strrchr(argv0, '/')))
+			++def;
+		else
+			def = argv0;
+
+		/* hack for libtool */
+		if ((strlen(def) > strlen("lt-"))
+		    && !memcmp("lt-", def, strlen("lt-")))
+			def += 3;
+	}
+
+	return (def);
+}
+
 static int file_to_policy_file(char *filename, struct sepol_policy_file **pf,
 			       char *mode)
 {
@@ -107,13 +128,20 @@ int main(int argc, char **argv)
 		{"nc", required_argument, NULL, 'n'},
 		{"outfile", required_argument, NULL, 'o'},
 		{"help", 0, NULL, 'h'},
+		{"version", 0, NULL, 'V'},
 		{NULL, 0, NULL, 0}
 	};
 
-	while ((i = getopt_long(argc, argv, "m:f:s:u:o:n:h", opts, NULL)) != -1) {
+	progname = opt_program_name(argv[0], SEMODULE_PACKAGE_CONF_PROG_NAME);
+
+	while ((i = getopt_long(argc, argv, "m:f:s:u:o:n:hV", opts, NULL)) != -1) {
 		switch (i) {
+		case 'V':
+			fprintf(stdout,
+                                " %s version %s.\n", progname, VERSION);
+                        exit(EXIT_SUCCESS);
 		case 'h':
-			usage(argv[0]);
+			usage(progname);
 			exit(0);
 		case 'm':
 			if (module) {
@@ -178,10 +206,8 @@ int main(int argc, char **argv)
 		}
 	}
 
-	progname = argv[0];
-
 	if (!module || !outfile) {
-		usage(argv[0]);
+		usage(progname);
 		exit(0);
 	}
 
@@ -209,14 +235,14 @@ int main(int argc, char **argv)
 		exit(1);
 
 	if (sepol_module_package_create(&pkg)) {
-		fprintf(stderr, "%s:  Out of memory\n", argv[0]);
+		fprintf(stderr, "%s:  Out of memory\n", progname);
 		exit(1);
 	}
 
 	if (sepol_policydb_read(sepol_module_package_get_policy(pkg), mod)) {
 		fprintf(stderr,
 			"%s:  Error while reading policy module from %s\n",
-			argv[0], module);
+			progname, module);
 		exit(1);
 	}
 
@@ -239,7 +265,7 @@ int main(int argc, char **argv)
 	if (sepol_module_package_write(pkg, out)) {
 		fprintf(stderr,
 			"%s:  Error while writing module package to %s\n",
-			argv[0], argv[1]);
+			progname, argv[1]);
 		exit(1);
 	}
 
diff -pru policycoreutils/sestatus/Makefile policycoreutils-new/sestatus/Makefile
--- policycoreutils/sestatus/Makefile	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/sestatus/Makefile	2009-11-02 00:05:54.000000000 +0100
@@ -5,8 +5,9 @@ MANDIR = $(PREFIX)/share/man
 ETCDIR ?= $(DESTDIR)/etc
 LIBDIR ?= ${PREFIX}/lib
 
+VERSION = $(shell cat ../VERSION)
 CFLAGS = -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
+override CFLAGS += -I$(PREFIX)/include -DVERSION=\"$(VERSION)\" -D_FILE_OFFSET_BITS=64
 LDLIBS = -lselinux -L$(LIBDIR)
 
 all: sestatus
diff -pru policycoreutils/sestatus/sestatus.8 policycoreutils-new/sestatus/sestatus.8
--- policycoreutils/sestatus/sestatus.8	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/sestatus/sestatus.8	2009-11-02 02:00:55.000000000 +0100
@@ -4,7 +4,7 @@ sestatus \- SELinux status tool
 
 .SH "SYNOPSIS"
 .B sestatus
-.I [\-v] [\-b]  
+.I -h | -V | [\-v] [\-b]  
 .P
 This tool is used to get the status of a system running SELinux.
 
@@ -28,12 +28,20 @@ Policy version:         16
 .SH "OPTIONS"
 .TP 
 
-.B \-v
+.B \-h,\-\-help
+.P
+ Print usage information.
+
+.B \-V,\-\-version
+.P
+ Print version information.
+
+.B \-v,\-\-verbose
 .P
  Checks the contexts of a files , and a processes listed in the /etc/sestatus.conf file.  It also checks the context of the target, in cases of
 symlinks.
 
-.B \-b
+.B \-b,\-\-show-bools
 .P
 Display the current state of booleans.
 
diff -pru policycoreutils/sestatus/sestatus.c policycoreutils-new/sestatus/sestatus.c
--- policycoreutils/sestatus/sestatus.c	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/sestatus/sestatus.c	2009-11-02 02:05:29.000000000 +0100
@@ -15,6 +15,7 @@
 #include <sys/stat.h>
 #include <dirent.h>
 #include <unistd.h>
+#include <getopt.h>
 #include <libgen.h>
 #include <ctype.h>
 
@@ -196,22 +197,38 @@ int main(int argc, char **argv)
 	const char *pol_name;
 	char *pol_path;
 
+	struct option long_options[] = {
+		{"version", no_argument, NULL, 'V'},
+		{"help", no_argument, NULL, 'h'},
+		{"verbose", no_argument, NULL, 'v'},
+		{"show-bools", no_argument, NULL, 'b'},
+		{NULL, 0, NULL, 0}
+	};
+
 	while (1) {
-		opt = getopt(argc, argv, "vb");
+		opt = getopt_long(argc, argv, "vbVh", long_options, NULL);
 		if (opt == -1)
 			break;
 		switch (opt) {
+		case 'V':
+			fprintf(stdout,
+				" %s version %s.\n", basename(argv[0]), VERSION);
+			exit(EXIT_SUCCESS);
 		case 'v':
 			verbose = 1;
 			break;
 		case 'b':
 			show_bools = 1;
 			break;
+		case 'h':
 		default:
 			/* invalid option */
 			printf("\nUsage: %s [OPTION]\n\n", basename(argv[0]));
+			printf("  -h,--help     Print this help message.\n");
+			printf("  -V,--version     Print version information.\n");
 			printf
-			    ("  -v  Verbose check of process and file contexts.\n");
+			    ("  -v,--verbose     Verbose check of process and file contexts.\n");
+			printf("  -b,--show-bools     Display the current state of booleans.\n");
 			printf("\nWithout options, show SELinux status.\n");
 			return -1;
 		}
diff -pru policycoreutils/setfiles/Makefile policycoreutils-new/setfiles/Makefile
--- policycoreutils/setfiles/Makefile	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/setfiles/Makefile	2009-11-02 00:05:54.000000000 +0100
@@ -5,8 +5,8 @@ MANDIR = $(PREFIX)/share/man
 LIBDIR ?= $(PREFIX)/lib
 AUDITH = $(shell ls /usr/include/libaudit.h 2>/dev/null)
 
-CFLAGS = -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include
+VERSION = $(shell cat ../VERSION)
+override CFLAGS += -I$(PREFIX)/include -DVERSION=\"$(VERSION)\"
 LDLIBS = -lselinux -lsepol -L$(LIBDIR)
 
 ifeq (${AUDITH}, /usr/include/libaudit.h)
diff -pru policycoreutils/setfiles/restorecon.8 policycoreutils-new/setfiles/restorecon.8
--- policycoreutils/setfiles/restorecon.8	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/setfiles/restorecon.8	2009-11-02 02:09:30.000000000 +0100
@@ -22,6 +22,12 @@ new policy, or with the \-n option it ca
 contexts are all as you expect.
 
 .SH "OPTIONS"
+.TP
+.B \-h,\-\-help
+print usage information
+.TP
+.B \-V,\-\-version
+print version information
 .TP 
 .B \-i
 ignore files that do not exist
diff -pru policycoreutils/setfiles/setfiles.8 policycoreutils-new/setfiles/setfiles.8
--- policycoreutils/setfiles/setfiles.8	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/setfiles/setfiles.8	2009-11-02 02:09:15.000000000 +0100
@@ -19,6 +19,12 @@ new policy, or with the \-n option it ca
 contexts are all as you expect.
 
 .SH "OPTIONS"
+.TP
+.B \-h,\-\-help
+print usage information
+.TP
+.B \-V,\-\-version
+print version information
 .TP 
 .B \-c
 check the validity of the contexts against the specified binary policy.
diff -pru policycoreutils/setfiles/setfiles.c policycoreutils-new/setfiles/setfiles.c
--- policycoreutils/setfiles/setfiles.c	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/setfiles/setfiles.c	2009-11-02 02:08:57.000000000 +0100
@@ -8,6 +8,7 @@
 #include <stdio_ext.h>
 #include <string.h>
 #include <errno.h>
+#include <getopt.h>
 #include <ctype.h>
 #include <regex.h>
 #include <sys/vfs.h>
@@ -317,14 +318,18 @@ void usage(const char *const name)
 {
 	if (iamrestorecon) {
 		fprintf(stderr,
+			"usage:  %s -h,--help     print this usage information\n"
+			"usage:  %s -V,--version     print version information\n"
 			"usage:  %s [-iFnrRv0] [-e excludedir ] [-o filename ] [-f filename | pathname... ]\n",
-			name);
+			name, name, name);
 	} else {
 		fprintf(stderr,
+			"usage:  %s -h,--help     print this usage information\n"
+			"usage:  %s -V,--version     print version information\n"
 			"usage:  %s [-dnpqvW] [-o filename] [-r alt_root_path ] spec_file pathname...\n"
 			"usage:  %s -c policyfile spec_file\n"
 			"usage:  %s -s [-dnqvW] [-o filename ] spec_file\n", name, name,
-			name);
+			name, name, name);
 	}
 	exit(1);
 }
@@ -809,6 +814,12 @@ int main(int argc, char **argv)
 		{ SELABEL_OPT_PATH, NULL }
 	};
 
+	struct option long_options[] = {
+		{"version", no_argument, NULL, 'V'},
+		{"help", no_argument, NULL, 'h'},
+		{NULL, 0, NULL, 0}
+	};
+
 	memset(excludeArray, 0, sizeof(excludeArray));
 	altpath = NULL;
 
@@ -866,7 +877,7 @@ int main(int argc, char **argv)
 	exclude_non_seclabel_mounts();
 
 	/* Process any options. */
-	while ((opt = getopt(argc, argv, "c:de:f:ilnpqrsvo:FRW0")) > 0) {
+	while ((opt = getopt_long(argc, argv, "c:de:f:hilnpqrsvo:FRVW0", long_options, NULL)) != -1) {
 		switch (opt) {
 		case 'c':
 			{
@@ -993,6 +1004,11 @@ int main(int argc, char **argv)
 		case '0':
 			null_terminated = 1;
 			break;
+		case 'V':
+			fprintf(stdout,
+                                " %s version %s.\n", progname, VERSION);
+			exit(EXIT_SUCCESS);
+		case 'h':
 		case '?':
 			usage(argv[0]);
 		}
diff -pru policycoreutils/setsebool/Makefile policycoreutils-new/setsebool/Makefile
--- policycoreutils/setsebool/Makefile	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/setsebool/Makefile	2009-11-02 00:05:54.000000000 +0100
@@ -5,8 +5,9 @@ SBINDIR ?= $(PREFIX)/sbin
 MANDIR = $(PREFIX)/share/man
 LIBDIR ?= ${PREFIX}/lib
 
+VERSION = $(shell cat ../VERSION)
 CFLAGS ?= -Werror -Wall -W
-override CFLAGS += -I$(INCLUDEDIR)
+override CFLAGS += -I$(INCLUDEDIR) -DVERSION=\"$(VERSION)\"
 LDLIBS = -lsepol -lselinux -lsemanage -L$(LIBDIR)
 SETSEBOOL_OBJS = setsebool.o
 
diff -pru policycoreutils/setsebool/setsebool.8 policycoreutils-new/setsebool/setsebool.8
--- policycoreutils/setsebool/setsebool.8	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/setsebool/setsebool.8	2009-11-02 02:12:43.000000000 +0100
@@ -11,6 +11,17 @@ setsebool \- set SELinux boolean value
 sets the current state of a particular SELinux boolean or a list of booleans 
 to a given value. The value may be 1 or true or on to enable the boolean, or 0 or false or off to disable it. 
 
+.SH "OPTIONS"
+.TP
+
+.B \-h,\-\-help
+.P
+ Print usage information.
+
+.B \-V,\-\-version
+.P
+ Print version information.
+
 Without the -P option, only the current boolean value is 
 affected; the boot-time default settings 
 are not changed. 
diff -pru policycoreutils/setsebool/setsebool.c policycoreutils-new/setsebool/setsebool.c
--- policycoreutils/setsebool/setsebool.c	2009-11-01 22:23:01.000000000 +0100
+++ policycoreutils-new/setsebool/setsebool.c	2009-11-02 02:11:44.000000000 +0100
@@ -5,6 +5,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <errno.h>
+#include <getopt.h>
 #include <syslog.h>
 #include <pwd.h>
 #include <selinux/selinux.h>
@@ -14,38 +15,75 @@
 #include <semanage/boolean_record.h>
 #include <errno.h>
 
+#define SETSEBOOL_CONF_PROG_NAME "setsebool"	/* default program name */
+
 int permanent = 0;
 
 int setbool(char **list, size_t start, size_t end);
 
-void usage(void)
+void usage(char *progname)
 {
-	fputs
-	    ("\nUsage:  setsebool [ -P ] boolean value | bool1=val1 bool2=val2...\n\n",
-	     stderr);
+	fprintf(stderr, "\nUsage:  %s -h | -V | [ -P ] boolean value | bool1=val1 bool2=val2...\n\n", progname);
 	exit(1);
 }
 
+static char *opt_program_name(char *argv0, char *def)
+{
+	if (argv0) {
+		if ((def = strrchr(argv0, '/')))
+			++def;
+		else
+			def = argv0;
+
+		/* hack for libtool */
+		if ((strlen(def) > strlen("lt-"))
+		     && !memcmp("lt-", def, strlen("lt-")))
+			def += 3;
+	}
+
+	return (def);
+}
+
 int main(int argc, char **argv)
 {
 	size_t rc, start;
+	int opt;
+	char *program_name = NULL;
+	struct option long_options[] = {
+		{"help", no_argument, NULL, 'h'},
+		{"version", no_argument, NULL, 'V'},
+		{NULL, 0, NULL, 0}
+	};
+
+	program_name = opt_program_name(argv[0], SETSEBOOL_CONF_PROG_NAME);
+	start = 1;
+
+	while ((opt = getopt_long(argc, argv, "hPV", long_options, NULL)) != -1) {
+		switch (opt) {
+		case 'V':
+			fprintf(stdout,
+				" %s version %s.\n", program_name, VERSION);
+			exit(EXIT_SUCCESS);
+		case 'h':
+			usage(program_name);
+		case 'P':
+			if (argc < 3)
+				usage(program_name);
+			permanent = 1;
+			start = 2;
+		default:
+			usage(program_name);
+		}
+	}
 
 	if (argc < 2)
-		usage();
+		usage(program_name);
 
 	if (is_selinux_enabled() <= 0) {
 		fputs("setsebool:  SELinux is disabled.\n", stderr);
 		return 1;
 	}
 
-	if (strcmp(argv[1], "-P") == 0) {
-		permanent = 1;
-		if (argc < 3)
-			usage();
-		start = 2;
-	} else
-		start = 1;
-
 	/* Check to see which way we are being called. If a '=' is passed,
 	   we'll enforce the list syntax. If not we'll enforce the original
 	   syntax for backward compatibility. */
@@ -54,7 +92,7 @@ int main(int argc, char **argv)
 		char *bool_list[1];
 
 		if ((argc - start) != 2)
-			usage();
+			usage(program_name);
 
 		/* Add 1 for the '=' */
 		len = strlen(argv[start]) + strlen(argv[start + 1]) + 2;

--=-S+dr3xlhgmP6mtSH0srn--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
