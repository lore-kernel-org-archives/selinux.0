Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61B227C161
	for <selinux@vger.kernel.org>; Wed,  9 Apr 2025 18:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224825; cv=none; b=GbBc2E5p6OHMJyW9vsuJedLMfclVwkvyAFJdF7jblLITOhdCCXsDm9VK6oNALW5hAZnZpG6vxrup1jBNb7UV0t8cx8tCb/ZE8bczQ2KrDyAy3yr3XVHTmNc3OaKHQAsS0CPrMRVjbo/EowkznTc1MD6b/9VXf0eboht+RMYvh5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224825; c=relaxed/simple;
	bh=J8s0MQCX1rti68StIWFgrsqpocBfi5qZEsksUWpZxis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNsT7i2GxbHOlJ4tkYvpaRJT29lS+kMePzmtHUxFCiEQoQvb6q9gRVcj3TemVMSE3GSxQvoN2l6BGr8Y1/AC65vNU5c4KN46FSMjPkwa012XtMTm54VQ9dIf2DxZOvJDTgIKMaw1OQLOvXWudU7Vjlo/pP6m4ain832M6F533wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d4u5oiYb; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d4u5oiYb"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6f0ad744811so39669186d6.1
        for <selinux@vger.kernel.org>; Wed, 09 Apr 2025 11:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224823; x=1744829623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HeZKybOSs8+NFkJZkOorGpVfvMZ0pYJDZjai2pWJ8pA=;
        b=d4u5oiYb5SBvHvUMBDPwTcHp5dsXnnhQyvkK+mKqQc3tZvxKUjuit8ZydID7xmjsbj
         ka7vrQ5AuOBA3abOYtz9wjOFYXvpL3+AkWgQlhecSCFesxT4pTOfnOL4cINX8II8tFhx
         y8q/mpN3AWuv3yR/YfUz6X3ucZQ4vwiOcTzSF3lA6Y3FOb4X4KljlIdP5po9kqHVnnzl
         rwgP+lHc2AG3mzOPXw5z/WJRhhe/JwB8K4aBxbojClvqal4edvJ4ddFM3vE1Q6D/pRow
         YvMD3Uf/xwGbwA7OcNdMCJ6fHqQW2tpjmfgjG4wy2Ec2AFM0OSua9oZ7SGf3fLkkAgNA
         vjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224823; x=1744829623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeZKybOSs8+NFkJZkOorGpVfvMZ0pYJDZjai2pWJ8pA=;
        b=OIoQ1nlYcIK3lD4X8xn6J4hID2BFLNZ8v9vimn/c122Mdo1POnVdaNLKZDbOx5tKP+
         KTbEmuOHZIl+x+GwJKW4uQpFvhGLl4hFtk3uKonZb7KGnHG4Lsa1S5493sxTzPCnRqnh
         byh0xZsoCdZbcnpGCn872lelV/4+pcpZC1GWZiGkTVd0AlollX3+OyCfczqNgfhtkL/J
         Uw6Cr1lXfZuFJAWfRDPLCS8uqlmGQR5UbsFHtfwkOCW41GzlBE5276eUamW400C7kU/i
         jSdXDCp4p+Fpf4ht4VT3876mfu39Ju/ZoclCX354ybXgVmDlYRRINbKsgsYSTTRmuF5Q
         AWTg==
X-Forwarded-Encrypted: i=1; AJvYcCWU87brImZ4/NodJxQ2CBcwRd299VM4EBOOuRaTcRqR7XLwgyM34CZoWTlH2z6u9We8ABjABJ6n@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd3BYpXa/Wa5AZMV59hsng5QfD36JE5QIGWrSQIrjX2ykYqSCK
	o9MCnGS5XMtOXMwbJrDjxtFkiDKHO9JUu4jF3QHZu2cPmMiQgB7Sm1HK0BVjtA==
X-Gm-Gg: ASbGnctZgwgx0VB63MdmcECLzfZWRmg/PLy6rDqbeQOaIOvRmGMsOIs/xvzcUf53Sbx
	2W8sWZD7V0HfvDzPRk2vlNr8bG5fmVsr0kNFV2QlyAYzu5bqmR26wOUACKvioIhtZWoxC0jjlvA
	31eKrDladJPQBFnBNWycynpX1wNx1wk/7Tv37Gh5q6UN5geP7t2D3adSFvuZ687lQ8kigoUwBHW
	WMRsYAqMCT/9hD36SsS4lG+SCgG8MVDAHHZ0hLk0Vus2nw5g5DmW5R212FkUPCEYi2p07whbnmE
	Gd8gnOVT85po0U5fsYBY7OMF2p9gtSpR+m9y4E/sUwUVkzWMwxsSQ4hj6NKTF2T9ufCkN6vxGHF
	dp5rH13hiKQ==
X-Google-Smtp-Source: AGHT+IESHnGzNmRVVfPacCj/vkxRHpaeuMhAwSPmcfan8bf0MsKhilZAB1P0leX7AFd/wHfREf45Ng==
X-Received: by 2002:a05:6214:500f:b0:6e8:fad6:7104 with SMTP id 6a1803df08f44-6f0e5bf7a6bmr258306d6.35.1744224822725;
        Wed, 09 Apr 2025 11:53:42 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de970d77sm10619256d6.28.2025.04.09.11.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:42 -0700 (PDT)
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
Subject: [RFC PATCH 14/29] lsm: add missing function header comment blocks in lsm_init.c
Date: Wed,  9 Apr 2025 14:49:59 -0400
Message-ID: <20250409185019.238841-45-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=903; i=paul@paul-moore.com; h=from:subject; bh=J8s0MQCX1rti68StIWFgrsqpocBfi5qZEsksUWpZxis=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sG+swr7AIcKgsrGNx3b01lMOqA9ckaYbHdkB tLPkjbIOgqJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bBvgAKCRDqIPLalzeJ c4pOD/4iwZ5xEcGorjH8fqDkC59PW1O43qMZWH+uIU1ASOYZSRvLBdrI9VWc5pmswdaw+LgRNWj 3/4F65Osb4v+kK/qHueTrOgEJLjnhhiDANNtGTrgDRHCRSVSStyACKJCYnpJSgfFYLkGMWegURP CtsszZ/hlTxAI+kH2NYeV01p2H1w/bq2c8zq00xS127hDmPBNJ13L2ZWRF//pdUL2W+ixSAKeFB KThZCVFxS2/4sk6s+LBz6Z/D7D8MsQOPvw1bhVWnQP9Ro6jwKo/sYz7fOZnxraMY9yzgyczCVhE I+JkJ3WhDmD9MWdDPWZIZtRqT+AatuEATTHNaml/tvcEKw336cYdSYz/Yoz5e5StQD/C9rLyDAq YVvdXkJEbYN2zlFOJi7oc9STtDQjEzM5DFzIu8aZa7H5RoeRNfdAEiHr+iIZN25Enx5AWjGXEwu OkYLvDxCS4LyJQJ5sKMHN9g0yPlFaRezAdmxGOAjBKWxNaI5bbooB/Fjt9HAHXh2J84IHctuf6Z AjzQ3WnlfZH3xU7kvRhXhkE6ilZdaJQk/JlDTqWlJAaMigj9O84wJ9BU+6z2bgyLbfqWTAS8KnR dA4T+Ohu5ibbuaAgW18KQRbiQIZda+/B0gA8xQ0ooXUz1vyxM+y18jVW2pT7czR8AyHvrUWvc3S jE9TGSeQuAzCq7A==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 55b3fa82db76..04b1f5e760b1 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -313,6 +313,10 @@ static void __init lsm_init_single(struct lsm_info *lsm)
 	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
 }
 
+/**
+ * lsm_static_call_init - Initialize a LSM's static calls
+ * @hl: LSM hook list
+ */
 static void __init lsm_static_call_init(struct security_hook_list *hl)
 {
 	struct lsm_static_call *scall = hl->scalls;
@@ -351,6 +355,9 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	}
 }
 
+/**
+ * early_security_init - Initialize the early LSMs
+ */
 int __init early_security_init(void)
 {
 	struct lsm_info *lsm;
-- 
2.49.0

