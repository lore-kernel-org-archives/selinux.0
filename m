Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m07HtU6Y030096
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2008 12:55:30 -0500
Received: from g4t0015.houston.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m07HtTfn027949
	for <selinux@tycho.nsa.gov>; Mon, 7 Jan 2008 17:55:29 GMT
Received: from g4t0015.houston.hp.com (localhost.localdomain [127.0.0.1])
	by receive-from-antispam-filter (Postfix) with SMTP id EC8E0819D
	for <selinux@tycho.nsa.gov>; Mon,  7 Jan 2008 17:55:28 +0000 (UTC)
Received: from smtp1.fc.hp.com (smtp.cnd.hp.com [15.15.136.127])
	by g4t0015.houston.hp.com (Postfix) with ESMTP id E0A4D816E
	for <selinux@tycho.nsa.gov>; Mon,  7 Jan 2008 17:55:28 +0000 (UTC)
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v11 07/19] NET: Clone the sk_buff 'iif' field in
	__skb_clone()
To: selinux@tycho.nsa.gov
Date: Mon, 07 Jan 2008 12:55:27 -0500
Message-ID: <20080107175527.13733.12852.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20080107174952.13733.68074.stgit@flek.americas.hpqcorp.net>
References: <20080107174952.13733.68074.stgit@flek.americas.hpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Both NetLabel and SELinux (other LSMs may grow to use it as well) rely on the
'iif' field to determine the receiving network interface of inbound packets.
Unfortunately, at present this field is not preserved across a skb clone
operation which can lead to garbage values if the cloned skb is sent back
through the network stack.  This patch corrects this problem by properly
copying the 'iif' field in __skb_clone() and removing the 'iif' field
assignment from skb_act_clone() since it is no longer needed.

Also, while we are here, put the assignments in the same order as the offsets
to reduce cacheline bounces.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 include/net/sch_generic.h |    1 -
 net/core/skbuff.c         |   11 ++++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index c926551..4c3b351 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -325,7 +325,6 @@ static inline struct sk_buff *skb_act_clone(struct sk_buff *skb, gfp_t gfp_mask)
 		n->tc_verd = SET_TC_VERD(n->tc_verd, 0);
 		n->tc_verd = CLR_TC_OK2MUNGE(n->tc_verd);
 		n->tc_verd = CLR_TC_MUNGED(n->tc_verd);
-		n->iif = skb->iif;
 	}
 	return n;
 }
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5b4ce9b..b628377 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -416,16 +416,17 @@ static struct sk_buff *__skb_clone(struct sk_buff *n, struct sk_buff *skb)
 	C(len);
 	C(data_len);
 	C(mac_len);
-	n->cloned = 1;
 	n->hdr_len = skb->nohdr ? skb_headroom(skb) : skb->hdr_len;
+	n->cloned = 1;
 	n->nohdr = 0;
 	n->destructor = NULL;
-	C(truesize);
-	atomic_set(&n->users, 1);
-	C(head);
-	C(data);
+	C(iif);
 	C(tail);
 	C(end);
+	C(head);
+	C(data);
+	C(truesize);
+	atomic_set(&n->users, 1);
 
 	atomic_inc(&(skb_shinfo(skb)->dataref));
 	skb->cloned = 1;


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
