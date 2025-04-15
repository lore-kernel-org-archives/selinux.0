Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B71275852
	for <selinux@vger.kernel.org>; Tue, 15 Apr 2025 07:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744701032; cv=none; b=Eh3m9kR854Yca+vdkPyzZxVDHsqQg9OW6vzB6IF2Il2+1lpyTeB9VSD8LZw3jfB2vafXFSqVf78zsxwu59QVvHGV2eBiFpKp8O1RohTAdr2Lixnn2cld+aYsuO+3eu7KgXmtApKZexUd5A8oIgPW02auOrOv1miPIVJ1f0CZBaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744701032; c=relaxed/simple;
	bh=RTyV6CuY1ILJEHa4mBQoCKQeLLKta6AOsqk80g5KMLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fvXF0j59+odk5aBR3sAK6UleQiM0HNWJ8tE4tKpd+FewzlK8Z2i0dTPkz5ZADzuttGZbUu5808Nlp3EWdOyjYkxMGwTkoUI/vwmkw+6WHCXefeXBhBW2WSgoBpN1DcFxGTbU/8BpDqYfF+nbvWybakEX4oFpXi2ZLUoSs4IBoeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I9aZj3y3; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I9aZj3y3"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736dd9c4b40so5126704b3a.0
        for <selinux@vger.kernel.org>; Tue, 15 Apr 2025 00:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744701030; x=1745305830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CYejmGyG0ZZvUYJF2X4xi2wGhXKVNeVaxdRV2uzAA3M=;
        b=I9aZj3y3cHEMUBty5lq8ODSUowbmadboLJpqx0MYGvLD40Ou9C03HcsLz1KMiAQfXw
         d2PofoGIX07HrE55tF1ciTkF/lgX+/ns0f2OHIE4jaa4qsuY4/jhMgBHYvZ71+640iCI
         xluaTlHOtrSjcIPVJ51u1X50jPFilW0hIQV0U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744701030; x=1745305830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CYejmGyG0ZZvUYJF2X4xi2wGhXKVNeVaxdRV2uzAA3M=;
        b=rs9YjVtIgXQzdRLeXF9Go1B6jtoYNOzl+jKRiU8SWaP8/DNKVg0R8vsxvgDtBWytSm
         QQ/0480K3//kuHJpwrJIJ7mZWlHtUn2PLhHBpOwzbRkvwdIKrHoEYRzssmd9d7qXSuUW
         P/EuLG3bGNWnnSnlvN/4nAwXOrB7/kGkrWffW+t4Hiav0DwjPbP5x1RKatGoIoQnKpmS
         GBpM/0roNmoSiVB/ESDYpZ+XnSq9BlCqabklButMfyDQF2YJPEavqkXngv92HPopJVyZ
         gLugzGu9ZiefEl4jIJL5N1Oag/cooMyz5WjUBogSv6Jfy/qWbF7Fw1Z28AkuauVPpO4l
         a8BA==
X-Forwarded-Encrypted: i=1; AJvYcCXyLwUGsx3ARyBO1rONHg1VDwSvrlZXkBUskoqEgRg2UmADFVmj3lUvca+ndImCnXHa6zoCS8n/@vger.kernel.org
X-Gm-Message-State: AOJu0YxzbKbTKQkgf1wRdBvxydmtHim7X+4v9hs0geASFbXmej72J6Lo
	8q24o41AQKRIpsZm7sPwNZmjf66z5xa6X7mfrmKgUgypG+iQbtr5AlFzvFuElA==
X-Gm-Gg: ASbGncs+3wXNMQYmkGaV1DQZB+/0YMJmjPILKaRtF8VBNQg0IjJwsEa+IriFkNWg2uo
	PQm+fT7T8btZWTnDsHLSeMJTtbV93DcuyIfIEBiJEyOd8AdMsiSe4KUNLel4FHSYOT4C3Q6OUxo
	UzTmZolMqwZeMBod+t5vTeSeTZSr+0vujaIQqSwgFKBh0v9P+11KYXAHMfHGvxZYnI3hYTKX+EC
	9gziDdtuQwXGfH8zv85i+AHvfv3jxFj0HMEqd/UNBr0F3teFWDo1Gll1P7y4hVLu3LAho6ZEYhp
	1dzVIHKnFPNcSfE3lr7EWbssry/l/xs5dpIjqU8y3OhcoRSBZT0df0h1gQF5Xe92QtCYAAxC5n4
	cocjOpHxrnRfSMKJ+Tbxb2BIu0mjdR3L/
X-Google-Smtp-Source: AGHT+IGWTN2yQeSDJJtvSK1ZNh/SieezMonVkazgrlx4GpaEw0oeWFpAkP6J3Bf+UHyZnh1uBjuWfw==
X-Received: by 2002:a05:6a21:7a41:b0:1f3:2fde:8a6c with SMTP id adf61e73a8af0-20398df77b1mr3778675637.4.1744701029869;
        Tue, 15 Apr 2025 00:10:29 -0700 (PDT)
Received: from li-cloudtop.c.googlers.com.com (132.197.125.34.bc.googleusercontent.com. [34.125.197.132])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a2d3a250sm8659543a12.62.2025.04.15.00.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 00:10:29 -0700 (PDT)
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
	hridya@google.com
Cc: smoreland@google.com,
	ynaffit@google.com,
	kernel-team@android.com
Subject: [PATCH v17 1/3] lsm, selinux: Add setup_report permission to binder
Date: Tue, 15 Apr 2025 00:10:15 -0700
Message-ID: <20250415071017.3261009-2-dualli@chromium.org>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
In-Reply-To: <20250415071017.3261009-1-dualli@chromium.org>
References: <20250415071017.3261009-1-dualli@chromium.org>
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
2.49.0.604.gff1f9ca942-goog

