Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75247379C26
	for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 19:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787082708; cv=none; b=eHCYyLaPvDLlcN1Jk14J7fe806JsBSMBfQTOUZhpmYy7OaakDFdv0EmQDXezJ8GLmEp68QkLeDMitm5zCB1h7kdNG0yd4Yqh7PV7vxx6P3V+9cXSbh4cao3GjZEDlV0dcmght8CURpDSIT+ajFq5Aymsf8P2BnnyAtRdhKmZcRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787082708; c=relaxed/simple;
	bh=zSdAoshV6PguyX7bw95N4A7c09eJSx5mBc5Ua6Jl6bA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k/Bv20FpZ86dQvBRC/Mnze8ZSXKkV2IFMyvWEfacGVef0HDyn2nXMUyPE62AKSUuQxOqbbZRnw6kK7ujG/hwk9V1OGBPkiT+29pVq+wA0Miz1VdAtgSQJ0hiMxUlNkobOVFQGWcPJJth9As72BAif2vb//2V+R5F0OYlANIfE8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c++GlGGB; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c++GlGGB"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4996e2575dbso2995e9.0
        for <selinux@vger.kernel.org>; Tue, 18 Aug 2026 12:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787082704; x=1787687504; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cgP6lQOibHlCVKVmBeaw+pleu+P2xINjgIC2sMiWwBc=;
        b=c++GlGGBK+doUn7LFPs21SC8bvcP6KRoJGN2RmCuselaI/4uem8v86Hssk6aPdBOij
         F0aF7gdKV/eMRO/2Vd7+i6MdcSGx6UhQ65wtM+LAm27ND1nLM8b0kpfL3Lb3G2AhXoEW
         OkHR4kclpgOgHY2aSjXs2v37jW5/RIf6iqtqc8Aki8KQ1eUv/pU6C/XcBthEC9MFC8JD
         Zdh5ErUBsMkOG3AEB/tuIYRtW65xt20j4XeLrXcApFmTGvOf6tOJlZWQM6Tmeh4CdVdU
         0vK6gqjmYhmHsXleXDlKE9ju+wDRajBwjT1xfrU41KqN1U5JhhaWgcbghv9KvR3f4D+R
         Lpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787082704; x=1787687504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cgP6lQOibHlCVKVmBeaw+pleu+P2xINjgIC2sMiWwBc=;
        b=onVEJt7A5kgYO3addRJESfA5coHDDiIIzAqpS3b4kyw6naDv0DoI/YfMmrxzro+v3y
         +bU5caZJF/5yYShWRSQvSnbBKhMAmOM2oW/bZeEch5GfE/qdwAR5St6UjRkiq0qn3Mga
         2IAeCKFTnnok8wv9Tl19VRRxdGOhSlL+3L9ms5+/dKQgfEYoZL4O3aW8tXhIsjJpUZyk
         u9dUy3/bm8QBRrX+kiN6miHTTFO98EcOHitcL72+kMUuFt/RGNtPf9ozV9UdEUdLz+QA
         bqjQl5Kq986AXroilpY5sINA092e6B4iGjzfjl7E1WiphE+tQAKOwL8tqPwNWXkA60Ab
         Z0Wg==
X-Forwarded-Encrypted: i=1; AHgh+RqtI2vQMm7t23ShhbJKCfLhW7AaIIeNrGPbrarLJyh8tg5LNKMsh9iYnHc7Jc+TT8eXfN91yvSR@vger.kernel.org
X-Gm-Message-State: AOJu0YwhDj0/BUPnvYWUa25baLRLXnnMRmx7TcwJQS/S0FxUBWADV6CO
	/nHtIZxFqR3LSWTv3+wP3gNxFRv51scBGPIz0JUDhREU34adjEdeXCyhseNxDM7vAD6KUPb5d1o
	OGx5jBohw
X-Gm-Gg: AR+sD13XVCDlkxwLiYqfY1ik/N5PyfN53ycidyuOTJMmgBtGUtA2eWcM9qB1A2ViwA8
	2nexkaidDYdJDrjSkB6w6OT9m3fmTbGKns0bANpD7XRMxGQlFV9H4JIxfXYCNm5ibbd+X3l31Y/
	mgphgpr8vTPYvNCrjax3ymv8vKo5i9DIiCnHiay9geIy7oI5sUTcV5aJVAQJH9W9nK2XSxTauyq
	RfZ3yJkC6qRHQOODeLMGBWRgU/PsHkeECT81tR6YFvrXSDdvrzygGgDcw29GcZJpud/5YZFYiCL
	uK+FqLsrEGUhI4gVsgZYiSF/PDfCbrIizojdCb3KCn1QDep+SKA3YqzbJIbEaqYYRgdvuZivnMl
	H93RN+ibXe6H+l2UfhY3XH0U216TWfg+TfSAH2aepGAeo3ZjQL/Ed5lXR2hjVWxGCmVUp8lmbOs
	cHykOEdweTiFohgkgDyHC9/snJJ1ubd3SvnmSzCYWQR2ZjXKecBpD9Jz8HuQE4ZILa4soYW9Gkr
	ajrm5qEJTeKRWMQpy4XGu6tHFUp1FrrujcQSj/U/BnT9Gfj
X-Received: by 2002:a05:600c:8905:b0:493:b169:784d with SMTP id 5b1f17b1804b1-499a98b8974mr38235e9.8.1787082704117;
        Tue, 18 Aug 2026 12:51:44 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:f466:5a15:1301:318d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b77f41sm13393110f8f.27.2026.08.18.12.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 12:51:43 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 18 Aug 2026 21:51:07 +0200
Subject: [PATCH 3/3] selinux: require EXECMEM or PTRACE for FOLL_FORCE
 introspection
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-selinux-pokemem-v1-3-90cd2357ee05@google.com>
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
In-Reply-To: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787082694; l=2735;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=zSdAoshV6PguyX7bw95N4A7c09eJSx5mBc5Ua6Jl6bA=;
 b=Lyhniy9H5W1G2wuKZtV9Z+ZJwr+oTZ4Wxkivk0swGQT5TVkCUpGEnUh4di50Ud5ofYDrM8FV3
 hG088NQOnE8BjBxCnVn9kU0SPcGSVr57AdYgL4wVzDxIO+bERsoFvU6
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a process can
only create anonymous executable memory via /proc/self/mem if it has one
of:

 - EXECMEM (like for other methods of creating anonymous executable pages)
 - PTRACE (like when using /proc/$pid/mem of another process)

This closes a hole in EXECMEM enforcement that Project Zero has used in a
remote Android exploit chain:
It was possible to use a memory corruption bug in a service without EXECMEM
permission to overwrite executable code via /proc/self/mem, which made it
possible to load and run shellcode with a kernel exploit.

Signed-off-by: Jann Horn <jannh@google.com>
---
 security/selinux/hooks.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 18dd28b2bb13..905137c47321 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2157,6 +2157,32 @@ static int selinux_ptrace_traceme(struct task_struct *parent)
 			    SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
 }
 
+/*
+ * Decide whether it should be possible to read non-readable VMAs and write
+ * non-writable VMAs via /proc/self/mem.
+ * This only applies to systems configured with PROC_MEM_FORCE_ALWAYS, and only
+ * triggers on accesses that are not visible to selinux_ptrace_access_check().
+ *
+ * This allows a process to overwrite read-only code in its own address space.
+ *
+ * Creating an audit record on denial doesn't make sense here, since we can't
+ * tell whether FOLL_FORCE matters for the accessed VMAs.
+ */
+static int selinux_introspect_mem_foll_force(const struct cred *subject)
+{
+	struct av_decision avd;
+	int rc;
+	u32 sid = cred_sid(subject);
+
+	/* Allow if the process is generally allowed to have executable anonymous memory. */
+	rc = avc_has_perm_noaudit(sid, sid, SECCLASS_PROCESS, PROCESS__EXECMEM, 0, &avd);
+
+	/* Also allow if selinux_ptrace_access_check() would allow it. */
+	if (rc)
+		rc = avc_has_perm_noaudit(sid, sid, SECCLASS_PROCESS, PROCESS__PTRACE, 0, &avd);
+	return rc;
+}
+
 static int selinux_capget(const struct task_struct *target, kernel_cap_t *effective,
 			  kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
@@ -7558,6 +7584,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
+	LSM_HOOK_INIT(introspect_mem_foll_force, selinux_introspect_mem_foll_force),
 	LSM_HOOK_INIT(capget, selinux_capget),
 	LSM_HOOK_INIT(capset, selinux_capset),
 	LSM_HOOK_INIT(capable, selinux_capable),

-- 
2.55.0.737.g08866a6d13-goog

