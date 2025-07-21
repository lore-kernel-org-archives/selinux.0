Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B796C256C8A
	for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 23:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140279; cv=none; b=Roo5UaqpOCLaqomUJM3VAGTIUVfzERe4lLVEI98/wEgkQ8aKQnt/ajUPcwywAh4Hv1j7XY9BimCQNVMp4RWrkP39l4A8p8LDCGHsMyT+AzGDO4lfXQmJHvlXEef3EC7EPWWefI8WvApatOktQSiYS/NziFtuBjTP1Tx7W18OG00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140279; c=relaxed/simple;
	bh=p1vICmxi1fti6S9Rw6hUCN1R72nz6xE9UXNQI1bkhho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAXZYhNc0id8Fz8fp58cAUJ6sT5QWBw928h7YaPcQ8NBDzGlCtSaaUb2Tr0WfNAhR/22mOceChV5MtpWekfVFw58QtZ+WY8lG4x02Q1mWiVSWF3Rz0kFgzCwXecsSrnUAhsBMKBzikB1IrUqAsamBpxj8tGxs866WOUxEvmKrss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NKthlovZ; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NKthlovZ"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70478ba562aso61151916d6.1
        for <selinux@vger.kernel.org>; Mon, 21 Jul 2025 16:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140277; x=1753745077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MUkWr9eqINkeO0e8VCf7ovyQsA5LE+ytl1/HEelWN4Y=;
        b=NKthlovZOL05iupRHpn59y4zSyuJYpkQJMhiH7WX/gln65ICd/LRA651mf10USxX6E
         8KNmly/pHGSi7Xk3fOGSsVEc7bzEPA61DkZWS8aplCR69CWDbbY+mRl1EKCSFFK+IHsQ
         bUlZhj02naryU1fkLPTVUq5Y4yw0HekK1I3E4yfNicaVtlYHesN1u/DP3jc5ZzDXFY3g
         p5WZ4JcguCVnDRii1q+pD8OHFnqI/2jvCqeJU8xFCHNer0798KJ6VAsnA9ky9WPJeutq
         VkjvYlnJiwtIoT2anW5LT1+xojNgHNkN1Iqquzg8ztraiRXjlXr53tvpLmCrXL9euGnc
         slSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140277; x=1753745077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUkWr9eqINkeO0e8VCf7ovyQsA5LE+ytl1/HEelWN4Y=;
        b=QGlXYk0YW3s+ZQx6KNwsWM2KhjLMRnWn1GFuYvP/SY/5mrkL47gVGXf0AyPtmXWu/2
         Dfb+I/58er7fsOgbGbk/+SKPIQONzIZ1tABZVYEZz6t+iNwbQM+TWk2txDMjWRkJbMM+
         iJwTcctjqfob8XxVnX0UaAZGTU40jr8eueVgDD1J6uQ9l1aRGzKkrqDX/yaTsyf4TaSt
         Iqm3pQWx/USbFfcKKXmHbmXi+myJ2QOMjp0SdU0vDu+r+wgI1DtOWOW1VH7k/IJaLEMn
         d97NjZTBVFveZm7euTOwSX5un0D33oygkLoyJQLRfT0QO+0x2WP0K1NysZCChDabF5MD
         o0Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXfL0bESo6de2n5LvDiXbY9XcxIVKOtSMofAfORu2IDgPSbAJtKbTQ7X/gd9/gGQf4QWOfOeevq@vger.kernel.org
X-Gm-Message-State: AOJu0YwpKE74h5epWshHNymze3MKaLfDhGfnCYonJTu+t1Lf0JupkWAi
	QwIeYI/KZR1UBqFQv91b2jh7delFSbL9X78SSE9GLzy3vpXdmOM0TtD3uYm27iRWNA==
X-Gm-Gg: ASbGnctBOCL27zGzHWWJ2+EbBO8JZ1HYRATDOjfDv9prX5Zee/zlLsOMrg7+wxtqrMe
	5953GtKNl8Ym4MDLfhQLrLMzOFsqLJZLvuK7TSKB+4FFnjbB4KfaQC4OYrYrO8FEFdQqr7sh1gS
	AmQGz6GblodSvBr0G6FBIzurRrh8nImZIfvg4y35RTG3Y52MVtCaPFEpBqExOIyWdNIqDjXHaDx
	9/rpHEDkt+KrQNIkD35p/dpKciFliaopPBpO+oEPv9flL2LkWnWMqBGQhgnt8TGsLQSDUz3s49m
	bWn+bPPxLpsP/VnKWokG5BElgZiBK5jXXnvrfhbdME5yfeMtQxGDYX/dUT/UH/X4GowxEkTZ09S
	Ei0gASRglfqfIh/IwZnn+iTKZz6eRCFt7jdfOlnUepMVl+BU23yraNymhoX8nvw/I3U0=
X-Google-Smtp-Source: AGHT+IE/GOn20n7YD5/OWJBC1EWu/7Sg5dOIy7jdFB+JR34W8MLs8c+l49xwAHQ2VSBuw52TY2eREA==
X-Received: by 2002:a05:6214:4e03:b0:704:f7d8:7034 with SMTP id 6a1803df08f44-706eb8a6d48mr19089776d6.25.1753140276679;
        Mon, 21 Jul 2025 16:24:36 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7051ba6c8fesm45065406d6.61.2025.07.21.16.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:36 -0700 (PDT)
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
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [RFC PATCH v2 34/34] lsm: add a LSM_STARTED_ALL notification event
Date: Mon, 21 Jul 2025 19:21:37 -0400
Message-ID: <20250721232142.77224-70-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1016; i=paul@paul-moore.com; h=from:subject; bh=p1vICmxi1fti6S9Rw6hUCN1R72nz6xE9UXNQI1bkhho=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofswAXBx6NWMyJEJMRwP7xcIS0YcighZyL1XRC o9zC8SWyIGJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7MAAAKCRDqIPLalzeJ c2Y+EACxlYqRC7OtM0sPAuXTBNwmxXyRFadMAec8uYiYBeLQcIb9z9adT/AtuUPB03TijrKxKfE yotpamSHDQRcBg1wFEK3WJjGdqzOQzq8ahht2p6ljIof6fGXFdrTJ7EJrvxZNN/Bgitw0bEHUC1 ksThdik4B1SPn5ZmgfzeMXsu+x/d9fIULud3ctgKJ8klW0tKBIFwQ1bkXvM7UkL8NlyAb9g1Bmd C+eClH8c8p1oE3RH9Gq47NMJQq3PMsqo/A3Jr8fMysAiAhFg4qRxtTokkE2z0yJNZLqEs07STD0 ZjxQUvcmI+6m0WC2qYI/nF6jpxL60ItU6Ds39ddAw2tvU1jwvifTjAVKt4vxxwIUmd5jjMM35TS QmtytVb265qXHqo6mQrMtfQQoHphcLkea4hMiNE3/7Yqi6YyUD9DEBr22lfgqqFhMHzfwXUnO07 Q/PpC+O+XDCumMduXX+DOy5ATJ/XEZuBtRff+0hlMsjLGnbVUGjGk/vZfa46dqXXimye0U8sHIB UuVuNpgT3v2cRTS3sc712Yxcet0skb6Q1PciC8+fgqmO/7ojJwKS/waPreCG0Vv0jp1lb2AzVv8 PwKAeGjpiUOL5UX3jVnS9lfDNkqn7OKw41WD8AwVtIrf6ftJSl6QY+qDXcOZJ+6lT1RyMYE/aBp /7OB7g8AVqWFNgw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Add a new LSM notifier event, LSM_STARTED_ALL, which is fired once at
boot when all of the LSMs have been started.

Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h | 1 +
 security/lsm_init.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index c57a9a7499ea..b9cace094f0f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -85,6 +85,7 @@ struct timezone;
 
 enum lsm_event {
 	LSM_POLICY_CHANGE,
+	LSM_STARTED_ALL,
 };
 
 struct dm_verity_digest {
diff --git a/security/lsm_init.c b/security/lsm_init.c
index f178a9a2f9d4..6812a13f64c9 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -550,6 +550,7 @@ static int __init security_initcall_late(void)
 
 	rc = lsm_initcall(late);
 	lsm_pr_dbg("all enabled LSMs fully activated\n");
+	call_blocking_lsm_notifier(LSM_STARTED_ALL, NULL);
 
 	return rc;
 }
-- 
2.50.1

