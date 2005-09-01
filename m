Message-ID: <43176E2C.2030805@redhat.com>
Date: Thu, 01 Sep 2005 17:10:04 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: ltcgcw@us.ibm.com
CC: SELinux <SELinux@tycho.nsa.gov>, redhat-lspp <redhat-lspp@redhat.com>
Subject: Re: [redhat-lspp] [RFC][PATCH] killall context regex and userid matching
References: <20050901185631.GA22593@us.ibm.com>
In-Reply-To: <20050901185631.GA22593@us.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------020305070407080107020708"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------020305070407080107020708
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

ltcgcw@us.ibm.com wrote:

>Please find a patch to psmisc attached.  It adds these features to killall:
>  - regular expression SELinux context matching
>  - userid matching
>  - process names now optional when matching by either context or userid
>  - most fprintf() strings now gettext-ized
>  - help text no longer split up by #ifdef; missing newline added
>  - manpage updates
>
>The patch applies to the psmisc CVS tree, current as of today.  I will
>submit it to the psmisc maintainer once I incorporate comments received on
>this list.  It might be useful to add something similar to skill and snice.
>
>  
>
Updated patch to apply to psmisc-21.5

-- 



--------------020305070407080107020708
Content-Type: text/x-patch;
 name="psmisc-21.5-selinux-user.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="psmisc-21.5-selinux-user.patch"

--- psmisc-21.5/src/killall.c.selinux-user	2005-09-01 16:58:13.000000000 -0400
+++ psmisc-21.5/src/killall.c	2005-09-01 17:00:44.000000000 -0400
@@ -22,7 +22,9 @@
 #include <sys/stat.h>
 #include <getopt.h>
 #ifdef WITH_SELINUX
+#include <regex.h>
 #include <selinux/selinux.h>
+#include <pwd.h>
 #endif /*WITH_SELINUX*/
 #ifdef ENABLE_NLS
 #include <libintl.h>
@@ -42,7 +44,7 @@
 
 static int verbose = 0, exact = 0, interactive = 0,
            quiet = 0, wait_until_dead = 0, process_group = 0,
-           ignore_case = 0, pidof;
+           ignore_case = 0, byuser = 0, pidof;
 
 static int
 ask (char *name, pid_t pid)
@@ -69,17 +71,17 @@
 
 #ifdef WITH_SELINUX
 static int
-kill_all(int signal, int names, char **namelist, security_context_t scontext )
+kill_all(int signal, int names, char **namelist, uid_t *uid, regex_t *context_regex)
 #else  /*WITH_SELINUX*/
 static int
-kill_all (int signal, int names, char **namelist)
+kill_all (int signal, int names, char **namelist, uid_t *uid)
 #endif /*WITH_SELINUX*/
 {
   DIR *dir;
   struct dirent *de;
   FILE *file;
   struct stat st, sts[MAX_NAMES];
-  int *name_len;
+  int *name_len=NULL;
   char *path, comm[COMM_LEN];
   char *command_buf;
   char *command;
@@ -88,30 +90,45 @@
   int empty, i, j, okay, length, got_long, error;
   int pids, max_pids, pids_killed;
   unsigned long found;
+  uid_t ps_uid = 0;
+  const int ps_buffer_size = 80;
+  char ps_buffer[ps_buffer_size];
+  int rc = 0;
 #ifdef WITH_SELINUX
+  int nameless = ((names == 0) && ((uid != NULL) || (context_regex != NULL)));
+  security_context_t ps_context = NULL;
+#else
+  int nameless = (names == 0) && (uid != NULL);
   security_context_t lcontext=NULL;
 
   if ( names == 0 || ! namelist ) exit( 1 ); /* do the obvious thing...*/
 #endif /*WITH_SELINUX*/
 
-  if (!(name_len = malloc (sizeof (int) * names)))
-    {
-      perror ("malloc");
-      exit (1);
-    }
-  for (i = 0; i < names; i++) {
-    if (!strchr (namelist[i], '/'))
+  if (!nameless)
+  {
+    if (!(name_len = malloc (sizeof (int) * names)))
       {
-	sts[i].st_dev = 0;
-	name_len[i] = strlen (namelist[i]);
+        perror ("malloc");
+        exit (1);
+      }
+    for (i = 0; i < names; i++) {
+      if (!strchr (namelist[i], '/'))
+        {
+	  sts[i].st_dev = 0;
+	  name_len[i] = strlen (namelist[i]);
+        }
+      else {
+        if (stat (namelist[i], &sts[i]) < 0)
+	  {
+	    perror (namelist[i]);
+	    exit (1);
+	  }
       }
-    else {
-      if (stat (namelist[i], &sts[i]) < 0)
-	{
-	  perror (namelist[i]);
-	  exit (1);
-	}
     }
+  }
+  else
+  { 
+	  names = 1;		/* But loop once through names */
   } 
   self = getpid ();
   found = 0;
@@ -165,6 +182,54 @@
     }
   for (i = 0; i < pids; i++)
     {
+      /* Match by UID */
+      if (uid != NULL)
+	{
+	  if (asprintf (&path, PROC_BASE "/%d/status", pid_table[i]) < 0)
+	    {
+	      continue;
+	    }
+	  if (!(file = fopen (path, "r")))
+ 	    {
+ 	      free (path);
+ 	      continue;
+ 	    }
+	  free (path);
+	  rc = 0;
+	  while (rc == 0)
+	    {
+	      if ((rc = (int)fgets(ps_buffer, ps_buffer_size, file)) != EOF)
+		{
+		  rc = sscanf (ps_buffer, "Uid:\t%d", &ps_uid);
+		}
+  	    }
+	  (void) fclose(file);
+ 	  if (rc == EOF)
+	    {
+	      fprintf(stderr, _("Cannot get UID from process status\n"));
+	      exit (1);
+            }
+          if (*uid != ps_uid)
+            {
+              continue;
+            }
+        }
+#ifdef WITH_SELINUX
+      /* Match by context */
+      if (context_regex != NULL)
+	{
+	  if (getpidcon(pid_table[i], &ps_context) < 0)
+	    {
+	      continue;
+	    }
+	  if (regexec (context_regex, (const char *)ps_context, 0, NULL, 0) != 0)
+	    {
+	      freecon(ps_context);
+	      continue;
+	    }
+	  freecon(ps_context);
+	}
+#endif /*WITH_SELINUX*/
       if (asprintf (&path, PROC_BASE "/%d/stat", pid_table[i]) < 0)
 	continue;
       if (!(file = fopen (path, "r"))) 
@@ -244,60 +309,40 @@
 	{
 	  pid_t id;
 
-	  if (!sts[j].st_dev)
-	    {
-	      if (length != COMM_LEN - 1 || name_len[j] < COMM_LEN - 1)
-		{
-		  if (ignore_case == 1)
-		  {
-		    if (strcasecmp (namelist[j], comm))
+ 	  if (!nameless)
+  	    {
+	      if (!sts[j].st_dev)
+	        {
+	          if (length != COMM_LEN - 1 || name_len[j] < COMM_LEN - 1)
+		    {
+		      if (ignore_case == 1)
+		        {
+		          if (strcasecmp (namelist[j], comm))
+		          continue;
+		        }
+		      else
+		      {
+		          if (strcmp(namelist[j], comm))
+		          continue;
+		      }
+		    }
+	          else if (got_long ? strcmp (namelist[j], command) :
+		       strncmp (namelist[j], comm, COMM_LEN - 1))
 		    continue;
-		  }
-		  else
-		  {
-		    if (strcmp(namelist[j], comm))
+ 	        }
+ 	      else
+ 	        {
+ 	          if (asprintf (&path, PROC_BASE "/%d/exe", pid_table[i]) < 0)
 		    continue;
-		  }
-		}
-	      else if (got_long ? strcmp (namelist[j], command) :
-		       strncmp (namelist[j], comm, COMM_LEN - 1))
-		continue;
-#ifdef WITH_SELINUX
-              if ( scontext != NULL ) {
-                if ( getpidcon(pid_table[i], &lcontext) < 0 )
-                  continue;
-                if (strcmp(lcontext,scontext)!=0) {
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
 
-	      if (stat (path, &st) < 0) {
+  	          if (stat (path, &st) < 0) {
 		    free (path);
 		    continue;
-	      }
-	      free (path);
-#ifdef WITH_SELINUX
-              if ( scontext != NULL ) {
-                if ( getpidcon(pid_table[i], &lcontext) < 0 )
-                  continue;
-                if (strcmp(lcontext,scontext)!=0) {
-		  freecon(lcontext);
-                  continue;
-		}
-		freecon(lcontext);
-              }
-#endif /*WITH_SELINUX*/
-
-	      if (sts[j].st_dev != st.st_dev || sts[j].st_ino != st.st_ino)
-		continue;
+	          }
+	          free (path);
+  	          if (sts[j].st_dev != st.st_dev || sts[j].st_ino != st.st_ino)
+		    continue;
+		}	    
 	    }
 	  if (!process_group)
 	    id = pid_table[i];
@@ -342,16 +387,25 @@
     }
   if (empty)
     {
-      fprintf (stderr, _("%s is empty (not mounted ?)\n"), PROC_BASE);
-      exit (1);
+      if (pids == 0)
+        {
+          fprintf (stderr, _("%s is empty (not mounted ?)\n"), PROC_BASE);
+          exit (1);
+        }
+      else
+        {
+          fprintf (stderr, _("Warning: No processes matched search criteria\n"));
+          exit(1);
+        }
     }
-  if (!quiet && !pidof)
+  if (!quiet && !pidof && !nameless)
     for (i = 0; i < names; i++)
       if (!(found & (1 << i)))
 	fprintf (stderr, _("%s: no process killed\n"), namelist[i]);
   if (pidof)
     putchar ('\n');
-  error = found == ((1 << (names - 1)) | ((1 << (names - 1)) - 1)) ? 0 : 1;
+  /* If it gets this far and is nameless, at least one process matched. */
+  error = found == (((1 << (names - 1)) | ((1 << (names - 1)) - 1)) || nameless) ? 0 : 1;
   /*
    * We scan all (supposedly) killed processes every second to detect dead
    * processes as soon as possible in order to limit problems of race with
@@ -392,15 +446,12 @@
 usage_killall (void)
 {
 #ifdef WITH_SELINUX
-  fprintf(stderr,"Usage: killall [-Z context] [ -egiqvw ] [ -signal ] name ...\n");
-#else  /*WITH_SELINUX*/
+  fprintf(stderr,"Usage: killall [-Z context] [ -u USERID ] [ -eIgilqsvVw ] [ -signal ] name ...\n");
+#else  
   fprintf (stderr, "usage: killall [ OPTIONS ] [ -- ] name ...\n");
 #endif /*WITH_SELINUX*/
   fprintf (stderr, "       killall -l, --list\n");
   fprintf (stderr, "       killall -V --version\n\n");
-#ifdef WITH_SELINUX
-  fprintf (stderr, "  -Z,--context        kill only process(es) having scontext\n");
-#endif /*WITH_SELINUX*/
   fprintf (stderr, "  -e,--exact          require exact match for very long names\n");
   fprintf (stderr, "  -I,--ignore-case-   case insensitive process name match\n");
   fprintf (stderr, "  -g,--process-group  kill process group instead of process\n");
@@ -408,9 +459,15 @@
   fprintf (stderr, "  -l,--list           list all known signal names\n");
   fprintf (stderr, "  -q,--quiet          don't print complaints\n");
   fprintf (stderr, "  -s,--signal         send signal instead of SIGTERM\n");
+#ifdef WITH_SELINUX
+  fprintf (stderr, "  -u,--user USER      kill only process(es) running as USER\n");
+#endif 
   fprintf (stderr, "  -v,--verbose        report if the signal was successfully sent\n");
   fprintf (stderr, "  -V,--version        display version information\n");
   fprintf (stderr, "  -w,--wait           wait for processes to die\n\n");
+#ifdef WITH_SELINUX
+  fprintf (stderr, "  -Z,--context        kill only process(es) having scontext\n");
+#endif 
 }
 
 
@@ -441,7 +498,13 @@
   int sig_num;
   int optc;
   int myoptind;
+  uid_t uid;
+  struct passwd *pwent;
   //int optsig = 0;
+#ifdef WITH_SELINUX
+  int rc;
+  regex_t context_regex;
+#endif /*WITH_SELINUX*/
 
   struct option options[] = {
     {"exact", 0, NULL, 'e'},
@@ -451,6 +514,7 @@
     {"list-signals", 0, NULL, 'l'},
     {"quiet", 0, NULL, 'q'},
     {"signal", 1, NULL, 's'},
+    {"user", 1, NULL, 'u'},
     {"verbose", 0, NULL, 'v'},
     {"wait", 0, NULL, 'w'},
 #ifdef WITH_SELINUX
@@ -462,7 +526,6 @@
 #ifdef WITH_SELINUX
    security_context_t scontext = NULL;
   
-    if ( argc < 2 ) usage(); /* do the obvious thing... */
 #endif /*WITH_SELINUX*/
     
   name = strrchr (*argv, '/');
@@ -482,7 +545,7 @@
 
   opterr = 0;
 #ifdef WITH_SELINUX
-  while ( (optc = getopt_long_only(argc,argv,"egilqs:vwVIZ",options,NULL)) != EOF) {
+  while ( (optc = getopt_long_only(argc,argv,"egilqs:u:vwVIZ:",options,NULL)) != EOF) {
 #else
   while ( (optc = getopt_long_only(argc,argv,"egilqs:vwVI",options,NULL)) != EOF) {
 #endif
@@ -512,6 +575,16 @@
       case 's':
 	sig_num = get_signal (optarg, "killall");
         break;
+      case 'u':
+        pwent = getpwnam(optarg);
+        if (pwent != NULL) {
+          uid = pwent->pw_uid;
+          byuser = 1;
+        } else {
+          fprintf (stderr, _("Cannot find user\n"));
+          exit (1);
+        }
+        break;
       case 'v':
         if (pidof)
           usage();
@@ -531,14 +604,25 @@
         break;
 #ifdef WITH_SELINUX
 	case 'Z': 
-	  if( is_selinux_enabled()>0) 
+	  if( is_selinux_enabled()>0) {
 	    scontext=optarg;
-	  else 
+            if (regcomp(&context_regex, scontext, REG_EXTENDED|REG_NOSUB) != 0) {
+              fprintf(stderr, _("Bad regular expression\n"));
+              exit (1);
+            }
+	  } else {
 	    fprintf(stderr, "Warning: -Z (--context) ignored. Requires an SELinux enabled kernel\n");
+	  }
 	  break;
 #endif /*WITH_SELINUX*/
       case '?':
-        /* Signal names are in uppercase, so check to see if the argv
+#ifdef WITH_SELINUX
+        /* Special case the 'Z' option--it's the only uppercase opt with 
+         * an optarg. Otherwise, code below confuses it with a signal. */
+        if (strncmp(argv[optind-1], "-Z", 32) == 0) {
+          usage();
+        }
+#endif /*WITH_SELINUX*/        /* Signal names are in uppercase, so check to see if the argv
          * is upper case */
         if (argv[optind-1][1] >= 'A' && argv[optind-1][1] <= 'Z') 
 	  sig_num = get_signal (argv[optind-1]+1, "killall");
@@ -558,7 +642,11 @@
     }
     */
   myoptind = optind;
-  if (argc - myoptind < 1) 
+#ifdef WITH_SELINUX
+  if ((argc - myoptind < 1) && (byuser == 0) && (scontext == NULL))
+#else
+  if ((argc - myoptind < 1) && (byuser == 0))
+#endif /*WITH_SELINUX*/
     usage();
 
   if (argc - myoptind > MAX_NAMES + 1)
@@ -569,8 +657,16 @@
   argv = argv + myoptind;
   /*printf("sending signal %d to procs\n", sig_num);*/
 #ifdef WITH_SELINUX
-  return kill_all(sig_num,argc - myoptind, argv, scontext);
+  rc = kill_all(sig_num,
+		argc - myoptind,
+		argv,
+		((byuser == 0) ? NULL : &uid),
+		((scontext == NULL) ? NULL : &context_regex));
+  if (scontext != NULL) {
+    regfree(&context_regex);
+  }
+  return rc;
 #else  /*WITH_SELINUX*/
-  return kill_all(sig_num,argc - myoptind, argv );
+  return kill_all(sig_num, argc - myoptind, argv, ((byuser == 0) ? NULL : &uid));
 #endif /*WITH_SELINUX*/
 }
--- psmisc-21.5/doc/killall.1.selinux-user	2005-09-01 16:58:13.000000000 -0400
+++ psmisc-21.5/doc/killall.1	2005-09-01 16:58:13.000000000 -0400
@@ -4,13 +4,16 @@
 .SH SYNOPSIS
 .ad l
 .B killall
-.RB [ \-c , \-\-context ] 
+.RB [ \-Z , \-\-context
+.IR regex ]
 .RB [ \-e , --exact ]
 .RB [ \-g , \-\-process-group ]
 .RB [ \-i , \-\-interactive ]
 .RB [ \-q , \-\-quiet ]
 .RB [ \-s , \-\-signal 
 .IR signal ]
+.RB [ \-u , \-\-user
+.IR user ]
 .RB [ \-v , \-\-verbose ]
 .RB [ \-w , \-\-wait ]
 .RB [ \-V, \-\-version ]
@@ -35,7 +38,9 @@
 particular file will be selected for killing, independent of their name.
 .PP
 \fBkillall\fP returns a zero return code if at least one process has been 
-killed for each listed command. \fBkillall\fP returns non-zero otherwise.
+killed for each listed command, or no commands were listed and at least
+one process matched the -u and -Z search criteria. \fBkillall\fP returns
+non-zero otherwise.
 .PP
 A \fBkillall\fP process never kills itself (but may kill other \fBkillall\fP
 processes).
@@ -59,6 +64,8 @@
 List all known signal names.
 .IP "\fB\-q\fP, \fB\-\-quiet\fP"
 Do not complain if no processes were killed.
+.IP "\fB\-u\fP, \fB\-\-user\fP"
+Kill only processes the specified user owns.  Command names are optional.
 .IP "\fB\-v\fP, \fB\-\-verbose\fP"
 Report if the signal was successfully sent.
 .IP "\fB\-V\fP, \fB\-\-version\fP"
@@ -68,9 +75,9 @@
 any of the killed processes still exist and only returns if none are left.
 Note that \fBkillall\fP may wait forever if the signal was ignored, had no
 effect, or if the process stays in zombie state.
-.IP \fB\-Z\fP
-(SELinux Only) Specify security context: kill only processes with given security context.
-Must precede other arguments on the command line.
+.IP "\fB\-Z\fP, \fB\-\-context\fP"
+(SELinux Only) Kill only processes having a security context that matches the
+given extended regular expression.  Command names are optional.
 .SH FILES
 .nf
 /proc	location of the proc file system

--------------020305070407080107020708--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
