Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F292427C87E;
	Tue, 20 May 2025 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742469; cv=none; b=BXT7PqlsndDIfvJMAofDk0yIlSqBAGNS0uCX1yAseto5C/4f5slvcg5hyp8NheT+T+eEq79LWCPH7jZtITr3qcHK6i+VwPhtDoWMwaOjDsSaBdM1xvwSPv5fnnLizvcVNaUIcVMsVmnnrgRPmprT3820ooa7uS14HHtFNRgP7HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742469; c=relaxed/simple;
	bh=eU8WgAx3ii+FH/NhCp3C69yrP0RIrwSpVSYCtUqZ3NU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hgJD054pZg3paOfPCNLik9xQzDM9bp/sTnwthPBfhf+T+yZUxdZ2sDmON6zze2uurCBILTly2P00eSfbiLL4Dv7kt7i46PIZC/O7VmAVPqL+lbl6iCE7dplA85S8ihleY2kBet4R77QZz4xwab5dPMyW7k2pBRTJUYmKADYPgSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKopCgn5; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKopCgn5"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7c5b2472969so583173585a.1;
        Tue, 20 May 2025 05:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747742466; x=1748347266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gR0g8p04tPHmKzvAEwAOf0jxHYKg5oK1Gghu4QnchLo=;
        b=WKopCgn5Y9D9GY2ASID5Agi10dBdwYF2892t/IYyZwBvJIIGqfYfYpDJIDjZTViqxF
         D0mphnbcssy+D/SMbhPBn0AbsZaAOFPXCWPN2/gOVcOis8MZUwTHMLnvVxOMnlzk5RpP
         jBNTF0uS87UJ7sBW/cgF5jfgQQix9OuVLWyVrhD08CcX17RIt8cqXNlz1SA4BAecMrSS
         67VQ5Y/StIemBr+1S9gJDNkME+m5aiohk+ZKsUpXNrTMJuNWZn6/Dg6VdQ9yy/paHSEX
         z6B6Q4oG2goimkAeP6n3fATtf89vwVsvOqrVa4VQt3Sp6aX/dZmzSE9Z8CSO6JiSVp9G
         rYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747742466; x=1748347266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gR0g8p04tPHmKzvAEwAOf0jxHYKg5oK1Gghu4QnchLo=;
        b=UJXNBiHqx8Ryfzqy4MDQqd5sHbnL8TPnw2YotolgImjj4fSdfI4g5tu2S8MCzGaEwD
         eHz4orvubfpvhYAfrVR6HmwXmD74BfAsKiebCisnwdpG5NM1t1j2F5biYCaJP7Hz6vw1
         GyOLEwfXIrU0f/yP+O7MraTRsnRhcW5XbNgl2R/oVM5CJFG3p4JTtSNQLIQL3ZIwNIAs
         j3imUMFs6ZYVsR9tXuV3B7ZLTwy4PRssWw8j3UFVtkXJb0YJPvtDA2GeuH0KjTQYg/mw
         vDq/2TJ1DobTs3NueR4ym1tIjlRj77HYMjKcsY6bUI648FIlU3Wty6kv06myt4BFGtoX
         2NHw==
X-Forwarded-Encrypted: i=1; AJvYcCUxnjx9ej4sz4JeiLu9Spi0EXwDwvLSTEZ6Bjiegzg7QJsLNzhT4GdqnfH7O+a6xadxDjyTXHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDYxFO/tjPAZyIrsfqNGsanATgDzUp5siFYO+SBk9l3qJUsWIT
	5cuJj4IX+QMafiFbKKTFp9VN1rJeLxSbQVO+j2Acq5p/XMksLqiozpWQZ/q+9A==
X-Gm-Gg: ASbGncu9fcas02TKRHOB4xNmhBg97o5c5XTv2LltQEPTzjekJUk1GzjLYVD9BOPMpqm
	02r+jwwicKKFrI+qMY/o+cX6Ee/k8aVyXCzGzFHHORw7cwWVRYMEXN4UQvVHlPioyJU+gcu8MVm
	Kh7dQo37ASildJjT5dEOB3KnBrjS8R2RO9+7gJLG8lutXPJ0mxxqqOZCmc/I9Mmxe7yo/P3Pgq4
	R0leAjH18J9MD5SMdo40++c4lOEl1HOE12QH9AgMA7iVc0Wxvv3tUsCq/fOsfy5XflOy4hTKORQ
	0IGfAzqzbJatfOukJ/jejTr8gzu/N86eJ9prz/uqfbEX+be1miOHfIGxajdu2S15pG+ipUkAokY
	qTVdTxzsZ7SBerwsnroKLwrjGPHE821g2zL5ysEMhReDQ5+mUXByre3n/IZk6wUt+
X-Google-Smtp-Source: AGHT+IGtuIhc9naUcFwAa0VLFuLW1u5VrSOFEhjc3cc1jh0JLUnSmAN/eL/6yuOmAD8BKLD3X6TQ0Q==
X-Received: by 2002:a05:620a:4ad5:b0:7ce:ba1d:400a with SMTP id af79cd13be357-7ceba1d4361mr1110497485a.30.1747742466119;
        Tue, 20 May 2025 05:01:06 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd468b6e52sm728409985a.77.2025.05.20.05.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 05:01:05 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 06/42] selinux: limit selinux netlink notifications to init namespace
Date: Tue, 20 May 2025 07:59:04 -0400
Message-ID: <20250520120000.25501-8-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
References: <20250520120000.25501-2-stephen.smalley.work@gmail.com>
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
index fe4c65b132a4..414889634661 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -108,7 +108,7 @@
 
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

