Received: from mx208.easyname.com (mx208.easyname.com [212.232.28.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7C3346AFB
	for <selinux@vger.kernel.org>; Thu,  7 May 2026 10:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.232.28.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778148732; cv=none; b=cG9UAHVVr7Q6Er/9mAV2/keMCrmlKSQStFtOSuS5KlfDjSRmNu8hN7N1YopfEtnFxEM4QIBT9PYX4bePYOYNRGq8uQ5XpO4elDbvc+40HypHZGndbQAMdy/FNWtCf4qZjxDnr6Hdbn1lE9s/MydkFGqWdIOaIJ+fkQgjms7aFoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778148732; c=relaxed/simple;
	bh=J4FHcQWhhaU7wOaeTVMzT3aSylFfIz1qeXi1zrRdC2w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gQNGMqTKi4C5xvZI5bf5vRNZDC90o3O4LzMxhHw4Wxt2idksMmb+kgMs/H+mhiBl7kGPJOAE7nT7AQNRHZ7IrPpHx3J585KfgqR7E2S4r3xDDyUUU8KofmnWIXy2T7HMvjWuVi/6rsFG7gM/C2uHUel5qxhPz50JXIyNXav0qEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peppergray.xyz; spf=pass smtp.mailfrom=peppergray.xyz; dkim=pass (2048-bit key) header.d=peppergray.xyz header.i=@peppergray.xyz header.b=o/4hYSGm; dkim=pass (2048-bit key) header.d=peppergray.xyz header.i=@peppergray.xyz header.b=o/4hYSGm; arc=none smtp.client-ip=212.232.28.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peppergray.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peppergray.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peppergray.xyz header.i=@peppergray.xyz header.b="o/4hYSGm";
	dkim=pass (2048-bit key) header.d=peppergray.xyz header.i=@peppergray.xyz header.b="o/4hYSGm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=peppergray.xyz; s=easyname; h=Content-Type:To:Subject:Message-ID:Date:From:
	MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=J4FHcQWhhaU7wOaeTVMzT3aSylFfIz1qeXi1zrRdC2w=; b=o/4hYSGmt7FORNJJH8mSAdTlNF
	uBrzh34/+xqTx4P+FKHe4OChC2zrWS6hlamqXWb4XGIMKXrVLuBj8zqyYtlaXPmiELEsF1bYaFYm9
	BwVRWJTm+6aWvo2df+DBqzBncBOXhdyBhJA/vCr9uuFoefkCep5h9ygUD9vuTZofsKCqwFEATfnb9
	mj9x6A2ssb9YKvICzlvNDjTlO1gP6KkA++NlW3lTwS4O/P4iKVin79G5DQxkiuz7Bqb8LEnc5cGaz
	Kj2MZXkvO3bdOlcj4KXwDH50CeROYZqOfZgV6/h/WqUaGbm33tp/T7AJDpbMwlR3JaJCG/e7dvrqJ
	tvvEOszQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=peppergray.xyz; s=easyname; h=Content-Type:To:Subject:Message-ID:Date:From:
	MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=J4FHcQWhhaU7wOaeTVMzT3aSylFfIz1qeXi1zrRdC2w=; b=o/4hYSGmt7FORNJJH8mSAdTlNF
	uBrzh34/+xqTx4P+FKHe4OChC2zrWS6hlamqXWb4XGIMKXrVLuBj8zqyYtlaXPmiELEsF1bYaFYm9
	BwVRWJTm+6aWvo2df+DBqzBncBOXhdyBhJA/vCr9uuFoefkCep5h9ygUD9vuTZofsKCqwFEATfnb9
	mj9x6A2ssb9YKvICzlvNDjTlO1gP6KkA++NlW3lTwS4O/P4iKVin79G5DQxkiuz7Bqb8LEnc5cGaz
	Kj2MZXkvO3bdOlcj4KXwDH50CeROYZqOfZgV6/h/WqUaGbm33tp/T7AJDpbMwlR3JaJCG/e7dvrqJ
	tvvEOszQ==;
Received: from mail-ed1-f45.google.com ([209.85.208.45])
	by mx.easyname.com with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92)
	(envelope-from <hello@peppergray.xyz>)
	id 1wKvPc-000F6i-KC
	for selinux@vger.kernel.org; Thu, 07 May 2026 09:52:57 +0000
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-678adefbd26so1127296a12.3
        for <selinux@vger.kernel.org>; Thu, 07 May 2026 02:52:54 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz42ALJWEzfV8gojCeZTohItFkdCGYv18bXj8RAGEPJoOXONCvs
	E+p4ozPFaeVw7TwUlEMaxoL64MUFYSQdninq3zyB5VxMUbbWPOUgobxszLOgu+78up6bGiZhE5g
	ihm/TawHCgNvx3pLpfVYghJwPGuWdX6ydhZtfsFngwQ==
X-Received: by 2002:a17:907:3e0a:b0:b98:50b:e94a with SMTP id
 a640c23a62f3a-bc56c92eda4mr460193066b.16.1778147574304; Thu, 07 May 2026
 02:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pepper Gray <hello@peppergray.xyz>
Date: Thu, 7 May 2026 11:52:43 +0200
X-Gmail-Original-Message-ID: <CAHLDejyMAktQhBkfJrvz5OrS=d7WSSe4pFA33qKJALtH_nWafw@mail.gmail.com>
X-Gm-Features: AVHnY4JXMtUVDJvf8NVYToQRrkeaLlD4a0skpjDV1c8AaJYLTMHFUZ_hJFVEsEc
Message-ID: <CAHLDejyMAktQhBkfJrvz5OrS=d7WSSe4pFA33qKJALtH_nWafw@mail.gmail.com>
Subject: [PATCH] expose alias for stat64 and lstat64 on musl
To: selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From 0471d76499aae8f44cb21c7faa1609e0387abafb Mon Sep 17 00:00:00 2001
From: Pepper Gray <hello@peppergray.xyz>
Date: Sat, 11 Apr 2026 15:08:26 +0200
Subject: [PATCH] expose alias for stat64 and lstat64 on musl

fix: #477
Signed-off-by: Pepper Gray <hello@peppergray.xyz>
---
 libselinux/src/selinux_restorecon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/libselinux/src/selinux_restorecon.c
b/libselinux/src/selinux_restorecon.c
index 8425a3c5f..2ccda300e 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -19,7 +19,6 @@
 #include <limits.h>
 #include <stdint.h>
 #include <sys/types.h>
-#include <sys/stat.h>
 #include <sys/xattr.h>
 #include <sys/vfs.h>
 #include <sys/statvfs.h>
@@ -29,6 +28,10 @@
 #include <syslog.h>
 #include <assert.h>

+// expose alias for stat64 and lstat64 on musl
+#define _LARGEFILE64_SOURCE 1
+#include <sys/stat.h>
+
 #include <selinux/selinux.h>
 #include <selinux/context.h>
 #include <selinux/label.h>
