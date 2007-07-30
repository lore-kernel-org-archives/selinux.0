Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6UKZ6ui018976
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2007 16:35:06 -0400
Received: from atlrel8.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l6UKZ5T4004335
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2007 20:35:05 GMT
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.11.136.114])
	by atlrel8.hp.com (Postfix) with ESMTP id 6E6363465B
	for <selinux@tycho.nsa.gov>; Mon, 30 Jul 2007 16:35:03 -0400 (EDT)
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070730203331.970255822@hp.com>
Date: Mon, 30 Jul 2007 16:33:26 -0400
To: selinux@tycho.nsa.gov
Subject: [PATCH] SELinux: restore proper NetLabel caching behavior
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A small fix to the SELinux/NetLabel glue code to ensure that the NetLabel
cache is utilized when possible.  This was broken when the SELinux/NetLabel
glue code was reorganized in the last kernel release.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 include/net/netlabel.h      |    2 ++
 security/selinux/netlabel.c |   16 ++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

Index: linux-2.6_netlabel-cache-fix-2/include/net/netlabel.h
===================================================================
--- linux-2.6_netlabel-cache-fix-2.orig/include/net/netlabel.h
+++ linux-2.6_netlabel-cache-fix-2/include/net/netlabel.h
@@ -132,6 +132,8 @@ struct netlbl_lsm_secattr_catmap {
 #define NETLBL_SECATTR_CACHE            0x00000002
 #define NETLBL_SECATTR_MLS_LVL          0x00000004
 #define NETLBL_SECATTR_MLS_CAT          0x00000008
+#define NETLBL_SECATTR_CACHEABLE        (NETLBL_SECATTR_MLS_LVL | \
+					 NETLBL_SECATTR_MLS_CAT)
 struct netlbl_lsm_secattr {
 	u32 flags;
 
Index: linux-2.6_netlabel-cache-fix-2/security/selinux/netlabel.c
===================================================================
--- linux-2.6_netlabel-cache-fix-2.orig/security/selinux/netlabel.c
+++ linux-2.6_netlabel-cache-fix-2/security/selinux/netlabel.c
@@ -162,9 +162,13 @@ int selinux_netlbl_skbuff_getsid(struct 
 
 	netlbl_secattr_init(&secattr);
 	rc = netlbl_skbuff_getattr(skb, &secattr);
-	if (rc == 0 && secattr.flags != NETLBL_SECATTR_NONE)
+	if (rc == 0 && secattr.flags != NETLBL_SECATTR_NONE) {
 		rc = security_netlbl_secattr_to_sid(&secattr, base_sid, sid);
-	else
+		if (rc == 0 &&
+		    (secattr.flags & NETLBL_SECATTR_CACHEABLE) &&
+		    (secattr.flags & NETLBL_SECATTR_CACHE))
+			netlbl_cache_add(skb, &secattr);
+	} else
 		*sid = SECSID_NULL;
 	netlbl_secattr_destroy(&secattr);
 
@@ -307,11 +311,15 @@ int selinux_netlbl_sock_rcv_skb(struct s
 
 	netlbl_secattr_init(&secattr);
 	rc = netlbl_skbuff_getattr(skb, &secattr);
-	if (rc == 0 && secattr.flags != NETLBL_SECATTR_NONE)
+	if (rc == 0 && secattr.flags != NETLBL_SECATTR_NONE) {
 		rc = security_netlbl_secattr_to_sid(&secattr,
 						    SECINITSID_NETMSG,
 						    &nlbl_sid);
-	else
+		if (rc == 0 &&
+		    (secattr.flags & NETLBL_SECATTR_CACHEABLE) &&
+		    (secattr.flags & NETLBL_SECATTR_CACHE))
+			netlbl_cache_add(skb, &secattr);
+	} else
 		nlbl_sid = SECINITSID_UNLABELED;
 	netlbl_secattr_destroy(&secattr);
 	if (rc != 0)

-- 
paul moore
linux security @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
