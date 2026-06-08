Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667D036C5B4
	for <selinux@vger.kernel.org>; Mon,  8 Jun 2026 13:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925280; cv=none; b=sreyilATssFte/2fomZbncPYwEGpPa+tqLUzjD3zx5URXXjl2dYB5KwxosD9SSfdgyT8jT8LbCWuXxAVTJxoYbo8kuMK6IdnYRsvxcNwtBBQvowaFJXUC1RC/o8T8Kjg3UQ2OjJNSdkkTx8KuTxhetEk+mUqLIh7fuUtO+n4lIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925280; c=relaxed/simple;
	bh=ABVXayvL84AWM08bk6LuwgBCEco/YP9GnQUi57PKXpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vk9goR7KhBltNTknyXL3e+jHeMl/gEaSW8Rs1Uw7ZnGdXvrajEhRMuwb26x8au+6m6z26e0j4JHs781gzmCJdvTluwQNi7Mb7zN6wfKti5poFHBfu46wSy94/NjxJGSugO+UGVZah0XK1hkBdQLorhBaZbSRHfCb3XMRVzFM3oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzl/EtpQ; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzl/EtpQ"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8cce26ee1e9so68357136d6.2
        for <selinux@vger.kernel.org>; Mon, 08 Jun 2026 06:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780925278; x=1781530078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iRBiOQ/vvYhVkn16GyPUdBPuzURQgxyQsxrrRw3Kgv0=;
        b=kzl/EtpQ7N4KY1+xhiwQKfQpAuTKJy0zESKSYdikiKCW4JKt/5UUfDxQlZv75wzV9/
         BailFJ5ZxuDJZqIppYWDLkt/ISbMf+u3SMoPA05iSIE9+yAkxvXTlmeaAImFSN3+6UHd
         en8cEMGESApt8oK8jb6Yxh4fVpgGa0Q8rDMCDhHjkjt/EkLcjFzMPM/1o9j4rBb9r93Y
         /8ddZSiUmQ/0D6gRKFkSk2wrPR0BKOSl/VQKPbmaRGjlsdvxb5NpSAKSp5mtu4ohVriy
         gMLKf65dMkT7BK0d1jpHiL1l/lDMO/WrkW9oBQ5YLYnnFBqXQrBGLvzACT+HsSdW+GS1
         ncKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780925278; x=1781530078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRBiOQ/vvYhVkn16GyPUdBPuzURQgxyQsxrrRw3Kgv0=;
        b=KdPAWMaDGcW8NrlBkkHlQ0+BixEc+/2+9rrXNpdKb5XpXxoGj5YUWWu88efUSRqD8L
         dAwD2KUG9aEf0hK5d9LvzLo7RfcCm3iVGNSOxdMxHx3r2aSRK2RNivK0+WalKm+0fpqM
         9AHs6Xt21gq6GHBitTDwKWpulXMdAd82D/0rOsMGwj9LyJSpbQidpfxsZM7facUfl1pr
         /8bfqetZZ6hwP1doToub1TUj/W91Zt0cs1aSppPt2LwdhI04X0tpRJMFFvqwPOrl8r+1
         opm9L/kDV9vUaDMC5/dValOpuKmSREnSv7c23nUcdn58aa4DmWGHL1tZ8Y2ayORyjYe/
         FRjw==
X-Gm-Message-State: AOJu0YwCdBU1svZy5Jq9Yam401ye54c/pttTeOuxVlLO8LSRwSD2bOBI
	Yd/TYAFfQRtOIT82GqdxyhlVwvA17MvOAHZ3m5NhyPtisqqHLL2cg6uhNk1Wag==
X-Gm-Gg: Acq92OFDqb511U3S/aRkSGYgG5Aize/fn5kOp2FffTefsR+Ns2cqlQVeideZ3eIszBb
	jLwLN203ydWKvKhVK+hE1OKfN8rSABEipt4sy20FN2QhNYRsf5cLNe66pLCc/SCGvjgt0pReEmC
	fQ1b2i8Wa5d3daHLX/+sXiAcq0FGep3JDrkk7x4GlY5IsZlOIyc21uWjokbv6O2m5bJpyfiKz8F
	QVhisftodaLxhmhw5v1aCTzG52MxHeYlXRnzTJ00uREZwIkGNkRPyQltj22mZIiYSFdGiEQiBB3
	eESDaF9XuDcpTK7hAp8IAPq4TD2p1K/SysE4TsrXcNIqgmom0QC8Bgc5H05l7PL5CMEx/u2Xytb
	yT0VH9rvbhAvF16T9E8KNyRx6U8I/ckhOe2PCSfhCbw6ER5Wl2P5Gn2KWiJfaSIKlqPxknR3pfu
	VpjJjOT515r3fn6h6sf+wzaAVoD0sxl8udDBYAYBhYe1YtLAze7nVohLZSZeV7zIs/BZ7trFHEO
	q+qCbbYgWOBpUH+51LC9WUXIatcnsNcu0KfgA==
X-Received: by 2002:a05:6214:aa6:b0:8bf:6a92:84b2 with SMTP id 6a1803df08f44-8cee5fe6944mr165370286d6.13.1780925278237;
        Mon, 08 Jun 2026 06:27:58 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccdb93d8sm169711706d6.16.2026.06.08.06.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:27:57 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Yi Zhao <yi.zhao@windriver.com>
Subject: [PATCH] sepolicy: set conf.substitutions['releasever'] to empty str when releasever is None
Date: Mon,  8 Jun 2026 09:27:41 -0400
Message-ID: <20260608132741.309092-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yi Zhao <yi.zhao@windriver.com>

For some distributions (e.g. Yocto) that do not provide
system-release/distribution-release file, libdnf can not get releasever
variable, causing conf.substitutions['releasever'] to not be set.
This will cause 'sepolicy generate' command to fail with the following
error on these distributions:

$ sepolicy generate --init /usr/local/bin/foo
Traceback (most recent call last):
  File "/usr/bin/sepolicy", line 702, in <module>
    args.func(args)
  File "/usr/bin/sepolicy", line 569, in generate
    mypolicy.gen_writeable()
  File "/usr/lib/python3.12/site-packages/sepolicy/generate.py", line 1302, in gen_writeable
    self.__extract_rpms()
  File "/usr/lib/python3.12/site-packages/sepolicy/generate.py", line 1268, in __extract_rpms
    base.read_all_repos()
  File "/usr/lib/python3.12/site-packages/dnf/base.py", line 554, in read_all_repos
    for repo in reader:
                ^^^^^^
  File "/usr/lib/python3.12/site-packages/dnf/conf/read.py", line 42, in __iter__
    for r in self._get_repos(self.conf.config_file_path):
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/lib/python3.12/site-packages/dnf/conf/read.py", line 109, in _get_repos
    parser.setSubstitutions(substs)
  File "/usr/lib/python3.12/site-packages/libdnf/conf.py", line 1643, in setSubstitutions
    return _conf.ConfigParser_setSubstitutions(self, substitutions)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
TypeError: in method 'ConfigParser_setSubstitutions', argument 2 of type 'std::map< std::string,std::string,std::less< std::string >,std::allocator< std::pair< std::string const,std::string > > > const &'

Set conf.substitutions['releasever'] to empty str if releasever is None.

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 python/sepolicy/sepolicy/generate.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/python/sepolicy/sepolicy/generate.py b/python/sepolicy/sepolicy/generate.py
index 780a56b2..0edda54a 100644
--- a/python/sepolicy/sepolicy/generate.py
+++ b/python/sepolicy/sepolicy/generate.py
@@ -1322,6 +1322,9 @@ allow %s_t %s_t:%s_socket name_%s;
         import dnf
 
         with dnf.Base() as base:
+            if base.conf.substitutions.get('releasever') is None:
+                base.conf.substitutions['releasever'] = ''
+
             base.read_all_repos()
             base.fill_sack(load_system_repo=True)
 
-- 
2.54.0

