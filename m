Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAHMhKJ3013830
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 17:43:20 -0500
Received: from atlrel8.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAHMgbKG025826
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 22:42:37 GMT
Message-Id: <20061117224333.829365000@hp.com>
References: <20061117223842.399078000@hp.com>
Date: Fri, 17 Nov 2006 17:38:47 -0500
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: jmorris@namei.org, Paul Moore <paul.moore@hp.com>
Subject: [PATCH 05/13] NetLabel: check for a CIPSOv4 option before we do call into the CIPSOv4 layer
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Paul Moore <paul.moore@hp.com>

Right now the NetLabel code always jumps into the CIPSOv4 layer to determine if
a CIPSO IP option is present.  However, we can do this check directly in the
NetLabel code by making use of the CIPSO_V4_OPTEXIST() macro which should save
us a function call in the common case of not having a CIPSOv4 option present.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 net/ipv4/cipso_ipv4.c        |    2 --
 net/netlabel/netlabel_kapi.c |    6 ++----
 2 files changed, 2 insertions(+), 6 deletions(-)

Index: net-2.6.20_netlabel-base-work/net/ipv4/cipso_ipv4.c
===================================================================
--- net-2.6.20_netlabel-base-work.orig/net/ipv4/cipso_ipv4.c
+++ net-2.6.20_netlabel-base-work/net/ipv4/cipso_ipv4.c
@@ -1436,8 +1436,6 @@ int cipso_v4_skbuff_getattr(const struct
 	u32 doi;
 	struct cipso_v4_doi *doi_def;
 
-	if (!CIPSO_V4_OPTEXIST(skb))
-		return -ENOMSG;
 	cipso_ptr = CIPSO_V4_OPTPTR(skb);
 	if (cipso_v4_cache_check(cipso_ptr, cipso_ptr[1], secattr) == 0)
 		return 0;
Index: net-2.6.20_netlabel-base-work/net/netlabel/netlabel_kapi.c
===================================================================
--- net-2.6.20_netlabel-base-work.orig/net/netlabel/netlabel_kapi.c
+++ net-2.6.20_netlabel-base-work/net/netlabel/netlabel_kapi.c
@@ -149,10 +149,8 @@ int netlbl_socket_getattr(const struct s
 int netlbl_skbuff_getattr(const struct sk_buff *skb,
 			  struct netlbl_lsm_secattr *secattr)
 {
-	int ret_val;
-
-	ret_val = cipso_v4_skbuff_getattr(skb, secattr);
-	if (ret_val == 0)
+	if (CIPSO_V4_OPTEXIST(skb) &&
+	    cipso_v4_skbuff_getattr(skb, secattr) == 0)
 		return 0;
 
 	return netlbl_unlabel_getattr(secattr);

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
