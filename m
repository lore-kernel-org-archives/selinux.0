Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6385D2DA76C
	for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781187086; cv=none; b=YNO6tdwo0ZCQPnMTnQbNacLtL6spjkMdohOaipIID+q1SCy+gKZplWnh23Qil8tm5MPt4hLWCcoHfZUjuKRxDfafrTeCSRfHSZ86OgOrF7dx1kF5AgnpoDJ4uguz/4/XT/VmIeaCAO0ST7fUpIpb0vwwtDFN2nELRq357d9x4Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781187086; c=relaxed/simple;
	bh=rwF+k7S1BtFG9EXJC18GsKa4++TBvzjSNTrIltl9Who=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OM2hZC4FSOlbx3oYidgDElTpeJmCHdQ/gf2S+tWNEZb4+xQCNvcpjy2C6lnk00SC4mHYhmo9E3KjyDsHeVRAk0TMskVRTkVBn3RjS4RtLQjD5kGXDKVFBJwp1a7nlT1YxZZOWZ6+BZBW8kJwVtjYR+xatgun+tpWZ+3SkadmFAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gyf+R+GL; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gyf+R+GL"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51758478240so40922781cf.2
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 07:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781187084; x=1781791884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W8e+imCdPrd9n1dWaloWrdcKljRoWqGfEQKfkoG1VWU=;
        b=Gyf+R+GLXa0c/p/3Ev6zjfGvMxMZRxJiJFZ8PmRTNij+yybrN2RwnrLZASrM81fSYL
         L6CXpu6Q5B1OpY21kSmLJy22SmrD6Ay6+z72k2wPdHpR/amGnsJV5E4qI5svCxQKG+Lu
         Yma2PZMdWEbAgO7LcZTrd6aHhHyRBRCT3nscbwK3PQlRfCHU2QgAjKCb/NeM5VAxtgy8
         6ivA6etROVd15xvuogZs40Q7I9FbgK2He/xMlMw4BDuWkDsJnW50tMl34IZXByFhpM2l
         kJ1ugGU4TnL22nqV4Mja3ABt5ewyWm8nnlmRBtOHzbQFjEQ6n2kolXagGzaPUHANEuln
         urEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781187084; x=1781791884;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8e+imCdPrd9n1dWaloWrdcKljRoWqGfEQKfkoG1VWU=;
        b=Uz73wBIDXDIirc8Onv5gHN8eJeQqw2s33kjChpzxS9rTWDaMznLr4kSTJrtEmUJgEJ
         vzCmo2XHnbMK/jmex4tx78l9szbH2wx52xvtK6RmXnotyX7L+9vfIe3wddRP3RFZwLXU
         phmm+fOSOoKWDKeSyHUJYxNNbvvgLQ4wtmpUAw7U1SxzhNQBBg4A3kWSiVBEbzoOP+zc
         CLFThWuy/3qq1AaeAPi3TFzFUp4DqLYl+5KcpvvlubSXSPPGsK0tDLbTzYtdtTv8VYlL
         mimk42Z8mvHCmueGzVla4fg/SHUSEiXK3LCCRSmIItEuw0/ysTS4VYXwR42LfZQH9yWL
         SSwA==
X-Gm-Message-State: AOJu0YzmDhdse5EWpBjiUCgxS5191v8EkhV4uiZud1So3QkVEX6GKXUn
	M3sOXp9XjHh28i/1B4IQgGDfRwxld/H0mLk6MulZIiRg9zZ3nbODtm2b5sHHpg==
X-Gm-Gg: Acq92OEIoRBvXmGJCeC1fn3q1jNdctGXhKhaOMIqHfK5fKo2m1Qm7AkaNyUl9rKZJp/
	AzSxinexp96NU0BykemBjCEfLLEzEfpyqtBktHIjBq3p2xa3EbIhqsSuIwVT6KJRW3diIpUpZIN
	aZdfTAWbdW9b42hr8YjLkFIDhLpGaAi8Qy9limcIwkcLCmRNy+fxs04mtXO6zZ1O7t0AcfhAkqB
	DlhI/4KJp7mGJYWx8c42UrgEchs79jY/C5W34rPr0qnMLfT4a2tVPCE2uSRjxHaGZHHNYttEgvL
	lGydPTzw5P3tNnvnhsygzVOatx6vf8JupaBeuEgxQG2yHQTjb7DxX/zDtJs36LTuGQMZZvseVbA
	s4olzejJxtAsUByPfNbCI+bmOjIE9oIH9IWHLpTBhw8+m8jWi/RrU5hiDG+48BH0vaewDqcRuGD
	X2wbbo1EGrbp5D9WQrs0TcpvhzFjCzGBf7mgZTPlWYleWaZ+dnrNObi5QF4r2BuXPKHfbodfZiv
	lljAFhnglacOh155FEoF1r2SbJtp0D3HPc8MA==
X-Received: by 2002:a05:622a:587:b0:517:8f2e:5d97 with SMTP id d75a77b69052e-517ede2d97bmr44430321cf.22.1781187084085;
        Thu, 11 Jun 2026 07:11:24 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517ef620e44sm17844061cf.22.2026.06.11.07.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 07:11:23 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 0/3] userspace: use openat2 if defined
Date: Thu, 11 Jun 2026 10:10:58 -0400
Message-ID: <20260611141102.17893-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is only an RFC (targeted for merging after the 3.11 final
release). It updates libselinux, restorecond, and sandbox/seunshare to
use openat2() if defined to provide symlink-safe full pathname lookup
in a single system call rather than requiring per-component lookups
(as in safe_open() in libselinux and restorecond) or following
intermediate symlinks (as in seunshare, although this is done with the
caller's fsuid and thus is not a concern). If openat2 is not defined
or if it is not supported by the kernel, the code continues to fall
back to the old logic and thus preserves compatibility. If we care, we
could save the result to avoid repeatedly trying openat2() on pre-5.6
kernels but I am not sure we do.

Stephen Smalley (3):
  libselinux: selinux_restorecon: use openat2 if defined
  restorecond: use openat2 if defined
  sandbox/seunshare: pin_dir: use openat2 if available

 libselinux/src/selinux_restorecon.c | 23 +++++++++++++++++++++++
 restorecond/watch.c                 | 23 +++++++++++++++++++++++
 sandbox/seunshare.c                 | 17 +++++++++++++++--
 3 files changed, 61 insertions(+), 2 deletions(-)

-- 
2.54.0

