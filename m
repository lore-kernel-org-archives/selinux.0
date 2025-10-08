Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BCA191
	for <selinux@vger.kernel.org>; Wed,  8 Oct 2025 00:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759881967; cv=none; b=ea8CL2gOGPUoM4g8tFfhEPw4LYYuQey0PrypLDZ4pZx1pBEZfQ7Vt4bEkFwTyN/dyXYNWXFy0X1Oab6c+WVXZHNE1c4I2lL37es373WM1iqhgGITaMGSAnrDD1PVD5cnqfH08YvMoTPy/EbwqLqBdYG74ZDUMhfFoIO/jXfS/EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759881967; c=relaxed/simple;
	bh=iByYgKeFHAbw0PE/YTfOWHupGaE+J1qGKTTlikSiabc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M1kpPYkGpBFJoWAHIjM9RH2lMTnuhP2fBVr4aHMV6SAEuMKUnanQDlTBXClvxUWXvzRxDjvA/OmRGDQAVGSW9yIwgt2XvkZe4mdVrz3+hSp+tXRvRVvZB2ndKrDMOxSfwo+SScSin1KpclBCIznY0x6wPjCCvM1Hf/J0R0uNowo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ykb8zpDe; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ykb8zpDe"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e42fa08e4so64816465e9.3
        for <selinux@vger.kernel.org>; Tue, 07 Oct 2025 17:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759881962; x=1760486762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wl/LhZoksa8STIvwpe7IaiC9Xf4MeipgBIgvKvnObg=;
        b=Ykb8zpDeMWhlDphONOaJTFVg7GDn/DUDtA/tnz5v/jBqk3cHrJOX9bUHi1R+1Z4iLp
         58+c/m1rXZgYoA7y7ZBv1kmNJ9BsOSqjo5+JkeB2CveshAiC6Y9mxH32SAc9QzaTYItn
         tDW94CqhHTIGqJ2ZyFjBAcBD55wiFnS9UBKnJI/k4zBgJ9V7EDN9O4YzE5VgF1lts2yE
         PeVq3Le8+V/+/Ak/YNcoN7pZFAo02T313reMjilpYwzkMjNrmoRiu5TcxrwisR/q9Agc
         emWlxHQaXMiDVL2pI5pbKwXQhzaT5OeBj04Vr79CsNOEi7oSKpnqmfBYpQud0mNPeVyh
         885w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759881962; x=1760486762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wl/LhZoksa8STIvwpe7IaiC9Xf4MeipgBIgvKvnObg=;
        b=PgfbDB2h8Sy6kJ+MIGbECDry2kVOAvz9bwsBpz38CPMRYfePWjruckAVg3uM3ZSDPN
         GswOVrz1LZJJLf8RQgzFUcNJ0+ma5Saa7Tq8aSkl3CFZNeje3VGKEx3nXKPRE/nstnLR
         jYpmChZfQeF7nqQ647UVtgMaqwmySdEVzT3qFjCDgWDC5XXMDCcKS4IjNc8sgnBoKhRl
         WcpF2YTmYzVnFss/ifAOsv9d4lg/yRlQ1j5bYCXfS1W6F9OGUYViEHMUHsvvgVsCo8xL
         aKujEH56RnWe1tzc79LFaL3MnX6dItgUZxG8BNYNuWsdcs4NMD17wkSwW+7FbJztdTyX
         Lbsg==
X-Gm-Message-State: AOJu0YyWTNkCUWcvhX2/qIxHwGjY27QGobPPDLuFXdtwQtqh0pEIkFA1
	Dt66oTzGNMJwi9wbyC8hojnCpSl86osNQMq2qw+WEHiuSO87Z/Y1VuFi
X-Gm-Gg: ASbGncs5EDXGWAhgAxkMYZR+asiDMoBD3GG40GXuVSU3unEyrsYgnapsuR7gXzDSxUN
	o7J0x7tYHRGj39c9pmvqYGFFORSI9WWwaw/ug9clLKiY802AWruM2LbrVwpdmI4s5p/O2coNlRm
	HgCWIUFmukQBlT2jLoTtXhx43J5YOmenK5dM7aLKp2U/u6koHgvyOKXxDsiJhp1L2niPXjknm3j
	y7JLPnz6N/Tp7NPWM9qRrrM2smtsPjYUkdTag2RkZC43XYmOJdnVM3xazN+A1CP/zkSr0JNabJL
	XbMKgeyz3DiNCBEkMXK5xLP+2bKWJnBUfRSfqD5xizsV2+rqowcRikg36sjPMRK0IJMB87PR2mT
	q/KyjNc2XpWbokq4nMYPDzKYppZNuFVlv
X-Google-Smtp-Source: AGHT+IFgo9c8uZcOeh1tyIzM6ahbdeLLW3fC+jQQ/1Vx52G7xAprwPj4XnpS99TvPXEJRbWxeq0AxQ==
X-Received: by 2002:a05:600c:3b1f:b0:46e:4340:adf7 with SMTP id 5b1f17b1804b1-46fa9a8b3c0mr9577865e9.8.1759881962287;
        Tue, 07 Oct 2025 17:06:02 -0700 (PDT)
Received: from sierra ([81.79.15.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f0853sm27753798f8f.50.2025.10.07.17.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 17:06:01 -0700 (PDT)
From: Rahul Sandhu <nvraxn@gmail.com>
To: nvraxn@gmail.com
Cc: selinux@vger.kernel.org
Subject: [PATCH v2] default_contexts: introduce PAM stacks
Date: Wed,  8 Oct 2025 01:05:49 +0100
Message-ID: <20251008000549.539392-1-nvraxn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251007192808.514297-1-nvraxn@gmail.com>
References: <20251007192808.514297-1-nvraxn@gmail.com>
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
 libselinux/src/get_context_list.c      | 4 ++++
 2 files changed, 11 insertions(+), 1 deletion(-)

v2: no need to set found to 0, it's already initalised as that. not
    sure what I was thinking...

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
index 0f3bdc5c..331a26d8 100644
--- a/libselinux/src/get_context_list.c
+++ b/libselinux/src/get_context_list.c
@@ -165,6 +165,10 @@ static int get_context_user(FILE * fp,
 		if (line[len - 1] == '\n')
 			line[len - 1] = 0;
 
+		/* This line requires a pam stack to be matched, which we don't handle. */
+		if (strchr(line, '"'))
+			continue;
+
 		/* Skip leading whitespace. */
 		start = line;
 		while (*start && isspace((unsigned char)*start))
-- 
2.50.1

