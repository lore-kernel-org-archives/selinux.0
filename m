Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466BEC433EF
	for <selinux@archiver.kernel.org>; Wed,  8 Jun 2022 17:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbiFHRXE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jun 2022 13:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiFHRV4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jun 2022 13:21:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98DE7476C52
        for <selinux@vger.kernel.org>; Wed,  8 Jun 2022 10:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654708198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ndTkbnQlx6y+cgjOJCPSW+ftUDh4rgMyrSCvpsy9I2c=;
        b=Dk0C4htE41lwtr2uJ6UrE/NqgqqxNwGF0NqpDcKzJH+hLSqwQF3DGeeZQ/Y79Sm9UQE3tR
        FO+/yJPq4AizQjxVttkns19JrK/ltdwgCQ5In5FpUnupy67ZhVQK0aycPlVj7kGtrhfkyG
        EwFUzjLu/OJod9zHu1bp+Vf4yu5VG0I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-YqefBKW_MlmW2IUD1k0_ew-1; Wed, 08 Jun 2022 13:09:57 -0400
X-MC-Unique: YqefBKW_MlmW2IUD1k0_ew-1
Received: by mail-wr1-f69.google.com with SMTP id w8-20020adfde88000000b00213b7fa3a37so4241032wrl.2
        for <selinux@vger.kernel.org>; Wed, 08 Jun 2022 10:09:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ndTkbnQlx6y+cgjOJCPSW+ftUDh4rgMyrSCvpsy9I2c=;
        b=0Lf6IcXEjLFj+5H4FCdVajDaYOcDbeUq7fLn+yb9vEpneZcCJdgLSHvcyB/0GdYI3s
         0f5pNxo/bxAYaNOLE84MsJ+rN/BUeV1cWJV/yNvBRVvw96szJDRvsDkubg/4xpzDkjzc
         Hmc1jcW8M9/RByqgRepShOer/U0YGyu0uttu3gwUofkITXXhFNg7IfoXvC8qa7RY7KWz
         ZlzeAfoSBC5820dY52H2e9pztOQ4fka9i6U0lj53o+o8nNJsBvUSClP1z5OgZo2ab7vr
         z1x2AouBsN5HcYs5Ip5nFovIhLyro8dkmwLq3vXmm5LHuMbe15TpXyowv69Ye6y5K346
         ZQuA==
X-Gm-Message-State: AOAM530jdv6f+/YaY25o4nPchjKBjfsC+K3OAjIOE5QI6XHR0qY3z9t9
        o9diNpDLDQGUvtWhPgLAJiwSZFyNU90Z4nskif5ZiiFACobLiXEQYg+bKepgWplHaDqLm5rs5fG
        SozDaOkmNluWJwC35L9xiFnXn8kC0z5xW57CBseg0nTGlQVP2tKI/nvGVR3u/CmVdx4PwYA==
X-Received: by 2002:adf:d1c9:0:b0:20f:c3dc:e980 with SMTP id b9-20020adfd1c9000000b0020fc3dce980mr33970785wrd.552.1654708196042;
        Wed, 08 Jun 2022 10:09:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQupNqRSCE1jeTztGIYqZQSLrlmzH/ExWzZiylv2HY1nb3f33HyKDxHQOJJajq3/NwaRiZNw==
X-Received: by 2002:adf:d1c9:0:b0:20f:c3dc:e980 with SMTP id b9-20020adfd1c9000000b0020fc3dce980mr33970763wrd.552.1654708195721;
        Wed, 08 Jun 2022 10:09:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b106:e300:32b0:6ebb:8ca4:d4d3])
        by smtp.gmail.com with ESMTPSA id m2-20020adfe942000000b0020fcaba73bcsm22176194wrn.104.2022.06.08.10.09.54
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 10:09:55 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace 1/2] libsemanage: always write kernel policy when check_ext_changes is specified
Date:   Wed,  8 Jun 2022 19:09:53 +0200
Message-Id: <20220608170954.114668-2-omosnace@redhat.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220608170954.114668-1-omosnace@redhat.com>
References: <20220608170954.114668-1-omosnace@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

For the use case of rebuilding the policy afte package updates, we need
the check_ext_changes operation to always do at least the do_write_kernel
step, because the various semanage dbs may have also changed content
relative to the current binary policy. As this step is itself relatively
fast, we can do it unconditionally.

Fixes: 286a679fadc4 ("libsemanage: optionally rebuild policy when modules are changed externally")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 libsemanage/include/semanage/handle.h | 2 +-
 libsemanage/src/direct_api.c          | 8 +++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/libsemanage/include/semanage/handle.h b/libsemanage/include/semanage/handle.h
index 0157be4f..4cf30815 100644
--- a/libsemanage/include/semanage/handle.h
+++ b/libsemanage/include/semanage/handle.h
@@ -67,7 +67,7 @@ extern void semanage_set_reload(semanage_handle_t * handle, int do_reload);
 extern void semanage_set_rebuild(semanage_handle_t * handle, int do_rebuild);
 
 /* set whether to rebuild the policy on commit when potential changes
- * to module files since last rebuild are detected,
+ * to store files since last rebuild are detected,
  * 1 for yes (default), 0 for no */
 extern void semanage_set_check_ext_changes(semanage_handle_t * handle, int do_check);
 
diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
index 7206483a..7aa081ab 100644
--- a/libsemanage/src/direct_api.c
+++ b/libsemanage/src/direct_api.c
@@ -1437,13 +1437,15 @@ static int semanage_direct_commit(semanage_handle_t * sh)
 	 * Determine what else needs to be done.
 	 * We need to write the kernel policy if we are rebuilding
 	 * or if any other policy component that lives in the kernel
-	 * policy has been modified.
+	 * policy has been modified. We also want to force it when
+	 * check_ext_changes was specified as the various dbases may have
+	 * changes as well.
 	 * We need to install the policy files if any of the managed files
 	 * that live under /etc/selinux (kernel policy, seusers, file contexts)
 	 * will be modified.
 	 */
-	do_write_kernel = do_rebuild | ports_modified | ibpkeys_modified |
-		ibendports_modified |
+	do_write_kernel = do_rebuild | sh->check_ext_changes |
+		ports_modified | ibpkeys_modified | ibendports_modified |
 		bools->dtable->is_modified(bools->dbase) |
 		ifaces->dtable->is_modified(ifaces->dbase) |
 		nodes->dtable->is_modified(nodes->dbase) |
-- 
2.36.1

