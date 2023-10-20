Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A08BC00A98
	for <selinux@archiver.kernel.org>; Fri, 20 Oct 2023 15:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377830AbjJTP7Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 20 Oct 2023 11:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377790AbjJTP7Y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 20 Oct 2023 11:59:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1615E124
        for <selinux@vger.kernel.org>; Fri, 20 Oct 2023 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697817520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PrVd5hNLS1wjnMKJG4uMD0VRG9l+SsuhqjwmjWwDMM4=;
        b=IJuFp/Fx6ueSuAXkSsCQKYqbAKCc+kvqPmug7M88Jlut33ubCiktGYlRLc9gsKlihBPILm
        CiLohKWjDZ3GiA4DTjIrwb6/cl57t7f1Uxn1OPEIEUmG7D++3tm0wM/m03YWNwFcoxjhTc
        dDvJKlxWo7SiNAQxuNkLBUlx6Oq6mX0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-oJ_RXLPwNCCswWlW3aS1YA-1; Fri, 20 Oct 2023 11:58:33 -0400
X-MC-Unique: oJ_RXLPwNCCswWlW3aS1YA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CED2857D07;
        Fri, 20 Oct 2023 15:58:32 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.39.208.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 61637503B;
        Fri, 20 Oct 2023 15:58:29 +0000 (UTC)
From:   Maxime Coquelin <maxime.coquelin@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        xieyongji@bytedance.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        david.marchand@redhat.com, lulu@redhat.com
Cc:     Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v4 1/4] vduse: validate block features only with block devices
Date:   Fri, 20 Oct 2023 17:58:16 +0200
Message-ID: <20231020155819.24000-2-maxime.coquelin@redhat.com>
In-Reply-To: <20231020155819.24000-1-maxime.coquelin@redhat.com>
References: <20231020155819.24000-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This patch is preliminary work to enable network device
type support to VDUSE.

As VIRTIO_BLK_F_CONFIG_WCE shares the same value as
VIRTIO_NET_F_HOST_TSO4, we need to restrict its check
to Virtio-blk device type.

Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Xie Yongji <xieyongji@bytedance.com>
Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index df7869537ef1..5b3879976b3d 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1662,13 +1662,14 @@ static bool device_is_allowed(u32 device_id)
 	return false;
 }
 
-static bool features_is_valid(u64 features)
+static bool features_is_valid(struct vduse_dev_config *config)
 {
-	if (!(features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
+	if (!(config->features & (1ULL << VIRTIO_F_ACCESS_PLATFORM)))
 		return false;
 
 	/* Now we only support read-only configuration space */
-	if (features & (1ULL << VIRTIO_BLK_F_CONFIG_WCE))
+	if ((config->device_id == VIRTIO_ID_BLOCK) &&
+			(config->features & (1ULL << VIRTIO_BLK_F_CONFIG_WCE)))
 		return false;
 
 	return true;
@@ -1695,7 +1696,7 @@ static bool vduse_validate_config(struct vduse_dev_config *config)
 	if (!device_is_allowed(config->device_id))
 		return false;
 
-	if (!features_is_valid(config->features))
+	if (!features_is_valid(config))
 		return false;
 
 	return true;
-- 
2.41.0

