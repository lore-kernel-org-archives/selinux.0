Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DF6C433FE
	for <selinux@archiver.kernel.org>; Thu, 13 Oct 2022 13:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJMNXu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Oct 2022 09:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJMNXf (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Oct 2022 09:23:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF8EF4198
        for <selinux@vger.kernel.org>; Thu, 13 Oct 2022 06:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665667412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/+2IDaoUJtpWKZpdlV9PD6m96Mo+Q8CBgaDSxxeSnyM=;
        b=bUaYnCxE+Y6Go0BNsdOlSazalDwVlUbhV1NNdyrDaHyP2RwJ9ottxtOXyDyF+55pk3R3nN
        lTwXFo/hPuaywgSY4vu+TKP7OLO9RB183oQWcNra3x82T1vBXhvFb6lS8b1CEfnvSRwV8o
        /2A4R/ZBCha/OjToLwN1Gl9WUTkGSZo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-57-JuRugiVAOlWBzMxGTyjwAA-1; Thu, 13 Oct 2022 09:23:31 -0400
X-MC-Unique: JuRugiVAOlWBzMxGTyjwAA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E0D0F3C0F234
        for <selinux@vger.kernel.org>; Thu, 13 Oct 2022 13:23:20 +0000 (UTC)
Received: from localhost.localdomain (ovpn-193-3.brq.redhat.com [10.40.193.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D7C05200C0EA;
        Thu, 13 Oct 2022 13:23:18 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 1/2] sandbox: Do not try to remove tmpdir twice if uid == 0
Date:   Thu, 13 Oct 2022 15:23:11 +0200
Message-Id: <20221013132312.294095-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

If the user is root, tmpdir is already wiped out.

Fixes:
    # sandbox -T /root/tmp -- id
    uid=0(root) gid=0(root) groups=0(root) context=unconfined_u:unconfined_r:sandbox_t:s0:c696,c756
    Failed to remove directory /tmp/.sandbox-root-KIlB59: No such file or directory

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 sandbox/seunshare.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 8917a0f9bd42..dd1d7ddbdc89 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -414,7 +414,7 @@ static int cleanup_tmpdir(const char *tmpdir, const char *src,
 		rc++;
 	}
 
-	if (rmdir(tmpdir) == -1)
+	if (pwd->pw_uid != 0 && rmdir(tmpdir) == -1)
 		fprintf(stderr, _("Failed to remove directory %s: %s\n"), tmpdir, strerror(errno));
 	if ((uid_t)setfsuid(pwd->pw_uid) != 0) {
 		fprintf(stderr, _("unable to switch back to user after clearing tmp dir\n"));
-- 
2.37.3

