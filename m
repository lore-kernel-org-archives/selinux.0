Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i09LQ1Rb002845
	for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 16:26:01 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i09LQ0iV022798
	for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 21:26:01 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id i09LQ006022795 for <selinux@tycho.nsa.gov>; Fri, 9 Jan 2004 21:26:00 GMT
Subject: Re: [PATCH][SELINUX] 2/7 Add netif controls
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>
Cc: James Morris <jmorris@redhat.com>, lkml <linux-kernel@vger.kernel.org>,
   selinux@tycho.nsa.gov
In-Reply-To: <20040109125718.5266c3f4.akpm@osdl.org>
References: <Xine.LNX.4.44.0401091009440.21309@thoron.boston.redhat.com>
	 <Xine.LNX.4.44.0401091012460.21309-100000@thoron.boston.redhat.com>
	 <20040109125718.5266c3f4.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1073683548.29816.174.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 09 Jan 2004 16:25:48 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-01-09 at 15:57, Andrew Morton wrote:
> The selinux makefiles seem a little unusual.  Can this not use the usual
> 
> 	obj-$(CONFIG_FOO) += bar.o
> 
> ?
> 
> Similarly, security/Makefile uses:
> 
> 	ifeq ($(CONFIG_SECURITY_SELINUX),y)
> 		obj-$(CONFIG_SECURITY_SELINUX)	+= selinux/built-in.o
> 	endif
> 
> why the `ifeq'?

Hmm...possible diff below against 2.6.1 for the security and selinux
makefiles.

Index: linux-2.6/security/Makefile
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/Makefile,v
retrieving revision 1.1.1.3
diff -u -r1.1.1.3 Makefile
--- linux-2.6/security/Makefile	29 Sep 2003 13:14:38 -0000	1.1.1.3
+++ linux-2.6/security/Makefile	9 Jan 2004 21:06:46 -0000
@@ -12,8 +12,6 @@
 # Object file lists
 obj-$(CONFIG_SECURITY)			+= security.o dummy.o
 # Must precede capability.o in order to stack properly.
-ifeq ($(CONFIG_SECURITY_SELINUX),y)
-	obj-$(CONFIG_SECURITY_SELINUX)	+= selinux/built-in.o
-endif
+obj-$(CONFIG_SECURITY_SELINUX)		+= selinux/built-in.o
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= commoncap.o capability.o
 obj-$(CONFIG_SECURITY_ROOTPLUG)		+= commoncap.o root_plug.o
Index: linux-2.6/security/selinux/Makefile
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/Makefile,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 Makefile
--- linux-2.6/security/selinux/Makefile	12 Aug 2003 13:05:04 -0000	1.1.1.1
+++ linux-2.6/security/selinux/Makefile	9 Jan 2004 21:06:08 -0000
@@ -4,7 +4,9 @@
 
 obj-$(CONFIG_SECURITY_SELINUX) := selinux.o ss/
 
-selinux-objs := avc.o hooks.o selinuxfs.o
+selinux-y := avc.o hooks.o selinuxfs.o
+
+selinux-$(CONFIG_SECURITY_NETWORK) += netif.o
 
 EXTRA_CFLAGS += -Isecurity/selinux/include
 
Index: linux-2.6/security/selinux/ss/Makefile
===================================================================
RCS file: /nfshome/pal/CVS/linux-2.6/security/selinux/ss/Makefile,v
retrieving revision 1.1.1.2
diff -u -r1.1.1.2 Makefile
--- linux-2.6/security/selinux/ss/Makefile	9 Jan 2004 14:24:58 -0000	1.1.1.2
+++ linux-2.6/security/selinux/ss/Makefile	9 Jan 2004 21:06:15 -0000
@@ -5,9 +5,7 @@
 EXTRA_CFLAGS += -Isecurity/selinux/include
 obj-y := ss.o
 
-ss-objs := ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o
+ss-y := ebitmap.o hashtab.o symtab.o sidtab.o avtab.o policydb.o services.o
 
-ifeq ($(CONFIG_SECURITY_SELINUX_MLS),y)
-ss-objs += mls.o
-endif
+ss-$(CONFIG_SECURITY_SELINUX_MLS) += mls.o
 

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
