Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2E5385D64
	for <selinux@vger.kernel.org>; Mon,  6 Jul 2026 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783348665; cv=none; b=HUnrRNxR9RX3whBwTcfrSsY0CzaS+r62rvTQ2zLUPapb5hQBaGkHuXoycUxyinPYh1V84jZMjJ1Uvv2ASEv+kzuSJeEn0D7q9OjwYs6FjxCmuMZ5c+WA8mDQJpBU/zRgEmajHBwe3Ju+zjNS9/MINyg+CdUuw9i0xcCozbSGI4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783348665; c=relaxed/simple;
	bh=tyyZTtgtMensv5yfz5/z2QK0pJ0OFf/Wd0uhFziNSIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LWXkryR6jp5QM7Vl2SyU7gpECZKMI7G3aHAxESalt5R5quQDC23BNmppn35YSwU88aumTDm62La52m7KVIXg6fcFbr+akAEwqtFVaELC8zxdn/Yvwmh3WkoJMGeZfdDiB9R9epbw7hoiEN8REPDCciDc0zEZLVAuZb7lymccKs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlbQeaxX; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlbQeaxX"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-92e6391b114so221699385a.3
        for <selinux@vger.kernel.org>; Mon, 06 Jul 2026 07:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783348663; x=1783953463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4L0jUpsmYtg9dUpxVbKcdgEf14yEqW3MQHsIYNv4rs8=;
        b=RlbQeaxXI2Y7MDOdCtjXv6EcEadoeqEt8CTIIuxTwGA/W0rU2L25Eqk3v2fE/JT+Eu
         td9IKsbrYJSD61JlDS8q8p/Cp+YoQM+ra8aZsNj/Sx4W4matwwfxnNat8sw9FKssmyRs
         9N5Bdt8RDCPPsWt1D/ueRsbAvZv5HfHtHWUv22xzQscDjEMSIGUNz1MU3sD7wZOBT/Bq
         s5xInvuhuvq74tOYV2CpwUrSxH6MlWuNHcREir1OjOAgg7m6KUuVsq2JIWwKG5yaxXlO
         2vJ2egjTohcF+je4t21qO6Yk5OqC8Ma2EpovZWTobC7xJMhRMtNwIUD7lvbX8uuuLScd
         KtoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783348663; x=1783953463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4L0jUpsmYtg9dUpxVbKcdgEf14yEqW3MQHsIYNv4rs8=;
        b=f9aHU0cy6CLndTLcyTJNHS6C3ZdM9a+T7CTkE2yhBlS3FY0ZppB/JdYgkBpHWCVhNO
         hN6ZbF55z0SzWqKYnOJkCoQ6maYjpOU0SPdn89nmvvq1djM9+YatCwtbNmAMhvdNgOez
         SdZHA1n37RAT8XkNdkz3wWOYHapxGLryUHmIJt8pX/I2AYcnCLyjTyDr+Gt6921XjOYT
         M3TWjZjjt4A2jRz9FpZIly8VB1UyZGVYRN19QrL3H40YD0NaJxwDRRVmGefa+d3FwzsX
         F8vN0Bq8ZInI1CUk3cc3YRWIBzdkMfRxo4A6WlWLqrWIgPUC78LyKmqTMMX2lxZQ8+ka
         sw3w==
X-Gm-Message-State: AOJu0YxQt6AP4w8z1PtBsBUk7ho467BJpCRcunnh9J3GqwPwcAaDV2nB
	BpzGYQzIW26ZbP6FxSUuUzwdaEeBbikCGNrd8m8CS5qawUyFi4Fdww/ByPcH3g==
X-Gm-Gg: AfdE7ckjAA/nqwCRfA1Bn8byowqDvbVCVVk3Tg21BGPPpwgOhUjB+WEv8ffPKQJ2dXs
	9EFt0m9O8uZwIsnHpzAm2ZWR5vaClIJkACUbfbb0l1+d5noUOGdQ7uC/B0X2nv0kzI1GhfzsQ6P
	16aK6sN8M9dbKKux6WiFVe3VEXZYwYZ9+Zv1c3gw8qFwobyAMu40CeJnXP1T+LMqFlcOlCz9Q4M
	USsAB4qPrYi8HAIyYW8DuiqB2oH5XKyk6YABoZLR0JMDKMHv/oWI/sGctaVvRJdQ2dC5fZA8oVg
	NVUqhEslDEpBwItFFC2CvT3ILQM9ZGQP3bYSXz+/O1/3unXasFWIN2Rsa6xidT2duZm6g4m5hoC
	9ZNaJTHJWy/ieCHKo+W74MBAizp60O0bjIVaSIz8ZDLv/TlrUt3OaEwu0c3BpBEqAC7X3a6wCP4
	B8MBs70wFN7YfM0SbLk1SmKMEw+iEIb5SG+KMLxW3i0vDPcT3YtkoqH8Va8PzGkgUqvXgyyaGMa
	vH8MHOamvd1U4hQjzV5CbgarLQ=
X-Received: by 2002:a05:620a:3725:b0:92e:64b3:3464 with SMTP id af79cd13be357-92ebb60a5b3mr126030385a.54.1783348662635;
        Mon, 06 Jul 2026 07:37:42 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46f304533sm136972416d6.18.2026.07.06.07.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 07:37:42 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2 2/3] restorecond: use openat2 if defined
Date: Mon,  6 Jul 2026 10:37:25 -0400
Message-ID: <20260706143726.47421-3-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706143726.47421-1-stephen.smalley.work@gmail.com>
References: <20260706143726.47421-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update restorecond's safe_open() helper to use openat2() if defined to
optimize the lookup of the initial pathname. Fall back to the existing
per-component lookup on ENOSYS/EINVAL so that pre-5.6 and
seccomp-filtered environments are unaffected.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 restorecond/watch.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/restorecond/watch.c b/restorecond/watch.c
index 25918fd5..18bd90db 100644
--- a/restorecond/watch.c
+++ b/restorecond/watch.c
@@ -12,6 +12,10 @@
 #include <glob.h>
 #include <libgen.h>
 #include <sys/stat.h>
+#include <sys/syscall.h>
+#ifdef __NR_openat2
+#include <linux/openat2.h>
+#endif
 #include <string.h>
 #include <stdio.h>
 #include <fcntl.h>
@@ -72,6 +76,25 @@ static int safe_open(const char *path, struct stat *sb)
 		return -1;
 	}
 
+#ifdef __NR_openat2
+	struct open_how how = {
+		.flags = O_PATH | O_NOFOLLOW | O_CLOEXEC,
+		.resolve = RESOLVE_NO_SYMLINKS | RESOLVE_NO_MAGICLINKS,
+	};
+
+	nfd = syscall(__NR_openat2, AT_FDCWD, path, &how, sizeof(how));
+	if (nfd >= 0) {
+		if (fstat(nfd, sb) < 0) {
+			close(nfd);
+			return -1;
+		}
+		return nfd;
+	}
+
+	if (errno != ENOSYS && errno != EINVAL)
+		return -1;
+#endif
+
 	copy = strdup(path);
 	if (!copy)
 		return -1;
-- 
2.54.0

