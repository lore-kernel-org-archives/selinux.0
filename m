Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBFLq0AI024325
	for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2006 16:52:00 -0500
Received: from atlrel8.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBFLqW2A000819
	for <selinux@tycho.nsa.gov>; Fri, 15 Dec 2006 21:52:32 GMT
Message-Id: <20061215215229.660129000@hp.com>
References: <20061215214926.018950000@hp.com>
Date: Fri, 15 Dec 2006 16:49:28 -0500
From: paul.moore@hp.com
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 2/2] NetLabel: correctly fill in unused CIPSOv4 level and category mappings
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

From: Paul Moore <paul.moore@hp.com>

Back when the original NetLabel patches were being changed to use Netlink
attributes correctly some code was accidentially dropped which set all of the
undefined CIPSOv4 level and category mappings to a sentinel value.  The result
is the mappings data in the kernel contains bogus mappings which always map to
zero.  This patch restores the old/correct behavior by initializing the mapping
data to the correct sentinel value.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 net/netlabel/netlabel_cipso_v4.c |    9 +++++++++
 1 files changed, 9 insertions(+)

Index: net-2.6.20_bugfix/net/netlabel/netlabel_cipso_v4.c
===================================================================
--- net-2.6.20_bugfix.orig/net/netlabel/netlabel_cipso_v4.c
+++ net-2.6.20_bugfix/net/netlabel/netlabel_cipso_v4.c
@@ -162,6 +162,7 @@ static int netlbl_cipsov4_add_std(struct
 	struct nlattr *nla_b;
 	int nla_a_rem;
 	int nla_b_rem;
+	u32 iter;
 
 	if (!info->attrs[NLBL_CIPSOV4_A_TAGLST] ||
 	    !info->attrs[NLBL_CIPSOV4_A_MLSLVLLST])
@@ -231,6 +232,10 @@ static int netlbl_cipsov4_add_std(struct
 		ret_val = -ENOMEM;
 		goto add_std_failure;
 	}
+	for (iter = 0; iter < doi_def->map.std->lvl.local_size; iter++)
+		doi_def->map.std->lvl.local[iter] = CIPSO_V4_INV_LVL;
+	for (iter = 0; iter < doi_def->map.std->lvl.cipso_size; iter++)
+		doi_def->map.std->lvl.cipso[iter] = CIPSO_V4_INV_LVL;
 	nla_for_each_nested(nla_a,
 			    info->attrs[NLBL_CIPSOV4_A_MLSLVLLST],
 			    nla_a_rem)
@@ -302,6 +307,10 @@ static int netlbl_cipsov4_add_std(struct
 			ret_val = -ENOMEM;
 			goto add_std_failure;
 		}
+		for (iter = 0; iter < doi_def->map.std->cat.local_size; iter++)
+			doi_def->map.std->cat.local[iter] = CIPSO_V4_INV_CAT;
+		for (iter = 0; iter < doi_def->map.std->cat.cipso_size; iter++)
+			doi_def->map.std->cat.cipso[iter] = CIPSO_V4_INV_CAT;
 		nla_for_each_nested(nla_a,
 				    info->attrs[NLBL_CIPSOV4_A_MLSCATLST],
 				    nla_a_rem)

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
