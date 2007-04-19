Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3JHuQiV007109
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 13:56:27 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l3JHuPuv018471
	for <selinux@tycho.nsa.gov>; Thu, 19 Apr 2007 17:56:25 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: [PATCH] avc_internal.c needs #include <linux/types.h> for rhel4
Date: Thu, 19 Apr 2007 13:56:23 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588A71731@exchange.columbia.tresys.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Cc: "Stephen Smalley" <sds@epoch.ncsc.mil>,
        "Karl MacMillan" <kmacmill@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Apparently RHEL4 needs #include <linux/types.h> in avc_internal.c in
order to compile. This should be applied to trunk and stable.

===================================================================
--- libselinux/src/avc_internal.c       (revision 2357)
+++ libselinux/src/avc_internal.c       (working copy)
@@ -17,6 +17,7 @@
 #include <string.h>
 #include <sys/types.h>
 #include <sys/socket.h>
+#include <linux/types.h>
 #include <linux/netlink.h>
 #include "selinux_netlink.h"
 #include "avc_internal.h"


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
