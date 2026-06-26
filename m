Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB93B1714AA;
	Fri, 26 Jun 2026 01:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782437651; cv=none; b=E/WQJoagOCkT1oumC69C7itBHk4c8LsVZ8FbM3XTfuiPKGtovaUiS7XRof0eFdpLPaEp9OtmNGe3wabbT4DR12CskKcAqb2aS2ILvqltG5ynHR/O+YaLBTOI3o8S6jLTOdFesSuRPOWWpKcc50QWU90mE4ozK/3SmxFy/70NUqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782437651; c=relaxed/simple;
	bh=2+QLewizUHSd4+IaPUuAzHL1yhd2ooVE955i5vx1evQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lw+F0icF4PCcEICHHu3qY901mXPiSe/tg5Nq9fGCQitB88Q6NoZEmSCcOusyPHCV0glm0HrRCa0CMVR0bk0aatU5y5O8ETt0mZ7NlOMVI1EXh4DSs1GMj/27KpAaF/sZl8bb+FMZ32HUvu6HIANyhjSuC3HhhUyFayMEe3rvLMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xWu6ASgK; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xWu6ASgK"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=NFuGSu6wfP8vMso2w5/cFckMhhrc1IZ9MJKT+QkLAhQ=;
	b=xWu6ASgKZbwbrwy4IifCGBuwfqHbUhUaQXl9e9sDOw/0TUXy7AheAPKIpE9prYzb8hg2uO1AP
	Be5l4Ji6uPJt9aFijzvF7WA9TGKwpCdJbwALDNo1LJIX3sbcs2jCwZ+IQWYGzh6toc+qlAVHO5a
	9qbRv7kfWwO0ckZqQkn6o5I=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4gmdJR5V82z1prKw;
	Fri, 26 Jun 2026 09:24:55 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 262DD40576;
	Fri, 26 Jun 2026 09:34:04 +0800 (CST)
Received: from kwepemq200017.china.huawei.com (7.202.195.228) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 26 Jun 2026 09:34:03 +0800
Received: from hulk-vt.huawei.com (10.67.174.72) by
 kwepemq200017.china.huawei.com (7.202.195.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 26 Jun 2026 09:34:03 +0800
From: Cai Xinchen <caixinchen1@huawei.com>
To: <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
	<stephen.smalley.work@gmail.com>, <omosnace@redhat.com>,
	<amir73il@gmail.com>, <brauner@kernel.org>
CC: <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<selinux@vger.kernel.org>, <caixinchen1@huawei.com>, <lujialin4@huawei.com>
Subject: [PATCH -next 0/2] Fix call security_backing_file_free second time
Date: Fri, 26 Jun 2026 01:17:18 +0000
Message-ID: <20260626011720.1144213-1-caixinchen1@huawei.com>
X-Mailer: git-send-email 2.34.1
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

Cai Xinchen (2):
  security: Some cleanup code
  security: Fix call security_backing_file_free second time

 security/lsm_init.c      | 1 -
 security/security.c      | 5 +----
 security/selinux/hooks.c | 1 -
 3 files changed, 1 insertion(+), 6 deletions(-)

-- 
2.34.1

