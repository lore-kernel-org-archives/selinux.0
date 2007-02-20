Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1KHuVFn004552
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 12:56:31 -0500
Received: from web51504.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1KHvmlw023893
	for <selinux@tycho.nsa.gov>; Tue, 20 Feb 2007 17:57:48 GMT
Message-ID: <20070220175747.16810.qmail@web51504.mail.yahoo.com>
Date: Tue, 20 Feb 2007 09:57:47 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: [PATCH] restorecond memory leaks
To: selinux@tycho.nsa.gov
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1498274122-1171994267=:16398"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-1498274122-1171994267=:16398
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,

Attached is a patch addressing memory leaks in restorecond. It still consumes way
too much memory, but this fixes all know leaks and valgrind now reports all
memory freed at exit.

Signed-off-by: Steve Grubb <linux_4ever@yahoo.com>




 
____________________________________________________________________________________
No need to miss a message. Get email on-the-go 
with Yahoo! Mail for Mobile. Get started.
http://mobile.yahoo.com/mail 
--0-1498274122-1171994267=:16398
Content-Type: text/x-patch; name="policycoreutils-2.0.1-memleak.patch"
Content-Description: 2292891528-policycoreutils-2.0.1-memleak.patch
Content-Disposition: inline; filename="policycoreutils-2.0.1-memleak.patch"

diff -urp policycoreutils-2.0.1.orig/restorecond/restorecond.c policycoreutils-2.0.1/restorecond/restorecond.c
--- policycoreutils-2.0.1.orig/restorecond/restorecond.c	2007-02-19 21:25:54.000000000 -0500
+++ policycoreutils-2.0.1/restorecond/restorecond.c	2007-02-20 12:50:29.000000000 -0500
@@ -483,6 +483,8 @@ int main(int argc, char **argv)
 
 	watch_list_free(master_fd);
 	close(master_fd);
+	matchpathcon_fini();
+	utmpwatcher_free();
 	if (pidfile)
 		unlink(pidfile);
 
diff -urp policycoreutils-2.0.1.orig/restorecond/utmpwatcher.c policycoreutils-2.0.1/restorecond/utmpwatcher.c
--- policycoreutils-2.0.1.orig/restorecond/utmpwatcher.c	2007-02-19 21:25:54.000000000 -0500
+++ policycoreutils-2.0.1/restorecond/utmpwatcher.c	2007-02-20 12:51:27.000000000 -0500
@@ -101,6 +101,12 @@ void utmpwatcher_add(int inotify_fd, con
 	watch_file(inotify_fd, path);
 }
 
+void utmpwatcher_free(void)
+{
+	if (utmp_ptr)
+		strings_list_free(utmp_ptr);
+}
+
 #ifdef TEST
 int main(int argc, char **argv)
 {
diff -urp policycoreutils-2.0.1.orig/restorecond/utmpwatcher.h policycoreutils-2.0.1/restorecond/utmpwatcher.h
--- policycoreutils-2.0.1.orig/restorecond/utmpwatcher.h	2007-02-19 21:25:54.000000000 -0500
+++ policycoreutils-2.0.1/restorecond/utmpwatcher.h	2007-02-20 12:50:09.000000000 -0500
@@ -25,5 +25,6 @@
 
 unsigned int utmpwatcher_handle(int inotify_fd, int wd);
 void utmpwatcher_add(int inotify_fd, const char *path);
+void utmpwatcher_free(void);
 
 #endif

--0-1498274122-1171994267=:16398--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
