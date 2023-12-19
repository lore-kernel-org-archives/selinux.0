Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED1D1D125
	for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GKZ/aG4B"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-553338313a0so3422973a12.2
        for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 08:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1703002212; x=1703607012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jayhy+5twOAsvydafjKvRy2sAVMLExMRwrz2kuGOIis=;
        b=GKZ/aG4BCzJuk0RSseusGu9NuJYqmtEsAoRVkLF6SRs+WDf6ML9s8nOoXC2cCXmRK9
         Jzh9x8zeCDmnLeJh/+4zzP3G2FSDdSFA04IEzc4deXIunaram5TzJjIiy5ztj+QNz9iF
         nW5puNaT/5mDP5xd99tzBFL5j8URX4hp9mLftMiuqxwOBO+SBjqC4oboEc+LB7iamlR+
         v5PItlC612VzXI2Yjh9yudnaw2n3Uo4FueUbpOZ1Xdos/kb4tArE04UyYvejmFjyiolH
         gDe3T67Q7aXbOauI1o5ynuG4LKlrjCZEu61ga5To66Dz1KTVXB9+iOCyZnXQjZHNjWmm
         G5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703002212; x=1703607012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jayhy+5twOAsvydafjKvRy2sAVMLExMRwrz2kuGOIis=;
        b=w7oowb6bMQOkf5sa6J6vadVeH/nsMJIeQ5W4HnyWbYwT2sxWQR8NDu0kPZ16pHcBwa
         eyLIS4bh82OcQL1tjpsElC0p7pDw28I+GpHDXOCFpzqU5DzKpawL1TcIBxhb9RV0BqoM
         mbwC8TSnvR9aQMflJr2R2TT//LPS0LrP6rqpa3ENSMayKiDdV3eA1C//w3Gj+ZN8JCxc
         /G3kWSzORCvxpgr6CrYpIJ0J6YqB36EqvEgUv1nsiHGiZPwZ4CsaQqmSeKc0CSjHlqTf
         /CbriXzwU278ZYO0UT7Tn8gYLQ9qNltkoEhS6AtQHA1VHGeOk7XkXD8FczQOZj0cS2Np
         +q+w==
X-Gm-Message-State: AOJu0Yzi+Ey4ur4CXjzboSusA0nDJPNZA/aLVULrqZNWPtnjsd5TIzWp
	83Cp8Rj6C9RQWj3ZiaJRIyInvLk5F5A=
X-Google-Smtp-Source: AGHT+IHzJ+1w/wWABDyDuFBG8USz8MIzPOBRDq7pnOoAKBpIPwDEYEIS6jg2QTm5Wu87UFR00n0a1w==
X-Received: by 2002:a17:906:c41:b0:a26:8622:a2f7 with SMTP id t1-20020a1709060c4100b00a268622a2f7mr400495ejf.141.1703002212089;
        Tue, 19 Dec 2023 08:10:12 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-010-185-155.77.10.pool.telefonica.de. [77.10.185.155])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906489300b00a236378a43fsm1936621ejq.62.2023.12.19.08.10.11
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:10:11 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 02/11] libselinux/man: sync selinux_check_securetty_context(3)
Date: Tue, 19 Dec 2023 17:09:24 +0100
Message-ID: <20231219160943.334370-2-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231219160943.334370-1-cgzones@googlemail.com>
References: <20231219160943.334370-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the missing const qualifier.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man3/selinux_check_securetty_context.3 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/man/man3/selinux_check_securetty_context.3 b/libselinux/man/man3/selinux_check_securetty_context.3
index 429023bb..7b64cc5e 100644
--- a/libselinux/man/man3/selinux_check_securetty_context.3
+++ b/libselinux/man/man3/selinux_check_securetty_context.3
@@ -5,12 +5,12 @@ selinux_check_securetty_context \- check whether a SELinux tty security context
 .SH "SYNOPSIS"
 .B #include <selinux/selinux.h>
 .sp
-.BI "int selinux_check_securetty_context(char *" tty_context );
+.BI "int selinux_check_securetty_context(const char *" tty_context );
 .
 .SH "DESCRIPTION"
 .BR selinux_check_securetty_context ()
 returns 0 if tty_context is a securetty context,
-returns < 0 otherwise. 
+returns < 0 otherwise.
 .
 .SH "SEE ALSO"
 .BR selinux "(8)"
-- 
2.43.0

