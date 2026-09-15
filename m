Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0ED4A441C
	for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 21:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789508295; cv=none; b=NslkN5mjnlzE7WPiWeM3nbdrXxpEStJo5XNdhv+3yaVdye0o/2FSqJHbVGgbqqQllBEu1OYRI1flKXiKTgizKB5dBPc6UlXTD8aosG6M1LGwE7SjL6B0K9Goim7qK1cIlbcsSduXWP/SfcJvjZpIgQaifAtCtvx2bmUzuxU+pPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789508295; c=relaxed/simple;
	bh=pec/vIP9Y4ghGZSnWp8fj/yDqGkS3PNts325pWorIjo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h37lVLbTvD5DAuZPKeaAALqNeOyYYpI9P3HWRn464F+hRTF+sdsynFz6I+L7NAG7coIq5ngpcEutijk4qw5qTpuQMZF3re9iBnW5qJUVl8cD+/IuQywgBbT37hFrZl+YCh2MTlrXQz8RVw//74sq9ndgwATYuyVcjQI/rDSpbgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gM+iu/mA; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gM+iu/mA"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb767cc71so1606001cf.1
        for <selinux@vger.kernel.org>; Tue, 15 Sep 2026 14:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789508292; x=1790113092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SscywtfHPlpCKzUb41VUuYse9NDOrmxI9hAFqMkIR3I=;
        b=gM+iu/mAyOThNK5m/NbAKfRrx1WAnvSgy/8pqiTGm6E3fNKXhPNkES6D6veWEyVK9W
         YMTUotq1oCTrAS4p17wSVpghy4UiQ7vtD4/v7PwvE6PFUwaekLB3C31JZlSdGGjQQ3EK
         sL3EesEJmnPCHNFqJh74ynQXlfKYJrLGc4S18VIQ8bo41mdWL99YOw6U9FhhNAF/N5vR
         tRV6brcsLiOe805FuUloFJISz28DK5kcJh9Ru7Zl3PRMYFjhmk4x8zXuNgFBnzsrv2/7
         IiwvNlbkTBKh5LQncxknrQ3yz39l9qZfHBb4djt438L2Ko3eEF37aYbZnS2WMIM/Bsns
         pnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789508292; x=1790113092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SscywtfHPlpCKzUb41VUuYse9NDOrmxI9hAFqMkIR3I=;
        b=J6e2kob9cMvDw90V7HeOOYzQ0nRdIdkiRVUWGtHUyCn3ZDy6/hdfELJ6KFu3mostDM
         5uHkGtaxYafoCbfLRb43WGvk+LojYrHsLOZ4SBAO5RKcZ4AKDDpXoO9USwoasH8CcQn5
         6i3cXgED5qeEBuwly6pvv7OzArBLBVw7od4x6FMsQ8qjaleGm2Kn0lUvOrLGM7+PNcVn
         kPAXnJzW9kRsr/RyeuCSc7s8a85nHO/AZfY0rrKA5lsDpWQ7PtS8fL3TwPveWYc/WGJ0
         MV6Hl1DVtaEl0Btzl6p5Jfr28w75ef49t883o1Mzn6s/S0sbIprsLv234YQmCGmSMmCe
         uFzg==
X-Gm-Message-State: AFuF++mHnjLt3RbL8ycAk7OjsOS0FvUnOL2+MxIiigN1l7PY6iTASqEs
	pZIvCof5tLULS1y3dlH+sf8OnuHg48RUEwnqhQtPhovBm/F+LsV+zCTNnLBU69KZi06xIYQhxwF
	CTrAlxM9y
X-Gm-Gg: AYBFou2PcrXJzERiJ1uebdbnqTtDOQt+NOWBl74QHLncDadRM96zYSmpKeTI1StcM3n
	i/EXDP3e7XC/F0CyFTwM2Jhg+Akhk7RMxNBk3Ddk58UfOoXrv/qiVyvLMOnU5nFCSjGJQRQmGIS
	tQ3xFypx9FXdk1WDOTXKid7Kw+q4AKDRBFTvh2W0AkY59JGYtlXuZf2HE5GGbbGw8JJ9PwjsgeJ
	T61eYTP9pwBk+FElGtw+Wsb/1m2tjc140EaPEWvG5EYm8tTaQFVr62C7qWxPerjdufh5tuaxzsK
	b+ah1tUER4DABVKkwuSM0Qx3orZiO7uQcMsIlEl0Ifo5XwHKlWN2S/OHJxGQiewxX2ibTrEudk8
	54Fzqf2OnPoYo+/9U/SUvw6qKyfhll+1m9/9FTEw5jAhLYyGLQxodKKzabXPuNFyJjhJFznCzvT
	d0aX3+Zgrmz+ZeMtyQY6FrdL9TC8aqqGAVjMEjaRqtVGkeSIYlnwbFdXIRu45qpw7OzGTk6+mHG
	UHxM2qyytjeafvxASmVXQoDetJl1XaggjIBdVO2z4skoY+swufPRb0cMhovl0qfs+zi1b4WZPSn
X-Received: by 2002:ac8:7e81:0:b0:530:42d4:4c9a with SMTP id d75a77b69052e-5327eedcdc3mr1871861cf.44.1789508292024;
        Tue, 15 Sep 2026 14:38:12 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123beb4884sm8674896d6.37.2026.09.15.14.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:38:11 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: selinux@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] selinux: avoid 64-bit division of inode numbers
Date: Tue, 15 Sep 2026 17:38:08 -0400
Message-ID: <20260915213807.481355-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823; i=paul@paul-moore.com; h=from:subject; bh=pec/vIP9Y4ghGZSnWp8fj/yDqGkS3PNts325pWorIjo=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBqqbq/v+zYYVJ/CexG4TaumCENuRWlsdtL/h0cc 1aeSKBBoEqJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaqm6vwAKCRDqIPLalzeJ czi4EADf+N+fRI4ynZCWuRHerlqQqHdGw/xo6Lszf1muTV1IOGATeedcI7EAByRPHgKs6EOoeke sdb1UuypmFDJQu/4fu0XoRCZ+eF8CsnoT4mWH+n/o5PHNrk2pIicItV0R+4fM+cZQzi9StLHhJF vwgryDKdKArZeR8H5bY9gkKeJhGBaqrLcDQp0rQpkUjqAQ9QCnYttmD1ik90IvbGctyKWfRD3aJ 8gh8pz4JN63EFAUpfkliy2uSAlL8CTyKvI5j96n7rqToIgxSfQ19cKKlUhMkryIaavFWtDkAfI4 Z/cSVfBe397W8Xj4CZBDP+FwtIWaJxPcuROSKWfSxsO8RXC6LMXopkDNvXKGIIY6cXD4Od2fNyz VpbhcJW9Z3CadFwOFUbvarA9Mu1crMJGsl2KplmmHDoE/CXu+EV4O2P7D3HbqHRvzo4vnVOKhMx 4yZpD6/MWOs/w3xAdn1Pz6kkfiag9IQNYtfCxMqUJ3oTFnpOUVxU+pdgn9LzUmBtXVgfygxzqfQ WLVcW8LlP1HQup42l4dHaHYbrlAtkb2oz1NxsEPGyhh7C+XjZWfrAptH41Ita/kLen4E7rirHR/ UIyczJflN/jq96Lj3JcV23MPfUQI0c8zCdB5ObS7ovwWqrdwI7E5pfrV2RbZCycliuUwv6k6z0C YbZljVVmRKSN+fg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

As reported by Arnd, a previous change to convert the selinuxfs inode
numbers to u64 to match the rest of the kernel caused a problem on 32-bit
systems:

  arm-linux-gnueabi-ld: .../selinuxfs.o: in function `sel_read_class':
   selinuxfs.c:(.text+0xdcc): undefined reference to `__aeabi_uldivmod'
  arm-linux-gnueabi-ld: .../selinuxfs.o: in function `sel_read_perm':
   selinuxfs.c:(.text+0xed0): undefined reference to `__aeabi_uldivmod'

Since we don't currently use more than 24-bits in the selinuxfs inodes
(see SEL_INO_MASK), fix this by applying the SEL_INO_MASK to the
selinuxfs inode numbers and casting to a u32 before performing any
division operations.

Fixes: fc68b6a45f16 ("selinux: convert selinuxfs inode numbers from unsigned long to u64")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/selinux/selinuxfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 292302eb60f3..d864c314c873 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -1574,7 +1574,8 @@ static inline u64 sel_class_to_ino(u16 class)
 
 static inline u16 sel_ino_to_class(u64 ino)
 {
-	return (ino & SEL_INO_MASK) / (SEL_VEC_MAX + 1);
+	u32 ino_masked = ino & SEL_INO_MASK;
+	return ino_masked / (SEL_VEC_MAX + 1);
 }
 
 static inline u64 sel_perm_to_ino(u16 class, u32 perm)
@@ -1584,7 +1585,8 @@ static inline u64 sel_perm_to_ino(u16 class, u32 perm)
 
 static inline u32 sel_ino_to_perm(u64 ino)
 {
-	return (ino & SEL_INO_MASK) % (SEL_VEC_MAX + 1);
+	u32 ino_masked = ino & SEL_INO_MASK;
+	return ino_masked % (SEL_VEC_MAX + 1);
 }
 
 static ssize_t sel_read_class(struct file *file, char __user *buf,
-- 
2.55.0

