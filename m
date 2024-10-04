Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88B51E3789
	for <selinux@vger.kernel.org>; Fri,  4 Oct 2024 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060381; cv=none; b=S8qF+RxUtd6Kt96kjBRvEFbaWPZwLEtyjovXR+c7uJ/qTr8ENKcrJcsZeT8/0/MIXMoqBld0lclcyoB15zkx86nZwdIUY8107HdRAA/ZVOkqnAMngPXgYR5utw0eZ4KHcfEObH1HiQCSnxfGirbMBGxy4Gr1wuCaB1tTN4LReHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060381; c=relaxed/simple;
	bh=ywYaXNSeQa3SUlJQw68Vq1qiomUiiN7Sbmn0AfaXOvk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d58thIak99RtPJyiDjnRjQ1waSR4Vli3skYrsjEH2NkmosS5jZPC1y/LyZrl1WnJbZmWZqgd9+gLF0Mw8T1KeVd+teK8kagZYI6Ij1Q7Jxk7+tMKkvZTjYEbUHMst+q8otTukkM7+0nkoUsz17lFFezvC3Q+y+Vt6sjKhp6tAB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QiAF2Bxe; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiAF2Bxe"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-457ce5fda1aso18349531cf.1
        for <selinux@vger.kernel.org>; Fri, 04 Oct 2024 09:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728060378; x=1728665178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iUA5I7bFXLy4rXH1cTW/7fxwQ/Amq5OABn1sSV7StAc=;
        b=QiAF2Bxe5DaHKuAhJB81rtTnlYyjBQ/bfobWXz+bWFWeqi0euILgzC2HsBBUr7AE2d
         gpAIveGERo7nf9soIizvsPUsKf1MH3OzMOoLVGQzW3UqhJOu7Fc7JUGigbL+Ud6KhNf5
         hauYOPjf7YaGcuN/tX8MRgpLo5r1qZdWe8hsOlw+YsNVu+APkTmpXhCxLFQZUD8um7VG
         dyxvoUKMYSnbzAySP8JTkVF5ZUztinGW3GZCYO+1+TggdfMcWRLj9Inkvyd2A1jaDixJ
         aZSuRnSLG/G8zHge+qltSzJ86LLRme0UplAUZoXZJ6X0UiGYvxmFdT+h4Nro5rjpYbGX
         dgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728060378; x=1728665178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iUA5I7bFXLy4rXH1cTW/7fxwQ/Amq5OABn1sSV7StAc=;
        b=kpSP6domqMRcjUsRo5rdyo+l2z6KYfnm2WOhCcT1NLaSwrhh0HcKNTadm2qzK0xeN+
         eMzO1gTYsuEtWCbj7ivfKPEkoyMK/5jZR64k+2uOzYAEerm3diWQyiRHrcMFGdC4MObR
         /ZtCJlV6UerVppLIk0NI5C1X/rSh4s5cqg09mn/W5RLXwiOPDTf2API8sGDPDp/d2lYf
         SbIFZmmpq0XeFmDIoeUK/z/LYAcoCcC0LwbwXyqZWLHS/gBEPg0bc6VSKkVwNbO0LfDW
         /W2hJKQekztAza/Pp0FygTs9TSSh12lA0q2L1mXtcfyMlynP/h5J+2iNRO83qtqB+Auo
         PjaQ==
X-Gm-Message-State: AOJu0YwzW/1wPl9SgwifrW9XOZBO4yciBvKwU97FdvPf20xbRJyI/sMj
	0YtVOHvNi/qj+BuHJ8ruOM8SnwHa8Dj3LOXubchhfmubHLkxKDobGtj7gA==
X-Google-Smtp-Source: AGHT+IHw8b2GXbCTcbkOJMANmTcB6mlAYwR0IKv1GTdq/YuFknex9S9Oe7HjmxFx72Mc4DCAuQIyAQ==
X-Received: by 2002:ac8:5d46:0:b0:458:1dd3:e3a6 with SMTP id d75a77b69052e-45d9ba452camr60390631cf.23.1728060378372;
        Fri, 04 Oct 2024 09:46:18 -0700 (PDT)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45da75ed39esm618821cf.66.2024.10.04.09.46.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2024 09:46:17 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] libselinux: formally deprecate security_compute_user()
Date: Fri,  4 Oct 2024 12:46:05 -0400
Message-Id: <20241004164605.7607-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was originally marked for deprecation back in Feb 2020,
commit a41dfeb55d43 ("libselinux: deprecate security_compute_user(),
update man pages"), but the attribute was not added at the time.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/include/selinux/selinux.h | 6 ++++++
 libselinux/src/compute_user.c        | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
index 1318a66a..50419a7c 100644
--- a/libselinux/include/selinux/selinux.h
+++ b/libselinux/include/selinux/selinux.h
@@ -263,9 +263,15 @@ extern int security_compute_member_raw(const char * scon,
  * These interfaces are deprecated.  Use get_ordered_context_list() or
  * one of its variant interfaces instead.
  */
+#ifdef __GNUC__
+__attribute__ ((deprecated))
+#endif
 extern int security_compute_user(const char * scon,
 				 const char *username,
 				 char *** con);
+#ifdef __GNUC__
+__attribute__ ((deprecated))
+#endif
 extern int security_compute_user_raw(const char * scon,
 				     const char *username,
 				     char *** con);
diff --git a/libselinux/src/compute_user.c b/libselinux/src/compute_user.c
index f55f945a..d4387aed 100644
--- a/libselinux/src/compute_user.c
+++ b/libselinux/src/compute_user.c
@@ -96,7 +96,9 @@ int security_compute_user(const char * scon,
 	if (selinux_trans_to_raw_context(scon, &rscon))
 		return -1;
 
+	IGNORE_DEPRECATED_DECLARATION_BEGIN
 	ret = security_compute_user_raw(rscon, user, con);
+	IGNORE_DEPRECATED_DECLARATION_END
 
 	freecon(rscon);
 	if (!ret) {
-- 
2.40.1

