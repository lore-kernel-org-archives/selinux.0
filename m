Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0355227C860
	for <selinux@vger.kernel.org>; Wed,  9 Apr 2025 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224834; cv=none; b=X39H39c4CQYGZvL2helmaSZtorM+XU8u3n6+O/9K7hhvJHsL5epK0c8B/77Jw4ovToXiPVsk7mMPDFWbQt9NLe1K4ClokaRhBnAfx4x9XsORqVDTk7hPLPswhD+vMsoVe2S6nkLcFDr5G+Y0G4X+1ZYvuChyMSwlRYxoVRxtbYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224834; c=relaxed/simple;
	bh=MkPoYwIG4TinjPfNk0EXrsRLK59ADeRUmFIT97JZOE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9vRqATdw+yXQ2xVLZ7G67OO7TsFk2OcJZCjz235B2E3EHcM6ZdEI1YGjOwy+awxgykv+cwv2TH++U73oGIRhnummp4Pt3t0zYoXxEUDZWyz89piO93buY5ihO4FWlgTKIKimVpZWG9ZezFLMRN/uXYdugn5QhZAfIMgDBXmI/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=B4B8KgAN; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="B4B8KgAN"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4769bbc21b0so63935651cf.2
        for <selinux@vger.kernel.org>; Wed, 09 Apr 2025 11:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224832; x=1744829632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpBxHpsE71g/suNoRLUwEmP3N3oQiPkN9k6/6tTBThM=;
        b=B4B8KgANTO2yMHa4TLnCd7wW9aprQd1uLNDJqAGyqZttnLaxWL9lv7pxK/OfibSkpF
         2IZAosKKF44VVLw3o+Ue9afWSUy2g9LDKaa3JyOCsRsY92f6S8bFjcuT0VYbiajqzb+d
         HYkaYUx/gX4kzY6Yr5uQTcepv0zlFp7aJ9rIQVKlIIjhBkmUa6Qp2dZJ8HlzYX7ZMJpu
         xqM1gXbaW/BMqE4Yw1Cvi66D4kvr5PBHE/rhsZi5AaWUsaiT36wjy1xV+rTdFJMkI9C3
         QQUl+hK3d3wHEwORezgDTZp3MA7mrBarFVXwv6P0FlojDv1DOj/+h+ji6wdZg2zTkMuu
         uHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224832; x=1744829632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpBxHpsE71g/suNoRLUwEmP3N3oQiPkN9k6/6tTBThM=;
        b=IKC7iRkOtwlUK7+EEflUhRbn5gt/3mPiBHUepaNENY0R2UVZ6/aTv/l1LRH3smtOxX
         8oxOIy8llPiLDzyetJTtByx8V7Irq+63ZGXOpa4B9x6KCfcNJd5J9hXg0qn8imN7P1fB
         x+fba+4c8H0ia9BinrXKIE8I75qUg9O68h+GYyIy14OnxxLGvn65iMJTedvISdVIm1BK
         B2xYbN851OoKGP9lFRMNYktwYS7mkzbbUQxn0B7ughprLcn3G4qtC4rrYPxmjxCzldVX
         QjCW3oBSDiTHb/4pKtvs9T9auUAadY+makepJ22xLjooYeneDYG6LgnwL+qPYWsb0L4V
         oE4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVUbBLAuoaTwuRqSsUhnkKScyviba+VBcqNZ/LW8CUzQtVzwo0UeO2QTnWf8T+oBIa+rdzqkkJe@vger.kernel.org
X-Gm-Message-State: AOJu0YwC4AVuUMpN0MpEsFIqFo4rlS5lsgLBpGC1xBWE1bwX6YEYlIaw
	+IlJNj6qDH9fAFJ4CRVFXSYRj6Rl2TtmfLmUS6rYA6XJFg9i9TnIwr9ShQAQ6g==
X-Gm-Gg: ASbGnctZLWluYnsIq0xcsVLyl0EK2gXkxueftKCoG13eh6BEDgyAy17xwNqRFtg++9M
	Ma7HQt6Om9M5MX5wEu8LQsM+NazEalJ24H6HI+BKYY4ta4L67qOlhFMOGfSR8EHNOLg3fFLsMdj
	ClzpZmYU0W7ouz1qunoaLyWw8r1DSehImlI0L06cdw83e1zUH80dC87djkUGMv8GlepJtAgzJkJ
	afkR07kFPCPioA7fd9AwcgK7hZnamE1XToSeynbNLfqWwovOHCiPflAnKV6f7FLvt0W5Zac0fAY
	+uE8iO7D8Kx2/w0pmg8k+HQ8vlnCDwJuS8kk61n3NCX2stbgtaiu1PiCwNP2k77w0DA2m7odVJO
	GzCH6ODbkoQ==
X-Google-Smtp-Source: AGHT+IGKjEcW8b/8GPzhZUHT1zNIKNgDIj/v7fuhXJr44NKDkgr4AuVO0W+EG6FcVrakZVdFk11qZA==
X-Received: by 2002:ac8:5844:0:b0:476:80ce:a61f with SMTP id d75a77b69052e-4795f3598ffmr68385611cf.39.1744224832022;
        Wed, 09 Apr 2025 11:53:52 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47964da3c4asm10539011cf.21.2025.04.09.11.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:51 -0700 (PDT)
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
Subject: [RFC PATCH 24/29] lockdown: move initcalls to the LSM framework
Date: Wed,  9 Apr 2025 14:50:09 -0400
Message-ID: <20250409185019.238841-55-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=734; i=paul@paul-moore.com; h=from:subject; bh=MkPoYwIG4TinjPfNk0EXrsRLK59ADeRUmFIT97JZOE0=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sH7zz2TyyNFtvO3UgRZnEV312ilpaAUNyWAI hQx5NGZYJCJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bB+wAKCRDqIPLalzeJ cwNwEACfZo0wxnpfxkfjEszjRYFP9SCK/ie6gsYwcnTay9PKHXK8dv/Z4Hkt3MEWRmw3yIhWk2x 7bhGuKKRKWE4yrAbvkiEtFiApt10TVNU8JbiwrAJ6tVn2P47KPw0xGf70X5FLCvTKepz/k6+n9h D9jcyIOM5XE5nOUB6ojFqnLxOH/6C1QbrYBsg9238A1T1MVqk438tnlXYt1vQ5shxMM5nMYRGjQ yLAFBk9r5KP6f81vUEOVBA9gi2FgAYt1tWfUxWlOdUmTb7b0zAH/FL5K3Hga5NWgt2L/sr8D4Yb jBSh0HFxlXRGUe+ImUxEmqjZAREIwIP6KZuN4Q1hItmkTijpeY30koe3NF+o3f1+M/NvlC/I6xw alM7u43vHu5uP+1ehpTTS4VkdeDfv2a5Z86Mk/fZ7c0k+gDkaDBIuFEpnDuIGKxeoRZkIUut7zH kNg1TRNxeU4HxyJ9kSvhuX+VzgunlavA7XD6KFeQA3rrscdJPiLTQPT+NKxCKxrJ+7MxO5WKkCM ovXoKMxLPvHVbTbBYiPkhmOUEOsBcCQie+JGS6MTZSQlgyqAH3/l9O/s19FdSZO4OeAHQyGZb0U rt9tBhntZiEZ4EzbFllxU1uO+BhsfCtmhPWzQpWqYdAeSXS94BWyheG32ouvcy9XiUH1co/8qVn uNrcYeQ+acXJCew==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

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
2.49.0

