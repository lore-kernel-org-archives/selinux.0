Return-Path: <SRS0=c/u7=SV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33526C282E0
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 18:55:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F386F20663
	for <selinux@archiver.kernel.org>; Fri, 19 Apr 2019 18:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="EaGOt+0E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbfDSSzQ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:55:16 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43729 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfDSSzQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Apr 2019 14:55:16 -0400
Received: by mail-qk1-f196.google.com with SMTP id p19so1028175qkm.10
        for <selinux@vger.kernel.org>; Fri, 19 Apr 2019 11:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=IyzQ5btbQftJrbWM0aHTnEtKVALpoNzETGpMHZaIPvE=;
        b=EaGOt+0EjjEkZgjxbIbsyF5CCsH0DiRZAP64/JO76ukHiMz7xpBd/ZHMZlU8hwD05Q
         9uh0QsqqJuizACVSgE+gZpSqDgOZDCiHVMu8oWbUzHJVkes/fjAXHxrD6dzu2NgHxTzX
         k1wY1aKglJ5k2JJg1OO3dKnu6fHSIywZoXslbRflUCvFg06dSx9wOi/NQ0F1/YYf2w12
         VRtTwMmoDALfx92FZLAfpwy3hvk4AZKdjUo3xqRqgeOWbTyyIjNz7HCJO7z7vfaZ00fV
         JJOa+HrmSsiZe2gPRd6xgkSxVbGMhZkFbzY7HHnxVdEf4kuMoqr4ulDiKZhN+eXLqHYb
         aZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=IyzQ5btbQftJrbWM0aHTnEtKVALpoNzETGpMHZaIPvE=;
        b=thZqoCV0jZpX9q6wfW0FNYApHYNEZrAqDO/LiVCEbKjznx/FOR26ac09fYJSy5q4DS
         FqTG9Srh6djk8JVgLWoDBINBJL8MT5IL5a1Ikkg87h1wx6QXgY2WcFmFNh+b6t54I4wZ
         E4B8E99Iw62TH53g2k50wZkWVtOJYblYQH9ApLdbDwUdOjhWuV1QmnWV0GpoIc9F64Ug
         3ErEbMe6/2ifsRp/F7Y9OgtOMgrrRWoouGuhAH1jcBePEr6PgiEgYf/6MD4ZL/cFwkaH
         YLcuS0C8QneyBJVyza+ev7s2jCpcXxOsRhGc+rSTd5uS5Qrht/ktmDW7BBzjqBGiCKja
         xSFA==
X-Gm-Message-State: APjAAAXlA2LZh0tbxZf89EMLcZmlP/VBwALro1UKfkxMRvSCPmd2ce68
        gwoeMtLgIUQjAtlWjTp6udXZ
X-Google-Smtp-Source: APXvYqxjIFdh64aCmn9++d8Zgq+lvKLUbo7+LEFA6/PpeMyN4ILZGc9obA0vkGVNMfX58ANeYQdOiw==
X-Received: by 2002:a37:2c82:: with SMTP id s124mr4258770qkh.286.1555700114582;
        Fri, 19 Apr 2019 11:55:14 -0700 (PDT)
Received: from localhost (static-96-233-112-89.bstnma.ftas.verizon.net. [96.233.112.89])
        by smtp.gmail.com with ESMTPSA id i24sm3512340qti.76.2019.04.19.11.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Apr 2019 11:55:13 -0700 (PDT)
Subject: [PATCH] proc: prevent changes to overridden credentials
From:   Paul Moore <paul@paul-moore.com>
To:     linux-security-module@vger.kernel.org
Cc:     selinux@vger.kernel.org, cj.chengjian@huawei.com,
        john.johansen@canonical.com, casey@schaufler-ca.com
Date:   Fri, 19 Apr 2019 14:55:12 -0400
Message-ID: <155570011247.27135.12509150054846153288.stgit@chester>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Prevent userspace from changing the the /proc/PID/attr values if the
task's credentials are currently overriden.  This not only makes sense
conceptually, it also prevents some really bizarre error cases caused
when trying to commit credentials to a task with overridden
credentials.

Cc: <stable@vger.kernel.org>
Reported-by: "chengjian (D)" <cj.chengjian@huawei.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 fs/proc/base.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index ddef482f1334..87ba007b86db 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2539,6 +2539,11 @@ static ssize_t proc_pid_attr_write(struct file * file, const char __user * buf,
 		rcu_read_unlock();
 		return -EACCES;
 	}
+	/* Prevent changes to overridden credentials. */
+	if (current_cred() != current_real_cred()) {
+		rcu_read_unlock();
+		return -EBUSY;
+	}
 	rcu_read_unlock();
 
 	if (count > PAGE_SIZE)

