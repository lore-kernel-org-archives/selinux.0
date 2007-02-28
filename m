From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070228202031.473078320@hp.com>
References: <20070228201419.115784233@hp.com>
Date: Wed, 28 Feb 2007 15:14:21 -0500
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, jmorris@namei.org, Paul Moore <paul.moore@hp.com>
Subject: [RFC 2/4] NetLabel: convert a BUG_ON in the CIPSO code to a runtime check
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch changes a BUG_ON in the CIPSO code to a runtime check.  It should
also increase the readability of the code as it replaces an unexplained
constant with a well defined macro.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 net/ipv4/cipso_ipv4.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: net-2.6_future/net/ipv4/cipso_ipv4.c
===================================================================
--- net-2.6_future.orig/net/ipv4/cipso_ipv4.c
+++ net-2.6_future/net/ipv4/cipso_ipv4.c
@@ -1141,7 +1141,9 @@ static int cipso_v4_map_cat_rng_hton(con
 	u32 cat_size = 0;
 
 	/* make sure we don't overflow the 'array[]' variable */
-	BUG_ON(net_cat_len > 30);
+	if (net_cat_len >
+	    (CIPSO_V4_OPT_LEN_MAX - CIPSO_V4_HDR_LEN - CIPSO_V4_TAG_RNG_BLEN))
+		return -ENOSPC;
 
 	for (;;) {
 		iter = netlbl_secattr_catmap_walk(secattr->mls_cat, iter + 1);

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
