Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A2137D11F
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 18:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787683176; cv=none; b=kZ667Fll8zN0Jjtfcdv/+Z6bGHtt/BepEVRppxQoMaGgDFFmqncDKQgBzX9SMClFV856/LSMdc8M0SYrSJ4Tur0lCaqHapMKXj5Gjjytrx3Shqn7XufTmifVNlM0s3kHwqvnCBgFWwZinyGugYWV/V8C+BIW3ch7YhSXe0Y0m3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787683176; c=relaxed/simple;
	bh=EvcybHcv68QQFqGtTU8tppP5khSatN4aJvvfORGlQbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P9G2rdZzAY9OoFOQpbcA/TgqzLhW+fcXzSm6u17RoI5Trm+F6GcBWeYD43VA8/NPDx6m6mFRXa1PA8ddldI4vRNbBgdPHe9e7kPxMhMUb+F8C6C8BKQ462yHbebhBq0d7r7Ht6ZFsWDgO45X6GIobvq/lLI2RQF81jr4U46R3gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XZ6tmQ8m; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XZ6tmQ8m"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a17c7c3c6eso1732a12.1
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 11:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787683173; x=1788287973; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1FmJj7cqvHGQvjzRrY8P2RyixQ1zI0rgSWEthVkE6Ms=;
        b=XZ6tmQ8mLDB6w/7Yr/DZ2g05HWjEvjGQd7Z9ro4nd2pqAp0jCMCo96HWNoI91M/bJn
         W9EZnZTm53+J66mEdc/bZN4vi2iUd3Zjd5xeUqUmYYNz1TQjhqGf4OrbrYvisHJ3DRe6
         fjg5o4Lo5FV/7DmbeuvB8kMbhk6Xei80i5btJtgrjyJRjv7dlb2jPXcqEVgHaCk3DFGP
         L5AXf3XnZl9hpkSa+rSwSY7c0SpiY21FBr3u++RVaIJ7wQy2EksrDBUBtBYWSl/xAu0X
         2GLiyTPDEj2eFWpASQUsu/K1GccW5wioG8BMKgqEZDbqAKv2L6B4ZH+c6HKeVRo4ux0Y
         Ec/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787683173; x=1788287973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1FmJj7cqvHGQvjzRrY8P2RyixQ1zI0rgSWEthVkE6Ms=;
        b=Vh0c+fU0LurhRnuFXV0Xk/1rVKfyTfBt9Q++Oj0YDsbEY+4wUsgPQOtWYeuFgL/nzj
         4JFD4xFW2sPQ8e309yv31qZeXLUwZML6/ZakZR4ma4/Dtf2o8UDPr/rTYWnLlID8o/bE
         y1NeBYFBztFq3IQ6hJ0SvsKYr/z2+8hcPpwHkol83YdYNOtUBVqLfsvlM87D52wXAPiC
         K0zozks784uK/WItyx6E/T2DWfYwIHjrTOycZ7T4lgmJCfDkSOCirx3bjvqYm2n0DhmZ
         XaL4wM7lODMQ+AKhrxLD582kD0WO0HrtKdml+t2hAFeGqbpPhzNQPdSNjJiMfKVhDC/e
         4jAw==
X-Forwarded-Encrypted: i=1; AHgh+RpkTKV9PlSVd9P2Yz7aDxBt1P99UxqyatpqOU0dQplXRoKcgK3FZr0w0B4cF6IuMJ4Cr9alEhXE@vger.kernel.org
X-Gm-Message-State: AFuF++l71Q2dHuzCMk7hmB6nXV/oqfJ2F38cLaZLZH43lB9sWa5Hg2kG
	KqgO7JhxZLqpGe51SnJL+xE77qBOD49daFXIGbtaTNNtm1Eq3VH7gFl703iIdw4RRg==
X-Gm-Gg: AR+sD11tEK/Bs2/RuBzVMU9x/dCZ2ngvUkuc54BpnMjh1GgrJp43rZXApx3CMk/O9jo
	JyiU2JlW7ZSrVABilYWETrQ/0lZbxivIcLTBEXjuYcB8Fzca4MJrJglgW6fhFr7F0b2zzOuUy8/
	QCtXTwvY80X5uk4/Lz3YU4SoIP8Wn2mecUF2jT4qBDJCFJh4cO9jt/xX18knf7XfjVplzloXgTM
	Vk0TAkoKpK+h1LeJTfsOAV3/0AvxhulV7VZxs7MiUccpWY0KnHvmTzOA+kPNx/KIZW3BR1kl6KF
	RaQuyQm1N4ZF6GVavpE0CkMDFrmNYstjMNX2XVu7wwCSgcdERHDM9pphMpvP/AXo6C6OeqiiwVN
	LZhxCIeghaZzuR0TRzs/hxRqE5lP5tIMIM//stPRW2r5rfmXmrMFAhf4Zis2Tavg4SSzydFOKMA
	IT6pPBZuxieviFSRWodfRRlN7a2+stWPuV3yUSjWWNivInZwwoio4R6f31M3WHkTp4BfixYnF8o
	KT3AnPtVE5kKxb32xCHuuLAZkcOlG1ByZjwGQqNY0M0w15hM0FPHIHuZ0o=
X-Received: by 2002:aa7:d5c2:0:b0:6a0:a317:9c47 with SMTP id 4fb4d7f45d1cf-6a5dfc8c1f0mr810a12.3.1787683172270;
        Tue, 25 Aug 2026 11:39:32 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:980a:b43:2df6:51f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a73038asm69027666b.26.2026.08.25.11.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:39:31 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Aug 2026 20:39:18 +0200
Subject: [PATCH v2 2/3] proc: query LSMs for introspective mem access (if
 PROC_MEM_FORCE_ALWAYS)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-selinux-pokemem-v2-2-b46bc64916d8@google.com>
References: <20260825-selinux-pokemem-v2-0-b46bc64916d8@google.com>
In-Reply-To: <20260825-selinux-pokemem-v2-0-b46bc64916d8@google.com>
To: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Stephen Smalley <stephen.smalley.work@gmail.com>, 
 Jeff Xu <jeffxu@google.com>, 
 =?utf-8?q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
 Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787683163; l=5578;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=EvcybHcv68QQFqGtTU8tppP5khSatN4aJvvfORGlQbE=;
 b=igbKCV8hulK01S94Oo+xDmbcq1U99pUxYx+EQ5tzIO8NSfr0cXrRdmwJeGJYn+g/tUpMFtdcu
 FofuUvk4b/7BlRlmB25d4jPjJcAmBINNjve28kApv6HHEGCZVbae/uY
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently have no
good opportunity to block a process from overwriting read-only code in its
own address space through FOLL_FORCE writes via /proc/self/mem.
The security_ptrace_access_check() LSM hook is bypassed when a process
opens /proc/self/mem because this is considered "introspection".

This causes a hole in SELinux EXECMEM enforcement, which tries to ensure
that a process cannot create executable anonymous pages.

PROC_MEM_FORCE_PTRACE prevents that and ensures that such FOLL_FORCE
accesses are only possible when the LSM allows ptrace() attachment; but it
is unclear how quickly PROC_MEM_FORCE_PTRACE can be deployed in
environments running lots of third-party code, such as Android.

So, introduce a new LSM hook that can forbid FOLL_FORCE specifically for
such "introspective" accesses.

Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/proc/base.c                |  9 +++++++++
 include/linux/lsm_hook_defs.h |  1 +
 include/linux/security.h      |  6 ++++++
 security/security.c           | 20 ++++++++++++++++++++
 4 files changed, 36 insertions(+)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index bec6197329dc..dc6fdcb47b79 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -851,6 +851,11 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
 /* private_data for proc_mem_operations */
 struct mem_private {
 	struct mm_struct *mm;
+	/*
+	 * Was the ptrace access check on open bypassed because the opener used
+	 * the same MM (introspection)?
+	 */
+	bool opened_by_owner;
 };
 
 static int mem_open(struct inode *inode, struct file *file)
@@ -864,12 +869,14 @@ static int mem_open(struct inode *inode, struct file *file)
 	priv->mm = proc_mem_open(inode, PTRACE_MODE_ATTACH);
 	if (IS_ERR_OR_NULL(priv->mm))
 		return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
+	priv->opened_by_owner = priv->mm == current->mm;
 	file->private_data = no_free_ptr(priv);
 	return 0;
 }
 
 static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
 {
+	struct mem_private *priv = file->private_data;
 	struct task_struct *task;
 	bool ptrace_active = false;
 
@@ -886,6 +893,8 @@ static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
 		}
 		return ptrace_active;
 	default:
+		if (priv->opened_by_owner)
+			return security_mem_foll_force_opened_by_owner(file->f_cred) == 0;
 		return true;
 	}
 }
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 65c9609ec207..50e3f0abc676 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -36,6 +36,7 @@ LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
 LSM_HOOK(int, 0, ptrace_access_check, struct task_struct *child,
 	 unsigned int mode)
 LSM_HOOK(int, 0, ptrace_traceme, struct task_struct *parent)
+LSM_HOOK(int, 0, mem_foll_force_opened_by_owner, const struct cred *subject)
 LSM_HOOK(int, 0, capget, const struct task_struct *target, kernel_cap_t *effective,
 	 kernel_cap_t *inheritable, kernel_cap_t *permitted)
 LSM_HOOK(int, 0, capset, struct cred *new, const struct cred *old,
diff --git a/include/linux/security.h b/include/linux/security.h
index 153e9043058f..74eb876054b0 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -338,6 +338,7 @@ int security_binder_transfer_file(const struct cred *from,
 				  const struct cred *to, const struct file *file);
 int security_ptrace_access_check(struct task_struct *child, unsigned int mode);
 int security_ptrace_traceme(struct task_struct *parent);
+int security_mem_foll_force_opened_by_owner(const struct cred *subject);
 int security_capget(const struct task_struct *target,
 		    kernel_cap_t *effective,
 		    kernel_cap_t *inheritable,
@@ -676,6 +677,11 @@ static inline int security_ptrace_traceme(struct task_struct *parent)
 	return cap_ptrace_traceme(parent);
 }
 
+static inline int security_mem_foll_force_opened_by_owner(const struct cred *subject)
+{
+	return 0;
+}
+
 static inline int security_capget(const struct task_struct *target,
 				   kernel_cap_t *effective,
 				   kernel_cap_t *inheritable,
diff --git a/security/security.c b/security/security.c
index 71aea8fdf014..fff26ff65e07 100644
--- a/security/security.c
+++ b/security/security.c
@@ -595,6 +595,26 @@ int security_ptrace_traceme(struct task_struct *parent)
 	return call_int_hook(ptrace_traceme, parent);
 }
 
+/**
+ * security_mem_foll_force_opened_by_owner() - Check if introspective FOLL_FORCE is allowed
+ * @subject: credentials of the process accessing its own memory
+ *
+ * Check if FOLL_FORCE is allowed for accessing process memory through
+ * /proc/$pid/mem in the case where the opener's MM was the same as the target
+ * MM, meaning the security_ptrace_access_check() hook was bypassed on open().
+ * (current->mm does not matter for this; for example, if write() is called on
+ * an FD that was received from another process which obtained it with
+ * open("/proc/self/mem"), this hook still runs.)
+ *
+ * This is only used when the system is configured with PROC_MEM_FORCE_ALWAYS.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_mem_foll_force_opened_by_owner(const struct cred *subject)
+{
+	return call_int_hook(mem_foll_force_opened_by_owner, subject);
+}
+
 /**
  * security_capget() - Get the capability sets for a process
  * @target: target process

-- 
2.55.0.860.g4b6b3295ed-goog

