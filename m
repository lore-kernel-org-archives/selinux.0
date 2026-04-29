Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFEC33C183
	for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 21:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497173; cv=none; b=UvyjcpKAkbNwTGlDHIB8OlgGdnZ25F0B/LvNUVNgyLq+y1FpaWvrNeSm+RfVUVcjQP4v91qBxA4vxYTo1d4LBWXEsM/feZ2iSQJlZbqUID9LqFVOaMPT1bkAxBPLlWMvsLLKsTkHoQF1xYUlRo3FHlzih166xd2zJluDivgJ/iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497173; c=relaxed/simple;
	bh=WRrg5JNaosnzHKRnx+EM7cz/V3t9nlv1tEANopN5u/s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e/88cwDuBqt4z4eBNsOJL4SlGxH/F2AH0K7aZNSNkLpVZPiY5OGAocDDK4XKRRwzItdcP5dvJbKXw3xgntLti76YMWX8+mNIFkaLqZy7dnDK2pdOUi2pRy1gLtOHH5GOrBKLLuNH2SMTIwx1taVkjhQCA4809ebqalg79UxIn8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rhWMbGPf; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhWMbGPf"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8f83efb5729so25354985a.1
        for <selinux@vger.kernel.org>; Wed, 29 Apr 2026 14:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777497171; x=1778101971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OEtimuaCiSytBCIswG+2sk8WSgxS3Syd2utJTFMAQWE=;
        b=rhWMbGPf1nqVdIApYZhSVqHU9eaVoXBZL6zyrjIkeH+fBsuJN3+E727ggmNJYL/Syj
         cA0xd8MZHxYXXYhswQHPh7GHlk2tUclAXKoUuU7uovm+Gz55srfgV1RMm/WRHGby00jJ
         oBuM+2+pK4BN3NgpX9n1L3U5hBXf14nbs/iE7R/wjUENFYnazX1KScmsg6IIpX4NFnCC
         bgGjp7ON+EC/Qcz/9Z5LqgnkiuzHzYhESkR7VBCk2CeyxOtQAHno9gCqzuMzGVR/ww8z
         syCDECfZ9337YBdLHNQ0HEhtwtq/lKj4TTzsjZEiCynmRqstB9kYoh0VpjmK/wy8L+yb
         jE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777497171; x=1778101971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEtimuaCiSytBCIswG+2sk8WSgxS3Syd2utJTFMAQWE=;
        b=Fdos+eCDd8n9mMvVd5JtatfLyUcfjKTg0iqmFBxrAKMFHCO2P7AK67VouD3Vk2/Dkx
         /9o/bhJXD3XoF+DiUDhMP8g/BEiXyk//RCMUsTVpyeH7vNbatUs/P1vgg0+qWhPmhFws
         3II4cBbqqqFOT1V66IT3bgE3Tsa5jdnnUURwNTd8YX0Q7D7V3xmfx9GOhjjYvE5Bf4fU
         ecfvpIw/+Cyk7DkS/tElng9eUY/TNoVI73X7xtpfVfvWxnfKL50BI0Rsxa/rQuvLbuR/
         xRg+CP83tujuwYWe8xVEQDoCOgRidVFRm9+qti4yGhICnWopclalCsAhq7NG3anGZAXc
         AvVw==
X-Gm-Message-State: AOJu0YzJY9P7L7OhUpnPbtiDc5WY90PbVn1XfbbWU9jSijAh2ebei31s
	ckF8IC6J8Q06NUWuEJGXsWo+ng4ErO9tYFvamE+A9cdLYz6rlGH3ALrnzQxnwA==
X-Gm-Gg: AeBDietVIXdRAcpDQkaM+0fZ9YeIAU5Jy6lHBt14dXlF+ZsuKx8eFrXV0Xvn2P+2aAm
	mho3oIXQMVSMxP11V/X74Nbdsb6KqcoaPU9JEgXJKAZ2izZRni1qNvhG0DQTmNIjQs5qwwuG5Zm
	O3M0MRjsHFU71IGtu+wISmzYk+uddsnXZZwsJWeXdxpHYyw5MgDTSdpJtklxamK+n2rERTLxFFI
	z1eeuQVcFoFmZ56+8fmuUjYBr2WGq20PcFOqs8VT37HQNSK8biL3GSb2K2kpd9DMZbufsDM3tOg
	yAmv9TCK3dqn6OBUVXMJu0KoBI1eb2vYh5nBSy8HIGNIzayW3I4c7Sgx6dYz8i0vUaVPO806E0a
	XG2+/ckAGjivCyHrhP+4FSMiC5CIQ9T2yTuJkQiJvkwr0q5RnA1+e4964uYDuYrALKwbBLZ111a
	3F4uWI0WzwGoq4ST/ozYWlS+DbX/5/44GQ/X/nEE6yMzDv0G0MJ3t/cAvz6ylY9aLXOn0CFufUv
	DPNes7Y1jcd2SmFKjpv5fQz2uMcPNDEDX4d65XEaaTQHtR1gtsv+eiFlrwdSXlfiWWGiu3UCiuO
X-Received: by 2002:a05:620a:3910:b0:8d0:8f7:36b4 with SMTP id af79cd13be357-8fa8893e986mr71140885a.32.1777497170943;
        Wed, 29 Apr 2026 14:12:50 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8f93cff8e85sm280355885a.17.2026.04.29.14.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 14:12:50 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: paul@paul-moore.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 0/3] selinux: prune deprecated interfaces
Date: Wed, 29 Apr 2026 17:12:26 -0400
Message-ID: <20260429211229.3750-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

*** BLURB HERE ***

Stephen Smalley (3):
  selinux: prune /sys/fs/selinux/checkreqprot
  selinux: prune /sys/fs/selinux/disable
  selinux: prune /sys/fs/selinux/user

 .../{obsolete => removed}/sysfs-selinux-user  |   0
 security/selinux/include/security.h           |   2 -
 security/selinux/selinuxfs.c                  | 145 ++----------------
 security/selinux/ss/services.c                | 125 ---------------
 4 files changed, 13 insertions(+), 259 deletions(-)
 rename Documentation/ABI/{obsolete => removed}/sysfs-selinux-user (100%)

-- 
2.54.0

