Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113459;
	b=UgybjlsvNYQRbqL+a/QWrm/VRp8u4oxDGsJaPirbM2c8/DesPJX7Vi5Ed2vhQdyQOpgX
	 x4ges1c7VneZ6Vng/7Bu1Sn/v0/hyHOgSn56j43kLMpAp1lXqewPYswTkbLHxVc8Ny0PT
	 hoO2miU4x+jWrb5+CAMGPpinJVInTr/jxTuiifv0f2tfE/1DHs4WrSL+CYNyhSUmQ+tFq
	 7hEa1vaGIDZxCTGH42W8qCFtTTMZYtdoFpmiN4B0ePdfNKMGA+XsdFE0a+j7Weun3fzx8
	 OyjaxkI1hpe3UBBapp2zrWIrF0DAXyD6j2tMGMYPRMW3WWRq0n9juPX+fxiFBdd+7xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113459;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Developer-Signature:X-Developer-Key:
	 X-Scanned-By;
	bh=ELwETE9puCDkWaMizckqbNhj0IuGl0YqFp+CU1fqLCk=;
	b=C4ho1XoXUpcBvxI1Q45GS9XXXHbD+fOpvvW4AcoVbq9BK/X13eHLJ/69gdJX4B3e+1j8
	 w9ambGGDS+C1CHyp6C0d07cbf+RoqWSq9hi/0XX/DSIlgkVSkEMFEUKYWX6WK+3c9BXK0
	 oAOe9G7GXC5NKDs8iNikHhlkn2gkhcjoDEByx3RSMKQH9oGog3ERMFEt7Vq4b+6XAnvCY
	 Oo74p7xzafTyIV7exx88W4zhbic7+2uO90oXQQaufLSXT4QptJNQQVWsB0F3avTLRmMTb
	 w+mfCgrjUbwUxsYjZqeZR+fBq88S1voVsUSjF7pVBsoiVLTBa6c9TgAyZgzhzFAgAYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FAjzXJSn;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA4960A3815
	for <selinux@vger.kernel.org>; Tue, 27 Oct 2026 15:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFA4960A3815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FAjzXJSn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793113458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ELwETE9puCDkWaMizckqbNhj0IuGl0YqFp+CU1fqLCk=;
	b=FAjzXJSnez2ptJhB8CoCrSDufdMMGTmDsjVlHArseFlxT+GDALe6Vp3xS9jcfkJdk0u8Qr
	Ilv/J5XXP5ApDT7OxdXMz7z1Pt6s82g7Wb+qk5ravJi2hib+BL+ojzDDWHNW6hsSghOOyl
	/iV8Os2hUmJL7FAvlVpMD5j4KOsB5dw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-5IXUjqf5Mh2LG2GcL9QwLw-1; Tue,
 27 Oct 2026 11:04:07 -0400
X-MC-Unique: 5IXUjqf5Mh2LG2GcL9QwLw-1
X-Mimecast-MFC-AGG-ID: 5IXUjqf5Mh2LG2GcL9QwLw_1793113441
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 82C2218011F7;
	Tue, 27 Oct 2026 15:04:01 +0000 (UTC)
Received: from aesteve-thinkpadp1gen8.rmtes.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4D9318005B2;
	Tue, 27 Oct 2026 15:03:53 +0000 (UTC)
From: Albert Esteve <aesteve@redhat.com>
Date: Tue, 27 Oct 2026 16:02:49 +0100
Subject: [PATCH v3 6/8] selinux: Restrict dma-buf direct cgroup charging
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
Message-Id: <20261027-v2_20230123_tjmercier_google_com-v3-6-78d2c4cb8647@redhat.com>
References: <20261027-v2_20230123_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com>
In-Reply-To: <20261027-v2_20230123_tjmercier_google_com-v3-0-78d2c4cb8647@redhat.com>
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
 Jens Wiklander <jenswi@kernel.org>, Sumit Garg <sumit.garg@kernel.org>, 
 =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>
Cc: cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
 linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 op-tee@lists.trustedfirmware.org, Albert Esteve <aesteve@redhat.com>, 
 echanude@redhat.com, mripard@kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793113379; l=3440;
 i=aesteve@redhat.com; s=20260827; h=from:subject:message-id;
 bh=wN5MetiOIXBEZQC/HDlRJrMQSnkYl46Q+UcUWMTZ3cg=;
 b=Q4GmTIe9NYB/opKZPIGgb1l9Vz3CAgDxTYSN9JTAtPCTrV3mdRnv1TsODGNuYpi5pugIrMVT9
 NyXpu/8zRMPCV9OKiHBHRsHuA6x7vW3nPZla8t2Jv2SPWc6vcnBt60L
X-Developer-Key: i=aesteve@redhat.com; a=ed25519;
 pk=zI2RBeZgocwYm3AkJW4CtjoJnKoDZrfBl1xe5Ed6h+U=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The security_dma_buf_charge_cgroup() hook allows security modules
to control which processes may charge dma-buf to an arbitrary
cgroup via cgroupfd passed in charge_fd. Without a policy
implementation, the hook is a no-op and any process that can open a
cgroup directory (effectively any process) can charge memory to it.

Implement selinux_dma_buf_charge_cgroup() using avc_has_perm() with
the dma_buf object class and a charge_cgroup permission. The target
SID is derived from the SELinux label on the cgroup's kernfs
directory, so access control follows the cgroup filesystem labeling.
Policy authors can then grant cross-cgroup charging selectively,
for example:

  allow allocator_app_t cgroup_t:dma_buf charge_cgroup;

The hook matches the fail-open semantics of
selinux_kernfs_init_security(). This means unlabeled cgroups are
unrestricted by default.

Signed-off-by: Albert Esteve <aesteve@redhat.com>
---
 security/selinux/hooks.c            | 37 +++++++++++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |  2 +-
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 8f39d91eabc9..2f99eaa910af 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2210,6 +2210,40 @@ static int selinux_dma_buf_charge_task(const struct cred *from, const struct cre
 			    SECCLASS_DMA_BUF, DMA_BUF__CHARGE_TASK, NULL);
 }
 
+#ifdef CONFIG_CGROUPS
+static int selinux_dma_buf_charge_cgroup(const struct cred *cred, struct cgroup *cgrp)
+{
+	u32 cgrp_sid, clen;
+	int rc;
+	char *context;
+
+	rc = kernfs_xattr_get(cgrp->kn, XATTR_NAME_SELINUX, NULL, 0);
+	if (rc == -ENODATA)
+		return 0;
+	else if (rc < 0)
+		return rc;
+
+	clen = (u32)rc;
+	context = kmalloc(clen, GFP_KERNEL);
+	if (!context)
+		return -ENOMEM;
+
+	rc = kernfs_xattr_get(cgrp->kn, XATTR_NAME_SELINUX, context, clen);
+	if (rc < 0) {
+		kfree(context);
+		return rc;
+	}
+
+	rc = security_context_to_sid(context, rc, &cgrp_sid, GFP_KERNEL);
+	kfree(context);
+	if (rc)
+		return rc;
+
+	return avc_has_perm(cred_sid(cred), cgrp_sid,
+			    SECCLASS_DMA_BUF, DMA_BUF__CHARGE_CGROUP, NULL);
+}
+#endif
+
 static int selinux_quotactl(int cmds, int type, int id, const struct super_block *sb)
 {
 	const struct cred *cred = current_cred();
@@ -7681,6 +7715,9 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(capset, selinux_capset),
 	LSM_HOOK_INIT(capable, selinux_capable),
 	LSM_HOOK_INIT(dma_buf_charge_task, selinux_dma_buf_charge_task),
+#ifdef CONFIG_CGROUPS
+	LSM_HOOK_INIT(dma_buf_charge_cgroup, selinux_dma_buf_charge_cgroup),
+#endif
 	LSM_HOOK_INIT(quotactl, selinux_quotactl),
 	LSM_HOOK_INIT(quota_on, selinux_quota_on),
 	LSM_HOOK_INIT(syslog, selinux_syslog),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index b4ebedc6e424..90d1e04c3d27 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -181,7 +181,7 @@ const struct security_class_mapping secclass_map[] = {
 	{ "user_namespace", { "create", NULL } },
 	{ "memfd_file",
 	  { COMMON_FILE_PERMS, "execute_no_trans", "entrypoint", NULL } },
-	{ "dma_buf", { "charge_task", NULL } },
+	{ "dma_buf", { "charge_task", "charge_cgroup", NULL } },
 	/* last one */ { NULL, {} }
 };
 

-- 
2.55.0

