Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E981F152E
	for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 21:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814585; cv=none; b=VjKFes+WbDP0nkJ706vDLznAvuLrzf2y+MjrUKCIZ8uhlpuQ4IMt6ql9V6ZQkNx1a2cW9dby8aeUg2e0yubDr+MJw5JIuITvRqpY7m1rwJkaBAqN4xdjNWcd7k9BsrEyVa0RAoM3/McrTjgqrQTm1HcAKEM59TGbGq1lMe+KIqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814585; c=relaxed/simple;
	bh=G2e3iolvH9qEslV/akG34i7cS7UuqJvA1p2iiSDOzVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhaugzNKzONpShAQqb8jx8S9QScLzkT3LehbpKfyKM9mWgSiDPSf42jiR/Bi59iKcmGbNnEkcPafX/Cp38+MTJGoMx8zXsI5D1qwythFH8d4msMVqCEsnWf+EK16znWOuo9X1BNp3ErHnb4SZVWUlUqmnIi4ljGTWu58hyvu6wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=e8JsmYR+; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="e8JsmYR+"
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 740BB3F717
	for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 21:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814576;
	bh=yf0KmmK+2JCiuqTR1dE5uJSectdXjdHO7BaOi/Ze5/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=e8JsmYR+bmqnDO8ig/JUHN+ga3YznlIadNIojqds0ZG1L7WDRwkxHIzpzFsneg+E5
	 0srcB3RsuXrVQ5MG3MWonPvlf8gfMjjod2u4SMJ1jKnC0UuERRgmiAAHp8yoB2HPqZ
	 OxVkH+9w2zXikhY0F60PuuRqZ8yIxDBNw270dYrgm8x5ikmqkOuzFuopIOVY+vBCWl
	 2kfer8F4Vb1RE2Bndr4A8Gvfo81TDQvmFaoy3spv8NzsLJOeWyRc6y7rGm46EJwmsh
	 c5kDw25JpC45ZMERGVjT1glEyxSBt7zUpxa9mPK25tYo4HOZVYsTDlJ0RimYfqc0Av
	 HWF62R3YHdccw==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2ff64898e2aso2105922a91.1
        for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 14:22:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814574; x=1742419374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yf0KmmK+2JCiuqTR1dE5uJSectdXjdHO7BaOi/Ze5/Q=;
        b=xSh5FZ6jmLSriOAqDv5WWqW9Ij1w160PXMvsQ3W1M3ewgmI2sxhEsRKnsgsSmI/NLB
         P8ZkZtOLVDiu69vR1MKfjLypC4pHmXTfccEoZcL0Xh//DMCb22KWsOfW09wRVYBXsv/I
         P3dj5090FLBoKFmfS5Us3Hraqn/GR7K4WcG3gVRT8L3sDmGHSqmeY8nCG6pX8gINVync
         QVilGuzzQyxv5MsXdCPwHcRD4SWX+o/AX85+NJSFM0hwvpziZY70SYCgxVpJS1TgC9vu
         pbvKKwLVeWaQKOhYdTEiPX1hKV/HmTzCx9wbe9fWDujdLT3PSzlZSRkfmn9UvduEP+A2
         ZqBA==
X-Forwarded-Encrypted: i=1; AJvYcCWOR7D6da484/txn8drp7jR9QVN45glv4kGiw2Ix8eP7wARxEZvXxGlo6h5AcsVNmSxEdDPUp2P@vger.kernel.org
X-Gm-Message-State: AOJu0YyRonlBZIcU+i+zQlJvUfrRm8KrZhN1eQ5qwAS7Dad0eyz0IopW
	RIDf4imLFhNgs5tTCbZrxvSOuPpIJa1bTLmmgVBdtxiNJDnBN3PKeZeItz9DOouHde1xpd/HP4m
	+NG5aJx7IdOBZ4bNiw/nqUb91f5WYyLnPcCRvCxlBzdmuqbK//1vhJBxUazv88biTpNzHTKk=
X-Gm-Gg: ASbGnct5dQFWZa30cGndAom5rKm5y/s3XNkFVH2CR0f6gaepHBmndaXmbiHIfCt81oe
	AKHxH1b8RZoi5FB+5lE4QAXXTAjfsGt2O8nptvvVDohxoNzHAHFtXj604CuJze+dCb1JiHBUTT1
	Hnez8VRWwT3vOkT0mJrEvzy7TdDvLFY6jUxaiC6IAo57wC37kx4iffd+OyYpWGlsCYaNZ7mJB2s
	CN7QHdr/Rxts97MizAYTGvHl4iX1baEGwMAAOt6Bci8+8roBEimrhiBkwgZakERkc6TviYOb0Rj
	jo5q+fC0LuyQeLoHGcifFMVNaRHrHMtw3ima1plgq2Vw1Fxi+h7dPX2S03Wl+tqkOAhskxU=
X-Received: by 2002:a17:90b:3bce:b0:2ef:ad48:7175 with SMTP id 98e67ed59e1d1-30135f6037cmr88387a91.15.1741814573785;
        Wed, 12 Mar 2025 14:22:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwAw+1MiMC/B8BNZEJ4oppU1sIELS1vCTl7SNsacHdi/KdGlgg9CgoB/KGdKxX2Zf2vFxSyQ==
X-Received: by 2002:a17:90b:3bce:b0:2ef:ad48:7175 with SMTP id 98e67ed59e1d1-30135f6037cmr88319a91.15.1741814572564;
        Wed, 12 Mar 2025 14:22:52 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:52 -0700 (PDT)
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
Subject: [RFC PATCH 5/6] smack: explicitly skip mediation of O_PATH file descriptors
Date: Wed, 12 Mar 2025 14:21:45 -0700
Message-ID: <20250312212148.274205-6-ryan.lee@canonical.com>
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

Now that O_PATH fds are being passed to the file_open hook,
unconditionally skip mediation of them to preserve existing behavior.

Signed-off-by: Ryan Lee <ryan.lee@canonical.com>
---
 security/smack/smack_lsm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 2f65eb392bc0..c05e223bfb33 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -2062,6 +2062,10 @@ static int smack_file_open(struct file *file)
 	struct smk_audit_info ad;
 	int rc;
 
+	/* Preserve the behavior of O_PATH fd creation not being mediated */
+	if (file->f_flags & O_PATH)
+		return 0;
+
 	smk_ad_init(&ad, __func__, LSM_AUDIT_DATA_PATH);
 	smk_ad_setfield_u_fs_path(&ad, file->f_path);
 	rc = smk_tskacc(tsp, smk_of_inode(inode), MAY_READ, &ad);
-- 
2.43.0

base-kernel: v6.14-rc6
