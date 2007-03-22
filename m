Message-ID: <4602EC58.2030603@redhat.com>
Date: Thu, 22 Mar 2007 16:51:36 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: stdint.h required in avc.h in order for other package builds to work.
  (uint32_t definition)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

ff --exclude-from=exclude -N -u -r nsalibselinux/include/selinux/avc.h 
libselinux-2.0.7/include/selinux/avc.h
--- nsalibselinux/include/selinux/avc.h    2007-02-20 08:43:13.000000000 
-0500
+++ libselinux-2.0.7/include/selinux/avc.h    2007-03-22 
16:48:42.000000000 -0400
@@ -6,6 +6,7 @@
 #ifndef _SELINUX_AVC_H_
 #define _SELINUX_AVC_H_
 
+#include <stdint.h>
 #include <sys/types.h>
 #include <errno.h>
 #include <stdlib.h>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
