Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED4A37C909
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787683174; cv=none; b=rO/AkrhLPHBbkK6mqXO3S8Cf4nYWcaXTBRI5VmZICcHbw90OT1ELKqDdhXCLkWh9jQuIrJ1q3R3HjWNkAKr2ti8s1iZ7Wqo3NiXEFRHLp1AqAOgvv+I/gwZCG3fNZiX9UW4f1443I5Z4Ek2Hqt5/4j6GpYhufUR8FYu5uz8fiCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787683174; c=relaxed/simple;
	bh=cMZpfmy5y60iCBgOY8zKfRDT8aXfoJ3FsT1GEaT5qgg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iO8WvNspCLEp4KdKjzd6JXHKGDX9q7NEnyeFpPfuwuJZbC0h6x3jzrR0OnId1LEkjNU4q/6FqaQ/x8m4wQRD+iQFPPRfDe4R81+nfPyZD9Y7LCrtdMoIOrxWdaTkhh029zdy2jSiVC8cqWuUqEmV3btle7gr+qUbwpd5ctpvmnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tzNhsjoo; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tzNhsjoo"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a17c7c3c6eso1716a12.1
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 11:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787683171; x=1788287971; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZDanl1d4pFlCVpfToYIsXIfzb7i9JlEtociyRendWt4=;
        b=tzNhsjooTe031QUmSXR820hYC2b+oTzglcWqV1dElHG4uqYvSHKSB+HobBfpRwVEwB
         9G5PJB0BizVEDVo6HBVNKjtCkceGnHfEUc3e81hiNjsiwUNqCGcOO7eJ65k9ueLbGTZo
         qTytBVEUkxFZtzrd1dHF1COEOTXn8qsgHRY/En6NMfyWNFkYJNv+5XptXmuVV3kAWVvz
         UHNzZmjdMIjkTC2v1htpwZm7J1xHQcviRQXE3sPkaqMOIeHzpTk3/TMKXwiTt6knz94r
         rn5qJ6OPKqKCo1BYN60V9ZZKf/eV09eGkmfxmVOrKptAPu9Qr57nOY8gtW/swDlLmw8g
         DyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787683171; x=1788287971;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZDanl1d4pFlCVpfToYIsXIfzb7i9JlEtociyRendWt4=;
        b=lyY5JLBnPQVapNXdQdhFrSWqmUNzMDuyBtt/kbYM9wTUpiFLBlc7l1njLDQJncX37u
         aQwzFEvNvLAwFtgo5tQVx6ZJGO80vKyaffB5ElH91HS8Wn/o6lHdEzrdFKMRjU9cRE9D
         NU5kr7XWbJuuMEJnptX6C+qEINceH+8tM/9776Yj7M5+k48VkHlCSG60owOzXNQFFxpQ
         k+ISvbqZgsHVWs8HKl945N7EGHpwt4oQU4kvjYxm2nYU3Iaapmz5e54Dui2wCqrSXJQa
         3rd2UiM67wXNGOhcGFhos2Wp+UaDAzPXKX4vVuqVs4IE2zBzMYVvKcCoQ1/SNZJ4k9LH
         plrA==
X-Forwarded-Encrypted: i=1; AHgh+Rrre5dI5CurJq0zGFhJ64lrQnRnRu1BQXePPTEGi2tQyrv9AtNd/xB3QX0PdicGG0/vp2ESmXsM@vger.kernel.org
X-Gm-Message-State: AFuF++lvir1mb4HJvgQC9OpMu4C+3Czj12j1k6CpZBN+x66sDTySN3qJ
	PjyCNbXh0irCiZEXaZVTt/d7Jw+Edu3C8dNrIncQrcVRrAMLtov9UTvkbDndS31HgQ==
X-Gm-Gg: AR+sD10DLLmUTvDnB3YqjDH63XM9XgyT6TToBHSx4ik3Er0efPV52LqCPuYDak7vB4e
	7WMb0epa0ZSS752cRtyJXCu84EJozqQ5SU6JxUFciQySvddYrXdwPCWW1W+Oo2WTS7X7csNfhe6
	OFyUCL3UjwnbThAaUp1aCdbjf/SI6/xsHesfv2vdGwkcIik5D5tO22n3B4wGb7l1GBPGVYh/t98
	KBuo9Ta0V3DFqe3NMElrjerF7s/dqLDEfEI0U+aHr0GN9Q/pAbKqlsmU/Y0gSoEPWJOy2JOOvyI
	F9uafJsaqTBhFkJ1ctBxAgUcSduXuwAjftKjRcibVFSVk/nKhaVVlthvOCAJher5juQs7sm92sC
	NYtNNTHiIIDlCS9BU0gBoe40ChdKbUzJ5sDDubYNXB2eC4A3YSYdqsVLKgdTnl3lUNjEScY+mCt
	7RCvagOlnXLJJw0Z+Z6GfXFcjUOv2vpZ6HFPCekRdxvYiwN5u+xYhTRDcR9MFqS9k6TyPCsm4Om
	zFTV+CLOH4dfdtmD/mosPWArMQE43EGqvtbt4DEp5tWgs4=
X-Received: by 2002:a05:6402:1503:b0:68a:e1ba:9cc0 with SMTP id 4fb4d7f45d1cf-6a5c4a438c1mr79208a12.8.1787683170518;
        Tue, 25 Aug 2026 11:39:30 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:980a:b43:2df6:51f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a704e55sm77188266b.21.2026.08.25.11.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:39:29 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Aug 2026 20:39:17 +0200
Subject: [PATCH v2 1/3] proc: refactor /proc/$pid/mem to use struct as
 private_data
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-selinux-pokemem-v2-1-b46bc64916d8@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787683163; l=2508;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=cMZpfmy5y60iCBgOY8zKfRDT8aXfoJ3FsT1GEaT5qgg=;
 b=etcdXt6YJPtLzJ6NsslFUvgTrScKbEiz++YkD+u7YgmV0etE8NJizSEaw4u8B+QgHDC0OYnkX
 3FNCYVeg1SkCai4r7vUI2wYlcZQZ8x+LEATW601w5uzuzrhWwsKDhRj
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Refactor the handlers for proc_mem_operations to use the new struct
mem_private as ->private_data, rather than directly storing an mm_struct*
in ->private_data.

This is in preparation for adding more state in mem_private in the next
commit.

Reviewed-by: Jan Kara <jack@suse.cz>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/proc/base.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 780f81259052..bec6197329dc 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -848,11 +848,24 @@ static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
 	return 0;
 }
 
+/* private_data for proc_mem_operations */
+struct mem_private {
+	struct mm_struct *mm;
+};
+
 static int mem_open(struct inode *inode, struct file *file)
 {
+	struct mem_private *priv __free(kfree) = kmalloc_obj(struct mem_private);
+
+	if (!priv)
+		return -ENOMEM;
 	if (WARN_ON_ONCE(!(file->f_op->fop_flags & FOP_UNSIGNED_OFFSET)))
 		return -EINVAL;
-	return __mem_open(inode, file, PTRACE_MODE_ATTACH);
+	priv->mm = proc_mem_open(inode, PTRACE_MODE_ATTACH);
+	if (IS_ERR_OR_NULL(priv->mm))
+		return priv->mm ? PTR_ERR(priv->mm) : -ESRCH;
+	file->private_data = no_free_ptr(priv);
+	return 0;
 }
 
 static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
@@ -880,7 +893,8 @@ static bool proc_mem_foll_force(struct file *file, struct mm_struct *mm)
 static ssize_t mem_rw(struct file *file, char __user *buf,
 			size_t count, loff_t *ppos, int write)
 {
-	struct mm_struct *mm = file->private_data;
+	struct mem_private *priv = file->private_data;
+	struct mm_struct *mm = priv->mm;
 	unsigned long addr = *ppos;
 	ssize_t copied;
 	char *page;
@@ -970,12 +984,21 @@ static int mem_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int mem_release_with_private(struct inode *inode, struct file *file)
+{
+	struct mem_private *priv = file->private_data;
+
+	mmdrop(priv->mm);
+	kfree(priv);
+	return 0;
+}
+
 static const struct file_operations proc_mem_operations = {
 	.llseek		= mem_lseek,
 	.read		= mem_read,
 	.write		= mem_write,
 	.open		= mem_open,
-	.release	= mem_release,
+	.release	= mem_release_with_private,
 	.fop_flags	= FOP_UNSIGNED_OFFSET,
 };
 

-- 
2.55.0.860.g4b6b3295ed-goog

