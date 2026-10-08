Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765A03D75C9
	for <selinux@vger.kernel.org>; Thu,  8 Oct 2026 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791444462; cv=none; b=MRVvUNcpcGzpRzlO6rxF2q6dFcVcSOhR9VZjNgeTZcckuLTFc/ONWQEul9suixz9fPAkKrU1VQUoPAIx89Q2b71RHhIUhl75luWKcFMrwrj6g5P36fSPIC2PzWBqlThi8GtKv1B+aQ9yxAofZMIsB9URk1yb3jGZnLNv9gkyWlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791444462; c=relaxed/simple;
	bh=kNfftGTuyKr5UntzEV5eXUutzYGpxdkwWK0DHyoWc3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rWqq4xzEMgFShVgjTSix2vtwIeZ0KztJCpybTvxXNXDKoYE/yn3AKTHygyEgYjsd+3m9IYzJMJ0OshMCUWmteD3d/HwOFC9IUY//imbhUYsW0ql/XrHGn4dfDdk4LQ3IUNxViExOkDXL12xIbdD0sybmese94/dv84yuZBh5Vmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c315869241fso533044566b.0
        for <selinux@vger.kernel.org>; Thu, 08 Oct 2026 00:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791444459; x=1792049259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w2s7XFT1LYOjmY+81we/LCYwtE1UWFZH0fAjqntC1Tc=;
        b=2tg2wvLv/dm2E/HvsYy9f6OOPUmSZZBuZQx1tY/Y+T3uJjvM2vPEVw/fi5D4oqYUdc
         LbJuxrRgdILyQSSAUkr3DNSbLDwAQQTlb63JVbGApGKl6jaxURVvSVqokB+U2Jy0Yvfk
         6/GJVGBpQfFXS6+gJ95v61kOO9R4PHaPpT9pPIhtZtkhudabCtbBZQ+NPXVuYCHcv7/2
         KE4QPZbl4Bi6+TcVj+8cyrNDNQyOeI2w08wp1ndI3s0q1pWGhZZY8PxIhdWi9LYOMNO5
         WTsbb1hVCAqYvoLvs5gsAZjCurmij43l1/kaBaFSU9K4q4VH5cgxd9xvBVd66YGiYxdO
         69Aw==
X-Gm-Message-State: AFuF++ltKrgh3+6SmT1lk29nG01scKHXS/0b95V2iNlSPX1+0waxrbnG
	s7L71q1Qa6J4lqgrdSvRT2VH2drMI8eCUyNi0L9kPSxjkf6yRzuFMhvzP6ZhNA==
X-Gm-Gg: AYBFou0GXFhUEdMkKssvwnO7Tmm80FjcQhokjUr6jdZA6yUmYoxANeEYYIS6VOqug4q
	z/bzY6uNuGzDBzy3nSTsFak8dEVdbtNJ/QlVb3xy+Ve+gTUjXncrqgpmDdyqGpX7XUUtHSZJaGD
	d68QudPzauGLjh+PaHYB89CmO8dKfRSWbPo7jKQEeSWnMpBuGl4WgsOv+VOcHYs0Kva2ngt1hL7
	qRyYf6VBohQuNU88pTY3wnwZ3oXqc240J2juk6Uik+UeCgE3fOcZXMveBMLe5nWDXN8Hf05twVb
	dx1Q8Usd9j7Am0qCN2cygFaleHgh/gyQGint666ihFC57vX6yAWTjKEwQYiDYwrr+CwZXDMBA2I
	fHdc+12pRhpnVt/VBPuz2brQW4BMg+S4XiZS9EvfoTPCl0/XkzBW4y4+6xxgUx20RUTdw3mL/rP
	KcvUFQgdLxrsX6w+sg+ANyXBYQ+5Fj9NakXTC1XjlyEnNXFi4GMFP98jxYgCxX6cWXE+qY9ivTA
	KvzT6V6ZsExYc49v8L5hiLd2cHfDkWklXi/vimCog==
X-Received: by 2002:a17:907:9723:b0:c2b:7686:4d7 with SMTP id a640c23a62f3a-c317c121daamr403731566b.39.1791444458594;
        Thu, 08 Oct 2026 00:27:38 -0700 (PDT)
Received: from honr (1594037-cn39285.twc1.net. [89.19.217.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c317c2fd772sm186095766b.54.2026.10.08.00.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 00:27:37 -0700 (PDT)
From: Evgeniy Gorbanyov <esgor@altlinux.org>
To: selinux@vger.kernel.org
Cc: Evgeniy Gorbanyov <esgor@altlinux.org>
Subject: [PATCH] libselinux: avcstat: reject out-of-range interval values
Date: Thu,  8 Oct 2026 13:27:10 +0600
Message-ID: <20261008072710.41831-1-esgor@altlinux.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strtoul() returns unsigned long, but avcstat stored the result in a
signed int and passed it to sleep(). A value above INT_MAX becomes
negative, and sleep() then treats it as a large unsigned duration.
Compare the full strtoul() result with INT_MAX before narrowing it.

Signed-off-by: Evgeniy Gorbanyov <esgor@altlinux.org>
---
 libselinux/utils/avcstat.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/libselinux/utils/avcstat.c b/libselinux/utils/avcstat.c
index 640a7a05..0c534f51 100644
--- a/libselinux/utils/avcstat.c
+++ b/libselinux/utils/avcstat.c
@@ -13,6 +13,7 @@
 #include <libgen.h>
 #include <stdarg.h>
 #include <errno.h>
+#include <limits.h>
 #include <string.h>
 #include <fcntl.h>
 #include <unistd.h>
@@ -122,9 +123,9 @@ int main(int argc, char **argv)
 
 	if (optind < argc) {
 		char *arg = argv[optind];
-		unsigned int n = strtoul(arg, NULL, 10);
+		unsigned long n = strtoul(arg, NULL, 10);
 
-		if (errno == ERANGE) {
+		if (errno == ERANGE || n > INT_MAX) {
 			usage();
 			die("invalid interval \'%s\'", arg);
 		}
-- 
2.50.1

