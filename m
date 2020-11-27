Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D11C2D0E4
	for <selinux@archiver.kernel.org>; Fri, 27 Nov 2020 08:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 440E222249
	for <selinux@archiver.kernel.org>; Fri, 27 Nov 2020 08:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9L132Ay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgK0Ixh (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 Nov 2020 03:53:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36598 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725985AbgK0Ixh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 Nov 2020 03:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606467216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sin5tmcYh0FNYxdoTkiTRJlBjR4D3F5rVA7owkAUb6U=;
        b=T9L132AyhTPuWX8o/nJbxnTGn7oobEShfzFaOp/ajC3SLiJqb3yZGEVLaxQjSa0bRF+9cu
        8KZ2FzP7g1MdjHFXZtZgVIawG1o0H0TeVPe3SL3qyQKSB8OZWVo6482zUMwv4N9p+bDJ93
        FTfFsgdg25FfkqRdL/EHihXhzO4adgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-_LPceE6jMAWSD6zpw9NwaQ-1; Fri, 27 Nov 2020 03:53:32 -0500
X-MC-Unique: _LPceE6jMAWSD6zpw9NwaQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8187107AD3B;
        Fri, 27 Nov 2020 08:53:31 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.193.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AB3E519C46;
        Fri, 27 Nov 2020 08:53:30 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Hu Keping <hukeping@huawei.com>
Subject: [PATCH 2/3] Use X.Y instead of date for release tag
Date:   Fri, 27 Nov 2020 09:52:20 +0100
Message-Id: <20201127085220.813760-3-plautrba@redhat.com>
In-Reply-To: <20201127085220.813760-1-plautrba@redhat.com>
References: <20201127085220.813760-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: Hu Keping <hukeping@huawei.com>

As per discussed at github issue[1] and mailing list[2], we consider
a version format of X.Y starting at 3.2.

[1]: https://github.com/SELinuxProject/selinux/issues/270
[2]: https://lore.kernel.org/selinux/87d004wan2.fsf@redhat.com/T/#u

Signed-off-by: Hu Keping <hukeping@huawei.com>
---
 scripts/release | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/release b/scripts/release
index 0781374954e4..040aaf68e86a 100755
--- a/scripts/release
+++ b/scripts/release
@@ -7,7 +7,7 @@ if [ \! -d $WIKIDIR ]; then
     git clone git@github.com:SELinuxProject/selinux.wiki.git $WIKIDIR
 fi
 
-RELEASE_TAG=$(date '+%Y%m%d')
+RELEASE_TAG=`cat VERSION`
 DEST=releases/$RELEASE_TAG
 DIRS="libsepol libselinux libsemanage checkpolicy secilc policycoreutils mcstrans restorecond semodule-utils"
 DIRS_NEED_PREFIX="dbus gui python sandbox"
@@ -43,7 +43,7 @@ echo "Add the following to the $WIKIDIR/Releases.md wiki page:"
 
 echo ""
 
-echo "## Release $(date '+%Y-%m-%d')"
+echo "## Release $RELEASE_TAG"
 
 echo ""
 
-- 
2.29.2

