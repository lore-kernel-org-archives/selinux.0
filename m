Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C70C34022
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 16:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895F12469C
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 16:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2THaQV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgB0QDH (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:03:07 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29285 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729153AbgB0QDH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 11:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582819385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y5V5O4Frh8/tdoAgx14UNDt+09hzQ6GHQblCrdvgshk=;
        b=U2THaQV6groTJMlrg7Y/zryTS5fjZzB6IrFkYipiys/NKmaDtjkjk+7SMEHNEOw68EVxLg
        7tQxMq60ovx4IYG5VIRIrDKUgRGyEXrnvg/wCi9JSfHnBQFG1Pim3CPUUI0DrSYs/WzSjY
        E9nDrjanZUUdDaM5n8JwHl9jUVtK2qA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-J3bR5OLePCCejGI8xgm0Zg-1; Thu, 27 Feb 2020 11:03:03 -0500
X-MC-Unique: J3bR5OLePCCejGI8xgm0Zg-1
Received: by mail-wr1-f70.google.com with SMTP id o9so28706wrw.14
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 08:03:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y5V5O4Frh8/tdoAgx14UNDt+09hzQ6GHQblCrdvgshk=;
        b=P3mLHUCWcn800ewZF8HIOa0dcRsJWVsQ3TfaVW1JGaomnGk5jGYjxNSxzi3nw8ndJd
         e3PlSReIya/E1DJHzcxl4uRbGuGWzd6AupsXcyv31oO+/vCk2VyH54c8JT9DoFcVOqpZ
         38FwrCdWevxImxXvLUFe4hhuB6ESSRBsYThwXZIbm55KacJuFI0nQqUbQjQur8nRSdPR
         HaqOoDak2V65JyGB+JbwSBLvaQ8nUF5yJpMxf75S9GgTWeviLn3/YhlAZcrcKGNNB/+7
         tT36uzBAzXI0lI8t2u2cfQl7HzXyWblW2K7Su8/jQMesM036p+uD25sA3lw2mz9ymeoX
         rENQ==
X-Gm-Message-State: APjAAAVERF+sZlfDy+HDe9yDQo6wzL0J3NFs9BySyc6O1W9Qrb3cy0QE
        E8PT56fAcaxdazmCvl+1vG/kTt1kGKkv6IAYIduah+h0g/c9jEloBhnyTLrQYQvsOg+EXClT7Y9
        7fv5/udKXARGgB2gyLg==
X-Received: by 2002:adf:f310:: with SMTP id i16mr5823202wro.326.1582819381746;
        Thu, 27 Feb 2020 08:03:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqyHVrhKV5Pcn1E+9GcBYmThs5tTBv2/mcIFx0fHOPG8USvtFz7WT3UXBBbCGbx5K4YnTRfhKw==
X-Received: by 2002:adf:f310:: with SMTP id i16mr5823183wro.326.1582819381560;
        Thu, 27 Feb 2020 08:03:01 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id d17sm8063456wmb.36.2020.02.27.08.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 08:03:01 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>
Subject: [PATCH 2/3] libsepol: optimize inner loop in build_type_map()
Date:   Thu, 27 Feb 2020 17:02:56 +0100
Message-Id: <20200227160257.340737-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227160257.340737-1-omosnace@redhat.com>
References: <20200227160257.340737-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Only attributes can be a superset of another attribute, so we can skip
non-attributes right away.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsepol/src/optimize.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
index 4d835d47..2b5102af 100644
--- a/libsepol/src/optimize.c
+++ b/libsepol/src/optimize.c
@@ -50,6 +50,9 @@ static ebitmap_t *build_type_map(const policydb_t *p)
 			for (k = 0; k < p->p_types.nprim; k++) {
 				ebitmap_t *types_k = &p->attr_type_map[k];
 
+				if (p->type_val_to_struct[k]->flavor != TYPE_ATTRIB)
+					continue;
+
 				if (ebitmap_contains(types_k, types_i)) {
 					if (ebitmap_set_bit(&map[i], k, 1))
 						goto err;
-- 
2.24.1

