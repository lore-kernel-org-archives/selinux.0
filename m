Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAHMhPGb013935
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 17:43:25 -0500
Received: from atlrel7.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAHMfiUg029636
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 22:41:44 GMT
Message-Id: <20061117224335.464740000@hp.com>
References: <20061117223842.399078000@hp.com>
Date: Fri, 17 Nov 2006 17:38:50 -0500
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: jmorris@namei.org, Paul Moore <paul.moore@hp.com>
Subject: [PATCH 08/13] NetLabel: return the correct error for translated CIPSOv4 tags
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Paul Moore <paul.moore@hp.com>

The CIPSOv4 translated tag #1 mapping does not always return the correct error
code if the desired mapping does not exist; instead of returning -EPERM it
returns -ENOSPC indicating that the buffer is not large enough to hold the
translated value.  This was caused by failing to check a specific error
condition.  This patch fixes this so that unknown mappings return
-EPERM which is consistent with the rest of the related CIPSOv4 code.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 net/ipv4/cipso_ipv4.c |    4 ++++
 1 files changed, 4 insertions(+)

Index: net-2.6.20_netlabel-base-work/net/ipv4/cipso_ipv4.c
===================================================================
--- net-2.6.20_netlabel-base-work.orig/net/ipv4/cipso_ipv4.c
+++ net-2.6.20_netlabel-base-work/net/ipv4/cipso_ipv4.c
@@ -868,6 +868,8 @@ static int cipso_v4_map_cat_rbm_hton(con
 				return -EPERM;
 
 			net_spot = host_cat_array[host_spot];
+			if (net_spot >= CIPSO_V4_INV_CAT)
+				return -EPERM;
 			if (net_spot >= net_clen_bits)
 				return -ENOSPC;
 			cipso_v4_bitmap_setbit(net_cat, net_spot, 1);
@@ -936,6 +938,8 @@ static int cipso_v4_map_cat_rbm_ntoh(con
 				return -EPERM;
 
 			host_spot = net_cat_array[net_spot];
+			if (host_spot >= CIPSO_V4_INV_CAT)
+				return -EPERM;
 			if (host_spot >= host_clen_bits)
 				return -ENOSPC;
 			cipso_v4_bitmap_setbit(host_cat, host_spot, 1);

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
