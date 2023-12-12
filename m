Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gk13oEqT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953C218C
	for <selinux@vger.kernel.org>; Tue, 12 Dec 2023 05:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702387043;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uEfBOjzPjblysBMFnX+6a/wE9U/z2J+F0Gwcn3mSyk0=;
	b=Gk13oEqTruJFMDqC/yXFE2hlMKJAqhXZOlY7mEtrJf3TSCT/WkXnxtMyXhb7fYP7pQLnlw
	oaQI+Qm3+GMgQDGM9c1mV5d/3OueAg+KP5aiQaz11gDdOQr0FnomUB191lJ7Rge9JJnpfC
	LS/TX1z3bPSJGPSwMWA2m8r83cipJ4g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-iW6Az-r9NfyE7sxNi-GDCw-1; Tue,
 12 Dec 2023 08:17:20 -0500
X-MC-Unique: iW6Az-r9NfyE7sxNi-GDCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 788B528EC10B;
	Tue, 12 Dec 2023 13:17:19 +0000 (UTC)
Received: from max-p1.redhat.com (unknown [10.39.208.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 92FAF1121306;
	Tue, 12 Dec 2023 13:17:15 +0000 (UTC)
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
Subject: [PATCH v5 0/4] vduse: add support for networking devices
Date: Tue, 12 Dec 2023 14:17:08 +0100
Message-ID: <20231212131712.1816324-1-maxime.coquelin@redhat.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

This small series enables virtio-net device type in VDUSE.
With it, basic operation have been tested, both with
virtio-vdpa and vhost-vdpa using DPDK Vhost library series
adding VDUSE support using split rings layout (merged in
DPDK v23.07-rc1).

Control queue support (and so multiqueue) has also been
tested, but requires a Kernel series from Jason Wang
relaxing control queue polling [1] to function reliably,
so while Jason rework is done, a patch is added to disable
CVQ and features that depend on it (tested also with DPDK
v23.07-rc1).

In this v5, LSM hooks introduced in previous revision are
unified into a single hook that covers below operations:
- VDUSE_CREATE_DEV ioctl on VDUSE control file,
- VDUSE_DESTROY_DEV ioctl on VDUSE control file,
- open() on VDUSE device file.

In combination with the operations permission, a device type
permission has to be associated:
- block: Virtio block device type,
- net: Virtio networking device type.

Changes in v5:
==============
- Move control queue disablement patch before Net
  devices enablement (Jason).
- Unify operations LSM hooks into a single hook.
- Rebase on latest master.

Maxime Coquelin (4):
  vduse: validate block features only with block devices
  vduse: Temporarily disable control queue features
  vduse: enable Virtio-net device type
  vduse: Add LSM hook to check Virtio device type

 MAINTAINERS                         |  1 +
 drivers/vdpa/vdpa_user/vduse_dev.c  | 65 +++++++++++++++++++++++++++--
 include/linux/lsm_hook_defs.h       |  2 +
 include/linux/security.h            |  6 +++
 include/linux/vduse.h               | 14 +++++++
 security/security.c                 | 15 +++++++
 security/selinux/hooks.c            | 32 ++++++++++++++
 security/selinux/include/classmap.h |  2 +
 8 files changed, 133 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/vduse.h

-- 
2.43.0

