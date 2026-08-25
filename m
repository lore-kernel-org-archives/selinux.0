Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6401E37C909
	for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 18:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787683178; cv=none; b=hv1wpqTsh4Y8Udi+d6CzUw3qIpvupPNymm/jAWRImHGPQyszJ6YytSCEdropCNtN2OO7yOJXNt23pocJoHGZEbjVx+gskxUu0WIhPBUltl9gKAoupjx74UoxLDG9rNLaeRSRR5PSe2CPXUVpEH5exlDA5vx7CxQOZ0s1FJM2w7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787683178; c=relaxed/simple;
	bh=Ns+udTpi8SWKloYkKMw8Din2oarGSCfqpMuFm48xRLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=StBtfGyynib5nvLraBihISeGM4mKs43Qx+ruXSE/fMnlnyY+nJC1XC9DlaVZ8swGSrs3ZBT/VOzdYfUorlNJkhIBY36NLYoVhECz5WolFO5sNKhY+ln9szC+p7VvtVsKXkTdm/+YU22N22Fsz+ttL0wM7e1L/qUIWf86PN55itQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FIny9rHC; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FIny9rHC"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a17c7c3c6eso1741a12.1
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2026 11:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787683175; x=1788287975; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RPvPgg8WrBS502z3EqfWF3DM7etFQasO/Hjw3jKjTbY=;
        b=FIny9rHCeTlRYb6dB/mMb0NboZ3DLg3scK8a+v7Rcfl+NY1ePYlW1uEqPbBNzc/XMZ
         W0JSO8Y9/MZ132kcuz0zr98QgSR295AU3jXrz0TJsshFdpx2j2K/Ht246ttPwpQzksRZ
         7KghSep0qNAxzRCJxpxSag7Dm8mPhNsY+yK3G6GDANRlNFUWhHoFxLujrQQ4nX222SP2
         q6G2aYlrxCuFaA8l8VvtpXbt4Gcenq4FBIN33yFhCY57UnlS/psHhke+HgjMB/iF2og0
         r0scXN6bA5mWRjkBIs5LjfD6PfvUoSc8LMzCPj7HHGbXxIIqExWo5FyDlBDbz/yOyCEX
         NjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787683175; x=1788287975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RPvPgg8WrBS502z3EqfWF3DM7etFQasO/Hjw3jKjTbY=;
        b=mN4p9LMq9lMN3u/J5Xu7C12yC+I1LJrNQXvX9cYZT7+dt1MUmw6tTclgQT4ATzgT8p
         duICNTbiT+EhIbJrNk6Oj6d6wx8IAKrMp6cHhEjvq84Ve9O9CVFyHLyJ5HkpHDjp4Bcz
         9Vw4lpp0OrAqCXhoiStdwwYGuzzF/OLLbmynEwqrLXLlRelmOkPgRBUWArPKtLpgAEPm
         kgeb59sWc5MgqmElAtAKliJGdTzhatZncWcLcTj99FwERoZ4rEsftS/MQ9zF5W/xuDv5
         /RWKHqY41ff4nXtdfhgGAXxLeLH600wqm21beeZsLmu3gPFtAUMnPZ1LKUFSA5Wf9yGt
         4JMg==
X-Forwarded-Encrypted: i=1; AHgh+RqKCNC2XdIzhQG9JZ+AHjcbV5RJ6AYN57iOJ7nuEm8x+e3EX7ptcsqHSGHNgZ5HlOAmpHNquPCQ@vger.kernel.org
X-Gm-Message-State: AFuF++nI5aA7JK5Gupyn7Rp+ufbqEm289WNUuVHZUng9G6jlA4IQ5Y4p
	Mpqmo4d7wDKlk3jWMje5voHcYDDs2dkqHhuEcdEfMugfGGButLbe5cSAySoVeoPJ7w==
X-Gm-Gg: AR+sD10ngFC5Ihp5i6dPfBw8Oj4WHpwAExIyyFoZjerH8EAncpGObt+iMoaT3AGCo2W
	0/JLmkKoEhPRCteE8xSk/gV4n6dKBVg0zBhStklFr7fP/U3YozUieOioUGBaGLf1m6AZDpH06FS
	CQV/wiKcXKfVFD0ugiYbcrbkfvulf/6gEl/+L8M/2oIQc98CpvgqcdcdqDw429PzsvXG60Yf7+D
	IeblVr4I2pfxdSzr15sxBhsWZh8Y/nrgf48gqd9MuiP6xs6+gI4ycYHYF2UPM/9kX5zKfhAlf0s
	ZAHU35ZZrZ9jTxkV1J9EqsINSLO6yFZg44ND68weTtfoZmKmvxjo8N4SG4AOpyrKlsJ0LbEzTwZ
	pquiaZRiCsPJL2hYItWga+tKYZ4l0EU7XMTvw+RnRS9kv7Ou3u6u4RVG6kEjzvpmUS4ahkle/8U
	s1ANbLogb0RG4d5TNI5MeCuSVD8+rFZkCU6AZcUpNe8tBRYGZnfM/ybWtaRNMU38QDAKosmRAYM
	0QGTvnCiseKZc2/yba9gi0qhgFnXtOlkEHceomtWA8Nvsw=
X-Received: by 2002:a05:6402:2023:b0:67b:7d05:60b8 with SMTP id 4fb4d7f45d1cf-6a5c4a423a0mr72402a12.10.1787683174081;
        Tue, 25 Aug 2026 11:39:34 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:980a:b43:2df6:51f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a702c7asm82067566b.19.2026.08.25.11.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:39:33 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Aug 2026 20:39:19 +0200
Subject: [PATCH v2 3/3] selinux: require PROCESS__PTRACE for FOLL_FORCE
 introspection
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-selinux-pokemem-v2-3-b46bc64916d8@google.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787683164; l=2509;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=Ns+udTpi8SWKloYkKMw8Din2oarGSCfqpMuFm48xRLo=;
 b=zeD7wBrHYoqhVh6HblaO+73EuAz1CQeVXst7AZwlAE/ssLvvQw8Ia6UL9q7TkXPnVftUvkutA
 EZh2GLrwyjZCNMAdQM0EcaCQZx1Tr+oTA0Tv+2dWEkEGth/XbX8l9/W
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

Signed-off-by: Jann Horn <jannh@google.com>
---
 security/selinux/hooks.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 18dd28b2bb13..2c2c60e9e0fe 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2157,6 +2157,27 @@ static int selinux_ptrace_traceme(struct task_struct *parent)
 			    SECCLASS_PROCESS, PROCESS__PTRACE, NULL);
 }
 
+/*
+ * Decide whether it should be possible to read non-readable VMAs and write
+ * non-writable VMAs via /proc/self/mem.
+ * This only applies to systems configured with PROC_MEM_FORCE_ALWAYS, and only
+ * triggers on accesses that are not visible to selinux_ptrace_access_check()
+ * because of the introspection exceptions in may_access_mm() and
+ * __ptrace_may_access().
+ *
+ * This allows a process to overwrite read-only code in its own address space.
+ *
+ * Creating an audit record on denial doesn't make sense here, since we can't
+ * tell whether FOLL_FORCE matters for the accessed VMAs.
+ */
+static int selinux_mem_foll_force_opened_by_owner(const struct cred *subject)
+{
+	struct av_decision avd;
+	u32 sid = cred_sid(subject);
+
+	return avc_has_perm_noaudit(sid, sid, SECCLASS_PROCESS, PROCESS__PTRACE, 0, &avd);
+}
+
 static int selinux_capget(const struct task_struct *target, kernel_cap_t *effective,
 			  kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
@@ -7558,6 +7579,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(ptrace_access_check, selinux_ptrace_access_check),
 	LSM_HOOK_INIT(ptrace_traceme, selinux_ptrace_traceme),
+	LSM_HOOK_INIT(mem_foll_force_opened_by_owner, selinux_mem_foll_force_opened_by_owner),
 	LSM_HOOK_INIT(capget, selinux_capget),
 	LSM_HOOK_INIT(capset, selinux_capset),
 	LSM_HOOK_INIT(capable, selinux_capable),

-- 
2.55.0.860.g4b6b3295ed-goog

