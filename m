Message-ID: <3C16408B.1010503@pcez.com>
Date: Tue, 11 Dec 2001 09:21:15 -0800
From: Shaun Savage <savages@pcez.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_homegate.savages.net-32487-1008091476-0001-2"
CC: SELinux@tycho.nsa.gov
Subject: RH72 psmisc patch
References: <Pine.GSO.4.33.0112110830440.13843-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_homegate.savages.net-32487-1008091476-0001-2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Here is a patch for psmisc-20.1
do rpm -bp psmisc.spec
then apply this patch.
run autoconf   (make sure you upgrade to 2.52)
then run rpm -bc --shortcircuit psmisc.spec
then rpm -bi --short-circuit psmisc.spec

I upgraded to the new selinux-20011210.....
I found a problem with the fileutils patch i submitted yesterday.  'df' 
security segfaults.

Shaun Savage

--=_homegate.savages.net-32487-1008091476-0001-2
Content-Type: text/plain; name="psmisc-20.1-selinux.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="psmisc-20.1-selinux.patch"

diff -Nur psmisc-20.1/acconfig.h psmisc-20.1-ok/acconfig.h
--- psmisc-20.1/acconfig.h	Wed Dec 31 16:00:00 1969
+++ psmisc-20.1-ok/acconfig.h	Mon Dec 10 15:46:06 2001
@@ -0,0 +1,2 @@
+/* SELinux */
+#undef FLASK_LINUX
diff -Nur psmisc-20.1/configure.in psmisc-20.1-ok/configure.in
--- psmisc-20.1/configure.in	Sat Mar 24 15:07:07 2001
+++ psmisc-20.1-ok/configure.in	Mon Dec 10 15:45:44 2001
@@ -1,8 +1,25 @@
 dnl Process this file with autoconf to produce a configure script.
-AC_INIT(src/comm.h)
+AC_INIT
+AC_CONFIG_SRCDIR([src/comm.h])
 AM_CONFIG_HEADER(config.h)
 AM_INIT_AUTOMAKE(psmisc,20.1)
 
+dnl Set of available languages.
+ALL_LINGUAS="de fr es ko nl no pl pt sl sv"
+
+
+dnl Make Flask security-enhanced versions of fileutils
+dnl Should add existence chackes for libsecure library, etc
+dnl   CFLAGS="$CFLAGS -DFLASK_LINUX  -I/usr/flask/include -I/usr/src/linux/include"
+dnl   LIBS="$LIBS -L/usr/flask/lib -lsecure"
+
+AC_ARG_WITH(selinux,
+[  --with-selinux            include support for SELinux],
+[  AC_DEFINE(FLASK_LINUX)
+   CFLAGS="$CFLAGS -I/usr/local/selinux/include -Wall"
+   DEFS="-DFLASK_LINUX"
+   LIBS="$LIBS -L/usr/local/selinux/lib -lsecure"])
+
 dnl Checks for programs.
 AC_PROG_CC
 AC_PROG_CPP
@@ -22,10 +39,27 @@
 AC_C_CONST
 AC_TYPE_PID_T
 AC_TYPE_SIZE_T
-AC_STRUCT_ST_RDEV
+AC_DIAGNOSE([obsolete],[AC_DIAGNOSE([obsolete],[AC_STRUCT_ST_RDEV:
+        your code should no longer depend upon `HAVE_ST_RDEV', but
+        `HAVE_STRUCT_STAT_ST_RDEV'.  Remove this warning and
+        the `AC_DEFINE' when you adjust the code.])
+AC_CHECK_MEMBERS([struct stat.st_rdev],[AC_DEFINE(HAVE_ST_RDEV, 1,
+                            [Define if your `struct stat' has `st_rdev'.
+                             Deprecated, use `HAVE_STRUCT_STAT_ST_RDEV'
+                             instead.])])
+:
+        your code should no longer depend upon `HAVE_ST_RDEV', but
+        `HAVE_STRUCT_STAT_ST_RDEV'.  Remove this warning and
+        the `AC_DEFINE' when you adjust the code.])
+AC_CHECK_MEMBERS([struct stat.st_rdev],[AC_DEFINE(HAVE_ST_RDEV, 1,
+                            [Define if your `struct stat' has `st_rdev'.
+                             Deprecated, use `HAVE_STRUCT_STAT_ST_RDEV'
+                             instead.])])
+
 AC_TYPE_UID_T
 
 dnl Checks for library functions.
 AC_CHECK_FUNCS(strdup strerror strtoul)
 
-AC_OUTPUT(Makefile doc/Makefile src/Makefile)
+AC_CONFIG_FILES([Makefile doc/Makefile src/Makefile])
+AC_OUTPUT
diff -Nur psmisc-20.1/doc/killall.1 psmisc-20.1-ok/doc/killall.1
--- psmisc-20.1/doc/killall.1	Sat Mar 24 23:11:05 2001
+++ psmisc-20.1-ok/doc/killall.1	Tue Dec 11 09:03:47 2001
@@ -11,6 +11,8 @@
 .RB [ \-v , \-\-verbose ]
 .RB [ \-w , \-\-wait ]
 .RB [ \-V, \-\-version ]
+.RB [ \-S , \-\-sid ]
+.RB [ \-c , \-\-context ] 
 .RB [ \-s , \-\-signal
 .IR signal ]
 .RB [ \-\- ]
@@ -66,6 +68,12 @@
 any of the killed processes still exist and only returns if none are left.
 Note that \fBkillall\fP may wait forever if the signal was ignored, had no
 effect, or if the process stays in zombie state.
+.IP \fB\-S\fP
+(Flask only) Specify SID: kill only processes with given SID. Mutually exclusive
+with \fB-c\fP argument.  Must precede other arguments on command line.
+.IP \fB\-c\fP
+(Flask only) Specify security context: kill only processes with given security context.
+Mutually exclusive with \fB-s\fP.  Must precede other arguments on the command line.
 .SH FILES
 .nf
 /proc	location of the proc file system
diff -Nur psmisc-20.1/doc/pstree.1 psmisc-20.1-ok/doc/pstree.1
--- psmisc-20.1/doc/pstree.1	Wed Dec 13 15:43:09 2000
+++ psmisc-20.1-ok/doc/pstree.1	Tue Dec 11 09:03:48 2001
@@ -74,6 +74,10 @@
 with \fBecho -e '\\033%@'\fP
 .IP \fB\-V\fP
 Display version information.
+.IP \fB\-s\fP
+(Flask) Show Security ID (SID) for each process.
+.IP \fB\-x\fP
+(Flask) Show security context for each process.
 .SH FILES
 .nf
 /proc	location of the proc file system
diff -Nur psmisc-20.1/src/Makefile.am psmisc-20.1-ok/src/Makefile.am
--- psmisc-20.1/src/Makefile.am	Sun Mar 18 19:00:13 2001
+++ psmisc-20.1-ok/src/Makefile.am	Tue Dec 11 08:53:21 2001
@@ -1,5 +1,4 @@
 
-CFLAGS = -Wall
 
 bin_PROGRAMS = fuser killall pstree
 
diff -Nur psmisc-20.1/src/killall.c psmisc-20.1-ok/src/killall.c
--- psmisc-20.1/src/killall.c	Sat Mar 31 02:26:47 2001
+++ psmisc-20.1-ok/src/killall.c	Tue Dec 11 09:02:48 2001
@@ -16,6 +16,9 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <getopt.h>
+#ifdef FLASK_LINUX
+#include <fs_secure.h>
+#endif /*FLASK_LINUX*/
 
 #include "comm.h"
 #include "signals.h"
@@ -52,9 +55,13 @@
   return ch == 'y' || ch == 'Y';
 }
 
-
-static int
-kill_all (int signal, int names, char **namelist)
+#ifdef FLASK_LINUX
+static int 
+kill_all(int signal,int names,char **namelist, security_id_t sid )
+#else  /*FLASK_LINUX*/
+static int 
+kill_all(int signal,int names,char **namelist)
+#endif /*FLASK_LINUX*/
 {
   DIR *dir;
   struct dirent *de;
@@ -69,23 +76,36 @@
   int empty, i, j, okay, length, got_long, error;
   int pids, max_pids, pids_killed;
   unsigned long found;
+#ifdef FLASK_LINUX
+  security_id_t lsid;
+
+  if ( names == 0 || ! namelist ) exit( 1 ); /* do the obvious thing...*/
+#endif /*FLASK_LINUX*/
 
   if (!(name_len = malloc (sizeof (int) * names)))
     {
       perror ("malloc");
       exit (1);
     }
-  for (i = 0; i < names; i++)
+  for (i = 0; i < names; i++) {
     if (!strchr (namelist[i], '/'))
       {
 	sts[i].st_dev = 0;
 	name_len[i] = strlen (namelist[i]);
       }
+#ifdef FLASK_LINUX
+      else if (stat_secure(namelist[i],&sts[i], &lsid) < 0) {
+              perror(namelist[i]);
+              exit(1);
+          }
+#else  /*FLASK_LINUX*/
     else if (stat (namelist[i], &sts[i]) < 0)
       {
 	perror (namelist[i]);
 	exit (1);
       }
+#endif /*FLASK_LINUX*/
+   } 
   self = getpid ();
   found = 0;
   if (!(dir = opendir (PROC_BASE)))
@@ -203,14 +223,30 @@
 	      else if (got_long ? strcmp (namelist[j], command) :
 		       strncmp (namelist[j], comm, COMM_LEN - 1))
 		continue;
+#ifdef FLASK_LINUX
+              if ( (int) sid > 0 ) {
+                if ( stat_secure(path, &st, &lsid) < 0 )
+                  continue;
+                if ( lsid != sid )
+                  continue;
+              }
+#endif /*FLASK_LINUX*/
 	    }
 	  else
 	    {
 	      sprintf (path, PROC_BASE "/%d/exe", pid_table[i]);
+#ifdef FLASK_LINUX
+              if (stat_secure(path,&st,&lsid) < 0) continue;
+              if (sts[j].st_dev != st.st_dev ||
+                  sts[j].st_ino != st.st_ino ||
+                  ((int) sid > 0 && (lsid != sid)) )
+                  continue;
+#else  /*FLASK_LINUX*/
 	      if (stat (path, &st) < 0)
 		continue;
 	      if (sts[j].st_dev != st.st_dev || sts[j].st_ino != st.st_ino)
 		continue;
+#endif /*FLASK_LINUX*/
 	    }
 	  if (!process_group)
 	    id = pid_table[i];
@@ -304,7 +340,11 @@
 static void
 usage_killall (void)
 {
+#ifdef FLASK_LINUX
+  fprintf(stderr,"Usage: killall [-s sid] [-c context] [ -egiqvw ] [ -signal ] name ...\n");
+#else  /*FLASK_LINUX*/
   fprintf (stderr, "usage: killall [ OPTIONS ] [ -- ] name ...\n");
+#endif /*FLASK_LINUX*/
   fprintf (stderr, "       killall -l, --list\n");
   fprintf (stderr, "       killall -V --version\n\n");
   fprintf (stderr, "  -e,--exact          require exact match for very long names\n");
@@ -316,6 +356,12 @@
   fprintf (stderr, "  -v,--verbose        report if the signal was successfully sent\n");
   fprintf (stderr, "  -V,--version        display version information\n");
   fprintf (stderr, "  -w,--wait           wait for processes to die\n\n");
+#ifdef FLASK_LINUX
+  fprintf (stderr, "  -S,--Sid            kill only process(es) having sid\n");
+  fprintf (stderr, "  -c,--context        kill only process(es) having scontext\n");
+  fprintf(stderr, "   (-s, -c are mutually exclusive and must precede other
+arguments)\n\n");
+#endif /*FLASK_LINUX*/
 }
 
 
@@ -346,7 +392,7 @@
   int sig_num;
   int optc;
   int myoptind;
-  int optsig = 0;
+  //int optsig = 0;
 
   struct option options[] = {
     {"exact", 0, NULL, 'e'},
@@ -357,9 +403,20 @@
     {"signal", 1, NULL, 's'},
     {"verbose", 0, NULL, 'v'},
     {"wait", 0, NULL, 'w'},
+#ifdef FLASK_LINUX
+    {"Sid", 1, NULL, 'S'},
+    {"context", 1, NULL, 'c'},
+#endif /*FLASK_LINUX*/
     {"version", 0, NULL, 'V'},
     {0,0,0,0 }};
 
+#ifdef FLASK_LINUX
+  security_id_t sid;
+  int  security_context_to_sid(), security_sid_to_context();
+
+  if ( argc < 2 ) usage(); /* do the obvious thing... */
+#endif /*FLASK_LINUX*/
+
   name = strrchr (*argv, '/');
   if (name)
     name++;
@@ -369,7 +426,7 @@
   sig_num = SIGTERM;
 
   opterr = 0;
-  while ( (optc = getopt_long_only(argc,argv,"egilqs:vwV",options,NULL)) != EOF) {
+  while ( (optc = getopt_long_only(argc,argv,"egilqs:vwS:c:V",options,NULL)) != EOF) {
     switch (optc) {
       case 'e':
         exact = 1;
@@ -410,6 +467,46 @@
         print_version();
         return 0;
         break;
+#ifdef FLASK_LINUX
+      case 'S': {
+          char **buf, *calloc();
+          int strlen(), rv;
+          security_id_t lsid;
+
+          buf = (char **) calloc(1, strlen(optarg));
+          if ( ! buf ) {
+             (void) fprintf(stderr, "%s: %s\n", name, strerror(errno));
+             return( 1 );
+          }
+
+	  lsid = strtol(optarg, buf, 0);
+          if ( **buf ) {
+              (void) fprintf(stderr, "%s: SID (%s) must be numeric\n", name, *argv);
+              (void) fflush(stderr);
+              return( 1 );
+          }
+
+          sid = (security_id_t) lsid;
+          /* sanity check */
+          rv = security_sid_to_context(sid, buf, strlen(optarg));
+          if ( rv < 0 && (errno != ENOSPC) ) {
+              (void) fprintf(stderr, "%s: security_sid_to_context(%d) %s\n", name, (int) sid, strerror(errno));
+              (void) fflush(stderr);
+              free(buf);
+              return( 1 );
+          }
+          free(buf);
+          break;
+      }
+      case 'c': {
+          if ( security_context_to_sid(optarg, strlen(optarg)+1, &sid) ) {
+              (void) fprintf(stderr, "%s: security_context_to_sid(%s): %s\n",
+                     name, optarg, strerror(errno));
+              (void) fflush(stderr);
+              return( 1 );
+          }
+      }
+#endif /*FLASK_LINUX*/
       case '?':
         /* Signal names are in uppercase, so check to see if the argv
          * is upper case */
@@ -441,5 +538,9 @@
     }
   argv = argv + myoptind;
   /*printf("sending signal %d to procs\n", sig_num);*/
-  return kill_all (sig_num, argc - myoptind, argv );
+#ifdef FLASK_LINUX
+  return kill_all(sig_num,argc - myoptind, argv, sid);
+#else  /*FLASK_LINUX*/
+  return kill_all(sig_num,argc - myoptind, argv );
+#endif /*FLASK_LINUX*/
 }
diff -Nur psmisc-20.1/src/pstree.c psmisc-20.1-ok/src/pstree.c
--- psmisc-20.1/src/pstree.c	Sun Dec 17 21:59:23 2000
+++ psmisc-20.1-ok/src/pstree.c	Tue Dec 11 09:02:48 2001
@@ -23,6 +23,9 @@
 
 #include "comm.h"
 
+#ifdef FLASK_LINUX
+#include <fs_secure.h>
+#endif /*FLASK_LINUX*/
 
 #ifndef MAX_DEPTH
 #define MAX_DEPTH    100
@@ -51,6 +54,9 @@
   int argc;			/* with -a   : number of arguments, -1 if swapped    */
   pid_t pid;
   uid_t uid;
+#ifdef FLASK_LINUX
+  security_id_t sid;
+#endif /*FLASK_LINUX*/
   int highlight;
   struct _child *children;
   struct _proc *parent;
@@ -98,6 +104,10 @@
 static int width[MAX_DEPTH], more[MAX_DEPTH];
 static int print_args = 0, compact = 1, user_change = 0, pids = 0, by_pid = 0,
   trunc = 1;
+#ifdef FLASK_LINUX
+static int show_sids    = 0;
+static int show_scontext = 0;
+#endif /*FLASK_LINUX*/
 static int output_width = 132;
 static int cur_x = 1;
 static char last_char = 0;
@@ -147,6 +157,38 @@
   return digits;
 }
 
+#ifdef FLASK_LINUX
+static void 
+out_sid ( security_id_t sid )
+{
+  if ( (int) sid >= 0 )
+    out_int((int) sid);
+  else
+    out_string("??");
+}
+
+static void 
+out_scontext ( security_id_t sid )
+{
+  static char buf[256];
+  int security_sid_to_context();
+  int len = sizeof(buf);
+  int rv;
+
+  bzero(buf,256);
+
+  rv = security_sid_to_context((int)sid, buf, &len);
+  if ( rv ) {
+    out_string("`??'"); /* punt */
+  }
+  else {
+    out_string("`");
+    out_string(buf);
+    out_string("'");
+  }
+}
+#endif /*FLASK_LINUX*/
+
 
 static void
 out_newline (void)
@@ -170,9 +212,13 @@
   return walk;
 }
 
-
+#ifdef FLASK_LINUX
+static PROC *
+new_proc(const char *comm,pid_t pid,uid_t uid, security_id_t sid)
+#else  /*FLASK_LINUX*/
 static PROC *
-new_proc (const char *comm, pid_t pid, uid_t uid)
+new_proc(const char *comm,pid_t pid,uid_t uid)
+#endif /*FLASK_LINUX*/
 {
   PROC *new;
 
@@ -185,6 +231,9 @@
   new->pid = pid;
   new->uid = uid;
   new->highlight = 0;
+#ifdef FLASK_LINUX
+  new->sid = sid;
+#endif /*FLASK_LINUX*/
   new->children = NULL;
   new->parent = NULL;
   new->next = list;
@@ -253,15 +302,23 @@
     this->argv[i] = start = strchr (start, 0) + 1;
 }
 
-
-static void
-add_proc (const char *comm, pid_t pid, pid_t ppid, uid_t uid,
-	  const char *args, int size)
+#ifdef FLASK_LINUX
+static void 
+add_proc(const char *comm, pid_t pid, pid_t ppid, uid_t uid,
+         const char *args, int size, security_id_t sid)
+#else  /*FLASK_LINUX*/
+static void 
+add_proc(const char *comm, pid_t pid, pid_t ppid, uid_t uid,
+         const char *args, int size)
+#endif /*FLASK_LINUX*/
 {
   PROC *this, *parent;
 
-  if (!(this = find_proc (pid)))
-    this = new_proc (comm, pid, uid);
+#ifdef FLASK_LINUX
+  if (!(this = find_proc(pid))) this = new_proc(comm,pid,uid,sid);
+#else  /*FLASK_LINUX*/
+  if (!(this = find_proc(pid))) this = new_proc(comm,pid,uid);
+#endif /*FLASK_LINUX*/
   else
     {
       strcpy (this->comm, comm);
@@ -271,8 +328,11 @@
     set_args (this, args, size);
   if (pid == ppid)
     ppid = 0;
-  if (!(parent = find_proc (ppid)))
-    parent = new_proc ("?", ppid, 0);
+#ifdef FLASK_LINUX
+  if (!(parent = find_proc(ppid))) parent = new_proc("?",ppid,0,sid);
+#else  /*FLASK_LINUX*/
+  if (!(parent = find_proc(ppid))) parent = new_proc("?",ppid,0);
+#endif /*FLASK_LINUX*/
   add_child (parent, this);
   this->parent = parent;
 }
@@ -364,12 +424,25 @@
       else
 	(void) out_int (current->uid);
     }
+#ifdef FLASK_LINUX
+  if ( show_sids ) {
+      out_char(',');
+      out_sid(current->sid);
+  }
+  if ( show_scontext ) {
+      out_char(',');
+      out_scontext(current->sid);
+  }
+#endif /*FLASK_LINUX*/
   if (info || swapped)
     out_char (')');
   if (current->highlight && (tmp = tgetstr ("me", NULL)))
     tputs (tmp, 1, putchar);
-  if (print_args)
-    {
+#ifdef FLASK_LINUX
+  if (show_scontext || print_args) {
+#else  /*FLASK_LINUX*/
+  if (print_args) {
+#endif /*FLASK_LINUX*/
       for (i = 0; i < current->argc; i++)
 	{
 	  out_char (' ');
@@ -392,13 +465,19 @@
 	    }
 	}
     }
-  if (print_args || !current->children)
-    {
+#ifdef FLASK_LINUX
+  if ( show_scontext || print_args || ! current->children ) {
+#else  /*FLASK_LINUX*/
+  if (print_args || !current->children) {
+#endif /*FLASK_LINUX*/
       while (closing--)
 	out_char (']');
       out_newline ();
-      if (print_args)
-	{
+#ifdef FLASK_LINUX
+      if ( show_scontext || print_args ) {
+#else /*FLASK_LINUX*/
+      if (print_args) {
+#endif /*FLASK_LINUX*/
 	  more[level] = !last;
 	  width[level] = swapped + (comm_len > 1 ? 0 : -1);
 	  for (walk = current->children; walk; walk = walk->next)
@@ -487,6 +566,9 @@
   pid_t pid, ppid;
   int fd, size;
   int empty;
+#ifdef FLASK_LINUX
+  security_id_t sid = -1;
+#endif /*FLASK_LINUX*/
 
   if (!print_args)
     buffer = NULL;
@@ -508,8 +590,11 @@
 	if ((file = fopen (path, "r")) != NULL)
 	  {
 	    empty = 0;
-	    if (fstat (fileno (file), &st) < 0)
-	      {
+#ifdef FLASK_LINUX
+            if (fstat_secure(fileno(file),&st,&sid) < 0) {
+#else /*FLASK_LINUX*/
+            if (fstat(fileno(file),&st) < 0) {
+#endif /*FLASK_LINUX*/
 		perror (path);
 		exit (1);
 	      }
@@ -533,7 +618,11 @@
 		 &ppid) == 4)
 	      */
 		if (!print_args)
-		  add_proc (comm, pid, ppid, st.st_uid, NULL, 0);
+#ifdef FLASK_LINUX
+                  add_proc(comm,pid,ppid,st.st_uid,NULL,0,sid);
+#else  /*FLASK_LINUX*/
+                  add_proc(comm,pid,ppid,st.st_uid,NULL,0);
+#endif /*FLASK_LINUX*/
 		else
 		  {
 		    sprintf (path, "%s/%d/cmdline", PROC_BASE, pid);
@@ -550,7 +639,11 @@
 		    (void) close (fd);
 		    if (size)
 		      buffer[size++] = 0;
-		    add_proc (comm, pid, ppid, st.st_uid, buffer, size);
+#ifdef FLASK_LINUX
+                    add_proc(comm, pid, ppid, st.st_uid, buffer, size, sid);
+#else  /*FLASK_LINUX*/
+                    add_proc(comm, pid, ppid, st.st_uid, buffer, size);
+#endif /*FLASK_LINUX*/
 		  }
 	      } } }
 	    (void) fclose (file);
@@ -586,7 +679,11 @@
 	cmd = comm;
       if (*cmd == '-')
 	cmd++;
-      add_proc (cmd, pid, ppid, uid, NULL, 0);
+#ifdef FLASK_LINUX
+      add_proc(cmd, pid, ppid, uid, NULL, 0, -1);
+#else  /*FLASK_LINUX*/
+      add_proc(cmd, pid, ppid, uid, NULL, 0);
+#endif /*FLASK_LINUX*/
     }
 }
 
@@ -611,6 +708,10 @@
   fprintf (stderr, "    -n     sort output by PID\n");
   fprintf (stderr, "    -p     show PIDs; implies -c\n");
   fprintf (stderr, "    -u     show uid transitions\n");
+#ifdef FLASK_LINUX
+  fprintf (stderr, "    -s     show Flask SIDs\n");
+  fprintf (stderr, "    -x     show Flask security contexts\n");
+#endif /*FLASK_LINUX*/
   fprintf (stderr,
 	   "    -U     use UTF-8 (Unicode) line drawing characters\n");
   fprintf (stderr, "    -V     display version information\n");
@@ -637,7 +738,11 @@
   pid = 1;
   highlight = 0;
   pw = NULL;
+#ifdef FLASK_LINUX
+  while ((c = getopt (argc, argv, "acGhH:npluUVsx")) != EOF)
+#else  /*FLASK_LINUX*/
   while ((c = getopt (argc, argv, "acGhH:npluUV")) != EOF)
+#endif /*FLASK_LINUX*/
     switch (c)
       {
       case 'a':
@@ -694,6 +799,14 @@
       case 'V':
 	fprintf (stderr, "pstree from psmisc version %s\n", VERSION);
 	return 0;
+#ifdef FLASK_LINUX
+      case 's':
+        show_sids = 1;
+        break;
+      case 'x':
+        show_scontext = 1;
+        break;
+#endif /*FLASK_LINUX*/
       default:
 	usage ();
       }

--=_homegate.savages.net-32487-1008091476-0001-2--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
