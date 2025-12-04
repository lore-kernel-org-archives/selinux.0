Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC929325726
	for <selinux@vger.kernel.org>; Thu,  4 Dec 2025 12:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764853164; cv=none; b=uATwkyh6BqxKGSLDkPugK+vq9exys/+McUjHmkYwn4OxgoqxvIoMbDh0/Wzjm/yztLCewXq1s6UCfmBl8EfvqvRZ1JVi4JKyWuRndlTdHt0mulbAsb6xlmvt5oxI0OYlMPfldXJo0Gm8QDkrz/C0ti8rhOtZudGUOvQ52iBzwN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764853164; c=relaxed/simple;
	bh=hDClTYUke+S3lw1Dam2zNOlSPw5NHSqYQafCDHsN8xo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LK39qKPiuT0rx9Qu2JP1Nzmxe0YKu79skz+3jjz7iMwV+z3NdcCNkK+SYH8vKjLEL/9CF2AAQgUiaPQF/mimFlXNvZMqLfSSKQ+ftKUZV4EEbxWgYzYfvsyGiGZBoy7HNBTVVBC6ilPuzi34fAysqRV6wNY0uBDbym76Sn2gQYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C5ec6u5f; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=D8iPtYBp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5ec6u5f";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="D8iPtYBp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764853161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GheDSDHtTYd5XNDiQRKusO77ePE5TJS8yhyiwwPNBd8=;
	b=C5ec6u5ffCZwjoWtlUj4P1jZYoAc4qglBsJ9FjEy5gIpU5jf0Yspzv7gT8Qzm12yGfGBXL
	uHDVpmZcCILfsk5baIUIC3ABpQ1k3jIA2sRGczbAFGBQm9k/Md3aOaa/kqbTbVgA30S9r6
	fzr+SU2+IX2E4o1XOPfs1MiMHnDLseY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-S90NIsmxPNyFW0FKLulohQ-1; Thu, 04 Dec 2025 07:59:20 -0500
X-MC-Unique: S90NIsmxPNyFW0FKLulohQ-1
X-Mimecast-MFC-AGG-ID: S90NIsmxPNyFW0FKLulohQ_1764853159
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-64174630bf9so833653a12.1
        for <selinux@vger.kernel.org>; Thu, 04 Dec 2025 04:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764853159; x=1765457959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GheDSDHtTYd5XNDiQRKusO77ePE5TJS8yhyiwwPNBd8=;
        b=D8iPtYBpjNJULRB4s77sruEUD6TjR2CmpPwbfoKrXcUEI+GTSftnR8vCQSdQgYFlSi
         0oA+g4H/LNGHj+lmrEAt2VRPVJ5iNiKCyIwXrU4cquidBU9aPxasM1iMNlx5g8Kz9919
         oXiaQaUA5Z6gFubXx/1Kjom/j3MPAi9cCj4YDzqurNEMrV160fIesESfKvsIZlhTyM1c
         K7JXh//jBD+xXZD8AzlijbZ0xeqagbXzZYLw9Sq1tIm6Yga0Tde5bmts6H12WV9b7zyk
         7JHyqkmrT49SPZc7MRTaIuonFJbxVv3BEhFbwja4rsKwt66sleKpydWsDFfXQWTZTGpV
         Wraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764853159; x=1765457959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GheDSDHtTYd5XNDiQRKusO77ePE5TJS8yhyiwwPNBd8=;
        b=fpz6FkLLcR8NJ8TvrxVYUMlxe2tvAVr2r5LffodrW41Ix5GWBCLmQ0erVeC3XV7S89
         VCfkIcG+mhE+nEE4CIKsetvqYSrO7nGW2WT1mHKf7CUBVOdryQkrT07fdylO0hT014S3
         jJ+/AGjYkJSDSbLG0dnFaf33F5xsIxfPnzPH5yPjSZ/cByod0J7Za0O+Q12iRwhSZNqi
         Td53dDTkdf7WuIedRUiGMZo5VelNmWz9UyYMq7I38Zc4Bu83Jgxlim+Bu+zZ5SqYLOUv
         DoBCCSsOQ+nSu4h8fsYeZKlP5Z8dn5vmUBt1HZ/GDF0xveNE3NlpWv2RtaeScDzExlf0
         chhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfJ1yVgWqlDYYJH3RtNVfuRgM0K6XlG+54xLXBs9RAsmGpBwUW1L6zlkwgU6v8igD9Ky5QQSB8@vger.kernel.org
X-Gm-Message-State: AOJu0YwiwgYJl8t5/QZo2NGpNuXXPlAxj2YoP+hsNXBnElCyLY128f8I
	mjFTS6LtfR7CMaFpaeq47Hb0dOXvOFg+QSiZN9/XnOV99Cu1MLIGomBj5dJbMEzmffjtc95+vh/
	ySozQ5Lh0ZLKkqvpGRaZ2N2R1gyfxjq5VnFtgwHJgpXLoz0+gNQpUDxaJaxc=
X-Gm-Gg: ASbGnctCezo+OlXPExhyqn+npro+qgmcs4lT9OskGzgn4ouJiBRGgD9ASsFroGZ5+uF
	svxsi5yzGOSiPv7mp80MQIGS2hjH7h9dB1U7tpjoOjL5UR72hMv5Gy+t2Ya4AbsoBo1jRf6tYza
	wK75WvED6VDWPk2SzzgWIxXTnB9R3dvVtABSafh1S3dZUfvspJJsRFJr7XMTa+Sk+aWeKYlxmF5
	Wd/ncc2kvAtpsQV68ozGcXj12hseez4Bd+Jd1HSVCRTX8ydxZrgTvJJ/GsYCeZyLuk6/cQmtw0P
	wfrmG9eE+JBR7u0eNCcGBl5+MpUyX+EyAQ8cASLxSt3w5Yd0inefSn46mRbFlcs48qWezRmUvf5
	f2wupow==
X-Received: by 2002:a05:6402:274b:b0:640:b3c4:c22 with SMTP id 4fb4d7f45d1cf-647abdd3177mr2458531a12.18.1764853159309;
        Thu, 04 Dec 2025 04:59:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpIWeVg+u1yy1Z+F+69TkiJ/5ziYNykTKxahwDIMAG7zZcbakM3dgVe2ZnEUxhIOcGKQFi7Q==
X-Received: by 2002:a05:6402:274b:b0:640:b3c4:c22 with SMTP id 4fb4d7f45d1cf-647abdd3177mr2458514a12.18.1764853158907;
        Thu, 04 Dec 2025 04:59:18 -0800 (PST)
Received: from fedora ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b2ec319csm1251929a12.3.2025.12.04.04.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Dec 2025 04:59:18 -0800 (PST)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	"Serge E . Hallyn" <serge@hallyn.com>
Subject: [PATCH] bpf, arm64: Do not audit capability check in do_jit()
Date: Thu,  4 Dec 2025 13:59:16 +0100
Message-ID: <20251204125916.441021-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Analogically to the x86 commit 881a9c9cb785 ("bpf: Do not audit
capability check in do_jit()"), change the capable() call to
ns_capable_noaudit() in order to avoid spurious SELinux denials in audit
log.

The commit log from that commit applies here as well:
"""
The failure of this check only results in a security mitigation being
applied, slightly affecting performance of the compiled BPF program. It
doesn't result in a failed syscall, an thus auditing a failed LSM
permission check for it is unwanted. For example with SELinux, it causes
a denial to be reported for confined processes running as root, which
tends to be flagged as a problem to be fixed in the policy. Yet
dontauditing or allowing CAP_SYS_ADMIN to the domain may not be
desirable, as it would allow/silence also other checks - either going
against the principle of least privilege or making debugging potentially
harder.

Fix it by changing it from capable() to ns_capable_noaudit(), which
instructs the LSMs to not audit the resulting denials.
"""

Fixes: f300769ead03 ("arm64: bpf: Only mitigate cBPF programs loaded by unprivileged users")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 arch/arm64/net/bpf_jit_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index afd05b41ea9e6..5823f2df204d9 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1004,7 +1004,7 @@ static void __maybe_unused build_bhb_mitigation(struct jit_ctx *ctx)
 	    arm64_get_spectre_v2_state() == SPECTRE_VULNERABLE)
 		return;
 
-	if (capable(CAP_SYS_ADMIN))
+	if (ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN))
 		return;
 
 	if (supports_clearbhb(SCOPE_SYSTEM)) {
-- 
2.52.0

