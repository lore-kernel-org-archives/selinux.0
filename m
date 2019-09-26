Return-Path: <SRS0=fLGi=XV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3879FC4360C
	for <selinux@archiver.kernel.org>; Thu, 26 Sep 2019 17:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F281A222C7
	for <selinux@archiver.kernel.org>; Thu, 26 Sep 2019 17:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.nsa.gov header.i=@tycho.nsa.gov header.b="qr8qto2L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbfIZRTm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 26 Sep 2019 13:19:42 -0400
Received: from UCOL19PA38.eemsg.mail.mil ([214.24.24.198]:3234 "EHLO
        UCOL19PA38.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfIZRTm (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 26 Sep 2019 13:19:42 -0400
X-EEMSG-check-017: 28271209|UCOL19PA38_ESA_OUT05.csd.disa.mil
X-IronPort-AV: E=Sophos;i="5.64,552,1559520000"; 
   d="scan'208";a="28271209"
Received: from emsm-gh1-uea10.ncsc.mil ([214.29.60.2])
  by UCOL19PA38.eemsg.mail.mil with ESMTP/TLS/DHE-RSA-AES256-SHA256; 26 Sep 2019 17:19:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tycho.nsa.gov; i=@tycho.nsa.gov; q=dns/txt;
  s=tycho.nsa.gov; t=1569518380; x=1601054380;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4qgzzpOmPKXsiIoVsG391IDLYTjaTb1+Ho657Sz/dXI=;
  b=qr8qto2LN4PDXSw+TTGqkZzDn7wu0wTlXTUvr9Nrzk6oI7qPchgxWZFt
   zLHblhHTwwYc+mrvFpLapQ1Zty93XuFfIrMrzRSTIguWLd9GrhaqlWp49
   ScPzeIMJr2AKs1fcWC8mRjSxayr2LiTPkoBr2ykIa+QzERBF5oQvdcYpN
   rOTkxZ1iJrDBA2L3k7XqhiqawcGULmqvIzA5pBVFNYXTJBaUQ4B8SLUQo
   ycb2ghrfu+v6seyc65zFZJuoXb+QxXFGtLOIIasnbqMGh1M51CmshUuY0
   sRe5UCNcgSAIen6lyGfccl4g5h+FInMdLWxN94SgYXMDg1JO8yx3d0xrO
   g==;
X-IronPort-AV: E=Sophos;i="5.64,552,1559520000"; 
   d="scan'208";a="28367340"
IronPort-PHdr: =?us-ascii?q?9a23=3ARcAmqhdzncAdaxgRwt56sfVwlGMj4u6mDksu8p?=
 =?us-ascii?q?Mizoh2WeGdxcu8ZB7h7PlgxGXEQZ/co6odzbaP6Oa7BSdZuM7JmUtBWaQEbw?=
 =?us-ascii?q?UCh8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFR?=
 =?us-ascii?q?rlKAV6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+MRu7oR/fu8QZjoduN7s9xg?=
 =?us-ascii?q?fUqXZUZupawn9lK0iOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ7FGFToqK2?=
 =?us-ascii?q?866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXD?=
 =?us-ascii?q?mp8qlmRAP0hCoBKjU2/nvXishth6xFphyvqQF0z4rNbIybMPdye6XQds4YS2?=
 =?us-ascii?q?VcRMZcTyxPDJ2hYYUBDOQPOulXoYbmqlcSrhazHxWgCfnzxjNUgHL9wK000/?=
 =?us-ascii?q?4mEQHDxAEuG8gBsHHKo9XuKawfT/q6zLPUzTrddfNdxDDw6IrGcx89u/6MR6?=
 =?us-ascii?q?5wfdTKxEkzFwLKklWQqYv/MzOTzeQCqXKX7+VnVeKxkmMqrRx6rDu3xso0l4?=
 =?us-ascii?q?XEiY0YxkrE+Clk2oo5O9K1RFBhbdK5FpZbqjuUOJFsQsw4RmFloCM6yrobtp?=
 =?us-ascii?q?GlZCUK05EnxwLHa/yAboiI/grvVOaPLjd8g3JoYK6/iAyo8Uih1+38TdO40E?=
 =?us-ascii?q?pKryVZktnMsWoB1xrP5cicVvRx5EKh2TeL1wzL6+FEJ147lbbDJpI8zbM9mY?=
 =?us-ascii?q?AfvETeEiPshkn7g7Gael859uSw7uToeLTmppuSN49ujQH+N7wjms6xAOskKA?=
 =?us-ascii?q?cORXSb9fqn2b3//Uz2XLVKjvosnqnfq5DVP94XpqG+Aw9Lyooj8QqwDy+60N?=
 =?us-ascii?q?QEmnkKNElFdwyDj4joPVHOPf/5AOyhg1Sjjjhr3erKPr7/DZXXKHjMjrPhca?=
 =?us-ascii?q?x6605GxwpghexYsolZDrAHPeLbRED8rprbAwU/PgjyxPzoW/tn0YZLe2uKD7?=
 =?us-ascii?q?TRG6rIrVKSrrYtPOKFfpNPkCrsIPgiofj1hDk2nkFLLvrh5ocedH3tRqcuGE?=
 =?us-ascii?q?6ee3e5x4xQHA=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AFDQAy8oxd/wHyM5BmHgEGEoNbKoFAMiqTM00BAQEBA?=
 =?us-ascii?q?QEGiyuPQ4FnCQEBAQEBAQEBARsZAQIBAYdzIzgTAgwBAQEEAQEBAQEFAwEBb?=
 =?us-ascii?q?IU5gjopgxYLAYIXgmM/gXcUsE8zhUyDO4FIgTSHM4RZgRCBB4RhhCyFewSBL?=
 =?us-ascii?q?wGrZQaCJowZiGYMG5kzAalOIYFYKwgCGClKgR6BTlAQFIFaF44+JQMwgQYBA?=
 =?us-ascii?q?Y4JAQE?=
Received: from tarius.tycho.ncsc.mil ([144.51.242.1])
  by EMSM-GH1-UEA10.NCSC.MIL with ESMTP; 26 Sep 2019 17:19:40 +0000
Received: from moss-lions.infosec.tycho.ncsc.mil (moss-lions [192.168.25.4])
        by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id x8QHJdYL007617
        for <selinux@vger.kernel.org>; Thu, 26 Sep 2019 13:19:40 -0400
From:   James Carter <jwcart2@tycho.nsa.gov>
To:     selinux@vger.kernel.org
Subject: [PATCH] libsepol: Further improve binary policy optimization
Date:   Thu, 26 Sep 2019 13:19:34 -0400
Message-Id: <20190926171934.9786-1-jwcart2@tycho.nsa.gov>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This improves commit b8213acf (libsepol: add a function to optimize
kernel policy) by Ondrej Mosnacek <omosnace@redhat.com> by always
removing redundant conditional rules which have an identical rule
in the unconditional policy.

Add a flag called not_cond to is_avrule_redundant(). When checking
unconditional rules against the avtab (which stores the unconditional
rules) we need to skip the actual rule that we are checking (otherwise
a rule would be determined to be redundant with itself and bad things
would happen), but when checking a conditional rule against the avtab
we do not want to skip an identical rule (which is what currently
happens), we want to remove the redundant permissions in the conditional
rule.

A couple of examples to illustrate when redundant condtional rules
are not removed.

Example 1
  allow t1 t2:class1 perm1;
  if (bool1) {
    allow t1 t2:class1 perm1;
  }
The conditional rule is clearly redundant, but without this change it
will not be removed, because of the check for an identical rule.

Example 2
  typeattribute t1 a1;
  allow t1 t2:class1 perm1;
  allow a1 t2:class1 perm1;
  if (bool1) {
    allow t1 t2:class1 perm1;
  }
The conditional rule is again clearly redundant, but now the order of
processing during the optimization will determine whether or not the
rule is removed. Because a1 contains only t1, a1 and t1 are considered
to be supersets of each other. If the rule with the attribute is
processed first, then it will be determined to be redundant and
removed, so the conditional rule will not be removed. But if the rule
with the type is processed first, then it will be removed and the
conditional rule will be determined to be redundant with the rule with
the attribute and removed as well.

The change reduces the size of policy a bit more than the original
optimization. Looking at the change in number of allow rules, there is
about a 10% improvement over the old optimization.
           orig    old    new
Refpolicy 113284  82467  78053
Fedora    106410  64015  60008

Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
---
 libsepol/src/optimize.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
index 10399a43..1e5e97e8 100644
--- a/libsepol/src/optimize.c
+++ b/libsepol/src/optimize.c
@@ -123,7 +123,7 @@ static int process_avtab_datum(uint16_t specified,
 
 /* checks if avtab contains a rule that covers the given rule */
 static int is_avrule_redundant(avtab_ptr_t entry, avtab_t *tab,
-			       const ebitmap_t *type_map)
+			       const ebitmap_t *type_map, unsigned char not_cond)
 {
 	unsigned int i, k, s_idx, t_idx;
 	ebitmap_node_t *snode, *tnode;
@@ -146,7 +146,7 @@ static int is_avrule_redundant(avtab_ptr_t entry, avtab_t *tab,
 		key.source_type = i + 1;
 
 		ebitmap_for_each_positive_bit(&type_map[t_idx], tnode, k) {
-			if (s_idx == i && t_idx == k)
+			if (not_cond && s_idx == i && t_idx == k)
 				continue;
 
 			key.target_type = k + 1;
@@ -223,7 +223,7 @@ static void optimize_avtab(policydb_t *p, const ebitmap_t *type_map)
 	for (i = 0; i < tab->nslot; i++) {
 		cur = &tab->htable[i];
 		while (*cur) {
-			if (is_avrule_redundant(*cur, tab, type_map)) {
+			if (is_avrule_redundant(*cur, tab, type_map, 1)) {
 				/* redundant rule -> remove it */
 				avtab_ptr_t tmp = *cur;
 
@@ -279,7 +279,7 @@ static void optimize_cond_av_list(cond_av_list_t **cond, cond_av_list_t **del,
 		 * First check if covered by an unconditional rule, then also
 		 * check if covered by another rule in the same list.
 		 */
-		if (is_avrule_redundant((*cond)->node, &p->te_avtab, type_map) ||
+		if (is_avrule_redundant((*cond)->node, &p->te_avtab, type_map, 0) ||
 		    is_cond_rule_redundant((*cond)->node, *pcov_cur, type_map)) {
 			cond_av_list_t *tmp = *cond;
 
-- 
2.21.0

