Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0B927C179
	for <selinux@vger.kernel.org>; Wed,  9 Apr 2025 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224829; cv=none; b=M//cRB5bODakofR6Wzi9j+PK74xJX0w0p83pAdkdmRKlg4N+1O0YXXs9/vo0DH4+WFsJm+c4eewy+BAzAk0V7w6Uc0GiMFLJAVT70dmVB8pLfvr6Wk9Eo7EJll0+syeCR4bRk5X9DgAYz9qj4okjU6C/dFqWML5cA0IYFE4o70Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224829; c=relaxed/simple;
	bh=U0J8daT5qbdY0XH0/6KwMZfXF6KoGXdJq3T5B3kThVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZ2JGuR83KIIH2CzRU39d7IH12vJKtcTYEg9Xwp6bzdwAfBjVnOwV8JTFD/82DXofzochTvxIdJ3mZi1FbOopn5zopnTOfS+69YY2L1byfbs47QiBx9ocmnM4RX6O4qwj0QSyh4a6Y+6fy9w2PuRehWJjMWkqi6W7XgjC20UGEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MlUMReY1; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MlUMReY1"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c5f720c717so111593485a.0
        for <selinux@vger.kernel.org>; Wed, 09 Apr 2025 11:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224826; x=1744829626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOHKz9d/qjT2CE9duhaUIeD9jISgOoKf1CYvh/h5rto=;
        b=MlUMReY1lCgQD/eolgpi9Nr2raLx8fyK/f/5UFvFpjgpC+ghisy+6p8O9hvspmDe7h
         ZxD2q9eEHqdyI4QOCghfzrj9w5sqG3+Bpl9jFIhbYI+msYw9pLQdV9CxYdkQ77QE3AkP
         uKoU6SFRCvV38f6t1iv5r/MncgpusEajtdgBYvgIE8UePHbsaMyIsJD+maZ9fd2pepIb
         iYIQDO6q3xBPNHRG+FiqNyGVrqkTDlguV5JOk7b8zAwmTBz3OWuUVX4dF02YU4dOYNiR
         QWf3wJMVAtivjAyvIEy2xf9IpB2Q6Yr4mYdo0FEBlBqj0sm+tzkuoRdoqTDj01kn44k6
         MY7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224826; x=1744829626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOHKz9d/qjT2CE9duhaUIeD9jISgOoKf1CYvh/h5rto=;
        b=Uh8H5ZNbPx1zyE1+AfGzuJoCkyzZZowG+oERyrXPP1y6g7mxw5IxOb2a71i4TCVaaV
         RyOrrtwt8R8x3JQQR8Yv5+lvP9pG6ScPFsLnfjy2V0OJoBDvUMTP3ZwJE0KZATwx9bvv
         1k48gVRCCueCTD6ia8iMp+sBP6RYs4vEy9inAVimipfiTksc6qYv+ROgxESRG9vOTD/6
         McYAbdU6QzZ1EsM4LnSQJB6KbDE99U6YXWUAtB4X9+jzocrh96+yg0YYCvK+qpmD92Z6
         fLrI+d0QiHxghBuMyAeZU7CfnTzfraW3IzgwbO5Bm4bZ3+gFB2A+ZlwzzfQRoZw++Pam
         Aojg==
X-Forwarded-Encrypted: i=1; AJvYcCXd6+IRdu5JPWLcZtXSgzkPgSTLLO3iZAt3mGg4MYQggzw8xnsWOScoPeHA/3x1CdlCQ12wDO7j@vger.kernel.org
X-Gm-Message-State: AOJu0YzXv7KU45Qa1m6vleQWrRZJaCzFYdd+WC8O6cbpC0KsQ6ovztXk
	jiFw7qLCB7PT58DpM7b+eS4xQJt9RAd4KuOHW34uMG9piKG4GtA2uL+nVZhFU5MGhnBxwu0ZCQE
	=
X-Gm-Gg: ASbGncszwZpvLezh8aTkt7v5SOYC6ddoTm2SlQAPeqJFDkTrdWgkXow0zhKVxR+CVwq
	tfDj+UIVsjK0ERniFRDJjMUrq6f/klGMMhwduNXA/z9DjMKnb/N/ZCi983AwmPgn+CneGgPuGHx
	5Xo8No8IDAcUP9pAF69qT3P7bYtnOMrW67nntrwHF5cDtsfn/oR9w9w0gzttetQMnfXKCQgks/N
	VrpSAN10iiWhdtzt4oDC3HfrpB2Gp39mMgetHevCwHiK0OlfKJN3LXDefFj8slzX83O3XsU5QKi
	w4xI7X6jsiMduqirEhyrN8ypOk5op2d3e3mNNXpANHANTYtpV12DZVH7Jj4x/X2+3Peyfb2fGqQ
	Kv+dlMSHi1w==
X-Google-Smtp-Source: AGHT+IG+c6drXp3nozaPsjXztwAoOvjGgCaW6rE/tB4NQI4PpZiDxVdOYrpKlKJ0q3cSZYNhC4QBsQ==
X-Received: by 2002:a05:620a:258d:b0:7c0:b384:77bb with SMTP id af79cd13be357-7c7a65e1ce2mr100060285a.14.1744224826739;
        Wed, 09 Apr 2025 11:53:46 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a11c9bd0sm105448885a.85.2025.04.09.11.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:46 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 18/29] loadpin: move initcalls to the LSM framework
Date: Wed,  9 Apr 2025 14:50:03 -0400
Message-ID: <20250409185019.238841-49-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169; i=paul@paul-moore.com; h=from:subject; bh=U0J8daT5qbdY0XH0/6KwMZfXF6KoGXdJq3T5B3kThVs=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sHWJoStLswLfKePDDr3dsFYxt6C8v3Zk7goC HEKVxevRFKJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bB1gAKCRDqIPLalzeJ c2KMEACm7+2OCx2kQ5fG7StRMJW/3n1wX/suF7NH5uiAbGUkQgRDyX3aohGr/TNR1vI0WuBxcxd iKIdGrsFiPSGjQVFKWdgQmAA3zJYwHttMd+uS5G03hIGriID5uLDqrsS0x6/jkN9X1IrTgMWXNd 17OyZ6e4fOYvenc0FEn7YTz5Z1RIBC6zdeMSw8A9U1FFGzWltu8mkyQlTnwBBxQonW7ZZ5TLER+ t40CYiSURQJOBUllsApcrEz5+N64liy92cl726YpbmPrw159omGFxwf5WBG1rn11ERliOAlCRxZ qBo/r24HBp56gtHYSSLiVtKUziOqdVTPKEnhCRXJSx1U5ilJF1Sp1wMa+Biem4oqq1ujXQsK/Km 9Ezmy1vpGCuwmTeoZbWXfJO0K8iq2RSRD9RwpaTvcekvWqCbjOJb6AzQ5aaGAs+NI5QulV59d7J QnQrF2hKccrPBWm9TZrQi8k2S2oAstftdKSDzu57BCqJHT1QweyWXYUhN2TUneUPDNLJXfQ2xX3 IJXNGatmzo6V8malwATvZD5r8vEkCJlosykEOhY1nye5NsnenufsZPDWX7fEBy97J1T3oxhmTTP dUpVwCuOnSmTvsyqvwMopHrPMGloXaQBXAtRfVLJSbkgyDmaYBBntNgyOGRo2Y18lN5XoXHL/gG hT8O2jpwYddoTog==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/loadpin/loadpin.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b9ddf05c5c16..273ffbd6defe 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -270,11 +270,6 @@ static int __init loadpin_init(void)
 	return 0;
 }
 
-DEFINE_LSM(loadpin) = {
-	.id = &loadpin_lsmid,
-	.init = loadpin_init,
-};
-
 #ifdef CONFIG_SECURITY_LOADPIN_VERITY
 
 enum loadpin_securityfs_interface_index {
@@ -434,10 +429,16 @@ static int __init init_loadpin_securityfs(void)
 	return 0;
 }
 
-fs_initcall(init_loadpin_securityfs);
-
 #endif /* CONFIG_SECURITY_LOADPIN_VERITY */
 
+DEFINE_LSM(loadpin) = {
+	.id = &loadpin_lsmid,
+	.init = loadpin_init,
+#ifdef CONFIG_SECURITY_LOADPIN_VERITY
+	.initcall_fs = init_loadpin_securityfs,
+#endif /* CONFIG_SECURITY_LOADPIN_VERITY */
+};
+
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
 module_param(enforce, int, 0);
 MODULE_PARM_DESC(enforce, "Enforce module/firmware pinning");
-- 
2.49.0

