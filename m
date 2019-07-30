Return-Path: <SRS0=so3z=V3=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E91C0650F
	for <selinux@archiver.kernel.org>; Tue, 30 Jul 2019 12:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39AC20693
	for <selinux@archiver.kernel.org>; Tue, 30 Jul 2019 12:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbfG3Ms7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Jul 2019 08:48:59 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43908 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfG3Ms6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Jul 2019 08:48:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id p13so65617284wru.10
        for <selinux@vger.kernel.org>; Tue, 30 Jul 2019 05:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H2wj7qmee1LrAdMSpeDSYr9rI/zavPZmtnKfkq/bX40=;
        b=JtjuZ6ZiNfXVhGmnMpOGsLYa03gPmi9HZFqQ4tZyqhkbNVokYM1v6HAjAjs2b5r52X
         OXbkaTTMhk71BhZJMgzJcDoNny4t5q1FW/+/OF8NZ3kFddZaLYoyQjXTi6mhlbTuff/y
         ACawTmAuCitqR4OGo5hZeTT/CCjbAr6IAI+sPPpgtCqM8vhGRtaYVCTM4uIs/k+LWZeS
         hqzgi6GlK+ASeru+9/9HnQPVJwisj5sj8QxCXJOLB9aBkxT1nP/YTVQonrG1z/X/lOTm
         IVNiZV/DnGMbGuvuJ43yGGWI226US2HMYltfqShcSc3q7zczyEbK7AhdeFgcw89Y95kO
         tZsg==
X-Gm-Message-State: APjAAAVwyQfINaJin1nG51UiAeD5JCDcNx13lEAtVVwniEvUZ07awu2D
        Sjd8++HSboIq8MAvxfEsyTMtbHlIVH8=
X-Google-Smtp-Source: APXvYqwZCiAaNWztuC/1oztqJmuDcEygp8e39DP61Y8wK78iopHYTJKLjgsaQ/sodPbl2SiZ6PVabg==
X-Received: by 2002:adf:fa49:: with SMTP id y9mr95196786wrr.6.1564490935636;
        Tue, 30 Jul 2019 05:48:55 -0700 (PDT)
Received: from localhost.localdomain.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id p14sm52231242wrx.17.2019.07.30.05.48.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 05:48:55 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Michal Sekletar <msekleta@redhat.com>
Subject: [PATCH] selinux: optimize MLS context to string conversion
Date:   Tue, 30 Jul 2019 14:48:52 +0200
Message-Id: <20190730124852.7670-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When mls_compute_context_len() or mls_sid_to_context() encounters a
context with large category ranges, it behaves suboptimally - it
traverses each positive bit of the category bitmap, each time calling
find_next_bit() again.

This has a large performance impact on UNIX datagram sockets with
SO_PASSSEC set, since here the peer context needs to be converted to
string for each recieved datagram. See [1] for more information.

This patch introduces a new helper for ebitmap traversal, which allows
to efficiently iterate over positive ranges instead of bits -
ebitmap_for_each_positive_range() - and converts the two mls_*()
functions to leverage it.

[1] https://bugzilla.redhat.com/show_bug.cgi?id=1733259

Reported-by: Michal Sekletar <msekleta@redhat.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/ebitmap.h | 46 +++++++++++++++++++++
 security/selinux/ss/mls.c     | 76 +++++++++++++----------------------
 2 files changed, 73 insertions(+), 49 deletions(-)

diff --git a/security/selinux/ss/ebitmap.h b/security/selinux/ss/ebitmap.h
index 6aa7cf6a2197..a415741cb206 100644
--- a/security/selinux/ss/ebitmap.h
+++ b/security/selinux/ss/ebitmap.h
@@ -42,6 +42,10 @@ struct ebitmap {
 	u32 highbit;	/* highest position in the total bitmap */
 };
 
+struct ebitmap_range {
+	unsigned int start, end;
+};
+
 #define ebitmap_length(e) ((e)->highbit)
 
 static inline unsigned int ebitmap_start_positive(struct ebitmap *e,
@@ -80,6 +84,43 @@ static inline unsigned int ebitmap_next_positive(struct ebitmap *e,
 	return ebitmap_length(e);
 }
 
+static inline unsigned int ebitmap_next_negative(struct ebitmap *e,
+						 struct ebitmap_node **n,
+						 unsigned int bit)
+{
+	unsigned int ofs;
+
+	ofs = find_next_zero_bit((*n)->maps, EBITMAP_SIZE,
+				 bit - (*n)->startbit + 1);
+	if (ofs < EBITMAP_SIZE)
+		return ofs + (*n)->startbit;
+
+	for (*n = (*n)->next; *n; *n = (*n)->next) {
+		ofs = find_first_zero_bit((*n)->maps, EBITMAP_SIZE);
+		if (ofs < EBITMAP_SIZE)
+			return ofs + (*n)->startbit;
+	}
+	return ebitmap_length(e);
+}
+
+static inline void ebitmap_start_positive_range(struct ebitmap *e,
+						struct ebitmap_node **n,
+						struct ebitmap_range *range)
+{
+	range->end = range->start = ebitmap_start_positive(e, n);
+	if (range->start < ebitmap_length(e))
+		range->end = ebitmap_next_negative(e, n, range->start);
+}
+
+static inline void ebitmap_next_positive_range(struct ebitmap *e,
+					       struct ebitmap_node **n,
+					       struct ebitmap_range *range)
+{
+	range->end = range->start = ebitmap_next_positive(e, n, range->end);
+	if (range->start < ebitmap_length(e))
+		range->end = ebitmap_next_negative(e, n, range->start);
+}
+
 #define EBITMAP_NODE_INDEX(node, bit)	\
 	(((bit) - (node)->startbit) / EBITMAP_UNIT_SIZE)
 #define EBITMAP_NODE_OFFSET(node, bit)	\
@@ -122,6 +163,11 @@ static inline void ebitmap_node_clr_bit(struct ebitmap_node *n,
 	     bit < ebitmap_length(e);			\
 	     bit = ebitmap_next_positive(e, &n, bit))	\
 
+#define ebitmap_for_each_positive_range(e, n, range)		\
+	for (ebitmap_start_positive_range(e, &n, &range);	\
+	     range.start < ebitmap_length(e);			\
+	     ebitmap_next_positive_range(e, &n, &range))	\
+
 int ebitmap_cmp(struct ebitmap *e1, struct ebitmap *e2);
 int ebitmap_cpy(struct ebitmap *dst, struct ebitmap *src);
 int ebitmap_contains(struct ebitmap *e1, struct ebitmap *e2, u32 last_e2bit);
diff --git a/security/selinux/ss/mls.c b/security/selinux/ss/mls.c
index 5e05f5b902d7..3abd6b950c66 100644
--- a/security/selinux/ss/mls.c
+++ b/security/selinux/ss/mls.c
@@ -35,10 +35,12 @@
  */
 int mls_compute_context_len(struct policydb *p, struct context *context)
 {
-	int i, l, len, head, prev;
+	int l, len;
 	char *nm;
 	struct ebitmap *e;
 	struct ebitmap_node *node;
+	struct ebitmap_range range;
+	unsigned int rlen;
 
 	if (!p->mls_enabled)
 		return 0;
@@ -49,24 +51,14 @@ int mls_compute_context_len(struct policydb *p, struct context *context)
 		len += strlen(sym_name(p, SYM_LEVELS, index_sens - 1));
 
 		/* categories */
-		head = -2;
-		prev = -2;
 		e = &context->range.level[l].cat;
-		ebitmap_for_each_positive_bit(e, node, i) {
-			if (i - prev > 1) {
-				/* one or more negative bits are skipped */
-				if (head != prev) {
-					nm = sym_name(p, SYM_CATS, prev);
-					len += strlen(nm) + 1;
-				}
-				nm = sym_name(p, SYM_CATS, i);
+		ebitmap_for_each_positive_range(e, node, range) {
+			rlen = range.end - range.start;
+			if (rlen > 1) {
+				nm = sym_name(p, SYM_CATS, range.start);
 				len += strlen(nm) + 1;
-				head = i;
 			}
-			prev = i;
-		}
-		if (prev != head) {
-			nm = sym_name(p, SYM_CATS, prev);
+			nm = sym_name(p, SYM_CATS, range.end - 1);
 			len += strlen(nm) + 1;
 		}
 		if (l == 0) {
@@ -91,9 +83,11 @@ void mls_sid_to_context(struct policydb *p,
 			char **scontext)
 {
 	char *scontextp, *nm;
-	int i, l, head, prev;
+	int l, first;
 	struct ebitmap *e;
 	struct ebitmap_node *node;
+	struct ebitmap_range range;
+	unsigned int rlen;
 
 	if (!p->mls_enabled)
 		return;
@@ -109,43 +103,27 @@ void mls_sid_to_context(struct policydb *p,
 		scontextp += strlen(scontextp);
 
 		/* categories */
-		head = -2;
-		prev = -2;
+		first = 1;
 		e = &context->range.level[l].cat;
-		ebitmap_for_each_positive_bit(e, node, i) {
-			if (i - prev > 1) {
-				/* one or more negative bits are skipped */
-				if (prev != head) {
-					if (prev - head > 1)
-						*scontextp++ = '.';
-					else
-						*scontextp++ = ',';
-					nm = sym_name(p, SYM_CATS, prev);
-					strcpy(scontextp, nm);
-					scontextp += strlen(nm);
-				}
-				if (prev < 0)
-					*scontextp++ = ':';
-				else
-					*scontextp++ = ',';
-				nm = sym_name(p, SYM_CATS, i);
-				strcpy(scontextp, nm);
-				scontextp += strlen(nm);
-				head = i;
-			}
-			prev = i;
-		}
-
-		if (prev != head) {
-			if (prev - head > 1)
-				*scontextp++ = '.';
-			else
+		ebitmap_for_each_positive_range(e, node, range) {
+			if (first) {
+				first = 0;
+				*scontextp++ = ':';
+			} else {
 				*scontextp++ = ',';
-			nm = sym_name(p, SYM_CATS, prev);
+			}
+			nm = sym_name(p, SYM_CATS, range.start);
 			strcpy(scontextp, nm);
 			scontextp += strlen(nm);
-		}
+			rlen = range.end - range.start;
+			if (rlen > 1) {
+				*scontextp++ = rlen > 2 ? '.' : ',';
 
+				nm = sym_name(p, SYM_CATS, range.end - 1);
+				strcpy(scontextp, nm);
+				scontextp += strlen(nm);
+			}
+		}
 		if (l == 0) {
 			if (mls_level_eq(&context->range.level[0],
 					 &context->range.level[1]))
-- 
2.21.0

