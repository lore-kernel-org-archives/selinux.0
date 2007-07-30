Date: Mon, 30 Jul 2007 10:22:54 +0900
From: Yuichi Nakamura <ynakam@hitachisoft.jp>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [patch] Update for libselinux embedded build support
Cc: ynakam@hitachisoft.jp, selinux@tycho.nsa.gov, busybox@kaigai.gr.jp,
        ewalsh@tycho.nsa.gov
In-Reply-To: <1185367660.2900.28.camel@moss-spartans.epoch.ncsc.mil>
References: <20070725120139.6112.YNAKAM@hitachisoft.jp> <1185367660.2900.28.camel@moss-spartans.epoch.ncsc.mil>
Message-Id: <20070730102119.CC6E.YNAKAM@hitachisoft.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 25 Jul 2007 08:47:40 -0400
Stephen Smalley wrote:
> On Wed, 2007-07-25 at 12:10 +0900, Yuichi Nakamura wrote:
...
> > Index: libselinux/src/compute_create.c
> > ===================================================================
> > --- libselinux/src/compute_create.c	(revision 2500)
> > +++ libselinux/src/compute_create.c	(working copy)
> > @@ -36,7 +36,12 @@
> >  		ret = -1;
> >  		goto out;
> >  	}
> > +
> > +#ifdef DISABLE_AVC
> > +	snprintf(buf, size, "%s %s %hu", scon, tcon, tclass);
> > +#else
> >  	snprintf(buf, size, "%s %s %hu", scon, tcon, unmap_class(tclass));
> > +#endif
> 
> As with the kernel, we don't want #ifdef's sprinkled through the code.
> Instead, just #define unmap_class(x) x and #define unmap_perm(x,y) y in
> mapping.h #ifdef DISABLE_AVC.
Fixed, below is updated patch.


Index: libselinux/src/Makefile
===================================================================
--- libselinux/src/Makefile	(revision 2502)
+++ libselinux/src/Makefile	(working copy)
@@ -20,7 +20,7 @@
 LIBSO=$(TARGET).$(LIBVERSION)
 
 ifeq ($(DISABLE_AVC),y)
-	UNUSED_SRCS+=avc.c avc_internal.c avc_sidtab.c 
+	UNUSED_SRCS+=avc.c avc_internal.c avc_sidtab.c mapping.c stringrep.c checkAccess.c
 endif
 ifeq ($(DISABLE_BOOL),y)
 	UNUSED_SRCS+=booleans.c
Index: libselinux/src/mapping.h
===================================================================
--- libselinux/src/mapping.h	(revision 2502)
+++ libselinux/src/mapping.h	(working copy)
@@ -31,4 +31,11 @@
 extern void
 map_decision(security_class_t tclass, struct av_decision *avd);
 
+/*mapping is not used for embedded build*/
+#ifdef DISABLE_AVC 
+#define unmap_perm(x,y) y
+#define unmap_class(x) x
+#define map_decision(x,y) 
+#endif
+
 #endif				/* _SELINUX_MAPPING_H_ */
Index: libselinux/Makefile
===================================================================
--- libselinux/Makefile	(revision 2502)
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
