Message-ID: <461154EB.5080804@tycho.nsa.gov>
Date: Mon, 02 Apr 2007 15:09:31 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] libselinux: handle null SID's in sidput / sidget
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch makes it possible to sidput a userspace AVC SID in cleanup code
when the SID may never have been initialized.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

 avc_internal.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


Index: libselinux/src/avc_internal.h
===================================================================
--- libselinux/src/avc_internal.h	(revision 2318)
+++ libselinux/src/avc_internal.h	(working copy)
@@ -18,12 +18,12 @@
 /* SID reference counter manipulation */
 static inline int sid_inc_refcnt(security_id_t sid)
 {
-	return sid->refcnt = (sid->refcnt > 0) ? sid->refcnt + 1 : 0;
+	return sid->refcnt = (sid && sid->refcnt > 0) ? sid->refcnt + 1 : 0;
 }
 
 static inline int sid_dec_refcnt(security_id_t sid)
 {
-	return sid->refcnt = (sid->refcnt > 0) ? sid->refcnt - 1 : 0;
+	return sid->refcnt = (sid && sid->refcnt > 0) ? sid->refcnt - 1 : 0;
 }
 
 /* callback pointers */


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
