Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597413;
	b=YK76Ij9hxIX79qxp69sy8grOoXZiKwZSYpYILfbbyJw+SOC52r1D56yI74RXOEQL2JAg
	 4onqnStYSWHsnFfjMcbHCd0MdrzZ060q/lDNQu+B+j0blXwPPMmWyuHKzxeBucg40bBDo
	 uL4rON/UmoDELw/Kmwlmz6Gucf/dpvo170pPUUmYBaZxYCqHbLiSakQYSTGtwEGYwgIWQ
	 r1faUtSDPgU8kRQkm556PbZAiX+MUEQmLte3aP95SUhHZ3a85mk42q2tdAgefx+KpUbiq
	 I6RopzRe80MYaCN6A6456lyfoh+1XBRxYblw7SzpeV3cQfGyDbDFQj3hT6CSRP9nqoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597413;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key:
	 X-Scanned-By;
	bh=KZFeAMYs79I5sWokt5+NC87pvbsB/zjt4WLbaNq6EN4=;
	b=nWC2SyRAfXOHhSGl53sp+oxXYsSlDNUaEj71K5wvuauH+6MgLJHjndEv6NwFwWgvDZBS
	 MabBfuN8usByNLiRG4DiE5pjcFUQqSuBMCamciZiPMvo4iChwO/HMB8+Zz9hEjjOyEVo9
	 cYl9YtMOwKC41gDVmuDsWmUnCteecVqdYG7A9JKfVvn8NO/NzNY/sD2ydVPfOmI7l7+4k
	 t2m8lN7pg+V47CP7vCkC14vhH1ErMIdHYwTr3N0G/A1NyPje0m0WRAg6q2+QbtzfP3qqj
	 6fk8op2SA5l/vyleERIvPigt3pm8fTblrPjtLGufZjf5b9M8PtdDpYpiuFA/I7cNFiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XALpk1cJ;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F89160A3814
	for <selinux@vger.kernel.org>; Wed, 21 Oct 2026 15:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F89160A3814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XALpk1cJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792597412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KZFeAMYs79I5sWokt5+NC87pvbsB/zjt4WLbaNq6EN4=;
	b=XALpk1cJ7RsRqamgPM7wAMlCdSS9/ok7vHylR79lvxEB60OZrIqV7V7r7unEtEkPva+o2s
	Q9+s7SN3M406GfqQuyhtOITyhnWJ9j5TiV/F6oizr6bbZPWgyYEMso5u8jgyF0inJpeaWP
	7qQGfy23rBC7mOOPYE/28fH1XtUKxNQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-GDMDWi0YNvSHU5ZJ4qe9SQ-1; Wed,
 21 Oct 2026 11:43:27 -0400
X-MC-Unique: GDMDWi0YNvSHU5ZJ4qe9SQ-1
X-Mimecast-MFC-AGG-ID: GDMDWi0YNvSHU5ZJ4qe9SQ_1792597403
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0BBF918007F7;
	Wed, 21 Oct 2026 15:43:23 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7B4EF18005B4;
	Wed, 21 Oct 2026 15:43:15 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Wed, 21 Oct 2026 17:42:25 +0200
Subject: [PATCH RFC v2 4/8] security: dma-buf: Add dma_buf_charge_cgroup
 LSM hook
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261021-v2_20230123_tjmercier_google_com-v2-4-ef6ee2dd8c5c@redhat.com>
References: <20261021-v2_20230123_tjmercier_google_com-v2-0-ef6ee2dd8c5c@redhat.com>
In-Reply-To: <20261021-v2_20230123_tjmercier_google_com-v2-0-ef6ee2dd8c5c@redhat.com>
To: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 Christian Brauner <brauner@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Albert Esteve <aesteve@redhat.com>, mripard@kernel.org, echanude@redhat.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792597359; l=4349;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=znl1hbhvPkHiP1XBBo9O+z3sZFSbbBVomu0oqewjCLc=;
 b=LFnf31vV5uLvKeRyfLinIkjKbpF70zfdQJTZp/XdKtbMNiEnLPxU8E8whDfi1i53NSqRWshmM
 adRPRDyo8FuCo2yRgHVhOceyMgvDyscgpmI8um/Ur8g9+6hCkceRwFf
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Similar to how security_dma_buf_charge_task adds an
access-control point for pidfd for the charge_fd of a
DMA_HEAP_IOCTL_ALLOC ioctl, we need a new access-control
point for the case where charge_fd represents a cgroupfd.

Add security_dma_buf_charge_cgroup(), called in
dma_heap_ioctl_allocate() when charge_fd refers to a cgroup.
The hook receives the credentials of the requesting process (cred)
and the target cgroup to charge (cgrp), giving security modules
a controlled enforcement point for cross-cgroup dma-buf attribution
policy.

When CONFIG_SECURITY is not set the hook compiles to an inline
returning 0, adding no overhead to the fast path.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 drivers/dma-buf/dma-heap.c    |  6 ++++++
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  7 +++++++
 security/security.c           | 16 ++++++++++++++++
 4 files changed, 30 insertions(+)

diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
index c31573917886..e06131f4655d 100644
--- a/drivers/dma-buf/dma-heap.c
+++ b/drivers/dma-buf/dma-heap.c
@@ -115,7 +115,13 @@ static struct dma_buf *dma_heap_ioctl_allocate(struct file *file, void *data)
 
 			memcg = mem_cgroup_from_css(css);
 			rcu_read_unlock();
+
+			ret = security_dma_buf_charge_cgroup(current_cred(), cgrp);
 			cgroup_put(cgrp);
+			if (ret) {
+				mem_cgroup_put(memcg);
+				return ERR_PTR(ret);
+			}
 		} else {
 			/* charge_fd is a pidfd  */
 			task = pidfd_get_task(heap_allocation->charge_fd, &pidfd_flags);
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 0f1138e16dbe..9a719e0e9ced 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -44,6 +44,7 @@ LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
 LSM_HOOK(int, 0, capable, const struct cred *cred, struct user_namespace *ns,
 	 int cap, unsigned int opts)
 LSM_HOOK(int, 0, dma_buf_charge_task, const struct cred *from, const struct cred *to)
+LSM_HOOK(int, 0, dma_buf_charge_cgroup, const struct cred *cred, struct cgroup *cgrp)
 LSM_HOOK(int, 0, quotactl, int cmds, int type, int id, const struct super_block *sb)
 LSM_HOOK(int, 0, quota_on, struct dentry *dentry)
 LSM_HOOK(int, 0, syslog, int type)
diff --git a/include/linux/security.h b/include/linux/security.h
index 89a35eb07b8c..4626c047a0c2 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -351,6 +351,7 @@ int security_capable(const struct cred *cred,
 		       int cap,
 		       unsigned int opts);
 int security_dma_buf_charge_task(const struct cred *from, const struct cred *to);
+int security_dma_buf_charge_cgroup(const struct cred *cred, struct cgroup *cgrp);
 int security_quotactl(int cmds, int type, int id, const struct super_block *sb);
 int security_quota_on(struct dentry *dentry);
 int security_syslog(int type);
@@ -708,6 +709,12 @@ static inline int security_dma_buf_charge_task(const struct cred *from,
 	return 0;
 }
 
+static inline int security_dma_buf_charge_cgroup(const struct cred *cred,
+						 struct cgroup *cgrp)
+{
+	return 0;
+}
+
 static inline int security_quotactl(int cmds, int type, int id,
 				     const struct super_block *sb)
 {
diff --git a/security/security.c b/security/security.c
index 4a16e4076aab..eb83e8bf3dbf 100644
--- a/security/security.c
+++ b/security/security.c
@@ -676,6 +676,22 @@ int security_dma_buf_charge_task(const struct cred *from, const struct cred *to)
 	return call_int_hook(dma_buf_charge_task, from, to);
 }
 
+/**
+ * security_dma_buf_charge_cgroup() - Check if charging dma-buf memory to a cgroup is allowed
+ * @cred: credentials of the process requesting the charge
+ * @cgrp: target cgroup to charge
+ *
+ * Check whether the process with credentials @cred is allowed to charge
+ * dma-buf memory to @cgrp. Called when userspace passes a cgroupfd to
+ * identify the charge target instead of a pidfd.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_dma_buf_charge_cgroup(const struct cred *cred, struct cgroup *cgrp)
+{
+	return call_int_hook(dma_buf_charge_cgroup, cred, cgrp);
+}
+
 /**
  * security_quotactl() - Check if a quotactl() syscall is allowed for this fs
  * @cmds: commands

-- 
2.55.0

