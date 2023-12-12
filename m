Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZm6AGYh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A48E109
	for <selinux@vger.kernel.org>; Tue, 12 Dec 2023 05:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702387049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kbn/Pj7lGZv5FQhku3s01YJlXyJKSmX12DB6Cc5Zb3k=;
	b=TZm6AGYhRa3K8WWZ4Mbsyvhd6juFKv69S7BeqvP76RLiPMWvfBclnFSxOVcwvwIlbruEbH
	a41o5qwmrmBnfpysDeabuhKzjw9QYlQ5gMO4l2jV+z6tSGNZ10vvgbkUuZdKE7r3AO7kB5
	UNN8sFmn3St+PfjDKlqQ1rVuhphfctM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-267-r6trOJMmMXybz5kfVgFA4A-1; Tue,
 12 Dec 2023 08:17:24 -0500
X-MC-Unique: r6trOJMmMXybz5kfVgFA4A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED34928EC102;
	Tue, 12 Dec 2023 13:17:22 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.39.208.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C38C31121306;
	Tue, 12 Dec 2023 13:17:19 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
	xieyongji@bytedance.com,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	david.marchand@redhat.com,
	lulu@redhat.com,
	casey@schaufler-ca.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: [PATCH v5 1/4] vduse: validate block features only with block devices
Date: Tue, 12 Dec 2023 14:17:09 +0100
Message-ID: <20231212131712.1816324-2-maxime.coquelin@redhat.com>
In-Reply-To: <20231212131712.1816324-1-maxime.coquelin@redhat.com>
References: <20231212131712.1816324-1-maxime.coquelin@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

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
index 0ddd4b8abecb..0486ff672408 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -1671,13 +1671,14 @@ static bool device_is_allowed(u32 device_id)
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
@@ -1704,7 +1705,7 @@ static bool vduse_validate_config(struct vduse_dev_config *config)
 	if (!device_is_allowed(config->device_id))
 		return false;
 
-	if (!features_is_valid(config->features))
+	if (!features_is_valid(config))
 		return false;
 
 	return true;
-- 
2.43.0

