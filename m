Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m03HcZT9012859
	for <selinux@tycho.nsa.gov>; Thu, 3 Jan 2008 12:38:35 -0500
Received: from g1t0029.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m03HcYjV029817
	for <selinux@tycho.nsa.gov>; Thu, 3 Jan 2008 17:38:34 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v10 08/20] NET: Clone the sk_buff 'iif' field in
	__skb_clone()
To: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Date: Thu, 03 Jan 2008 12:38:32 -0500
Message-ID: <20080103173832.15387.53025.stgit@flek.americas.hpqcorp.net>
In-Reply-To: <20080103173225.15387.60940.stgit@flek.americas.hpqcorp.net>
References: <20080103173225.15387.60940.stgit@flek.americas.hpqcorp.net>
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

Also, while we are here, get rid of that silly C() macro.

Signed-off-by: Paul Moore <paul.moore@hp.com>
---

 include/net/sch_generic.h |    1 -
 net/core/skbuff.c         |   20 +++++++++-----------
 2 files changed, 9 insertions(+), 12 deletions(-)

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
index 5b4ce9b..c726cd4 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -407,31 +407,29 @@ static void __copy_skb_header(struct sk_buff *new, const struct sk_buff *old)
 
 static struct sk_buff *__skb_clone(struct sk_buff *n, struct sk_buff *skb)
 {
-#define C(x) n->x = skb->x
-
 	n->next = n->prev = NULL;
 	n->sk = NULL;
 	__copy_skb_header(n, skb);
 
-	C(len);
-	C(data_len);
-	C(mac_len);
+	n->iif = skb->iif;
+	n->len = skb->len;
+	n->data_len = skb->data_len;
+	n->mac_len = skb->mac_len;
 	n->cloned = 1;
 	n->hdr_len = skb->nohdr ? skb_headroom(skb) : skb->hdr_len;
 	n->nohdr = 0;
 	n->destructor = NULL;
-	C(truesize);
+	n->truesize = skb->truesize;
 	atomic_set(&n->users, 1);
-	C(head);
-	C(data);
-	C(tail);
-	C(end);
+	n->head = skb->head;
+	n->data = skb->data;
+	n->tail = skb->tail;
+	n->end = skb->end;
 
 	atomic_inc(&(skb_shinfo(skb)->dataref));
 	skb->cloned = 1;
 
 	return n;
-#undef C
 }
 
 /**


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
