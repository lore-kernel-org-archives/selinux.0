Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C936C1EF091
	for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814577; cv=none; b=qvylvNj6EpE8F9YoTvOn8dMIrc68Q/yRg/Vb1TSwgcAI589Q1WfxXJn+zVuO1hhLw9zo6QYaIxSlo3g3uZXeivHlCC3QWN4379JNtDDp0tLZWDFE5/6VzNx48d5xo46EOfR5XoXkPF8uHU9CVeFTtgtGXYSWQVSZqDsKrLzDYGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814577; c=relaxed/simple;
	bh=mvIFvWIp9NnNpqjlb78s7uPPK/9pOen0F/aXj53TS9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLEGP1P5iZ/qiZRblCFIJRKtZvurkM3WytutlCnPyGqNRgFEVH4xT8IYZH0luf2yyc73LkFKY2BA1RLpfJ4QJeecGrr7l5IcKjqxH4ZI/DOzId3B5LsNzKCvfUPO2P8bo3vRTNjrbeT6FBsgUveha/vigppWYVVufHciuyN3vXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=aYQejKLd; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="aYQejKLd"
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E71213F2B2
	for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 21:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814565;
	bh=JJCUu0nnTlIAwhQtLazst1i1S2GtJ41RAYnP5gniTzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=aYQejKLdGr5ExUmspDdnU4wPFXdH2B9XIl3jyJjix0AkrBK9MGcHnrPzRAu8tUxiD
	 CgXF22FNABlCdCQFPRkIuncmGmy1MC2ACreWoVAnL4hUfkdlb6R5PNo7hXHZ5exizm
	 nLJqAVl8zkEerBQidWAbFE061ZVDq1+HFicGaffj/wZ/1XyXXqr7ckr/I//oWYPfhY
	 PST0r1MN8uJoG2WOyw1/4gYYr8RLnWvVe4f7K6fJrf/qhrVIF2JtQcojxe2sVjJssG
	 ngO9tp/zB0TVsprWPMtZTdrE4MoIjrgFk+CTIUNt9FIacnlsZwjYuxIpr3Mn/P5zC4
	 hitZsvYit1t3Q==
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2235a1f8aadso3652765ad.2
        for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 14:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814564; x=1742419364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJCUu0nnTlIAwhQtLazst1i1S2GtJ41RAYnP5gniTzw=;
        b=PruLV/Bpk2wJJr2RtajJn5leCdB4qeJqgCVgETaGWfuxRuzr5yNA/knPuONwK4BMeV
         YirJ6XM4OHdCRaRYDXLtjrUw0ilQ7iGolqVI8YLP/C0Z3gFzCW44PrfGGkAkoaZeJXqh
         6pY0PSNN9dZ2MTeQtfukEsrT4vNPmFabfeOVE6Mrs1QJChwCJFfBcmFXmiAdB/8Fj1ok
         6gMPa4SyRwKgZdbnTUW4tgP+a4q8yRoNhlf+fjo+5AWgzbjQx6Hv51zMyQFBIpuULdp4
         X+OE6wfexfHMSk5e0wJYx8YIROUZTv57RfLRfzT62LzgknhY3YG1mk0tMd38E7q81aeZ
         KG8A==
X-Forwarded-Encrypted: i=1; AJvYcCWBtsfGITspy79ClIwt32gpY3MVY0XEoni9F0NwsJyENyak0/SDjkTM/VkSh5OtNs/b5Bjq6r1V@vger.kernel.org
X-Gm-Message-State: AOJu0YxECnzfk5nF0/VzXJaQiq0hVehyWLkHklE+mDreaBSnHbkHZxKO
	BPP+iTWSSFLFNKkZq6Lcd7ZQC3H2NndNcRKf/YDvmuMDhpZZXZ4QagS4+nG/9tHk6zce+ipt/Gp
	YY0IRLyZ/DjMMx6O6mMyabFIur2uO1A0TgWXpnkV9FHR63CmBcKgowtSR3oHUolw6hxNMJYg=
X-Gm-Gg: ASbGncvlrnJDABl7sF1W2Z6cdCxYDtB8dAoy8JL6HzMOJJF45QAs4tVB/iMWi5FlTcz
	EBzbr2IuJbM/v3Pen5cn50CGbt8bCIu+eRr/lKduErazfxUWi0P+adQVF2WRcyXEbrwpDbE8zLm
	blfezM1cSIe5pvNhkm6z4c7Vlr/AHvgCD3ytip6lVXI9g9qLPoegWChT4NoHIBLq7FKnn5vg28c
	WJHL90xBdym5GN1AC+CrLlnEWtbWgWKv609PbGJ9wxVPpu7tPioRmWOcnXEJyB5G0AHtj2oshfu
	u1QcTI5J4zUlVExTX0KvnSEynUMVhs0A3ghKE0hWeE653jTO9or2uPrqV0fe0yE+jkcs+28=
X-Received: by 2002:a17:902:ea07:b0:224:a79:5fe4 with SMTP id d9443c01a7336-2242888681cmr334106805ad.2.1741814564403;
        Wed, 12 Mar 2025 14:22:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjVvzREwSOFKw0Hfsl/h89sadLsPdTTQZ/I/XFETV/GwxC6RNVuLWxGdk5FbZ6Djc3RCsmNQ==
X-Received: by 2002:a17:902:ea07:b0:224:a79:5fe4 with SMTP id d9443c01a7336-2242888681cmr334106495ad.2.1741814564101;
        Wed, 12 Mar 2025 14:22:44 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:43 -0700 (PDT)
From: Ryan Lee <ryan.lee@canonical.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Cc: Ryan Lee <ryan.lee@canonical.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 1/6] fs: invoke LSM file_open hook in do_dentry_open for O_PATH fds as well
Date: Wed, 12 Mar 2025 14:21:41 -0700
Message-ID: <20250312212148.274205-2-ryan.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312212148.274205-1-ryan.lee@canonical.com>
References: <20250312212148.274205-1-ryan.lee@canonical.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, opening O_PATH file descriptors completely bypasses the LSM
infrastructure. Invoking the LSM file_open hook for O_PATH fds will
be necessary for e.g. mediating the fsmount() syscall.

Signed-off-by: Ryan Lee <ryan.lee@canonical.com>
---
 fs/open.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/open.c b/fs/open.c
index 30bfcddd505d..0f8542bf6cd4 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -921,8 +921,13 @@ static int do_dentry_open(struct file *f,
 	if (unlikely(f->f_flags & O_PATH)) {
 		f->f_mode = FMODE_PATH | FMODE_OPENED;
 		file_set_fsnotify_mode(f, FMODE_NONOTIFY);
 		f->f_op = &empty_fops;
-		return 0;
+		/*
+		 * do_o_path in fs/namei.c unconditionally invokes path_put
+		 * after this function returns, so don't path_put the path
+		 * upon LSM rejection of O_PATH opening
+		 */
+		return security_file_open(f);
 	}
 
 	if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) == FMODE_READ) {
-- 
2.43.0

base-kernel: v6.14-rc6
