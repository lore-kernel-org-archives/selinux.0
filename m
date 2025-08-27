Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D15C31282B
	for <selinux@vger.kernel.org>; Wed, 27 Aug 2025 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756333372; cv=none; b=n6/BBxXZODjGSyrU/cn3IbEhlMAa92Zsg72+pkOqRZV7GWwAtNRZ7QbS6MuC1YX/oslRp2ARnZ56vhF8bFmVIfNPou0uNe2B0PslGmKtPtwiKe2GA7q8fh5dSkNJNFTRz0QeP2qV6qYGtnl0UbeqjcjU6jIiitXdagu/J9Np7Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756333372; c=relaxed/simple;
	bh=ds/S1EVyIKnvZ9LVpP/WvBCpoyb7+PD68B4U73/Pc0k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mUTh8x/Bhnju7+WMqRyGDtMLPW9mfxx3a5BCJFm1tzp41Wj/iU3Yb2uvgZA/UCDFbuAOIRpqbAEYtsMPwbyreQF99ptDqevaAV3mE38EQFX2lhAAfil6YpSoAbjhkdCn7nutVgdF2IyNSRatqE1lDDYVYjjtWMtSSriQhutzDc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iqOtqQJA; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nkapron.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iqOtqQJA"
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3ec4acb4b61so3951015ab.0
        for <selinux@vger.kernel.org>; Wed, 27 Aug 2025 15:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756333370; x=1756938170; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YATE6/X/BBWba8kshTUTT9lCmwAYXNlSRbgjhzgP5vU=;
        b=iqOtqQJA6bp+I9qyih+Gs9D6ALLPqNQgFTBDAc4iwBAjuL+JIleALrijOXLmK9Iz6X
         +j4Mq27KVTs1o1CnwsghXAP1jWdeHPylFUh0EKf+Df4kYjfdSmHjmXWe1I2T6lEx3MZG
         Q0d7tLWAplXCoW2xloNFUIdR/s3l+EolE3VGLjQH20bwa07HbicNFFFPwkszQC2TLCNR
         Hge2Qa2QOOPLz57eglZBNN+1kBzs04wIG7jPNhMDkvhcvbqg8KQPvugOFxw4i06cHx/U
         ePu7/wG7lm43dcF8u5Rf2mVpDHWqole7kXJr1JURFi1E2ae5rtr4Z/gckS6Jx5ORhwY2
         C29A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756333370; x=1756938170;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YATE6/X/BBWba8kshTUTT9lCmwAYXNlSRbgjhzgP5vU=;
        b=Sv4xmPw+7HSOVqzpCtRf07rAeoLyUULQGmiYKLU2jv40qww88o2V6U+BaY2ZGqfJfJ
         CZlBG6FSXN7PoCY3s8U7rrj33oEcFXNZoPYJG9NahtfuyR+DJP2oWTm7FsObCMeA5GKM
         JgZGhXxCLM+rtrI5v59B0+RvLvLrtwSak2+ETR8NY03RrNZoRnVrk2YMecwNwEf8v28W
         pA5Gh6IV2/fuhBNRSSbEstgkiTAnSSvK4PXZE0I6jG/MiklGW2QVKJu1Br1FIay7ONfS
         vfn8zgdRIXj3OhabB8azm6Obke3abLWr6fSmJHQvtCeeYrT5vfF6CLEpEYq3zYG1DmhU
         41Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUGYOSAnI5Tava95D2R5K/XpSG4Mvo0kSzBFVVsOpbiH3B51dyjopMeKq8T2lVjFLObjHjNAJ3P@vger.kernel.org
X-Gm-Message-State: AOJu0YxXo/MZKl4kkAcSVcfb4lvtef5A0HT2yP5Td3eQAS9xcUHlk1Z1
	gXHQ5y+T7Cp5tYNY4QVfpoyJTpTUnlXPzT5y5UGFmmmtdjorhfgopC4vfrpMlez4R+/dO9/Y902
	jPNXC18mGmw==
X-Google-Smtp-Source: AGHT+IG08NPlcTfnwJRV14NPo5BAvb6gaNt/RvTdXkNxGluLT4kwGpYXIl8mJzP3qm8I+PwEm4sOfWuatXVf
X-Received: from ilgr20.prod.google.com ([2002:a92:c514:0:b0:3e5:533b:799f])
 (user=nkapron job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6e02:190e:b0:3f0:f671:aca5
 with SMTP id e9e14a558f8ab-3f0f671adafmr25112685ab.19.1756333370643; Wed, 27
 Aug 2025 15:22:50 -0700 (PDT)
Date: Wed, 27 Aug 2025 22:22:21 +0000
In-Reply-To: <20250827222224.1648500-1-nkapron@google.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250827222224.1648500-1-nkapron@google.com>
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250827222224.1648500-2-nkapron@google.com>
Subject: [PATCH v2 2/2] libsepol: Support functionfs_seclabel policycap
From: Neill Kapron <nkapron@google.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>
Cc: Neill Kapron <nkapron@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This adds the necessary userspace pieces to support the
functionfs_seclabel policycap which enables per-file labels in
functionfs and the ability for userspace to apply the labels.

With the policycap disabled, legacy behaviors are maintained and
per-file labeling is disallowed.

Signed-off-by: Neill Kapron <nkapron@google.com>
---
 libsepol/include/sepol/policydb/polcaps.h | 1 +
 libsepol/src/polcaps.c                    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
index 0835ea21..bbaebf1a 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -19,6 +19,7 @@ enum {
 	POLICYDB_CAP_NETLINK_XPERM,
 	POLICYDB_CAP_NETIF_WILDCARD,
 	POLICYDB_CAP_GENFS_SECLABEL_WILDCARD,
+	POLICYDB_CAP_FUNCTIONFS_SECLABEL,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index 7ac0ae7c..83eb6143 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -18,6 +18,7 @@ static const char * const polcap_names[POLICYDB_CAP_MAX + 1] = {
 	[POLICYDB_CAP_NETLINK_XPERM]			= "netlink_xperm",
 	[POLICYDB_CAP_NETIF_WILDCARD]			= "netif_wildcard",
 	[POLICYDB_CAP_GENFS_SECLABEL_WILDCARD]		= "genfs_seclabel_wildcard",
+	[POLICYDB_CAP_FUNCTIONFS_SECLABEL]		= "functionfs_seclabel",
 };
 
 int sepol_polcap_getnum(const char *name)
-- 
2.51.0.318.gd7df087d1a-goog

