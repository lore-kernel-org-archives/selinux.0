Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B0A1C5F23
	for <selinux@vger.kernel.org>; Tue,  7 Oct 2025 19:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759865308; cv=none; b=BzOpYjMlSIYb/Lc5pIJwGZJ/U5xrASWR9QpTTqsWfZF48DY970Rbiv9JCTX+6zKuYTQoSKh229/aGCtVdzmHJU0a9Qdc/YafR2JyO7bsW+3rHPSbbN3Z/xHhEuTRdy5FoOiYiatmtFu0fkVhRBTmNH5K6omp61xGLJId58ltI3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759865308; c=relaxed/simple;
	bh=WBii1+10XNoZHclsd7d2pcht+y9nyCnIk1WdTDjWo2g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kRcRkHnvIVD6IpUhG9hPnrTJEnBBz200if+q2NEOFob6fiZ00jKtycWJAbWzmQ4M3TwsHhM7YN6mAqha2G8XeNBOxA6M2AMzH3y3j2MDAxOFUanunSBfAjfFtYBIpPb6a2iXDw+MJrBvzkxaQt0SrSAEPRVef7xaAz4Z18tF1Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjcFOW0N; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjcFOW0N"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-42568669606so3620171f8f.2
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 12:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759865305; x=1760470105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ougQYGFn3tYStfsr03zsncqgARtaqsRa8cT/6k2kvbs=;
        b=YjcFOW0NlZJcVeE0ZQqnkV+FEi4N/OAggH8m0PPk5NDC1bQr70jfRKJ/SOL4BJPKRx
         KawUAB69JHKNWn0I7o4q7khlK+D03bIkLx3kjLc3g+1UetSZdMaGdpwYgbRznIJY2oNA
         yR8AOIxAoYZos14LuBYil/gUkO9OP+C4p1tKQ5y0eVBDYeVIeC1OvSdEUDq3OIvf3IPI
         wsDJ53Ec40OIfD6Deufz1lJMyQXSUcr4Rd0ziFyNGPBkD35tbXVbD3YSn004vRUai/Am
         nUeqRFevvg2niAY16UGCN/iA62+3XkmwFWmAJj/3dlaUAJBcTBBS60/E2St6ZKz8Y+rs
         vbkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759865305; x=1760470105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ougQYGFn3tYStfsr03zsncqgARtaqsRa8cT/6k2kvbs=;
        b=vJpiE7lol03NTqvTcmFY+x4YVZgXxzhzb2dgZ1h7CsxqH8o7dM4HQgJW7XSLDAsN31
         FN0rFJLIWcUVWywU0ANlnwSia2KHxTdREhjJ6MEXgjzNInwo6miOf995iE6WJ9uHoyZN
         2jZOP/DCrKXh/J3tj+IxRinlXzFHK1JX39Fe7qcsW4b8BsxqbgtjbGLqlY3+s/Ja3pgQ
         sPHP6LwebsRpgWi1RhUGSEcReihd0BGpRQav1aRwQBOF/bvsVfffK97YiMbBjuNVPvJQ
         Ai0gHMlWAf8N0Q+j16Pq0y6GEo/VlUxGdYzM+yniNuaKKZW/PBMeJLQojHUYvgeV0HLq
         pa8Q==
X-Gm-Message-State: AOJu0Yx1AsztVfRxwNSYXCig9wI8PRwUgZ4GLiuimGaq7C97SE+PgElQ
	WzA6DtOyWVgFduPNBbzUhyNZnZkTi3/5qLRSTWEdCEHxa41VtA74JbJKzHvX/6cG
X-Gm-Gg: ASbGnctybhh/PBWJWA4hYW5jPp+saGYhD0PgBKoE6WHxDTkgYtq6QCVg3QV5i8EKa7u
	GY7eDckq7znIWkQigBY+Eh0g+LYqZ+JJ5bdIyvoyQ10uRdU3e2fdHoMxibjig8MDNyLhXNeDolX
	CJllW2NFCFYwuceGpzFfDUA98VpjrnINDlyN3LK+kKU3pxEm6PyaE4rpfVL7sUBSxKX5De6Qk07
	1N0PouAeqOrDbaWVIKRY0DsTfIPyv4Urbi3xn05UjrTSUKZ8D3DdoT+EsVAOF+EKp45phRyL8J3
	Zsf35QDH+heK0u9INuTcfm2ssby5tlvPcHJTh0kyJThauaQ5o1WVhj2A7smxtJ58DiLN3Nwz8GD
	IKXDbjhBpssX1JhVc3SATuLgiT2/LLwiq
X-Google-Smtp-Source: AGHT+IHaLmxu7+vHY2IHL7bSs95V9SNyJZ9sSxZaU4WoKYahrcpGFIbSUzNW5vpTGEE7Q3kAtPbJ6g==
X-Received: by 2002:a05:6000:3106:b0:3ee:12a8:6f1c with SMTP id ffacd0b85a97d-4266e8de388mr305780f8f.46.1759865305037;
        Tue, 07 Oct 2025 12:28:25 -0700 (PDT)
Received: from sierra ([81.79.15.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f4cc3sm26580954f8f.55.2025.10.07.12.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 12:28:24 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@gmail.com>
Subject: [PATCH] default_contexts: introduce PAM stacks
Date: Tue,  7 Oct 2025 20:28:08 +0100
Message-ID: <20251007192808.514297-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows a default_contexts entry to only be matched for a given PAM
stack. This feature isn't implemented by us in this commit, though it
may be in the future should it prove useful for `pam_selinux`.

Signed-off-by: Rahul Sandhu <nvraxn@gmail.com>
---
 libselinux/man/man5/default_contexts.5 | 8 +++++++-
 libselinux/src/get_context_list.c      | 6 ++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/libselinux/man/man5/default_contexts.5 b/libselinux/man/man5/default_contexts.5
index f63d24a0..49ebbd25 100644
--- a/libselinux/man/man5/default_contexts.5
+++ b/libselinux/man/man5/default_contexts.5
@@ -35,7 +35,7 @@ Where \fI{SELINUXTYPE}\fR is the entry from the selinux configuration file \fIco
 .SH "FILE FORMAT"
 Each line in the default configuration file consists of the following:
 .RS
-.I login_process user_login_process [user_login_process] ...
+.I login_process user_login_process [user_login_process] ... <pam_stack>
 .RE
 .sp
 Where:
@@ -48,6 +48,10 @@ This consists of a \fIrole\fB:\fItype\fR[\fB:\fIrange\fR] entry that represents
 .RS
 This consists of one or more \fIrole\fB:\fItype\fR[\fB:\fIrange\fR] entries that represent the user login process context defined in the policy.
 .RE
+.I pam_stack
+.RS
+This consists of a name for a PAM stack required for a match.  All PAM stacks must be enclosed in quotes, else they will be treated as a \fIuser_login_process\fR.
+.RE
 .RE
 .
 .SH "EXAMPLE"
@@ -64,6 +68,8 @@ system_r:sshd_t:s0			 user_r:user_t:s0
 system_r:sulogin_t:s0		 sysadm_r:sysadm_t:s0
 .br
 system_r:xdm_t:s0			 user_r:user_t:s0
+.br
+system_r:xdm_t:s0			 user_r:user_t:s0 "login"
 .
 .SH "SEE ALSO"
 .ad l
diff --git a/libselinux/src/get_context_list.c b/libselinux/src/get_context_list.c
index 0f3bdc5c..8e9c5bc2 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -165,6 +165,12 @@ static int get_context_user(FILE * fp,
 		if (line[len - 1] == '\n')
 			line[len - 1] = 0;
 
+		/* This line requires a pam stack to be matched, which we don't handle. */
+		if (strchr(line, '"')) {
+			found = 0;
+			continue;
+		}
+
 		/* Skip leading whitespace. */
 		start = line;
 		while (*start && isspace((unsigned char)*start))
-- 
2.50.1

