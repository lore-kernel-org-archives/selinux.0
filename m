Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BC230AAB8;
	Thu, 14 Aug 2025 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178066; cv=none; b=Q+d48P2s55+2+FQT1wHmOTTeMfD9GOmBIZou31V7Y9vMVhb3BixXJInomtPHrDYbXMdpURDKsFIew8SygJZjAt4dKJb1E5mERGfC3jgQnzWGXd8izM4X0z9N8ASFucKzCbDjfjozpR0Av+DxfrVyiVkm13K/Vo9iPozMe+/PkWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178066; c=relaxed/simple;
	bh=Bt6ISCQodDfQri+QLDOZAn/XsZUMMebCHnKHR5LoX+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7Ge9xkv8AYRI7lRE+IbCEKzpu7NFMK3kN1mazp1p+iZ5gwiKPXlSfwtaJsaWJNwwBDgOXQjyvn8n4WaZhAMcX0t6OKurNeL9StoMCNSh9DdbrZoDp3EFIJZEUzdiW7HeJkDSk83nSOcoCqgas7aA9RwIJvdDJWL1gSoqm83zU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRv/NVNF; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRv/NVNF"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b109bd8b09so11876141cf.2;
        Thu, 14 Aug 2025 06:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178063; x=1755782863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oynIzZGPYTD/B7eQFC1V2P0a/zdpbpPeEOAZlp8KkvU=;
        b=SRv/NVNFwubPdLsT1emYUxeR41WzRKcFRIC/r3ec/D5UMD4ie+Mij9PnecdBo+Q24O
         jvdgn/g7zK2uTjHLa2T4gxJRfnUydvmYV3vbVDKBl8cT2PkXqAMXl1/lpik/NGhDMTFw
         WtTcvqOv3PPL6AivLABtc02BdgPe/k8dHYxDHcn1358T8K395K179ZTyYSJiIX2OXd4i
         NEVGuykapuPcPmGg/jOQryY6ZLXQ6fUnJsD0EXRLjHsohCiY5fIZhCXOgAoVZ3xKrZ1Z
         ymQTw4shEo1RVagV0mXswVcrEkwxzfzoMkG8vC0bw8jYrbm+HyKNY1Q+6AOiECNaWzaA
         VIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178063; x=1755782863;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oynIzZGPYTD/B7eQFC1V2P0a/zdpbpPeEOAZlp8KkvU=;
        b=hrau+qvvH0YO0ukjl6JjWqKHx8Kw8tME7svZCfDJMcIJGVzGgcsN7I1iPcXpP3X9sv
         kacxwY+OAtD5XpxMEEkoQkoArEfqNj9+1KhpnRbEgfrOSOEIQDURJWqXWBQSgGk3Gf5/
         mRMO4DQlaNtmaTwyssHP3WCIWPQ4kfhsKx7fcFy7h9dfp0uNPzIFHQTSDdDTBGcXmOQ4
         ucIuDzFfzpOeEYkdetzX/z5ljePOvN4PPSCeZyZtYjoK38JJzBNU2OIKWnsjDhDZ2KWv
         cqCj4XHTvBbyssYL7c1ZmofkG/6c4g4WtTXtF1FKiXsJViRqFEhesOIpfGkS3kHbul5y
         hEiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhFbvxcL4mKchwRBX5UbltS9euqFFACY60Y7GZpf9mc9Q6pGAIUaXH4s7X2UHoPa6LAIkD2xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBLiv9eXdgoQGGXVqLPDzsJdHWr06jolK7zKGJ0DgYrNiCtAFi
	An7eXivm2xT98RMgP+wr5BMkMOXzTfX5dhZ2bUd65MknYZ2+M/uT3TFpebSu3Q==
X-Gm-Gg: ASbGncutxiQkscWSoRKhWnhgpCooeDjvbajXcQVh5vNYMgkyHk+nX1tfEUMjNYCK6HS
	lrBzQ679Nj469sb3etGwdpuixyEf02aDcsJe5JPSmr/HGvEw3kJRk81qjj0Y7qXKF9OwfEZzwoI
	pi4mb0C0FYKhJWFs3wSl6APLiQ9/zI98vLdbs7Ti1FfJuEIufoEWj+OT9G46pSRlbtqwZidn3ID
	3QfwYEWY10tl9eSPL8ZGfGCS1ryJUNIsWuSyb6z6WQetUWkUz4Ru8UIyiaaKbAL254DCFJ7ZFuC
	piQPCQ8ebu9wsZ27tchInOxFyZYp/wiI2cD7jDHVc2VFVZGn3fpaBBhC+bWTdFA77yjnkGBlSQU
	slBLAmZDn9UzSqKbWrCeJYEa9REZClMQD+Z4sICsuxGqsFj5e4rmmkKEN46gGxsPznvIZz/5GNu
	7ubKAJ1y/tzOAj02yy43aqXjUaYg==
X-Google-Smtp-Source: AGHT+IEUvK4+izu9DmL7CpSl0DO0tYz9mjg/+WopF13quHIPqU7f8LyiBwKk25YmwLyIg1CfkbaQIA==
X-Received: by 2002:a05:622a:1f9b:b0:4b0:be3b:d40 with SMTP id d75a77b69052e-4b10c57c4fdmr35940281cf.40.1755178063156;
        Thu, 14 Aug 2025 06:27:43 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:42 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 42/42] selinux: disallow writes to /sys/fs/selinux/user in non-init namespaces
Date: Thu, 14 Aug 2025 09:26:33 -0400
Message-ID: <20250814132637.1659-43-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
References: <20250814132637.1659-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disallow writes to /sys/fs/selinux/user in non-init SELinux namespaces.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index b1ce3a98a241..f847767e5e15 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1371,10 +1371,20 @@ static ssize_t sel_write_user(struct file *file, char *buf, size_t size)
 	int rc;
 	u32 i, len, nsids;
 
-	pr_warn_ratelimited("SELinux: %s (%d) wrote to /sys/fs/selinux/user!"
-		" This will not be supported in the future; please update your"
-		" userspace.\n", current->comm, current->pid);
-	ssleep(5);
+	if (state == init_selinux_state) {
+		pr_warn_ratelimited("SELinux: %s (%d) wrote to"
+				" /sys/fs/selinux/user! This will not be"
+				" supported in the future; please update your"
+				" userspace.\n", current->comm, current->pid);
+		ssleep(5);
+	} else {
+		pr_warn_ratelimited("SELinux: %s (%d) tried to write to"
+				" /sys/fs/selinux/user! This is not supported"
+				" in non-init SELinux namespaces; please"
+				" update your userspace.\n", current->comm,
+				current->pid);
+		return -EPERM;
+	}
 
 	/*
 	 * Only check against the current namespace because
-- 
2.50.1

