Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20837157A6B
	for <selinux@vger.kernel.org>; Sat,  2 Nov 2024 09:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730539889; cv=none; b=n0/2HdPrtCzZr7kFkk1N8tT1RjNcYtMI71+v9GpImNoAfu8/x8KnLBoDDW2r727yNFVzP9wz834DIcXgzhrSht1S7Q+FCwmccy79hWvK1awYalgbxWKiva8o8m0KLbn8EWih+QPPDOywMI6t9zdacKjoWsO6tzVv+DJlaiRxcWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730539889; c=relaxed/simple;
	bh=AxfZ6gGVPQPRt1Kkz1e9AnPzzLi9MaVmGq3SQAO0XGw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=X2uTtvhqVMJqZC5fdF3lF+HT9bOzIE0aPhdEFAMAbL5O9GqH01bh6QROtDFyT+BiKBD3zIi13QCNMAuGT5R0fExvJLXXiGjCHxR9CTxsUtD5u/c916OGE+6IaMiJe+0eWn3r33AEGTZxQeFoDCOpKzQdFetp1TASiQz14ZCIMlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uk6kea6D; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uk6kea6D"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d49a7207cso1726268f8f.0
        for <selinux@vger.kernel.org>; Sat, 02 Nov 2024 02:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730539884; x=1731144684; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2G33OuRKLaV8/Qlw+mzO1Q7pXloYVXQQTnj0b51x9wA=;
        b=Uk6kea6DO+3dVkD/lMhzKq9JPrLY/9qbLQ/kuXxTQ+vi9rzA+BBnbnWASGN9dWXM9f
         dwFyFLdyspMacm9C7UvplAdwqQ9eXVuUVkkwRlYyOAIKkKkculU385cJZjkwudrQHD2D
         Q0eMkChINXVxMIiygDybbqzTNjm9Qs3Y7L3FDJO5THPCzastnsy6nZQhNCTnWrdrZOCk
         ykFue19DfwicyBY7hyCMo5AIx/2EgicdObLblk8+u49ETXrOeTWNyIZ6G5Oqoa97lopf
         G0u9UoZJTKup53qAa3UgBGKCN9DFYhXtsJAVXp6H+ULuqimW5JueagC2VwptVBtrEr6C
         REFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730539884; x=1731144684;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2G33OuRKLaV8/Qlw+mzO1Q7pXloYVXQQTnj0b51x9wA=;
        b=rbItJSkviEGg8nPHjSx5S2m8QckYixBCF11v6GvNvUF9mOWHeNWZopEfE0MO62OYSv
         ILj9AgMMI/zti3YUKC7oT0Y75MvqJOE+ecMC86efe05MXIllh5kW+ECeitccLcf4rMcr
         tfhf9i25ZaDlMxmxaEdkMR1LAijqYxTRNX/UPDoHBVnYwGWnLkXHtS9Qgocq4B5/La6f
         sthEtQee/VAPV2Nd3NQMVLo2FZmwQ/Q7YkN5IhgYCe1TNPGiRny4oIE6hYjGNEaQsgfU
         1NOkbaK4C/AL9IWAtbVzBzG4/YoKj5oWjWtdCsiXD80ZzZQS6VQehpsLTVp9GZF1SEGb
         fWcA==
X-Forwarded-Encrypted: i=1; AJvYcCUcY0sI2VdpChfkgjm/ZHQn4NWwgg1m82HTWnwXwaLoHhUQiAaw3EcS11QjMPgDW1XMdlzMY/1V@vger.kernel.org
X-Gm-Message-State: AOJu0YyAHcuIOrg1nva72grPOgHYR2dUS6hf8UrYZWn/jAU9lGI0GL7A
	0kLIErTrKbJwKa6zTW+bCtrbalI+PLRt3pKbIjPHRAMcf4UF3a5tNnZxEX6NiTgjtd/M+GJw4eu
	u
X-Google-Smtp-Source: AGHT+IFMNVmV9EFSObPL947fodX0Fb+SP0SISXcsLVbP/D8qbWurJtklEVb7Kef4HIak7PcfND0EKQ==
X-Received: by 2002:a5d:5f4f:0:b0:37d:4dcc:7fb4 with SMTP id ffacd0b85a97d-381c7a3a2e0mr5427434f8f.10.1730539884403;
        Sat, 02 Nov 2024 02:31:24 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d414csm7493312f8f.26.2024.11.02.02.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 02:31:24 -0700 (PDT)
Date: Sat, 2 Nov 2024 12:31:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH next] lsm: Fix signedness bug in selinux_secid_to_secctx()
Message-ID: <2d02f331-42ee-40db-a64f-5ee378eb44db@stanley.mountain>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The "ret" variable needs to be signed for the error checking to work.

Fixes: 95a3c11eb670 ("lsm: replace context+len with lsm_context")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index eca9674c9478..0ff018f557ac 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6644,7 +6644,7 @@ static int selinux_ismaclabel(const char *name)
 static int selinux_secid_to_secctx(u32 secid, struct lsm_context *cp)
 {
 	u32 seclen;
-	u32 ret;
+	int ret;
 
 	if (cp) {
 		cp->id = LSM_ID_SELINUX;
-- 
2.45.2

