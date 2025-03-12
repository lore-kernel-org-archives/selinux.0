Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D728F1EF09C
	for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814578; cv=none; b=Xbq8Cj7gHLvLp0qDpwRykKj8w3iRBGLgQdlpajv2jbW+6cPF9FWA+f19kYGy16DoaqhicMtjeEEHhIyiiOjyuhuDNXlb1KvuMXBm4hPbk0Q4Rms1mnlZl3ICB/0ZD7Dc5d9ZuOQnBthm3MRZt8z5yz/Xlup53JXPDPq1IOfMt/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814578; c=relaxed/simple;
	bh=6cBhe/0J0x7XG16Ij8KWWPYPemaK8pVTxylYk+O6p0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BVRXbOKbvz2ZqDILgXm9LIjcPlGpjkM5kqQsTFkhpM0K3Dgqts9Bf6/XEYX7c/hfBR7Gug9377fEqYhFSIz5M/2Y+wv8OVZg+7XEp/+WPUSoOHDu3taDN0p07ZGqD1LhiQGfVvUGh2UovjFuDmyUXlS6bAzxorGm83P1IZeHoLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Rc1pNXbF; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Rc1pNXbF"
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E66953F2C4
	for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 21:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1741814563;
	bh=UYHE7PfrFzAetCRzPVVNsPinECVfo2Zm0WG/ZDMIyJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=Rc1pNXbFbnXXCbTzwMpSkrJv9F+x6BA5D2j9tVs9bxHaaOP4BoMneWMVkCzwLrRy8
	 4WunHHnuh+eTZghZZI9PZXrKjPeVPfOOFB5V4ef0D05pbWwmbarOQ9u2c6bazz5A+O
	 oLKtEWr7+pdiZEJrzWL/m9edy983t18LjHo8oZOVt0jpo4HnVFXmHmN2lMCgWoXU2N
	 kpW8goWoxVlE9pY4GF5RIBymc4B5G2CIwLrMsnaNwM2ztsModpVt0S+x/JJkS590+G
	 frN21DvvN4WsboKU4MixRfr7VXhM9xIZ3QJJr+9TfXvqJV9EGrU8ZHELYC4Pi31/J9
	 qS0jv52lhsDCA==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3010db05acfso462951a91.3
        for <selinux@vger.kernel.org>; Wed, 12 Mar 2025 14:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814562; x=1742419362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UYHE7PfrFzAetCRzPVVNsPinECVfo2Zm0WG/ZDMIyJE=;
        b=JGmcaaigXT9TxIYUp0kQHX90OlnqS4cnTBfGuw9j9oGBVsUFyUIiXe7S+Pk+Jp9SV6
         BTtW6EQZSwMP0yDCNUyfjfqTweX4GifVP9YVZN/RTftveKwPtcl3ZlcXgabynlOqgi3Z
         tL5OKztN7xg0DwsDIvskI84tknL62ACpA9AdbvrpuW8ukbU6hIhZUBqX1DWjKLqOXeBx
         VulQglCnciErtxh85oezUGc2J/a3ikfqMhB7ur7paOVmLwoTmQXeg7aOF4LBuy+4JdWu
         NGlUBnR8f1BItqYaWLVL7HWmrKT8Fv8tJFn9azGHAE7H0zpU2nmZ5ewybSBq7JZocePN
         FxjA==
X-Forwarded-Encrypted: i=1; AJvYcCUiLO67RoFcIysB9M8nMxWVC8Ti68FuBkfqj4N6BkoSg8T5CfsobHttudpHJF2WxB5IWC6M2riZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwELHOtbL04dt2E0tT/BOC17jZEV1BueOjETziyC5xIwSGPSXm4
	0q6X33l2v6/Nfa2bOoCv1ctuKt1o5GJQnZJEnyS0pKd86IY9NTccF1L/oc9FcVrAYP1HRe2m6Jv
	Z2YDdkcg1tdqUHR/oEyeaskxzafK7SZYCEj5hXeIdpBGXvpvrxuE0ILHH5QZ4QVBhtOtCtJ0=
X-Gm-Gg: ASbGncsNL4+msm43sBQq8ao0bOrsCzFoUqIA38/dzGRhsvHOICEbfddDViCH5sG2X/F
	UTlNL+wSzRX8Jalmv7heCZtqfwHMZpHjYdgthSA1unrYw9xkSptmfULubpIKSLFmxCha+0hYEnW
	NPaxLCpDqkN5zNl8ucVOkImS9/HkATtOIHEUbNoJN0uOVkacphxfuLedRGiqTs7klRSbk0Ye2UA
	w+nVbTS7bV6mBy+XLceChyWkCY6Ev7UUr47MV1RbQB+q/YGcqkCONAJBfzahn+W4XZIwxcsqZUW
	9j0jSLUTRoCTsVNpoh9WIJ/DAjfZOrseFu8E41y+ShUrlYh9/j33Fv9fNr8q3aG8aPSSl1o=
X-Received: by 2002:a17:90b:1d8c:b0:2ee:f677:aa14 with SMTP id 98e67ed59e1d1-2ff7ce6ff9dmr33955134a91.13.1741814562178;
        Wed, 12 Mar 2025 14:22:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESqd74aQLaRYMlhUC52mOCTMPtX58VJpqPHYNlhWsmVgCtfWUR4bux5MtYAMon8vBiSS29gA==
X-Received: by 2002:a17:90b:1d8c:b0:2ee:f677:aa14 with SMTP id 98e67ed59e1d1-2ff7ce6ff9dmr33955108a91.13.1741814561871;
        Wed, 12 Mar 2025 14:22:41 -0700 (PDT)
Received: from ryan-lee-laptop-13-amd.. (c-76-103-38-92.hsd1.ca.comcast.net. [76.103.38.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-301190b98b7sm2353887a91.32.2025.03.12.14.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:22:41 -0700 (PDT)
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
Subject: [RFC PATCH 0/6] fs, lsm: mediate O_PATH fd creation in file_open hook
Date: Wed, 12 Mar 2025 14:21:40 -0700
Message-ID: <20250312212148.274205-1-ryan.lee@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calls to the openat(2) family of syscalls are mediated by the file_open LSM
hook, but the opening of O_PATH file descriptors completely bypasses LSM
mediation, preventing LSMs from initializing LSM file security context
blobs for such file descriptors for use in other mediation hooks.

This patchset enables mediation of O_PATH file descriptors through the
file_open hook and updates the LSMs using that hook to unconditionally
allow creation of O_PATH fds, in order to preserve the existing behavior.
However, the LSM patches are primarily meant as a starting point for
discussions on how each one wants to handle O_PATH fd creation.

Ryan Lee (6):
  fs: invoke LSM file_open hook in do_dentry_open for O_PATH fds as well
  apparmor: explicitly skip mediation of O_PATH file descriptors
  landlock: explicitly skip mediation of O_PATH file descriptors
  selinux: explicitly skip mediation of O_PATH file descriptors
  smack: explicitly skip mediation of O_PATH file descriptors
  tomoyo: explicitly skip mediation of O_PATH file descriptors

 fs/open.c                  |  7 ++++++-
 security/apparmor/lsm.c    | 10 ++++++++++
 security/landlock/fs.c     |  8 ++++++++
 security/selinux/hooks.c   |  5 +++++
 security/smack/smack_lsm.c |  4 ++++
 security/tomoyo/file.c     |  4 ++++
 6 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.43.0

