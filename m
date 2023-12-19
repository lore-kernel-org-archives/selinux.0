Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5952C1D521
	for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZW8JmgQm"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50e44c1b35fso1174708e87.3
        for <selinux@vger.kernel.org>; Tue, 19 Dec 2023 08:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1703002211; x=1703607011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FXMJOKV6j1eEJfgN28NBo6G5tHjUrwwHFBXOWqGFtY4=;
        b=ZW8JmgQmqUUbt/9QJaCU+vQxok1K78aorXk35XjaA54QURQZTIdrD9zMKxaLjyjTgu
         ILeUxZDfn7jBEFaHiM9DOIU0S2Fn8w/Wh+jhYvXLPzZXPiE7xfguD9Xb0udFDEv6/J5G
         COQZi+8rlVjvTXek1pePh8MWBufZDYJNSCGMHPG7F/BIotVhxm3F7y4JpI6BBEPozrPd
         gx2b1w5yvw/pTXzhNMd+UJBEz7Kpl4JfP+cuVbzhZeJQZfnXoEOUkEEftf1BHAZHTobl
         T3UPCxAby+4YVbVTtpU4tgG3kpDGal+OLrr2Njl3EPt2L3fRECDwhCsrN6wtuPpNPIMp
         J9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703002211; x=1703607011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXMJOKV6j1eEJfgN28NBo6G5tHjUrwwHFBXOWqGFtY4=;
        b=iYG25Qv4L/CGKrjbYIwF8ZrhtGm0m54NMmyBTfeRACO7zSkG3cLatIdoWH3kqkdgVc
         cak9oH9paIULBKcNJcNkQNyn1yFT2OF7r5Lqua4Ma/QhvWj8zERhArXUyaXIHOCFMh4q
         ILSj7Qd5e8oa4fgRz/s8qey4hQeVpsag/vgDINM3yyv51nrwsd9lG+geTrlmJ1ydS2FN
         F7S70waUieO2q2t11MC12VP676Xo+fwMQdi6g6iQSuW4ka20wBfS2EF4du/NrXwC07VD
         k26PNJOcg8uWCVmry4KMmFXJ1aub9xDGDRHivc5CSQj/sOD2CpbEVvW68tY9N0/0nDbZ
         emJw==
X-Gm-Message-State: AOJu0YyIN4r83rWiH3kwaz60ir999cwB/7Ts9WhvcLNZZ2IUYxMrxb2j
	JjAu984IUjUtOGhKopXKLws4GZ7Yecc=
X-Google-Smtp-Source: AGHT+IHCn9NXq9MkbFbOjhqafuPDAk7+Xk3fDQa+ze8eVnSK/UJpxRPEU11QIlVD/CycE0cJR6qJOg==
X-Received: by 2002:a05:6512:200a:b0:50e:3870:d978 with SMTP id a10-20020a056512200a00b0050e3870d978mr1629066lfb.122.1703002211180;
        Tue, 19 Dec 2023 08:10:11 -0800 (PST)
Received: from debian_development.DebianHome (dynamic-077-010-185-155.77.10.pool.telefonica.de. [77.10.185.155])
        by smtp.gmail.com with ESMTPSA id v19-20020a170906489300b00a236378a43fsm1936621ejq.62.2023.12.19.08.10.10
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 08:10:10 -0800 (PST)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 01/11] libselinux/man: mention errno for regex compilation failure
Date: Tue, 19 Dec 2023 17:09:23 +0100
Message-ID: <20231219160943.334370-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Selabel lookups might fail with errno set to EINVAL in the unlikely case
a regular expression from the file context definition failed to compile.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/man/man3/selabel_lookup.3            | 3 ++-
 libselinux/man/man3/selabel_lookup_best_match.3 | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/libselinux/man/man3/selabel_lookup.3 b/libselinux/man/man3/selabel_lookup.3
index 4e47c3ec..e20345e6 100644
--- a/libselinux/man/man3/selabel_lookup.3
+++ b/libselinux/man/man3/selabel_lookup.3
@@ -64,7 +64,8 @@ The
 .I key
 and/or
 .I type
-inputs are invalid, or the context being returned failed validation.
+inputs are invalid, or the context being returned failed validation, or a
+regular expression in the database failed to compile.
 .TP
 .B ENOMEM
 An attempt to allocate memory failed.
diff --git a/libselinux/man/man3/selabel_lookup_best_match.3 b/libselinux/man/man3/selabel_lookup_best_match.3
index ef2efb4a..985a8600 100644
--- a/libselinux/man/man3/selabel_lookup_best_match.3
+++ b/libselinux/man/man3/selabel_lookup_best_match.3
@@ -78,7 +78,8 @@ The
 .I key
 and/or
 .I type
-inputs are invalid, or the context being returned failed validation.
+inputs are invalid, or the context being returned failed validation, or a
+regular expression in the database failed to compile.
 .TP
 .B ENOMEM
 An attempt to allocate memory failed.
-- 
2.43.0

