Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6IDFHHa003630
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2003 09:15:18 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6IDEEFB016808
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2003 13:14:14 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
	by jazzswing.ncsc.mil  with ESMTP id h6IDEEGD016805
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2003 13:14:14 GMT
Received: from moss-huskers.epoch.ncsc.mil (moss-huskers [144.51.25.140])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6IDFFLX005804
	for <selinux@tycho.nsa.gov>; Fri, 18 Jul 2003 09:15:15 -0400 (EDT)
Subject: [patch] null byte pad for contexts in libselinux
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov
Content-Type: multipart/mixed; boundary="=-tL4HjDy/CPm7hX9Hriu5"
Message-Id: <1058534114.1064.86.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 18 Jul 2003 09:15:15 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-tL4HjDy/CPm7hX9Hriu5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The attached patch, also committed to the sourceforge CVS tree,
addresses Albert Cahalan's observation that you could end up with a
context that doesn't include the null terminator.  In the SELinux case,
the kernel always includes the null terminator except possibly in the
*getfilecon functions due to a change we made to the SELinux kernel code
to accomodate the optional use of the existing attr utilities to
manipulate the file contexts.  

The setfattr utility does not ordinarily include the null byte
terminator as part of the attribute value when calling setxattr (unless 
you explicit include it in the string argument for -v), so the
SELinux kernel code was modified to accept such attribute values,
extending them with a null byte internally before converting them into a
SID for internal use.  The null byte is not stored in that case, as the
LSM hooks are limited to access control, not content filtering.  Hence,
someone using setfattr to set an attribute value could result in a
subsequent getxattr (which is what getfilecon calls) on that file to
return a context without the null terminator included.  To actually
trigger the bug, a person would have to be able to construct a valid
context that is at least as long as the initial buffer used by
getfilecon (255 bytes) and would have to be allowed
to call setxattr on a file with that context (i.e. relabelfrom and
relabelto permissions to the old and new file contexts) that is later
used by a target process that calls getfilecon on it.  The patch
ensures that an extra null byte is always left at the end of the
buffer.  

It would also be possible to revert the SELinux kernel code to simply
deny attempts to call setxattr with a context that does not include the
null terminator, but that would break common usage of the attr utilities
and is likely undesirable. 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

--=-tL4HjDy/CPm7hX9Hriu5
Content-Disposition: attachment; filename=nullbyte.patch
Content-Type: text/x-patch; name=nullbyte.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: libselinux/src/compute_av.c
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-2.5/libselinux/src/compute_av.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 compute_av.c
--- libselinux/src/compute_av.c	14 Jul 2003 17:11:31 -0000	1.1.1.1
+++ libselinux/src/compute_av.c	17 Jul 2003 14:49:01 -0000
@@ -37,7 +37,7 @@
 		goto out2;
 
 	memset(buf, 0, len);
-	ret = read(fd, buf, len);
+	ret = read(fd, buf, len-1);
 	if (ret < 0)
 		goto out2;
 
Index: libselinux/src/compute_create.c
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-2.5/libselinux/src/compute_create.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 compute_create.c
--- libselinux/src/compute_create.c	14 Jul 2003 17:11:31 -0000	1.1.1.1
+++ libselinux/src/compute_create.c	17 Jul 2003 14:49:01 -0000
@@ -35,7 +35,7 @@
 		goto out2;
 
 	memset(buf, 0, size);
-	ret = read(fd, buf, size);
+	ret = read(fd, buf, size-1);
 	if (ret < 0)
 		goto out2;
 
Index: libselinux/src/compute_relabel.c
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-2.5/libselinux/src/compute_relabel.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 compute_relabel.c
--- libselinux/src/compute_relabel.c	14 Jul 2003 17:11:31 -0000	1.1.1.1
+++ libselinux/src/compute_relabel.c	17 Jul 2003 14:49:01 -0000
@@ -35,7 +35,7 @@
 		goto out2;
 
 	memset(buf, 0, size);
-	ret = read(fd, buf, size);
+	ret = read(fd, buf, size-1);
 	if (ret < 0)
 		goto out2;
 
Index: libselinux/src/compute_user.c
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-2.5/libselinux/src/compute_user.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 compute_user.c
--- libselinux/src/compute_user.c	14 Jul 2003 17:11:31 -0000	1.1.1.1
+++ libselinux/src/compute_user.c	17 Jul 2003 14:49:01 -0000
@@ -36,7 +36,7 @@
 		goto out2;
 
 	memset(buf, 0, size);
-	ret = read(fd, buf, size);
+	ret = read(fd, buf, size-1);
 	if (ret < 0)
 		goto out2;
 
Index: libselinux/src/fgetfilecon.c
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-2.5/libselinux/src/fgetfilecon.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 fgetfilecon.c
--- libselinux/src/fgetfilecon.c	14 Jul 2003 17:11:31 -0000	1.1.1.1
+++ libselinux/src/fgetfilecon.c	17 Jul 2003 14:49:01 -0000
@@ -13,13 +13,13 @@
 	size_t size;
 	ssize_t ret;
 
-	size = INITCONTEXTLEN;
+	size = INITCONTEXTLEN+1;
 	buf = malloc(size);
 	if (!buf) 
 		return -1;
 	memset(buf, 0, size);
 
-	ret = fgetxattr(fd, XATTR_NAME_SELINUX, buf, size);
+	ret = fgetxattr(fd, XATTR_NAME_SELINUX, buf, size-1);
 	if (ret < 0 && errno == ERANGE) {
 		char *newbuf;
 
@@ -27,13 +27,14 @@
 		if (size < 0)
 			goto out;
 
+		size++;
 		newbuf = realloc(buf, size);
 		if (!newbuf)
 			goto out;
 
 		buf = newbuf;
 		memset(buf, 0, size);
-		ret = fgetxattr(fd, XATTR_NAME_SELINUX, buf, size); 
+		ret = fgetxattr(fd, XATTR_NAME_SELINUX, buf, size-1); 
 	}
 out:			
 	if (ret < 0)
Index: libselinux/src/getcon.c
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-2.5/libselinux/src/getcon.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 getcon.c
--- libselinux/src/getcon.c	14 Jul 2003 17:11:31 -0000	1.1.1.1
+++ libselinux/src/getcon.c	17 Jul 2003 14:49:01 -0000
@@ -26,7 +26,7 @@
 	}
 	memset(buf, 0, size);
 
-	ret = read(fd, buf, size);
+	ret = read(fd, buf, size-1);
 	if (ret < 0)
 		goto out2;
 
Index: libselinux/src/getexeccon.c
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-2.5/libselinux/src/getexeccon.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 getexeccon.c
--- libselinux/src/getexeccon.c	14 Jul 2003 17:11:31 -0000	1.1.1.1
+++ libselinux/src/getexeccon.c	17 Jul 2003 14:49:01 -0000
@@ -26,7 +26,7 @@
 	}
 	memset(buf, 0, size);
 
-	ret = read(fd, buf, size);
+	ret = read(fd, buf, size-1);
 	if (ret < 0)
 		goto out2;
 
Index: libselinux/src/getfilecon.c
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-2.5/libselinux/src/getfilecon.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 getfilecon.c
--- libselinux/src/getfilecon.c	14 Jul 2003 17:11:31 -0000	1.1.1.1
+++ libselinux/src/getfilecon.c	17 Jul 2003 14:49:01 -0000
@@ -13,13 +13,13 @@
 	size_t size;
 	ssize_t ret;
 
-	size = INITCONTEXTLEN;
+	size = INITCONTEXTLEN+1;
 	buf = malloc(size);
 	if (!buf) 
 		return -1;
 	memset(buf, 0, size);
 
-	ret = getxattr(path, XATTR_NAME_SELINUX, buf, size);
+	ret = getxattr(path, XATTR_NAME_SELINUX, buf, size-1);
 	if (ret < 0 && errno == ERANGE) {
 		char *newbuf;
 
@@ -27,13 +27,14 @@
 		if (size < 0)
 			goto out;
 
+		size++;
 		newbuf = realloc(buf, size);
 		if (!newbuf)
 			goto out;
 
 		buf = newbuf;
 		memset(buf, 0, size);
-		ret = getxattr(path, XATTR_NAME_SELINUX, buf, size); 
+		ret = getxattr(path, XATTR_NAME_SELINUX, buf, size-1); 
 	}
 out:			
 	if (ret < 0)
Index: libselinux/src/getfscreatecon.c
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-2.5/libselinux/src/getfscreatecon.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 getfscreatecon.c
--- libselinux/src/getfscreatecon.c	14 Jul 2003 17:11:31 -0000	1.1.1.1
+++ libselinux/src/getfscreatecon.c	17 Jul 2003 14:49:01 -0000
@@ -26,7 +26,7 @@
 	}
 	memset(buf, 0, size);
 
-	ret = read(fd, buf, size);
+	ret = read(fd, buf, size-1);
 	if (ret < 0)
 		goto out2;
 
Index: libselinux/src/getpidcon.c
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-2.5/libselinux/src/getpidcon.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 getpidcon.c
--- libselinux/src/getpidcon.c	14 Jul 2003 17:11:31 -0000	1.1.1.1
+++ libselinux/src/getpidcon.c	17 Jul 2003 14:49:01 -0000
@@ -30,7 +30,7 @@
 	}
 	memset(buf, 0, size);
 
-	ret = read(fd, buf, size);
+	ret = read(fd, buf, size-1);
 	if (ret < 0)
 		goto out2;
 
Index: libselinux/src/getprevcon.c
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-2.5/libselinux/src/getprevcon.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 getprevcon.c
--- libselinux/src/getprevcon.c	14 Jul 2003 17:11:31 -0000	1.1.1.1
+++ libselinux/src/getprevcon.c	17 Jul 2003 14:49:01 -0000
@@ -26,7 +26,7 @@
 	}
 	memset(buf, 0, size);
 
-	ret = read(fd, buf, size);
+	ret = read(fd, buf, size-1);
 	if (ret < 0)
 		goto out2;
 
Index: libselinux/src/lgetfilecon.c
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-2.5/libselinux/src/lgetfilecon.c,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 lgetfilecon.c
--- libselinux/src/lgetfilecon.c	14 Jul 2003 17:11:31 -0000	1.1.1.1
+++ libselinux/src/lgetfilecon.c	17 Jul 2003 14:49:01 -0000
@@ -13,13 +13,13 @@
 	size_t size;
 	ssize_t ret;
 
-	size = INITCONTEXTLEN;
+	size = INITCONTEXTLEN+1;
 	buf = malloc(size);
 	if (!buf) 
 		return -1;
 	memset(buf, 0, size);
 
-	ret = lgetxattr(path, XATTR_NAME_SELINUX, buf, size);
+	ret = lgetxattr(path, XATTR_NAME_SELINUX, buf, size-1);
 	if (ret < 0 && errno == ERANGE) {
 		char *newbuf;
 
@@ -27,13 +27,14 @@
 		if (size < 0)
 			goto out;
 
+		size++;
 		newbuf = realloc(buf, size);
 		if (!newbuf)
 			goto out;
 
 		buf = newbuf;
 		memset(buf, 0, size);
-		ret = lgetxattr(path, XATTR_NAME_SELINUX, buf, size); 
+		ret = lgetxattr(path, XATTR_NAME_SELINUX, buf, size-1); 
 	}
 out:			
 	if (ret < 0)

--=-tL4HjDy/CPm7hX9Hriu5--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
