Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9K21lWt017397
	for <selinux@tycho.nsa.gov>; Sun, 19 Oct 2003 22:01:47 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h9K21Z0p025182
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 02:01:36 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by jazzswing.ncsc.mil  with ESMTP id h9K21Ur7025156
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 02:01:31 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 56D97924F4
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 01:51:06 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id C82EA7F06B
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 01:51:04 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: procps 3.1.12 patch for new SE Linux
Date: Mon, 20 Oct 2003 01:51:04 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_oLrk/Z37lH4+UOc"
Message-Id: <200310200151.04226.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_oLrk/Z37lH4+UOc
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have attached a patch to make procps 3.1.12 work on the new SE Linux.  It's 
a little rough and may have some bugs tracking memory (if you can trigger a 
double-free or a memory leak I wouldn't be surprised).  But it basically 
works.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_oLrk/Z37lH4+UOc
Content-Type: text/x-diff;
  charset="us-ascii";
  name="procps.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="procps.diff"

diff -ruN orig/procps-3.1.12/debian/changelog procps-3.1.12/debian/changelog
--- orig/procps-3.1.12/debian/changelog	2003-09-16 14:52:43.000000000 +1000
+++ procps-3.1.12/debian/changelog	2003-10-19 02:20:31.000000000 +1000
@@ -1,3 +1,9 @@
+procps (1:3.1.12-1.new.se1) unstable; urgency=low
+
+  * Compiled with SE Linux support.
+
+ -- Russell Coker <russell@coker.com.au>  Sun, 19 Oct 2003 02:20:00 +1000
+
 procps (1:3.1.12-1) unstable; urgency=low
 
   * New upstream release
diff -ruN orig/procps-3.1.12/debian/control procps-3.1.12/debian/control
--- orig/procps-3.1.12/debian/control	2003-09-16 14:52:43.000000000 +1000
+++ procps-3.1.12/debian/control	2003-10-19 02:17:03.000000000 +1000
@@ -2,7 +2,7 @@
 Section: base
 Priority: required
 Maintainer: Craig Small <csmall@debian.org>
-Build-Depends: debhelper (>> 4.1.1), libncurses5-dev, make (>= 3.78.1-8)
+Build-Depends: debhelper (>> 4.1.1), libncurses5-dev, make (>= 3.78.1-8), libselinux1-dev
 Standards-Version: 3.5.9
 
 Package: procps
diff -ruN orig/procps-3.1.12/debian/rules procps-3.1.12/debian/rules
--- orig/procps-3.1.12/debian/rules	2003-09-16 14:52:43.000000000 +1000
+++ procps-3.1.12/debian/rules	2003-10-19 02:17:03.000000000 +1000
@@ -21,7 +21,8 @@
 	SHARED=0 $(MAKE) proc/libproc.a
 	mv proc/libproc.a static
 	$(MAKE) clean
-	$(MAKE) W_SHOWFROM=\-DW_SHOWFROM
+	$(MAKE) W_SHOWFROM=\-DW_SHOWFROM LDFLAGS=-lselinux CFLAGS="-O2 -g3 -I/usr/include/selinux -DWITH_SELINUX"
+
 
 	touch build-stamp
 
diff -ruN orig/procps-3.1.12/proc/readproc.c procps-3.1.12/proc/readproc.c
--- orig/procps-3.1.12/proc/readproc.c	2003-09-16 14:52:43.000000000 +1000
+++ procps-3.1.12/proc/readproc.c	2003-10-19 02:17:49.000000000 +1000
@@ -27,8 +27,8 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 
-#ifdef FLASK_LINUX
-#include <fs_secure.h>
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
 #endif
 
 #ifdef PROF
@@ -82,6 +82,10 @@
 	free((void*)*p->cmdline);
     if (p->environ)
 	free((void*)*p->environ);
+#ifdef WITH_SELINUX
+    if (p->scontext)
+	freecon(p->scontext);
+#endif
     free(p);
 }
 
@@ -519,11 +523,12 @@
     static struct direct *ent;		/* dirent handle */
     static struct stat sb;		/* stat buffer */
     static char path[32], sbuf[1024];	/* bufs for stat,statm */
-#ifdef FLASK_LINUX
-    security_id_t secsid;
-#endif
     pid_t pid;  // saved until we have a proc_t allocated for sure
 
+#ifdef WITH_SELINUX
+    int selinux_enabled=is_selinux_enabled();
+#endif
+
     /* loop until a proc matching restrictions is found or no more processes */
     /* I know this could be a while loop -- this way is easier to indent ;-) */
 next_proc:				/* get next PID for consideration */
@@ -546,11 +551,7 @@
 	strcpy(path+6, ent->d_name);  // trust /proc to not contain evil top-level entries
 //	snprintf(path, sizeof path, "/proc/%s", ent->d_name);
     }
-#ifdef FLASK_LINUX
-    if ( stat_secure(path, &sb, &secsid) == -1 ) /* no such dirent (anymore) */
-#else
     if (unlikely(stat(path, &sb) == -1))	/* no such dirent (anymore) */
-#endif
 	goto next_proc;
 
     if ((flags & PROC_UID) && !XinLN(uid_t, sb.st_uid, PT->uids, PT->nuid))
@@ -561,9 +562,6 @@
 
     p->euid = sb.st_uid;			/* need a way to get real uid */
     p->egid = sb.st_gid;			/* need a way to get real gid */
-#ifdef FLASK_LINUX
-    p->secsid = secsid;
-#endif
     p->pid  = pid;
 
     if (flags & PROC_FILLSTAT) {         /* read, parse /proc/#/stat */
@@ -572,6 +570,30 @@
 	stat2proc(sbuf, p);				/* parse /proc/#/stat */
     }
 
+#ifdef WITH_SELINUX
+    if (selinux_enabled) {
+        if (p->scontext) {
+            freecon(p->scontext);
+            p->scontext=NULL;
+        }
+        if (getpidcon(p->pid, &p->scontext) < 0 )
+            goto next_proc;
+
+        if (FLAGS & PROC_CONTEXT) {
+            int found=0;
+            int i=0;
+            for (i=0; PT->scontexts[i]; i++) {
+                if (strcmp(p->scontext, PT->scontexts[i]) ==0) {
+                    found=1;
+                    break;
+                }
+            }
+            if (! found)
+                goto next_proc;                   /* not one of the requested CONTEXTS */
+        }
+    }
+#endif
+
     if (unlikely(flags & PROC_FILLMEM)) {				/* read, parse /proc/#/statm */
 	if (likely( file2str(path, "statm", sbuf, sizeof sbuf) != -1 ))
 	    statm2proc(sbuf, p);		/* ignore statm errors here */
@@ -631,8 +653,8 @@
     static struct direct *ent;		/* dirent handle */
     static struct stat sb;		/* stat buffer */
     static char path[32], sbuf[1024];	/* bufs for stat,statm */
-#ifdef FLASK_LINUX
-    security_id_t secsid;
+#ifdef WITH_SELINUX
+    int selinux_enabled=is_selinux_enabled();
 #endif
     pid_t pid;  // saved until we have a proc_t allocated for sure
 
@@ -653,11 +675,7 @@
     strcpy(path+6, ent->d_name);  // trust /proc to not contain evil top-level entries
 //  snprintf(path, sizeof path, "/proc/%s", ent->d_name);
 
-#ifdef FLASK_LINUX
-    if (stat_secure(path, &sb, &secsid) == -1) /* no such dirent (anymore) */
-#else
     if (stat(path, &sb) == -1)		/* no such dirent (anymore) */
-#endif
 	goto next_proc;
 
     if (!p)
@@ -665,15 +683,23 @@
 
     p->euid = sb.st_uid;			/* need a way to get real uid */
     p->egid = sb.st_gid;			/* need a way to get real gid */
-#ifdef FLASK_LINUX
-    p->secsid = secsid;
-#endif
     p->pid  = pid;
 
     if ((file2str(path, "stat", sbuf, sizeof sbuf)) == -1)
 	goto next_proc;			/* error reading /proc/#/stat */
     stat2proc(sbuf, p);				/* parse /proc/#/stat */
 
+#ifdef WITH_SELINUX
+    if (selinux_enabled) {
+        if (p->scontext) {
+            freecon(p->scontext);
+            p->scontext=NULL;
+        }
+        if (getpidcon(p->pid, &p->scontext) < 0 )
+            goto next_proc;
+        }
+#endif
+
     if (flags & PROC_FILLMEM) {				/* read, parse /proc/#/statm */
 	if ((file2str(path, "statm", sbuf, sizeof sbuf)) != -1 )
 	    statm2proc(sbuf, p);		/* ignore statm errors here */
@@ -757,6 +783,10 @@
     }
     else if (flags & PROC_PID)
 	PT = openproc(flags, va_arg(ap, void*)); /* assume ptr sizes same */
+#ifdef WITH_SELINUX
+    else if ( Do(CONTEXT) )
+        PT = openproc(flags, va_arg(ap, security_context_t*));
+#endif
     else
 	PT = openproc(flags);
     va_end(ap);
diff -ruN orig/procps-3.1.12/proc/readproc.h procps-3.1.12/proc/readproc.h
--- orig/procps-3.1.12/proc/readproc.h	2003-07-02 09:27:26.000000000 +1000
+++ procps-3.1.12/proc/readproc.h	2003-10-19 02:17:03.000000000 +1000
@@ -14,8 +14,8 @@
 
 #define SIGNAL_STRING
 
-#ifdef FLASK_LINUX
-#include <fs_secure.h>
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
 #endif
 
 EXTERN_C_BEGIN
@@ -136,8 +136,8 @@
 	tgid,		/* thread group ID */
 	exit_signal,	/* might not be SIGCHLD */
 	processor;      /* current (or most recent?) CPU */
-#ifdef FLASK_LINUX
-	security_id_t secsid;
+#ifdef WITH_SELINUX
+	security_context_t scontext;
 #endif
 } proc_t;
 
@@ -154,8 +154,8 @@
     pid_t*	pids;	/* pids of the procs */
     uid_t*	uids;	/* uids of procs */
     int		nuid;	/* cannot really sentinel-terminate unsigned short[] */
-#ifdef FLASK_LINUX
-    security_id_t* sids; /* SIDs of the procs */
+#ifdef WITH_SELINUX
+    security_context_t* scontexts; /* security contexts of the procs */
 #endif
 } PROCTAB;
 
diff -ruN orig/procps-3.1.12/ps/common.h procps-3.1.12/ps/common.h
--- orig/procps-3.1.12/ps/common.h	2003-02-17 15:18:03.000000000 +1100
+++ procps-3.1.12/ps/common.h	2003-10-19 02:17:03.000000000 +1000
@@ -103,7 +103,6 @@
 #define FF_LX 0x0100 /* X */
 #define FF_Lm 0x0200 /* m */  /* overloaded: threads, sort, format */
 #define FF_Fc 0x0400 /* --context */  /* Flask security context format */
-#define FF_Fs 0x0800 /* --SID */      /* Flask SID format */
 
 /* predefined format modifier flags such as:  -l -f l u s -j */
 #define FM_c 0x0001 /* -c */
diff -ruN orig/procps-3.1.12/ps/output.c procps-3.1.12/ps/output.c
--- orig/procps-3.1.12/ps/output.c	2003-07-03 13:57:25.000000000 +1000
+++ procps-3.1.12/ps/output.c	2003-10-19 02:19:58.000000000 +1000
@@ -68,11 +68,8 @@
 #include "../proc/escape.h"
 #include "common.h"
 
-#ifdef FLASK_LINUX
-#include <errno.h>
-#include <fs_secure.h>
-#include <ss.h>
-#define DEF_CTXTLEN 255
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
 #endif
 
 
@@ -211,6 +208,9 @@
 CMP_SMALL(pcpu)
 
 CMP_SMALL(state)
+#ifdef WITH_SELINUX
+CMP_STR(scontext)
+#endif
 
 /* approximation to: kB of address space that could end up in swap */
 static int sr_swapable(const proc_t* P, const proc_t* Q) {
@@ -951,7 +951,6 @@
   return snprintf(outbuf, COLWID, "%d", pp->tpgid);
 }
 
-
 /* SGI uses "cpu" to print the processor ID with header "P" */
 static int pr_sgi_p(char *restrict const outbuf, const proc_t *restrict const pp){          /* FIXME */
   if(pp->state == 'R') return snprintf(outbuf, COLWID, "%d", pp->processor);
@@ -963,133 +962,32 @@
 #ifdef FLASK_LINUX
 
 /*
- * The sr_fn() calls -- for sorting -- don't return errors because
- * the same errors should show up when the printing function pr_fn()
- * is called, at which point the error goes onscreen.
+ * The sr_fn() calls -- for sorting -- don't return errors because the same errors
+ * should show up when the printing function pr_fn() is called, at which point the
+ * error goes onscreen.
  */
 
-/* as above, creates sr_secsid function */
-CMP_INT(secsid)  /* FLASK security ID, **NOT** a session ID -- ugh */
-
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
-    return sprintf(outbuf, "-");
-
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
+static int pr_context ( void ) {
+  if (pp->scontext) {
+    sprintf(outbuf, pp->scontext);
   } else {
-    rv = sprintf(outbuf, "%s", ctxt);
-    free(ctxt);
-    return rv;
+    sprintf(outbuf, "-");
   }
+  return 0;
 }
 
-
 static int sr_context ( const proc_t* P, const proc_t* Q ) {
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
+  if ((P->scontext==NULL) && (Q->scontext==NULL))
+    return 0;
+  if ((P->scontext==NULL) || (Q->scontext==NULL))
+    return 1;
+  return strcmp(P->scontext, Q->scontext);
 }
 
 #else
 
 /****** dummy functions ******/
 
-#define pr_secsid pr_nop
-#define sr_secsid sr_nop
 #define pr_context pr_nop
 #define sr_context sr_nop
 
@@ -1277,7 +1175,6 @@
 {"sched",     "SCH",     pr_sched,    sr_sched,   3,   0,    AIX, RIGHT},
 {"scnt",      "SCNT",    pr_nop,      sr_nop,     4,   0,    DEC, RIGHT},  /* man page misspelling of scount? */
 {"scount",    "SC",      pr_nop,      sr_nop,     4,   0,    AIX, RIGHT},  /* scnt==scount, DEC claims both */
-{"secsid",    "SID",     pr_secsid,   sr_secsid,  6,   0,    LNX, RIGHT}, /* Flask Linux */
 {"sess",      "SESS",    pr_sess,     sr_session, 5,   0,    XXX, PIDMAX|RIGHT},
 {"session",   "SESS",    pr_sess,     sr_session, 5,   0,    LNX, PIDMAX|RIGHT},
 {"sgi_p",     "P",       pr_sgi_p,    sr_nop,     1,   0,    LNX, RIGHT}, /* "cpu" number */
@@ -1387,8 +1284,7 @@
 
 {"FL5FMT",   "f,state,uid,pid,ppid,pcpu,pri,nice,rss,wchan,start,time,command"},  /* Digital -fl */
 
-{"FLASK_context",   "pid,secsid,context,command"},  /* Flask Linux context, --context */
-{"FLASK_sid",       "pid,secsid,command"},          /* Flask Linux SID,     --SID */
+{"FLASK_context",   "pid,context,command"},  /* Flask Linux context, --context */
 
 {"HP_",      "pid,tty,time,comm"},  /* HP default */
 {"HP_f",     "user,pid,ppid,cpu,stime,tty,time,args"},  /* HP -f */
diff -ruN orig/procps-3.1.12/ps/parser.c procps-3.1.12/ps/parser.c
--- orig/procps-3.1.12/ps/parser.c	2003-03-19 11:51:38.000000000 +1100
+++ procps-3.1.12/ps/parser.c	2003-10-19 02:20:07.000000000 +1000
@@ -314,8 +314,18 @@
       display_version();
       exit(0);
     case 'Z':     /* full Mandatory Access Control level info */
+#ifdef WITH_SELINUX
+      if (is_selinux_enabled()) {
+        trace("-Z shows full MAC info\n");
+        format_flags |= FF_Fc;
+      } else {
+        fprintf(stderr,
+                "Warning: -Z ignored. Requires a SELinux enabled kernel\n");
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
@@ -755,7 +764,6 @@
   {"pid",           &&case_pid},
   {"ppid",          &&case_ppid},
   {"rows",          &&case_rows},
-  {"secsid",        &&case_secsid},
   {"sid",           &&case_sid},
   {"sort",          &&case_sort},
   {"tty",           &&case_tty},
@@ -944,10 +952,6 @@
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
+++ procps-3.1.12/ps/ps.1	2003-10-19 02:20:14.000000000 +1000
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
@@ -432,7 +431,6 @@
 ruid         RUID    
 ruser        RUSER   
 s            S       
-secsid       SECSID
 sess         SESS    
 session      SESS    
 sgi_p        P       
diff -ruN orig/procps-3.1.12/ps/sortformat.c procps-3.1.12/ps/sortformat.c
--- orig/procps-3.1.12/ps/sortformat.c	2003-09-13 11:11:07.000000000 +1000
+++ procps-3.1.12/ps/sortformat.c	2003-10-19 02:20:22.000000000 +1000
@@ -832,7 +832,6 @@
 
     /* These are FLASK security options. */
     case FF_Fc:          spec="FLASK_context"; break;
-    case FF_Fs:          spec="FLASK_sid";     break;
 
     }  /* end switch(format_flags) */
 

--Boundary-00=_oLrk/Z37lH4+UOc--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
