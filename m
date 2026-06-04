Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E23D399348
	for <selinux@vger.kernel.org>; Thu,  4 Jun 2026 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588413; cv=none; b=tsDewUxPBt4Y0Cfmg7ch2KCaKrkahv3R5iLkmG2wpLqbfFFWwHTXz5a2bpTupB78zmmQk390Q/jIx1j77qo/94alw3UaC1XMA7Er5Hq8Yt1VtbAymCYsgmAbJ9SM3vSP0pkeVRco8h4f/rUxLcJyzIh2M1rfxkcf+6GbIsz67xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588413; c=relaxed/simple;
	bh=A2GQ2FhT+hFyCsp3O/SMk0bn8KhcP0PufyMviSpSLhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f2BB0fUhCMHalU1k3Cv6t4jCnSQThdZpd7sIXtLSUYOwAQCJQ1W0L0AoyyZ8V5G4aMdsCFEl01wycFccG/d7STC6XYEPMSGXYdeS6pYGypXo+d31fhIKAkzDIiJX9Eckcp2eg1CsjXY3wzrojDutvwgVJ2c6ALtWSiOyX+zwcEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdV8yRs5; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdV8yRs5"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8cce8873b56so7751106d6.1
        for <selinux@vger.kernel.org>; Thu, 04 Jun 2026 08:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780588411; x=1781193211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=043rqFsOd1pdd9LCKl+8ILixcQaAfPQS8zZNJ7FnDDY=;
        b=NdV8yRs5OM9UhB/5hcUV7zl+RD3TM9WZqvFVcLWv/VqVqehcXrFad9NuSvRa+aRCtW
         qv8hiHu58E2rqw63aM3Qm/eBv6tqLCooCuPqPbr7hKHvmIT/BoundeumSCe7mGXGuh0Y
         2IpPyKa76amWKpPPTZoh0sN2QYXVTi/u1geLMv1x0F+NlN4Wsq6L4KAxJfz9ug6a6B9A
         iEfw9hrMWpaLcENcT3dmhcJiLmckCJX5hyxLMh3g850bcNOAOp9XWTwzV2yyi2RsWAm5
         JgoR3EJtvBZKK0qqrFRiD+AEe5ZmiE52O/KMW0qqG6b27qdkE5gg+n/thpo2KeVyO9v3
         DPiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780588411; x=1781193211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=043rqFsOd1pdd9LCKl+8ILixcQaAfPQS8zZNJ7FnDDY=;
        b=QJ3x9jltxqR5aIItI7XrTHxifJk9iYf3e8vxCslPLkIOONHqNtdGOolK4twzhP320q
         cFY4VLCqyNTg5nkAW4KJii4OmGDtgp/QS88euEQwEvhf+2PlgqK9rWE0jWUNwfAQlrYE
         7toF7c+xkNXWBtGRd7ioqfFtbfegmXatWABua77oE7Fx0mdYX9lC91AObSxFxjlTYDra
         TaUmS6tMSqeGYL9ieEBSqz6TRq3XYfHydsMsOMO3rInJvnI3nAjQ0T3KrkRUosGaegmx
         4ETz2WQSZkKx9RBzL1ZCqJEa95xTV7G/jdw6Ne+IsMVHqpzh5Eqj/II2wovwPxy8vS1A
         VfUg==
X-Gm-Message-State: AOJu0YzRcH1r7NC1FTRkEC4lPnPOa8MRbTKqRxzCfbg6R16CqrI8L50S
	KbRtMbQeMosGTbCzZDV2jklgEalqEUJgN7byOIIkk9XKb0zmV9ZYPikfodZj9A==
X-Gm-Gg: Acq92OHKMm9ZMcTGUOMwt3htfmxpYtG8Pmjk+ypxxAQgw/Tcs1+zS09/X3sjY5jqPlq
	OxBS+Udg1v6d1TaEjzCiiuCGV3bru1TDkU3REew6UhB1cy98WWNN+p2/SGeEpEHOEZek9EYrq28
	FvwUnguumxj8qvJVry8OYQVM7IG9FIyJcc5K+drvWm05UHl7y7pxFk30NTinTd+8+29OppgnfEh
	IVjQLuDqdL1JhqSmY0jGRAPSiMChKwbkZRXaq8PT4KJfsIJkauUGbtjuFFxT8cpJDQYF3eH189g
	aS4ncRVKB39GyMhu4nXX6EScxwvOlLw7DuTPjc/EUqJtuqXiTWv81e185hjbWS5WDHJefMz9EQo
	oXubRDftMXAYjRMxfR8+626kroaeBONAoPMEeaKC1j6Il4saPFlJ5XB9chamQ7dHA28Zu5MegyJ
	oZy9RinJagUawve+4tdFgKpBhr91R+8hDQmUvCU6rhgIi/wxa0oU1qcAm7
X-Received: by 2002:a05:6214:3913:b0:89c:ac42:e119 with SMTP id 6a1803df08f44-8ced7cb59femr62560666d6.8.1780588411523;
        Thu, 04 Jun 2026 08:53:31 -0700 (PDT)
Received: from Fedora43-SELinux ([144.51.8.27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd077be8sm55438716d6.40.2026.06.04.08.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 08:53:31 -0700 (PDT)
From: James Carter <jwcart2@gmail.com>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	James Carter <jwcart2@gmail.com>
Subject: [PATCH v3] Have clang-format ignore auto-generated files
Date: Thu,  4 Jun 2026 11:53:19 -0400
Message-ID: <20260604155319.16844-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add .clang-format-ignore files listing the auto-generated files to
ignore taken from the .gitignore files.

With the exception of libsemanage, place the .clang-format-ignore
files in the same directory as the .gitignore files. For libsemanage
which has a .gitignore in both its top level and src directories,
just place one in the src directory.

Signed-off-by: James Carter <jwcart2@gmail.com>
---
v3: Add missing newline to end of libsemanage/src/.clang-format-ignore
v2: Use multiple files instead of just one in the top level directory.

 checkpolicy/.clang-format-ignore     | 3 +++
 libselinux/src/.clang-format-ignore  | 3 +++
 libsemanage/src/.clang-format-ignore | 6 ++++++
 libsepol/cil/.clang-format-ignore    | 1 +
 4 files changed, 13 insertions(+)
 create mode 100644 checkpolicy/.clang-format-ignore
 create mode 100644 libselinux/src/.clang-format-ignore
 create mode 100644 libsemanage/src/.clang-format-ignore
 create mode 100644 libsepol/cil/.clang-format-ignore

diff --git a/checkpolicy/.clang-format-ignore b/checkpolicy/.clang-format-ignore
new file mode 100644
index 00000000..f6b7b435
--- /dev/null
+++ b/checkpolicy/.clang-format-ignore
@@ -0,0 +1,3 @@
+lex.yy.c
+y.tab.c
+y.tab.h
diff --git a/libselinux/src/.clang-format-ignore b/libselinux/src/.clang-format-ignore
new file mode 100644
index 00000000..001f20b0
--- /dev/null
+++ b/libselinux/src/.clang-format-ignore
@@ -0,0 +1,3 @@
+selinux.py
+selinuxswig_python_wrap.c
+selinuxswig_ruby_wrap.c
diff --git a/libsemanage/src/.clang-format-ignore b/libsemanage/src/.clang-format-ignore
new file mode 100644
index 00000000..2d2d8e8b
--- /dev/null
+++ b/libsemanage/src/.clang-format-ignore
@@ -0,0 +1,6 @@
+conf-parse.c
+conf-parse.h
+conf-scan.c
+semanageswig_wrap.c
+semanage.py
+semanageswig_ruby_wrap.c
diff --git a/libsepol/cil/.clang-format-ignore b/libsepol/cil/.clang-format-ignore
new file mode 100644
index 00000000..3eb2902f
--- /dev/null
+++ b/libsepol/cil/.clang-format-ignore
@@ -0,0 +1 @@
+src/cil_lexer.c
-- 
2.54.0

