Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBCGQjRb009596
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 11:26:45 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hBCGQhAH012392
	for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 16:26:43 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id hBCGQfZA012384 for <selinux@tycho.nsa.gov>; Fri, 12 Dec 2003 16:26:42 GMT
Subject: [patch] Change is_selinux_enabled()
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov, Daniel J Walsh <dwalsh@redhat.com>,
   Russell Coker <russell@coker.com.au>
Content-Type: multipart/mixed; boundary="=-xOLfMsJCY449gyXz0yry"
Message-Id: <1071246383.14716.93.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 12 Dec 2003 11:26:23 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-xOLfMsJCY449gyXz0yry
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patch changes is_selinux_enabled() to return -1 on errors. 
The possible failure cases are:
- Inability to open /proc/filesystems, either due to /proc
not being mounted or due to a SELinux permission denial to proc_t.
errno should be ENOENT in the former case or EACCES in the latter.
- Inability to allocate a buffer.  errno should be ENOMEM.
- Inability to read(2) from the open file for /proc/filesystems.  errno
could be any of the defined values for read(2) or possibly EACCES due to
a SELinux revocation after the open, although this is unlikely.

Note that this changes the default behavior of callers, which have been
treating is_selinux_enabled() as a simple boolean.  Previously, on such
errors, is_selinux_enabled() would have returned 0, and SELinux
processing in the application would have been disabled (possibly
wrongly, as any of these failures could occur on a SELinux system). 
Since is_selinux_enabled() will now return a non-zero value on such
errors, existing callers will default to attempting to perform the
SELinux processing.

Callers could be changed to test for error returns from
is_selinux_enabled(), but it isn't clear how they should proceed in such
cases, as there is no reliable way to determine whether or not SELinux
is truly enabled at that point.
 
-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-xOLfMsJCY449gyXz0yry
Content-Disposition: attachment; filename=enabled.patch
Content-Type: text/x-patch; name=enabled.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: selinux-usr/libselinux/src/enabled.c
diff -u selinux-usr/libselinux/src/enabled.c:1.6 selinux-usr/libselinux/src/enabled.c:1.7
--- selinux-usr/libselinux/src/enabled.c:1.6	Thu Nov 20 09:28:38 2003
+++ selinux-usr/libselinux/src/enabled.c	Fri Dec 12 10:27:45 2003
@@ -17,18 +17,22 @@
 
 	fd = open("/proc/filesystems", O_RDONLY);
 	if (fd < 0)
-		return 0;
+		return -1;
 
 	size = PAGE_SIZE;
 	buf = malloc(size);
-	if (!buf)
+	if (!buf) {
+		enabled = -1;
 		goto out;
+	}
 		
 	memset(buf, 0, size);
 
 	ret = read(fd, buf, size - 1);
-	if (ret < 0)
+	if (ret < 0) {
+		enabled = -1;
 		goto out2;
+	}
 
 	if (!strstr(buf, "selinuxfs"))
 		goto out2;

--=-xOLfMsJCY449gyXz0yry--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
