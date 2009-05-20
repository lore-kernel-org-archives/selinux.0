From: Dennis Wronka <linuxweb@gmx.net>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: Policy loading problem
Date: Wed, 20 May 2009 22:07:28 +0800
Cc: SELinux@tycho.nsa.gov
References: <1242641994.470.5.camel@notebook2.grift.internal> <200905202146.54559.linuxweb@gmx.net> <1242827392.20082.392.camel@localhost.localdomain>
In-Reply-To: <1242827392.20082.392.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart25896236.IyZ8Atov0X";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200905202207.31829.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--nextPart25896236.IyZ8Atov0X
Content-Type: multipart/mixed;
  boundary="Boundary-01=_h6AFKO1aPYYASLe"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_h6AFKO1aPYYASLe
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Sorry I got to ask, but what do you actually mean by "initial policy loadin=
g=20
logic"?

I haven't actually written any code that handles the policy. I took the=20
attached patch for SysVInit and applied it. From what I know this is the=20
commonly used patch for this, as it seems to be pretty identical wherever I=
'm=20
looking.

One thing that has changed recently, although I am not sure if this could b=
e=20
the reason, is that I have switched the second run of compiling GLibC to a=
=20
later time. Usually I compile GLibC without SELinux, the the SELinux-librar=
ies=20
and then GLibC with SELinux. Currently this way results in an infinite loop=
=20
when compiling GLibC, so to resolve this (although I hope this to be a=20
temporary solution) I moved compiling GLibC with SELinux after compiling=20
BinUtils and GCC.

I pretty much follow the LFS-book, except for a few adjustments and additio=
ns=20
for SELinux.

In terms of code I haven't written much except shell-scripts, which do the=
=20
actual installation of the software.

So, please clarify what you mean by "initial policy loading logic", then I'=
ll=20
do my best to provide more information.

Regards,
Dennis

On Wednesday 20 May 2009 21:49:52 Stephen Smalley wrote:
> On Wed, 2009-05-20 at 21:46 +0800, Dennis Wronka wrote:
> > I have actually tried both.
> > The way it's usually done is through a patched init, which used to work
> > some time ago (I don't remember which version of the kernel, the policy
> > and the SELinux-tools/-libraries I used then, as everything always is
> > being updated and I worked on a lot of other stuff in between).
> > I also tried the approach Fedora uses, pretty much taking apart their
> > initrd and reimplementing the load_policy-command from nash into a
> > seperate program as I had trouble compiling nash). I got it partially
> > working later, but not in the way I used to do it and not the way it's
> > supposed to be.
> >
> > So, as said, the it's supposed to be is a patched init, although I could
> > live with doing it in my initramfs (I use that instead of an initrd, but
> > it's basically the same anyway).
> >
> > Still I find it quite confusing that the policy gets loaded when I set
> > SELinux to enforcing, but not when I set it to permissive.
>
> You didn't post your initial policy loading logic like I asked.  I agree
> that there is no reason why it shouldn't get loaded when permissive, and
> I don't see that behavior in Fedora, so I have to assume there is a bug
> in the way you've integrated initial policy load in your distribution.
>
> So, once again:  if you want help, show us how you are performing your
> initial policy load (the actual code).
>
> Also, if you boot permissive and then manually run load_policy, does
> that work?  If so, then that even more strongly indicates a bug in how
> you've integrated initial policy load in your distro.



--Boundary-01=_h6AFKO1aPYYASLe
Content-Type: text/x-patch;
  charset="UTF-8";
  name="sysvinit-2.86-selinux.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sysvinit-2.86-selinux.patch"

diff -U 3 -H -d -r -N -- sysvinit-2.86/src/Makefile sysvinit-2.86-selinux/s=
rc/Makefile
=2D-- sysvinit-2.86/src/Makefile	2004-06-09 20:47:45.000000000 +0800
+++ sysvinit-2.86-selinux/src/Makefile	2007-03-09 22:30:14.000000000 +0800
@@ -57,7 +57,7 @@
 all:		$(BIN) $(SBIN) $(USRBIN)
=20
 init:		init.o init_utmp.o
=2D		$(CC) $(LDFLAGS) $(STATIC) -o $@ init.o init_utmp.o
+		$(CC) $(LDFLAGS) $(STATIC) -o $@ init.o init_utmp.o -lsepol -lselinux
=20
 halt:		halt.o ifdown.o hddown.o utmp.o reboot.h
 		$(CC) $(LDFLAGS) -o $@ halt.o ifdown.o hddown.o utmp.o
@@ -78,7 +78,7 @@
 		$(CC) $(LDFLAGS) -o $@ runlevel.o
=20
 sulogin:	sulogin.o
=2D		$(CC) $(LDFLAGS) $(STATIC) -o $@ sulogin.o $(LCRYPT)
+		$(CC) $(LDFLAGS) $(STATIC) -o $@ sulogin.o $(LCRYPT) -lselinux
=20
 wall:		dowall.o wall.o
 		$(CC) $(LDFLAGS) -o $@ dowall.o wall.o
diff -U 3 -H -d -r -N -- sysvinit-2.86/src/Makefile~ sysvinit-2.86-selinux/=
src/Makefile~
=2D-- sysvinit-2.86/src/Makefile~	1970-01-01 08:00:00.000000000 +0800
+++ sysvinit-2.86-selinux/src/Makefile~	2004-06-09 20:47:45.000000000 +0800
@@ -0,0 +1,148 @@
+#
+# Makefile	Makefile for the systemV init suite.
+#		Targets:   all      compiles everything
+#		           install  installs the binaries (not the scripts)
+#                          clean    cleans up object files
+#			   clobber  really cleans up
+#
+# Version:	@(#)Makefile  2.85-13  23-Mar-2004  miquels@cistron.nl
+#
+
+CC	=3D gcc
+CFLAGS	=3D -Wall -O2 -fomit-frame-pointer -D_GNU_SOURCE
+LDFLAGS	=3D -s
+STATIC	=3D
+
+# For some known distributions we do not build all programs, otherwise we =
do.
+BIN	=3D
+SBIN	=3D init halt shutdown runlevel killall5
+USRBIN	=3D last mesg
+
+MAN1	=3D last.1 lastb.1 mesg.1
+MAN5	=3D initscript.5 inittab.5
+MAN8	=3D halt.8 init.8 killall5.8 pidof.8 poweroff.8 reboot.8 runlevel.8
+MAN8	+=3D shutdown.8 telinit.8
+
+ifeq ($(DISTRO),)
+BIN	+=3D mountpoint
+SBIN	+=3D sulogin bootlogd
+USRBIN	+=3D utmpdump wall
+MAN1	+=3D mountpoint.1 wall.1
+MAN8	+=3D sulogin.8 bootlogd.8
+endif
+
+ifeq ($(DISTRO),Debian)
+BIN	+=3D mountpoint
+SBIN	+=3D sulogin bootlogd
+MAN1	+=3D mountpoint.1
+MAN8	+=3D sulogin.8 bootlogd.8
+endif
+
+ifeq ($(DISTRO),Owl)
+USRBIN	+=3D wall
+MAN1	+=3D wall.1
+endif
+
+BIN_OWNER	=3D root
+BIN_GROUP	=3D root
+BIN_COMBO	=3D $(BIN_OWNER):$(BIN_GROUP)
+INSTALL		=3D install -o $(BIN_OWNER) -g $(BIN_GROUP)
+MANDIR		=3D /usr/share/man
+
+# Additional libs for GNU libc.
+ifneq ($(wildcard /usr/lib/libcrypt.a),)
+LCRYPT		=3D -lcrypt
+endif
+
+all:		$(BIN) $(SBIN) $(USRBIN)
+
+init:		init.o init_utmp.o
+		$(CC) $(LDFLAGS) $(STATIC) -o $@ init.o init_utmp.o
+
+halt:		halt.o ifdown.o hddown.o utmp.o reboot.h
+		$(CC) $(LDFLAGS) -o $@ halt.o ifdown.o hddown.o utmp.o
+
+last:		last.o oldutmp.h
+		$(CC) $(LDFLAGS) -o $@ last.o
+
+mesg:		mesg.o
+		$(CC) $(LDFLAGS) -o $@ mesg.o
+
+mountpoint:	mountpoint.o
+		$(CC) $(LDFLAGS) -o $@ mountpoint.o
+
+utmpdump:	utmpdump.o
+		$(CC) $(LDFLAGS) -o $@ utmpdump.o
+
+runlevel:	runlevel.o
+		$(CC) $(LDFLAGS) -o $@ runlevel.o
+
+sulogin:	sulogin.o
+		$(CC) $(LDFLAGS) $(STATIC) -o $@ sulogin.o $(LCRYPT)
+
+wall:		dowall.o wall.o
+		$(CC) $(LDFLAGS) -o $@ dowall.o wall.o
+
+shutdown:	dowall.o shutdown.o utmp.o reboot.h
+		$(CC) $(LDFLAGS) -o $@ dowall.o shutdown.o utmp.o
+
+bootlogd:	bootlogd.o
+		$(CC) $(LDFLAGS) -o $@ bootlogd.o -lutil
+
+init.o:		init.c init.h set.h reboot.h initreq.h
+		$(CC) -c $(CFLAGS) init.c
+
+utmp.o:		utmp.c init.h
+		$(CC) -c $(CFLAGS) utmp.c
+
+init_utmp.o:	utmp.c init.h
+		$(CC) -c $(CFLAGS) -DINIT_MAIN utmp.c -o init_utmp.o
+
+cleanobjs:
+		rm -f *.o *.bak
+
+clean:		cleanobjs
+		@echo Type \"make clobber\" to really clean up.
+
+clobber:	cleanobjs
+		rm -f $(BIN) $(SBIN) $(USRBIN)
+
+distclean:	clobber
+
+install:
+		for i in $(BIN); do \
+			$(INSTALL) -m 755 $$i $(ROOT)/bin/; \
+		done
+		for i in $(SBIN); do \
+			$(INSTALL) -m 755 $$i $(ROOT)/sbin/; \
+		done
+		for i in $(USRBIN); do \
+			$(INSTALL) -m 755 $$i $(ROOT)/usr/bin/; \
+		done
+		# $(INSTALL) -m 755 etc/initscript.sample $(ROOT)/etc/
+		ln -sf halt $(ROOT)/sbin/reboot
+		ln -sf halt $(ROOT)/sbin/poweroff
+		ln -sf init $(ROOT)/sbin/telinit
+		ln -sf ../sbin/killall5 $(ROOT)/bin/pidof
+		if [ ! -f $(ROOT)/usr/bin/lastb ]; then \
+			ln -sf last $(ROOT)/usr/bin/lastb; \
+		fi
+		$(INSTALL) -m 644 initreq.h $(ROOT)/usr/include/
+		for i in $(MAN1); do \
+			$(INSTALL) -m 644 ../man/$$i $(ROOT)$(MANDIR)/man1/; \
+		done
+		for i in $(MAN5); do \
+			$(INSTALL) -m 644 ../man/$$i $(ROOT)$(MANDIR)/man5/; \
+		done
+		for i in $(MAN8); do \
+			$(INSTALL) -m 644 ../man/$$i $(ROOT)$(MANDIR)/man8/; \
+		done
+ifeq ($(ROOT),)
+		#
+		# This part is skipped on Debian systems, the
+		# debian.preinst script takes care of it.
+		@if [ ! -p /dev/initctl ]; then \
+		 echo "Creating /dev/initctl"; \
+		 rm -f /dev/initctl; \
+		 mknod -m 600 /dev/initctl p; fi
+endif
diff -U 3 -H -d -r -N -- sysvinit-2.86/src/init.c sysvinit-2.86-selinux/src=
/init.c
=2D-- sysvinit-2.86/src/init.c	2004-07-30 20:16:20.000000000 +0800
+++ sysvinit-2.86-selinux/src/init.c	2007-03-09 22:28:38.000000000 +0800
@@ -42,6 +42,8 @@
 #include <stdarg.h>
 #include <sys/syslog.h>
 #include <sys/time.h>
+#include <selinux/selinux.h>
+
=20
 #ifdef __i386__
 #  if (__GLIBC__ >=3D 2)
@@ -2599,6 +2601,7 @@
 	char			*p;
 	int			f;
 	int			isinit;
+	int			enforce =3D 0;
=20
 	/* Get my own name */
 	if ((p =3D strrchr(argv[0], '/')) !=3D NULL)
@@ -2662,6 +2665,20 @@
 		maxproclen +=3D strlen(argv[f]) + 1;
 	}
=20
+  	if (getenv("SELINUX_INIT") =3D=3D NULL) {
+	  putenv("SELINUX_INIT=3DYES");
+	  if (selinux_init_load_policy(&enforce) =3D=3D 0 ) {
+	    execv(myname, argv);
+	  } else {
+	    if (enforce > 0) {
+	      /* SELinux in enforcing mode but load_policy failed */
+	      /* At this point, we probably can't open /dev/console, so log() won=
't work */
+		    printf("Unable to load SELinux Policy. Machine is in enforcing mode.=
 Halting now.\n");
+	      exit(1);
+	    }
+	  }
+	}
+ =20
 	/* Start booting. */
 	argv0 =3D argv[0];
 	argv[1] =3D NULL;
diff -U 3 -H -d -r -N -- sysvinit-2.86/src/init.c~ sysvinit-2.86-selinux/sr=
c/init.c~
=2D-- sysvinit-2.86/src/init.c~	1970-01-01 08:00:00.000000000 +0800
+++ sysvinit-2.86-selinux/src/init.c~	2004-07-30 20:16:20.000000000 +0800
@@ -0,0 +1,2673 @@
+/*
+ * Init		A System-V Init Clone.
+ *
+ * Usage:	/sbin/init
+ *		     init [0123456SsQqAaBbCc]
+ *		  telinit [0123456SsQqAaBbCc]
+ *
+ * Version:	@(#)init.c  2.86  30-Jul-2004  miquels@cistron.nl
+ */
+#define VERSION "2.86"
+#define DATE    "31-Jul-2004"
+/*
+ *		This file is part of the sysvinit suite,
+ *		Copyright 1991-2004 Miquel van Smoorenburg.
+ *
+ *		This program is free software; you can redistribute it and/or
+ *		modify it under the terms of the GNU General Public License
+ *		as published by the Free Software Foundation; either version
+ *		2 of the License, or (at your option) any later version.
+ *
+ */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <sys/wait.h>
+#ifdef __linux__
+#include <sys/kd.h>
+#endif
+#include <sys/resource.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+#include <stdio.h>
+#include <time.h>
+#include <fcntl.h>
+#include <string.h>
+#include <signal.h>
+#include <termios.h>
+#include <utmp.h>
+#include <ctype.h>
+#include <stdarg.h>
+#include <sys/syslog.h>
+#include <sys/time.h>
+
+#ifdef __i386__
+#  if (__GLIBC__ >=3D 2)
+     /* GNU libc 2.x */
+#    define STACK_DEBUG 1
+#    if (__GLIBC__ =3D=3D 2 && __GLIBC_MINOR__ =3D=3D 0)
+       /* Only glibc 2.0 needs this */
+#      include <sigcontext.h>
+#    endif
+#  endif
+#endif
+
+#include "init.h"
+#include "initreq.h"
+#include "paths.h"
+#include "reboot.h"
+#include "set.h"
+
+#ifndef SIGPWR
+#  define SIGPWR SIGUSR2
+#endif
+
+#ifndef CBAUD
+#  define CBAUD		0
+#endif
+#ifndef CBAUDEX
+#  define CBAUDEX	0
+#endif
+
+/* Set a signal handler. */
+#define SETSIG(sa, sig, fun, flags) \
+		do { \
+			sa.sa_handler =3D fun; \
+			sa.sa_flags =3D flags; \
+			sigemptyset(&sa.sa_mask); \
+			sigaction(sig, &sa, NULL); \
+		} while(0)
+
+/* Version information */
+char *Version =3D "@(#) init " VERSION "  " DATE "  miquels@cistron.nl";
+char *bootmsg =3D "version " VERSION " %s";
+#define E_VERSION "INIT_VERSION=3Dsysvinit-" VERSION
+
+CHILD *family =3D NULL;		/* The linked list of all entries */
+CHILD *newFamily =3D NULL;	/* The list after inittab re-read */
+
+CHILD ch_emerg =3D {		/* Emergency shell */
+	0, 0, 0, 0, 0,
+	"~~",
+	"S",
+	3,
+	"/sbin/sulogin",
+	NULL,
+	NULL
+};
+
+char runlevel =3D 'S';		/* The current run level */
+char thislevel =3D 'S';		/* The current runlevel */
+char prevlevel =3D 'N';		/* Previous runlevel */
+int dfl_level =3D 0;		/* Default runlevel */
+sig_atomic_t got_cont =3D 0;	/* Set if we received the SIGCONT signal */
+sig_atomic_t got_signals;	/* Set if we received a signal. */
+int emerg_shell =3D 0;		/* Start emergency shell? */
+int wrote_wtmp_reboot =3D 1;	/* Set when we wrote the reboot record */
+int wrote_utmp_reboot =3D 1;	/* Set when we wrote the reboot record */
+int sltime =3D 5;			/* Sleep time between TERM and KILL */
+char *argv0;			/* First arguments; show up in ps listing */
+int maxproclen;			/* Maximal length of argv[0] with \0 */
+struct utmp utproto;		/* Only used for sizeof(utproto.ut_id) */
+char *user_console =3D NULL;	/* User console device */
+char *console_dev;		/* Console device. */
+int pipe_fd =3D -1;		/* /dev/initctl */
+int did_boot =3D 0;		/* Did we already do BOOT* stuff? */
+int main(int, char **);
+
+/*	Used by re-exec part */
+int reload =3D 0;			/* Should we do initialization stuff? */
+char *myname=3D"/sbin/init";	/* What should we exec */
+int oops_error;			/* Used by some of the re-exec code. */
+const char *Signature =3D "12567362";	/* Signature for re-exec fd */
+
+/* Macro to see if this is a special action */
+#define ISPOWER(i) ((i) =3D=3D POWERWAIT || (i) =3D=3D POWERFAIL || \
+		    (i) =3D=3D POWEROKWAIT || (i) =3D=3D POWERFAILNOW || \
+		    (i) =3D=3D CTRLALTDEL)
+
+/* ascii values for the `action' field. */
+struct actions {
+  char *name;
+  int act;
+} actions[] =3D {
+  { "respawn", 	   RESPAWN	},
+  { "wait",	   WAIT		},
+  { "once",	   ONCE		},
+  { "boot",	   BOOT		},
+  { "bootwait",	   BOOTWAIT	},
+  { "powerfail",   POWERFAIL	},
+  { "powerfailnow",POWERFAILNOW },
+  { "powerwait",   POWERWAIT	},
+  { "powerokwait", POWEROKWAIT	},
+  { "ctrlaltdel",  CTRLALTDEL	},
+  { "off",	   OFF		},
+  { "ondemand",	   ONDEMAND	},
+  { "initdefault", INITDEFAULT	},
+  { "sysinit",	   SYSINIT	},
+  { "kbrequest",   KBREQUEST    },
+  { NULL,	   0		},
+};
+
+/*
+ *	State parser token table (see receive_state)
+ */
+struct {
+  char name[4];=09
+  int cmd;
+} cmds[] =3D {
+  { "VER", 	   C_VER	},
+  { "END",	   C_END	},
+  { "REC",	   C_REC	},
+  { "EOR",	   C_EOR	},
+  { "LEV",	   C_LEV	},
+  { "FL ",	   C_FLAG	},
+  { "AC ",	   C_ACTION	},
+  { "CMD",	   C_PROCESS	},
+  { "PID",	   C_PID	},
+  { "EXS",	   C_EXS	},
+  { "-RL",	   D_RUNLEVEL	},
+  { "-TL",	   D_THISLEVEL	},
+  { "-PL",	   D_PREVLEVEL	},
+  { "-SI",	   D_GOTSIGN	},
+  { "-WR",	   D_WROTE_WTMP_REBOOT},
+  { "-WU",	   D_WROTE_UTMP_REBOOT},
+  { "-ST",	   D_SLTIME	},
+  { "-DB",	   D_DIDBOOT	},
+  { "",	   	   0		}
+};
+struct {
+	char *name;
+	int mask;
+} flags[]=3D{
+	{"RU",RUNNING},
+	{"DE",DEMAND},
+	{"XD",XECUTED},
+	{NULL,0}
+};
+
+#define NR_EXTRA_ENV	16
+char *extra_env[NR_EXTRA_ENV];
+
+
+/*
+ *	Sleep a number of seconds.
+ *
+ *	This only works correctly because the linux select updates
+ *	the elapsed time in the struct timeval passed to select!
+ */
+void do_sleep(int sec)
+{
+	struct timeval tv;
+
+	tv.tv_sec =3D sec;
+	tv.tv_usec =3D 0;
+
+	while(select(0, NULL, NULL, NULL, &tv) < 0 && errno =3D=3D EINTR)
+		;
+}
+
+
+/*
+ *	Non-failing allocation routines (init cannot fail).
+ */
+void *imalloc(size_t size)
+{
+	void	*m;
+
+	while ((m =3D malloc(size)) =3D=3D NULL) {
+		initlog(L_VB, "out of memory");
+		do_sleep(5);
+	}
+	memset(m, 0, size);
+	return m;
+}
+
+
+char *istrdup(char *s)
+{
+	char	*m;
+	int	l;
+
+	l =3D strlen(s) + 1;
+	m =3D imalloc(l);
+	memcpy(m, s, l);
+	return m;
+}
+
+
+/*
+ *	Send the state info of the previous running init to
+ *	the new one, in a version-independant way.
+ */
+void send_state(int fd)
+{
+	FILE	*fp;
+	CHILD	*p;
+	int	i,val;
+
+	fp =3D fdopen(fd,"w");
+
+	fprintf(fp, "VER%s\n", Version);
+	fprintf(fp, "-RL%c\n", runlevel);
+	fprintf(fp, "-TL%c\n", thislevel);
+	fprintf(fp, "-PL%c\n", prevlevel);
+	fprintf(fp, "-SI%u\n", got_signals);
+	fprintf(fp, "-WR%d\n", wrote_wtmp_reboot);
+	fprintf(fp, "-WU%d\n", wrote_utmp_reboot);
+	fprintf(fp, "-ST%d\n", sltime);
+	fprintf(fp, "-DB%d\n", did_boot);
+
+	for (p =3D family; p; p =3D p->next) {
+		fprintf(fp, "REC%s\n", p->id);
+		fprintf(fp, "LEV%s\n", p->rlevel);
+		for (i =3D 0, val =3D p->flags; flags[i].mask; i++)
+			if (val & flags[i].mask) {
+				val &=3D ~flags[i].mask;
+				fprintf(fp, "FL %s\n",flags[i].name);
+			}
+		fprintf(fp, "PID%d\n",p->pid);
+		fprintf(fp, "EXS%u\n",p->exstat);
+		for(i =3D 0; actions[i].act; i++)
+			if (actions[i].act =3D=3D p->action) {
+				fprintf(fp, "AC %s\n", actions[i].name);
+				break;
+			}
+		fprintf(fp, "CMD%s\n", p->process);
+		fprintf(fp, "EOR\n");
+	}
+	fprintf(fp, "END\n");
+	fclose(fp);
+}
+
+/*
+ *	Read a string from a file descriptor.
+ *	FIXME: why not use fgets() ?
+ */
+static int get_string(char *p, int size, FILE *f)
+{
+	int	c;
+
+	while ((c =3D getc(f)) !=3D EOF && c !=3D '\n') {
+		if (--size > 0)
+			*p++ =3D c;
+	}
+	*p =3D '\0';
+	return (c !=3D EOF) && (size > 0);
+}
+
+/*
+ *	Read trailing data from the state pipe until we see a newline.
+ */
+static int get_void(FILE *f)
+{
+	int	c;
+
+	while ((c =3D getc(f)) !=3D EOF && c !=3D '\n')
+		;
+
+	return (c !=3D EOF);
+}
+
+/*
+ *	Read the next "command" from the state pipe.
+ */
+static int get_cmd(FILE *f)
+{
+	char	cmd[4] =3D "   ";
+	int	i;
+
+	if (fread(cmd, 1, sizeof(cmd) - 1, f) !=3D sizeof(cmd) - 1)
+		return C_EOF;
+
+	for(i =3D 0; cmds[i].cmd && strcmp(cmds[i].name, cmd) !=3D 0; i++)
+		;
+	return cmds[i].cmd;
+}
+
+/*
+ *	Read a CHILD * from the state pipe.
+ */
+static CHILD *get_record(FILE *f)
+{
+	int	cmd;
+	char	s[32];
+	int	i;
+	CHILD	*p;
+
+	do {
+		switch (cmd =3D get_cmd(f)) {
+			case C_END:
+				get_void(f);
+				return NULL;
+			case 0:
+				get_void(f);
+				break;
+			case C_REC:
+				break;
+			case D_RUNLEVEL:
+				fscanf(f, "%c\n", &runlevel);
+				break;
+			case D_THISLEVEL:
+				fscanf(f, "%c\n", &thislevel);
+				break;
+			case D_PREVLEVEL:
+				fscanf(f, "%c\n", &prevlevel);
+				break;
+			case D_GOTSIGN:
+				fscanf(f, "%u\n", &got_signals);
+				break;
+			case D_WROTE_WTMP_REBOOT:
+				fscanf(f, "%d\n", &wrote_wtmp_reboot);
+				break;
+			case D_WROTE_UTMP_REBOOT:
+				fscanf(f, "%d\n", &wrote_utmp_reboot);
+				break;
+			case D_SLTIME:
+				fscanf(f, "%d\n", &sltime);
+				break;
+			case D_DIDBOOT:
+				fscanf(f, "%d\n", &did_boot);
+				break;
+			default:
+				if (cmd > 0 || cmd =3D=3D C_EOF) {
+					oops_error =3D -1;
+					return NULL;
+				}
+		}
+	} while (cmd !=3D C_REC);
+
+	p =3D imalloc(sizeof(CHILD));
+	get_string(p->id, sizeof(p->id), f);
+
+	do switch(cmd =3D get_cmd(f)) {
+		case 0:
+		case C_EOR:
+			get_void(f);
+			break;
+		case C_PID:
+			fscanf(f, "%d\n", &(p->pid));
+			break;
+		case C_EXS:
+			fscanf(f, "%u\n", &(p->exstat));
+			break;
+		case C_LEV:
+			get_string(p->rlevel, sizeof(p->rlevel), f);
+			break;
+		case C_PROCESS:
+			get_string(p->process, sizeof(p->process), f);
+			break;
+		case C_FLAG:
+			get_string(s, sizeof(s), f);
+			for(i =3D 0; flags[i].name; i++) {
+				if (strcmp(flags[i].name,s) =3D=3D 0)
+					break;
+			}
+			p->flags |=3D flags[i].mask;
+			break;
+		case C_ACTION:
+			get_string(s, sizeof(s), f);
+			for(i =3D 0; actions[i].name; i++) {
+				if (strcmp(actions[i].name, s) =3D=3D 0)
+					break;
+			}
+			p->action =3D actions[i].act ? actions[i].act : OFF;
+			break;
+		default:
+			free(p);
+			oops_error =3D -1;
+			return NULL;
+	} while( cmd !=3D C_EOR);
+
+	return p;
+}
+
+/*
+ *	Read the complete state info from the state pipe.
+ *	Returns 0 on success
+ */
+int receive_state(int fd)
+{
+	FILE	*f;
+	char	old_version[256];
+	CHILD	**pp;
+
+	f =3D fdopen(fd, "r");
+
+ 	if (get_cmd(f) !=3D C_VER)
+		return -1;
+	get_string(old_version, sizeof(old_version), f);
+	oops_error =3D 0;
+	for (pp =3D &family; (*pp =3D get_record(f)) !=3D NULL; pp =3D &((*pp)->n=
ext))
+		;
+	fclose(f);
+	return oops_error;
+}
+
+/*
+ *	Set the process title.
+ */
+#ifdef __GNUC__
+__attribute__ ((format (printf, 1, 2)))
+#endif
+static int setproctitle(char *fmt, ...)
+{
+	va_list ap;
+	int len;
+	char buf[256];
+
+	buf[0] =3D 0;
+
+	va_start(ap, fmt);
+	len =3D vsnprintf(buf, sizeof(buf), fmt, ap);
+	va_end(ap);
+
+	if (maxproclen > 2) {
+		memset(argv0, 0, maxproclen);
+		strncpy(argv0, buf, maxproclen - 2);
+	}
+
+	return len;
+}
+
+/*
+ *	Set console_dev to a working console.
+ */
+void console_init(void)
+{
+	int fd;
+	int tried_devcons =3D 0;
+	int tried_vtmaster =3D 0;
+	char *s;
+
+	if (user_console) {
+		console_dev =3D user_console;
+	} else if ((s =3D getenv("CONSOLE")) !=3D NULL)
+		console_dev =3D s;
+	else {
+		console_dev =3D CONSOLE;
+		tried_devcons++;
+	}
+
+	while ((fd =3D open(console_dev, O_RDONLY|O_NONBLOCK)) < 0) {
+		if (!tried_devcons) {
+			tried_devcons++;
+			console_dev =3D CONSOLE;
+			continue;
+		}
+		if (!tried_vtmaster) {
+			tried_vtmaster++;
+			console_dev =3D VT_MASTER;
+			continue;
+		}
+		break;
+	}
+	if (fd < 0)
+		console_dev =3D "/dev/null";
+	else
+		close(fd);
+}
+
+
+/*
+ *	Open the console with retries.
+ */
+int console_open(int mode)
+{
+	int f, fd =3D -1;
+	int m;
+
+	/*
+	 *	Open device in nonblocking mode.
+	 */
+	m =3D mode | O_NONBLOCK;
+
+	/*
+	 *	Retry the open five times.
+	 */
+	for(f =3D 0; f < 5; f++)
+		if ((fd =3D open(console_dev, m)) >=3D 0) break;
+
+	if (fd < 0) return fd;
+
+	/*
+	 *	Set original flags.
+	 */
+	if (m !=3D mode)
+  		fcntl(fd, F_SETFL, mode);
+	return fd;
+}
+
+/*
+ *	We got a signal (HUP PWR WINCH ALRM INT)
+ */
+void signal_handler(int sig)
+{
+	ADDSET(got_signals, sig);
+}
+
+/*
+ *	SIGCHLD: one of our children has died.
+ */
+void chld_handler()
+{
+	CHILD		*ch;
+	int		pid, st;
+	int		saved_errno =3D errno;
+
+	/*
+	 *	Find out which process(es) this was (were)
+	 */
+	while((pid =3D waitpid(-1, &st, WNOHANG)) !=3D 0) {
+		if (errno =3D=3D ECHILD) break;
+		for( ch =3D family; ch; ch =3D ch->next )
+			if ( ch->pid =3D=3D pid && (ch->flags & RUNNING) ) {
+				INITDBG(L_VB,
+					"chld_handler: marked %d as zombie",
+					ch->pid);
+				ADDSET(got_signals, SIGCHLD);
+				ch->exstat =3D st;
+				ch->flags |=3D ZOMBIE;
+				if (ch->new) {
+					ch->new->exstat =3D st;
+					ch->new->flags |=3D ZOMBIE;
+				}
+				break;
+			}
+		if (ch =3D=3D NULL)
+			INITDBG(L_VB, "chld_handler: unknown child %d exited.",
+				pid);
+	}
+	errno =3D saved_errno;
+}
+
+/*
+ *	Linux ignores all signals sent to init when the
+ *	SIG_DFL handler is installed. Therefore we must catch SIGTSTP
+ *	and SIGCONT, or else they won't work....
+ *
+ *	The SIGCONT handler
+ */
+void cont_handler()
+{
+	got_cont =3D 1;
+}
+
+/*
+ *	Fork and dump core in /.
+ */
+void coredump(void)
+{
+	static int		dumped =3D 0;
+	struct rlimit		rlim;
+	sigset_t		mask;
+
+	if (dumped) return;
+	dumped =3D 1;
+
+	if (fork() !=3D 0) return;
+
+	sigfillset(&mask);
+	sigprocmask(SIG_SETMASK, &mask, NULL);
+
+	rlim.rlim_cur =3D RLIM_INFINITY;
+	rlim.rlim_max =3D RLIM_INFINITY;
+	setrlimit(RLIMIT_CORE, &rlim);
+	chdir("/");
+
+	signal(SIGSEGV, SIG_DFL);
+	raise(SIGSEGV);
+	sigdelset(&mask, SIGSEGV);
+	sigprocmask(SIG_SETMASK, &mask, NULL);
+
+	do_sleep(5);
+	exit(0);
+}
+
+/*
+ *	OOPS: segmentation violation!
+ *	If we have the info, print where it occured.
+ *	Then sleep 30 seconds and try to continue.
+ */
+#if defined(STACK_DEBUG) && defined(__linux__)
+void segv_handler(int sig, struct sigcontext ctx)
+{
+	char	*p =3D "";
+	int	saved_errno =3D errno;
+
+	if ((void *)ctx.eip >=3D (void *)do_sleep &&
+	    (void *)ctx.eip < (void *)main)
+		p =3D " (code)";
+	initlog(L_VB, "PANIC: segmentation violation at %p%s! "
+		  "sleeping for 30 seconds.", (void *)ctx.eip, p);
+	coredump();
+	do_sleep(30);
+	errno =3D saved_errno;
+}
+#else
+void segv_handler()
+{
+	int	saved_errno =3D errno;
+
+	initlog(L_VB,
+		"PANIC: segmentation violation! sleeping for 30 seconds.");
+	coredump();
+	do_sleep(30);
+	errno =3D saved_errno;
+}
+#endif
+
+/*
+ *	The SIGSTOP & SIGTSTP handler
+ */
+void stop_handler()
+{
+	int	saved_errno =3D errno;
+
+	got_cont =3D 0;
+	while(!got_cont) pause();
+	got_cont =3D 0;
+	errno =3D saved_errno;
+}
+
+/*
+ *	Set terminal settings to reasonable defaults
+ */
+void console_stty(void)
+{
+	struct termios tty;
+	int fd;
+
+	if ((fd =3D console_open(O_RDWR|O_NOCTTY)) < 0) {
+		initlog(L_VB, "can't open %s", console_dev);
+		return;
+	}
+
+	(void) tcgetattr(fd, &tty);
+
+	tty.c_cflag &=3D CBAUD|CBAUDEX|CSIZE|CSTOPB|PARENB|PARODD;
+	tty.c_cflag |=3D HUPCL|CLOCAL|CREAD;
+
+	tty.c_cc[VINTR]  =3D 3;	/* ctrl('c') */
+	tty.c_cc[VQUIT]  =3D 28;	/* ctrl('\\') */
+	tty.c_cc[VERASE] =3D 127;
+	tty.c_cc[VKILL]  =3D 24;	/* ctrl('x') */
+	tty.c_cc[VEOF]   =3D 4;	/* ctrl('d') */
+	tty.c_cc[VTIME]  =3D 0;
+	tty.c_cc[VMIN]   =3D 1;
+	tty.c_cc[VSTART] =3D 17;	/* ctrl('q') */
+	tty.c_cc[VSTOP]  =3D 19;	/* ctrl('s') */
+	tty.c_cc[VSUSP]  =3D 26;	/* ctrl('z') */
+
+	/*
+	 *	Set pre and post processing
+	 */
+	tty.c_iflag =3D IGNPAR|ICRNL|IXON|IXANY;
+	tty.c_oflag =3D OPOST|ONLCR;
+	tty.c_lflag =3D ISIG|ICANON|ECHO|ECHOCTL|ECHOPRT|ECHOKE;
+
+	/*
+	 *	Now set the terminal line.
+	 *	We don't care about non-transmitted output data
+	 *	and non-read input data.
+	 */
+	(void) tcsetattr(fd, TCSANOW, &tty);
+	(void) tcflush(fd, TCIOFLUSH);
+	(void) close(fd);
+}
+
+/*
+ *	Print to the system console
+ */
+void print(char *s)
+{
+	int fd;
+
+	if ((fd =3D console_open(O_WRONLY|O_NOCTTY|O_NDELAY)) >=3D 0) {
+		write(fd, s, strlen(s));
+		close(fd);
+	}
+}
+
+/*
+ *	Log something to a logfile and the console.
+ */
+#ifdef __GNUC__
+__attribute__ ((format (printf, 2, 3)))
+#endif
+void initlog(int loglevel, char *s, ...)
+{
+	va_list va_alist;
+	char buf[256];
+	sigset_t nmask, omask;
+
+	va_start(va_alist, s);
+	vsnprintf(buf, sizeof(buf), s, va_alist);
+	va_end(va_alist);
+
+	if (loglevel & L_SY) {
+		/*
+		 *	Re-establish connection with syslogd every time.
+		 *	Block signals while talking to syslog.
+		 */
+		sigfillset(&nmask);
+		sigprocmask(SIG_BLOCK, &nmask, &omask);
+		openlog("init", 0, LOG_DAEMON);
+		syslog(LOG_INFO, "%s", buf);
+		closelog();
+		sigprocmask(SIG_SETMASK, &omask, NULL);
+	}
+
+	/*
+	 *	And log to the console.
+	 */
+	if (loglevel & L_CO) {
+		print("\rINIT: ");
+		print(buf);
+		print("\r\n");
+	}
+}
+
+
+/*
+ *	Build a new environment for execve().
+ */
+char **init_buildenv(int child)
+{
+	char		i_lvl[] =3D "RUNLEVEL=3Dx";
+	char		i_prev[] =3D "PREVLEVEL=3Dx";
+	char		i_cons[32];
+	char		**e;
+	int		n, i;
+
+	for (n =3D 0; environ[n]; n++)
+		;
+	n +=3D NR_EXTRA_ENV + 8;
+	e =3D calloc(n, sizeof(char *));
+
+	for (n =3D 0; environ[n]; n++)
+		e[n] =3D istrdup(environ[n]);
+
+	for (i =3D 0; i < NR_EXTRA_ENV; i++)
+		if (extra_env[i])
+			e[n++] =3D istrdup(extra_env[i]);
+
+	if (child) {
+		snprintf(i_cons, sizeof(i_cons), "CONSOLE=3D%s", console_dev);
+		i_lvl[9]   =3D thislevel;
+		i_prev[10] =3D prevlevel;
+		e[n++] =3D istrdup(i_lvl);
+		e[n++] =3D istrdup(i_prev);
+		e[n++] =3D istrdup(i_cons);
+		e[n++] =3D istrdup(E_VERSION);
+	}
+
+	e[n++] =3D NULL;
+
+	return e;
+}
+
+
+void init_freeenv(char **e)
+{
+	int		n;
+
+	for (n =3D 0; e[n]; n++)
+		free(e[n]);
+	free(e);
+}
+
+
+/*
+ *	Fork and execute.
+ *
+ *	This function is too long and indents too deep.
+ *
+ */
+int spawn(CHILD *ch, int *res)
+{
+  char *args[16];		/* Argv array */
+  char buf[136];		/* Line buffer */
+  int f, st, rc;		/* Scratch variables */
+  char *ptr;			/* Ditto */
+  time_t t;			/* System time */
+  int oldAlarm;			/* Previous alarm value */
+  char *proc =3D ch->process;	/* Command line */
+  pid_t pid, pgrp;		/* child, console process group. */
+  sigset_t nmask, omask;	/* For blocking SIGCHLD */
+  struct sigaction sa;
+
+  *res =3D -1;
+  buf[sizeof(buf) - 1] =3D 0;
+
+  /* Skip '+' if it's there */
+  if (proc[0] =3D=3D '+') proc++;
+
+  ch->flags |=3D XECUTED;
+
+  if (ch->action =3D=3D RESPAWN || ch->action =3D=3D ONDEMAND) {
+	/* Is the date stamp from less than 2 minutes ago? */
+	time(&t);
+	if (ch->tm + TESTTIME > t) {
+		ch->count++;
+	} else {
+		ch->count =3D 0;
+		ch->tm =3D t;
+	}
+
+	/* Do we try to respawn too fast? */
+	if (ch->count >=3D MAXSPAWN) {
+
+	  initlog(L_VB,
+		"Id \"%s\" respawning too fast: disabled for %d minutes",
+		ch->id, SLEEPTIME / 60);
+	  ch->flags &=3D ~RUNNING;
+	  ch->flags |=3D FAILING;
+
+	  /* Remember the time we stopped */
+	  ch->tm =3D t;
+
+	  /* Try again in 5 minutes */
+	  oldAlarm =3D alarm(0);
+	  if (oldAlarm > SLEEPTIME || oldAlarm <=3D 0) oldAlarm =3D SLEEPTIME;
+	  alarm(oldAlarm);
+	  return(-1);
+	}
+  }
+
+  /* See if there is an "initscript" (except in single user mode). */
+  if (access(INITSCRIPT, R_OK) =3D=3D 0 && runlevel !=3D 'S') {
+	/* Build command line using "initscript" */
+	args[1] =3D SHELL;
+	args[2] =3D INITSCRIPT;
+	args[3] =3D ch->id;
+	args[4] =3D ch->rlevel;
+	args[5] =3D "unknown";
+	for(f =3D 0; actions[f].name; f++) {
+		if (ch->action =3D=3D actions[f].act) {
+			args[5] =3D actions[f].name;
+			break;
+		}
+	}
+	args[6] =3D proc;
+	args[7] =3D NULL;
+  } else if (strpbrk(proc, "~`!$^&*()=3D|\\{}[];\"'<>?")) {
+  /* See if we need to fire off a shell for this command */
+  	/* Give command line to shell */
+  	args[1] =3D SHELL;
+  	args[2] =3D "-c";
+  	strcpy(buf, "exec ");
+  	strncat(buf, proc, sizeof(buf) - strlen(buf) - 1);
+  	args[3] =3D buf;
+  	args[4] =3D NULL;
+  } else {
+	/* Split up command line arguments */
+	buf[0] =3D 0;
+  	strncat(buf, proc, sizeof(buf) - 1);
+  	ptr =3D buf;
+  	for(f =3D 1; f < 15; f++) {
+  		/* Skip white space */
+  		while(*ptr =3D=3D ' ' || *ptr =3D=3D '\t') ptr++;
+  		args[f] =3D ptr;
+  	=09
+		/* May be trailing space.. */
+		if (*ptr =3D=3D 0) break;
+
+  		/* Skip this `word' */
+  		while(*ptr && *ptr !=3D ' ' && *ptr !=3D '\t' && *ptr !=3D '#')
+  			ptr++;
+  	=09
+  		/* If end-of-line, break */=09
+  		if (*ptr =3D=3D '#' || *ptr =3D=3D 0) {
+  			f++;
+  			*ptr =3D 0;
+  			break;
+  		}
+  		/* End word with \0 and continue */
+  		*ptr++ =3D 0;
+  	}
+  	args[f] =3D NULL;
+  }
+  args[0] =3D args[1];
+  while(1) {
+	/*
+	 *	Block sigchild while forking.
+	 */
+	sigemptyset(&nmask);
+	sigaddset(&nmask, SIGCHLD);
+	sigprocmask(SIG_BLOCK, &nmask, &omask);
+
+	if ((pid =3D fork()) =3D=3D 0) {
+
+		close(0);
+		close(1);
+		close(2);
+		if (pipe_fd >=3D 0) close(pipe_fd);
+
+  		sigprocmask(SIG_SETMASK, &omask, NULL);
+
+		/*
+		 *	In sysinit, boot, bootwait or single user mode:
+		 *	for any wait-type subprocess we _force_ the console
+		 *	to be its controlling tty.
+		 */
+  		if (strchr("*#sS", runlevel) && ch->flags & WAITING) {
+			/*
+			 *	We fork once extra. This is so that we can
+			 *	wait and change the process group and session
+			 *	of the console after exit of the leader.
+			 */
+			setsid();
+			if ((f =3D console_open(O_RDWR|O_NOCTTY)) >=3D 0) {
+				/* Take over controlling tty by force */
+				(void)ioctl(f, TIOCSCTTY, 1);
+  				dup(f);
+  				dup(f);
+			}
+			if ((pid =3D fork()) < 0) {
+  				initlog(L_VB, "cannot fork");
+				exit(1);
+			}
+			if (pid > 0) {
+				/*
+				 *	Ignore keyboard signals etc.
+				 *	Then wait for child to exit.
+				 */
+				SETSIG(sa, SIGINT, SIG_IGN, SA_RESTART);
+				SETSIG(sa, SIGTSTP, SIG_IGN, SA_RESTART);
+				SETSIG(sa, SIGQUIT, SIG_IGN, SA_RESTART);
+				SETSIG(sa, SIGCHLD, SIG_DFL, SA_RESTART);
+
+				while ((rc =3D waitpid(pid, &st, 0)) !=3D pid)
+					if (rc < 0 && errno =3D=3D ECHILD)
+						break;
+
+				/*
+				 *	Small optimization. See if stealing
+				 *	controlling tty back is needed.
+				 */
+				pgrp =3D tcgetpgrp(f);
+				if (pgrp !=3D getpid())
+					exit(0);
+
+				/*
+				 *	Steal controlling tty away. We do
+				 *	this with a temporary process.
+				 */
+				if ((pid =3D fork()) < 0) {
+  					initlog(L_VB, "cannot fork");
+					exit(1);
+				}
+				if (pid =3D=3D 0) {
+					setsid();
+					(void)ioctl(f, TIOCSCTTY, 1);
+					exit(0);
+				}
+				while((rc =3D waitpid(pid, &st, 0)) !=3D pid)
+					if (rc < 0 && errno =3D=3D ECHILD)
+						break;
+				exit(0);
+			}
+
+			/* Set ioctl settings to default ones */
+			console_stty();
+
+  		} else {
+			setsid();
+			if ((f =3D console_open(O_RDWR|O_NOCTTY)) < 0) {
+				initlog(L_VB, "open(%s): %s", console_dev,
+					strerror(errno));
+				f =3D open("/dev/null", O_RDWR);
+			}
+			dup(f);
+			dup(f);
+		}
+
+  		/* Reset all the signals, set up environment */
+  		for(f =3D 1; f < NSIG; f++) SETSIG(sa, f, SIG_DFL, SA_RESTART);
+		environ =3D init_buildenv(1);
+
+		/*
+		 *	Execute prog. In case of ENOEXEC try again
+		 *	as a shell script.
+		 */
+  		execvp(args[1], args + 1);
+		if (errno =3D=3D ENOEXEC) {
+  			args[1] =3D SHELL;
+  			args[2] =3D "-c";
+  			strcpy(buf, "exec ");
+  			strncat(buf, proc, sizeof(buf) - strlen(buf) - 1);
+  			args[3] =3D buf;
+  			args[4] =3D NULL;
+			execvp(args[1], args + 1);
+		}
+  		initlog(L_VB, "cannot execute \"%s\"", args[1]);
+  		exit(1);
+  	}
+	*res =3D pid;
+  	sigprocmask(SIG_SETMASK, &omask, NULL);
+
+	INITDBG(L_VB, "Started id %s (pid %d)", ch->id, pid);
+
+	if (pid =3D=3D -1) {
+		initlog(L_VB, "cannot fork, retry..");
+		do_sleep(5);
+		continue;
+	}
+	return(pid);
+  }
+}
+
+/*
+ *	Start a child running!
+ */
+void startup(CHILD *ch)
+{
+	/*
+	 *	See if it's disabled
+	 */
+	if (ch->flags & FAILING) return;
+
+	switch(ch->action) {
+
+		case SYSINIT:
+		case BOOTWAIT:
+		case WAIT:
+		case POWERWAIT:
+		case POWERFAILNOW:
+		case POWEROKWAIT:
+		case CTRLALTDEL:
+			if (!(ch->flags & XECUTED)) ch->flags |=3D WAITING;
+		case KBREQUEST:
+		case BOOT:
+		case POWERFAIL:
+		case ONCE:
+			if (ch->flags & XECUTED) break;
+		case ONDEMAND:
+		case RESPAWN:
+  			ch->flags |=3D RUNNING;
+  			if (spawn(ch, &(ch->pid)) < 0) break;
+			/*
+			 *	Do NOT log if process field starts with '+'
+			 *	FIXME: that's for compatibility with *very*
+			 *	old getties - probably it can be taken out.
+			 */
+  			if (ch->process[0] !=3D '+')
+				write_utmp_wtmp("", ch->id, ch->pid,
+					INIT_PROCESS, "");
+  			break;
+	}
+}
+
+
+/*
+ *	Read the inittab file.
+ */
+void read_inittab(void)
+{
+  FILE		*fp;			/* The INITTAB file */
+  CHILD		*ch, *old, *i;		/* Pointers to CHILD structure */
+  CHILD		*head =3D NULL;		/* Head of linked list */
+#ifdef INITLVL
+  struct stat	st;			/* To stat INITLVL */
+#endif
+  sigset_t	nmask, omask;		/* For blocking SIGCHLD. */
+  char		buf[256];		/* Line buffer */
+  char		err[64];		/* Error message. */
+  char		*id, *rlevel,
+		*action, *process;	/* Fields of a line */
+  char		*p;
+  int		lineNo =3D 0;		/* Line number in INITTAB file */
+  int		actionNo;		/* Decoded action field */
+  int		f;			/* Counter */
+  int		round;			/* round 0 for SIGTERM, 1 for SIGKILL */
+  int		foundOne =3D 0;		/* No killing no sleep */
+  int		talk;			/* Talk to the user */
+  int		done =3D 0;		/* Ready yet? */
+
+#if DEBUG
+  if (newFamily !=3D NULL) {
+	INITDBG(L_VB, "PANIC newFamily !=3D NULL");
+	exit(1);
+  }
+  INITDBG(L_VB, "Reading inittab");
+#endif
+
+  /*
+   *	Open INITTAB and real line by line.
+   */
+  if ((fp =3D fopen(INITTAB, "r")) =3D=3D NULL)
+	initlog(L_VB, "No inittab file found");
+
+  while(!done) {
+	/*
+	 *	Add single user shell entry at the end.
+	 */
+	if (fp =3D=3D NULL || fgets(buf, sizeof(buf), fp) =3D=3D NULL) {
+		done =3D 1;
+		/*
+		 *	See if we have a single user entry.
+		 */
+		for(old =3D newFamily; old; old =3D old->next)
+			if (strpbrk(old->rlevel, "S")) break;
+		if (old =3D=3D NULL)
+			snprintf(buf, sizeof(buf), "~~:S:wait:%s\n", SULOGIN);
+		else
+			continue;
+	}
+	lineNo++;
+	/*
+	 *	Skip comments and empty lines
+	 */
+	for(p =3D buf; *p =3D=3D ' ' || *p =3D=3D '\t'; p++)
+		;
+	if (*p =3D=3D '#' || *p =3D=3D '\n') continue;
+
+	/*
+	 *	Decode the fields
+	 */
+	id =3D      strsep(&p, ":");
+	rlevel =3D  strsep(&p, ":");
+	action =3D  strsep(&p, ":");
+	process =3D strsep(&p, "\n");
+
+	/*
+	 *	Check if syntax is OK. Be very verbose here, to
+	 *	avoid newbie postings on comp.os.linux.setup :)
+	 */
+	err[0] =3D 0;
+	if (!id || !*id) strcpy(err, "missing id field");
+	if (!rlevel)     strcpy(err, "missing runlevel field");
+	if (!process)    strcpy(err, "missing process field");
+	if (!action || !*action)
+			strcpy(err, "missing action field");
+	if (id && strlen(id) > sizeof(utproto.ut_id))
+		sprintf(err, "id field too long (max %d characters)",
+			(int)sizeof(utproto.ut_id));
+	if (rlevel && strlen(rlevel) > 11)
+		strcpy(err, "rlevel field too long (max 11 characters)");
+	if (process && strlen(process) > 127)
+		strcpy(err, "process field too long");
+	if (action && strlen(action) > 32)
+		strcpy(err, "action field too long");
+	if (err[0] !=3D 0) {
+		initlog(L_VB, "%s[%d]: %s", INITTAB, lineNo, err);
+		INITDBG(L_VB, "%s:%s:%s:%s", id, rlevel, action, process);
+		continue;
+	}
+ =20
+	/*
+	 *	Decode the "action" field
+	 */
+	actionNo =3D -1;
+	for(f =3D 0; actions[f].name; f++)
+		if (strcasecmp(action, actions[f].name) =3D=3D 0) {
+			actionNo =3D actions[f].act;
+			break;
+		}
+	if (actionNo =3D=3D -1) {
+		initlog(L_VB, "%s[%d]: %s: unknown action field",
+			INITTAB, lineNo, action);
+		continue;
+	}
+
+	/*
+	 *	See if the id field is unique
+	 */
+	for(old =3D newFamily; old; old =3D old->next) {
+		if(strcmp(old->id, id) =3D=3D 0 && strcmp(id, "~~")) {
+			initlog(L_VB, "%s[%d]: duplicate ID field \"%s\"",
+				INITTAB, lineNo, id);
+			break;
+		}
+	}
+	if (old) continue;
+
+	/*
+	 *	Allocate a CHILD structure
+	 */
+	ch =3D imalloc(sizeof(CHILD));
+
+	/*
+	 *	And fill it in.
+	 */
+	ch->action =3D actionNo;
+	strncpy(ch->id, id, sizeof(utproto.ut_id) + 1); /* Hack for different lib=
s. */
+	strncpy(ch->process, process, sizeof(ch->process) - 1);
+	if (rlevel[0]) {
+		for(f =3D 0; f < sizeof(rlevel) - 1 && rlevel[f]; f++) {
+			ch->rlevel[f] =3D rlevel[f];
+			if (ch->rlevel[f] =3D=3D 's') ch->rlevel[f] =3D 'S';
+		}
+		strncpy(ch->rlevel, rlevel, sizeof(ch->rlevel) - 1);
+	} else {
+		strcpy(ch->rlevel, "0123456789");
+		if (ISPOWER(ch->action))
+			strcpy(ch->rlevel, "S0123456789");
+	}
+	/*
+	 *	We have the fake runlevel '#' for SYSINIT  and
+	 *	'*' for BOOT and BOOTWAIT.
+	 */
+	if (ch->action =3D=3D SYSINIT) strcpy(ch->rlevel, "#");
+	if (ch->action =3D=3D BOOT || ch->action =3D=3D BOOTWAIT)
+		strcpy(ch->rlevel, "*");
+
+	/*
+	 *	Now add it to the linked list. Special for powerfail.
+	 */
+	if (ISPOWER(ch->action)) {
+
+		/*
+		 *	Disable by default
+		 */
+		ch->flags |=3D XECUTED;
+
+		/*
+		 *	Tricky: insert at the front of the list..
+		 */
+		old =3D NULL;
+		for(i =3D newFamily; i; i =3D i->next) {
+			if (!ISPOWER(i->action)) break;
+			old =3D i;
+		}
+		/*
+		 *	Now add after entry "old"
+		 */
+		if (old) {
+			ch->next =3D i;
+			old->next =3D ch;
+			if (i =3D=3D NULL) head =3D ch;
+		} else {
+			ch->next =3D newFamily;
+			newFamily =3D ch;
+			if (ch->next =3D=3D NULL) head =3D ch;
+		}
+	} else {
+		/*
+		 *	Just add at end of the list
+		 */
+		if (ch->action =3D=3D KBREQUEST) ch->flags |=3D XECUTED;
+		ch->next =3D NULL;
+		if (head)
+			head->next =3D ch;
+		else
+			newFamily =3D ch;
+		head =3D ch;
+	}
+
+	/*
+	 *	Walk through the old list comparing id fields
+	 */
+	for(old =3D family; old; old =3D old->next)
+		if (strcmp(old->id, ch->id) =3D=3D 0) {
+			old->new =3D ch;
+			break;
+		}
+  }
+  /*
+   *	We're done.
+   */
+  if (fp) fclose(fp);
+
+  /*
+   *	Loop through the list of children, and see if they need to
+   *	be killed.=20
+   */
+
+  INITDBG(L_VB, "Checking for children to kill");
+  for(round =3D 0; round < 2; round++) {
+    talk =3D 1;
+    for(ch =3D family; ch; ch =3D ch->next) {
+	ch->flags &=3D ~KILLME;
+
+	/*
+	 *	Is this line deleted?
+	 */
+	if (ch->new =3D=3D NULL) ch->flags |=3D KILLME;
+
+	/*
+	 *	If the entry has changed, kill it anyway. Note that
+	 *	we do not check ch->process, only the "action" field.
+	 *	This way, you can turn an entry "off" immediately, but
+	 *	changes in the command line will only become effective
+	 *	after the running version has exited.
+	 */
+	if (ch->new && ch->action !=3D ch->new->action) ch->flags |=3D KILLME;
+
+	/*
+	 *	Only BOOT processes may live in all levels
+	 */
+	if (ch->action !=3D BOOT &&
+	    strchr(ch->rlevel, runlevel) =3D=3D NULL) {
+		/*
+		 *	Ondemand procedures live always,
+		 *	except in single user
+		 */
+		if (runlevel =3D=3D 'S' || !(ch->flags & DEMAND))
+			ch->flags |=3D KILLME;
+	}
+
+	/*
+	 *	Now, if this process may live note so in the new list
+	 */
+	if ((ch->flags & KILLME) =3D=3D 0) {
+		ch->new->flags  =3D ch->flags;
+		ch->new->pid    =3D ch->pid;
+		ch->new->exstat =3D ch->exstat;
+		continue;
+	}
+
+
+	/*
+	 *	Is this process still around?
+	 */
+	if ((ch->flags & RUNNING) =3D=3D 0) {
+		ch->flags &=3D ~KILLME;
+		continue;
+	}
+	INITDBG(L_VB, "Killing \"%s\"", ch->process);
+	switch(round) {
+		case 0: /* Send TERM signal */
+			if (talk)
+				initlog(L_CO,
+					"Sending processes the TERM signal");
+			kill(-(ch->pid), SIGTERM);
+			foundOne =3D 1;
+			break;
+		case 1: /* Send KILL signal and collect status */
+			if (talk)
+				initlog(L_CO,
+					"Sending processes the KILL signal");
+			kill(-(ch->pid), SIGKILL);
+			break;
+	}
+	talk =3D 0;
+=09
+    }
+    /*
+     *	See if we have to wait 5 seconds
+     */
+    if (foundOne && round =3D=3D 0) {
+	/*
+	 *	Yup, but check every second if we still have children.
+	 */
+	for(f =3D 0; f < sltime; f++) {
+		for(ch =3D family; ch; ch =3D ch->next) {
+			if (!(ch->flags & KILLME)) continue;
+			if ((ch->flags & RUNNING) && !(ch->flags & ZOMBIE))
+				break;
+		}
+		if (ch =3D=3D NULL) {
+			/*
+			 *	No running children, skip SIGKILL
+			 */
+			round =3D 1;
+			foundOne =3D 0; /* Skip the sleep below. */
+			break;
+		}
+		do_sleep(1);
+	}
+    }
+  }
+
+  /*
+   *	Now give all processes the chance to die and collect exit statuses.
+   */
+  if (foundOne) do_sleep(1);
+  for(ch =3D family; ch; ch =3D ch->next)
+	if (ch->flags & KILLME) {
+		if (!(ch->flags & ZOMBIE))
+		    initlog(L_CO, "Pid %d [id %s] seems to hang", ch->pid,
+				ch->id);
+		else {
+		    INITDBG(L_VB, "Updating utmp for pid %d [id %s]",
+				ch->pid, ch->id);
+		    ch->flags &=3D ~RUNNING;
+		    if (ch->process[0] !=3D '+')
+		    	write_utmp_wtmp("", ch->id, ch->pid, DEAD_PROCESS, NULL);
+		}
+	}
+
+  /*
+   *	Both rounds done; clean up the list.
+   */
+  sigemptyset(&nmask);
+  sigaddset(&nmask, SIGCHLD);
+  sigprocmask(SIG_BLOCK, &nmask, &omask);
+  for(ch =3D family; ch; ch =3D old) {
+	old =3D ch->next;
+	free(ch);
+  }
+  family =3D newFamily;
+  for(ch =3D family; ch; ch =3D ch->next) ch->new =3D NULL;
+  newFamily =3D NULL;
+  sigprocmask(SIG_SETMASK, &omask, NULL);
+
+#ifdef INITLVL
+  /*
+   *	Dispose of INITLVL file.
+   */
+  if (lstat(INITLVL, &st) >=3D 0 && S_ISLNK(st.st_mode)) {
+	/*
+	 *	INITLVL is a symbolic link, so just truncate the file.
+	 */
+	close(open(INITLVL, O_WRONLY|O_TRUNC));
+  } else {
+	/*
+	 *	Delete INITLVL file.
+	 */
+  	unlink(INITLVL);
+  }
+#endif
+#ifdef INITLVL2
+  /*
+   *	Dispose of INITLVL2 file.
+   */
+  if (lstat(INITLVL2, &st) >=3D 0 && S_ISLNK(st.st_mode)) {
+	/*
+	 *	INITLVL2 is a symbolic link, so just truncate the file.
+	 */
+	close(open(INITLVL2, O_WRONLY|O_TRUNC));
+  } else {
+	/*
+	 *	Delete INITLVL2 file.
+	 */
+  	unlink(INITLVL2);
+  }
+#endif
+}
+
+/*
+ *	Walk through the family list and start up children.
+ *	The entries that do not belong here at all are removed
+ *	from the list.
+ */
+void start_if_needed(void)
+{
+	CHILD *ch;		/* Pointer to child */
+	int delete;		/* Delete this entry from list? */
+
+	INITDBG(L_VB, "Checking for children to start");
+
+	for(ch =3D family; ch; ch =3D ch->next) {
+
+#if DEBUG
+		if (ch->rlevel[0] =3D=3D 'C') {
+			INITDBG(L_VB, "%s: flags %d", ch->process, ch->flags);
+		}
+#endif
+
+		/* Are we waiting for this process? Then quit here. */
+		if (ch->flags & WAITING) break;
+
+		/* Already running? OK, don't touch it */
+		if (ch->flags & RUNNING) continue;
+
+		/* See if we have to start it up */
+		delete =3D 1;
+		if (strchr(ch->rlevel, runlevel) ||
+		    ((ch->flags & DEMAND) && !strchr("#*Ss", runlevel))) {
+			startup(ch);
+			delete =3D 0;
+		}
+
+		if (delete) {
+			/* FIXME: is this OK? */
+			ch->flags &=3D ~(RUNNING|WAITING);
+			if (!ISPOWER(ch->action) && ch->action !=3D KBREQUEST)
+				ch->flags &=3D ~XECUTED;
+			ch->pid =3D 0;
+		} else
+			/* Do we have to wait for this process? */
+			if (ch->flags & WAITING) break;
+	}
+	/* Done. */
+}
+
+/*
+ *	Ask the user on the console for a runlevel
+ */
+int ask_runlevel(void)
+{
+	const char	prompt[] =3D "\nEnter runlevel: ";
+	char		buf[8];
+	int		lvl =3D -1;
+	int		fd;
+
+	console_stty();
+	fd =3D console_open(O_RDWR|O_NOCTTY);
+
+	if (fd < 0) return('S');
+
+	while(!strchr("0123456789S", lvl)) {
+  		write(fd, prompt, sizeof(prompt) - 1);
+		buf[0] =3D 0;
+  		read(fd, buf, sizeof(buf));
+  		if (buf[0] !=3D 0 && (buf[1] =3D=3D '\r' || buf[1] =3D=3D '\n'))
+			lvl =3D buf[0];
+		if (islower(lvl)) lvl =3D toupper(lvl);
+	}
+	close(fd);
+	return lvl;
+}
+
+/*
+ *	Search the INITTAB file for the 'initdefault' field, with the default
+ *	runlevel. If this fails, ask the user to supply a runlevel.
+ */
+int get_init_default(void)
+{
+	CHILD *ch;
+	int lvl =3D -1;
+	char *p;
+
+	/*
+	 *	Look for initdefault.
+	 */
+	for(ch =3D family; ch; ch =3D ch->next)
+		if (ch->action =3D=3D INITDEFAULT) {
+			p =3D ch->rlevel;
+			while(*p) {
+				if (*p > lvl) lvl =3D *p;
+				p++;
+			}
+			break;
+		}
+	/*
+	 *	See if level is valid
+	 */
+	if (lvl > 0) {
+		if (islower(lvl)) lvl =3D toupper(lvl);
+		if (strchr("0123456789S", lvl) =3D=3D NULL) {
+			initlog(L_VB,
+				"Initdefault level '%c' is invalid", lvl);
+			lvl =3D 0;
+		}
+	}
+	/*
+	 *	Ask for runlevel on console if needed.
+	 */
+	if (lvl <=3D 0) lvl =3D ask_runlevel();
+
+	/*
+	 *	Log the fact that we have a runlevel now.
+	 */
+	return lvl;
+}
+
+
+/*
+ *	We got signaled.
+ *
+ *	Do actions for the new level. If we are compatible with
+ *	the "old" INITLVL and arg =3D=3D 0, try to read the new
+ *	runlevel from that file first.
+ */
+int read_level(int arg)
+{
+	CHILD		*ch;			/* Walk through list */
+	unsigned char	foo =3D 'X';		/* Contents of INITLVL */
+	int		ok =3D 1;
+#ifdef INITLVL
+	FILE		*fp;
+	struct stat	stt;
+	int		st;
+#endif
+
+	if (arg) foo =3D arg;
+
+#ifdef INITLVL
+	ok =3D 0;
+
+	if (arg =3D=3D 0) {
+		fp =3D NULL;
+		if (stat(INITLVL, &stt) !=3D 0 || stt.st_size !=3D 0L)
+			fp =3D fopen(INITLVL, "r");
+#ifdef INITLVL2
+		if (fp =3D=3D NULL &&
+		    (stat(INITLVL2, &stt) !=3D 0 || stt.st_size !=3D 0L))
+			fp =3D fopen(INITLVL2, "r");
+#endif
+		if (fp =3D=3D NULL) {
+			/* INITLVL file empty or not there - act as 'init q' */
+			initlog(L_SY, "Re-reading inittab");
+  			return(runlevel);
+		}
+		ok =3D fscanf(fp, "%c %d", &foo, &st);
+		fclose(fp);
+	} else {
+		/* We go to the new runlevel passed as an argument. */
+		foo =3D arg;
+		ok =3D 1;
+	}
+	if (ok =3D=3D 2) sltime =3D st;
+
+#endif /* INITLVL */
+
+	if (islower(foo)) foo =3D toupper(foo);
+	if (ok < 1 || ok > 2 || strchr("QS0123456789ABCU", foo) =3D=3D NULL) {
+ 		initlog(L_VB, "bad runlevel: %c", foo);
+  		return runlevel;
+	}
+
+	/* Log this action */
+	switch(foo) {
+		case 'S':
+  			initlog(L_VB, "Going single user");
+			break;
+		case 'Q':
+			initlog(L_SY, "Re-reading inittab");
+			break;
+		case 'A':
+		case 'B':
+		case 'C':
+			initlog(L_SY,
+				"Activating demand-procedures for '%c'", foo);
+			break;
+		case 'U':
+			initlog(L_SY, "Trying to re-exec init");
+			return 'U';
+		default:
+		  	initlog(L_VB, "Switching to runlevel: %c", foo);
+	}
+
+	if (foo =3D=3D 'Q') return runlevel;
+
+	/* Check if this is a runlevel a, b or c */
+	if (strchr("ABC", foo)) {
+		if (runlevel =3D=3D 'S') return(runlevel);
+
+		/* Read inittab again first! */
+		read_inittab();
+
+  		/* Mark those special tasks */
+		for(ch =3D family; ch; ch =3D ch->next)
+			if (strchr(ch->rlevel, foo) !=3D NULL ||
+			    strchr(ch->rlevel, tolower(foo)) !=3D NULL) {
+				ch->flags |=3D DEMAND;
+				ch->flags &=3D ~XECUTED;
+				INITDBG(L_VB,
+					"Marking (%s) as ondemand, flags %d",
+					ch->id, ch->flags);
+			}
+  		return runlevel;
+	}
+
+	/* Store both the old and the new runlevel. */
+	write_utmp_wtmp("runlevel", "~~", foo + 256*runlevel, RUN_LVL, "~");
+	thislevel =3D foo;
+	prevlevel =3D runlevel;
+	return foo;
+}
+
+
+/*
+ *	This procedure is called after every signal (SIGHUP, SIGALRM..)
+ *
+ *	Only clear the 'failing' flag if the process is sleeping
+ *	longer than 5 minutes, or inittab was read again due
+ *	to user interaction.
+ */
+void fail_check(void)
+{
+	CHILD	*ch;			/* Pointer to child structure */
+	time_t	t;			/* System time */
+	time_t	next_alarm =3D 0;		/* When to set next alarm */
+
+	time(&t);
+
+	for(ch =3D family; ch; ch =3D ch->next) {
+
+		if (ch->flags & FAILING) {
+			/* Can we free this sucker? */
+			if (ch->tm + SLEEPTIME < t) {
+				ch->flags &=3D ~FAILING;
+				ch->count =3D 0;
+				ch->tm =3D 0;
+			} else {
+				/* No, we'll look again later */
+				if (next_alarm =3D=3D 0 ||
+				    ch->tm + SLEEPTIME > next_alarm)
+					next_alarm =3D ch->tm + SLEEPTIME;
+			}
+		}
+	}
+	if (next_alarm) {
+		next_alarm -=3D t;
+		if (next_alarm < 1) next_alarm =3D 1;
+		alarm(next_alarm);
+	}
+}
+
+/* Set all 'Fail' timers to 0 */
+void fail_cancel(void)
+{
+	CHILD *ch;
+
+	for(ch =3D family; ch; ch =3D ch->next) {
+		ch->count =3D 0;
+		ch->tm =3D 0;
+		ch->flags &=3D ~FAILING;
+	}
+}
+
+/*
+ *	Start up powerfail entries.
+ */
+void do_power_fail(int pwrstat)
+{
+	CHILD *ch;
+
+	/*
+	 *	Tell powerwait & powerfail entries to start up
+	 */
+	for (ch =3D family; ch; ch =3D ch->next) {
+		if (pwrstat =3D=3D 'O') {
+			/*
+		 	 *	The power is OK again.
+		 	 */
+			if (ch->action =3D=3D POWEROKWAIT)
+				ch->flags &=3D ~XECUTED;
+		} else if (pwrstat =3D=3D 'L') {
+			/*
+			 *	Low battery, shut down now.
+			 */
+			if (ch->action =3D=3D POWERFAILNOW)
+				ch->flags &=3D ~XECUTED;
+		} else {
+			/*
+			 *	Power is failing, shutdown imminent
+			 */
+			if (ch->action =3D=3D POWERFAIL || ch->action =3D=3D POWERWAIT)
+				ch->flags &=3D ~XECUTED;
+		}
+	}
+}
+
+/*
+ *	Check for state-pipe presence
+ */
+int check_pipe(int fd)
+{
+	struct timeval	t;
+	fd_set		s;
+	char		signature[8];
+
+	FD_ZERO(&s);
+	FD_SET(fd, &s);
+	t.tv_sec =3D t.tv_usec =3D 0;
+
+	if (select(fd+1, &s, NULL, NULL, &t) !=3D 1)
+		return 0;
+	if (read(fd, signature, 8) !=3D 8)
+		 return 0;
+	return strncmp(Signature, signature, 8) =3D=3D 0;
+}
+
+/*
+ *	 Make a state-pipe.
+ */
+int make_pipe(int fd)
+{
+	int fds[2];
+
+	pipe(fds);
+	dup2(fds[0], fd);
+	close(fds[0]);
+	fcntl(fds[1], F_SETFD, 1);
+	fcntl(fd, F_SETFD, 0);
+	write(fds[1], Signature, 8);
+
+	return fds[1];
+}
+
+/*
+ *	Attempt to re-exec.
+ */
+void re_exec(void)
+{
+	CHILD		*ch;
+	sigset_t	mask, oldset;
+	pid_t		pid;
+	char		**env;
+	int		fd;
+
+	if (strchr("S12345",runlevel) =3D=3D NULL)
+		return;
+
+	/*
+	 *	Reset the alarm, and block all signals.
+	 */
+	alarm(0);
+	sigfillset(&mask);
+	sigprocmask(SIG_BLOCK, &mask, &oldset);
+
+	/*
+	 *	construct a pipe fd --> STATE_PIPE and write a signature
+	 */
+	fd =3D make_pipe(STATE_PIPE);
+
+	/*=20
+	 * It's a backup day today, so I'm pissed off.  Being a BOFH, however,=20
+	 * does have it's advantages...
+	 */
+	fail_cancel();
+	close(pipe_fd);
+	pipe_fd =3D -1;
+	DELSET(got_signals, SIGCHLD);
+	DELSET(got_signals, SIGHUP);
+	DELSET(got_signals, SIGUSR1);
+
+	/*
+	 *	That should be cleaned.
+	 */
+	for(ch =3D family; ch; ch =3D ch->next)
+	    if (ch->flags & ZOMBIE) {
+		INITDBG(L_VB, "Child died, PID=3D %d", ch->pid);
+		ch->flags &=3D ~(RUNNING|ZOMBIE|WAITING);
+		if (ch->process[0] !=3D '+')
+			write_utmp_wtmp("", ch->id, ch->pid, DEAD_PROCESS, NULL);
+	    }
+
+	if ((pid =3D fork()) =3D=3D 0) {
+		/*
+		 *	Child sends state information to the parent.
+		 */
+		send_state(fd);
+		exit(0);
+	}
+
+	/*
+	 *	The existing init process execs a new init binary.
+	 */
+	env =3D init_buildenv(0);
+	execl(myname, myname, "--init", NULL, env);
+
+	/*
+	 *	We shouldn't be here, something failed.=20
+	 *	Bitch, close the state pipe, unblock signals and return.
+	 */
+	close(fd);
+	close(STATE_PIPE);
+	sigprocmask(SIG_SETMASK, &oldset, NULL);
+	init_freeenv(env);
+	initlog(L_CO, "Attempt to re-exec failed");
+}
+
+
+/*
+ *	We got a change runlevel request through the
+ *	init.fifo. Process it.
+ */
+void fifo_new_level(int level)
+{
+#if CHANGE_WAIT
+	CHILD	*ch;
+#endif
+	int	oldlevel;
+
+	if (level =3D=3D runlevel) return;
+
+#if CHANGE_WAIT
+	/* Are we waiting for a child? */
+	for(ch =3D family; ch; ch =3D ch->next)
+		if (ch->flags & WAITING) break;
+	if (ch =3D=3D NULL)
+#endif
+	{
+		/* We need to go into a new runlevel */
+		oldlevel =3D runlevel;
+		runlevel =3D read_level(level);
+		if (runlevel =3D=3D 'U') {
+			runlevel =3D oldlevel;
+			re_exec();
+		} else {
+			if (oldlevel !=3D 'S' && runlevel =3D=3D 'S') console_stty();
+			if (runlevel =3D=3D '6' || runlevel =3D=3D '0' ||
+			    runlevel =3D=3D '1') console_stty();
+			read_inittab();
+			fail_cancel();
+			setproctitle("init [%c]", runlevel);
+		}
+	}
+}
+
+
+/*
+ *	Set/unset environment variables. The variables are
+ *	encoded as KEY=3DVAL\0KEY=3DVAL\0\0. With "=3DVAL" it means
+ *	setenv, without it means unsetenv.
+ */
+void initcmd_setenv(char *data, int size)
+{
+	char		*env, *p, *e, *eq;
+	int		i, sz;
+
+	e =3D data + size;
+
+	while (*data && data < e) {
+		eq =3D NULL;
+		for (p =3D data; *p && p < e; p++)
+			if (*p =3D=3D '=3D') eq =3D p;
+		if (*p) break;
+		env =3D data;
+		data =3D ++p;
+
+		sz =3D eq ? (eq - env) : (p - env);
+
+		/*initlog(L_SY, "init_setenv: %s, %s, %d", env, eq, sz);*/
+
+		/*
+		 *	We only allow INIT_* to be set.
+		 */
+		if (strncmp(env, "INIT_", 5) !=3D 0)
+			continue;
+
+		/* Free existing vars. */
+		for (i =3D 0; i < NR_EXTRA_ENV; i++) {
+			if (extra_env[i] =3D=3D NULL) continue;
+			if (!strncmp(extra_env[i], env, sz) &&
+			    extra_env[i][sz] =3D=3D '=3D') {
+				free(extra_env[i]);
+				extra_env[i] =3D NULL;
+			}
+		}
+
+		/* Set new vars if needed. */
+		if (eq =3D=3D NULL) continue;
+		for (i =3D 0; i < NR_EXTRA_ENV; i++) {
+			if (extra_env[i] =3D=3D NULL) {
+				extra_env[i] =3D istrdup(env);
+				break;
+			}
+		}
+	}
+}
+
+
+/*
+ *	Read from the init FIFO. Processes like telnetd and rlogind can
+ *	ask us to create login processes on their behalf.
+ *
+ *	FIXME:	this needs to be finished. NOT that it is buggy, but we need
+ *		to add the telnetd/rlogind stuff so people can start using it.
+ *		Maybe move to using an AF_UNIX socket so we can use
+ *		the 2.2 kernel credential stuff to see who we're talking to.
+ *=09
+ */
+void check_init_fifo(void)
+{
+  struct init_request	request;
+  struct timeval	tv;
+  struct stat		st, st2;
+  fd_set		fds;
+  int			n;
+  int			quit =3D 0;
+
+  /*
+   *	First, try to create /dev/initctl if not present.
+   */
+  if (stat(INIT_FIFO, &st2) < 0 && errno =3D=3D ENOENT)
+	(void)mkfifo(INIT_FIFO, 0600);
+
+  /*
+   *	If /dev/initctl is open, stat the file to see if it
+   *	is still the _same_ inode.
+   */
+  if (pipe_fd >=3D 0) {
+	fstat(pipe_fd, &st);
+	if (stat(INIT_FIFO, &st2) < 0 ||
+	    st.st_dev !=3D st2.st_dev ||
+	    st.st_ino !=3D st2.st_ino) {
+		close(pipe_fd);
+		pipe_fd =3D -1;
+	}
+  }
+
+  /*
+   *	Now finally try to open /dev/initctl
+   */
+  if (pipe_fd < 0) {
+	if ((pipe_fd =3D open(INIT_FIFO, O_RDWR|O_NONBLOCK)) >=3D 0) {
+		fstat(pipe_fd, &st);
+		if (!S_ISFIFO(st.st_mode)) {
+			initlog(L_VB, "%s is not a fifo", INIT_FIFO);
+			close(pipe_fd);
+			pipe_fd =3D -1;
+		}
+	}
+	if (pipe_fd >=3D 0) {
+		/*
+		 *	Don't use fd's 0, 1 or 2.
+		 */
+		(void) dup2(pipe_fd, PIPE_FD);
+		close(pipe_fd);
+		pipe_fd =3D PIPE_FD;
+
+		/*
+		 *	Return to caller - we'll be back later.
+		 */
+	}
+  }
+
+  /* Wait for data to appear, _if_ the pipe was opened. */
+  if (pipe_fd >=3D 0) while(!quit) {
+
+	/* Do select, return on EINTR. */
+	FD_ZERO(&fds);
+	FD_SET(pipe_fd, &fds);
+	tv.tv_sec =3D 5;
+	tv.tv_usec =3D 0;
+	n =3D select(pipe_fd + 1, &fds, NULL, NULL, &tv);
+	if (n <=3D 0) {
+		if (n =3D=3D 0 || errno =3D=3D EINTR) return;
+		continue;
+	}
+
+	/* Read the data, return on EINTR. */
+	n =3D read(pipe_fd, &request, sizeof(request));
+	if (n =3D=3D 0) {
+		/*
+		 *	End of file. This can't happen under Linux (because
+		 *	the pipe is opened O_RDWR - see select() in the
+		 *	kernel) but you never know...
+		 */
+		close(pipe_fd);
+		pipe_fd =3D -1;
+		return;
+	}
+	if (n <=3D 0) {
+		if (errno =3D=3D EINTR) return;
+		initlog(L_VB, "error reading initrequest");
+		continue;
+	}
+
+	/*
+	 *	This is a convenient point to also try to
+	 *	find the console device or check if it changed.
+	 */
+	console_init();
+
+	/*
+	 *	Process request.
+	 */
+	if (request.magic !=3D INIT_MAGIC || n !=3D sizeof(request)) {
+		initlog(L_VB, "got bogus initrequest");
+		continue;
+	}
+	switch(request.cmd) {
+		case INIT_CMD_RUNLVL:
+			sltime =3D request.sleeptime;
+			fifo_new_level(request.runlevel);
+			quit =3D 1;
+			break;
+		case INIT_CMD_POWERFAIL:
+			sltime =3D request.sleeptime;
+			do_power_fail('F');
+			quit =3D 1;
+			break;
+		case INIT_CMD_POWERFAILNOW:
+			sltime =3D request.sleeptime;
+			do_power_fail('L');
+			quit =3D 1;
+			break;
+		case INIT_CMD_POWEROK:
+			sltime =3D request.sleeptime;
+			do_power_fail('O');
+			quit =3D 1;
+			break;
+		case INIT_CMD_SETENV:
+			initcmd_setenv(request.i.data, sizeof(request.i.data));
+			break;
+		case INIT_CMD_CHANGECONS:
+			if (user_console) {
+				free(user_console);
+				user_console =3D NULL;
+			}
+			if (!request.i.bsd.reserved[0])
+				user_console =3D NULL;
+			else
+				user_console =3D strdup(request.i.bsd.reserved);
+			console_init();
+			quit =3D 1;
+			break;
+		default:
+			initlog(L_VB, "got unimplemented initrequest.");
+			break;
+	}
+  }
+
+  /*
+   *	We come here if the pipe couldn't be opened.
+   */
+  if (pipe_fd < 0) pause();
+
+}
+
+
+/*
+ *	This function is used in the transition
+ *	sysinit (-> single user) boot -> multi-user.
+ */
+void boot_transitions()
+{
+  CHILD		*ch;
+  static int	newlevel =3D 0;
+  static int	warn =3D 1;
+  int		loglevel;
+  int		oldlevel;
+
+  /* Check if there is something to wait for! */
+  for( ch =3D family; ch; ch =3D ch->next )
+	if ((ch->flags & RUNNING) && ch->action !=3D BOOT) break;
+    =20
+  if (ch =3D=3D NULL) {
+	/* No processes left in this level, proceed to next level. */
+	loglevel =3D -1;
+	oldlevel =3D 'N';
+	switch(runlevel) {
+		case '#': /* SYSINIT -> BOOT */
+			INITDBG(L_VB, "SYSINIT -> BOOT");
+
+			/* Write a boot record. */
+			wrote_utmp_reboot =3D 0;
+			wrote_wtmp_reboot =3D 0;
+			write_utmp_wtmp("reboot", "~~", 0, BOOT_TIME, "~");
+
+  			/* Get our run level */
+  			newlevel =3D dfl_level ? dfl_level : get_init_default();
+			if (newlevel =3D=3D 'S') {
+				runlevel =3D newlevel;
+				/* Not really 'S' but show anyway. */
+				setproctitle("init [S]");
+			} else
+				runlevel =3D '*';
+			break;
+		case '*': /* BOOT -> NORMAL */
+			INITDBG(L_VB, "BOOT -> NORMAL");
+			if (runlevel !=3D newlevel)
+				loglevel =3D newlevel;
+			runlevel =3D newlevel;
+			did_boot =3D 1;
+			warn =3D 1;
+			break;
+		case 'S': /* Ended SU mode */
+		case 's':
+			INITDBG(L_VB, "END SU MODE");
+			newlevel =3D get_init_default();
+			if (!did_boot && newlevel !=3D 'S')
+				runlevel =3D '*';
+			else {
+				if (runlevel !=3D newlevel)
+					loglevel =3D newlevel;
+				runlevel =3D newlevel;
+				oldlevel =3D 'S';
+			}
+			warn =3D 1;
+			for(ch =3D family; ch; ch =3D ch->next)
+			    if (strcmp(ch->rlevel, "S") =3D=3D 0)
+				ch->flags &=3D ~(FAILING|WAITING|XECUTED);
+			break;
+		default:
+			if (warn)
+			  initlog(L_VB,
+				"no more processes left in this runlevel");
+			warn =3D 0;
+			loglevel =3D -1;
+			if (got_signals =3D=3D 0)
+				check_init_fifo();
+			break;
+	}
+	if (loglevel > 0) {
+		initlog(L_VB, "Entering runlevel: %c", runlevel);
+		write_utmp_wtmp("runlevel", "~~", runlevel + 256 * oldlevel, RUN_LVL, "~=
");
+		thislevel =3D runlevel;
+		prevlevel =3D oldlevel;
+		setproctitle("init [%c]", runlevel);
+	}
+  }
+}
+
+/*
+ *	Init got hit by a signal. See which signal it is,
+ *	and act accordingly.
+ */
+void process_signals()
+{
+  CHILD		*ch;
+  int		pwrstat;
+  int		oldlevel;
+  int		fd;
+  char		c;
+
+  if (ISMEMBER(got_signals, SIGPWR)) {
+	INITDBG(L_VB, "got SIGPWR");
+	/* See _what_ kind of SIGPWR this is. */
+	pwrstat =3D 0;
+	if ((fd =3D open(PWRSTAT, O_RDONLY)) >=3D 0) {
+		c =3D 0;
+		read(fd, &c, 1);
+		pwrstat =3D c;
+		close(fd);
+		unlink(PWRSTAT);
+	}
+	do_power_fail(pwrstat);
+	DELSET(got_signals, SIGPWR);
+  }
+
+  if (ISMEMBER(got_signals, SIGINT)) {
+	INITDBG(L_VB, "got SIGINT");
+	/* Tell ctrlaltdel entry to start up */
+	for(ch =3D family; ch; ch =3D ch->next)
+		if (ch->action =3D=3D CTRLALTDEL)
+			ch->flags &=3D ~XECUTED;
+	DELSET(got_signals, SIGINT);
+  }
+
+  if (ISMEMBER(got_signals, SIGWINCH)) {
+	INITDBG(L_VB, "got SIGWINCH");
+	/* Tell kbrequest entry to start up */
+	for(ch =3D family; ch; ch =3D ch->next)
+		if (ch->action =3D=3D KBREQUEST)
+			ch->flags &=3D ~XECUTED;
+	DELSET(got_signals, SIGWINCH);
+  }
+
+  if (ISMEMBER(got_signals, SIGALRM)) {
+	INITDBG(L_VB, "got SIGALRM");
+	/* The timer went off: check it out */
+	DELSET(got_signals, SIGALRM);
+  }
+
+  if (ISMEMBER(got_signals, SIGCHLD)) {
+	INITDBG(L_VB, "got SIGCHLD");
+	/* First set flag to 0 */
+	DELSET(got_signals, SIGCHLD);
+
+	/* See which child this was */
+	for(ch =3D family; ch; ch =3D ch->next)
+	    if (ch->flags & ZOMBIE) {
+		INITDBG(L_VB, "Child died, PID=3D %d", ch->pid);
+		ch->flags &=3D ~(RUNNING|ZOMBIE|WAITING);
+		if (ch->process[0] !=3D '+')
+			write_utmp_wtmp("", ch->id, ch->pid, DEAD_PROCESS, NULL);
+	    }
+
+  }
+
+  if (ISMEMBER(got_signals, SIGHUP)) {
+	INITDBG(L_VB, "got SIGHUP");
+#if CHANGE_WAIT
+	/* Are we waiting for a child? */
+	for(ch =3D family; ch; ch =3D ch->next)
+		if (ch->flags & WAITING) break;
+	if (ch =3D=3D NULL)
+#endif
+	{
+		/* We need to go into a new runlevel */
+		oldlevel =3D runlevel;
+#ifdef INITLVL
+		runlevel =3D read_level(0);
+#endif
+		if (runlevel =3D=3D 'U') {
+			runlevel =3D oldlevel;
+			re_exec();
+		} else {
+			if (oldlevel !=3D 'S' && runlevel =3D=3D 'S') console_stty();
+			if (runlevel =3D=3D '6' || runlevel =3D=3D '0' ||
+			    runlevel =3D=3D '1') console_stty();
+			read_inittab();
+			fail_cancel();
+			setproctitle("init [%c]", runlevel);
+			DELSET(got_signals, SIGHUP);
+		}
+	}
+  }
+  if (ISMEMBER(got_signals, SIGUSR1)) {
+	/*
+	 *	SIGUSR1 means close and reopen /dev/initctl
+	 */
+	INITDBG(L_VB, "got SIGUSR1");
+	close(pipe_fd);
+	pipe_fd =3D -1;
+	DELSET(got_signals, SIGUSR1);
+  }
+}
+
+/*
+ *	The main loop
+ */=20
+int init_main()
+{
+  CHILD			*ch;
+  struct sigaction	sa;
+  sigset_t		sgt;
+  pid_t			rc;
+  int			f, st;
+
+  if (!reload) {
+ =20
+#if INITDEBUG
+	/*
+	 * Fork so we can debug the init process.
+	 */
+	if ((f =3D fork()) > 0) {
+		static const char killmsg[] =3D "PRNT: init killed.\r\n";
+		pid_t rc;
+
+		while((rc =3D wait(&st)) !=3D f)
+			if (rc < 0 && errno =3D=3D ECHILD)
+				break;
+		write(1, killmsg, sizeof(killmsg) - 1);
+		while(1) pause();
+	}
+#endif
+
+#ifdef __linux__
+	/*
+	 *	Tell the kernel to send us SIGINT when CTRL-ALT-DEL
+	 *	is pressed, and that we want to handle keyboard signals.
+	 */
+	init_reboot(BMAGIC_SOFT);
+	if ((f =3D open(VT_MASTER, O_RDWR | O_NOCTTY)) >=3D 0) {
+		(void) ioctl(f, KDSIGACCEPT, SIGWINCH);
+		close(f);
+	} else
+		(void) ioctl(0, KDSIGACCEPT, SIGWINCH);
+#endif
+
+	/*
+	 *	Ignore all signals.
+	 */
+	for(f =3D 1; f <=3D NSIG; f++)
+		SETSIG(sa, f, SIG_IGN, SA_RESTART);
+  }
+
+  SETSIG(sa, SIGALRM,  signal_handler, 0);
+  SETSIG(sa, SIGHUP,   signal_handler, 0);
+  SETSIG(sa, SIGINT,   signal_handler, 0);
+  SETSIG(sa, SIGCHLD,  chld_handler, SA_RESTART);
+  SETSIG(sa, SIGPWR,   signal_handler, 0);
+  SETSIG(sa, SIGWINCH, signal_handler, 0);
+  SETSIG(sa, SIGUSR1,  signal_handler, 0);
+  SETSIG(sa, SIGSTOP,  stop_handler, SA_RESTART);
+  SETSIG(sa, SIGTSTP,  stop_handler, SA_RESTART);
+  SETSIG(sa, SIGCONT,  cont_handler, SA_RESTART);
+  SETSIG(sa, SIGSEGV,  (void (*)(int))segv_handler, SA_RESTART);
+
+  console_init();
+
+  if (!reload) {
+
+  	/* Close whatever files are open, and reset the console. */
+	close(0);
+	close(1);
+	close(2);
+  	console_stty();
+  	setsid();
+
+  	/*
+	 *	Set default PATH variable.
+	 */
+  	putenv(PATH_DFL);
+
+  	/*
+	 *	Initialize /var/run/utmp (only works if /var is on
+	 *	root and mounted rw)
+	 */
+  	(void) close(open(UTMP_FILE, O_WRONLY|O_CREAT|O_TRUNC, 0644));
+
+  	/*
+	 *	Say hello to the world
+	 */
+  	initlog(L_CO, bootmsg, "booting");
+
+  	/*
+	 *	See if we have to start an emergency shell.
+	 */
+	if (emerg_shell) {
+		SETSIG(sa, SIGCHLD, SIG_DFL, SA_RESTART);
+		if (spawn(&ch_emerg, &f) > 0) {
+			while((rc =3D wait(&st)) !=3D f)
+				if (rc < 0 && errno =3D=3D ECHILD)
+					break;
+		}
+  		SETSIG(sa, SIGCHLD,  chld_handler, SA_RESTART);
+  	}
+
+  	/*
+	 *	Start normal boot procedure.
+	 */
+  	runlevel =3D '#';
+  	read_inittab();
+ =20
+  } else {
+	/*
+	 *	Restart: unblock signals and let the show go on
+	 */
+	initlog(L_CO, bootmsg, "reloading");
+	sigfillset(&sgt);
+	sigprocmask(SIG_UNBLOCK, &sgt, NULL);
+  }
+  start_if_needed();
+
+  while(1) {
+
+     /* See if we need to make the boot transitions. */
+     boot_transitions();
+     INITDBG(L_VB, "init_main: waiting..");
+
+     /* Check if there are processes to be waited on. */
+     for(ch =3D family; ch; ch =3D ch->next)
+	if ((ch->flags & RUNNING) && ch->action !=3D BOOT) break;
+
+#if CHANGE_WAIT
+     /* Wait until we get hit by some signal. */
+     while (ch !=3D NULL && got_signals =3D=3D 0) {
+	if (ISMEMBER(got_signals, SIGHUP)) {
+		/* See if there are processes to be waited on. */
+		for(ch =3D family; ch; ch =3D ch->next)
+			if (ch->flags & WAITING) break;
+	}
+	if (ch !=3D NULL) check_init_fifo();
+     }
+#else /* CHANGE_WAIT */
+     if (ch !=3D NULL && got_signals =3D=3D 0) check_init_fifo();
+#endif /* CHANGE_WAIT */
+
+     /* Check the 'failing' flags */
+     fail_check();
+
+     /* Process any signals. */
+     process_signals();
+
+     /* See what we need to start up (again) */
+     start_if_needed();
+  }
+  /*NOTREACHED*/
+}
+
+/*
+ * Tell the user about the syntax we expect.
+ */
+void usage(char *s)
+{
+	fprintf(stderr, "Usage: %s 0123456SsQqAaBbCcUu\n", s);
+	exit(1);
+}
+
+int telinit(char *progname, int argc, char **argv)
+{
+#ifdef TELINIT_USES_INITLVL
+	FILE			*fp;
+#endif
+	struct init_request	request;
+	struct sigaction	sa;
+	int			f, fd, l;
+	char			*env =3D NULL;
+
+	memset(&request, 0, sizeof(request));
+	request.magic     =3D INIT_MAGIC;
+
+	while ((f =3D getopt(argc, argv, "t:e:")) !=3D EOF) switch(f) {
+		case 't':
+			sltime =3D atoi(optarg);
+			break;
+		case 'e':
+			if (env =3D=3D NULL)
+				env =3D request.i.data;
+			l =3D strlen(optarg);
+			if (env + l + 2 > request.i.data + sizeof(request.i.data)) {
+				fprintf(stderr, "%s: -e option data "
+					"too large\n", progname);
+				exit(1);
+			}
+			memcpy(env, optarg, l);
+			env +=3D l;
+			*env++ =3D 0;
+			break;
+		default:
+			usage(progname);
+			break;
+	}
+
+	if (env) *env++ =3D 0;
+
+	if (env) {
+		if (argc !=3D optind)
+			usage(progname);
+		request.cmd =3D INIT_CMD_SETENV;
+	} else {
+		if (argc - optind !=3D 1 || strlen(argv[optind]) !=3D 1)
+			usage(progname);
+		if (!strchr("0123456789SsQqAaBbCcUu", argv[optind][0]))
+			usage(progname);
+		request.cmd =3D INIT_CMD_RUNLVL;
+		request.runlevel  =3D env ? 0 : argv[optind][0];
+		request.sleeptime =3D sltime;
+	}
+
+	/* Open the fifo and write a command. */
+	/* Make sure we don't hang on opening /dev/initctl */
+	SETSIG(sa, SIGALRM, signal_handler, 0);
+	alarm(3);
+	if ((fd =3D open(INIT_FIFO, O_WRONLY)) >=3D 0 &&
+	    write(fd, &request, sizeof(request)) =3D=3D sizeof(request)) {
+		close(fd);
+		alarm(0);
+		return 0;
+	}
+
+#ifdef TELINIT_USES_INITLVL
+	if (request.cmd =3D=3D INIT_CMD_RUNLVL) {
+		/* Fallthrough to the old method. */
+
+		/* Now write the new runlevel. */
+		if ((fp =3D fopen(INITLVL, "w")) =3D=3D NULL) {
+			fprintf(stderr, "%s: cannot create %s\n",
+				progname, INITLVL);
+			exit(1);
+		}
+		fprintf(fp, "%s %d", argv[optind], sltime);
+		fclose(fp);
+
+		/* And tell init about the pending runlevel change. */
+		if (kill(INITPID, SIGHUP) < 0) perror(progname);
+
+		return 0;
+	}
+#endif
+
+	fprintf(stderr, "%s: ", progname);
+	if (ISMEMBER(got_signals, SIGALRM)) {
+		fprintf(stderr, "timeout opening/writing control channel %s\n",
+			INIT_FIFO);
+	} else {
+		perror(INIT_FIFO);
+	}
+	return 1;
+}
+
+/*
+ * Main entry for init and telinit.
+ */
+int main(int argc, char **argv)
+{
+	char			*p;
+	int			f;
+	int			isinit;
+
+	/* Get my own name */
+	if ((p =3D strrchr(argv[0], '/')) !=3D NULL)
+  		p++;
+	else
+  		p =3D argv[0];
+	umask(022);
+
+	/* Quick check */
+	if (geteuid() !=3D 0) {
+		fprintf(stderr, "%s: must be superuser.\n", p);
+		exit(1);
+	}
+
+	/*
+	 *	Is this telinit or init ?
+	 */
+	isinit =3D (getpid() =3D=3D 1);
+	for (f =3D 1; f < argc; f++) {
+		if (!strcmp(argv[f], "-i") || !strcmp(argv[f], "--init"))
+			isinit =3D 1;
+			break;
+	}
+	if (!isinit) exit(telinit(p, argc, argv));
+
+	/*
+	 *	Check for re-exec
+	 */ =09
+	if (check_pipe(STATE_PIPE)) {
+
+		receive_state(STATE_PIPE);
+
+		myname =3D istrdup(argv[0]);
+		argv0 =3D argv[0];
+		maxproclen =3D 0;
+		for (f =3D 0; f < argc; f++)
+			maxproclen +=3D strlen(argv[f]) + 1;
+		reload =3D 1;
+		setproctitle("init [%c]",runlevel);
+
+		init_main();
+	}
+
+  	/* Check command line arguments */
+	maxproclen =3D strlen(argv[0]) + 1;
+  	for(f =3D 1; f < argc; f++) {
+		if (!strcmp(argv[f], "single") || !strcmp(argv[f], "-s"))
+			dfl_level =3D 'S';
+		else if (!strcmp(argv[f], "-a") || !strcmp(argv[f], "auto"))
+			putenv("AUTOBOOT=3DYES");
+		else if (!strcmp(argv[f], "-b") || !strcmp(argv[f],"emergency"))
+			emerg_shell =3D 1;
+		else if (!strcmp(argv[f], "-z")) {
+			/* Ignore -z xxx */
+			if (argv[f + 1]) f++;
+		} else if (strchr("0123456789sS", argv[f][0])
+			&& strlen(argv[f]) =3D=3D 1)
+			dfl_level =3D argv[f][0];
+		/* "init u" in the very beginning makes no sense */
+		if (dfl_level =3D=3D 's') dfl_level =3D 'S';
+		maxproclen +=3D strlen(argv[f]) + 1;
+	}
+
+	/* Start booting. */
+	argv0 =3D argv[0];
+	argv[1] =3D NULL;
+	setproctitle("init boot");
+	init_main(dfl_level);
+
+	/*NOTREACHED*/
+	return 0;
+}
diff -U 3 -H -d -r -N -- sysvinit-2.86/src/sulogin.c sysvinit-2.86-selinux/=
src/sulogin.c
=2D-- sysvinit-2.86/src/sulogin.c	2004-07-30 19:40:28.000000000 +0800
+++ sysvinit-2.86-selinux/src/sulogin.c	2007-03-09 22:30:59.000000000 +0800
@@ -28,6 +28,9 @@
 #  include <crypt.h>
 #endif
=20
+#include <selinux/selinux.h>
+#include <selinux/get_context_list.h>
+
 #define CHECK_DES	1
 #define CHECK_MD5	1
=20
@@ -335,6 +338,19 @@
 	signal(SIGINT, SIG_DFL);
 	signal(SIGTSTP, SIG_DFL);
 	signal(SIGQUIT, SIG_DFL);
+	if (is_selinux_enabled > 0) {
+	  security_context_t scon=3DNULL;
+	  char *seuser=3DNULL;
+	  char *level=3DNULL;
+	  if (getseuserbyname("root", &seuser, &level) =3D=3D 0)
+		  if (get_default_context_with_level(seuser, level, 0, &scon) > 0) {
+			  if (setexeccon(scon) !=3D 0)=20
+				  fprintf(stderr, "setexeccon faile\n");
+			  freecon(scon);
+		  }
+		free(seuser);
+		free(level);
+	}
 	execl(sushell, shell, NULL);
 	perror(sushell);
=20
diff -U 3 -H -d -r -N -- sysvinit-2.86/src/sulogin.c~ sysvinit-2.86-selinux=
/src/sulogin.c~
=2D-- sysvinit-2.86/src/sulogin.c~	1970-01-01 08:00:00.000000000 +0800
+++ sysvinit-2.86-selinux/src/sulogin.c~	2004-07-30 19:40:28.000000000 +0800
@@ -0,0 +1,456 @@
+/*
+ * sulogin	This program gives Linux machines a reasonable
+ *		secure way to boot single user. It forces the
+ *		user to supply the root password before a
+ *		shell is started.
+ *
+ *		If there is a shadow password file and the
+ *		encrypted root password is "x" the shadow
+ *		password will be used.
+ *
+ * Version:	@(#)sulogin 2.85-3 23-Apr-2003 miquels@cistron.nl
+ *
+ */
+
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <pwd.h>
+#include <shadow.h>
+#include <termios.h>
+#include <sys/ioctl.h>
+#if defined(__GLIBC__)
+#  include <crypt.h>
+#endif
+
+#define CHECK_DES	1
+#define CHECK_MD5	1
+
+#define F_PASSWD	"/etc/passwd"
+#define F_SHADOW	"/etc/shadow"
+#define BINSH		"/bin/sh"
+
+char *Version =3D "@(#)sulogin 2.85-3 23-Apr-2003 miquels@cistron.nl";
+
+int timeout =3D 0;
+int profile =3D 0;
+
+#ifndef IUCLC
+#  define IUCLC	0
+#endif
+
+#if 0
+/*
+ *	Fix the tty modes and set reasonable defaults.
+ *	(I'm not sure if this is needed under Linux, but..)
+ */
+void fixtty(void)
+{
+	struct termios tty;
+
+	tcgetattr(0, &tty);
+
+	/*
+	 *	Set or adjust tty modes.
+	 */
+	tty.c_iflag &=3D ~(INLCR|IGNCR|IUCLC);
+	tty.c_iflag |=3D ICRNL;
+	tty.c_oflag &=3D ~(OCRNL|OLCUC|ONOCR|ONLRET|OFILL);
+	tty.c_oflag |=3D OPOST|ONLCR;
+	tty.c_cflag |=3D CLOCAL;
+	tty.c_lflag  =3D ISIG|ICANON|ECHO|ECHOE|ECHOK|ECHOCTL|ECHOKE;
+
+	/*
+	 *	Set the most important characters */
+	 */
+	tty.c_cc[VINTR]  =3D 3;
+	tty.c_cc[VQUIT]  =3D 28;
+	tty.c_cc[VERASE] =3D 127;
+	tty.c_cc[VKILL]  =3D 24;
+	tty.c_cc[VEOF]   =3D 4;
+	tty.c_cc[VTIME]  =3D 0;
+	tty.c_cc[VMIN]   =3D 1;
+	tty.c_cc[VSTART] =3D 17;
+	tty.c_cc[VSTOP]  =3D 19;
+	tty.c_cc[VSUSP]  =3D 26;
+=20
+	tcsetattr(0, TCSANOW, &tty);
+}
+#endif
+
+
+/*
+ *	Called at timeout.
+ */
+void alrm_handler()
+{
+}
+
+/*
+ *	See if an encrypted password is valid. The encrypted
+ *	password is checked for traditional-style DES and
+ *	FreeBSD-style MD5 encryption.
+ */
+int valid(char *pass)
+{
+	char *s;
+	int len;
+
+	if (pass[0] =3D=3D 0) return 1;
+#if CHECK_MD5
+	/*
+	 *	3 bytes for the signature $1$
+	 *	up to 8 bytes for the salt
+	 *	$
+	 *	the MD5 hash (128 bits or 16 bytes) encoded in base64 =3D 22 bytes
+	 */
+	if (strncmp(pass, "$1$", 3) =3D=3D 0) {
+		for(s =3D pass + 3; *s && *s !=3D '$'; s++)
+			;
+		if (*s++ !=3D '$') return 0;
+		len =3D strlen(s);
+		if (len < 22 || len > 24) return 0;
+
+		return 1;
+	}
+#endif
+#if CHECK_DES
+	if (strlen(pass) !=3D 13) return 0;
+	for (s =3D pass; *s; s++) {
+		if ((*s < '0' || *s > '9') &&
+		    (*s < 'a' || *s > 'z') &&
+		    (*s < 'A' || *s > 'Z') &&
+		    *s !=3D '.' && *s !=3D '/') return 0;
+	}
+#endif
+	return 1;
+}
+
+/*
+ *	Set a variable if the value is not NULL.
+ */
+void set(char **var, char *val)
+{
+	if (val) *var =3D val;
+}
+
+/*
+ *	Get the root password entry.
+ */
+struct passwd *getrootpwent(int try_manually)
+{
+	static struct passwd pwd;
+	struct passwd *pw;
+	struct spwd *spw;
+	FILE *fp;
+	static char line[256];
+	static char sline[256];
+	char *p;
+
+	/*
+	 *	First, we try to get the password the standard
+	 *	way using normal library calls.
+	 */
+	if ((pw =3D getpwnam("root")) &&
+	    !strcmp(pw->pw_passwd, "x") &&
+	    (spw =3D getspnam("root")))
+		pw->pw_passwd =3D spw->sp_pwdp;
+	if (pw || !try_manually) return pw;
+
+	/*
+	 *	If we come here, we could not retrieve the root
+	 *	password through library calls and we try to
+	 *	read the password and shadow files manually.
+	 */
+	pwd.pw_name =3D "root";
+	pwd.pw_passwd =3D "";
+	pwd.pw_gecos =3D "Super User";
+	pwd.pw_dir =3D "/";
+	pwd.pw_shell =3D "";
+	pwd.pw_uid =3D 0;
+	pwd.pw_gid =3D 0;
+
+	if ((fp =3D fopen(F_PASSWD, "r")) =3D=3D NULL) {
+		perror(F_PASSWD);
+		return &pwd;
+	}
+
+	/*
+	 *	Find root in the password file.
+	 */
+	while((p =3D fgets(line, 256, fp)) !=3D NULL) {
+		if (strncmp(line, "root:", 5) !=3D 0)
+			continue;
+		p +=3D 5;
+		set(&pwd.pw_passwd, strsep(&p, ":"));
+		(void)strsep(&p, ":");
+		(void)strsep(&p, ":");
+		set(&pwd.pw_gecos, strsep(&p, ":"));
+		set(&pwd.pw_dir, strsep(&p, ":"));
+		set(&pwd.pw_shell, strsep(&p, "\n"));
+		p =3D line;
+		break;
+	}
+	fclose(fp);
+
+	/*
+	 *	If the encrypted password is valid
+	 *	or not found, return.
+	 */
+	if (p =3D=3D NULL) {
+		fprintf(stderr, "%s: no entry for root\n", F_PASSWD);
+		return &pwd;
+	}
+	if (valid(pwd.pw_passwd)) return &pwd;
+
+	/*
+	 *	The password is invalid. If there is a
+	 *	shadow password, try it.
+	 */
+	strcpy(pwd.pw_passwd, "");
+	if ((fp =3D fopen(F_SHADOW, "r")) =3D=3D NULL) {
+		fprintf(stderr, "%s: root password garbled\n", F_PASSWD);
+		return &pwd;
+	}
+	while((p =3D fgets(sline, 256, fp)) !=3D NULL) {
+		if (strncmp(sline, "root:", 5) !=3D 0)
+			continue;
+		p +=3D 5;
+		set(&pwd.pw_passwd, strsep(&p, ":"));
+		break;
+	}
+	fclose(fp);
+
+	/*
+	 *	If the password is still invalid,
+	 *	NULL it, and return.
+	 */
+	if (p =3D=3D NULL) {
+		fprintf(stderr, "%s: no entry for root\n", F_SHADOW);
+		strcpy(pwd.pw_passwd, "");
+	}
+	if (!valid(pwd.pw_passwd)) {
+		fprintf(stderr, "%s: root password garbled\n", F_SHADOW);
+		strcpy(pwd.pw_passwd, ""); }
+	return &pwd;
+}
+
+/*
+ *	Ask for the password. Note that there is no
+ *	default timeout as we normally skip this during boot.
+ */
+char *getpasswd(char *crypted)
+{
+	struct sigaction sa;
+	struct termios old, tty;
+	static char pass[128];
+	char *ret =3D pass;
+	int i;
+
+	if (crypted[0])
+		printf("Give root password for maintenance\n");
+	else
+		printf("Press enter for maintenance\n");
+	printf("(or type Control-D to continue): ");
+	fflush(stdout);
+
+	tcgetattr(0, &old);
+	tcgetattr(0, &tty);
+	tty.c_iflag &=3D ~(IUCLC|IXON|IXOFF|IXANY);
+	tty.c_lflag &=3D ~(ECHO|ECHOE|ECHOK|ECHONL|TOSTOP);
+	tcsetattr(0, TCSANOW, &tty);
+
+	pass[sizeof(pass) - 1] =3D 0;
+
+	sa.sa_handler =3D alrm_handler;
+	sa.sa_flags =3D 0;
+	sigaction(SIGALRM, &sa, NULL);
+	if (timeout) alarm(timeout);
+
+	if (read(0, pass, sizeof(pass) - 1) <=3D 0)
+		ret =3D NULL;
+	else {
+		for(i =3D 0; i < sizeof(pass) && pass[i]; i++)
+			if (pass[i] =3D=3D '\r' || pass[i] =3D=3D '\n') {
+				pass[i] =3D 0;
+				break;
+			}
+	}
+	alarm(0);
+	tcsetattr(0, TCSANOW, &old);
+	printf("\n");
+
+	return ret;
+}
+
+/*
+ *	Password was OK, execute a shell.
+ */
+void sushell(struct passwd *pwd)
+{
+	char shell[128];
+	char home[128];
+	char *p;
+	char *sushell;
+
+	/*
+	 *	Set directory and shell.
+	 */
+	(void)chdir(pwd->pw_dir);
+	if ((p =3D getenv("SUSHELL")) !=3D NULL)
+		sushell =3D p;
+	else if ((p =3D getenv("sushell")) !=3D NULL)
+		sushell =3D p;
+	else {
+		if (pwd->pw_shell[0])
+			sushell =3D pwd->pw_shell;
+		else
+			sushell =3D BINSH;
+	}
+	if ((p =3D strrchr(sushell, '/')) =3D=3D NULL)
+		p =3D sushell;
+	else
+		p++;
+	snprintf(shell, sizeof(shell), profile ? "-%s" : "%s", p);
+
+	/*
+	 *	Set some important environment variables.
+	 */
+	getcwd(home, sizeof(home));
+	setenv("HOME", home, 1);
+	setenv("LOGNAME", "root", 1);
+	setenv("USER", "root", 1);
+	if (!profile)
+		setenv("SHLVL","0",1);
+
+	/*
+	 *	Try to execute a shell.
+	 */
+	setenv("SHELL", sushell, 1);
+	signal(SIGINT, SIG_DFL);
+	signal(SIGTSTP, SIG_DFL);
+	signal(SIGQUIT, SIG_DFL);
+	execl(sushell, shell, NULL);
+	perror(sushell);
+
+	setenv("SHELL", BINSH, 1);
+	execl(BINSH, profile ? "-sh" : "sh", NULL);
+	perror(BINSH);
+}
+
+void usage(void)
+{
+	fprintf(stderr, "Usage: sulogin [-e] [-p] [-t timeout] [tty device]\n");
+}
+
+int main(int argc, char **argv)
+{
+	char *tty =3D NULL;
+	char *p;
+	struct passwd *pwd;
+	int c, fd =3D -1;
+	int opt_e =3D 0;
+	pid_t pid, pgrp, ppgrp, ttypgrp;
+
+	/*
+	 *	See if we have a timeout flag.
+	 */
+	opterr =3D 0;
+	while((c =3D getopt(argc, argv, "ept:")) !=3D EOF) switch(c) {
+		case 't':
+			timeout =3D atoi(optarg);
+			break;
+		case 'p':
+			profile =3D 1;
+			break;
+		case 'e':
+			opt_e =3D 1;
+			break;
+		default:
+			usage();
+			/* Do not exit! */
+			break;
+	}
+
+	if (geteuid() !=3D 0) {
+		fprintf(stderr, "sulogin: only root can run sulogin.\n");
+		exit(1);
+	}
+
+	/*
+	 *	See if we need to open an other tty device.
+	 */
+	signal(SIGINT, SIG_IGN);
+	signal(SIGQUIT, SIG_IGN);
+	signal(SIGTSTP, SIG_IGN);
+	if (optind < argc) tty =3D argv[optind];
+	if (tty) {
+		if ((fd =3D open(tty, O_RDWR)) < 0) {
+			perror(tty);
+		} else if (!isatty(fd)) {
+			fprintf(stderr, "%s: not a tty\n", tty);
+			close(fd);
+		} else {
+
+			/*
+			 *	Only go through this trouble if the new
+			 *	tty doesn't fall in this process group.
+			 */
+			pid =3D getpid();
+			pgrp =3D getpgid(0);
+			ppgrp =3D getpgid(getppid());
+			ioctl(fd, TIOCGPGRP, &ttypgrp);
+
+			if (pgrp !=3D ttypgrp && ppgrp !=3D ttypgrp) {
+				if (pid !=3D getsid(0)) {
+					if (pid =3D=3D getpgid(0))
+						setpgid(0, getpgid(getppid()));
+					setsid();
+				}
+
+				signal(SIGHUP, SIG_IGN);
+				ioctl(0, TIOCNOTTY, (char *)1);
+				signal(SIGHUP, SIG_DFL);
+				close(0);
+				close(1);
+				close(2);
+				close(fd);
+				fd =3D open(tty, O_RDWR);
+				ioctl(0, TIOCSCTTY, (char *)1);
+				dup(fd);
+				dup(fd);
+			} else
+				close(fd);
+		}
+	}
+
+	/*
+	 *	Get the root password.
+	 */
+	if ((pwd =3D getrootpwent(opt_e)) =3D=3D NULL) {
+		fprintf(stderr, "sulogin: cannot open password database!\n");
+		sleep(2);
+	}
+
+	/*
+	 *	Ask for the password.
+	 */
+	while(pwd) {
+		if ((p =3D getpasswd(pwd->pw_passwd)) =3D=3D NULL) break;
+		if (pwd->pw_passwd[0] =3D=3D 0 ||
+		    strcmp(crypt(p, pwd->pw_passwd), pwd->pw_passwd) =3D=3D 0)
+			sushell(pwd);
+		printf("Login incorrect.\n");
+	}
+
+	/*
+	 *	User pressed Control-D.
+	 */
+	return 0;
+}
+

--Boundary-01=_h6AFKO1aPYYASLe--

--nextPart25896236.IyZ8Atov0X
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)

iEYEABECAAYFAkoUDqMACgkQ1sXw8/2VziTbLwCePBYbHS4pjUZfC1K1T/r6d6IW
cXAAn2P6zV25FjEZhu1b40vr7CdZG9Hi
=KjXp
-----END PGP SIGNATURE-----

--nextPart25896236.IyZ8Atov0X--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
