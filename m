Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B252430101C;
	Thu, 14 Aug 2025 13:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178033; cv=none; b=H2i+Mqg0rkvY9Y8Yowooob6m609/S1foUQaqL680ZUdu5AYK36T2hOT2CAhOhHU6QXUx+QXrkmgisamawtCCuPPYebwHZUmrc9tVDoF8tBmmZmuJaGjAMCRRfzu/ed58DVLJ3GUkfSViFFgrnp5pd9sFAUkkS5d4tpKIGNuBwjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178033; c=relaxed/simple;
	bh=u0iPXmY5ljO32Q5UtIQ8G3W6HPbhk5FO7AdkDFEM6Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qwge0KqirW1NMBHTNRbCPDRh/bHlXe9zJ2T/ECZ8ZkQLT8yk02qBnNgcPuHotCyZ7On1hcQBAak3GFOUnMgOhA64x4idLikVAvBeAj1ZU7Pq2iVrw3kE8GUrnHY8Vq4qSFCLTEfsdowrpLhCcW5Bemr1/kKNraXRtay0hiZVoa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3Od1w0C; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3Od1w0C"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b109add472so11098951cf.1;
        Thu, 14 Aug 2025 06:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178029; x=1755782829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0YhMrjDgkD3zdYVNYa2bjzSsjksXiSoyMURZt6IdmA=;
        b=e3Od1w0C8kj9z+tzUZHcdHXn7IHmC282Yw4Baof0qhGCwOoTJoEWKUZ/aTE6bfM4mP
         uykSUh21w1MyRX6c2qEsEMD6Idren8xSw83T4uoCdWFmq/zeigwUOnAWSGZILzXJ+Ufv
         mVqsD1mZHrhapg2cD6l/5b56HKYSsvLx6opMRgpFqlcw9tfsdwMrFiHiudsz3NSU53uh
         fcPq4O8beGKGyUR2eRkDGW7ZIrz7hWiuTQYEpr7U6EzcSkNkkN3R1dNraxWuQNbWKgvG
         7f9PIYqi7F5BDfPw2YdAEG3XCIsQDvMvWgVS7Aeu3jIp0/udG9gsE6as+HJ7cOsze6i9
         tdMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178029; x=1755782829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0YhMrjDgkD3zdYVNYa2bjzSsjksXiSoyMURZt6IdmA=;
        b=N3+MaABh9fUDMNQGWZbR9xIyTDnY19NoweEerf9kMaViIiFP+nQg/EfH3NfoVuvDpk
         YHtj9iioYvoJSBWBb71qvCiyCXaQx7dh1Mr696X26MbUaUXuUJkAdegwqaO4muqjNtLb
         LiUBISOAIqlEetkdDB2eRVpag7/3sKrHIVGmHad3IljCYeWbJlsIt+cTRtMsy117NV2z
         DGnuhR8+qykxWtIs6wMfswJQiox7AXqxEjxSUX6EA9BYts9NM89KVMwC56Di22n9S40V
         04Gjh6zjCX01VFnNMmWEYB+IE3XS7vqIK82QwLr6UWDWxuUGijZ5f0N2PQ5rFFTsoYqx
         ZvUw==
X-Forwarded-Encrypted: i=1; AJvYcCViLlXcCz13zIykNR4hHPXXzLaXJw6LaPJ2N3/B/q8YSdIfvjSho5pDm96JJ6tYGP7kDrEMMrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4UIe5sC7zThabWXtd+TnksNw93hVJf6T/mfVShnekmkfU6KiP
	TuBA8ekkMPRzGwmiAF4ZC5h75jCSIUAJxYAMNr3fEr9slkbIGYYkR6Oae6qXbg==
X-Gm-Gg: ASbGncuuG8OsWWs92GHg+oRKduTLVhvFNxQfyUBs6vTUzoRhEvrZSiypnDV6YkUcW+O
	ilmxYfAzhlGAkszL50ASsAZy6xj8x9AOV2VIC8B2qVEjDUlRraNpSJEwF78c5HHscOg5YVBfynW
	kGrlU5AwDNeSJUGBcWdrSyx83jguI8OzMKKjpdTjq/V3y22g5slxIG8CLJJxiObDdM8mm++bIGi
	RQ57bsXAs2Tk7aAmAOkAdMcQK/YMFgG+JTUILipVN2nkyXGm2PT4MSLFv9iGdqrSjIGrXwHJPgf
	w9do2Yv+sBoTTfVt408KncwLY8XLfeqAvD9v1sknY7dwRhBNnGIWAQ0KsgIG1tSYANizev3uHxH
	/O7rFrr+2q7L8t3PJpjYKAHMXo0IkSarPjaQvrhvOM7qw6f2p2PBYOG12ChXMFn+/n5Fx2NGnLd
	0LZjYJEdZ+ydeQ8N3CV/yNUVY7FA==
X-Google-Smtp-Source: AGHT+IFyutfVrCjXxFQNb2XL5t3fp44HSMDOwG7QqCpR/++g/KKHL5mNa+hC2OZnhbw7ECUmq7oawg==
X-Received: by 2002:a05:622a:420e:b0:4b0:71cb:5e2 with SMTP id d75a77b69052e-4b10c5eca6cmr28018341cf.57.1755178029352;
        Thu, 14 Aug 2025 06:27:09 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:08 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 06/42] selinux: limit selinux netlink notifications to init namespace
Date: Thu, 14 Aug 2025 09:25:57 -0400
Message-ID: <20250814132637.1659-7-stephen.smalley.work@gmail.com>
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

To prevent modifying the enforcing status or resetting the AVC
in the userspace policy enforcers, do not deliver SELinux netlink
notifications to the init network namespace unless they were
generated by the init SELinux namespace. If you want to receive
SELinux netlink notifications in a non-init SELinux namespace,
then unshare your network namespace too. Otherwise, just map
the SELinux status page (/sys/fs/selinux/status) to check the
enforcing status and to detect policy reloads which is now the
default behavior in libselinux on any kernels that support it.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/hooks.c            |  2 +-
 security/selinux/include/security.h |  1 +
 security/selinux/netlink.c          | 11 +++++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 7c405f3289db..0d9ec74b6144 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -107,7 +107,7 @@
 
 #define SELINUX_INODE_INIT_XATTRS 1
 
-static struct selinux_state *init_selinux_state;
+struct selinux_state *init_selinux_state;
 struct selinux_state *current_selinux_state;
 
 /* SECMARK reference count */
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index d733d2dabb9f..950601a28cd5 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -134,6 +134,7 @@ get_selinux_state(struct selinux_state *state)
 	return state;
 }
 
+extern struct selinux_state *init_selinux_state;
 extern struct selinux_state *current_selinux_state;
 
 static inline bool selinux_initialized(const struct selinux_state *state)
diff --git a/security/selinux/netlink.c b/security/selinux/netlink.c
index 03678a76f4bb..fb55d3ba25f5 100644
--- a/security/selinux/netlink.c
+++ b/security/selinux/netlink.c
@@ -70,6 +70,17 @@ static void selnl_notify(int msgtype, void *data)
 	struct sk_buff *skb;
 	struct nlmsghdr *nlh;
 
+	/*
+	 * Do not deliver SELinux netlink notifications to the
+	 * init network namespace if they were not generated
+	 * by the init selinux namespace. Unshare network
+	 * namespace if you want to receive them; otherwise,
+	 * just get updates via the SELinux status page.
+	 */
+	if (current_selinux_state != init_selinux_state &&
+	    net_eq(current->nsproxy->net_ns, &init_net))
+		return;
+
 	len = selnl_msglen(msgtype);
 
 	skb = nlmsg_new(len, GFP_USER);
-- 
2.50.1

