Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB14374EA
	for <selinux@vger.kernel.org>; Thu, 17 Apr 2025 00:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744849219; cv=none; b=bG7nCJ0RZcz8+EXBmRRnBlqtoPwjSGW2ERwRMoAJudvsPbTI3U+re7IaqK0sgotAN2AWOOOINAk8Qoy5t3k1c19dAGjCajXzSD2RJZ9SSA7Obgy0U1wt23GG/nbvsVNS0J4vuhWz5XX9aFvOQjmmzdy15DaCeRg1ecQtR5rqXa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744849219; c=relaxed/simple;
	bh=Xn0fhZah7VNoPSuth3cgN/5HbXDJG8TMVcqhWqJBa5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ogsrl+XbHHzscxmHtr5Xv1rvX1iVvb1ISJf5t+4taCUwjyQh3aLvx5NgD9cKtVnXVbd+t+s72L5u+XOFF8So7wNS6VZHtJYVNh/yvrIUpyXj2XNh31JQII6jJ+NrtaZ96pRxznJeNmrUGYTgv4MrrJKiEhpHP/niw//wejKpuzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ev6SCRPW; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ev6SCRPW"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22401f4d35aso2803405ad.2
        for <selinux@vger.kernel.org>; Wed, 16 Apr 2025 17:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744849217; x=1745454017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p53AigewFBsQmQbaVqLDW/4G17Cug0mvmUxIn4ebZoc=;
        b=ev6SCRPW5IDRwKA3f4otld0MqAVnhpehg8ZRX/H/ecVikSm5TxsCSQpORlo4/3W5jJ
         nb36KCOPVV1w6DRDhDWIftZfNPNxLWgJ730iFXnMbpK3IpenbgXNeHIe7uN7NMCSojwU
         ploYl4Q2nbzHNtsYsdwvskVHDgNfj55FnlzDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744849217; x=1745454017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p53AigewFBsQmQbaVqLDW/4G17Cug0mvmUxIn4ebZoc=;
        b=Lc4ISE09TjzoKRUZTheNj48Cc9HdcrmrTGL0v9UdrclT5mBo2pGPPb6Oo8trfWRVca
         jpCq0eCcfrNZ4aptpFp5NeLnfXH3y/NCkxcgOcnl1urr0L4qnEIX2NtaABtyvIulGeb8
         /tsJBC9eHLa4pUaQOjxhZ0B5gJFmhkWvD2WC4anfGy/kq+P4zzXyQidaOQBlXAP4DWmi
         BNd9d8slCY6paDHY6r9ZCeG7gNaD2qWwK8SgDxIDy6Te7D67bDXDPg7O7rVH0AEsI5k1
         QCnX+c/iVD6y311vOTKiMSRKbqDeQlFqH/CNgULUlMCqki/I62moKNyPU0dEbTDEVTxQ
         Qp+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWY0726BNYiggvJQPN+HklOKPStDVYuu9U/bDTLWMH/Mmb5C5d9PWr5gf7JKoWSeQDV3YyEFlAS@vger.kernel.org
X-Gm-Message-State: AOJu0YzIq/AgPx1oPNzh0Yj8kWXS54PEw7Y24p0HZdGvRpa+j5DW4gem
	dJlfzl3fBMsgGl05pRFbyqM4oldu/Z67P3+cZ8nM16IZ16urpjh12cm7snKsfg==
X-Gm-Gg: ASbGncthXhSwOQPexyNY8z1tqlP/xHzpdSH+SHnAGVEz0vc3rsuYFSUrYoyyr7e3/l8
	/HE+xZz6b41zVcCfnmOz+ddbBh8YEb0JEnsdAfQA7wZmbn3dBZ8MeVHaBAfwur7OLP8u5Ce92+1
	YVAh1iLBOb93giTUS8f+t8P1hkje2JW8zKpYnLasBsje4zUHjmmsMWRJJT4MFdwXQX5g7ru78kh
	eQdXVA+8SUbghjRf5LBA4feL02akPnggV6ulEK8xuzNWs0ot1QKsnWqtSsIkcFMThCUpmjHn1Xc
	SZFZzvi9g+G0P8tce40WRP5F9xVsDMgyd5yAq/zi9keRaZYzeWcM+XqmIbkZ7hE2HljospEEoRM
	GOzrgIuh9s/3iNkV9xftIft3TmzjJNMsH
X-Google-Smtp-Source: AGHT+IGNOO4PihoQLJC4VWdU+RdzRjOAKlmBvKQqMIYr7rV7iQC39qD2+3dZngycgcfs6Xuy7d4Cjg==
X-Received: by 2002:a17:902:f686:b0:223:42ca:10ef with SMTP id d9443c01a7336-22c35984391mr59251915ad.43.1744849217023;
        Wed, 16 Apr 2025 17:20:17 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (132.197.125.34.bc.googleusercontent.com. [34.125.197.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c33f1cd87sm20719205ad.73.2025.04.16.17.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 17:20:16 -0700 (PDT)
From: Li Li <dualli@chromium.org>
To: dualli@google.com,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com,
	joel@joelfernandes.org,
	brauner@kernel.org,
	cmllamas@google.com,
	surenb@google.com,
	omosnace@redhat.com,
	shuah@kernel.org,
	arnd@arndb.de,
	masahiroy@kernel.org,
	bagasdotme@gmail.com,
	horms@kernel.org,
	tweek@google.com,
	paul@paul-moore.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	hridya@google.com
Cc: smoreland@google.com,
	ynaffit@google.com,
	kernel-team@android.com
Subject: [PATCH RESEND v17 1/3] lsm, selinux: Add setup_report permission to binder
Date: Wed, 16 Apr 2025 17:20:02 -0700
Message-ID: <20250417002005.2306284-2-dualli@chromium.org>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
In-Reply-To: <20250417002005.2306284-1-dualli@chromium.org>
References: <20250417002005.2306284-1-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Thiébaud Weksteen <tweek@google.com>

Introduce a new permission "setup_report" to the "binder" class.
This persmission controls the ability to set up the binder generic
netlink driver to report certain binder transactions.

Signed-off-by: Thiébaud Weksteen <tweek@google.com>
Signed-off-by: Li Li <dualli@google.com>
---
 include/linux/lsm_hook_defs.h       |  1 +
 include/linux/security.h            |  6 ++++++
 security/security.c                 | 13 +++++++++++++
 security/selinux/hooks.c            |  7 +++++++
 security/selinux/include/classmap.h |  3 ++-
 5 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index bf3bbac4e02a..795a507db537 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -33,6 +33,7 @@ LSM_HOOK(int, 0, binder_transfer_binder, const struct cred *from,
 	 const struct cred *to)
 LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
 	 const struct cred *to, const struct file *file)
+LSM_HOOK(int, 0, binder_setup_report, const struct cred *to)
 LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
 	 unsigned int mode)
 LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
diff --git a/include/linux/security.h b/include/linux/security.h
index cc9b54d95d22..fe600fb37c98 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -338,6 +338,7 @@ int security_binder_transfer_binder(const struct cred *from,
 				    const struct cred *to);
 int security_binder_transfer_file(const struct cred *from,
 				  const struct cred *to, const struct file *file);
+int security_binder_setup_report(const struct cred *to);
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
 int security_ptrace_traceme(struct task_struct *parent);
 int security_capget(const struct task_struct *target,
@@ -657,6 +658,11 @@ static inline int security_binder_transfer_file(const struct cred *from,
 	return 0;
 }
 
+static inline int security_binder_setup_report(const struct cred *to)
+{
+	return 0;
+}
+
 static inline int security_ptrace_access_check(struct task_struct *child,
 					     unsigned int mode)
 {
diff --git a/security/security.c b/security/security.c
index fb57e8fddd91..5acf364e610f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1043,6 +1043,19 @@ int security_binder_transfer_file(const struct cred *from,
 	return call_int_hook(binder_transfer_file, from, to, file);
 }
 
+/**
+ * security_binder_setup_report() - Check if binder report is allowed
+ * @to: receiving process
+ *
+ * Check whether @to is allowed to set up binder reports.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_binder_setup_report(const struct cred *to)
+{
+	return call_int_hook(binder_setup_report, to);
+}
+
 /**
  * security_ptrace_access_check() - Check if tracing is allowed
  * @child: target process
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 595ceb314aeb..f02249345c4b 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2103,6 +2103,12 @@ static int selinux_binder_transfer_file(const struct cred *from,
 			    &ad);
 }
 
+static int selinux_binder_setup_report(const struct cred *to)
+{
+	return avc_has_perm(current_sid(), cred_sid(to), SECCLASS_BINDER,
+			    BINDER__SETUP_REPORT, NULL);
+}
+
 static int selinux_ptrace_access_check(struct task_struct *child,
 				       unsigned int mode)
 {
@@ -7295,6 +7301,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(binder_transaction, selinux_binder_transaction),
 	LSM_HOOK_INIT(binder_transfer_binder, selinux_binder_transfer_binder),
 	LSM_HOOK_INIT(binder_transfer_file, selinux_binder_transfer_file),
+	LSM_HOOK_INIT(binder_setup_report, selinux_binder_setup_report),
 
 	LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
index 5665aa5e7853..de7e28572fda 100644
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@ -133,7 +133,8 @@ const struct security_class_mapping secclass_map[] = {
 	{ "kernel_service", { "use_as_override", "create_files_as", NULL } },
 	{ "tun_socket", { COMMON_SOCK_PERMS, "attach_queue", NULL } },
 	{ "binder",
-	  { "impersonate", "call", "set_context_mgr", "transfer", NULL } },
+	  { "impersonate", "call", "set_context_mgr", "transfer",
+	    "setup_report", NULL } },
 	{ "cap_userns", { COMMON_CAP_PERMS, NULL } },
 	{ "cap2_userns", { COMMON_CAP2_PERMS, NULL } },
 	{ "sctp_socket",
-- 
2.49.0.805.g082f7c87e0-goog

