Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA10860
	for <selinux@tycho.nsa.gov>; Mon, 2 Sep 2002 10:54:55 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id OAA29563
	for <selinux@tycho.nsa.gov>; Mon, 2 Sep 2002 14:53:42 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id OAA29559
	for <selinux@tycho.nsa.gov>; Mon, 2 Sep 2002 14:53:38 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 468F092466
	for <selinux@tycho.nsa.gov>; Tue,  3 Sep 2002 00:54:42 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 390FF3B0
	for <selinux@tycho.nsa.gov>; Mon,  2 Sep 2002 16:54:33 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: psmisc
Date: Mon, 2 Sep 2002 16:54:32 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_W2GTTKYHECQRRRDL2YKB"
Message-Id: <200209021654.32794.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_W2GTTKYHECQRRRDL2YKB
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I have attached the latest patch for psmisc that I am using.  I have removed a 
number of gratuitous white-space changes to make it more clear what is being 
changed for SE, and I have initialised the variable sid in main() in the 
killall program to -1 so that "killall process" will work.

I will now send this upstream...

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--------------Boundary-00=_W2GTTKYHECQRRRDL2YKB
Content-Type: text/x-diff;
  charset="us-ascii";
  name="psmisc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="psmisc.diff"

diff -ru orig/psmisc-21/debian/changelog psmisc-21/debian/changelog
--- orig/psmisc-21/debian/changelog	2002-05-21 02:05:07.000000000 +0200
+++ psmisc-21/debian/changelog	2002-09-02 16:46:50.000000000 +0200
@@ -1,3 +1,16 @@
+psmisc (21-3.se2) unstable; urgency=low
+
+  * Removed some of the white-space patches and make killall work when you
+    don't specify a sid/context.
+
+ -- Russell Coker <russell@coker.com.au>  Mon,  2 Sep 2002 16:46:00 +0200
+
+psmisc (21-3.se1) unstable; urgency=low
+
+  * Compile with SE Linux support.
+
+ -- Russell Coker <russell@coker.com.au>  Sat, 27 Jul 2002 15:06:00 +0200
+
 psmisc (21-3) unstable; urgency=low
 
   * build-depends needs gettext otherwise conflicts happen Closes:
diff -ru orig/psmisc-21/doc/killall.1 psmisc-21/doc/killall.1
--- orig/psmisc-21/doc/killall.1	2001-03-25 09:11:05.000000000 +0200
+++ psmisc-21/doc/killall.1	2002-09-02 16:13:37.000000000 +0200
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
diff -ru orig/psmisc-21/doc/pstree.1 psmisc-21/doc/pstree.1
--- orig/psmisc-21/doc/pstree.1	2000-12-14 00:43:09.000000000 +0100
+++ psmisc-21/doc/pstree.1	2002-09-02 16:13:37.000000000 +0200
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
diff -ru orig/psmisc-21/src/Makefile.am psmisc-21/src/Makefile.am
--- orig/psmisc-21/src/Makefile.am	2002-05-15 13:57:17.000000000 +0200
+++ psmisc-21/src/Makefile.am	2002-09-02 16:13:37.000000000 +0200
@@ -1,5 +1,8 @@
 
 CFLAGS = -Wall -DLOCALEDIR=\"/usr/share/locale\"
+DEFS = @DEFS@ -I. -I$(srcdir) -I.. -DFLASK_LINUX
+INCLUDES = -I/usr/include/selinux
+LDADD = /usr/lib/libsecure.a
 
 bin_PROGRAMS = fuser killall pstree
 
@@ -9,7 +12,7 @@
 
 pstree_SOURCES = pstree.c comm.h
 
-pstree_LDADD = @TERMCAP_LIB@
+pstree_LDADD = @TERMCAP_LIB@ $(LDADD)
 
 BUILT_SOURCES = signames.h
 
diff -ru orig/psmisc-21/src/Makefile.in psmisc-21/src/Makefile.in
--- orig/psmisc-21/src/Makefile.in	2002-05-15 14:03:39.000000000 +0200
+++ psmisc-21/src/Makefile.in	2002-09-02 16:13:37.000000000 +0200
@@ -1,6 +1,6 @@
-# Makefile.in generated automatically by automake 1.4 from Makefile.am
+# Makefile.in generated automatically by automake 1.4-p5 from Makefile.am
 
-# Copyright (C) 1994, 1995-8, 1999 Free Software Foundation, Inc.
+# Copyright (C) 1994, 1995-8, 1999, 2001 Free Software Foundation, Inc.
 # This Makefile.in is free software; the Free Software Foundation
 # gives unlimited permission to copy and/or distribute it,
 # with or without modifications, as long as this notice is preserved.
@@ -92,6 +92,9 @@
 VERSION = @VERSION@
 
 CFLAGS = -Wall -DLOCALEDIR=\"/usr/share/locale\"
+DEFS = @DEFS@ -I. -I$(srcdir) -I.. -DFLASK_LINUX
+INCLUDES = -I/usr/include/selinux
+LDADD = /usr/lib/libsecure.a
 
 bin_PROGRAMS = fuser killall pstree
 
@@ -101,7 +104,7 @@
 
 pstree_SOURCES = pstree.c comm.h
 
-pstree_LDADD = @TERMCAP_LIB@
+pstree_LDADD = @TERMCAP_LIB@ $(LDADD)
 
 BUILT_SOURCES = signames.h
 
@@ -113,21 +116,19 @@
 CONFIG_CLEAN_FILES = 
 PROGRAMS =  $(bin_PROGRAMS)
 
-
-DEFS = @DEFS@ -I. -I$(srcdir) -I..
 CPPFLAGS = @CPPFLAGS@
 LDFLAGS = @LDFLAGS@
 LIBS = @LIBS@
 fuser_OBJECTS =  fuser.o signals.o
 fuser_LDADD = $(LDADD)
-fuser_DEPENDENCIES = 
+fuser_DEPENDENCIES =  /usr/lib/libsecure.a
 fuser_LDFLAGS = 
 killall_OBJECTS =  killall.o signals.o
 killall_LDADD = $(LDADD)
-killall_DEPENDENCIES = 
+killall_DEPENDENCIES =  /usr/lib/libsecure.a
 killall_LDFLAGS = 
 pstree_OBJECTS =  pstree.o
-pstree_DEPENDENCIES = 
+pstree_DEPENDENCIES =  /usr/lib/libsecure.a
 pstree_LDFLAGS = 
 COMPILE = $(CC) $(DEFS) $(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS)
 LTCOMPILE = $(LIBTOOL) --mode=compile $(CC) $(DEFS) $(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS)
@@ -247,7 +248,7 @@
 	  awk '    { files[$$0] = 1; } \
 	       END { for (i in files) print i; }'`; \
 	test -z "$(ETAGS_ARGS)$$unique$(LISP)$$tags" \
-	  || (cd $(srcdir) && etags $(ETAGS_ARGS) $$tags  $$unique $(LISP) -o $$here/TAGS)
+	  || (cd $(srcdir) && etags -o $$here/TAGS $(ETAGS_ARGS) $$tags  $$unique $(LISP))
 
 mostlyclean-tags:
 
@@ -273,11 +274,6 @@
 	    || cp -p $$d/$$file $(distdir)/$$file || :; \
 	  fi; \
 	done
-fuser.o: fuser.c ../config.h comm.h loop.h signals.h
-killall.o: killall.c ../config.h comm.h signals.h
-pstree.o: pstree.c ../config.h comm.h
-signals.o: signals.c signals.h signames.h
-
 info-am:
 info: info-am
 dvi-am:
diff -ru orig/psmisc-21/src/killall.c psmisc-21/src/killall.c
--- orig/psmisc-21/src/killall.c	2001-06-13 03:20:21.000000000 +0200
+++ psmisc-21/src/killall.c	2002-09-02 16:45:45.000000000 +0200
@@ -16,6 +16,10 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <getopt.h>
+#ifdef FLASK_LINUX
+#include <fs_secure.h>
+#include <ss.h>
+#endif /*FLASK_LINUX*/
 #include <libintl.h>
 #include <locale.h>
 #define _(String) gettext (String)
@@ -55,9 +59,13 @@
   return ch == 'y' || ch == 'Y';
 }
 
-
+#ifdef FLASK_LINUX
+static int
+kill_all(int signal, int names, char **namelist, security_id_t sid )
+#else  /*FLASK_LINUX*/
 static int
 kill_all (int signal, int names, char **namelist)
+#endif /*FLASK_LINUX*/
 {
   DIR *dir;
   struct dirent *de;
@@ -72,23 +80,36 @@
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
@@ -206,14 +227,30 @@
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
@@ -307,7 +344,11 @@
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
@@ -319,6 +360,12 @@
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
 
 
@@ -349,7 +396,7 @@
   int sig_num;
   int optc;
   int myoptind;
-  int optsig = 0;
+  //int optsig = 0;
 
   struct option options[] = {
     {"exact", 0, NULL, 'e'},
@@ -360,9 +407,19 @@
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
+  security_id_t sid = -1;
+
+  if ( argc < 2 ) usage(); /* do the obvious thing... */
+#endif /*FLASK_LINUX*/
+
   name = strrchr (*argv, '/');
   if (name)
     name++;
@@ -377,7 +434,7 @@
   textdomain(PACKAGE);
 
   opterr = 0;
-  while ( (optc = getopt_long_only(argc,argv,"egilqs:vwV",options,NULL)) != EOF) {
+  while ( (optc = getopt_long_only(argc,argv,"egilqs:vwS:c:V",options,NULL)) != EOF) {
     switch (optc) {
       case 'e':
         exact = 1;
@@ -418,6 +475,46 @@
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
@@ -449,5 +546,9 @@
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
diff -ru orig/psmisc-21/src/pstree.c psmisc-21/src/pstree.c
--- orig/psmisc-21/src/pstree.c	2001-10-18 00:42:23.000000000 +0200
+++ psmisc-21/src/pstree.c	2002-09-02 16:41:04.000000000 +0200
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
+new_proc(const char *comm, pid_t pid, uid_t uid, security_id_t sid)
+#else  /*FLASK_LINUX*/
 static PROC *
 new_proc (const char *comm, pid_t pid, uid_t uid)
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
@@ -253,15 +302,24 @@
     this->argv[i] = start = strchr (start, 0) + 1;
 }
 
-
+#ifdef FLASK_LINUX
+static void
+add_proc(const char *comm, pid_t pid, pid_t ppid, uid_t uid,
+         const char *args, int size, security_id_t sid)
+#else  /*FLASK_LINUX*/
 static void
 add_proc (const char *comm, pid_t pid, pid_t ppid, uid_t uid,
 	  const char *args, int size)
+#endif /*FLASK_LINUX*/
 {
   PROC *this, *parent;
 
   if (!(this = find_proc (pid)))
+#ifdef FLASK_LINUX
+    this = new_proc(comm, pid, uid, sid);
+#else  /*FLASK_LINUX*/
     this = new_proc (comm, pid, uid);
+#endif /*FLASK_LINUX*/
   else
     {
       strcpy (this->comm, comm);
@@ -272,7 +330,11 @@
   if (pid == ppid)
     ppid = 0;
   if (!(parent = find_proc (ppid)))
+#ifdef FLASK_LINUX
+    parent = new_proc("?", ppid, 0, sid);
+#else  /*FLASK_LINUX*/
     parent = new_proc ("?", ppid, 0);
+#endif /*FLASK_LINUX*/
   add_child (parent, this);
   this->parent = parent;
 }
@@ -364,11 +426,25 @@
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
+#ifdef FLASK_LINUX
+  if (show_scontext || print_args)
+#else  /*FLASK_LINUX*/
   if (print_args)
+#endif /*FLASK_LINUX*/
     {
       for (i = 0; i < current->argc; i++)
 	{
@@ -392,12 +468,20 @@
 	    }
 	}
     }
+#ifdef FLASK_LINUX
+  if ( show_scontext || print_args || ! current->children )
+#else  /*FLASK_LINUX*/
   if (print_args || !current->children)
+#endif /*FLASK_LINUX*/
     {
       while (closing--)
 	out_char (']');
       out_newline ();
+#ifdef FLASK_LINUX
+      if ( show_scontext || print_args )
+#else /*FLASK_LINUX*/
       if (print_args)
+#endif /*FLASK_LINUX*/
 	{
 	  more[level] = !last;
 	  width[level] = swapped + (comm_len > 1 ? 0 : -1);
@@ -487,6 +571,9 @@
   pid_t pid, ppid;
   int fd, size;
   int empty;
+#ifdef FLASK_LINUX
+  security_id_t sid = -1;
+#endif /*FLASK_LINUX*/
 
   if (!print_args)
     buffer = NULL;
@@ -509,7 +596,11 @@
 	  {
 	    empty = 0;
             sprintf (path, "%s/%d", PROC_BASE, pid);
+#ifdef FLASK_LINUX
+            if (fstat_secure(fileno(file),&st,&sid) < 0)
+#else /*FLASK_LINUX*/
             if (stat (path, &st) < 0)
+#endif /*FLASK_LINUX*/
 	    {
 		perror (path);
 		exit (1);
@@ -534,7 +625,11 @@
 		 &ppid) == 4)
 	      */
 		if (!print_args)
+#ifdef FLASK_LINUX
+		  add_proc(comm, pid, ppid, st.st_uid, NULL, 0, sid);
+#else  /*FLASK_LINUX*/
 		  add_proc (comm, pid, ppid, st.st_uid, NULL, 0);
+#endif /*FLASK_LINUX*/
 		else
 		  {
 		    sprintf (path, "%s/%d/cmdline", PROC_BASE, pid);
@@ -551,7 +646,11 @@
 		    (void) close (fd);
 		    if (size)
 		      buffer[size++] = 0;
+#ifdef FLASK_LINUX
+		    add_proc(comm, pid, ppid, st.st_uid, buffer, size, sid);
+#else  /*FLASK_LINUX*/
 		    add_proc (comm, pid, ppid, st.st_uid, buffer, size);
+#endif /*FLASK_LINUX*/
 		  }
 	      } } }
 	    (void) fclose (file);
@@ -587,7 +686,11 @@
 	cmd = comm;
       if (*cmd == '-')
 	cmd++;
+#ifdef FLASK_LINUX
+      add_proc(cmd, pid, ppid, uid, NULL, 0, -1);
+#else  /*FLASK_LINUX*/
       add_proc (cmd, pid, ppid, uid, NULL, 0);
+#endif /*FLASK_LINUX*/
     }
 }
 
@@ -612,6 +715,10 @@
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
@@ -638,7 +745,11 @@
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
@@ -695,6 +806,14 @@
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

--------------Boundary-00=_W2GTTKYHECQRRRDL2YKB--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
