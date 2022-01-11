Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD55C4321E
	for <selinux@archiver.kernel.org>; Tue, 11 Jan 2022 21:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345391AbiAKVzS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jan 2022 16:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345518AbiAKVzF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jan 2022 16:55:05 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E11C06175B
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:05 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id r6so767125qvr.13
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 13:55:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/oGXUnaG67opnE2dI+Wcfc77eKI5xjFbB3YQCwNs8BM=;
        b=hIux8aXTMNCWTrRbXZ3BZOXzZC1MHD4ZSquXjrFqO6dG4r2AD2JnYQySUbwAN9Zv9V
         wZNgFRbC7o0KZIz5AzMDWl1jxZDqiyw/lRE1jRXB2YVe9HhnWLNpCJKliPSW/tUccDtZ
         DJrU8NFMsoV209g+B/K4Eeg/bbibCQpYlTOiBzRdKs834wOM1AGUvZgF7shWN7d8Kqz0
         FbLcIYdirHphmZtoCWBCGI7PuzVOpBAb5bL8AqrcPSQ6bzNgXtZtrYhpe2EZP/EmOhhm
         XS4e8AKtEY53/39xKqtGKrn3SLE2JqG1ir5e06JjuRyb3j9nYS4RX3QVgt5bFdYtEkO1
         z9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/oGXUnaG67opnE2dI+Wcfc77eKI5xjFbB3YQCwNs8BM=;
        b=BMUAcIiG7minp5X8cvJVYPoQUUnAUclMdIUNes1oQfY24KeL+2Uy4/09thQmkaie9K
         7AYnA3wSiNw4UpJfCSrVIiAar7dKCZh4aQW9Mt099mPHSo98ZyATlXZFtZfjvTEjxvwQ
         jP8/1SSyi0ja73O8AJ9gFKEgGmWzL6V8MxsSHCC7Q+xziP/GxT46UhZrGWSJq3fT1+Bl
         DITokpv6MZ1+u2reeSiW4b/uUngTav7FkGNVfh8Z1vb1I14+pDQZoio3fuCF0URMaqUN
         Xj5efgmdJ4fCN4Sc9PsJT1lrQdZ7yPIehymbUDaUJpHZITWGt8sD+jkzyTJsD0MwFnrV
         MD9w==
X-Gm-Message-State: AOAM5316XlyXHGbWePJyvQVRntTv57qBXyXab2xapylifJz/6KYXMxvG
        e/v11IRS0ZJXcdzB7Owc9vxvlLfxHFg=
X-Google-Smtp-Source: ABdhPJyc6tySq1hc4oUC/GX6OiHKRLbdP0ZedcRHMWVrzkbW5KzFv2buHGSIyTBfk45riiLrS/bIRA==
X-Received: by 2002:a05:6214:c4f:: with SMTP id r15mr5719572qvj.87.1641938104142;
        Tue, 11 Jan 2022 13:55:04 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id j22sm5826949qko.46.2022.01.11.13.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 13:55:03 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 14/16 v2] libsepol: The src and tgt must be the same if neverallow uses self
Date:   Tue, 11 Jan 2022 16:54:44 -0500
Message-Id: <20220111215446.595516-15-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220111215446.595516-1-jwcart2@gmail.com>
References: <20220111215446.595516-1-jwcart2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When checking for violations of neverallow rules, if the neverallow
uses self, then the src and tgt must be the same when checking
extended permissions and when reporting violations.

Example:
  allow attr attr : CLASS PERM;
  neverallow attr self : CLASS PERM;

If the types t1 and t2 have attribute attr, then the violations
that would be reported would be:
  allow t1 t1 : CLASS PERM;
  allow t1 t2 : CLASS PERM;
  allow t2 t1 : CLASS PERM;
  allow t2 t2 : CLASS PERM;
instead of:
  allow t1 t1 : CLASS PERM;
  allow t2 t2 : CLASS PERM;

Signed-off-by: James Carter <jwcart2@gmail.com>
---
 libsepol/src/assertion.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/libsepol/src/assertion.c b/libsepol/src/assertion.c
index 93c57061..1c69f4d9 100644
--- a/libsepol/src/assertion.c
+++ b/libsepol/src/assertion.c
@@ -213,6 +213,7 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 	ebitmap_t src_matches, tgt_matches, self_matches;
 	ebitmap_node_t *snode, *tnode;
 	unsigned int i, j;
+	const int is_avrule_self = (avrule->flags & RULE_SELF) != 0;
 
 	if ((k->specified & AVTAB_ALLOWED) == 0)
 		return 0;
@@ -236,7 +237,7 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 	if (rc < 0)
 		goto oom;
 
-	if (avrule->flags == RULE_SELF) {
+	if (is_avrule_self) {
 		rc = ebitmap_and(&self_matches, &src_matches, &p->attr_type_map[k->target_type - 1]);
 		if (rc < 0)
 			goto oom;
@@ -260,6 +261,8 @@ static int report_assertion_avtab_matches(avtab_key_t *k, avtab_datum_t *d, void
 
 		ebitmap_for_each_positive_bit(&src_matches, snode, i) {
 			ebitmap_for_each_positive_bit(&tgt_matches, tnode, j) {
+				if (is_avrule_self && i != j)
+					continue;
 				if (avrule->specified == AVRULE_XPERMS_NEVERALLOW) {
 					a->errors += report_assertion_extended_permissions(handle,p, avrule,
 											i, j, cp, perms, k, avtab);
@@ -368,6 +371,7 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 	ebitmap_t src_matches, tgt_matches, self_matches;
 	unsigned int i, j;
 	ebitmap_node_t *snode, *tnode;
+	const int is_avrule_self = (avrule->flags & RULE_SELF) != 0;
 	int rc;
 
 	ebitmap_init(&src_matches);
@@ -389,7 +393,7 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 	if (rc < 0)
 		goto oom;
 
-	if (avrule->flags == RULE_SELF) {
+	if (is_avrule_self) {
 		rc = ebitmap_and(&self_matches, &src_matches, &p->attr_type_map[k->target_type - 1]);
 		if (rc < 0)
 			goto oom;
@@ -408,6 +412,8 @@ static int check_assertion_extended_permissions(avrule_t *avrule, avtab_t *avtab
 
 	ebitmap_for_each_positive_bit(&src_matches, snode, i) {
 		ebitmap_for_each_positive_bit(&tgt_matches, tnode, j) {
+			if (is_avrule_self && i != j)
+				continue;
 			if (check_assertion_extended_permissions_avtab(avrule, avtab, i, j, k, p)) {
 				rc = 1;
 				goto exit;
-- 
2.31.1

