Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB5ITeRb006751
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 13:29:40 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hB5ISxlU003098
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 18:28:59 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies.epoch.ncsc.mil [144.51.25.7])
	by jazzswing.ncsc.mil  with ESMTP id hB5ISxSX003095
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 18:28:59 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB5ITdmV001026
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 13:29:39 -0500
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id hB5ITd94001024
	for selinux@tycho.nsa.gov; Fri, 5 Dec 2003 13:29:39 -0500
Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hB5ILURb006714
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 13:21:30 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hB5ILTRV007211
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 18:21:29 GMT
Received: from smtp-bedford.mitre.org (smtp-bedford-x.mitre.org [192.160.51.76])
        by jazzband.ncsc.mil  with ESMTP id hB5ILSta007207 for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 18:21:28 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id hB5ILSU22111
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 13:21:28 -0500
Received: from linus.mitre.org (linus.mitre.org [129.83.10.1])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id hB5ILSM22104
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 13:21:28 -0500
Received: from divan.mitre.org (divan.mitre.org [129.83.10.75])
	by linus.mitre.org (8.12.10/8.12.8) with ESMTP id hB5ILSbL013023
	for <selinux@tycho.nsa.gov>; Fri, 5 Dec 2003 13:21:28 -0500 (EST)
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Security contexts in strace
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 05 Dec 2003 13:21:28 -0500
In-Reply-To: <ogtoeun6sui.fsf@divan.mitre.org>
Message-ID: <ogtk75b6s7r.fsf@divan.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I augmented strace so one sees security context information in system
call trace output.  For example, here is an augmented trace of the
usual hello world program:

$ ./strace -X ./hello
execve("./hello", ["./hello"], [/* 25 vars */]) = 0 <<ramsdell:user_r:user_t>>
uname({sys="Linux", node="expresso", ...}) = 0 <<ramsdell:user_r:user_t>>
set_tid_address(0)                      = -1 ENOSYS (Function not implemented) <<ramsdell:user_r:user_t>>
brk(0)                                  = 0x8049524 <<ramsdell:user_r:user_t>>
open("/etc/ld.so.preload" <<???>>, O_RDONLY) = -1 ENOENT (No such file or directory) <<ramsdell:user_r:user_t>>
open("/etc/ld.so.cache" <<gwilliam:object_r:etc_t>>, O_RDONLY) = 3 <<ramsdell:user_r:user_t>>
fstat64(3 <<???>>, {st_mode=S_IFREG|0644, st_size=58502, ...}) = 0 <<ramsdell:user_r:user_t>>
old_mmap(NULL, 58502, PROT_READ, MAP_PRIVATE, 3 <<???>>, 0) = 0x40016000 <<ramsdell:user_r:user_t>>
close(3 <<???>>)                        = 0 <<ramsdell:user_r:user_t>>
open("/lib/i686/libc.so.6" <<system_u:object_r:shlib_t>>, O_RDONLY) = 3 <<ramsdell:user_r:user_t>>
read(3 <<???>>, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0000\\\1"..., 512) = 512 <<ramsdell:user_r:user_t>>
fstat64(3 <<???>>, {st_mode=S_IFREG|0755, st_size=1561552, ...}) = 0 <<ramsdell:user_r:user_t>>
old_mmap(NULL, 1288868, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3 <<???>>, 0) = 0x40025000 <<ramsdell:user_r:user_t>>
old_mmap(0x4015a000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3 <<???>>, 0x134000) = 0x4015a000 <<ramsdell:user_r:user_t>>
old_mmap(0x4015e000, 6820, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4015e000 <<ramsdell:user_r:user_t>>
close(3 <<???>>)                        = 0 <<ramsdell:user_r:user_t>>
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40160000 <<ramsdell:user_r:user_t>>
munmap(0x40016000, 58502)               = 0 <<ramsdell:user_r:user_t>>
fstat64(1 <<ramsdell:object_r:user_devpts_t>>, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 1), ...}) = 0 <<ramsdell:user_r:user_t>>
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000 <<ramsdell:user_r:user_t>>
write(1 <<ramsdell:object_r:user_devpts_t>>, "Hello\n", 6Hello
) = 6 <<ramsdell:user_r:user_t>>
munmap(0x40016000, 4096)                = 0 <<ramsdell:user_r:user_t>>
exit_group(0)                           = ? <<ramsdell:user_r:user_t>>
$

To build an SELinux extended strace, save this message in a file named
strace-selinux.patch, and then go to 

http://sourceforge.net/projects/strace

and download strace version 4.5.  Build the patched system as follows.

$ tar xjf strace-4.5.tar.bz2
$ cd strace-4.5
$ patch -p1 < ../strace-selinux.patch
$ autoreconf
$ ./configure
$ make
$ ./strace -X ....

Note, this is a very preliminary version of the code, but I thought
some of you might like to play with it in its current state.

John

Only in strace-4.5: aclocal.m4
diff -ur strace-4.5/bjm.c strace/bjm.c
--- strace-4.5/bjm.c	2002-11-06 09:00:12.000000000 -0500
+++ strace/bjm.c	2003-11-14 06:32:22.000000000 -0500
@@ -27,7 +27,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: bjm.c,v 1.11 2002/11/06 14:00:12 ludvigm Exp $
+ *	$Id: bjm.c,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 #include "defs.h"
 
Only in strace-4.5: compile
Only in strace-4.5: config.guess
Only in strace-4.5: config.h.in
Only in strace-4.5: config.sub
Only in strace-4.5: configure
diff -ur strace-4.5/configure.ac strace/configure.ac
--- strace-4.5/configure.ac	2003-09-24 18:17:21.000000000 -0400
+++ strace/configure.ac	2003-11-24 07:10:06.000000000 -0500
@@ -1,6 +1,6 @@
 dnl Process this file with autoconf to create configure.  Use autoreconf.
 AC_PREREQ(2.57)
-AC_INIT([strace],[4.5])
+AC_INIT([strace],[4.5X])
 AC_CONFIG_SRCDIR([strace.c])
 AM_CONFIG_HEADER([config.h])
 AM_INIT_AUTOMAKE([foreign check-news dist-bzip2])
@@ -187,6 +187,10 @@
 AC_CHECK_LIB(nsl, main)
 fi
 
+dnl See if Security-Enhanced Linux library is available.
+AC_CHECK_HEADERS([selinux/selinux.h])
+AC_CHECK_LIB([selinux], [is_selinux_enabled])
+
 AC_CHECK_FUNCS(sigaction strerror strsignal pread sys_siglist _sys_siglist getdents mctl prctl sendmsg inet_ntop if_indextoname)
 AC_CHECK_HEADERS([sys/reg.h sys/filio.h sys/acl.h sys/asynch.h sys/door.h stropts.h sys/conf.h sys/stream.h sys/tihdr.h sys/tiuser.h sys/sysconfig.h ioctls.h sys/ioctl.h sys/ptrace.h termio.h linux/ptrace.h asm/reg.h sys/uio.h sys/aio.h  poll.h sys/poll.h sys/vfs.h asm/sysmips.h linux/utsname.h sys/nscsys.h], [], [])
 AC_CHECK_HEADERS([linux/icmp.h linux/in6.h linux/netlink.h linux/if_packet.h],
diff -ur strace-4.5/COPYRIGHT strace/COPYRIGHT
--- strace-4.5/COPYRIGHT	2002-03-31 13:43:00.000000000 -0500
+++ strace/COPYRIGHT	2003-11-14 06:32:22.000000000 -0500
@@ -28,4 +28,4 @@
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
-$Id: COPYRIGHT,v 1.3 2002/03/31 18:43:00 wichert Exp $
+$Id: COPYRIGHT,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
diff -ur strace-4.5/debian/copyright strace/debian/copyright
--- strace-4.5/debian/copyright	2002-12-30 04:09:53.000000000 -0500
+++ strace/debian/copyright	2003-11-14 06:32:22.000000000 -0500
@@ -35,4 +35,4 @@
 (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
-$Id: copyright,v 1.1 2002/03/31 18:45:45 wichert Exp $
+$Id: copyright,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
diff -ur strace-4.5/defs.h strace/defs.h
--- strace-4.5/defs.h	2003-08-21 05:58:00.000000000 -0400
+++ strace/defs.h	2003-12-03 11:36:13.000000000 -0500
@@ -26,7 +26,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: defs.h,v 1.43 2003/08/21 09:58:00 roland Exp $
+ *	$Id: defs.h,v 1.5 2003/12/03 16:36:13 ramsdell Exp $
  */
 
 #ifdef linux
@@ -595,3 +595,45 @@
 #endif
 
 extern int not_failing_only;
+
+/* Addition to support SELinux */
+
+#if defined HAVE_SELINUX_SELINUX_H && defined HAVE_LIBSELINUX
+#include <selinux/selinux.h>
+#define SELINUX
+extern void selinux_printcon P(());
+extern void selinux_printpid P((long));
+extern void selinux_printprevcon P(());
+extern void selinux_printexeccon P(());
+extern void selinux_printfscreatecon P(());
+extern void selinux_printpath P((const char *));
+extern void selinux_printlpath P((const char *));
+extern void selinux_printdesc P((long));
+extern int selinux_enabled;
+#endif
+
+/* Inlined printers */
+
+inline static void
+printdesc(long fd)
+{
+	tprintf("%ld", fd);
+#if defined SELINUX
+	selinux_printdesc(fd);
+#endif
+}
+
+inline static void
+printpid(long pid)
+{
+	tprintf("%ld", pid);
+#if defined SELINUX
+	selinux_printpid(pid);
+#endif
+}
+
+inline static void
+printargsep()
+{
+	tprintf(", ");
+}
Only in strace-4.5: depcomp
diff -ur strace-4.5/desc.c strace/desc.c
--- strace-4.5/desc.c	2003-01-14 02:53:31.000000000 -0500
+++ strace/desc.c	2003-12-03 09:47:54.000000000 -0500
@@ -27,7 +27,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: desc.c,v 1.12 2003/01/14 07:53:31 roland Exp $
+ *	$Id: desc.c,v 1.3 2003/12/03 14:47:54 ramsdell Exp $
  */
 
 #include "defs.h"
@@ -264,7 +264,8 @@
 	extern struct xlat openmodes[];
 
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		tprintf(", ");
 		printxval(fcntlcmds, tcp->u_arg[1], "F_???");
 		switch (tcp->u_arg[1]) {
 		case F_SETFD:
@@ -347,7 +348,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		tprintf(", ");
 		if (!printflags(flockcmds, tcp->u_arg[1]))
 			tprintf("LOCK_???");
 	}
@@ -360,7 +362,7 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
 	}
 	return 0;
 }
@@ -370,7 +372,7 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
 	}
 	return 0;
 }
@@ -380,7 +382,9 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, %ld", tcp->u_arg[0], tcp->u_arg[1]);
+		printdesc(tcp->u_arg[0]);
+		printargsep();
+		printdesc(tcp->u_arg[1]);
 	}
 	return 0;
 }
diff -ur strace-4.5/errnoent.sh strace/errnoent.sh
--- strace-4.5/errnoent.sh	1999-02-18 19:22:09.000000000 -0500
+++ strace/errnoent.sh	2003-11-14 06:32:22.000000000 -0500
@@ -24,7 +24,7 @@
 # (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 # THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #
-#	$Id: errnoent.sh,v 1.1.1.1 1999/02/19 00:22:09 wichert Exp $
+#	$Id: errnoent.sh,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
 
 awk '
 /^#define[ 	]+E[A-Z0-9_]+[ 	]+[0-9]+/ {
diff -ur strace-4.5/file.c strace/file.c
--- strace-4.5/file.c	2003-07-17 05:03:02.000000000 -0400
+++ strace/file.c	2003-12-05 10:43:43.000000000 -0500
@@ -28,7 +28,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: file.c,v 1.53 2003/07/17 09:03:02 roland Exp $
+ *	$Id: file.c,v 1.6 2003/12/05 15:43:43 ramsdell Exp $
  */
 
 #include "defs.h"
@@ -394,7 +394,8 @@
 	int _whence;
 
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		tprintf(", ");
 		offset = tcp->u_arg[1];
 		_whence = tcp->u_arg[2];
 		if (_whence == SEEK_SET)
@@ -413,12 +414,14 @@
 struct tcb *tcp;
 {
     if (entering(tcp)) {
-	if (tcp->u_arg[4] == SEEK_SET)
-	    tprintf("%ld, %llu, ", tcp->u_arg[0],
+        printdesc(tcp->u_arg[0]);
+	printargsep();
+	if (tcp->u_arg[4] == SEEK_SET) 
+	    tprintf("%llu, ", 
 		    (((long long int) tcp->u_arg[1]) << 32
 		     | (unsigned long long) (unsigned) tcp->u_arg[2]));
 	else
-	    tprintf("%ld, %lld, ", tcp->u_arg[0],
+	    tprintf("%lld, ",
 		    (((long long int) tcp->u_arg[1]) << 32
 		     | (unsigned long long) (unsigned) tcp->u_arg[2]));
     }
@@ -438,7 +441,9 @@
 struct tcb *tcp;
 {
     if (entering(tcp)) {
-	tprintf("%ld, %lld, %ld", tcp->u_arg[0],
+        printdesc(tcp->u_arg[0]);
+	printargsep();
+	tprintf("%lld, %ld",
 # if defined IA64 || defined X86_64 || defined ALPHA
 		(long long int) tcp->u_arg[1], tcp->u_arg[2]
 # else
@@ -459,12 +464,14 @@
 {
 	if (entering(tcp)) {
 		long long offset;
+		printdesc(tcp->u_arg[0]);
+		printargsep();
 		ALIGN64 (tcp, 1);	/* FreeBSD aligns off_t args */
 		offset = LONG_LONG(tcp->u_arg [1], tcp->u_arg[2]);
 		if (tcp->u_arg[3] == SEEK_SET)
-			tprintf("%ld, %llu, ", tcp->u_arg[0], offset);
+			tprintf("%llu, ", offset);
 		else
-			tprintf("%ld, %lld, ", tcp->u_arg[0], offset);
+			tprintf("%lld, ", offset);
 		printxval(whence, tcp->u_arg[3], "SEEK_???");
 	}
 	return RVAL_LUDECIMAL;
@@ -504,7 +511,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, %lu", tcp->u_arg[0], tcp->u_arg[1]);
+		printdesc(tcp->u_arg[0]);
+		tprintf(", %lu", tcp->u_arg[1]);
 	}
 	return 0;
 }
@@ -517,7 +525,8 @@
 {
 	if (entering(tcp)) {
 		ALIGN64 (tcp, 1);
-		tprintf("%ld, %llu", tcp->u_arg[0],
+		printdesc(tcp->u_arg[0]);
+		tprintf(", %llu", 
 			LONG_LONG(tcp->u_arg[1] ,tcp->u_arg[2]));
 	}
 	return 0;
@@ -703,7 +712,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		printargsep();
 		if (tcp->u_arg[1])
 			printflags(fileflags, tcp->u_arg[1]);
 		else
@@ -1026,9 +1036,10 @@
 sys_fstat(tcp)
 struct tcb *tcp;
 {
-	if (entering(tcp))
-		tprintf("%ld, ", tcp->u_arg[0]);
-	else {
+	if (entering(tcp)) {
+		printdesc(tcp->u_arg[0]);
+		printargsep();
+        } else {
 		printstat(tcp, tcp->u_arg[1]);
 	}
 	return 0;
@@ -1040,9 +1051,10 @@
 struct tcb *tcp;
 {
 #ifdef HAVE_STAT64
-	if (entering(tcp))
-		tprintf("%ld, ", tcp->u_arg[0]);
-	else {
+        if (entering(tcp)) {
+		printdesc(tcp->u_arg[0]);
+		printargsep();
+	} else {
 		printstat64(tcp, tcp->u_arg[1]);
 	}
 	return 0;
@@ -1056,9 +1068,10 @@
 sys_oldfstat(tcp)
 struct tcb *tcp;
 {
-	if (entering(tcp))
-		tprintf("%ld, ", tcp->u_arg[0]);
-	else {
+        if (entering(tcp)) {
+		printdesc(tcp->u_arg[0]);
+		printargsep();
+	} else {
 		printoldstat(tcp, tcp->u_arg[1]);
 	}
 	return 0;
@@ -1138,9 +1151,11 @@
 sys_fxstat(tcp)
 struct tcb *tcp;
 {
-	if (entering(tcp))
-		tprintf("%ld, %ld, ", tcp->u_arg[0], tcp->u_arg[1]);
-	else {
+        if (entering(tcp)) {
+		printdesc(tcp->u_arg[0]);
+		printargsep();
+		tprintf("%ld, ", tcp->u_arg[1]);
+	} else {
 #ifdef _STAT64_VER
 		if (tcp->u_arg[0] == _STAT64_VER)
 			printstat64 (tcp, tcp->u_arg[2]);
@@ -1252,7 +1267,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+	        printdesc(tcp->u_arg[0]);
+		printargsep();
 		printxval(aclcmds, tcp->u_arg[1], "???ACL???");
 		tprintf(", %ld", tcp->u_arg[2]);
 		/*
@@ -1428,7 +1444,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%lu, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		tprintf(", ");
 	} else {
 		printstatfs(tcp, tcp->u_arg[1]);
 	}
@@ -1500,7 +1517,9 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%lu, %lu, ", tcp->u_arg[0], tcp->u_arg[1]);
+	        printdesc(tcp->u_arg[0]);
+		printargsep();
+		tprintf("%lu, ", tcp->u_arg[1]);
 	} else {
 		if (tcp->u_arg[1] == sizeof (struct statfs64))
 			printstatfs64(tcp, tcp->u_arg[2]);
@@ -1627,7 +1646,7 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
 	}
 	return 0;
 }
@@ -1647,7 +1666,7 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
 	}
 	return 0;
 }
@@ -1731,8 +1750,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, %lu, %lu",
-			tcp->u_arg[0], tcp->u_arg[1], tcp->u_arg[2]);
+		printdesc(tcp->u_arg[0]);
+		tprintf(", %lu, %lu", tcp->u_arg[1], tcp->u_arg[2]);
 	}
 	return 0;
 }
@@ -1753,7 +1772,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, %#lo", tcp->u_arg[0], tcp->u_arg[1]);
+		printdesc(tcp->u_arg[0]);
+		tprintf(", %#lo", tcp->u_arg[1]);
 	}
 	return 0;
 }
@@ -1853,7 +1873,7 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
 	}
 	return 0;
 }
@@ -1886,7 +1906,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%lu, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		printargsep();
 	} else {
 		if (syserror(tcp) || tcp->u_rval == 0 || !verbose(tcp))
 			tprintf("%#lx", tcp->u_arg[1]);
@@ -1924,7 +1945,8 @@
 	char *buf;
 
 	if (entering(tcp)) {
-		tprintf("%lu, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		tprintf(", ");
 		return 0;
 	}
 	if (syserror(tcp) || !verbose(tcp)) {
@@ -2257,7 +2279,8 @@
 struct tcb *tcp;
 {
     if (entering(tcp)) {
-	tprintf("%ld, ", tcp->u_arg[0]);
+        printdesc(tcp->u_arg[0]);
+	printargsep();
 	printstr(tcp, tcp->u_arg[1], -1);
 	/* XXX Print value in format */
 	tprintf(", %p, %ld, ", (void *) tcp->u_arg[2], tcp->u_arg[3]);
@@ -2286,7 +2309,8 @@
 struct tcb *tcp;
 {
     if (entering(tcp)) {
-	tprintf("%ld, ", tcp->u_arg[0]);
+	printdesc(tcp->u_arg[0]);
+	printargsep();
 	printstr(tcp, tcp->u_arg[1], -1);
     } else {
 	/* XXX Print value in format */
@@ -2313,7 +2337,7 @@
 struct tcb *tcp;
 {
     if (entering(tcp)) {
-	tprintf("%ld", tcp->u_arg[0]);
+	printdesc(tcp->u_arg[0]);
     } else {
 	/* XXX Print value in format */
 	tprintf(", %p, %lu", (void *) tcp->u_arg[1], tcp->u_arg[2]);
@@ -2338,7 +2362,8 @@
 struct tcb *tcp;
 {
     if (entering(tcp)) {
-	tprintf("%ld, ", tcp->u_arg[0]);
+	printdesc(tcp->u_arg[0]);
+	printargsep();
 	printstr(tcp, tcp->u_arg[1], -1);
     }
     return 0;
diff -ur strace-4.5/freebsd/syscalls.cat strace/freebsd/syscalls.cat
--- strace-4.5/freebsd/syscalls.cat	2000-09-01 17:03:06.000000000 -0400
+++ strace/freebsd/syscalls.cat	2003-11-14 06:32:22.000000000 -0500
@@ -24,7 +24,7 @@
 # (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 # THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #
-#      $Id: syscalls.cat,v 1.1 2000/09/01 21:03:06 wichert Exp $
+#      $Id: syscalls.cat,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
 #
 # Syscalls categories
 # syntax: syscall catmask
diff -ur strace-4.5/freebsd/syscalls.pl strace/freebsd/syscalls.pl
--- strace-4.5/freebsd/syscalls.pl	2001-03-08 12:27:20.000000000 -0500
+++ strace/freebsd/syscalls.pl	2003-11-14 06:32:22.000000000 -0500
@@ -25,7 +25,7 @@
 # (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 # THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #
-#      $Id: syscalls.pl,v 1.3 2001/03/08 17:27:20 hughesj Exp $
+#      $Id: syscalls.pl,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
 #/
 
 # Buils syscall.h and syscallent.h from:
diff -ur strace-4.5/freebsd/syscalls.print strace/freebsd/syscalls.print
--- strace-4.5/freebsd/syscalls.print	2001-03-08 08:59:00.000000000 -0500
+++ strace/freebsd/syscalls.print	2003-11-14 06:32:22.000000000 -0500
@@ -24,7 +24,7 @@
 # (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 # THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #
-#      $Id: syscalls.print,v 1.4 2001/03/08 13:59:00 hughesj Exp $
+#      $Id: syscalls.print,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
 #
 # Printable syscalls
 # syntax: syscall [printfunc]
Only in strace-4.5: install-sh
diff -ur strace-4.5/io.c strace/io.c
--- strace-4.5/io.c	2003-08-21 05:58:00.000000000 -0400
+++ strace/io.c	2003-12-05 10:43:43.000000000 -0500
@@ -27,7 +27,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: io.c,v 1.16 2003/08/21 09:58:00 roland Exp $
+ *	$Id: io.c,v 1.7 2003/12/05 15:43:43 ramsdell Exp $
  */
 
 #include "defs.h"
@@ -51,7 +51,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		tprintf(", ");
 	} else {
 		if (syserror(tcp))
 			tprintf("%#lx", tcp->u_arg[1]);
@@ -67,7 +68,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		tprintf(", ");
 		printstr(tcp, tcp->u_arg[1], tcp->u_arg[2]);
 		tprintf(", %lu", tcp->u_arg[2]);
 	}
@@ -117,7 +119,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		tprintf(", ");
 	} else {
 		if (syserror(tcp)) {
 			tprintf("%#lx, %lu",
@@ -135,7 +138,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		tprintf(", ");
 		tprint_iov(tcp, tcp->u_arg[2], tcp->u_arg[1]);
 		tprintf(", %lu", tcp->u_arg[2]);
 	}
@@ -150,7 +154,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		tprintf(", ");
 	} else {
 		if (syserror(tcp))
 			tprintf("%#lx", tcp->u_arg[1]);
@@ -173,7 +178,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		tprintf(", ");
 		printstr(tcp, tcp->u_arg[1], tcp->u_arg[2]);
 #if UNIXWARE
 		/* off_t is signed int */
@@ -197,7 +203,10 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, %ld, %llu, %lu", tcp->u_arg[0], tcp->u_arg[1],
+	        printdesc(tcp->u_arg[0]);
+		printargsep();
+		printdesc(tcp->u_arg[1]);
+		tprintf(", %llu, %lu", 
 			(((unsigned long long) tcp->u_arg[3]) << 32 |
 			 (unsigned) tcp->u_arg[2]), tcp->u_arg[4]);
 	} else {
@@ -248,7 +257,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		printargsep();
 	} else {
 		if (syserror(tcp))
 			tprintf("%#lx", tcp->u_arg[1]);
@@ -266,7 +276,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		printargsep();
 		printstr(tcp, tcp->u_arg[1], tcp->u_arg[2]);
 		ALIGN64 (tcp, PREAD_OFFSET_ARG); /* PowerPC alignment restriction */
 		tprintf(", %lu, %llu", tcp->u_arg[2],
@@ -282,7 +293,10 @@
 	if (entering(tcp)) {
 		off_t offset;
 
-		tprintf("%ld, %ld, ", tcp->u_arg[0], tcp->u_arg[1]);
+		printdesc(tcp->u_arg[0]);
+		printargsep();
+		printdesc(tcp->u_arg[1]);
+		printargsep();
 		if (!tcp->u_arg[2])
 			tprintf("NULL");
 		else if (umove(tcp, tcp->u_arg[2], &offset) < 0)
@@ -301,7 +315,10 @@
 	if (entering(tcp)) {
 		loff_t offset;
 
-		tprintf("%ld, %ld, ", tcp->u_arg[0], tcp->u_arg[1]);
+		printdesc(tcp->u_arg[0]);
+		printargsep();
+		printdesc(tcp->u_arg[1]);
+		printargsep();
 		if (!tcp->u_arg[2])
 			tprintf("NULL");
 		else if (umove(tcp, tcp->u_arg[2], &offset) < 0)
@@ -321,7 +338,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		printargsep();
 	} else {
 		ALIGN64 (tcp, 3);
 		if (syserror(tcp))
@@ -340,7 +358,8 @@
 {
 	if (entering(tcp)) {
 		ALIGN64 (tcp, 3);
-		tprintf("%ld, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		printargsep();
 		printstr(tcp, tcp->u_arg[1], tcp->u_arg[2]);
 		tprintf(", %lu, %#llx", tcp->u_arg[2],
 			LONG_LONG(tcp->u_arg[3], tcp->u_arg[4]));
diff -ur strace-4.5/ioctl.c strace/ioctl.c
--- strace-4.5/ioctl.c	2003-01-14 02:53:34.000000000 -0500
+++ strace/ioctl.c	2003-11-14 06:32:22.000000000 -0500
@@ -27,7 +27,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: ioctl.c,v 1.9 2003/01/14 07:53:34 roland Exp $
+ *	$Id: ioctl.c,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 #include "defs.h"
diff -ur strace-4.5/ioctlsort.c strace/ioctlsort.c
--- strace-4.5/ioctlsort.c	2001-03-17 12:26:34.000000000 -0500
+++ strace/ioctlsort.c	2003-11-14 06:32:22.000000000 -0500
@@ -25,7 +25,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: ioctlsort.c,v 1.2 2001/03/17 17:26:34 wichert Exp $
+ *	$Id: ioctlsort.c,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 
diff -ur strace-4.5/ipc.c strace/ipc.c
--- strace-4.5/ipc.c	2003-07-17 05:03:04.000000000 -0400
+++ strace/ipc.c	2003-11-14 06:32:22.000000000 -0500
@@ -27,7 +27,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: ipc.c,v 1.6 2003/07/17 09:03:04 roland Exp $
+ *	$Id: ipc.c,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 #include "defs.h"
diff -ur strace-4.5/linux/alpha/syscallent.h strace/linux/alpha/syscallent.h
--- strace-4.5/linux/alpha/syscallent.h	2003-07-09 05:47:59.000000000 -0400
+++ strace/linux/alpha/syscallent.h	2003-11-14 06:32:22.000000000 -0500
@@ -25,7 +25,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: syscallent.h,v 1.11 2003/07/09 09:47:59 roland Exp $
+ *	$Id: syscallent.h,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 	{ 6,	0,	printargs,		"osf_syscall"		}, /* 0, not implemented */
diff -ur strace-4.5/linux/dummy.h strace/linux/dummy.h
--- strace-4.5/linux/dummy.h	2003-06-27 17:20:10.000000000 -0400
+++ strace/linux/dummy.h	2003-11-14 06:32:22.000000000 -0500
@@ -25,7 +25,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: dummy.h,v 1.12 2003/06/27 21:20:10 roland Exp $
+ *	$Id: dummy.h,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 /* still unfinished */
diff -ur strace-4.5/linux/hppa/syscallent.h strace/linux/hppa/syscallent.h
--- strace-4.5/linux/hppa/syscallent.h	2003-05-22 20:29:00.000000000 -0400
+++ strace/linux/hppa/syscallent.h	2003-11-14 06:32:22.000000000 -0500
@@ -1,7 +1,7 @@
 /*
  * Copyright (c) 2001 Hewlett-Packard, Matthew Wilcox
  *
- * $Id: syscallent.h,v 1.8 2003/05/23 00:29:00 roland Exp $
+ * $Id: syscallent.h,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  *
  */
 
diff -ur strace-4.5/linux/ia64/syscallent.h strace/linux/ia64/syscallent.h
--- strace-4.5/linux/ia64/syscallent.h	2003-07-17 05:07:41.000000000 -0400
+++ strace/linux/ia64/syscallent.h	2003-11-14 06:32:22.000000000 -0500
@@ -25,7 +25,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: syscallent.h,v 1.15 2003/07/17 09:07:41 roland Exp $
+ *	$Id: syscallent.h,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 /*
diff -ur strace-4.5/linux/ioctlent.sh strace/linux/ioctlent.sh
--- strace-4.5/linux/ioctlent.sh	2003-03-30 20:03:34.000000000 -0500
+++ strace/linux/ioctlent.sh	2003-11-14 06:32:22.000000000 -0500
@@ -25,7 +25,7 @@
 # (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 # THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #
-#	$Id: ioctlent.sh,v 1.8 2003/03/31 01:03:34 roland Exp $
+#	$Id: ioctlent.sh,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
 #
 
 # Validate arg count.
diff -ur strace-4.5/linux/mips/ioctlent.sh strace/linux/mips/ioctlent.sh
--- strace-4.5/linux/mips/ioctlent.sh	1999-10-31 19:46:49.000000000 -0500
+++ strace/linux/mips/ioctlent.sh	2003-11-14 06:32:22.000000000 -0500
@@ -27,7 +27,7 @@
 # (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 # THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #
-#	$Id: ioctlent.sh,v 1.1 1999/11/01 00:46:49 wichert Exp $
+#	$Id: ioctlent.sh,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
 
 # Files to find.
 file_find='asm/*.h linux/*.h scsi/*.h'
diff -ur strace-4.5/linux/powerpc/syscallent.h strace/linux/powerpc/syscallent.h
--- strace-4.5/linux/powerpc/syscallent.h	2003-07-17 05:03:01.000000000 -0400
+++ strace/linux/powerpc/syscallent.h	2003-11-14 06:32:22.000000000 -0500
@@ -25,7 +25,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: syscallent.h,v 1.14 2003/07/17 09:03:01 roland Exp $
+ *	$Id: syscallent.h,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 	{ 5,	0,	printargs,		"SYS_0"			}, /* 0 */
diff -ur strace-4.5/linux/sh/syscallent.h strace/linux/sh/syscallent.h
--- strace-4.5/linux/sh/syscallent.h	2003-08-21 05:58:00.000000000 -0400
+++ strace/linux/sh/syscallent.h	2003-11-14 06:32:22.000000000 -0500
@@ -27,7 +27,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: syscallent.h,v 1.3 2003/08/21 09:58:00 roland Exp $
+ *	$Id: syscallent.h,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 	{ 0,	0,	sys_setup,		"setup"		}, /* 0 */
diff -ur strace-4.5/linux/sparc/dummy2.h strace/linux/sparc/dummy2.h
--- strace-4.5/linux/sparc/dummy2.h	1999-02-18 19:23:09.000000000 -0500
+++ strace/linux/sparc/dummy2.h	2003-11-14 06:32:22.000000000 -0500
@@ -24,7 +24,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: dummy2.h,v 1.1.1.1 1999/02/19 00:23:09 wichert Exp $
+ *	$Id: dummy2.h,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 /* still unfinished */
diff -ur strace-4.5/linux/sparc/syscall1.h strace/linux/sparc/syscall1.h
--- strace-4.5/linux/sparc/syscall1.h	1999-02-18 19:23:16.000000000 -0500
+++ strace/linux/sparc/syscall1.h	2003-11-14 06:32:22.000000000 -0500
@@ -24,7 +24,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: syscall1.h,v 1.1.1.1 1999/02/19 00:23:16 wichert Exp $
+ *	$Id: syscall1.h,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 #define	SOLARIS_syscall	0
diff -ur strace-4.5/linux/sparc/syscallent1.h strace/linux/sparc/syscallent1.h
--- strace-4.5/linux/sparc/syscallent1.h	1999-02-18 19:23:19.000000000 -0500
+++ strace/linux/sparc/syscallent1.h	2003-11-14 06:32:22.000000000 -0500
@@ -24,7 +24,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: syscallent1.h,v 1.1.1.1 1999/02/19 00:23:19 wichert Exp $
+ *	$Id: syscallent1.h,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 	{ 6,	0,	solaris_syscall,	"syscall"	}, /* 0 */
diff -ur strace-4.5/linux/sparc/syscall.h strace/linux/sparc/syscall.h
--- strace-4.5/linux/sparc/syscall.h	2003-01-30 15:15:20.000000000 -0500
+++ strace/linux/sparc/syscall.h	2003-11-14 06:32:22.000000000 -0500
@@ -25,7 +25,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: syscall.h,v 1.7 2003/01/30 20:15:20 roland Exp $
+ *	$Id: syscall.h,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 #include "dummy.h"
 
diff -ur strace-4.5/linux/sparc/syscall.h.2 strace/linux/sparc/syscall.h.2
--- strace-4.5/linux/sparc/syscall.h.2	1999-02-18 19:23:14.000000000 -0500
+++ strace/linux/sparc/syscall.h.2	2003-11-14 06:32:22.000000000 -0500
@@ -25,7 +25,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: syscall.h.2,v 1.1.1.1 1999/02/19 00:23:14 wichert Exp $
+ *	$Id: syscall.h.2,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 #include "dummy.h"
diff -ur strace-4.5/linux/syscallent.h strace/linux/syscallent.h
--- strace-4.5/linux/syscallent.h	2003-08-21 06:08:54.000000000 -0400
+++ strace/linux/syscallent.h	2003-11-14 06:32:22.000000000 -0500
@@ -25,7 +25,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: syscallent.h,v 1.22 2003/08/21 10:08:54 roland Exp $
+ *	$Id: syscallent.h,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 	{ 0,	0,	sys_setup,		"setup"		}, /* 0 */
diff -ur strace-4.5/linux/syscall.h strace/linux/syscall.h
--- strace-4.5/linux/syscall.h	2003-07-17 05:03:02.000000000 -0400
+++ strace/linux/syscall.h	2003-11-14 06:32:22.000000000 -0500
@@ -25,7 +25,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: syscall.h,v 1.32 2003/07/17 09:03:02 roland Exp $
+ *	$Id: syscall.h,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 #include "dummy.h"
Only in strace-4.5: Makefile.in
diff -ur strace-4.5/mem.c strace/mem.c
--- strace-4.5/mem.c	2003-06-26 18:40:42.000000000 -0400
+++ strace/mem.c	2003-12-05 10:43:43.000000000 -0500
@@ -29,7 +29,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: mem.c,v 1.28 2003/06/26 22:40:42 roland Exp $
+ *	$Id: mem.c,v 1.3 2003/12/05 15:43:43 ramsdell Exp $
  */
 
 #include "defs.h"
@@ -197,9 +197,10 @@
 		printflags(mmap_flags, u_arg[3]);
 #endif
 		/* fd (is always int, not long) */
-		tprintf(", %d, ", (int)u_arg[4]);
+		printargsep();
+		printdesc(u_arg[4]);
 		/* offset */
-		tprintf("%#lx", u_arg[5]);
+		tprintf(", %#lx", u_arg[5]);
 	}
 	return RVAL_HEX;
 }
@@ -298,7 +299,8 @@
 		printflags(mmap_flags, u_arg[3]);
 #endif
 		/* fd */
-		tprintf(", %ld, ", u_arg[4]);
+		printdesc(u_arg[4]);
+		printargsep();
 		/* offset */
 		tprintf("%#llx", LONG_LONG(u_arg[5], u_arg[6]));
 	}
Only in strace-4.5: missing
Only in strace-4.5: mkinstalldirs
diff -ur strace-4.5/net.c strace/net.c
--- strace-4.5/net.c	2003-06-23 19:39:59.000000000 -0400
+++ strace/net.c	2003-12-03 10:38:22.000000000 -0500
@@ -27,7 +27,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: net.c,v 1.34 2003/06/23 23:39:59 roland Exp $
+ *	$Id: net.c,v 1.2 2003/12/03 15:38:22 ramsdell Exp $
  */
 
 #include "defs.h"
@@ -940,7 +940,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+	        printdesc(tcp->u_arg[0]);
+		printargsep();
 		printsock(tcp, tcp->u_arg[1], tcp->u_arg[2]);
 		tprintf(", %lu", tcp->u_arg[2]);
 	}
@@ -959,7 +960,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, %lu", tcp->u_arg[0], tcp->u_arg[1]);
+  	        printdesc(tcp->u_arg[0]);
+	        tprintf(", %lu", tcp->u_arg[1]);
 	}
 	return 0;
 }
@@ -969,7 +971,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+  	        printdesc(tcp->u_arg[0]);
+		printargsep();
 	} else if (!tcp->u_arg[2])
 		tprintf("%#lx, NULL", tcp->u_arg[1]);
 	else {
@@ -989,7 +992,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		printargsep();
 		printstr(tcp, tcp->u_arg[1], tcp->u_arg[2]);
 		tprintf(", %lu, ", tcp->u_arg[2]);
 		/* flags */
@@ -1004,7 +1008,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		printargsep();
 		printstr(tcp, tcp->u_arg[1], tcp->u_arg[2]);
 		tprintf(", %lu, ", tcp->u_arg[2]);
 		/* flags */
@@ -1026,7 +1031,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		printargsep();
 		printmsghdr(tcp, tcp->u_arg[1]);
 		/* flags */
 		tprintf(", ");
@@ -1043,7 +1049,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		printargsep();
 	} else {
 		if (syserror(tcp))
 			tprintf("%#lx", tcp->u_arg[1]);
@@ -1064,7 +1071,8 @@
 	int fromlen;
 
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		printargsep();
 	} else {
 		if (syserror(tcp)) {
 			tprintf("%#lx, %lu, %lu, %#lx, %#lx",
@@ -1110,7 +1118,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		printargsep();
 	} else {
 		if (syserror(tcp) || !verbose(tcp))
 			tprintf("%#lx", tcp->u_arg[1]);
@@ -1131,7 +1140,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, %ld", tcp->u_arg[0], tcp->u_arg[1]);
+		printdesc(tcp->u_arg[0]);
+		tprintf(", %ld", tcp->u_arg[1]);
 		switch (tcp->u_arg[1]) {
 		case 0:
 			tprintf("%s", " /* receive */");
@@ -1176,8 +1186,13 @@
 		}
 		if (umoven(tcp, tcp->u_arg[0], sizeof fds, (char *) fds) < 0)
 			tprintf("[...]");
-		else
-			tprintf("[%u, %u]", fds[0], fds[1]);
+		else {
+ 		        tprintf("[");
+			printdesc(fds[0]);
+			printargsep();
+			printdesc(fds[1]);
+			tprintf("]");
+		}
 	}
 #elif defined(SPARC) || defined(SH) || defined(SVR4) || defined(FREEBSD)
 	if (exiting(tcp))
@@ -1238,7 +1253,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		printargsep();
 		printxval(socketlayers, tcp->u_arg[1], "SOL_???");
 		tprintf (", ");
 		switch (tcp->u_arg[1]) {
@@ -1471,7 +1487,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		printargsep();
 		printsockopt (tcp, tcp->u_arg[1], tcp->u_arg[2],
 			      tcp->u_arg[3], tcp->u_arg[4]);
 		tprintf(", %lu", tcp->u_arg[4]);
diff -ur strace-4.5/proc.c strace/proc.c
--- strace-4.5/proc.c	2000-09-01 17:03:06.000000000 -0400
+++ strace/proc.c	2003-11-14 06:32:22.000000000 -0500
@@ -24,7 +24,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: proc.c,v 1.5 2000/09/01 21:03:06 wichert Exp $
+ *	$Id: proc.c,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 #include "defs.h"
diff -ur strace-4.5/process.c strace/process.c
--- strace-4.5/process.c	2003-08-21 05:58:00.000000000 -0400
+++ strace/process.c	2003-12-05 11:02:41.000000000 -0500
@@ -34,7 +34,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: process.c,v 1.71 2003/08/21 09:58:00 roland Exp $
+ *	$Id: process.c,v 1.6 2003/12/05 16:02:41 ramsdell Exp $
  */
 
 #include "defs.h"
@@ -1298,7 +1298,7 @@
 {
 	if (entering(tcp)) {
 #ifndef SVR4
-		tprintf("%lu", tcp->u_arg[0]);
+		printpid(tcp->u_arg[0]);
 #endif /* !SVR4 */
 	}
 	return 0;
@@ -1309,7 +1309,7 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%lu", tcp->u_arg[0]);
+		printpid(tcp->u_arg[0]);
 	}
 	return 0;
 }
@@ -1326,7 +1326,7 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%lu", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
 	}
 	return 0;
 }
@@ -1336,7 +1336,9 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%lu, %lu", tcp->u_arg[0], tcp->u_arg[1]);
+		printpid(tcp->u_arg[0]);
+		printargsep();
+		printpid(tcp->u_arg[1]);
 	}
 	return 0;
 }
@@ -1714,7 +1716,8 @@
 	int exited = 0;
 
 	if (entering(tcp)) {
-		tprintf("%ld, ", tcp->u_arg[0]);
+		printpid(tcp->u_arg[0]);
+		tprintf(", ");
 	} else {
 		/* status */
 		if (!tcp->u_arg[1])
@@ -2755,7 +2758,9 @@
 			  "PT_???"
 #endif
 			);
-		tprintf(", %lu, ", tcp->u_arg[1]);
+		printargsep();
+		printpid(tcp->u_arg[1]);
+		tprintf(", ");
 		addr = tcp->u_arg[2];
 #ifndef FREEBSD
 		if (tcp->u_arg[0] == PTRACE_PEEKUSER
diff -ur strace-4.5/resource.c strace/resource.c
--- strace-4.5/resource.c	2003-01-14 18:40:54.000000000 -0500
+++ strace/resource.c	2003-11-14 06:32:22.000000000 -0500
@@ -27,7 +27,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: resource.c,v 1.9 2003/01/14 23:40:54 roland Exp $
+ *	$Id: resource.c,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 #include "defs.h"
diff -ur strace-4.5/signal.c strace/signal.c
--- strace-4.5/signal.c	2003-09-23 18:19:32.000000000 -0400
+++ strace/signal.c	2003-12-03 09:47:54.000000000 -0500
@@ -30,7 +30,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: signal.c,v 1.44 2003/09/23 22:19:32 roland Exp $
+ *	$Id: signal.c,v 1.3 2003/12/03 14:47:54 ramsdell Exp $
  */
 
 #include "defs.h"
@@ -1674,7 +1674,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%ld, %s", tcp->u_arg[0], signame(tcp->u_arg[1]));
+		printpid(tcp->u_arg[0]);
+		tprintf(", %s", signame(tcp->u_arg[1]));
 	}
 	return 0;
 }
diff -ur strace-4.5/signalent.sh strace/signalent.sh
--- strace-4.5/signalent.sh	1999-02-18 19:22:28.000000000 -0500
+++ strace/signalent.sh	2003-11-14 06:32:22.000000000 -0500
@@ -24,7 +24,7 @@
 # (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 # THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #
-#	$Id: signalent.sh,v 1.1.1.1 1999/02/19 00:22:28 wichert Exp $
+#	$Id: signalent.sh,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
 
 cat $* |
 	sed -n -e 's/\/\*.*\*\// /' -e 's/^#[ 	]*define[ 	][ 	]*SIG\([^_ 	]*\)[ 	][ 	]*\([0-9][0-9]*\)[ 	]*$/\1 \2/p' |
diff -ur strace-4.5/sock.c strace/sock.c
--- strace-4.5/sock.c	2003-06-26 18:40:42.000000000 -0400
+++ strace/sock.c	2003-11-14 06:32:22.000000000 -0500
@@ -24,7 +24,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: sock.c,v 1.6 2003/06/26 22:40:42 roland Exp $
+ *	$Id: sock.c,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 #include "defs.h"
diff -ur strace-4.5/strace.1 strace/strace.1
--- strace-4.5/strace.1	2003-01-23 23:31:20.000000000 -0500
+++ strace/strace.1	2003-11-14 06:32:22.000000000 -0500
@@ -25,7 +25,7 @@
 .\" (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 .\" THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 .\"
-.\"	$Id: strace.1,v 1.9 2003/01/24 04:31:20 roland Exp $
+.\"	$Id: strace.1,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
 .\"
 .de CW
 .sp
diff -ur strace-4.5/strace.c strace/strace.c
--- strace-4.5/strace.c	2003-06-09 23:05:53.000000000 -0400
+++ strace/strace.c	2003-12-05 10:43:43.000000000 -0500
@@ -27,7 +27,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: strace.c,v 1.49 2003/06/10 03:05:53 roland Exp $
+ *	$Id: strace.c,v 1.5 2003/12/05 15:43:43 ramsdell Exp $
  */
 
 #include <sys/types.h>
@@ -159,6 +159,7 @@
 -u username -- run command as username handling setuid and/or setgid\n\
 -E var=val -- put var=val in the environment for command\n\
 -E var -- remove var from the environment for command\n\
+-X -- print SELinux specific information when possible\n\
 " /* this is broken, so don't document it
 -z -- print only succeeding syscalls\n\
   */
@@ -175,6 +176,10 @@
 #endif /* MIPS */
 #endif /* SVR4 */
 
+#if defined SELINUX
+int selinux_enabled= 0;
+#endif
+
 int
 main(argc, argv)
 int argc;
@@ -205,7 +210,7 @@
 	set_sortby(DEFAULT_SORTBY);
 	set_personality(DEFAULT_PERSONALITY);
 	while ((c = getopt(argc, argv,
-		"+cdfFhiqrtTvVxza:e:o:O:p:s:S:u:E:")) != EOF) {
+		"+cdfFhiqrtTvVxXza:e:o:O:p:s:S:u:E:")) != EOF) {
 		switch (c) {
 		case 'c':
 			cflag++;
@@ -298,6 +303,14 @@
 				exit(1);
 			}
 			break;
+		case 'X':
+#if defined SELINUX
+			selinux_enabled = is_selinux_enabled();
+			break;
+#else
+			fprintf(stderr, "SELinux support not available\n");
+			exit(1);
+#endif
 		default:
 			usage(stderr, 1);
 			break;
@@ -2275,6 +2288,9 @@
 printtrailer(tcp)
 struct tcb *tcp;
 {
+#if defined SELINUX
+        selinux_printcon();
+#endif
 	tprintf("\n");
 	tcp_last = NULL;
 }
diff -ur strace-4.5/strace-graph strace/strace-graph
--- strace-4.5/strace-graph	1999-08-30 19:26:53.000000000 -0400
+++ strace/strace-graph	2003-11-14 06:32:22.000000000 -0500
@@ -33,7 +33,7 @@
 # (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 # THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #
-#	$Id: strace-graph,v 1.2 1999/08/30 23:26:53 wichert Exp $
+#	$Id: strace-graph,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
 
 my %unfinished;
 
diff -ur strace-4.5/stream.c strace/stream.c
--- strace-4.5/stream.c	2003-04-01 20:10:44.000000000 -0500
+++ strace/stream.c	2003-11-14 06:32:22.000000000 -0500
@@ -25,7 +25,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: stream.c,v 1.19 2003/04/02 01:10:44 roland Exp $
+ *	$Id: stream.c,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 #include "defs.h"
diff -ur strace-4.5/sunos4/dummy.h strace/sunos4/dummy.h
--- strace-4.5/sunos4/dummy.h	1999-02-18 19:23:34.000000000 -0500
+++ strace/sunos4/dummy.h	2003-11-14 06:32:22.000000000 -0500
@@ -25,7 +25,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: dummy.h,v 1.1.1.1 1999/02/19 00:23:34 wichert Exp $
+ *	$Id: dummy.h,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 /* Obsolete syscalls */
diff -ur strace-4.5/sunos4/ioctlent.sh strace/sunos4/ioctlent.sh
--- strace-4.5/sunos4/ioctlent.sh	1999-02-18 19:23:38.000000000 -0500
+++ strace/sunos4/ioctlent.sh	2003-11-14 06:32:22.000000000 -0500
@@ -24,7 +24,7 @@
 # (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 # THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #
-#	$Id: ioctlent.sh,v 1.1.1.1 1999/02/19 00:23:38 wichert Exp $
+#	$Id: ioctlent.sh,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
 
 if [ $# -ne 1 ]
 then
diff -ur strace-4.5/sunos4/syscallent.h strace/sunos4/syscallent.h
--- strace-4.5/sunos4/syscallent.h	1999-02-18 19:23:40.000000000 -0500
+++ strace/sunos4/syscallent.h	2003-11-14 06:32:22.000000000 -0500
@@ -25,7 +25,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: syscallent.h,v 1.1.1.1 1999/02/19 00:23:40 wichert Exp $
+ *	$Id: syscallent.h,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 	{ 1,	0,	sys_indir,		"indir"		}, /* 0 */
diff -ur strace-4.5/sunos4/syscall.h strace/sunos4/syscall.h
--- strace-4.5/sunos4/syscall.h	1999-02-18 19:23:39.000000000 -0500
+++ strace/sunos4/syscall.h	2003-11-14 06:32:22.000000000 -0500
@@ -25,7 +25,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: syscall.h,v 1.1.1.1 1999/02/19 00:23:39 wichert Exp $
+ *	$Id: syscall.h,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 #include "dummy.h"
 
diff -ur strace-4.5/svr4/dummy.h strace/svr4/dummy.h
--- strace-4.5/svr4/dummy.h	2002-05-17 07:37:50.000000000 -0400
+++ strace/svr4/dummy.h	2003-11-14 06:32:22.000000000 -0500
@@ -24,7 +24,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: dummy.h,v 1.11 2002/05/17 11:37:50 hughesj Exp $
+ *	$Id: dummy.h,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 /* still unfinished */
diff -ur strace-4.5/svr4/ioctlent.sh strace/svr4/ioctlent.sh
--- strace-4.5/svr4/ioctlent.sh	2002-05-17 10:04:24.000000000 -0400
+++ strace/svr4/ioctlent.sh	2003-11-14 06:32:22.000000000 -0500
@@ -24,7 +24,7 @@
 # (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 # THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #
-#	$Id: ioctlent.sh,v 1.4 2002/05/17 14:04:24 hughesj Exp $
+#	$Id: ioctlent.sh,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
 
 if [ $# -ne 1 ]
 then
diff -ur strace-4.5/svr4/syscallent.h strace/svr4/syscallent.h
--- strace-4.5/svr4/syscallent.h	2001-03-27 08:57:48.000000000 -0500
+++ strace/svr4/syscallent.h	2003-11-14 06:32:22.000000000 -0500
@@ -24,7 +24,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: syscallent.h,v 1.9 2001/03/27 13:57:48 hughesj Exp $
+ *	$Id: syscallent.h,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 #ifdef MIPS
diff -ur strace-4.5/svr4/syscall.h strace/svr4/syscall.h
--- strace-4.5/svr4/syscall.h	2002-05-17 07:37:50.000000000 -0400
+++ strace/svr4/syscall.h	2003-11-14 06:32:22.000000000 -0500
@@ -24,7 +24,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: syscall.h,v 1.10 2002/05/17 11:37:50 hughesj Exp $
+ *	$Id: syscall.h,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 #include "dummy.h"
diff -ur strace-4.5/syscall.c strace/syscall.c
--- strace-4.5/syscall.c	2003-09-24 18:22:41.000000000 -0400
+++ strace/syscall.c	2003-11-14 06:32:22.000000000 -0500
@@ -30,7 +30,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: syscall.c,v 1.58 2003/09/24 22:22:41 roland Exp $
+ *	$Id: syscall.c,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 #include "defs.h"
diff -ur strace-4.5/syscallent.sh strace/syscallent.sh
--- strace-4.5/syscallent.sh	2003-03-30 20:03:34.000000000 -0500
+++ strace/syscallent.sh	2003-11-14 06:32:22.000000000 -0500
@@ -24,7 +24,7 @@
 # (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 # THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 #
-#	$Id: syscallent.sh,v 1.3 2003/03/31 01:03:34 roland Exp $
+#	$Id: syscallent.sh,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
 
 cat ${1+"$@"} |
 	sed -n 's/^#[ 	]*define[ 	][ 	]*SYS_\([^ 	]*\)[ 	]*[^0-9]*\([0-9]*\).*$/\1 \2/p
diff -ur strace-4.5/system.c strace/system.c
--- strace-4.5/system.c	2002-11-06 09:00:13.000000000 -0500
+++ strace/system.c	2003-12-05 10:43:43.000000000 -0500
@@ -27,7 +27,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: system.c,v 1.27 2002/11/06 14:00:13 ludvigm Exp $
+ *	$Id: system.c,v 1.5 2003/12/05 15:43:43 ramsdell Exp $
  */
 
 #include "defs.h"
@@ -613,7 +613,8 @@
 struct tcb *tcp;
 {
 	if (entering(tcp)) {
-		tprintf("%lu, ", tcp->u_arg[0]);
+		printdesc(tcp->u_arg[0]);
+		printargsep();
 		printxval(pathconflimits, tcp->u_arg[1], "_PC_???");
 	}
 	return 0;
diff -ur strace-4.5/term.c strace/term.c
--- strace-4.5/term.c	2003-01-14 02:53:40.000000000 -0500
+++ strace/term.c	2003-11-14 06:32:22.000000000 -0500
@@ -24,7 +24,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: term.c,v 1.6 2003/01/14 07:53:40 roland Exp $
+ *	$Id: term.c,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 #include "defs.h"
diff -ur strace-4.5/time.c strace/time.c
--- strace-4.5/time.c	2003-03-30 18:52:28.000000000 -0500
+++ strace/time.c	2003-11-14 06:32:22.000000000 -0500
@@ -26,7 +26,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: time.c,v 1.5 2003/03/30 23:52:28 roland Exp $
+ *	$Id: time.c,v 1.1.1.1 2003/11/14 11:32:22 ramsdell Exp $
  */
 
 #include "defs.h"
diff -ur strace-4.5/util.c strace/util.c
--- strace-4.5/util.c	2003-06-26 18:40:42.000000000 -0400
+++ strace/util.c	2003-12-05 10:47:20.000000000 -0500
@@ -30,7 +30,7 @@
  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  *
- *	$Id: util.c,v 1.44 2003/06/26 22:40:42 roland Exp $
+ *	$Id: util.c,v 1.7 2003/12/05 15:47:20 ramsdell Exp $
  */
 
 #include "defs.h"
@@ -345,8 +345,12 @@
 {
 	if (umovestr(tcp, addr, MAXPATHLEN, path) < 0)
 		tprintf("%#lx", addr);
-	else
+	else {
 		string_quote(path);
+#if defined SELINUX
+		selinux_printpath(path);
+#endif
+	}
 	return;
 }
 
@@ -361,6 +365,9 @@
 	else {
 		path[n] = '\0';
 		string_quote(path);
+#if defined SELINUX
+		selinux_printpath(path);
+#endif
 	}
 }
 
@@ -972,11 +979,11 @@
 	if(upeek(tcp->pid,PT_IAOQ0,&pc) < 0)
 		return -1;
 #elif defined(SH)
-       if (upeek(tcp->pid, 4*REG_PC ,&pc) < 0)
-               return -1;
+	if (upeek(tcp->pid, 4*REG_PC ,&pc) < 0)
+		return -1;
 #elif defined(SH64)
-       if (upeek(tcp->pid, REG_PC ,&pc) < 0)
-               return -1;
+	if (upeek(tcp->pid, REG_PC ,&pc) < 0)
+		return -1;
 #endif
 	return pc;
 #endif /* LINUX */
@@ -1085,13 +1092,13 @@
 	}
 	tprintf("[%08lx] ", pc);
 #elif defined(SH)
-       long pc;
+	long pc;
 
-       if (upeek(tcp->pid, 4*REG_PC, &pc) < 0) {
-               tprintf ("[????????] ");
-               return;
-       }
-       tprintf("[%08lx] ", pc);
+	if (upeek(tcp->pid, 4*REG_PC, &pc) < 0) {
+		tprintf ("[????????] ");
+		return;
+	}
+	tprintf("[%08lx] ", pc);
 #elif defined(SH64)
 	long pc;
 
@@ -1246,7 +1253,7 @@
 #  define arg0_offset	(4*(REG_REG0+4))
 #  define arg1_offset	(4*(REG_REG0+5))
 # elif defined (SH64)
-   /* ABI defines arg0 & 1 in r2 & r3 */
+/* ABI defines arg0 & 1 in r2 & r3 */
 #  define arg0_offset   (REG_OFFSET+16)
 #  define arg1_offset   (REG_OFFSET+24)
 #  define restore_arg0(tcp, state, val) 0
@@ -1518,7 +1525,7 @@
 		return -1;
 #elif defined (M68K)
 	if (upeek(tcp->pid, 4*PT_PC, &tcp->baddr) < 0)
-	  return -1;
+		return -1;
 #elif defined (ALPHA)
 	return -1;
 #elif defined (ARM)
@@ -1536,8 +1543,8 @@
 		return -1;
 	tcp->baddr &= ~0x03;
 #elif defined(SH)
-       if (upeek(tcp->pid, 4*REG_PC, &tcp->baddr) < 0)
-               return -1;
+	if (upeek(tcp->pid, 4*REG_PC, &tcp->baddr) < 0)
+		return -1;
 #else
 #error unknown architecture
 #endif
@@ -1583,7 +1590,7 @@
 	}
 	tcp->baddr = regs.r_o7 + 8;
 	if (ptrace(PTRACE_READTEXT, tcp->pid, (char *)tcp->baddr,
-				sizeof tcp->inst, (char *)tcp->inst) < 0) {
+		   sizeof tcp->inst, (char *)tcp->inst) < 0) {
 		perror("setbpt: ptrace(PTRACE_READTEXT, ...)");
 		return -1;
 	}
@@ -1599,7 +1606,7 @@
 	 * Of cause, if we evaporate ourselves in the middle of all this...
 	 */
 	if (ptrace(PTRACE_WRITETEXT, tcp->pid, (char *) tcp->baddr,
-			sizeof loopdeloop, (char *) loopdeloop) < 0) {
+		   sizeof loopdeloop, (char *) loopdeloop) < 0) {
 		perror("setbpt: ptrace(PTRACE_WRITETEXT, ...)");
 		return -1;
 	}
@@ -1628,7 +1635,7 @@
 #elif defined(HPPA)
 	long iaoq;
 #elif defined(SH)
-       long pc;
+	long pc;
 #endif /* architecture */
 
 #ifdef SPARC
@@ -1669,7 +1676,7 @@
 			if (debug)
 				fprintf(stderr,
 					"NOTE: PC not at bpt (pc %#lx baddr %#lx)\n",
-						addr, tcp->baddr);
+					addr, tcp->baddr);
 			return 0;
 		}
 	} else {
@@ -1735,7 +1742,7 @@
 		if (debug)
 			fprintf(stderr,
 				"NOTE: PC not at bpt (pc %#lx baddr %#lx)\n",
-					eip, tcp->baddr);
+				eip, tcp->baddr);
 		return 0;
 	}
 #elif defined(X86_64)
@@ -1746,7 +1753,7 @@
 		if (debug)
 			fprintf(stderr,
 				"NOTE: PC not at bpt (pc %#lx baddr %#lx)\n",
-					eip, tcp->baddr);
+				eip, tcp->baddr);
 		return 0;
 	}
 #elif defined(POWERPC)
@@ -1798,8 +1805,8 @@
 	ptrace(PTRACE_POKEUSER, tcp->pid, (void *)PT_IAOQ0, iaoq);
 	ptrace(PTRACE_POKEUSER, tcp->pid, (void *)PT_IAOQ1, iaoq);
 #elif defined(SH)
-       if (upeek(tcp->pid, 4*REG_PC, &pc) < 0)
-               return -1;
+	if (upeek(tcp->pid, 4*REG_PC, &pc) < 0)
+		return -1;
         if (pc != tcp->baddr) {
                 /* The breakpoint has not been reached yet.  */
                 if (debug)
@@ -1824,7 +1831,7 @@
 		return -1;
 	}
 	if (ptrace(PTRACE_WRITETEXT, tcp->pid, (char *) tcp->baddr,
-				sizeof tcp->inst, (char *) tcp->inst) < 0) {
+		   sizeof tcp->inst, (char *) tcp->inst) < 0) {
 		perror("clearbtp: ptrace(PTRACE_WRITETEXT, ...)");
 		return -1;
 	}
@@ -1840,12 +1847,12 @@
 		return -1;
 	}
 	if ((regs.r_pc < tcp->baddr) ||
-				(regs.r_pc > tcp->baddr + 4)) {
+	    (regs.r_pc > tcp->baddr + 4)) {
 		/* The breakpoint has not been reached yet */
 		if (debug)
 			fprintf(stderr,
 				"NOTE: PC not at bpt (pc %#x baddr %#x)\n",
-					regs.r_pc, tcp->parent->baddr);
+				regs.r_pc, tcp->parent->baddr);
 		return 0;
 	}
 	if (regs.r_pc != tcp->baddr)
@@ -1926,7 +1933,7 @@
 		return -1;
 	}
 	if (umoven(tcp, (int)ld.ld_symbols+(int)N_TXTADDR(hdr),
-					(int)ld.ld_symb_size, strtab) < 0)
+		   (int)ld.ld_symb_size, strtab) < 0)
 		goto err;
 
 #if 0
@@ -1951,15 +1958,96 @@
 		 * memory alignment bugs in ptrace
 		 */
 		if (tload(pid, (int)ld.ld_symbols+(int)N_TXTADDR(hdr),
-					(int)ld.ld_symb_size, strtab) < 0)
+			  (int)ld.ld_symb_size, strtab) < 0)
 			goto err;
 
 	free(strtab);
 	return 0;
 
-err:
+ err:
 	free(strtab);
 	return -1;
 }
 
 #endif /* SUNOS4 */
+
+/* Additions to support SELinux */
+
+#if defined SELINUX
+
+static void 
+showcon(security_context_t *con, int rc)
+{
+	if (rc < 0)
+		tprintf(" <<\?\?\?>>");
+	else {
+		tprintf(" <<%s>>", *con);
+		freecon(*con);
+	}
+}
+
+void selinux_printcon()
+{
+	if (selinux_enabled) {
+		security_context_t con;
+		showcon(&con, getcon(&con));
+	}
+}
+
+void selinux_printpid(long pid)
+{
+	if (selinux_enabled && pid >= 0) {
+		security_context_t con;
+		showcon(&con, getpidcon((pid_t)pid, &con));
+	}
+}
+
+void selinux_printprevcon()
+{
+	if (selinux_enabled) {
+		security_context_t con;
+		showcon(&con, getprevcon(&con));
+	}
+}
+
+void selinux_printexeccon()
+{
+	if (selinux_enabled) {
+		security_context_t con;
+		showcon(&con, getexeccon(&con));
+	}
+}
+
+void selinux_printfscreatecon()
+{
+	if (selinux_enabled) {
+		security_context_t con;
+		showcon(&con, getfscreatecon(&con));
+	}
+}
+
+void selinux_printpath(const char *path)
+{
+	if (selinux_enabled) {
+		security_context_t con;
+		showcon(&con, getfilecon(path, &con));
+	}
+}
+
+void selinux_printlpath(const char *path)
+{
+	if (selinux_enabled) {
+		security_context_t con;
+		showcon(&con, lgetfilecon(path, &con));
+	}
+}
+
+void selinux_printdesc(long desc)
+{
+	if (selinux_enabled && desc >= 0) {
+		security_context_t con;
+		showcon(&con, fgetfilecon((int)desc, &con));
+	}
+}
+
+#endif

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
