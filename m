Subject: port of procps patch to acahalan procps
From: Colin Walters <walters@verbum.org>
To: SELinux@tycho.nsa.gov
Cc: albert@users.sourceforge.net
Content-Type: multipart/mixed; boundary="=-8FiobVtZZYJeC6hEkVqw"
Message-Id: <1057776906.28674.262.camel@columbia>
Mime-Version: 1.0
Date: 09 Jul 2003 14:55:06 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-8FiobVtZZYJeC6hEkVqw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

I've ported the SELinux 2.5 procps patch to the acahalan procps; this
may be useful for other systems like Debian which also use acalahan's
procps (I think Gentoo does).

It's been lightly tested.

Albert: this is an update to the new SELinux API for Linux 2.5; the old
API is deprecated now, and will likely be obsoleted once the new API is
backported to Linux 2.4.

--=-8FiobVtZZYJeC6hEkVqw
Content-Disposition: attachment; filename=acalahan-procps.patch
Content-Type: text/plain; name=acalahan-procps.patch; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- procps-3.1.9.orig/Makefile
+++ procps-3.1.9/Makefile
@@ -63,9 +63,9 @@
=20
 CURSES :=3D -I/usr/include/ncurses -lncurses
=20
-LDFLAGS :=3D -Wl,-warn-common
+LDFLAGS :=3D -Wl,-warn-common -lselinux -lattr
=20
-CFLAGS :=3D -D_GNU_SOURCE -O2 -g3 -fno-common -ffast-math -I proc \
+CFLAGS :=3D -D_GNU_SOURCE -DWITH_SELINUX -g -fno-common -ffast-math -I pro=
c \
   -W -Wall -Wshadow -Wcast-align -Wredundant-decls \
   -Wbad-function-cast -Wcast-qual -Wwrite-strings -Waggregate-return \
 #  -Wpadded -Wunreachable-code -Wdisabled-optimization \
@@ -128,7 +128,7 @@
 ###### install
=20
 $(BINFILES) : all
-	$(install) --mode a=3Drx --strip $(notdir $@) $@
+	$(install) --mode a=3Drx $(notdir $@) $@
=20
 $(MANFILES) : all
 	$(install) --mode a=3Dr $(notdir $@) $@
--- procps-3.1.9.orig/proc/readproc.c
+++ procps-3.1.9/proc/readproc.c
@@ -27,8 +27,8 @@
 #include <sys/types.h>
 #include <sys/stat.h>
=20
-#ifdef FLASK_LINUX
-#include <fs_secure.h>
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
 #endif
=20
 #ifdef PROF
@@ -82,6 +82,10 @@
 	free((void*)*p->cmdline);
     if (p->environ)
 	free((void*)*p->environ);
+#ifdef WITH_SELINUX
+    if (p->scontext)
+        freecon(p->scontext);
+#endif
     free(p);
 }
=20
@@ -519,10 +523,10 @@
     static struct direct *ent;		/* dirent handle */
     static struct stat sb;		/* stat buffer */
     static char path[32], sbuf[1024];	/* bufs for stat,statm */
-#ifdef FLASK_LINUX
-    security_id_t secsid;
-#endif
     pid_t pid;  // saved until we have a proc_t allocated for sure
+#ifdef WITH_SELINUX
+    int selinux_enabled =3D is_selinux_enabled();
+#endif
=20
     /* loop until a proc matching restrictions is found or no more process=
es */
     /* I know this could be a while loop -- this way is easier to indent ;=
-) */
@@ -546,23 +550,18 @@
 	strcpy(path+6, ent->d_name);  // trust /proc to not contain evil top-leve=
l entries
 //	snprintf(path, sizeof path, "/proc/%s", ent->d_name);
     }
-#ifdef FLASK_LINUX
-    if ( stat_secure(path, &sb, &secsid) =3D=3D -1 ) /* no such dirent (an=
ymore) */
-#else
     if (unlikely(stat(path, &sb) =3D=3D -1))	/* no such dirent (anymore) *=
/
-#endif
 	goto next_proc;
=20
     if ((flags & PROC_UID) && !XinLN(uid_t, sb.st_uid, PT->uids, PT->nuid)=
)
 	goto next_proc;			/* not one of the requested uids */
=20
-    if (!p)
+    if (!p) {
 	p =3D xcalloc(p, sizeof *p); /* passed buf or alloced mem */
+	memset(p, 0, sizeof(p));
+    }
=20
     p->euid =3D sb.st_uid;			/* need a way to get real uid */
-#ifdef FLASK_LINUX
-    p->secsid =3D secsid;
-#endif
     p->pid  =3D pid;
=20
     if (flags & PROC_FILLSTAT) {         /* read, parse /proc/#/stat */
@@ -571,6 +570,30 @@
 	stat2proc(sbuf, p);				/* parse /proc/#/stat */
     }
=20
+#ifdef WITH_SELINUX
+    if (selinux_enabled) {
+	if (p->scontext) {
+	    freecon(p->scontext);
+	    p->scontext=3DNULL;
+	}
+	if (getpidcon(p->pid, &p->scontext) < 0 )
+	    goto next_proc;
+=09
+	if (unlikely(flags & PROC_CONTEXT)) {
+	    int found=3D0;
+	    int i=3D0;
+	    for (i=3D0; PT->scontexts[i]; i++) {
+		if (strcmp(p->scontext, PT->scontexts[i]) =3D=3D0) {
+		    found=3D1;
+		    break;
+		}
+	    }
+	    if (! found)
+		goto next_proc;			/* not one of the requested CONTEXTS */
+	}
+    }
+#endif
+
     if (unlikely(flags & PROC_FILLMEM)) {				/* read, parse /proc/#/statm =
*/
 	if (likely( file2str(path, "statm", sbuf, sizeof sbuf) !=3D -1 ))
 	    statm2proc(sbuf, p);		/* ignore statm errors here */
@@ -630,10 +653,10 @@
     static struct direct *ent;		/* dirent handle */
     static struct stat sb;		/* stat buffer */
     static char path[32], sbuf[1024];	/* bufs for stat,statm */
-#ifdef FLASK_LINUX
-    security_id_t secsid;
-#endif
     pid_t pid;  // saved until we have a proc_t allocated for sure
+#ifdef WITH_SELINUX
+    int selinux_enabled =3D is_selinux_enabled();
+#endif
=20
     /* loop until a proc matching restrictions is found or no more process=
es */
     /* I know this could be a while loop -- this way is easier to indent ;=
-) */
@@ -652,26 +675,30 @@
     strcpy(path+6, ent->d_name);  // trust /proc to not contain evil top-l=
evel entries
 //  snprintf(path, sizeof path, "/proc/%s", ent->d_name);
=20
-#ifdef FLASK_LINUX
-    if (stat_secure(path, &sb, &secsid) =3D=3D -1) /* no such dirent (anym=
ore) */
-#else
     if (stat(path, &sb) =3D=3D -1)		/* no such dirent (anymore) */
-#endif
 	goto next_proc;
=20
     if (!p)
 	p =3D xcalloc(p, sizeof *p); /* passed buf or alloced mem */
=20
     p->euid =3D sb.st_uid;			/* need a way to get real uid */
-#ifdef FLASK_LINUX
-    p->secsid =3D secsid;
-#endif
     p->pid  =3D pid;
=20
     if ((file2str(path, "stat", sbuf, sizeof sbuf)) =3D=3D -1)
 	goto next_proc;			/* error reading /proc/#/stat */
     stat2proc(sbuf, p);				/* parse /proc/#/stat */
=20
+#ifdef WITH_SELINUX
+    if (selinux_enabled) {
+	if (p->scontext) {
+	    freecon(p->scontext);
+	    p->scontext=3DNULL;
+	}
+	if (getpidcon(p->pid, &p->scontext) < 0 )
+	    goto next_proc;
+    }
+#endif
+
     if (flags & PROC_FILLMEM) {				/* read, parse /proc/#/statm */
 	if ((file2str(path, "statm", sbuf, sizeof sbuf)) !=3D -1 )
 	    statm2proc(sbuf, p);		/* ignore statm errors here */
@@ -755,9 +782,15 @@
     }
     else if (flags & PROC_PID)
 	PT =3D openproc(flags, va_arg(ap, void*)); /* assume ptr sizes same */
+#ifdef WITH_SELINUX
+    else if (flags & PROC_CONTEXT)
+	PT =3D openproc(flags, va_arg(ap, security_context_t*));
+#endif
     else
 	PT =3D openproc(flags);
     va_end(ap);
+    if (!PT)
+      return 0;
     do {					/* read table: */
 	tab =3D xrealloc(tab, (n+1)*sizeof(proc_t*));/* realloc as we go, using *=
/
 	tab[n] =3D readproc_direct(PT, NULL);     /* final null to terminate */
--- procps-3.1.9.orig/proc/readproc.h
+++ procps-3.1.9/proc/readproc.h
@@ -14,8 +14,8 @@
=20
 #define SIGNAL_STRING
=20
-#ifdef FLASK_LINUX
-#include <fs_secure.h>
+#ifdef WITH_SELINUX
+#include <selinux/selinux.h>
 #endif
=20
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
=20
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
=20
@@ -218,6 +218,9 @@
 /* Obsolete, consider only processes with one of the passed: */
 #define PROC_PID     0x1000  /* process id numbers ( 0   terminated) */
 #define PROC_UID     0x4000  /* user id numbers    ( length needed ) */
+#ifdef WITH_SELINUX
+#define PROC_CONTEXT 0x8000=20
+#endif
=20
 // it helps to give app code a few spare bits
 #define PROC_SPARE_1 0x01000000
--- procps-3.1.9.orig/ps/display.c
+++ procps-3.1.9/ps/display.c
@@ -246,7 +246,7 @@
     fprintf(stderr, "Error: can not access /proc.\n");
     exit(1);
   }
-  memset(&buf, '#', sizeof(proc_t));
+  memset(&buf, 0, sizeof(proc_t));
   while(ps_readproc(ptp,&buf)){
     if(want_this_proc(&buf)) show_one_proc(&buf);
     if(buf.cmdline) free((void*)*buf.cmdline); // ought to reuse
--- procps-3.1.9.orig/ps/help.c
+++ procps-3.1.9/ps/help.c
@@ -35,8 +35,8 @@
 "-O,O preloaded -o  v  virtual memory  --cumulative --format --deselect\n"
 "-l,l long          u  user-oriented   --sort --tty --forest --version\n"
 "-F   extra full    X  registers       --heading --no-heading\n"
-#ifdef FLASK_LINUX
-"                                      --context --SID   (Flask only)\n"
+#ifdef WITH_SELINUX
+"                                      --context (SELinux only)\n"
 #endif
 "                    ********* misc options *********\n"
 "-V,V show version       L  list format codes  f  ASCII art forest\n"
--- procps-3.1.9.orig/ps/output.c
+++ procps-3.1.9/ps/output.c
@@ -68,11 +68,9 @@
 #include "../proc/escape.h"
 #include "common.h"
=20
-#ifdef FLASK_LINUX
+#ifdef WITH_SELINUX
 #include <errno.h>
-#include <fs_secure.h>
-#include <ss.h>
-#define DEF_CTXTLEN 255
+#include <selinux/selinux.h>
 #endif
=20
=20
@@ -208,6 +206,9 @@
 CMP_SMALL(pcpu)
=20
 CMP_SMALL(state)
+#ifdef WITH_SELINUX
+CMP_STR(scontext)
+#endif
=20
 /* approximation to: kB of address space that could end up in swap */
 static int sr_swapable(const proc_t* P, const proc_t* Q) {
@@ -957,7 +958,7 @@
=20
=20
 /****************** FLASK security stuff **********************/
-#ifdef FLASK_LINUX
+#ifdef WITH_SELINUX
=20
 /*
  * The sr_fn() calls -- for sorting -- don't return errors because
@@ -965,128 +966,26 @@
  * is called, at which point the error goes onscreen.
  */
=20
-/* as above, creates sr_secsid function */
-CMP_INT(secsid)  /* FLASK security ID, **NOT** a session ID -- ugh */
-
-static int pr_secsid(char *restrict const outbuf, const proc_t *restrict c=
onst pp){
-  return sprintf(outbuf, "%d", (int) pp->secsid);
-}
-
 static int pr_context(char *restrict const outbuf, const proc_t *restrict =
const pp){
-  char *ctxt; /* should be security_context_t */
-  unsigned int len;
-  int rv;
-
-  len =3D DEF_CTXTLEN;
-  ctxt =3D (char *) calloc(1, len);
-  if ( ctxt !=3D NULL )
-    rv =3D security_sid_to_context(pp->secsid, (security_context_t) ctxt, =
&len);
-  else
-    return sprintf(outbuf, "-");
-
-  if ( rv ) {
-    if ( errno !=3D ENOSPC ) {
-      free(ctxt);
-      return sprintf(outbuf, "-");
-    } else {
-      free(ctxt);
-      ctxt =3D (char *) calloc(1, len);
-      if ( ctxt !=3D NULL ) {
-	rv =3D security_sid_to_context(pp->secsid, (security_context_t) ctxt, &le=
n);
-	if ( rv ) {
-	  free(ctxt);
-	  return sprintf(outbuf, "-");
-	} else {
-	  rv =3D sprintf(outbuf, "%s", ctxt);
-	  free(ctxt);
-	  return rv;
-	}
-      } else {           /* calloc() failed */
-	return sprintf(outbuf, "-");
-      }
-    }
+  if (pp->scontext) {
+    sprintf(outbuf, pp->scontext);
   } else {
-    rv =3D sprintf(outbuf, "%s", ctxt);
-    free(ctxt);
-    return rv;
+    sprintf(outbuf, "-");
   }
 }
=20
-
 static int sr_context ( const proc_t* P, const proc_t* Q ) {
-  char *ctxt_P, *ctxt_Q; /* type should be security_context_t */
-  unsigned int len;
-  int rv;
-
-  len =3D DEF_CTXTLEN;
-  ctxt_P =3D (char *) calloc(1, len);
-  ctxt_Q =3D (char *) calloc(1, len);
-
-  rv =3D security_sid_to_context(P->secsid, (security_context_t) ctxt_P, &=
len);
-  if ( rv ) {
-    if ( errno !=3D ENOSPC ) {
-      free(ctxt_P);
-      /* error should resurface during printing */
-      return( 0 );
-    } else {
-      free(ctxt_P);
-      ctxt_P =3D (char *) calloc(1, len);
-      if ( ctxt_P !=3D NULL ) {
-	rv =3D security_sid_to_context(P->secsid, (security_context_t) ctxt_P, &l=
en);
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
-  len =3D DEF_CTXTLEN;
-
-  rv =3D security_sid_to_context(Q->secsid, (security_context_t) ctxt_Q, &=
len);
-  if ( rv ) {
-    if ( errno !=3D ENOSPC ) {
-      free(ctxt_P);
-      free(ctxt_Q);
-      /* error should resurface during printing */
-      return( 0 );
-    } else {
-      free(ctxt_Q);
-      ctxt_Q =3D (char *) calloc(1, len);
-      if ( ctxt_Q !=3D NULL ) {
-	rv =3D security_sid_to_context(Q->secsid, (security_context_t) ctxt_Q, &l=
en);
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
-  rv =3D strcmp(ctxt_P, ctxt_Q);
-
-  free(ctxt_P);
-  free(ctxt_Q);
-
-  return( rv );
+  if ((P->scontext=3D=3DNULL) && (Q->scontext=3D=3DNULL))
+    return 0;
+  if ((P->scontext=3D=3DNULL) || (Q->scontext=3D=3DNULL))
+    return 1;
+  return strcmp(P->scontext, Q->scontext);
 }
=20
 #else
=20
 /****** dummy functions ******/
=20
-#define pr_secsid pr_nop
-#define sr_secsid sr_nop
 #define pr_context pr_nop
 #define sr_context sr_nop
=20
@@ -1274,7 +1173,7 @@
 {"sched",     "SCH",     pr_sched,    sr_sched,   3,   0,    AIX, RIGHT},
 {"scnt",      "SCNT",    pr_nop,      sr_nop,     4,   0,    DEC, RIGHT}, =
 /* man page misspelling of scount? */
 {"scount",    "SC",      pr_nop,      sr_nop,     4,   0,    AIX, RIGHT}, =
 /* scnt=3D=3Dscount, DEC claims both */
-{"secsid",    "SID",     pr_secsid,   sr_secsid,  6,   0,    LNX, RIGHT}, =
/* Flask Linux */
+{"context",   "CONTEXT", pr_context,  sr_context,40,   0,    LNX, RIGHT}, =
/* SE Linux */
 {"sess",      "SESS",    pr_sess,     sr_session, 5,   0,    XXX, RIGHT},
 {"session",   "SESS",    pr_sess,     sr_session, 5,   0,    LNX, RIGHT},
 {"sgi_p",     "P",       pr_sgi_p,    sr_nop,     1,   0,    LNX, RIGHT}, =
/* "cpu" number */
@@ -1384,9 +1283,6 @@
=20
 {"FL5FMT",   "f,state,uid,pid,ppid,pcpu,pri,nice,rss,wchan,start,time,comm=
and"},  /* Digital -fl */
=20
-{"FLASK_context",   "pid,secsid,context,command"},  /* Flask Linux context=
, --context */
-{"FLASK_sid",       "pid,secsid,command"},          /* Flask Linux SID,   =
  --SID */
-
 {"HP_",      "pid,tty,time,comm"},  /* HP default */
 {"HP_f",     "user,pid,ppid,cpu,stime,tty,time,args"},  /* HP -f */
 {"HP_fl",    "flags,state,user,pid,ppid,cpu,intpri,nice,addr,sz,wchan,stim=
e,tty,time,args"},  /* HP -fl */
@@ -1414,6 +1310,9 @@
=20
 {"RUSAGE",   "minflt,majflt,nswap,inblock,oublock,msgsnd,msgrcv,nsigs,nvcs=
w,nivcsw"}, /* Digital -o "RUSAGE" */
 {"SCHED",    "user,pcpu,pri,usrpri,nice,psxpri,psr,policy,pset"},         =
       /* Digital -o "SCHED" */
+#ifdef WITH_SELINUX
+{"SELINUX_context",   "pid,context,command"},  /* SELinux Linux context, -=
-context */
+#endif
 {"SFMT",     "uid,pid,cursig,sig,sigmask,sigignore,sigcatch,stat,tname,com=
mand"},  /* Digital s */
=20
 {"Std_f",    "uid_hack,pid,ppid,c,stime,tname,time,cmd"},                 =
    /* new -f */
--- procps-3.1.9.orig/ps/parser.c
+++ procps-3.1.9/ps/parser.c
@@ -727,7 +727,6 @@
   gnu_table_struct *found;
   static const gnu_table_struct gnu_table[] =3D {
   {"Group",         &&case_Group},       /* rgid */
-  {"SID",           &&case_secsid},
   {"User",          &&case_User},        /* ruid */
   {"cols",          &&case_cols},
   {"columns",       &&case_columns},
@@ -755,7 +754,6 @@
   {"pid",           &&case_pid},
   {"ppid",          &&case_ppid},
   {"rows",          &&case_rows},
-  {"secsid",        &&case_secsid},
   {"sid",           &&case_sid},
   {"sort",          &&case_sort},
   {"tty",           &&case_tty},
@@ -941,13 +939,14 @@
     exit(0);
     return NULL;
   case_context:
-    trace("--context\n");
-    format_flags |=3D FF_Fc;
+    if (is_selinux_enabled()) {
+	trace("--context\n");
+	format_flags |=3D FF_Fc;
+    } else {
+	  fprintf(stderr,
+		  "Warning: --context ignored. Requires a SELinux enabled kernel\n");
+    }
     return NULL;
-  case_secsid:
-     trace("--secsid\n");
-     format_flags |=3D FF_Fs;
-     return NULL;
 }
=20
 /*************** process trailing PIDs  **********************/
--- procps-3.1.9.orig/ps/sortformat.c
+++ procps-3.1.9/ps/sortformat.c
@@ -803,9 +803,8 @@
     case FF_LX:          spec=3D"OL_X";         break;
     case FF_Lm:          spec=3D"OL_m";         break;
=20
-    /* These are FLASK security options. */
-    case FF_Fc:          spec=3D"FLASK_context"; break;
-    case FF_Fs:          spec=3D"FLASK_sid";     break;
+    /* These are SELinux security options. */
+    case FF_Fc:          spec=3D"SELINUX_context"; break;
=20
     }  /* end switch(format_flags) */
=20
--- procps-3.1.9.orig/ps/common.h
+++ procps-3.1.9/ps/common.h
@@ -103,7 +103,6 @@
 #define FF_LX 0x0100 /* X */
 #define FF_Lm 0x0200 /* m */  /* overloaded: threads, sort, format */
 #define FF_Fc 0x0400 /* --context */  /* Flask security context format */
-#define FF_Fs 0x0800 /* --SID */      /* Flask SID format */
=20
 /* predefined format modifier flags such as:  -l -f l u s -j */
 #define FM_c 0x0001 /* -c */

--=-8FiobVtZZYJeC6hEkVqw--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
