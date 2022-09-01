Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985F1ECAAD3
	for <selinux@archiver.kernel.org>; Thu,  1 Sep 2022 15:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbiIAP1M (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Sep 2022 11:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234539AbiIAP0n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Sep 2022 11:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6D3754AF
        for <selinux@vger.kernel.org>; Thu,  1 Sep 2022 08:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662045998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V7YMU843VlzNWC/pPcXDFCFCDg71epze0+Cwzb9ajlw=;
        b=g0g0vDEVHCnSMAYVt8KWC/tJLRLkxFcHwZdx0lfiwPK6uOQFJNtz1TTi8XX6AWIUtatVqt
        dfgGynX45eHIRVqyM7Ei3CAyxFlrL5uj2bQdcIZcrFuiMAutpybDJuVvZCcuHpVKxcCnnI
        hXsEu4j9f5t7qYktHobEDRrdEz38bPA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-43--_XjAHNFOFehTXhOlb9vew-1; Thu, 01 Sep 2022 11:26:37 -0400
X-MC-Unique: -_XjAHNFOFehTXhOlb9vew-1
Received: by mail-ej1-f69.google.com with SMTP id hr32-20020a1709073fa000b00730a39f36ddso6950707ejc.5
        for <selinux@vger.kernel.org>; Thu, 01 Sep 2022 08:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=V7YMU843VlzNWC/pPcXDFCFCDg71epze0+Cwzb9ajlw=;
        b=y4ULUM4i9yKyiu24+1bmUPT9zNbZP3zxZ1kFPv/EZVD8aGlvG1eqEC3Qgvlj7qPE0Y
         AlTYOlV/ylwa1fqGqWr6d96peWnyLOOmLG/KeIpa5S1Czqn6c46+cla+EsudXH01Sbxo
         iSh1DumjFznPKnmKyDhSi4nsY33QcXX+SLjef5EyMJaA6J7A0psSAs9bOE5leZb1B2QU
         K8c7jM9x4u4DyHBZku1T83SSkn6z2VbFewlyuoHr01h+o8xi20BjL/e3DaCGV9AEH15Q
         Wdauxr6tVqS1/ZtqGktJlkw20uu8OlKXbKGAnbHS62vL8bosBXGRm70my30phYJI00s1
         inNw==
X-Gm-Message-State: ACgBeo1zQitB/pLbkjnhF9JBwAgUFOR1toApdE9cQP4mfuQzGwWGCsEl
        OoA8Sax2IVrrTkPx0dIs49uFepntJql4rIATtzvApPIHb1pzg6fqvTQEk1icmGquOYueSFviSqn
        vvkRTi/pu+wzr0cATqA==
X-Received: by 2002:a05:6402:2791:b0:448:763c:666f with SMTP id b17-20020a056402279100b00448763c666fmr16544848ede.36.1662045996605;
        Thu, 01 Sep 2022 08:26:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6IWwgCT5rUYou5fGNheuAznqzf2ytt4UDRtNcZDjDbVuQbEp4YWjiAyIYJGVUT6zs409BVUA==
X-Received: by 2002:a05:6402:2791:b0:448:763c:666f with SMTP id b17-20020a056402279100b00448763c666fmr16544831ede.36.1662045996400;
        Thu, 01 Sep 2022 08:26:36 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o23-20020a170906775700b00730bfe6adc4sm8646031ejn.37.2022.09.01.08.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:26:35 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Pitt <mpitt@redhat.com>
Subject: [PATCH 2/2] fs: don't call capable() prematurely in simple_xattr_list()
Date:   Thu,  1 Sep 2022 17:26:32 +0200
Message-Id: <20220901152632.970018-3-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901152632.970018-1-omosnace@redhat.com>
References: <20220901152632.970018-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Calling capable() pre-emptively causes a problem for SELinux, which will
normally log a denial whenever capable() is called and the task's
SELinux context doesn't have the corresponding capability permission
allowed.

With the current implementation of simple_xattr_list(), any time a
process without CAP_SYS_ADMIN calls listxattr(2) or similar on a
filesystem that uses this function, a denial is logged even if there are
no trusted.* xattrs on the inode in question. In such situation, policy
writers are forced to chose one of the following options:

1. Grant CAP_SYS_ADMIN to the given SELinux domain even though it
   doesn't really need it. (Not good for security.)
2. Add a rule to the policy that will silence CAP_SYS_ADMIN denials for
   the given domain without actually granting it. (Not good, because now
   denials that make actual difference may be hidden, making
   troubleshooting harder.)
3. Do nothing and let the denials appear. (Not good, because the audit
   spam could obscure actual important denials.)

To avoid this misery, only call capable() when an actual trusted.* xattr
is encountered. This is somewhat less optimal, since capable() will now
be called once per each trusted.* xattr, but that's pretty unlikely to
matter in practice.

Even after this fix any process listing xattrs on an inode that has one
or more trusted.* ones may trigger an "irrelevant" denial if it doesn't
actually care about the trusted.* xattrs, but such cases should be rare
and thus silencing the denial in such cases would not be as big of a
deal.

Fixes: b09e0fa4b4ea ("tmpfs: implement generic xattr support")
Reported-by: Martin Pitt <mpitt@redhat.com>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 fs/xattr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index fad2344f1168..84a459ac779a 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1155,7 +1155,6 @@ static int xattr_list_one(char **buffer, ssize_t *remaining_size,
 ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 			  char *buffer, size_t size)
 {
-	bool trusted = capable(CAP_SYS_ADMIN);
 	struct simple_xattr *xattr;
 	ssize_t remaining_size = size;
 	int err = 0;
@@ -1180,7 +1179,7 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 	rcu_read_lock();
 	list_for_each_entry_rcu(xattr, &xattrs->head, list) {
 		/* skip "trusted." attributes for unprivileged callers */
-		if (!trusted && xattr_is_trusted(xattr->name))
+		if (xattr_is_trusted(xattr->name) && !capable(CAP_SYS_ADMIN))
 			continue;
 
 		err = xattr_list_one(&buffer, &remaining_size, xattr->name);
-- 
2.37.2

