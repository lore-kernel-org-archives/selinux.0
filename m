Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB10C7EE2C
	for <selinux@archiver.kernel.org>; Wed, 31 May 2023 01:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbjEaBdX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 May 2023 21:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjEaBdW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 May 2023 21:33:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499D010C
        for <selinux@vger.kernel.org>; Tue, 30 May 2023 18:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685496759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oBPuimJWlm9ZdVVc8N1yEv41cmZoFmuJoClvLGn8pqo=;
        b=GHJubIZp/gO3ZiWuErhcmIMRlDO7RVmCmCIsT8DBVYE4qoQKDNzyjAXX3h4Lwo+i6Wb/KU
        It+RpESlrWGPZ6tVguhCV5dohnVNgeOQQU71EoKr0RDV+Y6UTHTG3ptoHOSWDTUwyW52tH
        O3OPsqrAcxQ0LKgMSwGMLN2/iEeyEjU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-c3RiI5TNPiK9uq6BgdN8jw-1; Tue, 30 May 2023 21:32:38 -0400
X-MC-Unique: c3RiI5TNPiK9uq6BgdN8jw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C948A101A531
        for <selinux@vger.kernel.org>; Wed, 31 May 2023 01:32:37 +0000 (UTC)
Received: from dev64.localdomain.com (unknown [10.64.240.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21657140EBB8;
        Wed, 31 May 2023 01:32:36 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     selinux@vger.kernel.org
Cc:     yamato@redhat.com
Subject: [PATCH 3/4] dismod: handle EOF in user interaction
Date:   Wed, 31 May 2023 10:32:23 +0900
Message-Id: <20230531013224.1135775-3-yamato@redhat.com>
In-Reply-To: <20230531013224.1135775-1-yamato@redhat.com>
References: <20230531013224.1135775-1-yamato@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 checkpolicy/test/dismod.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/checkpolicy/test/dismod.c b/checkpolicy/test/dismod.c
index f1b879b0..3b81b1ce 100644
--- a/checkpolicy/test/dismod.c
+++ b/checkpolicy/test/dismod.c
@@ -921,6 +921,8 @@ int main(int argc, char **argv)
 	for (;;) {
 		printf("\nCommand (\'m\' for menu):  ");
 		if (fgets(ans, sizeof(ans), stdin) == NULL) {
+			if (feof(stdin))
+				break;
 			fprintf(stderr, "fgets failed at line %d: %s\n", __LINE__,
 					strerror(errno));
 			continue;
-- 
2.40.1

