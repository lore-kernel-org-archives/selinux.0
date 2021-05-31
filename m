Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D52C47099
	for <selinux@archiver.kernel.org>; Mon, 31 May 2021 13:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ED2561623
	for <selinux@archiver.kernel.org>; Mon, 31 May 2021 13:49:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232186AbhEaNvC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 31 May 2021 09:51:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23630 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232976AbhEaNrj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 31 May 2021 09:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622468759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y54MkJ1DkDPUmNpg6ptgLnrQ5/7BnVMsItBiTZSYR8Q=;
        b=U/ffQNWsGWzo+UviRzP3xE4wjTrZ8lThoMyWmEk2Hx2OnHYnexzApeMsvMWkS0MTMYPUh/
        z5vK9mYNBH/ODqPopWq3Iy6xuw4x+9s7DRYa8dWT6V0bcIXSBqbT8/rt0rluPKXZfUnY1I
        jnE4BDkdrSBSKj99SFDM/fZcP2enL4A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-AjF5-yO5PKy1ZPlxqlSV7A-1; Mon, 31 May 2021 09:45:57 -0400
X-MC-Unique: AjF5-yO5PKy1ZPlxqlSV7A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E7774189C44F;
        Mon, 31 May 2021 13:45:54 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B3B5B5C1B4;
        Mon, 31 May 2021 13:45:52 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>, linux-audit@redhat.com,
        io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH 2/2] audit: block PERM fields being used with io_uring filtering
Date:   Mon, 31 May 2021 09:44:55 -0400
Message-Id: <8d1435a4b5db9139cc8eebce633f14872dd3a007.1622467740.git.rgb@redhat.com>
In-Reply-To: <CAHC9VhTr_hw_RBPf5yGD16j-qV2tbjjPJkimMNNQZBHtrJDbuQ@mail.gmail.com>
References: <CAHC9VhTr_hw_RBPf5yGD16j-qV2tbjjPJkimMNNQZBHtrJDbuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The commit ("audit: add filtering for io_uring records") added support for
filtering io_uring operations.  The PERM field is invalid for io_uring
filtering, so block it.

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
 kernel/auditfilter.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index bcdedfd1088c..d75acb014ccd 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -336,6 +336,10 @@ static int audit_field_valid(struct audit_entry *entry, struct audit_field *f)
 		if (entry->rule.listnr != AUDIT_FILTER_FS)
 			return -EINVAL;
 		break;
+	case AUDIT_PERM:
+		if (entry->rule.listnr == AUDIT_FILTER_URING_EXIT)
+			return -EINVAL;
+		break;
 	}
 
 	switch (entry->rule.listnr) {
-- 
2.27.0

