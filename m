Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC1C3F4128
	for <selinux@vger.kernel.org>; Mon,  7 Sep 2026 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788814836; cv=none; b=D+UTlKQ2qkH8yfnU0CMjT5Y2uAPQd/tmuqymp+SVNWLVvgFC6r3p6B7Gs4NfTYClGSYNpZMM/QLffGoVcA0O/y44OxPXoXVuwAe3G1F/f/E5e1DWnHQlFpI7JQQMBvTj51hoQqBsJFgP1+e6y98iBPOkNBZMlGX0iheV5kGLnYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788814836; c=relaxed/simple;
	bh=ADyoAPi4kZgirNh4gOcfqdLiEnc1vIBxWHYLFCTisIA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=styEkAzhixbhGUG9vhQRpp4HQTvikJssaZPt22+dvCceF4MPRxQQEfhe54NTmJ8l+D2QYtc3z7Y/6MW2lzASuHZK8FphYTss85JyluB6NOEIqFOx5k6LTvhTIZkYoxqm63ETXkzCG2P5kW5Xl7brj17QEGUzXB13nOqG40yiCCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vmm7PLg9; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vmm7PLg9"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cda5e048fso87425e9.0
        for <selinux@vger.kernel.org>; Mon, 07 Sep 2026 14:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788814833; x=1789419633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XRnXHx6VgGnMv74R9wDnVfN6U71gdwk07y3Ib4uyqeg=;
        b=vmm7PLg9zMZuqTP86vpaKW6P+d0KOrG07Ym2I/EFwNeEx6cmWhpIqheJGG1uxNKT9V
         8OqTdL9GDiHvG93iNOyVDYR53TlsXhh6DxWtk1HCgYsSct0lM3bbi6nQhwOHhmgLvd8e
         3/NmU+eXYX1I9q18R6GgOB6zRkAcLHsZsC4zQq9YrxpH7mQ3SjiEi9glURRjhIVVcGak
         jg5fc+BCDEFsRYVLZYtL9e1dD695AUqccP+OQdCDVdfsnfxXo+kdq237mCiq388LmEDR
         rBDhVoZRBmaE7SNK335rs1tKEHwZHNsg3stLPFUVsoi9A8TOQDXg/p33vCxcXiOZERCY
         wCmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788814833; x=1789419633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XRnXHx6VgGnMv74R9wDnVfN6U71gdwk07y3Ib4uyqeg=;
        b=ALyuEj4VCl/RXaZtYBIh6wFuHOFkDJIq/8L1zCP78Piv8QMDHI9hpztqCKpkYGizoi
         s/Ur2d8cE7tXYPrKG+/8rW7h6zM+nSoHzmJxzKCjbUAwXgnvkASqtnbJc5SYN0kzn7wj
         44ylVTsQwn6mGcHNpUMfyerwT8hgAzJx7Sl8a2iTwXzCBnkcTKJnuxxBsrueI71G1pda
         OPeP7c041eehDyDVbN+ge6YTkmaV3a8o/MHDDhV/lc8oA4j5tYM3+zS+CXUYRMU4hpOe
         BWnGUBxLaHP2uZEZifvGxwKDCJZdWfdu5r7R8MptDUWfYkldrNkzo6+ZHSwCrBXonh71
         dsbQ==
X-Forwarded-Encrypted: i=1; AKwUvBxO/rWLjUPq44z9NpJjnZG09FIOR5PLy9dA6QlVz4n8Lgo7L/wmfyapR1Ghr7HoLEObUPJyKTJK@vger.kernel.org
X-Gm-Message-State: AFuF++mVE+q6BtWck47rB0yu3G/Plm041o6CZoftjzmispDka7nmBbcO
	BBSrrPYMaTpO0RGaNIQMoYEKxvPiraj/0N32iUQdJGpcxv4jfIcbfTgrlPu6P+zMwQ==
X-Gm-Gg: AYBFou1tHap9SbGFYJDqDXipGQatZMcYh5vYTjVhs/mH3LZkO83ms8C7756crwEZ1xX
	FfIOg4FWNC/N3jlolQJvcDtGMBfvmrqk0JRxYrXpodDLLRhB3KiPNeRbgGvce2o/ncLoA0Qduua
	aitOHpZxhHWrZKNuNcip8J52BWm2nqbZXjEgSfOnwIE5I2a0TMImYwUYSvyliawodJ0MMh9b1Jc
	809LXQdyaUwLURECnF49j5YPa3ilUHd6n4YcfbZ4daIq8W84kZnSdLMRRyClAtcQvju3xhQxecq
	9QbRHsYXa7f7EouvbNjLjamtDGp7WGARRHBv92wisnPqLJR0EBKXUMSIpdehT4RwgyqxmUwgNa7
	L++ClpG0K4vrCiVmbT5l3WRaB/owN1zyMEhkha1qZ5my8yeJOn7kBOkR/1ikrXBUyPqTxibY+2M
	aV3nXlqgi10zkBhgtH9E+QObGRDbf6mGB8EKiqS7/DNKuEwS32SMMje6n7gK+ClzDOziZHIga34
	GE+x5hjuZUtZhbxyRLcMwJmWrlNd3fqGh7aiesoqBYbds3i
X-Received: by 2002:a05:600d:8495:10b0:48a:623c:8859 with SMTP id 5b1f17b1804b1-49d01dd5cbbmr1672455e9.7.1788814832694;
        Mon, 07 Sep 2026 14:00:32 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:437c:9ac6:4a41:e58b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce831af89sm296356215e9.1.2026.09.07.14.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:00:30 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Mon, 07 Sep 2026 23:00:18 +0200
Subject: [PATCH v3 3/3] selinux: require PROCESS__PTRACE for FOLL_FORCE
 introspection
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-selinux-pokemem-v3-3-0bafbaeafe50@google.com>
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
In-Reply-To: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788814820; l=2962;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=ADyoAPi4kZgirNh4gOcfqdLiEnc1vIBxWHYLFCTisIA=;
 b=/+BkX6CIIRykdm9LzWh7SeoNJjuZpofKO51F7SP8VrCx38snRk5/Dg7OkyREfcDhgHAdymDNB
 IscJXoiNDc1BcIlIo+7EG1udczgI6vImnw5htcwkQTKyUUdVlbw2zSG
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a process can
only create anonymous executable memory via /proc/self/mem if it has
PROCESS__PTRACE (like when using /proc/$pid/mem of another process).

This closes a hole in code integrity enforcement that Project Zero has used
in a remote Android exploit chain:
It was possible to use a memory corruption bug in a service without
EXECMEM/EXECMOD/PTRACE permission to overwrite executable code via
/proc/self/mem, which made it possible to load and run shellcode containing
a kernel exploit.

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
 security/selinux/hooks.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 18dd28b2bb13..45ead18c8f01 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2157,6 +2157,36 @@ static int selinux_ptrace_traceme(struct task_struct *parent)
 			    SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
 }
 
+/**
+ * selinux_mem_foll_force() - Determine whether /proc/$pid/mem can use FOLL_FORCE
+ * @subject: credentials using which /proc/$pid/mem was opened
+ * @opened_by_owner: whether checks on open() were bypassed because the opener
+ *                   has the same MM as the target
+ *
+ * Decide whether it should be possible to read non-readable VMAs and write
+ * non-writable VMAs via /proc/self/mem.
+ * The @opened_by_owner case only applies to systems configured with
+ * PROC_MEM_FORCE_ALWAYS, and only happens on accesses that are not visible to
+ * selinux_ptrace_access_check() because of the introspection exceptions in
+ * may_access_mm() and __ptrace_may_access().
+ *
+ * This allows a process to overwrite read-only code in its own address space.
+ *
+ * Creating an audit record on denial doesn't make sense here, since we can't
+ * tell whether FOLL_FORCE matters for the accessed VMAs.
+ */
+static int selinux_mem_foll_force(const struct cred *subject, bool opened_by_owner)
+{
+	struct av_decision avd;
+	u32 sid;
+
+	if (!opened_by_owner)
+		return 0;
+	sid = cred_sid(subject);
+
+	return avc_has_perm_noaudit(sid, sid, SECCLASS_PROCESS, PROCESS__PTRACE, 0, &avd);
+}
+
 static int selinux_capget(const struct task_struct *target, kernel_cap_t *effective,
 			  kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
@@ -7558,6 +7588,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
+	LSM_HOOK_INIT(mem_foll_force, selinux_mem_foll_force),
 	LSM_HOOK_INIT(capget, selinux_capget),
 	LSM_HOOK_INIT(capset, selinux_capset),
 	LSM_HOOK_INIT(capable, selinux_capable),

-- 
2.55.0.1003.g10538fe699-goog

