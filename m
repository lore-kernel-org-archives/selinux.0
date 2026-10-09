Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F23F58EA
	for <selinux@vger.kernel.org>; Fri,  9 Oct 2026 05:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791525461; cv=none; b=kUAugh4sUV1sOsnZ3fTWp9LDo/xjhAR5+7/7ek32s6iy2aqjVza9lqIOhDdZit76OdpUDj1LKMIWKe4HhmKqcGvoS63KQ0srxSWoJp33yx9+pPrkveAJvuTBsZnl5Zfd7eWnQBv7F/G7hNb4HL4XFeWd+8Be8vmvDIV+7rr9xqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791525461; c=relaxed/simple;
	bh=gwK7COpmh1DGrSrHtmZdR3/y7VZ8ifRurO00x4NOKO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K7uCiTV+lF0HioJJ9x9bHeXuejFvffjrxZu0/cRS3PnQPlnJhHi+oZv2NOEjSeH2Tu8mY8/pAtZqZqMPm12f2nwx0ou6+Q2hZ12DzkDaAh5nnxnXspPWuQ1In2oGr74sW7wG+D0uHy/yDoNXb5wftCdnaWcNX8AysMGFNxYEG9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2533d83e3bso598453866b.2
        for <selinux@vger.kernel.org>; Thu, 08 Oct 2026 22:57:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791525458; x=1792130258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EP5TF+1lZILGSJhmIyFYsOTAm6QMG91unIgi4oqKPAg=;
        b=gWszYK3grXOY5QYNtpOcmHnKsCHcIZgJgCJR6jpxP/d1qzzIGQXGSD+auV4e6S/k2C
         r+TB6/q6Wy+zCcWI3XgWvTgo+VW2sGM0nL53u/cPNA6ha673C+tB3QCcaxLXdoxyDE4k
         7zGC5fl3M7gr+hzaMKrPmaodnwFwFSexCazu7x4FtvaPlM8tofqUBIJ8lYGcMFFf865K
         LEiLeCHdPCENV2kjzz0t4K2YhpWEpvo6EMGiQ7WJUoKXZQciLOaZJvHXCrQ6+p4k7Rv2
         9dM8lOAM0+TRknUMHM6Pk9FKEv8Ev0TECvyKW2f7BVY3i0lPMgVt6JiaeInEm0GOrmAw
         z1Gg==
X-Gm-Message-State: AFq9FYIw06DMHi1vSNueLQuWkPXzdaG/35sLTNYn0MPPD+vhVJkzTxjh
	tEERtOvDB/qrvGS9Gpr7S2RaLt5WKP88iTNxECOt0KndarHul3DiXlIU+hMPuC6K
X-Gm-Gg: AYBFou2SobQ7W66MeqgC+vV4HKtIoEjTC9Zy7fM5VMU5cQVD8hZCwBch4MVCbME++pL
	au5AR0Uv3bM7ouIdZQ7Cyd8vtcZGEtLnhBkYJGFQpu4YkDXWIxnAtstZnFl8Ku60E2f/4kEUaVL
	Y41fUgfPfGGboPyqxvnFTq8OglQs40Ce7WBGs6aqvbJlnOf3r2B2MnWfDvkmEC+IGy2THPHYrI3
	9x9m9WLPGgT8VfS44PsKjTkwNeoOS6AwDxe3llR1om+ZPZD6ag6FYAddsvCRSoSMHPMN4hLJvfG
	yKYf88COtHbuGq9hFIOGSFK/Nz9zxloj8jRZTlkWlrdYRktJZL4nO305LPG9YsbydvQhW/NywBJ
	CNdOzrPOEyChB4MvQ3LE8N2eDSQVM1gTOCYXPDuQi01j9tL3gNcurEgnl72FstDuqzWLwHeDmBc
	y5rVc6RRU/wSCRuPhR1qkmTvqsLpS5qqpOs1hU6+4GoyQG7CW1bf8Mq/7dH7XHXZ3sHN2BcAzCa
	aOCeqy2hdm/mF470TyZLrxzojfvUrkXw9k9vZICOA==
X-Received: by 2002:a17:906:dc8c:b0:c25:2688:8212 with SMTP id a640c23a62f3a-c31a970483dmr70376266b.0.1791525457641;
        Thu, 08 Oct 2026 22:57:37 -0700 (PDT)
Received: from honr (1594037-cn39285.twc1.net. [89.19.217.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9762af5sm44198766b.1.2026.10.08.22.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 22:57:37 -0700 (PDT)
From: Evgeniy Gorbanyov <esgor@altlinux.org>
To: selinux@vger.kernel.org
Cc: stephen.smalley.work@gmail.com,
	Evgeniy Gorbanyov <esgor@altlinux.org>
Subject: [PATCH v2] libselinux: avcstat: reject out-of-range interval values
Date: Fri,  9 Oct 2026 11:57:13 +0600
Message-ID: <20261009055713.16085-1-esgor@altlinux.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <CAEjxPJ4Uh+_GsevF3xtxeKPkz=KAgwj-=+JNq3Uc7SWrLDq04Q@mail.gmail.com>
References: <CAEjxPJ4Uh+_GsevF3xtxeKPkz=KAgwj-=+JNq3Uc7SWrLDq04Q@mail.gmail.com>
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

Clear errno before strtoul() so a stale ERANGE cannot reject a valid
interval.

Signed-off-by: Evgeniy Gorbanyov <esgor@altlinux.org>
Reviewed-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/utils/avcstat.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/libselinux/utils/avcstat.c b/libselinux/utils/avcstat.c
index 640a7a05..c7658792 100644
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
@@ -122,9 +123,12 @@ int main(int argc, char **argv)
 
 	if (optind < argc) {
 		char *arg = argv[optind];
-		unsigned int n = strtoul(arg, NULL, 10);
+		unsigned long n;
 
-		if (errno == ERANGE) {
+		errno = 0;
+		n = strtoul(arg, NULL, 10);
+
+		if (errno == ERANGE || n > INT_MAX) {
 			usage();
 			die("invalid interval \'%s\'", arg);
 		}
-- 
2.50.1

