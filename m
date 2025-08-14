Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C837C285058
	for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 22:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212102; cv=none; b=XxmJZAlo8Dus+duDNAWW/yRZmS8CjBeZKJ4ZTH5aGJmlayatRHZ3/DmsHqoB2lID8JAaiyDZx9a23W2ynzIpwId66wBxxUnMrpQx5OE9wF2ZXCuGAJEa3XDiLthN2K3ip7mdF9xcg9BFF4G2Lizj8DRZiFGMrNcuimDkE52DGI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212102; c=relaxed/simple;
	bh=URVWxfK85fttW3+Th+J6RoO8v/wxk5dtKWR/04cDVZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2+edVfGg1vdcBkCVimOz6de6I1QIx30p29egosHdhKow3sbhhOANDcHrnfpdS41j6ru4ykHFiip4FvD4EpH3RPVpJvU+M25FTJyBnnlZXA45wvlywHZd98a6SwRMMRFuw0zb1yXWai2dToSMeVnzo5jKXK1Jfoybyv5Un4WarY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NTkqa9QI; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NTkqa9QI"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b109a95f09so11108501cf.1
        for <selinux@vger.kernel.org>; Thu, 14 Aug 2025 15:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212100; x=1755816900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4D+dMcKUsP+TdRIF7gesTZPNDJ8YR+vx6kSTZ1U4BY=;
        b=NTkqa9QItvAzpM9XUZ0SPdxDiqtP6Q8/jrMyGL+AeC4tdoiwFzbTc8gZf/YXWsAznB
         tE3Wapd4O8FsPttE9jtY6+ceiiaKbQ0t/Bq22ypkpQ4v8b3yQCfLDs7T+UPfJ8uFn14Q
         2T8dBDpnleFi2F+GqyP/kps5Yncxpu/COIHBbl6jKY2hZtoMQNiT8Qd/j/vXQhdpxt/g
         TpDe4llZBRgcFzPgVl6mpr36t9Pts51/rBqaAT8Idq9ua7lrfFk3zr26OTphs8kej168
         ri8v4tSpv35u3+QmXu7rnlEsBFZ9sCf/Gf24S/pclNGrhXJly+fm2xRw+9V1Vc1BzezP
         rVXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212100; x=1755816900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4D+dMcKUsP+TdRIF7gesTZPNDJ8YR+vx6kSTZ1U4BY=;
        b=rM4TUZYTDk3vs5OocRCaZOqSd2bLz1o4rfBb+9K8QHXgAIyLdtjhciYNxKr1qTW0T+
         8K+NsoSbBnW1jWrDBPGg8rQMbqqS21xhhgCxbtoBHkmlGZyYYuPalQdiwC64YWggcKWR
         R51c2pFkQ2TImbBsmR8dFX9xquhlKkvcZ0YMFc4Vl+K5375Nut76Xyvyb/yWdkFJ1TKz
         4PI31jZy9XF6UJMVBrQqusdOngW97ZG4CnEcFqKwHCAxNue1Dg/lrxbjXs+otZQqCmaw
         MctUaPrdJ+IswxUAxOiNPHg/PzYyrNo7H7TGZ9Bkm2lU5R+LUjb2j70fG7iK6THuP70J
         zcjw==
X-Forwarded-Encrypted: i=1; AJvYcCXkHZDTCSmBh+Q6mApdPQEGCRhItApKh4zxv7L/aOlDGWlR089Ag2SuU0+yP3FfADa6QsDqhgNc@vger.kernel.org
X-Gm-Message-State: AOJu0Yze5FLk9M+mZs8FiTKk7G9g5l6Lf5Cn+V90fAwedaVvSTbi8nFE
	gTuVTN5sVmEiz/xMnCZsm0+cU8nKToIj880vhIu6MWpJgs0YvngKV1wNkxSHacP6UQ==
X-Gm-Gg: ASbGnct2mMD2D1szCxYiLaRbTn2DDbGCmUEUSeBKwQbiOJIubgEb6L9hPwwC1xwGdCQ
	LJ0fQoWXn0iiVZ6cmbRpL5LDqBgG4Oji7rqE99FAbHGgxzCc0sX/txXyipaE0DSzm45WTRP2pie
	RZtLu+u2ttmFKdDASWs3eVbEeHKLjDrlV1ZlDEf1bZ+nlHSnRTAXnF8anodiJkJKHkCw3LDW3Cd
	e1DXlgknrK9zEnPze/Fn1jhjvF2ADqRxFY8s/kdYPX7FP/w9Kije1/ToJxLIlWNDXqC9Ef0aijv
	/HXpqWHV1tfbxQ3LCDLQoBOoeN7nu2wpbqIA8FAtwlHFVynyiLVLMRQl/Ozs6pBAlg3Q3NV1rsV
	m0qf6VxyzaMe/tozb8nOKZ577p7iIxnkxdxD6twOAnoPUy0pfsrlmvIKAT+0JDxaqG0FsLytSOh
	TI7g==
X-Google-Smtp-Source: AGHT+IEEDKJm+l79Dx5z529UddvGnLjKvYxEwgpaywZhanewYGh2aS0aUs91oxzAAMjw0E1QYschiA==
X-Received: by 2002:ac8:594a:0:b0:4b0:7435:4243 with SMTP id d75a77b69052e-4b10ab02801mr62861771cf.49.1755212099684;
        Thu, 14 Aug 2025 15:54:59 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b11aa11d85sm2325431cf.35.2025.08.14.15.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:58 -0700 (PDT)
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
Subject: [PATCH v3 30/34] lockdown: move initcalls to the LSM framework
Date: Thu, 14 Aug 2025 18:50:39 -0400
Message-ID: <20250814225159.275901-66-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=825; i=paul@paul-moore.com; h=from:subject; bh=URVWxfK85fttW3+Th+J6RoO8v/wxk5dtKWR/04cDVZ4=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmjuthZ1t1lTxmuY+UtzM+a7e6/s2EZ6P5DW0 Or7Vw5YKZ2JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5o7gAKCRDqIPLalzeJ c5fpEADDTwwkicUA6WRpdxsVirRfXxD6DnrC4rPBYSNiF2GMMN8k+zQOa4fetmFb3trSpXcJI0K z0UtocoE7nNyfqat072Ynfy9vQUz4kkMouvklXBUcJhVIXmmBP7q5+9i2zsLV9TBFdcpUsWkk31 D6MjthQPLEKfch0QlXHiWohjzWqu8o8oQ7QMqVHoLvXrEDeiHimACEoQQNMkZQ3O4M5gmeeJOnB uL1BVA4VqcB8HQZCqHjOt0QJCTmLuhZiuSHz5ytlHgkTF4CddZXRE4LDc2oG4vBGIZNuIATfVNP S/vVIlbm8qX49wYD7hocVRgmKSgWjvSa4RTbm5NZYl3f9o+21QUClU+pFMMP7mYE6vhG/E0tTU3 NHt07Q30kQJQh1mKxHy80g/acZzX6aZ3hMFqnoRZDZXSfbbkLylqPeouvDyi+2bQrUW5QlsIj83 UIl7O7adtvjLvTXBeM6WRTMF0z2wTGt6Xdba6ZT07PUEy8GNP1CvAlStz7QjAJynILqvjcuJeUW FEKdx14QdCPieNAuxOBN3VcjarXqGhe3Pc5pjNGabWCdQdcGRM03RO+2l9GkvIcOm8QzgEm0hBo jUNF+yzJAtbel0vjD46jenD8akmIhs+txWQ4mJGW1LYozW9xTC+WS2cx04DMg6xZKhdRDq2WFS7 Fi9SVYD4IrJoxVQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Acked-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lockdown/lockdown.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 4813f168ff93..8d46886d2cca 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -161,8 +161,6 @@ static int __init lockdown_secfs_init(void)
 	return PTR_ERR_OR_ZERO(dentry);
 }
 
-core_initcall(lockdown_secfs_init);
-
 #ifdef CONFIG_SECURITY_LOCKDOWN_LSM_EARLY
 DEFINE_EARLY_LSM(lockdown) = {
 #else
@@ -170,4 +168,5 @@ DEFINE_LSM(lockdown) = {
 #endif
 	.id = &lockdown_lsmid,
 	.init = lockdown_lsm_init,
+	.initcall_core = lockdown_secfs_init,
 };
-- 
2.50.1

