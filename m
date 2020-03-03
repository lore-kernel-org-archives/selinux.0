Return-Path: <SRS0=zB1t=4U=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0773DC3F2CD
	for <selinux@archiver.kernel.org>; Tue,  3 Mar 2020 11:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3D920848
	for <selinux@archiver.kernel.org>; Tue,  3 Mar 2020 11:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E+LsumRB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgCCL3Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 Mar 2020 06:29:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46924 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725818AbgCCL3Q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 Mar 2020 06:29:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583234955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QBKY1CBnU+51huBJoRNlasBWhYoL2UuyMn57mDSmDP4=;
        b=E+LsumRBmNYD0Vij9RA7VqhlNtem87ec+vggExzYyO4IccMl8LMQfHXzWaKKWlJclOqL+8
        BgIYziB2EnZ/ni4s4UQv0IY9tro6oVnUYzHSBPwhY4Psoly/xHrfwKwMTIbgyf8ih4wDSv
        2SIUU/qRqolqZdgkbguFnJT2PTWhW7g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-bCz8KQIbPYWHJUYaBQH7-w-1; Tue, 03 Mar 2020 06:29:14 -0500
X-MC-Unique: bCz8KQIbPYWHJUYaBQH7-w-1
Received: by mail-wm1-f71.google.com with SMTP id w12so531069wmc.3
        for <selinux@vger.kernel.org>; Tue, 03 Mar 2020 03:29:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QBKY1CBnU+51huBJoRNlasBWhYoL2UuyMn57mDSmDP4=;
        b=oyFyw5RBd2ELTORsOuttg5NQ5D7W4tShX5KgLJIyVvtko0Gl8OmUIlEvpHoRuss56M
         BJqkvTUVaPfrZ2QbLF4ElmofWQ9jBcwxrKFGI8C1MsijgGXVmAzwa9EUikOq4/Xs6eah
         8x3iFEoJbfXcReHtPFwRulNXEjoRWkIDwD6tljvYS7QqGO5n/ggwg17Sv5WVbLAyl4Fz
         wMCA9S7HGp4tInxbpRE98+Qr8aWtVQ2kx8106GnLkHrZyS/V+fSCUZMiIeVoiHvB5qJ/
         +i9rYYNGdZ7d/q47O+lMc0qG4CYWOuac9MMrdOXayeJDcy4Id+YMW8qBV2WgIbpOlNAG
         Gp4g==
X-Gm-Message-State: ANhLgQ3cALawt6w8GlijXhVBHXvSr4MNOmMRyrp/ylGSvXsZ3T/uySj6
        Omy36WZsCHV2GBbRSc9zLgb2rJdW+79Lq69qB4shSCtDqdDb2pGqyjqgClePaGHLzfjokh5GOY7
        PNfNcvVhPjRZB0uphUw==
X-Received: by 2002:a1c:e143:: with SMTP id y64mr4017065wmg.131.1583234952915;
        Tue, 03 Mar 2020 03:29:12 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuEpXP2uJDwT56AZlvuRTaG9MYXx7HuXXO6qyEgNdyxEgAmr9qsWEZu0OrEObDx+RC9VNI31g==
X-Received: by 2002:a1c:e143:: with SMTP id y64mr4017048wmg.131.1583234952709;
        Tue, 03 Mar 2020 03:29:12 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id u1sm14669771wrt.78.2020.03.03.03.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 03:29:12 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH] selinux: clean up error path in policydb_init()
Date:   Tue,  3 Mar 2020 12:29:10 +0100
Message-Id: <20200303112910.147788-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit e0ac568de1fa ("selinux: reduce the use of hard-coded hash sizes")
moved symtab initialization out of policydb_init(), but left the cleanup
of symtabs from the error path. This patch fixes the oversight.

Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 security/selinux/ss/policydb.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/security/selinux/ss/policydb.c b/security/selinux/ss/policydb.c
index 7739369f5d9a..00edcd216aaa 100644
--- a/security/selinux/ss/policydb.c
+++ b/security/selinux/ss/policydb.c
@@ -463,36 +463,28 @@ static int rangetr_cmp(struct hashtab *h, const void *k1, const void *k2)
  */
 static int policydb_init(struct policydb *p)
 {
-	int i, rc;
+	int rc;
 
 	memset(p, 0, sizeof(*p));
 
 	rc = avtab_init(&p->te_avtab);
 	if (rc)
-		goto out;
+		return rc;
 
 	rc = cond_policydb_init(p);
 	if (rc)
-		goto out;
+		return rc;
 
 	p->filename_trans = hashtab_create(filenametr_hash, filenametr_cmp,
 					   (1 << 11));
-	if (!p->filename_trans) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (!p->filename_trans)
+		return -ENOMEM;
 
 	ebitmap_init(&p->filename_trans_ttypes);
 	ebitmap_init(&p->policycaps);
 	ebitmap_init(&p->permissive_map);
 
 	return 0;
-out:
-	for (i = 0; i < SYM_NUM; i++) {
-		hashtab_map(p->symtab[i].table, destroy_f[i], NULL);
-		hashtab_destroy(p->symtab[i].table);
-	}
-	return rc;
 }
 
 /*
-- 
2.24.1

