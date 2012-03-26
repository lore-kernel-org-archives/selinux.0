Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QJgY1X024646
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 15:42:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 479321A15A
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 21:42:33 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u5o8M8wnYlCE for <selinux@tycho.nsa.gov>;
	Mon, 26 Mar 2012 21:42:31 +0200 (CEST)
Received: from fornost.bigon.be (fornost.bigon.be [IPv6:2001:6f8:303:1:226:18ff:fe08:6073])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id B4DE21A044
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 21:42:30 +0200 (CEST)
Date: Mon, 26 Mar 2012 21:42:27 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 2/8] setools -- Fix build failure with ld --as-needed
Message-ID: <20120326214227.1c7c7254@fornost.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

This patch fix FTBFS when passing --as-needed to ld.

The ordering of the flags and the libraries are important in that case.

Cheers,
Laurent Bigonville


Description: Fix build failure with ld --as-needed.
Author: Matthias Klose <doko@ubuntu.com>
Date: Sun, 05 Dec 2010 15:33:35 +0100
Bug-Debian: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=606020

--- setools-3.3.6.ds.orig/seaudit/Makefile.am
+++ setools-3.3.6.ds/seaudit/Makefile.am
@@ -12,10 +12,10 @@
 AM_LDFLAGS = @DEBUGLDFLAGS@ @WARNLDFLAGS@ @PROFILELDFLAGS@
 
 # need the -rdynamic flag below - glade uses dlopen() upon seaudit callbacks
-seaudit_LDFLAGS = $(AM_LDFLAGS) \
-	@GTK_LIBS@ @PIXBUF_LIBS@ @GLADE_LIBS@ @GTHREAD_LIBS@ -rdynamic
+seaudit_LDFLAGS = $(AM_LDFLAGS) -rdynamic
 
-LDADD = @SELINUX_LIB_FLAG@ @SEAUDIT_LIB_FLAG@ @APOL_LIB_FLAG@ @QPOL_LIB_FLAG@
+LDADD = @SELINUX_LIB_FLAG@ @SEAUDIT_LIB_FLAG@ @APOL_LIB_FLAG@ @QPOL_LIB_FLAG@ \
+	@GTK_LIBS@ @PIXBUF_LIBS@ @GLADE_LIBS@ @GTHREAD_LIBS@
 
 dist_setools_DATA = \
 	seaudit.glade \
only in patch2:
unchanged:
--- setools-3.3.6.ds.orig/sediff/Makefile.am
+++ setools-3.3.6.ds/sediff/Makefile.am
@@ -13,16 +13,15 @@
 	@QPOL_CFLAGS@ @APOL_CFLAGS@ @POLDIFF_CFLAGS@
 AM_LDFLAGS = @DEBUGLDFLAGS@ @WARNLDFLAGS@ @PROFILELDFLAGS@
 
-LDADD = @SELINUX_LIB_FLAG@ @POLDIFF_LIB_FLAG@ @APOL_LIB_FLAG@ @QPOL_LIB_FLAG@
+LDADD = @SELINUX_LIB_FLAG@ @POLDIFF_LIB_FLAG@ @APOL_LIB_FLAG@ @QPOL_LIB_FLAG@ \
+	@GTK_LIBS@ @PIXBUF_LIBS@ @GLADE_LIBS@ @GTHREAD_LIBS@ @XML_LIBS@
 
 sediff_CFLAGS = $(AM_CFLAGS)
 sediffx_CFLAGS = $(AM_CFLAGS) \
 	@GTK_CFLAGS@ @PIXBUF_CFLAGS@ @GLADE_CFLAGS@ @GTHREAD_CFLAGS@
 
 # need the -rdynamic flag below - glade uses dlopen() upon sediffx callbacks
-sediffx_LDFLAGS = $(AM_LDFLAGS) \
-	@GTK_LIBS@ @PIXBUF_LIBS@ @GLADE_LIBS@ @GTHREAD_LIBS@ @XML_LIBS@ \
-	-rdynamic
+sediffx_LDFLAGS = $(AM_LDFLAGS) -rdynamic
 
 DEPENDENCIES = $(top_builddir)/libpoldiff/src/libpoldiff.so \
 	$(top_builddir)/libapol/src/libapol.so \

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
