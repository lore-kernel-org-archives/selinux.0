Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B552DE1FF;
	Tue, 17 Jun 2025 14:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169174; cv=none; b=QB2l43cz7FjU+5k//BwETOJBV3nZ7fx1mkJssvEG3uWZH/Qum0XSa8GDKdREHJrZrf1OkoiUY1zL5EUkR47OMMh8fZTCV8dpve3EfqkcoK/Oq9UZAvgZQnfYEkEYGZrdzjdUZ1asnvAfGMvpEZOc/V8IdjdBINWN5VK82OUaHWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169174; c=relaxed/simple;
	bh=eCNiGapXxHDqPddRF9jAnZ4v7bM/Qy1+5Qlg98rQyVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qh9Il40rkWl5EY0VKmRHpf9jgfjrpTlrggRaOCji3qHN1TGXECF1x37YWyAk0gp8ZvV+SP9vtkWahx0OgE2ZtrRZUz2yE+g0R4VGvUo0GKrhWGUl2W0Hm3zQ+j3U4w9AmCsd2qy9MgpILZX6Dgg9dgv2Xb3yZy5Zcq4FPccLfww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7cE5XTM; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7cE5XTM"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d09b0a5050so356876385a.3;
        Tue, 17 Jun 2025 07:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750169171; x=1750773971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvKCtAonUWQ5iWh4WREvJo48TrsD15eP1NxiS135b4Y=;
        b=L7cE5XTMMWOAf/IMqaDRKv6hgrcxS+CTqqAOgFTl49XYr0eHfz3LonX/7zHwcRssZ8
         DRlp1Fr0fFrIPDKpTih9aJiBn87UjGbOhlzJOKfj61zqK0DBpHFadJ0+EaqBjgcAuvrI
         EHOMS/3ZfbSMTz5ZIgVom6z2fjrjreSB41CUnGXfke5V6d0QNjdm890hyvxIGXdhVek+
         iI567MR6tI1ELwanuGudDYLgSdckkb0l/XVG5DVfryiLMNF6zUlSZGFSaMDglNV61d7g
         GvdU9Ot0Aramjns6Ja+D7qh9I3IFlGVIEaIPJRXLJB93rqPD5tUsgc8/ofEcx0z5Pxbi
         Rvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750169171; x=1750773971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pvKCtAonUWQ5iWh4WREvJo48TrsD15eP1NxiS135b4Y=;
        b=IhzISahqlcv+dhiD6qhyUoAJWcVCSfi1E3qSnjh8n8qsJNLL1hI7QTL9gFQkZyA6bM
         WIlnlOmt9ZvWiu9y9QPkY1+DxwLteDq76R9vJeiMOyxKMX+SMxB78lXQC3xlJQ6xShpJ
         mpByxwmBzSCo+5RlNO4FCXTj6bMEUflfebQUpB9378jN+97685LmmrkS8dnxWPVZ42gp
         1Me474InfZj1UfaFOo++0Z6lZrL+VQiidN+48EU55gSjCzWpqLx3/JHwrCOJWVtKuyrr
         nabvkBoRXwuBog3zhGHxytMjzCIur4gcCOKfXIB0/ROCRTs0/+iVXpM60wetaSnVNh2K
         yKtA==
X-Forwarded-Encrypted: i=1; AJvYcCXi7tPQwcJPltJhhM63nOF+Piw3NQlBA9cQiKSqg5axIwAzF+pscM6zWWFs+CkwqVzvSM1EwdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBlcbRpvbNvyJdp7EOpCRqabW+wGlvWG+h9qVh8/SmL++bnrCU
	FysaXRJR0QqdpznApcKIpTSwuCFBmqdvdTs2ikQEfNLNBli2CygovqnPNU1m6A==
X-Gm-Gg: ASbGnctwhUgxdtpM16oWYK24+Ng2qufENIQsTWo24hkCPBDQanGrOM/dwxqghaNPq3N
	g195fLnT3WrLWDr9WlfVGteNRof3ALr/E7ks5Mn3aDwU/qURpI4TC7p6EexvxFFZTV9xPwon5GD
	XNLYBCDx3scblPrkYN0srJdW9lHpqixsbKG1QWb0bwl62+FJnMAoGnjt1/bgWW8E9PQQfzWgZiC
	JGDu/dtlOPjsDpbwMBq0dF5rVc30bT2G9Uu1mAq/ugOnX/arxvBjQxlPgf+OQJEScw5tIFiS3j0
	H9KfZj02ntHGXvWBq4IymFT+mVlcwUAlA9Axh+qDGxlLL+D4+SfVJcm1U5H35x+tUmBZeITq6z4
	uoPUgM4pYZWHEUd+04YZhHcLaTaFop/SMBVVrc9njj+K/18+r9h0GnE6gFFknR26CzA==
X-Google-Smtp-Source: AGHT+IEWfD6Hhn7fr4SOf6blnNrCQIzB/xYgTSAomnwAUqIJzbYRDPayYpBTgCsx4CU0pxUcSJlPZA==
X-Received: by 2002:a05:620a:31aa:b0:7d2:3db:6816 with SMTP id af79cd13be357-7d3c6cff074mr2491223485a.47.1750169171483;
        Tue, 17 Jun 2025 07:06:11 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8edbe29sm651079585a.91.2025.06.17.07.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 07:06:10 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v5 06/42] selinux: limit selinux netlink notifications to init namespace
Date: Tue, 17 Jun 2025 10:04:53 -0400
Message-ID: <20250617140531.2036-7-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
References: <20250617140531.2036-1-stephen.smalley.work@gmail.com>
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
index 953f71e517c4..32d961cecfab 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -107,7 +107,7 @@
 
 #define SELINUX_INODE_INIT_XATTRS 1
 
-static struct selinux_state *init_selinux_state;
+struct selinux_state *init_selinux_state;
 struct selinux_state *current_selinux_state;
 
 /* SECMARK reference count */
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index f250d00daab3..10f5b2079f04 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -133,6 +133,7 @@ get_selinux_state(struct selinux_state *state)
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
2.49.0

