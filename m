Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82F22459C8;
	Tue, 10 Jun 2025 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749576189; cv=none; b=fiYe+f+/5oLqesHmWDcbcCeQZlols7BIhVGyYUiFHdKrb2GlT09jmPH5Ua3/CsunvHwkLO7XUwmGlYDhXttvb3jPXThb5q+Ae6fpN9BatDPIww5aKWkPA+GTzuPmiymRQ8ODEegdA8MWVJp6/T2g8drfqZWZ0Bb2kP1k5Em+FlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749576189; c=relaxed/simple;
	bh=P0uv4XHMIM5uyixnJhCuu3luCZswzo69FCnO8iN37oA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGqDSO38ibG3UKbBmmUKA3QZ9inx0Zw5+nwEPY+p+37pA59LTapMuSuDfJlZplNDMEp/w9NuVrz6r/65/685DCnI73ztp8+fScbUjqiwGAAq0R+QRzYad1YFzsYNeWxB771wkDzKYPko9WzTOxPdDKN/ge7FcFzz7Do9DB9ckWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U63SEsSk; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U63SEsSk"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c5b8d13f73so621903285a.0;
        Tue, 10 Jun 2025 10:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749576186; x=1750180986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt5xZOhpzSeUolCdjzem+EeuO52qWGYd4U8ByxV5itE=;
        b=U63SEsSkQiM7eIOU1DNHWJLLWViKYEAiU3JkKdMqu4zanxW9AUTcYU1jTN7+Adx7Cl
         kaW+WMXLR+ZVCQqXUR/wm3ynvXoh0VWYO4dsjNXLtHihRjW0UNBG6eFf/q1Qn62l/vl5
         mGJnLc6oWDsjkZbWEYWvQSSet1GcOKTy8nLmZI+Xp/0IW20epWWOB1wo9Gh4LAFzzJ91
         MAcNJ52ihDE9sUT7qKMdlqCaIm4K/fkkhQa3ZNpDHIVEkMMK4IeWJtwgts1BWzaxNUpN
         dUwZj83qwqIPzlXw4rZ6RDrANlcDii0nyoRcwthYCO0zp+jKoqYe5jk5XJmu2qZ4xTVl
         h7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749576186; x=1750180986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gt5xZOhpzSeUolCdjzem+EeuO52qWGYd4U8ByxV5itE=;
        b=TPI4Fh5i0/VT0zx7c8JT2iHeaJXPBDwZr4F/N3rPSvTTem4w3gQ0RRaCgfCbYBLA1d
         jWiyEA0uswjF7zcvk6MlBytfj9a8E79Vi3qMzQDECXOfZlX6Rh8Juq+/SH8sKmM+B69u
         cZCDZ/3dXKDyBwcqXG56otJoVQVO6ueyAT2T+cOue/gnc3fxhRkDvDvCgNpIH3u5c88+
         o66QYrmpezP+V59EiZbnpFncCpmlTKESAdHoB+rKAACrr4gx3JGhgsFwZgxPG02/gd9r
         hKt81/CJuZ8hsrGEaZbwFUJvdjIaeNeZUf+13WeAjQC1DoNG21SvtOjfOWt6C3Yx420F
         2QIA==
X-Forwarded-Encrypted: i=1; AJvYcCV6JDcj+MinVXWixbsEJflfLvsRt79wSOdQMUJmAovxhILlBVjkuOmqxEvxJ/aCBbei6Fg9+v8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6LuUm99IY1/XVfgTmsPatY7QkodTVZInqf63DNx4dnaCZJQLR
	B/9NkQLhU53tAkbifUg+snReMf0nDSlS/6cC0b9sKHWH+HCEdJgTKt9aze8/gQ==
X-Gm-Gg: ASbGncthcbv9Thph7oOVEOVmVcG4xxJGO0tQIDTKRto0MCoEm2iJl6/rCoJD5CFgIX+
	LBVwmZKfzub+VrfJtX70ilQ4p8i5njnZQnjydSTa4zcFVqGONZM005y0nBUxFNpy2HeEYCl5MU8
	2VLz6n8u7130ckX7QDpETdiF32o+s1QcE0w0lfKGg/aFXbRXMLrqMbM8R4fLNvKt55N9YluO07R
	cAfhBbBxwW79E5+K5PB4hSkKnIQ8G4Opa7xk3b/wqgZ2yT2LMl9C6c4M7HAVSYGq/ZIRfnlkkSL
	Lx9a0/0p9Lmnwq5FQLib8RFzY1N3ikbqC/i8BdoaJWqLWjMW6j4z1g0c83FCE2A48/sE6vg455O
	LdPcfi1SOKRypWmuDtEuOH9GzT0UGhrEHWowYM0YWj5fTNr3AqC8Jo1a47PBfONsVPrqZTEGm/I
	Oo
X-Google-Smtp-Source: AGHT+IG/Jj0kdyJuwzgUq6/mTTB9uzJnKgA9P/8XBGY2h6AzKcMlq1xTVaIyskFFJStdts2VOIrDGg==
X-Received: by 2002:a05:620a:3953:b0:7d3:907f:7544 with SMTP id af79cd13be357-7d3a883ee1fmr32931885a.35.1749576186479;
        Tue, 10 Jun 2025 10:23:06 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d25a608d19sm716491185a.63.2025.06.10.10.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:23:05 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v4 06/42] selinux: limit selinux netlink notifications to init namespace
Date: Tue, 10 Jun 2025 13:21:37 -0400
Message-ID: <20250610172226.1470741-7-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
References: <20250610172226.1470741-1-stephen.smalley.work@gmail.com>
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
index 59960e9a296f..af4a6fddc863 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -107,7 +107,7 @@
 
 #define SELINUX_INODE_INIT_XATTRS 1
 
-static struct selinux_state *init_selinux_state;
+struct selinux_state *init_selinux_state;
 struct selinux_state *current_selinux_state;
 
 /* SECMARK reference count */
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 913a29eb3136..bbcbdb767c49 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -132,6 +132,7 @@ get_selinux_state(struct selinux_state *state)
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

