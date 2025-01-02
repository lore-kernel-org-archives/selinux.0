Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D1C47A73
	for <selinux@vger.kernel.org>; Thu,  2 Jan 2025 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735836364; cv=none; b=Ll8u2MNMRZFxcOdJ9XWmsPczCzrj1cZYpH4n5B+jXMi66ds2BnQKZpHrL1p8PsBJTi6wGeV25S/tgh9XbnPvgkc2P37VUYiqZij0D2ZD8AB0VHBcUqlbRWR7Yjx03TJlfu059xluAWfV5ASpIMmOA9mgI04icSxPoq8HcldjQzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735836364; c=relaxed/simple;
	bh=EpnnaoVModCzAaWDiGLOVWI2IPG6d6UBsE47xuT++TQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dC2SMledUgAdjw6gxTjtAL5Xn7fGXC+mjTeyRPhKbrgMxwbDEiu66tT6BNR3NDflwpOGxcfRBpvD5vGESPFJ9ONKc+1gwb55fIHR3xoNP3D7GdVx+INNwGGLswcEOkGyyXNYrNAdp4EQS/wawoX82kVNCwzNOLUWMnslkA0Qgxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O0jEoC5z; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0jEoC5z"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4679d366adeso98454241cf.1
        for <selinux@vger.kernel.org>; Thu, 02 Jan 2025 08:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735836359; x=1736441159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQih05fUzP5zUKira43vzXXqq2ld3PdlBX2mcXzV8mU=;
        b=O0jEoC5zcljZgfzH2MXwsRepzjQt5KANyLLA2I+SJ9JMs9h3pxCKGTfbxZYqp+SNR3
         mGBvAfQnSU0vv2LU9CYrxLMAmaqcD+aU3su7YmCDm24xWZAtY6syGgCN8BRl6CLqkJla
         CHyfF8u1Cb7YGqOzJ778/NMizrLHK5vj+otwCJ1MZNmzw5n+TrKGmsvBzTOiLqexOxZv
         FfVOUBPaOhCNDk4q6LmDbmupopMVV3cuqgFgEtVO88Y24dQbq0pLx/Lk9TOM1Gdfluwr
         EWO+2u2zziEW6utCnNJ2rEfvaTN9rhiq9qpnEuWPpdLZDy/HijodKLSQcNvu5H3mAC1v
         h+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735836359; x=1736441159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YQih05fUzP5zUKira43vzXXqq2ld3PdlBX2mcXzV8mU=;
        b=YINCrbenYM0FaneSceR7c1w2SNgSwdXxaDqPzRnwXpuHMpBCBkTULVjNr7EBY2a6E7
         c97T2BCbnzGZy2w1i3rXvMPcD7XoUSngngb+Z71Mt8LXoz5Y/wxGKg/KKcysTaLATtkX
         ejuWtA2z7SorGoFnoh9qwWBvSsCl22s9KlqNGaf1scVPl7oGlAzKOwNJhDjRqpsoNNON
         Z5QcJCPe7f2YVOD41+VqRGlN1vXn0FQARPgtAhmwgK/UwOWNaDByAJ9Y9cNy15qUi+4V
         CP3PeIYZH/YRqRdaB/6e+SBYC7Xj5Lq4T1xOGDR9VoRmdA2TRMGYK3oaEVjPItdHcEm6
         WQCw==
X-Gm-Message-State: AOJu0Yw4ooA/lfoiWGqHGe8j4lgyZywgb5OTzPfDlTQ4pYCyRYaWw4CL
	oFozWiRZT8CJ0KoMil5f9BLNK9Yg42McKioVAqws9kouqlPykyldxOFGBA==
X-Gm-Gg: ASbGnctOHwAjxR4BfDWOiymq1Tcj3H9EY56HV2Ldzhkl/9iHZ0LjSvrCUlwgVzsYuqU
	7K1Leo6PHm09YNkTZ+dIBz8tTE8KmbGvt4qynIR33BbIHqE/IvYDN7e+m5lV9CRs0uGBqN7koqj
	DOszWpFguDbZ+aWB0Dp0wCy0awL/vP9YvhkB90nWrf8QUKnb+knwo5QQL22LDVQColhKQVmG6qb
	dJn0x2b1YrigXDtK4UGzQsj/BL8AwUcjZufWA5+EHDvYK3cZGkTvwSk8z01Vii+jislBTrzsnWs
	1e9OX0NMDC6tdwXTrb4EObkKXRmqUNF3v8VjaJGuE5IhZv5SIBOIITMHr9pdQYXdn1LHFA==
X-Google-Smtp-Source: AGHT+IG5YC2DnkGPzayjpAS7OPfh3tzRO5VgteA09MG4gyXdaFXV47yMRGNaiKhRbDwo0Hi5y8nrVA==
X-Received: by 2002:ac8:5755:0:b0:467:6b6b:fc1 with SMTP id d75a77b69052e-46a4b143bf5mr768723991cf.16.1735836359522;
        Thu, 02 Jan 2025 08:45:59 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46a3eb19684sm136795101cf.58.2025.01.02.08.45.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2025 08:45:59 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 36/44] selinux: set initial SID context for init to "kernel" in global SID table
Date: Thu,  2 Jan 2025 11:45:01 -0500
Message-Id: <20250102164509.25606-37-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
References: <20250102164509.25606-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Userspace treats any non-null value other than "kernel" as an
indicator that SELinux policy has already been loaded, so
the global SID table needs to transparently remap the init
initial SID to "kernel" just like the security server does.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 security/selinux/global_sidtab.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/security/selinux/global_sidtab.c b/security/selinux/global_sidtab.c
index 983b406389cb..50c3d58a11ed 100644
--- a/security/selinux/global_sidtab.c
+++ b/security/selinux/global_sidtab.c
@@ -21,6 +21,15 @@ int global_sidtab_init(void)
 
 		if (!str)
 			continue;
+		/*
+		 * Before the policy is loaded, translate
+		 * SECINITSID_INIT to "kernel", because systemd and
+		 * libselinux < 2.6 take a getcon_raw() result that is
+		 * both non-null and not "kernel" to mean that a policy
+		 * is already loaded.
+		 */
+		if (sid == SECINITSID_INIT)
+			str = "kernel";
 		ctx.str = (char *)str;
 		ctx.len = strlen(str)+1;
 		rc = sidtab_set_initial(&global_sidtab, sid, &ctx);
-- 
2.47.1

