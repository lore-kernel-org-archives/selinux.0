Return-Path: <SRS0=faga=6E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF1BC3815B
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 13:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FDE920722
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 13:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SE+WGGAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgDTN1k (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:27:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60313 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726009AbgDTN1j (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 09:27:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587389258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xW37H60Xaqnjrqgb2S2b4doPCechXWUylEHc+TCBFoU=;
        b=SE+WGGANkMjfeTXWrT7+31JZQHJoQaUn/w1AlgOofIqZJ9sHuNHm6oacl0Wgl/CaZ7wm6S
        64Vqa4yHTbD4baEvi7fwYslc9VAHsRZO0eo7+eTX4CPDxOEK/KivXxeD1BDc3SfzECRsOb
        9C+1BhurWqe9H0yIDiq4ULqaiDFx1BQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-S2aC5cCfOYKnSJoSXDv8ag-1; Mon, 20 Apr 2020 09:27:36 -0400
X-MC-Unique: S2aC5cCfOYKnSJoSXDv8ag-1
Received: by mail-wr1-f70.google.com with SMTP id j16so5680214wrw.20
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 06:27:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xW37H60Xaqnjrqgb2S2b4doPCechXWUylEHc+TCBFoU=;
        b=PZpZB16yRq9RLivFKgTdihAVedswrikq55ueZMQqLa/56Lmo9GZO4ZKquBjZnJOYOz
         gR3O53OToNaWIIi02CXw3DKxV9lTUBj5IDiQTWs3w9B88YFR04/+3LNYyrWnJo3IOeCZ
         kK5E+rWcN6HafHl4s5bwYcjkv5NYuNvooX+ZGS1VI0HX1EdrT7eUQEpj33jtrWLgF2gG
         ZCts5As15M6hGRC6Br8JQ6E7Il+TCeta5VPBqW/nzn1UzoEDCz54IME4wrSxhXgNmavE
         hZtds9stAPeLSgNwRTNFhndI5mXCL7znYaDXi1bVknEQ2ncQf4n1HEM6xd8pYGRwaC5B
         HEWA==
X-Gm-Message-State: AGi0Pub7hgkGzJCBvlYdoQxjiz51+/humlzgfp5XowsTjEYS32tuHAzk
        cMNCkbUtJOulmtxtuNcwkG6PkxOBQCq4jC0cY+725l+60Gp/OCHVPim6KShgsOGvXHV+h6SQVZs
        itwLmkVfK5C/M54ACEQ==
X-Received: by 2002:a1c:bc02:: with SMTP id m2mr17369071wmf.60.1587389255030;
        Mon, 20 Apr 2020 06:27:35 -0700 (PDT)
X-Google-Smtp-Source: APiQypKa9KTnw7bxej4mw34N8diZER1qvQDCuBcL+IJkA2Ms6lkLwpMbiELMPmpfSSm2Wtjk1oqJZQ==
X-Received: by 2002:a1c:bc02:: with SMTP id m2mr17369050wmf.60.1587389254684;
        Mon, 20 Apr 2020 06:27:34 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id j11sm1207803wrr.62.2020.04.20.06.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 06:27:33 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Subject: [PATCH] selinux: don't produce incorrect filename_trans_count
Date:   Mon, 20 Apr 2020 15:27:31 +0200
Message-Id: <20200420132731.1085015-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I thought I fixed the counting in filename_trans_read_helper() to count
the compat rule count correctly in the final version, but it's still
wrong. To really count the same thing as in the compat path, we'd need
to add up the cardinalities of stype bitmaps of all datums.

Since the kernel currently doesn't implement an ebitmap_cardinality()
function (and computing the proper count would just waste CPU cycles
anyway), just document that we use the field only in case of the old
format and stop updating it in filename_trans_read_helper().

Fixes: 430059024389 ("selinux: implement new format of filename transitions")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/policydb.c | 11 +++--------
 security/selinux/ss/policydb.h |  3 ++-
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index ef8d5b46b05b..1c0041576643 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -2016,12 +2016,7 @@ static int filename_trans_read_helper(struct policydb *p, void *fp)
 	if (rc)
 		goto out;
 
-	rc = ebitmap_set_bit(&p->filename_trans_ttypes, ttype, 1);
-	if (rc)
-		return rc;
-
-	p->filename_trans_count += ndatum;
-	return 0;
+	return ebitmap_set_bit(&p->filename_trans_ttypes, ttype, 1);
 
 out:
 	kfree(ft);
@@ -2051,7 +2046,7 @@ static int filename_trans_read(struct policydb *p, void *fp)
 	nel = le32_to_cpu(buf[0]);
 
 	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
-		p->filename_trans_count = nel;
+		p->compat_filename_trans_count = nel;
 		p->filename_trans = hashtab_create(filenametr_hash,
 						   filenametr_cmp, (1 << 11));
 		if (!p->filename_trans)
@@ -3568,7 +3563,7 @@ static int filename_trans_write(struct policydb *p, void *fp)
 		return 0;
 
 	if (p->policyvers < POLICYDB_VERSION_COMP_FTRANS) {
-		buf[0] = cpu_to_le32(p->filename_trans_count);
+		buf[0] = cpu_to_le32(p->compat_filename_trans_count);
 		rc = put_entry(buf, sizeof(u32), 1, fp);
 		if (rc)
 			return rc;
diff --git a/security/selinux/ss/policydb.h b/security/selinux/ss/policydb.h
index d3adb522d3f3..35dc6aa7904d 100644
--- a/security/selinux/ss/policydb.h
+++ b/security/selinux/ss/policydb.h
@@ -270,7 +270,8 @@ struct policydb {
 	struct ebitmap filename_trans_ttypes;
 	/* actual set of filename_trans rules */
 	struct hashtab *filename_trans;
-	u32 filename_trans_count;
+	/* only used if policyvers < POLICYDB_VERSION_COMP_FTRANS */
+	u32 compat_filename_trans_count;
 
 	/* bools indexed by (value - 1) */
 	struct cond_bool_datum **bool_val_to_struct;
-- 
2.25.3

