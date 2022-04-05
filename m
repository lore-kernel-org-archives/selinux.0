Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F259DC433FE
	for <selinux@archiver.kernel.org>; Tue,  5 Apr 2022 07:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbiDEHWq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 5 Apr 2022 03:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiDEHVc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 5 Apr 2022 03:21:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFD3D1D8
        for <selinux@vger.kernel.org>; Tue,  5 Apr 2022 00:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649143109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9VdeAnroTVs483TxGgrc2QXqOoo0vxzRIttvuzKdmxE=;
        b=bRD6xJnEBa7VfqvUtvxkmWr/w83d+qBZIjy1ybtBIR56HFaJX3qi1OC7XtkPhuC1l4ZfVL
        T7qWcXGyft3FmtzLyT2q3f5wMQ66LT4EjzqykpM7s0JzAv0lRjgV0fo8aUkxdvyYQAj25x
        ASHNTVzCIdR3LHN9MJEuKPH0xKhparw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-lBdnBUuHMbqe_HppweCSEA-1; Tue, 05 Apr 2022 03:18:27 -0400
X-MC-Unique: lBdnBUuHMbqe_HppweCSEA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AA5B899EE6
        for <selinux@vger.kernel.org>; Tue,  5 Apr 2022 07:18:27 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF63D401E0C;
        Tue,  5 Apr 2022 07:18:26 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2] setfiles.8: -q is deprecated and has no effect
Date:   Tue,  5 Apr 2022 09:17:36 +0200
Message-Id: <20220405071735.251995-1-plautrba@redhat.com>
In-Reply-To: <CAP+JOzTVdo2N8YKuhaS7xBVYCUjNFfb7NHk=yqTN1LZRncB+gA@mail.gmail.com>
References: <CAP+JOzTVdo2N8YKuhaS7xBVYCUjNFfb7NHk=yqTN1LZRncB+gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/setfiles/setfiles.8 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/setfiles/setfiles.8 b/policycoreutils/setfiles/setfiles.8
index 15f939d1bee0..5267064de3b5 100644
--- a/policycoreutils/setfiles/setfiles.8
+++ b/policycoreutils/setfiles/setfiles.8
@@ -124,7 +124,9 @@ and
 options are mutually exclusive.
 .TP 
 .B \-q
-Deprecated, was only used to stop printing inode association parameters.
+Deprecated and replaced by
+.B \-v
+. Has no effect on other options or on program behavior.
 .TP 
 .BI \-r \ rootpath
 use an alternate root path. Used in meta-selinux for OpenEmbedded/Yocto builds
-- 
2.35.1

