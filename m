Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5CFoF6g007870
	for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2006 11:50:15 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5CFoEZr010843
	for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2006 15:50:14 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6) with ESMTP id k5CFoNHg010586
	for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2006 11:50:23 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6/Submit) id k5CFoNc5010585
	for selinux@tycho.nsa.gov; Mon, 12 Jun 2006 11:50:23 -0400
Message-ID: <36282A1733C57546BE392885C0618592012D6270@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: redhat-lspp@redhat.com, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        jmorris@redhat.com, tjaeger@cse.psu.edu, latten@austin.ibm.com
Cc: Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel
	 <DGoeddel@TrustedCS.com>
Subject: [RFC] [SELXFRM 3/4] Add support to xfrm subsystem
Date: Sat, 10 Jun 2006 17:38:08 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch adds/enhances controls for SELinux/MLS handling of xfrms both on
the inbound and on the outbound. It also includes the security context to be
used by IKE, in the acquire messages sent to the IKE daemons.

Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>

---

 key/af_key.c       |   24 +++++++++++++++++++++++-
 xfrm/xfrm_policy.c |   28 +++++++++++++++-------------
 xfrm/xfrm_state.c  |   12 ++++++++++--
 xfrm/xfrm_user.c   |    2 +-
 4 files changed, 49 insertions(+), 17 deletions(-)

diff -purN -X linux-2.6.16.i686.lspp34/Documentation/dontdiff
linux-2.6.16.i686.lspp34/net/key/af_key.c
linux-2.6.16.i686.ipsec/net/key/af_key.c
--- linux-2.6.16.i686.lspp34/net/key/af_key.c	2006-06-09
09:01:32.000000000 -0500
+++ linux-2.6.16.i686.ipsec/net/key/af_key.c	2006-06-08
18:16:52.000000000 -0500
@@ -1079,7 +1079,7 @@ static struct xfrm_state * pfkey_msg2xfr
 		if (!uctx)
 			goto out;
 
-		err = security_xfrm_state_alloc(x, uctx);
+		err = security_xfrm_state_alloc(x, uctx, NULL, 0);
 		kfree(uctx);
 
 		if (err)
@@ -2704,6 +2704,9 @@ static int pfkey_send_acquire(struct xfr
 #endif
 	int sockaddr_size;
 	int size;
+	struct sadb_x_sec_ctx *sec_ctx;
+	struct xfrm_sec_ctx *xfrm_ctx;
+	int ctx_size = 0;
 	
 	sockaddr_size = pfkey_sockaddr_size(x->props.family);
 	if (!sockaddr_size)
@@ -2719,6 +2722,11 @@ static int pfkey_send_acquire(struct xfr
 	else if (x->id.proto == IPPROTO_ESP)
 		size += count_esp_combs(t);
 
+	if ((xfrm_ctx = x->security)) {
+		ctx_size = PFKEY_ALIGN8(xfrm_ctx->ctx_len);
+		size +=  sizeof(struct sadb_x_sec_ctx) + ctx_size;
+	}
+
 	skb =  alloc_skb(size + 16, GFP_ATOMIC);
 	if (skb == NULL)
 		return -ENOMEM;
@@ -2814,6 +2822,20 @@ static int pfkey_send_acquire(struct xfr
 	else if (x->id.proto == IPPROTO_ESP)
 		dump_esp_combs(skb, t);
 
+	/* security context */
+	if (xfrm_ctx) {
+		sec_ctx = (struct sadb_x_sec_ctx *) skb_put(skb,
+				sizeof(struct sadb_x_sec_ctx) + ctx_size);
+		sec_ctx->sadb_x_sec_len =
+		  (sizeof(struct sadb_x_sec_ctx) + ctx_size) /
sizeof(uint64_t);
+		sec_ctx->sadb_x_sec_exttype = SADB_X_EXT_SEC_CTX;
+		sec_ctx->sadb_x_ctx_doi = xfrm_ctx->ctx_doi;
+		sec_ctx->sadb_x_ctx_alg = xfrm_ctx->ctx_alg;
+		sec_ctx->sadb_x_ctx_len = xfrm_ctx->ctx_len;
+		memcpy(sec_ctx + 1, xfrm_ctx->ctx_str,
+		       xfrm_ctx->ctx_len);
+	}
+
 	return pfkey_broadcast(skb, GFP_ATOMIC, BROADCAST_REGISTERED, NULL);
 }
 
diff -purN -X linux-2.6.16.i686.lspp34/Documentation/dontdiff
linux-2.6.16.i686.lspp34/net/xfrm/xfrm_policy.c
linux-2.6.16.i686.ipsec/net/xfrm/xfrm_policy.c
--- linux-2.6.16.i686.lspp34/net/xfrm/xfrm_policy.c	2006-06-09
09:01:33.000000000 -0500
+++ linux-2.6.16.i686.ipsec/net/xfrm/xfrm_policy.c	2006-06-08
18:16:52.000000000 -0500
@@ -520,7 +520,7 @@ EXPORT_SYMBOL(xfrm_policy_walk);
 
 /* Find policy to apply to this flow. */
 
-static void xfrm_policy_lookup(struct flowi *fl, u32 sk_sid, u16 family, u8
dir,
+static void xfrm_policy_lookup(struct flowi *fl, u16 family, u8 dir,
 			       void **objp, atomic_t **obj_refp)
 {
 	struct xfrm_policy *pol;
@@ -536,7 +536,7 @@ static void xfrm_policy_lookup(struct fl
 		match = xfrm_selector_match(sel, fl, family);
 
 		if (match) {
- 			if (!security_xfrm_policy_lookup(pol, sk_sid, dir))
{
+ 			if (!security_xfrm_policy_lookup(pol, fl->sid, dir))
{
 				xfrm_pol_hold(pol);
 				break;
 			}
@@ -564,7 +564,7 @@ static inline int policy_to_flow_dir(int
 	};
 }
 
-static struct xfrm_policy *xfrm_sk_policy_lookup(struct sock *sk, int dir,
struct flowi *fl, u32 sk_sid)
+static struct xfrm_policy *xfrm_sk_policy_lookup(struct sock *sk, int dir,
struct flowi *fl)
 {
 	struct xfrm_policy *pol;
 
@@ -575,7 +575,7 @@ static struct xfrm_policy *xfrm_sk_polic
  		int err = 0;
 
 		if (match)
-		  err = security_xfrm_policy_lookup(pol, sk_sid,
policy_to_flow_dir(dir));
+		  err = security_xfrm_policy_lookup(pol, fl->sid,
policy_to_flow_dir(dir));
 
  		if (match && !err)
 			xfrm_pol_hold(pol);
@@ -785,19 +785,20 @@ int xfrm_lookup(struct dst_entry **dst_p
 	u32 genid;
 	u16 family;
 	u8 dir = policy_to_flow_dir(XFRM_POLICY_OUT);
-	u32 sk_sid = security_sk_sid(sk, fl, dir);
+
+	fl->sid = security_sk_sid(sk, fl, dir);
 restart:
 	genid = atomic_read(&flow_cache_genid);
 	policy = NULL;
 	if (sk && sk->sk_policy[1])
-		policy = xfrm_sk_policy_lookup(sk, XFRM_POLICY_OUT, fl,
sk_sid);
+		policy = xfrm_sk_policy_lookup(sk, XFRM_POLICY_OUT, fl);
 
 	if (!policy) {
 		/* To accelerate a bit...  */
 		if ((dst_orig->flags & DST_NOXFRM) ||
!xfrm_policy_list[XFRM_POLICY_OUT])
 			return 0;
 
-		policy = flow_cache_lookup(fl, sk_sid,
dst_orig->ops->family,
+		policy = flow_cache_lookup(fl, dst_orig->ops->family,
 					   dir, xfrm_policy_lookup);
 	}
 
@@ -955,13 +956,15 @@ int
 xfrm_decode_session(struct sk_buff *skb, struct flowi *fl, unsigned short
family)
 {
 	struct xfrm_policy_afinfo *afinfo = xfrm_policy_get_afinfo(family);
+	int err;
 
 	if (unlikely(afinfo == NULL))
 		return -EAFNOSUPPORT;
 
 	afinfo->decode_session(skb, fl);
+	err = security_xfrm_decode_session(skb, fl);
 	xfrm_policy_put_afinfo(afinfo);
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL(xfrm_decode_session);
 
@@ -981,14 +984,11 @@ int __xfrm_policy_check(struct sock *sk,
 	struct xfrm_policy *pol;
 	struct flowi fl;
 	u8 fl_dir = policy_to_flow_dir(dir);
-	u32 sk_sid;
 
 	if (xfrm_decode_session(skb, &fl, family) < 0)
 		return 0;
 	nf_nat_decode_session(skb, &fl, family);
 
-	sk_sid = security_sk_sid(sk, &fl, fl_dir);
-
 	/* First, check used SA against their selectors. */
 	if (skb->sp) {
 		int i;
@@ -1002,10 +1002,10 @@ int __xfrm_policy_check(struct sock *sk,
 
 	pol = NULL;
 	if (sk && sk->sk_policy[dir])
-		pol = xfrm_sk_policy_lookup(sk, dir, &fl, sk_sid);
+		pol = xfrm_sk_policy_lookup(sk, dir, &fl);
 
 	if (!pol)
-		pol = flow_cache_lookup(&fl, sk_sid, family, fl_dir,
+		pol = flow_cache_lookup(&fl, family, fl_dir,
 					xfrm_policy_lookup);
 
 	if (!pol)
@@ -1200,6 +1200,8 @@ int xfrm_bundle_ok(struct xfrm_dst *firs
 
 		if (fl && !xfrm_selector_match(&dst->xfrm->sel, fl, family))
 			return 0;
+		if (fl && !security_xfrm_flow_state_match(fl, dst->xfrm))
+			return 0;
 		if (dst->xfrm->km.state != XFRM_STATE_VALID)
 			return 0;
 
diff -purN -X linux-2.6.16.i686.lspp34/Documentation/dontdiff
linux-2.6.16.i686.lspp34/net/xfrm/xfrm_state.c
linux-2.6.16.i686.ipsec/net/xfrm/xfrm_state.c
--- linux-2.6.16.i686.lspp34/net/xfrm/xfrm_state.c	2006-06-09
09:01:33.000000000 -0500
+++ linux-2.6.16.i686.ipsec/net/xfrm/xfrm_state.c	2006-06-08
18:16:52.000000000 -0500
@@ -366,7 +366,7 @@ xfrm_state_find(xfrm_address_t *daddr, x
 			 */
 			if (x->km.state == XFRM_STATE_VALID) {
 				if (!xfrm_selector_match(&x->sel, fl,
family) ||
-				    !xfrm_sec_ctx_match(pol->security,
x->security))
+				    !security_xfrm_state_pol_flow_match(x,
pol, fl))
 					continue;
 				if (!best ||
 				    best->km.dying > x->km.dying ||
@@ -378,7 +378,7 @@ xfrm_state_find(xfrm_address_t *daddr, x
 			} else if (x->km.state == XFRM_STATE_ERROR ||
 				   x->km.state == XFRM_STATE_EXPIRED) {
  				if (xfrm_selector_match(&x->sel, fl, family)
&&
-				    xfrm_sec_ctx_match(pol->security,
x->security))
+				    security_xfrm_state_pol_flow_match(x,
pol, fl))
 					error = -ESRCH;
 			}
 		}
@@ -402,6 +402,14 @@ xfrm_state_find(xfrm_address_t *daddr, x
 		 * to current session. */
 		xfrm_init_tempsel(x, fl, tmpl, daddr, saddr, family);
 
+		error = security_xfrm_state_alloc(x, NULL, pol->security,
fl->sid);
+		if (error) {
+			x->km.state = XFRM_STATE_DEAD;
+			xfrm_state_put(x);
+			x = NULL;
+			goto out;
+		}
+
 		if (km_query(x, tmpl, pol) == 0) {
 			x->km.state = XFRM_STATE_ACQ;
 			list_add_tail(&x->bydst, xfrm_state_bydst+h);
diff -purN -X linux-2.6.16.i686.lspp34/Documentation/dontdiff
linux-2.6.16.i686.lspp34/net/xfrm/xfrm_user.c
linux-2.6.16.i686.ipsec/net/xfrm/xfrm_user.c
--- linux-2.6.16.i686.lspp34/net/xfrm/xfrm_user.c	2006-06-09
09:01:33.000000000 -0500
+++ linux-2.6.16.i686.ipsec/net/xfrm/xfrm_user.c	2006-06-08
18:16:52.000000000 -0500
@@ -255,7 +255,7 @@ static int attach_sec_ctx(struct xfrm_st
 		return 0;
 
 	uctx = RTA_DATA(u_arg);
-	return security_xfrm_state_alloc(x, uctx);
+	return security_xfrm_state_alloc(x, uctx, NULL, 0);
 }
 
 static void copy_from_user_state(struct xfrm_state *x, struct
xfrm_usersa_info *p)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
