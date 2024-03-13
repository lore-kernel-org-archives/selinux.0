Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B27E3E470
	for <selinux@vger.kernel.org>; Wed, 13 Mar 2024 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710328235; cv=none; b=kOHXoVg4yfFkuHORH0WL2Vl7dsJA3HevLIXCIWOpFFyovOHV5Eg7i8w1apFX5vdQycvOriOiXafqVzQ1/yj/aAyhXqGEJ8ZSueMmA3yuXJorZFg08HSDMS59Od5Z3fR8IVwZzCplPdeB2RRSRZi9zJ12nMtkVOJeF1GVuFXuBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710328235; c=relaxed/simple;
	bh=ZHzSsLawbszainBncfVohAtTe1OYDQk6uEH5gU5mnMI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fWIDHZnXA17HF1Zji6J+QVzxq3Te0YIGx1r2ELt/dOClVjNzkiEzyY1emnV0jS9I5SzVM+HwxVb0nBq5rovHGCQrT6C5QkCmjDOWpmySl7bNKr2iRIT8a8SsyZfVQubpbiTiWsezCEaslofzsIQPuOx/yuDqKW4c4B2XjXB8qNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ki0zJ3mx; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ki0zJ3mx"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a44d084bfe1so620616466b.1
        for <selinux@vger.kernel.org>; Wed, 13 Mar 2024 04:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710328232; x=1710933032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jhAAEYa1Rt0zVQpNcZCPBZYVgqEaZ+qCSE4TVrcKx1k=;
        b=ki0zJ3mxcPxHg6FqS9jbcE2mEClnn/FBM4zlCxB35f0bn6SKDH+Q34/921t38K5PBf
         Zk1WE7eFajZeJadG8DQSnILW3P4KEBYPSoS51ZYUa/OLyXNcm1lEDlHyVDKSS3XRl3BV
         XHEIY/YtpPhHqf7RWzKtCGYF5aHe33HXyagUgr5Jk8eNJV3mDjZBP+7DXNUZJ/u500rb
         Zp8+zcwGJxV+csiXNDrHnjtJ1R5nFJMQXl1ZudheXvongb+ncsvzrXyYFyJfH42ys6hs
         LnldP7RPajFeM1TO0hcHddVq5OB0NVfiincOdLPuGUI5pggqQIYhnYbbE3cD3psgApK4
         qaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710328232; x=1710933032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhAAEYa1Rt0zVQpNcZCPBZYVgqEaZ+qCSE4TVrcKx1k=;
        b=IXLmtjE5vkKVwkLFB4ROVRD+BYHtZytcOerda2CYWTsiPu9C+fJosOpyV40+wMBKLr
         uJ2kZ1WYFte7J/gTHYOjw8CVdj+WIn1kEN8OZG4AK7+lwWtMQNf5IxPrqdlIeeDPeyqx
         s4p4sEwyxdeiIwXmxVbR2wR8747V6m9aXKSKdt3pFa1octGQ6X4JnF1BYImMXCghauet
         C3tGXLhVPxh/PJrYQCIxn9KTxS/TXoUsk1FdmK3d9rN2/tO8UxVK7vG9f/cClXUnrXhT
         pb51bb8UyRXD3/6cWcM4TamVmc4YKKq25BRzYZPq906i9/NaanR1/NDUy7YXx9oDo6E/
         HnsQ==
X-Gm-Message-State: AOJu0YyD8K7dktisqOy4Hi46KQ4NO5hArYB5U/2rLIQaxpvEe6xs+4q4
	iILH5SJujQL0Sx9U1/6j7Mst07DiXEh8FvVlR0/R2sSaqUS38iIg33gYd4uSdKA=
X-Google-Smtp-Source: AGHT+IHPV2jeqUkaFk6yBJqe5IoJ5HlCMeS0iAbEVzyOj2RMIMFqhFeM27qi3nFnHD2JxmFOpIoohg==
X-Received: by 2002:a17:906:369a:b0:a46:65f8:73c6 with SMTP id a26-20020a170906369a00b00a4665f873c6mr52941ejc.13.1710328231575;
        Wed, 13 Mar 2024 04:10:31 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-077-001-104-044.77.1.pool.telefonica.de. [77.1.104.44])
        by smtp.gmail.com with ESMTPSA id hg22-20020a1709072cd600b00a463c821e4dsm1794319ejc.10.2024.03.13.04.10.31
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 04:10:31 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: selinux@vger.kernel.org
Subject: [PATCH 1/5] libselinux/utils/selabel_digest: drop unsupported option -d
Date: Wed, 13 Mar 2024 12:10:21 +0100
Message-ID: <20240313111025.43720-1-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The command line option -d is not supported, drop from usage message.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/selabel_digest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libselinux/utils/selabel_digest.c b/libselinux/utils/selabel_digest.c
index bf22b472..50f55311 100644
--- a/libselinux/utils/selabel_digest.c
+++ b/libselinux/utils/selabel_digest.c
@@ -11,7 +11,7 @@ static size_t digest_len;
 static __attribute__ ((__noreturn__)) void usage(const char *progname)
 {
 	fprintf(stderr,
-		"usage: %s -b backend [-d] [-v] [-B] [-i] [-f file]\n\n"
+		"usage: %s -b backend [-v] [-B] [-i] [-f file]\n\n"
 		"Where:\n\t"
 		"-b  The backend - \"file\", \"media\", \"x\", \"db\" or "
 			"\"prop\"\n\t"
-- 
2.43.0

