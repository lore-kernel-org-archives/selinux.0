Subject: RE: [Announce][Patch] Enhanced MLS support
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Chad Hanson <chanson@tcs-sec.com>
Cc: "SE Linux (E-mail)" <SELinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>
In-Reply-To: <791924EBDA572C4FA970D4A94AA95DA309E3CE@chaos.tcs.tcs-sec.com>
References: <791924EBDA572C4FA970D4A94AA95DA309E3CE@chaos.tcs.tcs-sec.com>
Content-Type: text/plain
Message-Id: <1078341036.13948.154.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 03 Mar 2004 14:10:36 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-03-02 at 16:33, Chad Hanson wrote:
> I have attached a new version of the library function utilizing selinuxmnt.

Requires the additional diff below in order to compile.  Applied.

diff -X /home/sds/exclude -ru selinux-usr/libselinux/src/enabled.c selinux-usr-cvs/libselinux/src/enabled.c
--- selinux-usr/libselinux/src/enabled.c        2003-12-12 11:27:20.000000000 -0500
+++ selinux-usr-cvs/libselinux/src/enabled.c    2004-03-03 14:00:31.000000000 -0500
@@ -4,7 +4,10 @@
 #include <selinux/selinux.h>
 #include <stdlib.h>
 #include <errno.h>
+#include <limits.h>
 #include <asm/page.h>
+#include <stdio.h>
+#include "policy.h"
  
 int is_selinux_enabled(void)
 {


-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
