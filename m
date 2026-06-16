Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6D03A1A54
	for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781620600; cv=none; b=Z2mSN7Z7v8ftwtpDTWb4zjJZ4C/vww3RGWaS9nLirUS1h3zGsUD2674nEcijrOD9w/4P75pmZ7mrLSqJrmws3R0RLbf9cxnROVEcexv+cCkZZWckjgbNUgGMTawvJuHfdI8oOZZe4HctaTq+cKmGdqEAiZykxuIy9bwyIGHy1o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781620600; c=relaxed/simple;
	bh=//Ct6Hy6c1omoYgXCtovT9gs1xA7JzPxKptUtln5rYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eSkReiE8gp2HEFCZn6t0ex+yCvmqvWm/1Cr7VonL3ymP3bu8q2snJC8gRZY0Oro4rLugD4OgG3JZrItfh/9hG0IDPh8x9387x+wiozCgWh1gk2l0k73aC+GcEyTc4pUj3TEa+D2Bywss+MWI95T5ZnjS3eDFoNuZ1O+wA+gzugo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJW+WzfK; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJW+WzfK"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8cce87d7995so51219816d6.0
        for <selinux@vger.kernel.org>; Tue, 16 Jun 2026 07:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781620598; x=1782225398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BFcD++Ca8Dl3BVnc9ztQXC5fqd4fis4SHN8fk5WT+eQ=;
        b=RJW+WzfKinAEx9XUDcODwbYPyw1GD3TjmneCuwe6wXkvto/OTqWRVl57ubSddOj5K5
         /+kZ0Gouv3mBT5kIiQUW/654tvinTs8kEns9pnyYlgdq946r4/nrpSxei3sRIa5yO49e
         CbMsOBW+dFwt4ePC6+Mo6iuzfcpwkz6M2I90eZQ/OENln3G7zWiaYPvvWV4a2ulcj1Nn
         qAw3w9xokdadxCBydSYUYLB3/8yrMQUHWM82x153ww//xCvjOyY1fkHmL/6dp3kzyUGc
         DDJsTZ9quCppFRcD2nKvgGmdGc8PyyIbRt2X68X0hMUU6piJiHEvwfGN03LY1hXhGW0Y
         srGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781620598; x=1782225398;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFcD++Ca8Dl3BVnc9ztQXC5fqd4fis4SHN8fk5WT+eQ=;
        b=aasbADht015I3SpTcYbtpzh8M82txorSc1Jhi9lGtLCUl+3GX90LYt27zzMD+E1eG1
         9F6RWmF0kizSvUu30NVldn3wvFyHVn3ltgrbmuwTZ8IiENTuJGZWE7B3k1tlwq61oMax
         XHDHKF8JvaPKlxjFve6D8ay4dv46B3TqK0TZKSD/dNlGU6T0dagPJQercAMR9X+lbJO2
         noC2LwqXu+7mj2NRN1uximv8tpw7+2qDseKE7U6Oi+k5ua5NSqET25CQBlTqCSf7cFYX
         jB09x/Yud1LonYIgwefLhyfebnXaonPUhFXUafJclX2FtjES/HFcNKhJVDDurEjySwbN
         iyKg==
X-Gm-Message-State: AOJu0YwRByd2uyjujB1pAxHe2hzCCVlmzplcDo3EnGtin+yJ1TlKyQ/F
	tMgPzrUvMOMF8ysX3SvgjzAPr4QFTpS4Di31Y6RvwWHa2yL8UxoArSyFrW5nnQ==
X-Gm-Gg: Acq92OF08NdzZ54rK3VRTPL/KqDxCpQLFpJG3/WQ8E/azPTvHu3hybcbhtzzI02nU1t
	gkOHb+8nDPCCDcvDVph8s8AobywXSe/sQ1c3yeMB0ELT8g3mlaD0+1dSJ2k14EbQh1yN6WNG0mQ
	6KWHdw3Yc39HD3CHr5Xv725LUiYIImi+tyhHkjNWrHfI45KB6EINPhyKcEZuGF6UAeAmMX/7ccy
	dov+gM95uX8xpA70gFBLpbprdpNEqULli+JMi9IqYaTV6Dz3ilz52A8T81irW+i4BBScCgJX5Gb
	dremiUZHJslFehzSXlBEfqB9LJjdC9xnLVH/8aY1BuOumCgVReJmOx1phYhKUSPXGwdoagR0TD2
	SFOunSBL7aUgXBM7qd8o8HYy9qZnNv4hHmQvx5+b29nn6pBShrfOuiCbkPIn1WAD+YUKgd6Rn4L
	fOSeHE0UnKX+xH4+fVe381XzNV7Bb3fiTBu3Dn8gX3RBK0U7BW775DfKN8ejaf/HULTinXPzEux
	qg3G6+ukuA5ked9fbRwzuRMW5A=
X-Received: by 2002:a05:6214:5084:b0:8cf:8b2:123d with SMTP id 6a1803df08f44-8d9fb96abb0mr72666706d6.8.1781620598016;
        Tue, 16 Jun 2026 07:36:38 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d9f18f31d7sm35488546d6.12.2026.06.16.07.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 07:36:37 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Pepper Gray <hello@peppergray.xyz>
Subject: [PATCH v2] libselinux: Add EXTRA_LD_FLAGS for musl+llvm builds
Date: Tue, 16 Jun 2026 10:34:54 -0400
Message-ID: <20260616143453.54781-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce an optionally defined EXTRA_LD_FLAGS variable for use
by musl+llvm builds to pass --undefined-version. This enables such
builds to link despite the intentionally omitted
matchpathcon_filespec_add64 symbol.

Fixes: https://github.com/SELinuxProject/selinux/issues/512
Fixes: https://github.com/SELinuxProject/selinux/pull/513
Link: https://lore.kernel.org/selinux/871pe7n3w3.fsf@redhat.com/
Fixes: 9395cc03226a0 ("Always build for LFS mode on 32-bit archs.")
Reported-by: Pepper Gray <hello@peppergray.xyz>
Suggested-by: Petr Lautrbach <plautrba@redhat.com>
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 fixes the missing comma issue noted by Petr and shortens the new
variable name to just EXTRA_LD_FLAGS, moving its use down to only
the line where the linker is called.

 README.md               | 4 ++++
 libselinux/src/Makefile | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 5e65a049..ea8c4e46 100644
--- a/README.md
+++ b/README.md
@@ -151,6 +151,10 @@ set when overriding are:
 - -fno-semantic-interposition for gcc or compilers that do not do this. clang does this by default. clang-10 and up
    will support passing this flag, but ignore it. Previous clang versions fail.
 
+## Setting EXTRA_LD_FLAGS
+
+Build with EXTRA_LD_FLAGS=--undefined-version to fix linking against
+musl with llvm.
 
 macOS
 -----
diff --git a/libselinux/src/Makefile b/libselinux/src/Makefile
index 9982faad..9ecdbd4d 100644
--- a/libselinux/src/Makefile
+++ b/libselinux/src/Makefile
@@ -7,6 +7,9 @@ RUBY ?= ruby
 RUBYPREFIX ?= $(notdir $(RUBY))
 PKG_CONFIG ?= pkg-config
 
+# Set EXTRA_LD_FLAGS to --undefined-version to fix
+# linking against musl with llvm.
+
 # Installation directories.
 PREFIX ?= /usr
 LIBDIR ?= $(PREFIX)/lib
@@ -163,7 +166,7 @@ $(LIBA): $(OBJS)
 	$(RANLIB) $@
 
 $(LIBSO): $(LOBJS)
-	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -fPIC -shared -o $@ $^ $(PCRE_LDLIBS) $(FTS_LDLIBS) -ldl -Wl,$(LD_SONAME_FLAGS)
+	$(CC) $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -fPIC -shared -o $@ $^ $(PCRE_LDLIBS) $(FTS_LDLIBS) -ldl -Wl,$(LD_SONAME_FLAGS)$(EXTRA_LD_FLAGS:%=,%)
 	ln -sf $@ $(TARGET)
 
 $(LIBPC): $(LIBPC).in ../VERSION
-- 
2.54.0

