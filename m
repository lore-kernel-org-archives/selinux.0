Date: Thu, 1 Sep 2005 13:56:31 -0500
From: ltcgcw@us.ibm.com
To: SELinux <SELinux@tycho.nsa.gov>
Cc: redhat-lspp <redhat-lspp@redhat.com>
Subject: [RFC][PATCH] killall context regex and userid matching
Message-ID: <20050901185631.GA22593@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="U+BazGySraz5kW0T"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Please find a patch to psmisc attached.  It adds these features to killall:
  - regular expression SELinux context matching
  - userid matching
  - process names now optional when matching by either context or userid
  - most fprintf() strings now gettext-ized
  - help text no longer split up by #ifdef; missing newline added
  - manpage updates

The patch applies to the psmisc CVS tree, current as of today.  I will
submit it to the psmisc maintainer once I incorporate comments received on
this list.  It might be useful to add something similar to skill and snice.

--=20
George Wilson <ltcgcw@us.ibm.com>
IBM Linux Technology Center

--U+BazGySraz5kW0T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="psmisc-16.patch"
Content-Transfer-Encoding: quoted-printable

diff -Naurp psmisc.orig/doc/killall.1 psmisc.comp/doc/killall.1
--- psmisc.orig/doc/killall.1	2005-03-20 18:02:44.000000000 -0600
+++ psmisc.comp/doc/killall.1	2005-08-28 16:17:58.000000000 -0500
@@ -4,13 +4,16 @@ killall \- kill processes by name
 .SH SYNOPSIS
 .ad l
 .B killall
-.RB [ \-Z , \-\-context ]
+.RB [ \-Z , \-\-context
+.IR regex ]
 .RB [ \-e , \-\-exact ]
 .RB [ \-g , \-\-process\-group ]
 .RB [ \-i , \-\-interactive ]
 .RB [ \-q , \-\-quiet ]
 .RB [ \-s , \-\-signal
 .IR signal ]
+.RB [ \-u , \-\-user
+.IR user ]
 .RB [ \-v , \-\-verbose ]
 .RB [ \-w , \-\-wait ]
 .RB [ \-I , \-\-ignore-case ]
@@ -36,7 +39,9 @@ If the command name contains a slash (\f
 particular file will be selected for killing, independent of their name.
 .PP
 \fBkillall\fP returns a zero return code if at least one process has been
-killed for each listed command. \fBkillall\fP returns non-zero otherwise.
+killed for each listed command, or no commands were listed and at least
+one process matched the -u and -Z search criteria. \fBkillall\fP returns
+non-zero otherwise.
 .PP
 A \fBkillall\fP process never kills itself (but may kill other \fBkillall\=
fP
 processes).
@@ -60,6 +65,8 @@ Interactively ask for confirmation befor
 List all known signal names.
 .IP "\fB\-q\fP, \fB\-\-quiet\fP"
 Do not complain if no processes were killed.
+.IP "\fB\-u\fP, \fB\-\-user\fP"
+Kill only processes the specified user owns.  Command names are optional.
 .IP "\fB\-v\fP, \fB\-\-verbose\fP"
 Report if the signal was successfully sent.
 .IP "\fB\-V\fP, \fB\-\-version\fP"
@@ -69,9 +76,9 @@ Wait for all killed processes to die. \f
 any of the killed processes still exist and only returns if none are left.
 Note that \fBkillall\fP may wait forever if the signal was ignored, had no
 effect, or if the process stays in zombie state.
-.IP \fB\-Z\fP
-(SELinux Only) Specify security context: kill only processes with given se=
curity context.
-Must precede other arguments on the command line.
+.IP "\fB\-Z\fP, \fB\-\-context\fP"
+(SELinux Only) Kill only processes having a security context that matches =
the
+given extended regular expression.  Command names are optional.
 .SH FILES
 .nf
 /proc	location of the proc file system
diff -Naurp psmisc.orig/src/killall.c psmisc.comp/src/killall.c
--- psmisc.orig/src/killall.c	2005-03-23 16:38:00.000000000 -0600
+++ psmisc.comp/src/killall.c	2005-08-29 07:33:39.000000000 -0500
@@ -39,15 +39,16 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <getopt.h>
-
-#ifdef WITH_SELINUX
-#include <selinux/selinux.h>
-#endif /*WITH_SELINUX*/
+#include <pwd.h>
=20
 #include "i18n.h"
 #include "comm.h"
 #include "signals.h"
=20
+#ifdef WITH_SELINUX
+#include <regex.h>
+#include <selinux/selinux.h>
+#endif /*WITH_SELINUX*/
=20
 #define PROC_BASE "/proc"
 #define MAX_NAMES (int)(sizeof(unsigned long)*8)
@@ -55,7 +56,7 @@
=20
 static int verbose =3D 0, exact =3D 0, interactive =3D 0,
            quiet =3D 0, wait_until_dead =3D 0, process_group =3D 0,
-           ignore_case =3D 0, pidof;
+           ignore_case =3D 0, byuser =3D 0, pidof;
=20
 static int
 ask (char *name, pid_t pid)
@@ -90,10 +91,10 @@ ask (char *name, pid_t pid)
=20
 #ifdef WITH_SELINUX
 static int
-kill_all(int signal, int names, char **namelist, security_context_t sconte=
xt )
+kill_all(int signal, int names, char **namelist, uid_t *uid, regex_t *cont=
ext_regex)
 #else  /*WITH_SELINUX*/
 static int
-kill_all (int signal, int names, char **namelist)
+kill_all (int signal, int names, char **namelist, uid_t *uid)
 #endif /*WITH_SELINUX*/
 {
   DIR *dir;
@@ -109,28 +110,41 @@ kill_all (int signal, int names, char **
   int empty, i, j, okay, length, got_long, error;
   int pids, max_pids, pids_killed;
   unsigned long found;
+  uid_t ps_uid =3D 0;
+  const int ps_buffer_size =3D 80;
+  char ps_buffer[ps_buffer_size];
+  int rc =3D 0;
 #ifdef WITH_SELINUX
-  security_context_t lcontext=3DNULL;
-
-  if ( names =3D=3D 0 || ! namelist ) exit( 1 ); /* do the obvious thing..=
=2E*/
+  int nameless =3D ((names =3D=3D 0) && ((uid !=3D NULL) || (context_regex=
 !=3D NULL)));
+  security_context_t ps_context =3D NULL;
+#else
+  int nameless =3D (names =3D=3D 0) && (uid !=3D NULL);
 #endif /*WITH_SELINUX*/
=20
-  if (!(name_len =3D malloc (sizeof (int) * names)))
+  if (!nameless)
     {
-      perror ("malloc");
-      exit (1);
+      if (!(name_len =3D malloc (sizeof (int) * names)))
+	{
+	  perror ("malloc");
+	  exit (1);
+	}
+      for (i =3D 0; i < names; i++)
+	{
+	  if (!strchr (namelist[i], '/'))
+	    {
+	      sts[i].st_dev =3D 0;
+	      name_len[i] =3D strlen (namelist[i]);
+	    }
+	  else if (stat (namelist[i], &sts[i]) < 0)
+	    {
+	      perror (namelist[i]);
+	      exit (1);
+	    }
+	}
     }
-  for (i =3D 0; i < names; i++) {
-    if (!strchr (namelist[i], '/'))
-      {
-	sts[i].st_dev =3D 0;
-	name_len[i] =3D strlen (namelist[i]);
-      }
-    else if (stat (namelist[i], &sts[i]) < 0)
-      {
-	perror (namelist[i]);
-	exit (1);
-      }
+  else
+   {
+     names =3D 1;		/* But loop once through names */
    }=20
   self =3D getpid ();
   found =3D 0;
@@ -184,6 +198,54 @@ kill_all (int signal, int names, char **
     }
   for (i =3D 0; i < pids; i++)
     {
+      /* Match by UID */
+      if (uid !=3D NULL)
+	{
+	  if (asprintf (&path, PROC_BASE "/%d/status", pid_table[i]) < 0)
+	    {
+	      continue;
+	    }
+	  if (!(file =3D fopen (path, "r")))
+ 	    {
+ 	      free (path);
+ 	      continue;
+ 	    }
+	  free (path);
+	  rc =3D 0;
+	  while (rc =3D=3D 0)
+	    {
+	      if ((rc =3D (int)fgets(ps_buffer, ps_buffer_size, file)) !=3D EOF)
+		{
+		  rc =3D sscanf (ps_buffer, "Uid:\t%d", &ps_uid);
+		}
+  	    }
+	  (void) fclose(file);
+ 	  if (rc =3D=3D EOF)
+	    {
+	      fprintf(stderr, _("Cannot get UID from process status\n"));
+	      exit (1);
+            }
+          if (*uid !=3D ps_uid)
+            {
+              continue;
+            }
+        }
+#ifdef WITH_SELINUX
+      /* Match by context */
+      if (context_regex !=3D NULL)
+	{
+	  if (getpidcon(pid_table[i], &ps_context) < 0)
+	    {
+	      continue;
+	    }
+	  if (regexec (context_regex, (const char *)ps_context, 0, NULL, 0) !=3D =
0)
+	    {
+	      freecon(ps_context);
+	      continue;
+	    }
+	  freecon(ps_context);
+	}
+#endif /*WITH_SELINUX*/
       if (asprintf (&path, PROC_BASE "/%d/stat", pid_table[i]) < 0)
 	continue;
       if (!(file =3D fopen (path, "r")))=20
@@ -262,60 +324,40 @@ kill_all (int signal, int names, char **
       for (j =3D 0; j < names; j++)
 	{
 	  pid_t id;
-
-	  if (!sts[j].st_dev)
+	  if (!nameless)
 	    {
-	      if (length !=3D COMM_LEN - 1 || name_len[j] < COMM_LEN - 1)
-		{
-		  if (ignore_case =3D=3D 1)
-		  {
-		    if (strcasecmp (namelist[j], comm))
+	      if (!sts[j].st_dev)
+	        {
+	          if (length !=3D COMM_LEN - 1 || name_len[j] < COMM_LEN - 1)
+		    {
+		      if (ignore_case =3D=3D 1)
+		      {
+		        if (strcasecmp (namelist[j], comm))
+		        continue;
+		      }
+		      else
+		      {
+		        if (strcmp(namelist[j], comm))
+		        continue;
+		      }
+		    }
+	          else if (got_long ? strcmp (namelist[j], command) :
+		           strncmp (namelist[j], comm, COMM_LEN - 1))
 		    continue;
-		  }
-		  else
-		  {
-		    if (strcmp(namelist[j], comm))
+	        }
+	      else
+	        {
+	          if (asprintf (&path, PROC_BASE "/%d/exe", pid_table[i]) < 0)
 		    continue;
-		  }
-		}
-	      else if (got_long ? strcmp (namelist[j], command) :
-		       strncmp (namelist[j], comm, COMM_LEN - 1))
-		continue;
-#ifdef WITH_SELINUX
-              if ( scontext !=3D NULL ) {
-                if ( getpidcon(pid_table[i], &lcontext) < 0 )
-                  continue;
-                if (strcmp(lcontext,scontext)!=3D0) {
-		  freecon(lcontext);
-                  continue;
-		}
-		freecon(lcontext);
-              }
-#endif /*WITH_SELINUX*/
-	    }
-	  else
-	    {
-	      if (asprintf (&path, PROC_BASE "/%d/exe", pid_table[i]) < 0)
-		continue;
=20
-	      if (stat (path, &st) < 0) {
-		    free (path);
+	          if (stat (path, &st) < 0) {
+		        free (path);
+		        continue;
+	          }
+	          free (path);
+	          if (sts[j].st_dev !=3D st.st_dev || sts[j].st_ino !=3D st.st_in=
o)
 		    continue;
-	      }
-	      free (path);
-#ifdef WITH_SELINUX
-              if ( scontext !=3D NULL ) {
-                if ( getpidcon(pid_table[i], &lcontext) < 0 )
-                  continue;
-                if (strcmp(lcontext,scontext)!=3D0) {
-		  freecon(lcontext);
-                  continue;
-		}
-		freecon(lcontext);
-              }
-#endif /*WITH_SELINUX*/
-	      if (sts[j].st_dev !=3D st.st_dev || sts[j].st_ino !=3D st.st_ino)
-		continue;
+	        }
 	    }
 	  if (!process_group)
 	    id =3D pid_table[i];
@@ -360,16 +402,25 @@ kill_all (int signal, int names, char **
     }
   if (empty)
     {
-      fprintf (stderr, _("%s is empty (not mounted ?)\n"), PROC_BASE);
-      exit (1);
+      if (pids =3D=3D 0)
+        {
+          fprintf (stderr, _("%s is empty (not mounted ?)\n"), PROC_BASE);
+          exit (1);
+        }
+      else
+        {
+          fprintf (stderr, _("Warning: No processes matched search criteri=
a\n"));
+          exit(1);
+        }
     }
-  if (!quiet && !pidof)
+  if (!quiet && !pidof && !nameless)
     for (i =3D 0; i < names; i++)
       if (!(found & (1 << i)))
 	fprintf (stderr, _("%s: no process killed\n"), namelist[i]);
   if (pidof)
     putchar ('\n');
-  error =3D found =3D=3D ((1 << (names - 1)) | ((1 << (names - 1)) - 1)) ?=
 0 : 1;
+  /* If it gets this far and is nameless, at least one process matched. */
+  error =3D found =3D=3D (((1 << (names - 1)) | ((1 << (names - 1)) - 1)) =
|| nameless) ? 0 : 1;
   /*
    * We scan all (supposedly) killed processes every second to detect dead
    * processes as soon as possible in order to limit problems of race with
@@ -410,12 +461,26 @@ static void
 usage_killall (void)
 {
 #ifdef WITH_SELINUX
-   fprintf(stderr, _(
-     "Usage: killall [-Z CONTEXT] [ -egiqvw ] [ -SIGNAL ] NAME...\n"));
+  fprintf(stderr, _(
+    "Usage: killall [-Z CONTEXT] [-u USERID] [-egiqvw] [-SIGNAL] NAME...\n=
"));
+  fprintf(stderr, _(
+    "       killall -l, --list\n"
+    "       killall -V, --version\n\n"
+    "  -e,--exact          require exact match for very long names\n"
+    "  -I,--ignore-case    case insensitive process name match\n"
+    "  -g,--process-group  kill process group instead of process\n"
+    "  -i,--interactive    ask for confirmation before killing\n"
+    "  -l,--list           list all known signal names\n"
+    "  -q,--quiet          don't print complaints\n"
+    "  -s,--signal SIGNAL  send this signal instead of SIGTERM\n"
+    "  -u,--user USER      kill only process(es) running as USER\n"
+    "  -v,--verbose        report if the signal was successfully sent\n"
+    "  -V,--version        display version information\n"
+    "  -w,--wait           wait for processes to die\n"
+    "  -Z,--context REGEX  kill only process(es) whose SELinux context mat=
ches REGEX\n\n"));
 #else  /*WITH_SELINUX*/
   fprintf(stderr, _(
     "Usage: killall [OPTIONS]... [--] NAME...\n"));
-#endif /*WITH_SELINUX*/
   fprintf(stderr, _(
     "       killall -l, --list\n"
     "       killall -V, --version\n\n"
@@ -426,13 +491,10 @@ usage_killall (void)
     "  -l,--list           list all known signal names\n"
     "  -q,--quiet          don't print complaints\n"
     "  -s,--signal SIGNAL  send this signal instead of SIGTERM\n"
+    "  -u,--user USER      kill only process(es) running as USER\n"
     "  -v,--verbose        report if the signal was successfully sent\n"
     "  -V,--version        display version information\n"
     "  -w,--wait           wait for processes to die\n\n"));
-#ifdef WITH_SELINUX
-  fprintf(stderr, _(
-    "  -Z,--context CONTEXT kill only process(es) having context\n"
-    "                      (must precede other arguments)"));
 #endif /*WITH_SELINUX*/
 }
=20
@@ -466,7 +528,13 @@ main (int argc, char **argv)
   int sig_num;
   int optc;
   int myoptind;
+  uid_t uid;
+  struct passwd *pwent;
   //int optsig =3D 0;
+#ifdef WITH_SELINUX
+  int rc;
+  regex_t context_regex;
+#endif /*WITH_SELINUX*/
=20
   struct option options[] =3D {
     {"exact", 0, NULL, 'e'},
@@ -476,6 +544,7 @@ main (int argc, char **argv)
     {"list-signals", 0, NULL, 'l'},
     {"quiet", 0, NULL, 'q'},
     {"signal", 1, NULL, 's'},
+    {"user", 1, NULL, 'u'},
     {"verbose", 0, NULL, 'v'},
     {"wait", 0, NULL, 'w'},
 #ifdef WITH_SELINUX
@@ -486,8 +555,6 @@ main (int argc, char **argv)
=20
 #ifdef WITH_SELINUX
   security_context_t scontext =3D NULL;
-
-  if ( argc < 2 ) usage(); /* do the obvious thing... */
 #endif /*WITH_SELINUX*/
=20
   name =3D strrchr (*argv, '/');
@@ -507,9 +574,9 @@ main (int argc, char **argv)
=20
   opterr =3D 0;
 #ifdef WITH_SELINUX
-  while ( (optc =3D getopt_long_only(argc,argv,"egilqs:vwZ:VI",options,NUL=
L)) !=3D EOF) {
+  while ( (optc =3D getopt_long_only(argc,argv,"egilqs:u:vwZ:VI",options,N=
ULL)) !=3D EOF) {
 #else
-  while ( (optc =3D getopt_long_only(argc,argv,"egilqs:vwVI",options,NULL)=
) !=3D EOF) {
+  while ( (optc =3D getopt_long_only(argc,argv,"egilqs:u:vwVI",options,NUL=
L)) !=3D EOF) {
 #endif
     switch (optc) {
       case 'e':
@@ -537,6 +604,16 @@ main (int argc, char **argv)
       case 's':
 	sig_num =3D get_signal (optarg, "killall");
         break;
+      case 'u':
+        pwent =3D getpwnam(optarg);
+        if (pwent !=3D NULL) {
+          uid =3D pwent->pw_uid;
+          byuser =3D 1;
+        } else {
+          fprintf (stderr, _("Cannot find user\n"));
+          exit (1);
+        }
+        break;
       case 'v':
         if (pidof)
           usage();
@@ -556,13 +633,25 @@ main (int argc, char **argv)
         break;
 #ifdef WITH_SELINUX
       case 'Z':=20
-        if (is_selinux_enabled()>0)=20
-           scontext=3Doptarg;
-        else=20
-           fprintf(stderr, "Warning: -Z (--context) ignored. Requires an S=
ELinux enabled kernel\n");
+        if (is_selinux_enabled() > 0) {
+           scontext =3D optarg;
+           if (regcomp(&context_regex, scontext, REG_EXTENDED|REG_NOSUB) !=
=3D 0) {
+             fprintf(stderr, _("Bad regular expression\n"));
+             exit (1);
+           }
+        } else {
+           fprintf(stderr, _("Warning: -Z (--context) ignored. Requires an=
 SELinux enabled kernel\n"));
+        }
         break;
 #endif /*WITH_SELINUX*/
       case '?':
+#ifdef WITH_SELINUX
+        /* Special case the 'Z' option--it's the only uppercase opt with=
=20
+         * an optarg. Otherwise, code below confuses it with a signal. */
+        if (strncmp(argv[optind-1], "-Z", 32) =3D=3D 0) {
+          usage();
+        }
+#endif /*WITH_SELINUX*/
         /* Signal names are in uppercase, so check to see if the argv
          * is upper case */
         if (argv[optind-1][1] >=3D 'A' && argv[optind-1][1] <=3D 'Z') {
@@ -579,7 +668,11 @@ main (int argc, char **argv)
     }
   }
   myoptind =3D optind;
-  if (argc - myoptind < 1)=20
+#ifdef WITH_SELINUX
+  if ((argc - myoptind < 1) && (byuser =3D=3D 0) && (scontext =3D=3D NULL))
+#else
+  if ((argc - myoptind < 1) && (byuser =3D=3D 0))
+#endif /*WITH_SELINUX*/
     usage();
=20
   if (argc - myoptind > MAX_NAMES + 1)
@@ -590,8 +683,16 @@ main (int argc, char **argv)
   argv =3D argv + myoptind;
   /*printf("sending signal %d to procs\n", sig_num);*/
 #ifdef WITH_SELINUX
-  return kill_all(sig_num,argc - myoptind, argv, scontext);
+  rc =3D kill_all(sig_num,
+		argc - myoptind,
+		argv,
+		((byuser =3D=3D 0) ? NULL : &uid),
+		((scontext =3D=3D NULL) ? NULL : &context_regex));
+  if (scontext !=3D NULL) {
+    regfree(&context_regex);
+  }
+  return rc;
 #else  /*WITH_SELINUX*/
-  return kill_all(sig_num,argc - myoptind, argv );
+  return kill_all(sig_num, argc - myoptind, argv, ((byuser =3D=3D 0) ? NUL=
L : &uid));
 #endif /*WITH_SELINUX*/
 }

--U+BazGySraz5kW0T--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
