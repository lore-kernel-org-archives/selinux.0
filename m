Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l05KGJZa001969
	for <selinux@tycho.nsa.gov>; Fri, 5 Jan 2007 15:16:19 -0500
Received: from atlrel6.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l05KH5Y9014710
	for <selinux@tycho.nsa.gov>; Fri, 5 Jan 2007 20:17:06 GMT
From: "Paul Moore" <paul.moore@hp.com>
Message-Id: <20070105201639.625399003@hp.com>
References: <20070105200820.975960210@hp.com>
Date: Fri, 05 Jan 2007 15:08:22 -0500
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Cc: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 2/2] NetLabel: correct CIPSO tag handling when adding new DOI definitions
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The current netlbl_cipsov4_add_common() function has two problems which are
fixed with this patch.  The first is an off-by-one bug where it is possibile to
overflow the doi_def->tags[] array.  The second is a bug where the same 
doi_def->tags[] array was not always fully initialized, which caused sporadic
failures.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---
 net/netlabel/netlabel_cipso_v4.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: net-2.6.20_bugfix_3/net/netlabel/netlabel_cipso_v4.c
===================================================================
--- net-2.6.20_bugfix_3.orig/net/netlabel/netlabel_cipso_v4.c
+++ net-2.6.20_bugfix_3/net/netlabel/netlabel_cipso_v4.c
@@ -130,12 +130,12 @@ static int netlbl_cipsov4_add_common(str
 
 	nla_for_each_nested(nla, info->attrs[NLBL_CIPSOV4_A_TAGLST], nla_rem)
 		if (nla->nla_type == NLBL_CIPSOV4_A_TAG) {
-			if (iter > CIPSO_V4_TAG_MAXCNT)
+			if (iter >= CIPSO_V4_TAG_MAXCNT)
 				return -EINVAL;
 			doi_def->tags[iter++] = nla_get_u8(nla);
 		}
-	if (iter < CIPSO_V4_TAG_MAXCNT)
-		doi_def->tags[iter] = CIPSO_V4_TAG_INVALID;
+	while (iter < CIPSO_V4_TAG_MAXCNT)
+		doi_def->tags[iter++] = CIPSO_V4_TAG_INVALID;
 
 	return 0;
 }

--
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
