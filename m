Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5CFoFgR007869
	for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2006 11:50:15 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5CFoEZr010842
	for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2006 15:50:14 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6) with ESMTP id k5CFoNEt010578
	for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2006 11:50:23 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6/Submit) id k5CFoN9k010577
	for selinux@tycho.nsa.gov; Mon, 12 Jun 2006 11:50:23 -0400
Message-ID: <36282A1733C57546BE392885C0618592012D626E@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: redhat-lspp@redhat.com, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        jmorris@redhat.com, tjaeger@cse.psu.edu, latten@austin.ibm.com
Cc: Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel
	 <DGoeddel@TrustedCS.com>
Subject: [RFC] [SELXFRM 1/4] Add support to core networking
Date: Sat, 10 Jun 2006 17:37:38 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds a security sid to the flow key itself making the flow cache
lookps based on the sid seemless.

This patch also adds support for handling security for sock. Security at the
sock level is needed to enforce policy even when a sock is orphaned (such as
in the TCP LAST_ACK state).

Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>

---

 include/net/flow.h |    5 +++--
 net/core/flow.c    |    7 ++-----
 net/core/sock.c    |    4 ++++
 3 files changed, 9 insertions(+), 7 deletions(-)

diff -purN -X linux-2.6.16.i686.lspp34/Documentation/dontdiff
linux-2.6.16.i686.lspp34/include/net/flow.h
linux-2.6.16.i686.ipsec/include/net/flow.h
--- linux-2.6.16.i686.lspp34/include/net/flow.h	2006-06-09
09:01:30.000000000 -0500
+++ linux-2.6.16.i686.ipsec/include/net/flow.h	2006-06-08
18:16:52.000000000 -0500
@@ -78,6 +78,7 @@ struct flowi {
 #define fl_icmp_type	uli_u.icmpt.type
 #define fl_icmp_code	uli_u.icmpt.code
 #define fl_ipsec_spi	uli_u.spi
+	__u32           sid;
 } __attribute__((__aligned__(BITS_PER_LONG/8)));
 
 #define FLOW_DIR_IN	0
@@ -85,10 +86,10 @@ struct flowi {
 #define FLOW_DIR_FWD	2
 
 struct sock;
-typedef void (*flow_resolve_t)(struct flowi *key, u32 sk_sid, u16 family,
u8 dir,
+typedef void (*flow_resolve_t)(struct flowi *key, u16 family, u8 dir,
 			       void **objp, atomic_t **obj_refp);
 
-extern void *flow_cache_lookup(struct flowi *key, u32 sk_sid, u16 family,
u8 dir,
+extern void *flow_cache_lookup(struct flowi *key, u16 family, u8 dir,
 	 		       flow_resolve_t resolver);
 extern void flow_cache_flush(void);
 extern atomic_t flow_cache_genid;
diff -purN -X linux-2.6.16.i686.lspp34/Documentation/dontdiff
linux-2.6.16.i686.lspp34/net/core/flow.c
linux-2.6.16.i686.ipsec/net/core/flow.c
--- linux-2.6.16.i686.lspp34/net/core/flow.c	2006-06-09
09:01:31.000000000 -0500
+++ linux-2.6.16.i686.ipsec/net/core/flow.c	2006-06-08
18:16:52.000000000 -0500
@@ -32,7 +32,6 @@ struct flow_cache_entry {
 	u8			dir;
 	struct flowi		key;
 	u32			genid;
-	u32			sk_sid;
 	void			*object;
 	atomic_t		*object_ref;
 };
@@ -165,7 +164,7 @@ static int flow_key_compare(struct flowi
 	return 0;
 }
 
-void *flow_cache_lookup(struct flowi *key, u32 sk_sid, u16 family, u8 dir,
+void *flow_cache_lookup(struct flowi *key, u16 family, u8 dir,
 			flow_resolve_t resolver)
 {
 	struct flow_cache_entry *fle, **head;
@@ -189,7 +188,6 @@ void *flow_cache_lookup(struct flowi *ke
 	for (fle = *head; fle; fle = fle->next) {
 		if (fle->family == family &&
 		    fle->dir == dir &&
-		    fle->sk_sid == sk_sid &&
 		    flow_key_compare(key, &fle->key) == 0) {
 			if (fle->genid == atomic_read(&flow_cache_genid)) {
 				void *ret = fle->object;
@@ -214,7 +212,6 @@ void *flow_cache_lookup(struct flowi *ke
 			*head = fle;
 			fle->family = family;
 			fle->dir = dir;
-			fle->sk_sid = sk_sid;
 			memcpy(&fle->key, key, sizeof(*key));
 			fle->object = NULL;
 			flow_count(cpu)++;
@@ -226,7 +223,7 @@ nocache:
 		void *obj;
 		atomic_t *obj_ref;
 
-		resolver(key, sk_sid, family, dir, &obj, &obj_ref);
+		resolver(key, family, dir, &obj, &obj_ref);
 
 		if (fle) {
 			fle->genid = atomic_read(&flow_cache_genid);
diff -purN -X linux-2.6.16.i686.lspp34/Documentation/dontdiff
linux-2.6.16.i686.lspp34/net/core/sock.c
linux-2.6.16.i686.ipsec/net/core/sock.c
--- linux-2.6.16.i686.lspp34/net/core/sock.c	2006-06-09
09:01:38.000000000 -0500
+++ linux-2.6.16.i686.ipsec/net/core/sock.c	2006-06-08
18:16:52.000000000 -0500
@@ -820,7 +820,11 @@ struct sock *sk_clone(struct sock *sk, c
 	if (newsk != NULL) {
 		struct sk_filter *filter;
 
+		/* Save/restore the LSM security pointer around the copy */
+		void *sptr = newsk->sk_security;
 		memcpy(newsk, sk, sk->sk_prot->obj_size);
+		newsk->sk_security = sptr;
+		security_sk_clone(sk, newsk);
 
 		/* SANITY */
 		sk_node_init(&newsk->sk_node);

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
