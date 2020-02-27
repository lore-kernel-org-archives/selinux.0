Return-Path: <SRS0=cYHv=4P=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68609C11D3D
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 16:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5FF2469C
	for <selinux@archiver.kernel.org>; Thu, 27 Feb 2020 16:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h/rO1qwH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729842AbgB0QDJ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:03:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32673 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729153AbgB0QDJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 27 Feb 2020 11:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582819388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hl0zGBH+n27gE0Df1dBcIr3nnNIxDiWCQl++8TVsIoo=;
        b=h/rO1qwHxaK9hMYnRIu4YYHVHI5exzZJV67FZvgrEbB147QlyUDndZDOea7qSu5Y3n2WYl
        BBH2gB5OdzyQa6L+W6ErlaTbubUZcmlH72pKggnP30c0KQWh3v8MYiaVI/7qSnkXOUuVqc
        FxcpmBwJq0hMe9OEG+jVgYB6xJPwtEw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-LR6XcntmORiQ0xrvDrlg5Q-1; Thu, 27 Feb 2020 11:03:06 -0500
X-MC-Unique: LR6XcntmORiQ0xrvDrlg5Q-1
Received: by mail-wr1-f71.google.com with SMTP id c6so24126wrm.18
        for <selinux@vger.kernel.org>; Thu, 27 Feb 2020 08:03:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hl0zGBH+n27gE0Df1dBcIr3nnNIxDiWCQl++8TVsIoo=;
        b=fZBLMRUOPcSw8B+nM+2jBWw5zs6Mj1wJ4W4PK5AxWNSkujZ0Rwe92owp5kMIfNKWxh
         92etD64Xah9p3VnDecwCCZHxhk0HHwltUviwFsOcOmBSKh7HujJna9grX7bW5XXXvfND
         rU373vRVlg8lKp+doh+G60kErjcDtmFCsiYp9XHvQ1kfc/g2lvBv40HyIeBCnvu7Q9Jk
         th5HzJQkRBZZ/hpxiq0Qcpr5jmGHqTSAfFsmz/4XUt3NRfOkuFDajKgMpnr4It+EgM5E
         8S3sGqm70xZ+2keJ6lJscfFiv0hoB1anW224t9tseBw4qbrbaPQH04Vx09gX4fxpRsVy
         2NRA==
X-Gm-Message-State: APjAAAW8TUruAxzgeNluytYpzbI/goY0NN4jKsnVEDGP1HMGTLxHZEw8
        vzQywcCZprA5NcKnGsGB1Yxo28JDtkOgJL+xdSW6Ts4AkFnWR+eQurL4JXaKDlY5B3qEMKQ4X5Q
        EkNxTgR9DJBrewFjKug==
X-Received: by 2002:a05:600c:291d:: with SMTP id i29mr202286wmd.39.1582819380924;
        Thu, 27 Feb 2020 08:03:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqxzoaNXpqxTYgYGeSWmf4uNVUQjUCiM/ufjVIt+fYP4pG/T8Mic8YvbPGeHKPs84NdgaiXp+Q==
X-Received: by 2002:a05:600c:291d:: with SMTP id i29mr202260wmd.39.1582819380694;
        Thu, 27 Feb 2020 08:03:00 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id d17sm8063456wmb.36.2020.02.27.08.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 08:03:00 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>
Subject: [PATCH 1/3] libsepol: skip unnecessary check in build_type_map()
Date:   Thu, 27 Feb 2020 17:02:55 +0100
Message-Id: <20200227160257.340737-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227160257.340737-1-omosnace@redhat.com>
References: <20200227160257.340737-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I copy-pasted it from a different part of the code, which had to deal
with policydb that isn't final yet. Since we only deal with the final
kernel policy here, we can skip the check for the type datum being NULL.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsepol/src/optimize.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/libsepol/src/optimize.c b/libsepol/src/optimize.c
index 1e5e97e8..4d835d47 100644
--- a/libsepol/src/optimize.c
+++ b/libsepol/src/optimize.c
@@ -40,8 +40,7 @@ static ebitmap_t *build_type_map(const policydb_t *p)
 		return NULL;
 
 	for (i = 0; i < p->p_types.nprim; i++) {
-		if (p->type_val_to_struct[i] &&
-		    p->type_val_to_struct[i]->flavor != TYPE_ATTRIB) {
+		if (p->type_val_to_struct[i]->flavor != TYPE_ATTRIB) {
 			if (ebitmap_cpy(&map[i], &p->type_attr_map[i]))
 				goto err;
 		} else {
-- 
2.24.1

