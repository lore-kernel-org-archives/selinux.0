Date: Wed, 25 Jul 2007 12:10:53 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: selinux@tycho.nsa.gov
Subject: [patch] Update for libselinux embedded build support
Cc: ynakam@hitachisoft.jp, busybox@kaigai.gr.jp, sds@tycho.nsa.gov,
        ewalsh@tycho.nsa.gov
Message-Id: <20070725120139.6112.YNAKAM@hitachisoft.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi.

Recently, some userspace AVC features are merged to libselinux.
I found make EMBEDDED=y fails due to that.
So I've updated "make EMBEDDED=y" support for libselinux.

Index: libselinux/src/Makefile
===================================================================
--- libselinux/src/Makefile	(revision 2500)
+++ libselinux/src/Makefile	(working copy)
@@ -20,7 +20,7 @@
 LIBSO=$(TARGET).$(LIBVERSION)
 
 ifeq ($(DISABLE_AVC),y)
-	UNUSED_SRCS+=avc.c avc_internal.c avc_sidtab.c 
+	UNUSED_SRCS+=avc.c avc_internal.c avc_sidtab.c mapping.c stringrep.c checkAccess.c
 endif
 ifeq ($(DISABLE_BOOL),y)
 	UNUSED_SRCS+=booleans.c
Index: libselinux/src/compute_create.c
===================================================================
--- libselinux/src/compute_create.c	(revision 2500)
+++ libselinux/src/compute_create.c	(working copy)
@@ -36,7 +36,12 @@
 		ret = -1;
 		goto out;
 	}
+
+#ifdef DISABLE_AVC
+	snprintf(buf, size, "%s %s %hu", scon, tcon, tclass);
+#else
 	snprintf(buf, size, "%s %s %hu", scon, tcon, unmap_class(tclass));
+#endif
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)
Index: libselinux/src/compute_member.c
===================================================================
--- libselinux/src/compute_member.c	(revision 2500)
+++ libselinux/src/compute_member.c	(working copy)
@@ -36,7 +36,12 @@
 		ret = -1;
 		goto out;
 	}
+
+#ifdef DISABLE_AVC
+	snprintf(buf, size, "%s %s %hu", scon, tcon, tclass);
+#else
 	snprintf(buf, size, "%s %s %hu", scon, tcon, unmap_class(tclass));
+#endif
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)
Index: libselinux/src/compute_relabel.c
===================================================================
--- libselinux/src/compute_relabel.c	(revision 2500)
+++ libselinux/src/compute_relabel.c	(working copy)
@@ -36,7 +36,12 @@
 		ret = -1;
 		goto out;
 	}
+
+#ifdef DISABLE_AVC
+	snprintf(buf, size, "%s %s %hu", scon, tcon, tclass);
+#else
 	snprintf(buf, size, "%s %s %hu", scon, tcon, unmap_class(tclass));
+#endif
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)
Index: libselinux/src/compute_av.c
===================================================================
--- libselinux/src/compute_av.c	(revision 2500)
+++ libselinux/src/compute_av.c	(working copy)
@@ -37,8 +37,13 @@
 		goto out;
 	}
 
+#ifdef DISABLE_AVC
 	snprintf(buf, len, "%s %s %hu %x", scon, tcon,
+		 tclass, requested);
+#else
+	snprintf(buf, len, "%s %s %hu %x", scon, tcon,
 		 unmap_class(tclass), unmap_perm(tclass, requested));
+#endif
 
 	ret = write(fd, buf, strlen(buf));
 	if (ret < 0)
@@ -56,7 +61,9 @@
 		goto out2;
 	}
 
+#ifndef DISABLE_AVC
 	map_decision(tclass, avd);
+#endif
 
 	ret = 0;
       out2:
Index: libselinux/Makefile
===================================================================
--- libselinux/Makefile	(revision 2500)
+++ libselinux/Makefile	(working copy)
@@ -8,6 +8,9 @@
 	override DISABLE_RPM=y
 	override DISABLE_BOOL=y
 endif
+ifeq ($(DISABLE_AVC),y)
+	EMFLAGS+= -DDISABLE_AVC
+endif
 ifeq ($(DISABLE_BOOL),y)
 	EMFLAGS+= -DDISABLE_BOOL
 endif




Regards,
-- 
Yuichi Nakamura
Hitachi Software Engineering Co., Ltd.
Japan SELinux Users Group(JSELUG): http://www.selinux.gr.jp/
SELinux Policy Editor: http://seedit.sourceforge.net/


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
