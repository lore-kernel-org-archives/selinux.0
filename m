Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9J4r6Wt015371
	for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 00:53:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9J4qt0p017415
	for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 04:52:55 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h9J4qnr7017412
	for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 04:52:53 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 1FDD3924F3
	for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 14:52:49 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id B3D1E7F03A
	for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 14:52:43 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: old SE Linux patch for procps 3.1.12
Date: Sun, 19 Oct 2003 14:52:43 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_bihk/o5x5Pm2ACq"
Message-Id: <200310191452.43127.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_bihk/o5x5Pm2ACq
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Procps includes SE Linux support upstream, but it's a bit outdated.

I have attached a patch to remove support for displaying SIDs.  It is a bit 
rough and has a memory leak (allocates textual representations of contexts 
but never frees them - may be a problem for "top").

I wrote this because I couldn't figure out how to get a straight patch for the 
new SE Linux, so I updated the old SE Linux code to be more like the new SE 
Linux code as an intermediate step.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_bihk/o5x5Pm2ACq
Content-Type: text/x-diff;
  charset="us-ascii";
  name="p.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="p.diff"

diff -ruN orig/procps-3.1.12/Makefile procps-3.1.12/Makefile
--- orig/procps-3.1.12/Makefile	2003-09-13 15:25:27.000000000 +1000
+++ procps-3.1.12/Makefile	2003-10-19 13:44:53.000000000 +1000
@@ -166,13 +166,13 @@
 ############ prog.o --> prog
 
 pmap w uptime tload free sysctl vmstat utmp pgrep skill: % : %.o $(LIBPROC)
-	$(CC) $(ALL_CFLAGS) $(ALL_LDFLAGS) -o $@ $^
+	$(CC) $(ALL_CFLAGS) $^ $(ALL_LDFLAGS) -o $@
 
 top:   % : %.o $(LIBPROC)
-	$(CC) $(ALL_CFLAGS) $(ALL_LDFLAGS) -o $@ $^ $(CURSES)
+	$(CC) $(ALL_CFLAGS) $^ $(ALL_LDFLAGS) -o $@ $(CURSES)
 
 watch: % : %.o
-	$(CC) $(ALL_CFLAGS) $(ALL_LDFLAGS) -o $@ $^ $(CURSES)
+	$(CC) $(ALL_CFLAGS) $^ $(ALL_LDFLAGS) -o $@ $(CURSES)
 
 ############ progX --> progY
 
diff -ruN orig/procps-3.1.12/debian/changelog procps-3.1.12/debian/changelog
--- orig/procps-3.1.12/debian/changelog	2003-09-16 14:52:43.000000000 +1000
+++ procps-3.1.12/debian/changelog	2003-10-19 13:47:16.000000000 +1000
@@ -1,3 +1,11 @@
+procps (1:3.1.12-1.se2) unstable; urgency=low
+
+  * Build with SE Linux support.
+
+  * Remove SID support.
+
+ -- Russell Coker <russell@coker.com.au>  Sun, 19 Oct 2003 13:47:00 +1000
+
 procps (1:3.1.12-1) unstable; urgency=low
 
   * New upstream release
diff -ruN orig/procps-3.1.12/debian/control procps-3.1.12/debian/control
--- orig/procps-3.1.12/debian/control	2003-09-16 14:52:43.000000000 +1000
+++ procps-3.1.12/debian/control	2003-10-19 13:44:53.000000000 +1000
@@ -2,7 +2,7 @@
 Section: base
 Priority: required
 Maintainer: Craig Small <csmall@debian.org>
-Build-Depends: debhelper (>> 4.1.1), libncurses5-dev, make (>= 3.78.1-8)
+Build-Depends: debhelper (>> 4.1.1), libncurses5-dev, make (>= 3.78.1-8), libselinux-dev
 Standards-Version: 3.5.9
 
 Package: procps
diff -ruN orig/procps-3.1.12/debian/rules procps-3.1.12/debian/rules
--- orig/procps-3.1.12/debian/rules	2003-09-16 14:52:43.000000000 +1000
+++ procps-3.1.12/debian/rules	2003-10-19 13:44:53.000000000 +1000
@@ -21,7 +21,7 @@
 	SHARED=0 $(MAKE) proc/libproc.a
 	mv proc/libproc.a static
 	$(MAKE) clean
-	$(MAKE) W_SHOWFROM=\-DW_SHOWFROM
+	$(MAKE) W_SHOWFROM=\-DW_SHOWFROM LDFLAGS=-lsecure CFLAGS="-O2 -g3 -I/usr/include/selinux -DFLASK_LINUX"
 
 	touch build-stamp
 
diff -ruN orig/procps-3.1.12/proc/module.mk procps-3.1.12/proc/module.mk
--- orig/procps-3.1.12/proc/module.mk	2003-09-16 14:52:43.000000000 +1000
+++ procps-3.1.12/proc/module.mk	2003-10-19 13:45:28.000000000 +1000
@@ -45,7 +45,7 @@
 
 #proc/$(SONAME): proc/library.map
 proc/$(SONAME): $(LIBOBJ)
-	$(CC) -shared -Wl,-soname,$(SONAME) -Wl,--version-script=proc/library.map -o $@ $^ -lc
+	$(CC) -shared -Wl,-soname,$(SONAME) -Wl,--version-script=proc/library.map -o $@ $^ -lc -lsecure
 	cd proc && $(ln_sf) $(SONAME) lib$(NAME).so
 
 
diff -ruN orig/procps-3.1.12/proc/readproc.c procps-3.1.12/proc/readproc.c
--- orig/procps-3.1.12/proc/readproc.c	2003-09-16 14:52:43.000000000 +1000
+++ procps-3.1.12/proc/readproc.c	2003-10-19 13:46:00.000000000 +1000
@@ -29,6 +29,8 @@
 
 #ifdef FLASK_LINUX
 #include <fs_secure.h>
+#include <ss.h>
+#include <selinux.h>
 #endif
 
 #ifdef PROF
@@ -485,6 +487,17 @@
     return n;
 }
 
+#ifdef FLASK_LINUX
+security_context_t sid_to_con(security_id_t sid)
+{
+  char buf[4096];
+  int len = sizeof(buf);
+  if(security_sid_to_context(sid, buf, &len))
+    return NULL;
+  return strdup(buf);
+}
+#endif
+
 /* These are some nice GNU C expression subscope "inline" functions.
  * The can be used with arbitrary types and evaluate their arguments
  * exactly once.
@@ -521,6 +534,7 @@
     static char path[32], sbuf[1024];	/* bufs for stat,statm */
 #ifdef FLASK_LINUX
     security_id_t secsid;
+    int selinux_enabled=is_selinux_enabled();
 #endif
     pid_t pid;  // saved until we have a proc_t allocated for sure
 
@@ -547,7 +561,8 @@
 //	snprintf(path, sizeof path, "/proc/%s", ent->d_name);
     }
 #ifdef FLASK_LINUX
-    if ( stat_secure(path, &sb, &secsid) == -1 ) /* no such dirent (anymore) */
+    if ( (selinux_enabled && unlikely(stat_secure(path, &sb, &secsid) == -1))
+       || unlikely(stat(path, &sb) == -1) ) /* no such dirent (anymore) */
 #else
     if (unlikely(stat(path, &sb) == -1))	/* no such dirent (anymore) */
 #endif
@@ -562,7 +577,8 @@
     p->euid = sb.st_uid;			/* need a way to get real uid */
     p->egid = sb.st_gid;			/* need a way to get real gid */
 #ifdef FLASK_LINUX
-    p->secsid = secsid;
+    if(selinux_enabled)
+      p->scontext = sid_to_con(secsid);
 #endif
     p->pid  = pid;
 
@@ -633,6 +649,7 @@
     static char path[32], sbuf[1024];	/* bufs for stat,statm */
 #ifdef FLASK_LINUX
     security_id_t secsid;
+    int selinux_enabled=is_selinux_enabled();
 #endif
     pid_t pid;  // saved until we have a proc_t allocated for sure
 
@@ -654,7 +671,8 @@
 //  snprintf(path, sizeof path, "/proc/%s", ent->d_name);
 
 #ifdef FLASK_LINUX
-    if (stat_secure(path, &sb, &secsid) == -1) /* no such dirent (anymore) */
+    if ( (selinux_enabled && stat_secure(path, &sb, &secsid) == -1)
+        || stat(path, &sb) == -1) /* no such dirent (anymore) */
 #else
     if (stat(path, &sb) == -1)		/* no such dirent (anymore) */
 #endif
@@ -666,7 +684,8 @@
     p->euid = sb.st_uid;			/* need a way to get real uid */
     p->egid = sb.st_gid;			/* need a way to get real gid */
 #ifdef FLASK_LINUX
-    p->secsid = secsid;
+    if(selinux_enabled)
+      p->scontext = sid_to_con(secsid);
 #endif
     p->pid  = pid;
 
diff -ruN orig/procps-3.1.12/proc/readproc.h procps-3.1.12/proc/readproc.h
--- orig/procps-3.1.12/proc/readproc.h	2003-07-02 09:27:26.000000000 +1000
+++ procps-3.1.12/proc/readproc.h	2003-10-19 13:44:53.000000000 +1000
@@ -137,7 +137,7 @@
 	exit_signal,	/* might not be SIGCHLD */
 	processor;      /* current (or most recent?) CPU */
 #ifdef FLASK_LINUX
-	security_id_t secsid;
+	security_context_t scontext;
 #endif
 } proc_t;
 
@@ -155,7 +155,7 @@
     uid_t*	uids;	/* uids of procs */
     int		nuid;	/* cannot really sentinel-terminate unsigned short[] */
 #ifdef FLASK_LINUX
-    security_id_t* sids; /* SIDs of the procs */
+    security_context_t* scontexts; /* security contexts of the procs */
 #endif
 } PROCTAB;
 
diff -ruN orig/procps-3.1.12/ps/common.h procps-3.1.12/ps/common.h
--- orig/procps-3.1.12/ps/common.h	2003-02-17 15:18:03.000000000 +1100
+++ procps-3.1.12/ps/common.h	2003-10-19 13:44:53.000000000 +1000
@@ -103,7 +103,6 @@
 #define FF_LX 0x0100 /* X */
 #define FF_Lm 0x0200 /* m */  /* overloaded: threads, sort, format */
 #define FF_Fc 0x0400 /* --context */  /* Flask security context format */
-#define FF_Fs 0x0800 /* --SID */      /* Flask SID format */
 
 /* predefined format modifier flags such as:  -l -f l u s -j */
 #define FM_c 0x0001 /* -c */
diff -ruN orig/procps-3.1.12/ps/module.mk procps-3.1.12/ps/module.mk
--- orig/procps-3.1.12/ps/module.mk	2003-09-13 08:05:29.000000000 +1000
+++ procps-3.1.12/ps/module.mk	2003-10-19 13:44:53.000000000 +1000
@@ -20,11 +20,11 @@
 TARFILES += $(PSSRC) $(addprefix ps/,$(PS_X))
 
 ps/ps: $(PSOBJ) $(LIBPROC)
-	$(CC) $(ALL_CFLAGS) $(ALL_LDFLAGS) -o $@ $^
+	$(CC) $(ALL_CFLAGS) $^ $(ALL_LDFLAGS) -o $@
 
 # This just adds the stacktrace code
 ps/debug: $(PSOBJ) stacktrace.o $(LIBPROC)
-	$(CC) $(ALL_CFLAGS) $(ALL_LDFLAGS) -o $@ $^ -lefence
+	$(CC) $(ALL_CFLAGS) $^ $(ALL_LDFLAGS) -o $@ -lefence
 
 $(PSOBJ): %.o: %.c ps/common.h $(LIBPROC)
 	$(CC) -c $(ALL_CPPFLAGS) $(ALL_CFLAGS) $< -o $@
diff -ruN orig/procps-3.1.12/ps/output.c procps-3.1.12/ps/output.c
--- orig/procps-3.1.12/ps/output.c	2003-07-03 13:57:25.000000000 +1000
+++ procps-3.1.12/ps/output.c	2003-10-19 13:46:37.000000000 +1000
@@ -968,130 +968,22 @@
  * is called, at which point the error goes onscreen.
  */
 
-/* as above, creates sr_secsid function */
-CMP_INT(secsid)  /* FLASK security ID, **NOT** a session ID -- ugh */
+/* as above, creates sr_scontext function */
+CMP_STR(scontext)  /* SE Linux context */
 
-static int pr_secsid(char *restrict const outbuf, const proc_t *restrict const pp){
-  return sprintf(outbuf, "%d", (int) pp->secsid);
-}
-
-static int pr_context(char *restrict const outbuf, const proc_t *restrict const pp){
-  char *ctxt; /* should be security_context_t */
-  unsigned int len;
-  int rv;
-
-  len = DEF_CTXTLEN;
-  ctxt = (char *) calloc(1, len);
-  if ( ctxt != NULL )
-    rv = security_sid_to_context(pp->secsid, (security_context_t) ctxt, &len);
-  else
+static int pr_scontext(char *restrict const outbuf, const proc_t *restrict const pp){
+  if ( !pp->scontext )
     return sprintf(outbuf, "-");
 
-  if ( rv ) {
-    if ( errno != ENOSPC ) {
-      free(ctxt);
-      return sprintf(outbuf, "-");
-    } else {
-      free(ctxt);
-      ctxt = (char *) calloc(1, len);
-      if ( ctxt != NULL ) {
-	rv = security_sid_to_context(pp->secsid, (security_context_t) ctxt, &len);
-	if ( rv ) {
-	  free(ctxt);
-	  return sprintf(outbuf, "-");
-	} else {
-	  rv = sprintf(outbuf, "%s", ctxt);
-	  free(ctxt);
-	  return rv;
-	}
-      } else {           /* calloc() failed */
-	return sprintf(outbuf, "-");
-      }
-    }
-  } else {
-    rv = sprintf(outbuf, "%s", ctxt);
-    free(ctxt);
-    return rv;
-  }
-}
-
-
-static int sr_context ( const proc_t* P, const proc_t* Q ) {
-  char *ctxt_P, *ctxt_Q; /* type should be security_context_t */
-  unsigned int len;
-  int rv;
-
-  len = DEF_CTXTLEN;
-  ctxt_P = (char *) calloc(1, len);
-  ctxt_Q = (char *) calloc(1, len);
-
-  rv = security_sid_to_context(P->secsid, (security_context_t) ctxt_P, &len);
-  if ( rv ) {
-    if ( errno != ENOSPC ) {
-      free(ctxt_P);
-      /* error should resurface during printing */
-      return( 0 );
-    } else {
-      free(ctxt_P);
-      ctxt_P = (char *) calloc(1, len);
-      if ( ctxt_P != NULL ) {
-	rv = security_sid_to_context(P->secsid, (security_context_t) ctxt_P, &len);
-	if ( rv ) {
-	  free(ctxt_P);
-	  /* error should resurface during printing */
-	  return( 0 );
-	}
-      } else {       /* calloc() failed */
-	/* error should resurface during printing */
-	return( 0 );
-      }
-    }
-  }
-
-  len = DEF_CTXTLEN;
-
-  rv = security_sid_to_context(Q->secsid, (security_context_t) ctxt_Q, &len);
-  if ( rv ) {
-    if ( errno != ENOSPC ) {
-      free(ctxt_P);
-      free(ctxt_Q);
-      /* error should resurface during printing */
-      return( 0 );
-    } else {
-      free(ctxt_Q);
-      ctxt_Q = (char *) calloc(1, len);
-      if ( ctxt_Q != NULL ) {
-	rv = security_sid_to_context(Q->secsid, (security_context_t) ctxt_Q, &len);
-	if ( rv ) {
-	  free(ctxt_P);
-	  free(ctxt_Q);
-	  /* error should resurface during printing */
-	  return( 0 );
-	}
-      } else {      /* calloc() failed */
-	/* error should resurface during printing */
-	free(ctxt_P);
-	return( 0 );
-      }
-    }
-  }
-
-  rv = strcmp(ctxt_P, ctxt_Q);
-
-  free(ctxt_P);
-  free(ctxt_Q);
-
-  return( rv );
+  return sprintf(outbuf, "%s", pp->scontext);
 }
 
 #else
 
 /****** dummy functions ******/
 
-#define pr_secsid pr_nop
-#define sr_secsid sr_nop
-#define pr_context pr_nop
-#define sr_context sr_nop
+#define pr_scontext pr_nop
+#define sr_scontext sr_nop
 
 #endif
 
@@ -1167,7 +1059,7 @@
 {"cnswap",    "-",       pr_nop,      sr_cnswap,  1,   0,    LNX, RIGHT},
 {"comm",      "COMMAND", pr_comm,     sr_nop,    16, COM,    U98, UNLIMITED}, /*ucomm*/
 {"command",   "COMMAND", pr_args,     sr_nop,    16, ARG,    XXX, UNLIMITED}, /*args*/
-{"context",   "CONTEXT", pr_context,  sr_context,40,   0,    LNX, LEFT},
+{"context",   "CONTEXT", pr_scontext, sr_scontext,40,  0,    LNX, LEFT},
 {"cp",        "CP",      pr_cp,       sr_pcpu,    3,   0,    DEC, RIGHT}, /*cpu*/
 {"cpu",       "CPU",     pr_nop,      sr_nop,     3,   0,    BSD, RIGHT}, /* FIXME ... HP-UX wants this as the CPU number for SMP? */
 {"cputime",   "TIME",    pr_time,     sr_nop,     8,   0,    DEC, RIGHT}, /*time*/
@@ -1277,7 +1169,6 @@
 {"sched",     "SCH",     pr_sched,    sr_sched,   3,   0,    AIX, RIGHT},
 {"scnt",      "SCNT",    pr_nop,      sr_nop,     4,   0,    DEC, RIGHT},  /* man page misspelling of scount? */
 {"scount",    "SC",      pr_nop,      sr_nop,     4,   0,    AIX, RIGHT},  /* scnt==scount, DEC claims both */
-{"secsid",    "SID",     pr_secsid,   sr_secsid,  6,   0,    LNX, RIGHT}, /* Flask Linux */
 {"sess",      "SESS",    pr_sess,     sr_session, 5,   0,    XXX, PIDMAX|RIGHT},
 {"session",   "SESS",    pr_sess,     sr_session, 5,   0,    LNX, PIDMAX|RIGHT},
 {"sgi_p",     "P",       pr_sgi_p,    sr_nop,     1,   0,    LNX, RIGHT}, /* "cpu" number */
@@ -1387,8 +1278,7 @@
 
 {"FL5FMT",   "f,state,uid,pid,ppid,pcpu,pri,nice,rss,wchan,start,time,command"},  /* Digital -fl */
 
-{"FLASK_context",   "pid,secsid,context,command"},  /* Flask Linux context, --context */
-{"FLASK_sid",       "pid,secsid,command"},          /* Flask Linux SID,     --SID */
+{"FLASK_context",   "pid,context,command"},  /* Flask Linux context, --context */
 
 {"HP_",      "pid,tty,time,comm"},  /* HP default */
 {"HP_f",     "user,pid,ppid,cpu,stime,tty,time,args"},  /* HP -f */
diff -ruN orig/procps-3.1.12/ps/parser.c procps-3.1.12/ps/parser.c
--- orig/procps-3.1.12/ps/parser.c	2003-03-19 11:51:38.000000000 +1100
+++ procps-3.1.12/ps/parser.c	2003-10-19 13:46:55.000000000 +1000
@@ -314,8 +314,18 @@
       display_version();
       exit(0);
     case 'Z':     /* full Mandatory Access Control level info */
+#ifdef WITH_SELINUX
+      if (is_selinux_enabled()) {
+	trace("-Z shows full MAC info\n");
+	format_flags |= FF_Fc;
+      } else {
+	fprintf(stderr,
+		"Warning: -Z ignored. Requires a SELinux enabled kernel\n");
+      }
+#else
       trace("-Z shows full MAC info\n");
       return "Don't understand MAC on Linux.";
+#endif
       break;
     case 'a':
       trace("-a select all with a tty, but omit session leaders.\n");
@@ -727,7 +737,6 @@
   gnu_table_struct *found;
   static const gnu_table_struct gnu_table[] = {
   {"Group",         &&case_Group},       /* rgid */
-  {"SID",           &&case_secsid},
   {"User",          &&case_User},        /* ruid */
   {"cols",          &&case_cols},
   {"columns",       &&case_columns},
@@ -755,8 +764,6 @@
   {"pid",           &&case_pid},
   {"ppid",          &&case_ppid},
   {"rows",          &&case_rows},
-  {"secsid",        &&case_secsid},
-  {"sid",           &&case_sid},
   {"sort",          &&case_sort},
   {"tty",           &&case_tty},
   {"user",          &&case_user},        /* euid */
@@ -904,14 +911,6 @@
       }
     }
     return "Number of rows must follow --rows or --lines.";
-  case_sid:
-    trace("--sid\n");
-    arg = grab_gnu_arg();
-    if(!arg) return "Some sid thing(s) must follow --sid.";
-    err=parse_list(arg, parse_pid);
-    if(err) return err;
-    selection_list->typecode = SEL_SESS;
-    return NULL;
   case_sort:
     trace("--sort\n");
     arg=grab_gnu_arg();
@@ -944,10 +943,6 @@
     trace("--context\n");
     format_flags |= FF_Fc;
     return NULL;
-  case_secsid:
-     trace("--secsid\n");
-     format_flags |= FF_Fs;
-     return NULL;
 }
 
 /*************** process trailing PIDs  **********************/
diff -ruN orig/procps-3.1.12/ps/ps.1 procps-3.1.12/ps/ps.1
--- orig/procps-3.1.12/ps/ps.1	2003-09-16 14:52:43.000000000 +1000
+++ procps-3.1.12/ps/ps.1	2003-10-19 13:44:53.000000000 +1000
@@ -106,8 +106,7 @@
 u            display user-oriented format
 v            display virtual memory format
 --format     user-defined format
---context    (SELinux only) Display security context format; implies --secsid
---secsid     (SELinux only) Display Security ID
+--context    (SELinux only) Display security context format;
 .TE
 .SH "OUTPUT MODIFIERS"
 .TS
@@ -432,14 +431,12 @@
 ruid         RUID    
 ruser        RUSER   
 s            S       
-secsid       SECSID
 sess         SESS    
 session      SESS    
 sgi_p        P       
 sgi_rss      RSS     
 sgid         SGID    
 sgroup       SGROUP  
-sid          SID     
 sig          PENDING 
 sig_block    BLOCKED 
 sig_catch    CATCHED 
diff -ruN orig/procps-3.1.12/ps/sortformat.c procps-3.1.12/ps/sortformat.c
--- orig/procps-3.1.12/ps/sortformat.c	2003-09-13 11:11:07.000000000 +1000
+++ procps-3.1.12/ps/sortformat.c	2003-10-19 13:44:53.000000000 +1000
@@ -832,7 +832,6 @@
 
     /* These are FLASK security options. */
     case FF_Fc:          spec="FLASK_context"; break;
-    case FF_Fs:          spec="FLASK_sid";     break;
 
     }  /* end switch(format_flags) */
 

--Boundary-00=_bihk/o5x5Pm2ACq--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
