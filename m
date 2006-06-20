Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5KIOV7F004869
	for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2006 14:24:31 -0400
Received: from tcsfw4.tcs-sec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5KIOU9b029073
	for <selinux@tycho.nsa.gov>; Tue, 20 Jun 2006 18:24:30 GMT
Message-ID: <44983D50.4080204@trustedcs.com>
Date: Tue, 20 Jun 2006 13:24:16 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: [PATCH 06/06] MLSXFRM: Add security context to acquire messages using
 PF_KEY
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This includes the security context of a security association created for use by IKE
in the acquire messages sent to IKE daemons using PF_KEY. This would allow
the daemons to include the security context in the negotiation, so that the resultant
association is unique to that security context.

Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>
---

 net/key/af_key.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

--- linux-2.6.16.vanilla/net/key/af_key.c	2006-06-12 17:49:42.000000000 -0500
+++ linux-2.6.16/net/key/af_key.c	2006-06-19 19:48:24.000000000 -0500
@@ -2709,6 +2709,9 @@ static int pfkey_send_acquire(struct xfr
 #endif
 	int sockaddr_size;
 	int size;
+	struct sadb_x_sec_ctx *sec_ctx;
+	struct xfrm_sec_ctx *xfrm_ctx;
+	int ctx_size = 0;
 	
 	sockaddr_size = pfkey_sockaddr_size(x->props.family);
 	if (!sockaddr_size)
@@ -2724,6 +2727,11 @@ static int pfkey_send_acquire(struct xfr
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
@@ -2819,6 +2827,20 @@ static int pfkey_send_acquire(struct xfr
 	else if (x->id.proto == IPPROTO_ESP)
 		dump_esp_combs(skb, t);
 
+	/* security context */
+	if (xfrm_ctx) {
+		sec_ctx = (struct sadb_x_sec_ctx *) skb_put(skb,
+				sizeof(struct sadb_x_sec_ctx) + ctx_size);
+		sec_ctx->sadb_x_sec_len =
+		  (sizeof(struct sadb_x_sec_ctx) + ctx_size) / sizeof(uint64_t);
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
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
