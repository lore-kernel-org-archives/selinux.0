Return-Path: <SRS0=riLa=NQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84BAC0044C
	for <selinux@archiver.kernel.org>; Mon,  5 Nov 2018 21:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94ADF20827
	for <selinux@archiver.kernel.org>; Mon,  5 Nov 2018 21:00:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94ADF20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=m4x.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387556AbeKFGVv (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:21:51 -0500
Received: from mx1.polytechnique.org ([129.104.30.34]:46793 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFGVv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 6 Nov 2018 01:21:51 -0500
Received: from localhost.localdomain (89-156-252-9.rev.numericable.fr [89.156.252.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id D4ECF56127D
        for <selinux@vger.kernel.org>; Mon,  5 Nov 2018 22:00:16 +0100 (CET)
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
To:     selinux@vger.kernel.org
Subject: [PATCH 1/1] libsepol: mark permissive types when loading a binary policy
Date:   Mon,  5 Nov 2018 22:00:01 +0100
Message-Id: <20181105210001.31499-1-nicolas.iooss@m4x.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Mon Nov  5 22:00:17 2018 +0100 (CET))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

When using checkpolicy to read a binary policy, permissive types are not
written in the output file. In order to reproduce this issue, a test
policy can be written from minimal.cil with the following commands:

    $ cd secilc/test/
    $ cp minimum.cil my_policy.cil
    $ echo '(typepermissive TYPE)' >> my_policy.cil
    $ secilc my_policy.cil
    $ checkpolicy -bC -o /dev/stdout policy.31

    # There is no "(typepermissive TYPE)" in checkpolicy output.

This is because TYPE_FLAGS_PERMISSIVE is added to typdatum->flags only
when loading a module, which uses the permissive flag in the type
properties. A kernel policy defines permissive types in a dedicated
bitmap, which gets loaded as p->permissive_map before the types are
loaded. Use this bitmap to mark permissive types in the loaded policy.

Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
---
 libsepol/src/policydb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libsepol/src/policydb.c b/libsepol/src/policydb.c
index 96176d805d59..f2beaf041fc7 100644
--- a/libsepol/src/policydb.c
+++ b/libsepol/src/policydb.c
@@ -2469,6 +2469,9 @@ static int type_read(policydb_t * p, hashtab_t h, struct policy_file *fp)
 		if (properties & TYPEDATUM_PROPERTY_PERMISSIVE
 		    && p->policy_type != POLICY_KERN)
 			typdatum->flags |= TYPE_FLAGS_PERMISSIVE;
+		if (p->policy_type == POLICY_KERN
+		    && ebitmap_get_bit(&p->permissive_map, typdatum->s.value))
+			typdatum->flags |= TYPE_FLAGS_PERMISSIVE;
 
 		typdatum->bounds = le32_to_cpu(buf[++pos]);
 	} else {
-- 
2.19.1

