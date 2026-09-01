Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543B9471D02
	for <selinux@vger.kernel.org>; Tue,  1 Sep 2026 16:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278559; cv=none; b=TkAlRy6sLDeTu4v5vcDD3Pj5nq3Wsr9hydNMuGY1wZk8O6rg9qwHXE9J5hPKkBH1NoszTZUX3rAol0UljK8F0NSX6nS/A0WRBN7eLsh+Zmovmsc6QDjKDwgUy7ID+71eqlG0HWff4ox0bE92iFgBbXY5IhbsqjDRXmHSdzelkSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278559; c=relaxed/simple;
	bh=Bo4lvK4HdZVgbnXWZT7DvmYJRUeI3CxeLKJgaaFeMc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oKHNB4VKMIjsLzFhFWB8EfpbyJZZH/3V7cdRfsqn6VyXiCVl3qCElC/YWkS1OlKLfgrS1GPzoa8Rh/WG409drznT8bcAZiU+W4uSLnBR+sxSKI2RT+zpkXsZVAylbosFXfu89fbUMjw/1bSAyQcp/GmmMs9ovFQ/kMGifTbTDf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jisU9+My; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jisU9+My"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-52d7ef16f91so34282881cf.3
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2026 09:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788278557; x=1788883357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rY7YtJIXHxPVCn5Ch/jHoonb22ud6GA60YvGNKXAQMQ=;
        b=jisU9+MyeP/lCNjoGzxsmPdKsUKF4HI13B6jx/5dG354mVJL4OcAH5fIkt31IpUnvf
         aavFs4QFPDcYD8gCutCpvJ8zCtLmC2ra8xo1NJZe9j7yMMRroY80yhhJ7j66cmRW7G5m
         9sBgM3iy+MwJHSDMe2lyTE+7BUvlbuH/rsnfYY36MmlQ56EsFeb+8lOcOUh6pfzsEMuO
         wogOSD1vGXDcYSQqz7vd7O5c+WbFQlvLuh/CfwX/ZSqj4OdM1kEY0lzfjqDqm5Mlvo76
         lS6lUiWyOdITOQo5Zls5WPvCxkIu63kP+aUJ8YM92a48U7e8vWo2CEDBW493T7G2aaXJ
         cjuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788278557; x=1788883357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rY7YtJIXHxPVCn5Ch/jHoonb22ud6GA60YvGNKXAQMQ=;
        b=Fyl20iykSIjma9darPNZd00Dqs65ewaMwjmpZvQ0a25bPDTxFqDV0DA/jkRkt7D5jV
         edmzolMR9c74xLAEhDCp+H07gEyvrHX34KkFd+ZtKXqXbEhGzHH2fetOMZQZldYs9GUb
         MnTO3AWgb6WB88BOPkBb1A/z/1uEhZBgo4LhbBgjYZl1+dg844GctGDGhE9bNbDpCb6G
         kkS+AVbNhXkmi5GPZE+EZP0Sc7/+S842+370h+NDolggweXAuR+3ZREKQ01VHslCbOxF
         XWJRgZ/rfgsFhT9I0BK+gR1GMX6+omV32cXwmcaAF2qcNfyAe3Vsr0yzP6/QXEsWeqLH
         +7QA==
X-Gm-Message-State: AFuF++k02GpmcyHq+rSXYh0U8R6alw99V8dbOEGwn4BhCCL7t1RFjHQU
	/v5fPVES8xfgl+WbEbKydNI8/OQgsxpua/aioQTWYx80k+L57pFG3FGTQaH+GA==
X-Gm-Gg: AR+sD12vemTQSk4/R07zfTSG2mkmMBqWWwywAlgk6BDP7ZOYU5eokwVu9Vkjyu8K6sJ
	Bzhy7hRbs64IhzNwLDDYoM5yTt4QF6n2pGtvPxAzLM4i8USZctuavnpQjKQkqIsrFeEDS3X96RA
	uewtDWH+qMzkqjOM0TgpCwqGPBG8hAHt01fnodtKGsqtTEHZIQ5RAFLd0ba/yoZeHVidgTKfQTU
	EQfooNlVjMsVTWXMFDqi6xsXDAu2F+Nad3+RufysDq3Xy97Ysjr+SjEBiEwiyWJ4QoMFEElBNV7
	WP8+9AqgZZ7RrgYB5QQye8xc1UUZT/Y98JaYzCaIqdqQqGDfHGdrAkMTUOj/T82dSo/d11I32gb
	6YDg6Ff20Fr07Lat67Jb2cJ4QJ9ZLHiWUL5W6WhTbMa5fxAwFENott+bMtam53jCk1lyVeyXyA6
	cWFiwSrbex05bE6hBEjOj9uQTLNjvYBlSBtU5PBcckgPPFBZKbAodDQZ+eLzKCGBgpsGqnLqUSl
	nPORmEc99PjiVlF+QT7ZSs1SSJjtxoKtruhCW/YItG/dumbbsNkh3ifRgyerGCy
X-Received: by 2002:a05:622a:1f16:b0:52e:467e:e9e5 with SMTP id d75a77b69052e-52fb96e682bmr465140121cf.40.1788278555625;
        Tue, 01 Sep 2026 09:02:35 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ff704a282sm78980701cf.18.2026.09.01.09.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:02:35 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 0/4] libselinux: add a configuration-root search list
Date: Tue,  1 Sep 2026 12:01:08 -0400
Message-ID: <20260901160111.42656-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is the first half of addressing
https://github.com/SELinuxProject/selinux/issues/33

It adds a configuration-root search list to libselinux so that it
searches an ordered list of configuration roots for each configuration
file. The list can be overridden at build time via
-DSELINUXFALLBACKDIRS=.  There is no change in behavior as long as the
files are found in their default locations under /etc/selinux; the
fallbacks are only used when those files are missing, e.g. upon a
factory reset.

The second half of this series will address libsemanage but is not
necessary to merge this half.

Stephen Smalley (4):
  libselinux: add a configuration-root search list
  libselinux: search for the binary policy across configuration roots
  libselinux: fall back through configuration roots
  libselinux: search file_contexts files across configuration roots

 libselinux/src/booleans.c                     |   2 +-
 libselinux/src/get_context_list.c             |   6 +-
 libselinux/src/get_default_type.c             |   5 +-
 libselinux/src/init.c                         |  12 +-
 libselinux/src/is_customizable_type.c         |   2 +-
 libselinux/src/label_db.c                     |   2 +-
 libselinux/src/label_file.c                   |  50 ++++-
 libselinux/src/label_media.c                  |   2 +-
 libselinux/src/label_x.c                      |   2 +-
 libselinux/src/load_policy.c                  |  24 ++-
 libselinux/src/matchmediacon.c                |   2 +-
 .../src/selinux_check_securetty_context.c     |   2 +-
 libselinux/src/selinux_config.c               | 179 ++++++++++++++++--
 libselinux/src/selinux_internal.h             |  40 ++++
 libselinux/src/seusers.c                      |   4 +-
 15 files changed, 284 insertions(+), 50 deletions(-)

-- 
2.55.0

