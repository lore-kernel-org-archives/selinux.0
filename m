Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002C413E02A
	for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 18:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786560365; cv=none; b=C2txD8f4Yl6vF+f6jS3xdDMrpjSPkIIaJCqN1mENwgz79JfE8ziDj24dCLMan2+/Va3WOM66uQusKefRUELeBB44MKaAzcEUt0YftWI6DkXxi8n9/uS4lifbLChASjQbFVyF0v8gGSGOibhYw6XKcMDvegklundFH+h7eA1kWzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786560365; c=relaxed/simple;
	bh=eiVQOYuZYsci49Ucy7e7XPnE6mkbynjq7YuCLorzyeI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j7zi7O8xxnxEkFtD6/HoB3gt9hiyPWfhkVuGJgWrnyU2nugvfiAfPAS6iP6xYRSeFCU+z2IsGOHTIyzxg7P3o6fc8wAedyWnsoNWs1oXiN3/oUhdgJCOsc+moMn2rwdMYp2chFFQUKKgwUy9LNmEnWzX7NvdMLHHhT8YwypiAXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BqJHjtB6; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BqJHjtB6"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51c0c45c580so9098981cf.0
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2026 11:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786560362; x=1787165162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XX3MwHlFd7S1hNLzvgyq9oL3aLdST4ikbFCJe6MmBHU=;
        b=BqJHjtB6ivmBBVJCq2P02lWa95kM2lx0EsRD2TF3NCAwaTlD0aI6DuSZ2RHMW5rONN
         ktGM88HiFqkeEk+YUwauUm8tKlI8PqufE0/EAoSVdDw43hOISwujZ8ZUr2/WLD2onF9l
         nZfEuBff0eShJbzwLgZscBbLy2VfsvPIvnvvzyDULaSlQ3vM2AGNzwZCmstIN1OtjeH2
         S58H3T+6ZSMpN/L2iE9excerbaRjrXuOB+8pn0F4UiXq5Trrdenk1oj7djJYmWPXMHBw
         73uwPXKbjbQ1+3U2IJXdmP22GtF22mGQQZ4ydXH8qw1Qnu7pMO5MwvwDBrB0BqMD+Gi3
         9kWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786560362; x=1787165162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XX3MwHlFd7S1hNLzvgyq9oL3aLdST4ikbFCJe6MmBHU=;
        b=CK+7SO6t1lSUllQX4b7ms5p9edBmxLkba9e4vxfe1j63QzW3Iz6I9W33HD6kKcC7Ub
         sFelhUNxSJkc+0XIUYb3iscHBc/0IT5fuZI98vzy0PP76kPsGuh61bHj8q+yHRnM0P6L
         q7HDahNrRXiaFZJEWyqZvg1z2YeZGld4j/TLOgjuiokFQMcDPFsMYtEW+G1RVTlWaB6v
         CX0JJ9WBbT7/HW0PqCvfMp1GO2WLM1B+yLfQ43K4814nt70WrsR/9Srse4I1/UQZYyNv
         ZuWgVvHx6EeqFKXRMuuV0QiykzvyYkJZ7Zzy5PDx7sf8Sks5VB4ON+VX1Q1C0y8Omo5X
         hfnw==
X-Gm-Message-State: AOJu0YxjaMM5ufjj/0zNAC5Vf1H/f/fr8AgwDJmuHMEaOsG9kZe3/+gN
	GjaLnZHVnTDnoAZS0ynJBPPs3OuOv/f8b0FrIr/EJ+4rHr4UgAO3yzGXUaDSdw==
X-Gm-Gg: AR+sD13vY1Y8TE5v704OeBChDyBVOWY/9t83eOrR/UlqdZQLHDoQ/hyWmYvH9JmiMZr
	kd88Id8arOKObsqY0HmLqmIV8fIPVBaqoY7z8Bb5of0UF1m+BYewuZT4g9rQlUgrmCtCiMbKWxx
	icc84UuDgAT/vfyXF1K5yPzhOcRvZ3Grxnufds8FTrE0J8julzhtyem02E/0iJgc1pu/F0QtYAz
	vAwe1DkWJKr3Md9d1Zrh94ddiKyGKa7VCWq7TVyaNbW5Oww1sbOhH9R41LLFUuEbNGPBfxHc2Om
	Qtv66c6y+XBt2dsT5mdMGg00V5sylVKTwJGcS0XyAllx1AIP8gvbR9aL07THHogAFEHpSLPxeBA
	IOh7kuN1xBZMhJd8RKFdCBpsS8L63hKokdpX4Dc5TegK2/hZ26oCeVyR7UEyhTNrBEHq+VJNNfP
	/7NXEzpYV11uWlyHPYJJBUHksKbGyfXAlvtIs/dzuJ9XcpxtuUFx5gOm2zi5JPOo7zOahe8162I
	ZrrxBCpkbHRAxNeVyzwaAuqeqsJqqzZ93x2FjjFsnUU/qqej56fqi+R2q6J9v5j
X-Received: by 2002:a05:622a:1f18:b0:51c:ba4:d837 with SMTP id d75a77b69052e-52d73c9551emr3074661cf.18.1786560362327;
        Wed, 12 Aug 2026 11:46:02 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c29e124sm27578346d6.13.2026.08.12.11.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 11:46:02 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] README.md: clarify minimum supported kernel and policy versions
Date: Wed, 12 Aug 2026 14:45:39 -0400
Message-ID: <20260812184539.134978-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clarify the minimum supported kernel and policy versions.

The Linux v3.0 kernel requirement is only for libselinux and anything
that uses libselinux to access selinuxfs. The policy build toolchain
does not link with libselinux or have any other runtime dependencies
on a particular Linux kernel version or even on Linux at all.

Note the libsepol version in which kernel policy version 24 was first
introduced, and also note the first userspace release tag that
included the relevant libsepol versions. At that time, the release
tags were date-based rather than version-based and the versions were
updated more frequently than just once per release, so userspace
release 20090403 was the first to include both libsepol version
updates.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 README.md | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/README.md b/README.md
index f256912c..bfd32b89 100644
--- a/README.md
+++ b/README.md
@@ -25,18 +25,28 @@ for more information.
 
 Minimum Supported Kernel Version
 --------------------------------
-Linux v3.0 (for /sys/fs/selinux mount point directory)
+Linux v3.0 (for /sys/fs/selinux mount point directory) for libselinux
+and anything that uses libselinux to access selinuxfs.
+
+Note that the policy build toolchain (e.g. libsepol, checkpolicy,
+checkmodule, secilc, semodule_package/expand/link) does not link with
+libselinux or have any other runtime dependencies on a particular
+Linux kernel version. The policy build toolchain has in the past
+successfully been built and run on non-Linux platforms as well
+(e.g. macOS), although this is not officially supported.
 
 Minimum Supported Policy Version
 --------------------------------
 Kernel policy version 24 (boundary) for the SELinux and Xen
-targets. Support for this policy version first shipped in Linux
-v2.6.28 and Xen 4.0.0. libsepol dropped support for kernel policy
-versions older than 24 starting with libsepol 3.12.
+targets. Support for this policy version first shipped in libsepol
+2.0.34 (userspace release 20090403), Linux v2.6.28, and Xen
+4.0.0. libsepol dropped support for kernel policy versions older than
+24 starting with libsepol 3.12.
 
 Modular policy version 10 (boundary alias). Support for this modular
-policy version first shipped in libsepol 2.0.35. libsepol dropped
-support for modular policies older than 10 starting with libsepol 3.12
+policy version first shipped in libsepol 2.0.35 (userspace release
+20090403). libsepol dropped support for modular policies older than 10
+starting with libsepol 3.12
 
 Installation
 ------------
-- 
2.55.0

