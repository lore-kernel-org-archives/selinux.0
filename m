Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FAFC7EE23
	for <selinux@archiver.kernel.org>; Thu,  8 Jun 2023 01:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjFHBxm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Jun 2023 21:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjFHBxk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Jun 2023 21:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA6C269F
        for <selinux@vger.kernel.org>; Wed,  7 Jun 2023 18:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686189178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vBJL1bwxU7sXc9bwKfuQaD318hfOQPdvqm5NwzIo8N0=;
        b=RcCpU7knvHhTCV6qwMZGU1N+cSrW2gh0W/OcbNOmQWZwBqJeOOcc+s6ZgwTi15Rc1DKOf/
        r5/Fb/d8wKy6XcE4jFZ55ZfDiCTxdowc5iZEpy+Vj+UmgxrpyyU3BZojnlkYWD/wOHqvz1
        7RcgMLS5CMF6RVlrmPteJvO454K03AE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-J4SG11zQM2aJa4pNDkvhfw-1; Wed, 07 Jun 2023 21:52:56 -0400
X-MC-Unique: J4SG11zQM2aJa4pNDkvhfw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B8228007D9
        for <selinux@vger.kernel.org>; Thu,  8 Jun 2023 01:52:56 +0000 (UTC)
Received: from dev64.localdomain.com (unknown [10.64.240.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A7194403367;
        Thu,  8 Jun 2023 01:52:55 +0000 (UTC)
From:   Masatake YAMATO <yamato@redhat.com>
To:     selinux@vger.kernel.org
Cc:     yamato@redhat.com
Subject: [PATCH 3/4] dispol: handle EOF in user interaction
Date:   Thu,  8 Jun 2023 10:52:40 +0900
Message-Id: <20230608015241.2454912-3-yamato@redhat.com>
In-Reply-To: <20230608015241.2454912-1-yamato@redhat.com>
References: <20230608015241.2454912-1-yamato@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 checkpolicy/test/dispol.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/checkpolicy/test/dispol.c b/checkpolicy/test/dispol.c
index e0748e90..e1f6d7fc 100644
--- a/checkpolicy/test/dispol.c
+++ b/checkpolicy/test/dispol.c
@@ -531,6 +531,8 @@ int main(int argc, char **argv)
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

