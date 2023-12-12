Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHJhJDXR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11634125
	for <selinux@vger.kernel.org>; Tue, 12 Dec 2023 05:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702387050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TaBsHxHFMnJzAJsTX2w35RpbTEwLYs4GFMNgU88u+kY=;
	b=jHJhJDXRWk6/QrULmAggiN7VhwNT0LR0h+rfmGZroRBhCMkZrmaNliiGap030ynaPYHmnZ
	lEFKn0r435Eoc4pszhRNXKeelGmPJzS5tm/NeP9VKWXyiiC65OP/J8d5Nzza8wo+0EITNj
	M3bdc1gjYEL59Y8TMaZx72mL+/zchkU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-l1dVKqVbNjSHXwliPbYvYA-1; Tue, 12 Dec 2023 08:17:27 -0500
X-MC-Unique: l1dVKqVbNjSHXwliPbYvYA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 79687868A21;
	Tue, 12 Dec 2023 13:17:26 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.39.208.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 445881121306;
	Tue, 12 Dec 2023 13:17:23 +0000 (UTC)
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
Subject: [PATCH v5 2/4] vduse: Temporarily disable control queue features
Date: Tue, 12 Dec 2023 14:17:10 +0100
Message-ID: <20231212131712.1816324-3-maxime.coquelin@redhat.com>
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

Virtio-net driver control queue implementation is not safe
when used with VDUSE. If the VDUSE application does not
reply to control queue messages, it currently ends up
hanging the kernel thread sending this command.

Some work is on-going to make the control queue
implementation robust with VDUSE. Until it is completed,
let's disable control virtqueue and features that depend on
it.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 drivers/vdpa/vdpa_user/vduse_dev.c | 37 ++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index 0486ff672408..fe4b5c8203fd 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -28,6 +28,7 @@
 #include <uapi/linux/virtio_config.h>
 #include <uapi/linux/virtio_ids.h>
 #include <uapi/linux/virtio_blk.h>
+#include <uapi/linux/virtio_ring.h>
 #include <linux/mod_devicetable.h>
 
 #include "iova_domain.h"
@@ -46,6 +47,30 @@
 
 #define IRQ_UNBOUND -1
 
+#define VDUSE_NET_VALID_FEATURES_MASK           \
+	(BIT_ULL(VIRTIO_NET_F_CSUM) |           \
+	 BIT_ULL(VIRTIO_NET_F_GUEST_CSUM) |     \
+	 BIT_ULL(VIRTIO_NET_F_MTU) |            \
+	 BIT_ULL(VIRTIO_NET_F_MAC) |            \
+	 BIT_ULL(VIRTIO_NET_F_GUEST_TSO4) |     \
+	 BIT_ULL(VIRTIO_NET_F_GUEST_TSO6) |     \
+	 BIT_ULL(VIRTIO_NET_F_GUEST_ECN) |      \
+	 BIT_ULL(VIRTIO_NET_F_GUEST_UFO) |      \
+	 BIT_ULL(VIRTIO_NET_F_HOST_TSO4) |      \
+	 BIT_ULL(VIRTIO_NET_F_HOST_TSO6) |      \
+	 BIT_ULL(VIRTIO_NET_F_HOST_ECN) |       \
+	 BIT_ULL(VIRTIO_NET_F_HOST_UFO) |       \
+	 BIT_ULL(VIRTIO_NET_F_MRG_RXBUF) |      \
+	 BIT_ULL(VIRTIO_NET_F_STATUS) |         \
+	 BIT_ULL(VIRTIO_NET_F_HOST_USO) |       \
+	 BIT_ULL(VIRTIO_F_ANY_LAYOUT) |         \
+	 BIT_ULL(VIRTIO_RING_F_INDIRECT_DESC) | \
+	 BIT_ULL(VIRTIO_RING_F_EVENT_IDX) |          \
+	 BIT_ULL(VIRTIO_F_VERSION_1) |          \
+	 BIT_ULL(VIRTIO_F_ACCESS_PLATFORM) |     \
+	 BIT_ULL(VIRTIO_F_RING_PACKED) |        \
+	 BIT_ULL(VIRTIO_F_IN_ORDER))
+
 struct vduse_virtqueue {
 	u16 index;
 	u16 num_max;
@@ -1782,6 +1807,16 @@ static struct attribute *vduse_dev_attrs[] = {
 
 ATTRIBUTE_GROUPS(vduse_dev);
 
+static void vduse_dev_features_filter(struct vduse_dev_config *config)
+{
+	/*
+	 * Temporarily filter out virtio-net's control virtqueue and features
+	 * that depend on it while CVQ is being made more robust for VDUSE.
+	 */
+	if (config->device_id == VIRTIO_ID_NET)
+		config->features &= VDUSE_NET_VALID_FEATURES_MASK;
+}
+
 static int vduse_create_dev(struct vduse_dev_config *config,
 			    void *config_buf, u64 api_version)
 {
@@ -1797,6 +1832,8 @@ static int vduse_create_dev(struct vduse_dev_config *config,
 	if (!dev)
 		goto err;
 
+	vduse_dev_features_filter(config);
+
 	dev->api_version = api_version;
 	dev->device_features = config->features;
 	dev->device_id = config->device_id;
-- 
2.43.0

