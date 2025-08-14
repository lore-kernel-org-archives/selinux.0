Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C146F302760;
	Thu, 14 Aug 2025 13:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178040; cv=none; b=eYnTwF/wylKaLpsEtbGPvYTs9OLysBfyQxf9WiMopQpo0Zo4Nkgtoq9l+IRm/MupfWPXZTfT5RlvHdFQsXAp1gSRlHICoVauUyzlBwRKsFxAb7C++PAi9ScLMOrI3fWK5YAm33C76ZSZtgKfHLqthmuch3n3lfOhSs07cEaG1eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178040; c=relaxed/simple;
	bh=KzhNPkW5iOc8N0smuipH9YkPtpWOiaRm3C2C9nelnLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNLjdIdT4M0sbIX9Y6efYJSKBJ5CDeBCcCIsqSY8SM5nc5DVIzt63qfFtA+MUQKRgnvg8G0kRKCJx2gZBeoXKtOnCzsJnzdq1CD8V67MijfwVLMhjz9Ea5Ms5Yful92+uKmpKKDd02b7l4bzDW/JgWTkk9RMOQxBWvVMb2E0tqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W22oSCTk; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W22oSCTk"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b109ae67fdso12840811cf.1;
        Thu, 14 Aug 2025 06:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755178037; x=1755782837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEQizxjJ1id8MX2ab8K42Y5KeIJUPJQZf0SfatvP9Gw=;
        b=W22oSCTkyzUv3gw/4+RhDZ32gY155D7NqjgrnItRpe7zPZA6qLPGli3hW03zCZUKZM
         AEgwQ6k4FEIZrO4Q8Ncz0KFmjhX5S0BAGD83sRiCP0utid5Zwup09IjKQEMz0Vyaf8cx
         hqaaRogXGNvrkYq3+zxma0DVaqbNo2BYA7TbycDMFcldefy+AbblNmu7LQAbcx/EBYHp
         CJKlBMFBj7OWFvzOZjAH9yrmplnGkwR6ZzV/111/LYcX/DECcItk1leVdcQIeOHVMH+h
         r6qQBApkz3hwFU/HZMPMGiHO/iWifT3NT4TozudTTivJSRR6F+37AlTyJnNiDlZa4E8B
         FiXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178037; x=1755782837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEQizxjJ1id8MX2ab8K42Y5KeIJUPJQZf0SfatvP9Gw=;
        b=AyxwJFem2XU0esjNA72TEakhG2xouMjdOBwXqaScReyTkImXsAqW59N+0STCA1j2Pp
         ZmKiuL0Lf6V6RHrKWGQOT341ZLcQ6ULqjXnmFN1b68kltoBwt6agsfpSSplCQGxniQ/O
         FXIDgVluNaE+msdckZCt7rUM1Ri5RI0Ib8gv4LS5DLRTlnU4Ic2eVQf/4ll9H4tNthoF
         3laDsjOHf2jsTd96RPiBGDMvf14WvUO5lwlluc3jV7JfUQHErnVep6nNL7gmfSvk34fZ
         zk7VRqJSm6q4uOJg0tjrPTqXOEsN7KMtU5hnNJDx/tRHqjx4F79e9Mr01vnqEUCohw3E
         KUkQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7eJTT591yOBNHQwRRN505RqqWOgERauSNcAIz/6bbKYPZeRqvXR28XN8K9jCHqVzYo3RwNnI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaYYWaXJjv6SG4c3S0YPdSxKXKjqO8VvJ1JU4hEmmZBY8p3T0A
	wdcGbPhrlyMghzpmZtYBfyn6QSH1hr19k1DGN9kAS2SNeTRVPUjTAwXi1NmDPw==
X-Gm-Gg: ASbGncsRLyqV2iTLxMT8V08y0uqIXIrMavh+NMVAEE9SKBhwovpYUPmkJV31OOnY9AH
	iOsptZlGkGRQOerC9aVpUMdrmqjBJvkWBN7qyfBO9Oc0gkS7BkAUaiXdtjxTHwuRNHHkWh3Uf/T
	qBeN1rdKAXQPAZisAmuuhGIcmtTZHw+rZFd2750e0LNHeCDjqWs9CI9sTsRzkfddn9m1Tw1f/Zt
	4n8T82FtaWAvRKpOEsbH7J52ov+gG216fiOJiBxKtoijZbZ3FUQ9YlpGbzrmC184cB5uRhR7tBJ
	ZjxHKYHNMRz+sREdUmE5VbgPwWOQIbezEo9wNy2hddgNKcpMmA6MaBE0wO9BFqX7fRPQY2Agwqi
	SYQe2VTAzQ50VygjI4Il9Ap11UcZ19uu4lx9QmWELxJtrGJwIWausjpBXHREkTUZLeMZrgTenx2
	PIlKGN29lHNqETioREdlhVlzrCLA==
X-Google-Smtp-Source: AGHT+IH0VhdLBsJe1Pn2RJncVWNUEwIi3WI2PEfnrWByHN2PJ/WYp4hO0Zus5hW7LGb2lXSckZTc0A==
X-Received: by 2002:a05:622a:1929:b0:4b1:103b:bb71 with SMTP id d75a77b69052e-4b1103bbf77mr24861341cf.63.1755178037390;
        Thu, 14 Aug 2025 06:27:17 -0700 (PDT)
Received: from fedora.. (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b0733088e1sm153587391cf.61.2025.08.14.06.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:27:16 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v7 14/42] selinux: allow userspace to detect non-init SELinux namespace
Date: Thu, 14 Aug 2025 09:26:05 -0400
Message-ID: <20250814132637.1659-15-stephen.smalley.work@gmail.com>
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

Enable reading of /sys/fs/selinux/unshare as a way to detect
whether a process is in a non-init SELinux namespace. This is
to allow the selinux-testsuite to adapt based on whether it is
run within a child SELinux namespace. Whether or not we want
to retain this as a userspace API is an open question.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/selinuxfs.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 3c2e828e0967..c8bc0c34a248 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -321,6 +321,19 @@ static const struct file_operations sel_disable_ops = {
 	.llseek		= generic_file_llseek,
 };
 
+static ssize_t sel_read_unshare(struct file *filp, char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	const struct task_security_struct *tsec = selinux_cred(current_cred());
+	char tmpbuf[1];
+
+	if (tsec->state == init_selinux_state)
+		tmpbuf[0] = '0';
+	else
+		tmpbuf[0] = '1';
+	return simple_read_from_buffer(buf, count, ppos, tmpbuf, 1);
+}
+
 static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 				 size_t count, loff_t *ppos)
 
@@ -373,6 +386,7 @@ static ssize_t sel_write_unshare(struct file *file, const char __user *buf,
 }
 
 static const struct file_operations sel_unshare_ops = {
+	.read		= sel_read_unshare,
 	.write		= sel_write_unshare,
 	.llseek		= generic_file_llseek,
 };
@@ -2237,7 +2251,7 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 		[SEL_POLICY] = {"policy", &sel_policy_ops, S_IRUGO},
 		[SEL_VALIDATE_TRANS] = {"validatetrans", &sel_transition_ops,
 					S_IWUGO},
-		[SEL_UNSHARE] = {"unshare", &sel_unshare_ops, 0200},
+		[SEL_UNSHARE] = {"unshare", &sel_unshare_ops, 0600},
 		[SEL_MAXNS] = {"maxns", &sel_maxns_ops, 0600},
 		[SEL_MAXNSDEPTH] = {"maxnsdepth", &sel_maxnsdepth_ops, 0600},
 		/* last one */ {"", NULL, 0}
-- 
2.50.1

