Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256F237BE97
	for <selinux@vger.kernel.org>; Wed, 14 Jan 2026 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768384914; cv=none; b=XhnTmSP5sZiYxUkHIlxW+FeiW3rlTRGSrIKiMlH6cyVC6vrEfobYT80RgUA4U9SBiU2nFfxw1xiNHVr2OWLyS6hQ6toT6s1BGa2pAvUoZJlWLaGUT/BI0Wbj2G1Skk46VX9MR/slmwWJZTHaIp4K924zFGYMhBrffJxGZ2oSwDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768384914; c=relaxed/simple;
	bh=fPVZTq8+zbrDGHoMjHeAp/6+eq8x4H0qoyA5826QEWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YvaNimGzWc3rbquH9gQynGz9HlMaLiYw7m1s6TwEVt/1AdI6iNmoy7xvuPEYzHBFcgRumUnsnOfgTiw+mjAI16MK6B4IlVLXM9IZ8NxmubiR5RDCrQfTkBKKOI/UEa1Q7ft/xkXSgHI0/mFVzSqghx0Ix3GR9WpasXloLxubGv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y44e6sUR; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y44e6sUR"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso4880474a12.3
        for <selinux@vger.kernel.org>; Wed, 14 Jan 2026 02:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768384912; x=1768989712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+zsrKnMkvLo2Q8esJ6ms2Of5PtJ7bwHEYXuvf3bfQ0M=;
        b=Y44e6sURst4OMGZEa5CHw7QKGBlg8TDParAx23qvoVUcThV9CRwZjPiEdNmjSUwDGK
         +lK6JSHP+c34OiDRFc9OyCPvsV2oSN+gVErWVaOBw3m2gXJcuDY0mEwDVtdCCwVCFmJE
         if4eBwm/d+CwZu4DklY5qkw+wxQ9ETO1TGjxivbSt8Oyv5Sw3CqI/Sp9g5vbmsa7PQya
         PBuChhE2pIOnS2LSD7IyS0yigV8/lybZoGyqW3/5CUorGx2xEZRsB8QAa4JbneX/qBza
         J9llaG3+D86gCn+kr/VZkREfYpaml4Cx/4Cz0zoBxyKRuwao4GRxYF+HxjpJzrN2mPXL
         XLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768384912; x=1768989712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zsrKnMkvLo2Q8esJ6ms2Of5PtJ7bwHEYXuvf3bfQ0M=;
        b=XS7aqYF9AZ/UKXuJwLCzCYEU6eH4VH/Sdpz94Wg57tcGRrVi989lt0Rrv+Rsp/0Az/
         UqqcQsYck6uMpwjlA8vqgnkOh3p6b5E4eK+mFlSGJtrS5Hn+UYP4/ukN5wSORxAW5GMt
         Ew8Ntiz22UBcn1qpkfzL0vTCXwZQSwEaAjY0AOaGIxIA2DGWJGBWX9e9nI4KaE5htsvi
         vCURYmh+eRCsQosPMHOLNOIj3gmrQXL0VqU6GlhYNWDdFSmuiABqm4zQYrpWE/oMNpHu
         di/v5kSo8ruJtOPycyVpFXC3vs3WzuPdCRWt4IZvWegC2rq6BNyn74mIU4TOQRqJ+Sr5
         +6kA==
X-Gm-Message-State: AOJu0YxYkdSJIoRLD4lOd4NT2Du4T3pYZWCUooQLuuC9rbJLhyuTavOk
	BjPfqfo+jdjgQaYWIUoZ0WpR6X2bgVg+Eii9f9aAzjQOm5r5WLPv0D0Kq9yBqg==
X-Gm-Gg: AY/fxX6mMBSzSyacAYsunVY1z6CD11Ymdt8yOQJuUUYI0oxpHTawasxv/ipYRAfQeTr
	ucdsOh0OaFhX74ErDdua+Zk09CALEDA09UNVxeC6iSjTKE+isxuJWgFPvJ0faDK4DL72JuoxETA
	rbT4cf5ZPOmoLxkSLdkNCz2w7c4tK1qqSCZ3TV4fM+VJhIW1J07i7sJNyU+/3rIl1kDEcsQvHkV
	0oULkUN3A5tGw4fTFhJ3lUm3fVbdeEKu+cufWFjIokAk/1FOGxc4Qbd04b9aTI3/OnFQVzlGCIx
	sX0tDCATjjiTZDXM4gMZ06rOi14dC4cGQqSOtGHLRdjjthAvma09zK6V7kCSlcv7UVipbKzGiu3
	1VgHNFXWtYK9l2ExW2J9FaR/u5c+1zwBugET3PKw0iMlWszFAYlBa8fX/tsrns4kl5JM6hHH0Jr
	nOaokoT8qNwkB5asRM+g==
X-Received: by 2002:a05:6a20:7f89:b0:347:9ae1:cffb with SMTP id adf61e73a8af0-38bed0d2c3bmr2290673637.24.1768384912475;
        Wed, 14 Jan 2026 02:01:52 -0800 (PST)
Received: from L-12443L.kpit.com ([106.51.46.100])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28ebe4sm22370879a12.4.2026.01.14.02.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 02:01:52 -0800 (PST)
From: Bhabu Bindu <bindudaniel1996@gmail.com>
X-Google-Original-From: Bhabu Bindu <bhabu.bindu@kpit.com>
To: selinux-refpolicy@vger.kernel.org
Cc: selinux@vger.kernel.org,
	bhabu.bindu@kpit.com,
	Bhabu Bindu <Bhabu.Bindu@kpit.com>
Subject: [PATCH] udev: allow udevadmin to extend socket recv buffer
Date: Wed, 14 Jan 2026 15:31:05 +0530
Message-Id: <20260114100105.542373-1-bhabu.bindu@kpit.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bhabu Bindu <Bhabu.Bindu@kpit.com>

Upstream systemd commit [eba449fa81f6] (PR #29872) modifies udevadm-trigger
and sd-device-monitor to unconditionally increase the receive buffer size
on netlink sockets. This helps avoid failures under high event loads,
such as:
wait-for-udev: Failed to increase receive buffer size, ignoring: Operation not permitted

To address: "wait-for-udev: Failed to increase receive buffer size, ignoring:
Operation not permitted", we need to allow udevadm to increase the buffer.
This may fix the issue that udevadm trigger hangs while processing the events
References:
- https://github.com/systemd/systemd/pull/29872

To support this in SELinux, Allow udevadm to use CAP_NET_ADMIN to extend
the socket receive buffer to hold more events.

Signed-off-by: Bhabu Bindu <Bhabu.Bindu@kpit.com>
---
 policy/modules/system/udev.te | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/policy/modules/system/udev.te b/policy/modules/system/udev.te
index e245a66a4..82fe8354d 100644
--- a/policy/modules/system/udev.te
+++ b/policy/modules/system/udev.te
@@ -447,3 +447,6 @@ seutil_read_file_contexts(udevadm_t)
 storage_getattr_fixed_disk_dev(udevadm_t)
 
 userdom_use_user_terminals(udevadm_t)
+
+# Allow udevadm to use CAP_NET_ADMIN to extend the socket receive buffer to hold more events
+allow udevadm_t self:capability { net_admin };
-- 
2.34.1

