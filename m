Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CE827C17D
	for <selinux@vger.kernel.org>; Wed,  9 Apr 2025 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224833; cv=none; b=H4Xf4IiTo4bNeyMzVGZVCOXNtJROQ6DrH+LVzyVHYv57fbeirk35uMUZqsD01pA6dNvXv4rwNCcThVK4EhC/RyYdfETrJb58ojkvXbyHMuYmKBJCd6Bma5MXdWkpJ4BgTLgMQbmF/TBCekHghBd9V7DFZRUq1vL5FvSZqkwum6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224833; c=relaxed/simple;
	bh=ncP3ipv/bV6iSyC9l86b4mFrIDnsVn2iRTu/Di2SXUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpop+lz+H40BhlO/ui+gynb30AfHNStw1rKgARfWxIC9VJDGt0srD6exfkHRYq5tnjY79q+6by+ph7vodn4aV/DWa9dcKRJ+Idb/zRDByeEPUfy3dGO4ZovpuwYt+Zvy/G5PQCTlBjNbAi/V7QeXeHjWH6M8rxlc9VP7cxdA/1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=W/LggYET; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="W/LggYET"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6ecfc7ed0c1so60375306d6.3
        for <selinux@vger.kernel.org>; Wed, 09 Apr 2025 11:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224829; x=1744829629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sXS9/0vT6l4p41gXbqSfGFGiz2UswVqMs3yG5LFyNk=;
        b=W/LggYETnLpTLb0g9Ue+wdRfslprOAjhBy0PNhyciVkcc/uALWRtz5g0h04B5rZFLx
         YxOEpPJ2bGxIdC5Sn573x7txiQoOtn8AEwsFwiuNYVwsfgsmOBUvPaO0gESZmmG8duMZ
         4l+ECvAUg9uWuVzaV3wOMr0rVsVmL/benCYs4E9Ym7YWmh0+g0Nc55vX4pU5Cf0CGpbG
         yLUJSVJTyuDvyHstM/GSThZiYwW+6bN3U/p/cBzjO6Pbn+YfjDx1YERKjPNZjpAOMHDn
         4weI12tTh1AV5ueWM/8KryXOZqh0PpLn2bip5BjQIv1SgbLOp7wI095LHGtP/cPbHkj7
         DLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224829; x=1744829629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sXS9/0vT6l4p41gXbqSfGFGiz2UswVqMs3yG5LFyNk=;
        b=OvFefY+Hh2gFgpndt9rgvnJMxTtWFTknabx1s3TcEM4CjIRDQFcmoD3iLq7Lg3M7LU
         Yjyt+OR8Vxioyk1qNoZEllGLi3eWerMXEVhPW2YQxiCvNthsa2cVNptW8l62HeeDASSf
         5/+gEG1ZuaCBGc06t4b2b1OKuZBiEXTmf29k8YnIH9duoE+FelMHXL+yERwgwCrjHFDU
         /R2wRJVuxY0YRutU9VCK0yz+BAqly6poX9kE7ro6pGyWfJKsQsTdcF4gj7TZR9S1iGzz
         ri2nvDDRk47KeVuO7tc+a+GwP6FOFKcYuhzgAz4WZmwHFrSOK5I4ooANCogGwLEGiUap
         ldew==
X-Forwarded-Encrypted: i=1; AJvYcCWXom1MJ75hxyv9UYUhUwmb0Z/EXbPy7716fConQ+4lyAfz4VB89BJPuFiN8xSc2Z/jPePpEgXL@vger.kernel.org
X-Gm-Message-State: AOJu0YwibwAoUL0ESTEISmS1dE6UG5TUaV1OHWEQaGNismB932t7QJnq
	4Rv3Ik6NVeSsIyZxyGUtHe6Jl7Q1cJffH7qdQjj2zaE456qjI6+yRU9ziEv1xQ==
X-Gm-Gg: ASbGncvOvNAznKFTa6evN15d0yfhvlW1SVBBbpzrxlbpW0585LFZjChS0UCUpGrgSas
	Ff+Q5Aga657eNGlPmXdjYnH3htglg0wOz4Jw7co+coT0/fDYiJsanxdCHiGVeEZlVB4o/bnJqEQ
	km/fMflgge93w9JLm8Gyfpq+TVzWY3OfHVy+f3oaezRsDOLSIThef+PYT8PHg4vUNB5AQA4rQu8
	VIpCpZCpn5w/MJLu6z+ARs8tVWEPj9bN4anSyiXlN0zpFZI5SeXje5FW7j/IHXMjQ7Ih+gMuxEX
	IsqHuMw/blHt7txpxzMrv3S3tzUlGhh7Jvn9Tmiu6v1+7NsF3Ph8X4go7a1WgHbs8rire1vViqD
	TceXrzejufEEF7l+Rasn2
X-Google-Smtp-Source: AGHT+IGikOQWcj33KIm5rOskseWH/Yr6wXc7U+ofTbx3SIVskx7NHnm6yUKGbKIPuI6qNIrMd7NHZA==
X-Received: by 2002:a05:6214:d8d:b0:6e8:f166:b19e with SMTP id 6a1803df08f44-6f0e5a7764fmr726926d6.17.1744224829253;
        Wed, 09 Apr 2025 11:53:49 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de95f8besm10578896d6.10.2025.04.09.11.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:48 -0700 (PDT)
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
Subject: [RFC PATCH 21/29] tomoyo: move initcalls to the LSM framework
Date: Wed,  9 Apr 2025 14:50:06 -0400
Message-ID: <20250409185019.238841-52-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1727; i=paul@paul-moore.com; h=from:subject; bh=ncP3ipv/bV6iSyC9l86b4mFrIDnsVn2iRTu/Di2SXUk=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sHoju/juiH/zVZi9WwQKm+CMvHYUamYCfM6H 9mASMylxUOJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bB6AAKCRDqIPLalzeJ c/WbEADf0j6M1iz4BcrNyNfco3AIMMOUeG94gDrwdaYGx0kQ26rRMWRKjyseQ6+Kn6ZAJzATNzT SHBx+ON6VTqMHm8cVtMET2Es0dOVG8ZBf7NF2e4WPP5KfROq7OI7YGMzZLBhHP/UOilArfMT5Iy GqMpA8Hx1LEoC2rxvxtZqVcLMuiBWW7jn4ta/L/0+W25JAmhHY4+G+HFXOFOuCDxPy/4Ru2X33F oMA0GQQVsTWKRIZSBRZZNHrLGWNYHoSGYRNygbf25G3AbE3pvr+Kg4mmtdi61IXtFriUEIMVzHB V57rkGShdnV88dG3FM2farEGXWwkB0hsTLDkWxmH8PL0KyRqvKEYM81U/dpg/Od0qW1IdD+hUy6 oPiRuvdBounRwNQTK0GCGvbY+Ub49xOvgI09tg9Dw8sDFlNdT7kfV9DjIYPsDKYBkMxuhFDTI0Z +vFa0rb3awovFPra5a9LA2EViyasxmzDUP+C1ukFdc3MhmPPFNuc4dsb9QqsbujhNzhpMrGj1TH WHOawO5bhZ5mtdPKoNQgB5yf2GLZcwHH9YPhMlNINkFcNnyTTjjEBF8P774dYasB9ReTykiyZ5Y 42Cb7gikVJg8rbZF5aWuyOgsSvLtnrFG1zeg+c3TnwQ7diJx8j+mXG5ZN5zqBaJiLphX4tNu/dV bvkltXm/UQgAU4A==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/tomoyo/common.h        | 2 ++
 security/tomoyo/securityfs_if.c | 4 +---
 security/tomoyo/tomoyo.c        | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index 0e8e2e959aef..3b2a97d10a5d 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -924,6 +924,8 @@ struct tomoyo_task {
 
 /********** Function prototypes. **********/
 
+int tomoyo_interface_init(void);
+
 bool tomoyo_address_matches_group(const bool is_ipv6, const __be32 *address,
 				  const struct tomoyo_group *group);
 bool tomoyo_compare_number_union(const unsigned long value,
diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
index 7e69747b2f77..33933645f5b9 100644
--- a/security/tomoyo/securityfs_if.c
+++ b/security/tomoyo/securityfs_if.c
@@ -233,7 +233,7 @@ static void __init tomoyo_create_entry(const char *name, const umode_t mode,
  *
  * Returns 0.
  */
-static int __init tomoyo_interface_init(void)
+int __init tomoyo_interface_init(void)
 {
 	struct tomoyo_domain_info *domain;
 	struct dentry *tomoyo_dir;
@@ -269,5 +269,3 @@ static int __init tomoyo_interface_init(void)
 	tomoyo_load_builtin_policy();
 	return 0;
 }
-
-fs_initcall(tomoyo_interface_init);
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index ed0f7b052a85..a015cf0c4a00 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -617,4 +617,5 @@ DEFINE_LSM(tomoyo) = {
 	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.blobs = &tomoyo_blob_sizes,
 	.init = tomoyo_init,
+	.initcall_fs = tomoyo_interface_init,
 };
-- 
2.49.0

