Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7138D2DF142;
	Fri, 26 Jun 2026 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782437657; cv=none; b=Y6a8kDLP7RvScAMcWmnksfeLuY1jkh+gk4MlA3DPmd7212u6Gdt+weRfyjyZ3Hp7L/wfVyq73a013viw+vCp2/rsxnYY3XFGIIjiaqRJ1QENbtSPHCO2RmE1/84w0uFYFQPEw+F6GbRFhEezD6asYfDExB33gbHCkEBZJX22KIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782437657; c=relaxed/simple;
	bh=SBR0GvjuIJ60/iWetvv3xLFy8ZDG6zsPXQsITcAmMp0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FW/l4y1sFlHL+Uf499ZcSstCFkNDq70OElJ+qjEDn5HZ2TjqNfVoddGG1fQlmVcuC72L1vlUKymzhAgKLfr/NY1+DFuHN6T7mcWoB2GR33U/8iV7HWTmf2rkwp9dyS7345IQiKT0tHEUZ4q2RANVdaPGUNmMEpHckemGfTl/slY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=V8l2gaGk; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="V8l2gaGk"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YLPS63gtqBayyLR+RvmdgyL8papKMvA8I0odhv422HA=;
	b=V8l2gaGk44kkwz02y72PPgRdqHD4YxNU8i/zHJjjggoO0qiTyPQNeACt4IQOuaWfpwDjVJtZ5
	p6kwdCTX6//vNK6DLNBoG3p3CZjiIer0YwKW2Cdkle25Ze71n1qMeQ8lg86Ya6VkdWhEkgU/YlK
	YKlLB67yzrYW4jJmq44drCg=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gmdJc2NHfzKm5B;
	Fri, 26 Jun 2026 09:25:04 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 3C05840565;
	Fri, 26 Jun 2026 09:34:13 +0800 (CST)
Received: from kwepemq200017.china.huawei.com (7.202.195.228) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 26 Jun 2026 09:34:13 +0800
Received: from hulk-vt.huawei.com (10.67.174.72) by
 kwepemq200017.china.huawei.com (7.202.195.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 26 Jun 2026 09:34:12 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<stephen.smalley.work@gmail.com>, <omosnace@redhat.com>,
	<amir73il@gmail.com>, <brauner@kernel.org>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<selinux@vger.kernel.org>, <caixinchen1@huawei.com>, <lujialin4@huawei.com>
Subject: [PATCH -next 2/2] security: Fix call security_backing_file_free second time
Date: Fri, 26 Jun 2026 01:17:20 +0000
Message-ID: <20260626011720.1144213-3-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626011720.1144213-1-caixinchen1@huawei.com>
References: <20260626011720.1144213-1-caixinchen1@huawei.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq200017.china.huawei.com (7.202.195.228)

I found the following path:

alloc_empty_backing-file
    init_file(&ff->file, xxx)
        -> file_ref_init(&f->f_ref, 1); // only 1
    error = init_backing_file
        -> security_backing_file_alloc
        -> rc = call_int_hook(backing_file_alloc, ...)
           if (unlikely(rc))
           	security_backing_file_free(backing_file); // first call
    if (unlikely(error)) {
        fput(&ff->file);
         -> if (unlikely(file_ref_put(&file->f_ref))) // zero
                __fput_deferred(file);
                 -> ____fput -> __fput -> file_free(file);
                 -> backing_file_free(backing_file(f));
                 -> security_backing_file_free(&ff->file); // second call

Currently, only SELinux has the lsm backing_file_alloc hook, and the
backing_file_free hook is not set. When security_backing_file_free is
called for the first time, the blobs pointer is set to NULL. Therefore,
double free will not occur in the code.

Fixes: 6af36aeb147a ("lsm: add backing_file LSM hooks")
Signed-off-by: Cai Xinchen <caixinchen1@huawei.com>
---
 security/security.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/security/security.c b/security/security.c
index 71aea8fdf014..595d3c73253e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2468,11 +2468,8 @@ int security_backing_file_alloc(struct file *backing_file,
 	rc = lsm_backing_file_alloc(backing_file);
 	if (rc)
 		return rc;
-	rc = call_int_hook(backing_file_alloc, backing_file, user_file);
-	if (unlikely(rc))
-		security_backing_file_free(backing_file);
 
-	return rc;
+	return call_int_hook(backing_file_alloc, backing_file, user_file);
 }
 
 /**
-- 
2.34.1

