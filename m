Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7QMpFrT016642
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2004 18:51:15 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7QMoSfU001676
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2004 22:50:28 GMT
Date: Fri, 27 Aug 2004 00:02:21 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Greg KH <greg@kroah.com>, Bill Nottingham <notting@redhat.com>,
   harald@redhat.com, SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   linux-hotplug-devel@lists.sourceforge.net
Subject: Re: Cleaned up udev-selinux patch
Message-ID: <20040826230221.GE6058@lkcl.net>
References: <20040223213614.GA12242@devserv.devel.redhat.com> <20040224233859.GA3265@kroah.com> <20040224234652.GA14775@devserv.devel.redhat.com> <403C8AE4.10403@redhat.com> <20040228005300.GA13860@kroah.com> <412DFE7B.6060409@redhat.com> <20040826155716.GA30726@kroah.com> <412E20AF.7000102@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <412E20AF.7000102@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Aug 26, 2004 at 01:41:03PM -0400, Daniel J Walsh wrote:

like this:


--- /dev/null	2004-06-21 15:29:38.000000000 -0400
+++ udev-030/selinux.h	2004-08-26 13:14:05.730808665 -0400
@@ -0,0 +1,87 @@
+#ifndef SELINUX_H
+#define SELINUX_H
+
+#ifndef USE_SELINUX
+#define set_selinux_set_context(file, mode)     do { } while (0)
+#define selinux_setup_context(file, mode)       do { } while (0)
+#define selinux_init()                          do { } while (0)
+#define selinux_restore()                       do { } while (0)
+
+#else
+
+#define set_selinux_set_context real_set_selinux_context
+#define set_selinux_setup_context real_set_setup_context
+...

--- /dev/null	2004-06-21 15:29:38.000000000 -0400
+++ udev-030/selinux.c	2004-08-26 13:14:05.730808665 -0400

+#include <selinux/selinux.h>
+
+static int selinux_enabled=-1;
+static security_context_t prev_scontext=NULL;
+
+#undef is_selinux_running
+static inline int is_selinux_running(void) {
+	if ( selinux_enabled==-1 ) 
+		return selinux_enabled=is_selinux_enabled()>0;
+	return selinux_enabled;
+}
+#undef selinux_set_context
+void real_selinux_set_context(char *file, unsigned int mode) { 
      ^^^^

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
