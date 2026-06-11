Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E423EAC9B
	for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 14:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781187087; cv=none; b=n/43hcoEeJ+ypze+yApLOGImfyQrzdEXWgNKsa30YJ6aZW6gawpQcbq2u6+006j/MSWslKS1u4dz+P+fH4KCp1cZEceN88W65de/mHsV9oQAgGVC49tF5R3CG0LT5G/2TMfps6iIFhtGXGyvUz1ovanDmcA3vSrciFPSDevxcTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781187087; c=relaxed/simple;
	bh=Gfh7ABrMRQjef6yMd697rcTgbb6rZKC0koiZbJg0ixQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JhbM81am4RRQ+hXV7F2QbXhO+u7z5IRlgN+YeQZrCxiqf20S5bstsM28xVlfAqHjBlve1E3gNwIxcymLJz9OpNMWGEOef+hDkLR60c4YFwcWaFJm9IdQZ0op7tOo3NMqjo5oiSK+3D7MHYvKlbJ54GbvuhE67x0k0RbvQhv/glQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMgRfTKt; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMgRfTKt"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51784eb2ba0so61329731cf.2
        for <selinux@vger.kernel.org>; Thu, 11 Jun 2026 07:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781187085; x=1781791885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X56mQyH31rH9X5qOR1YQu7XPLyQ0qZMT9MlbX+7bIiY=;
        b=jMgRfTKtF1ySwzvTV9Z8Mz/PCUSZiQ2/6J4GqL1P+css5dV0SpAhLjpFSdk5dJCq2x
         CGe5FzeztrkNcVV0VKz4xbbbFJ6LTLH/HqwJzMVKTch3mKDGk5UoR6PSQeplU4joWB3T
         yZ0OOU1IrtLWYx/qp2OHVwoevi6uRfLuII+yGag4FYZWSHH81AXg2avGgeuaKr9wQYHw
         34RVocmqOpb1zmT60I1WDoCcBDCMVhSBOT1+plv9kCO2EulniqZWoqqK58v51JIvhOQ6
         T6HGU4moPkkzq+A+8yk4zJ9EnMnmOw0Ew/PTqHK6Jhj2dt4KsmYZ5v0RTvpkLDCnFwTz
         LpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781187085; x=1781791885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X56mQyH31rH9X5qOR1YQu7XPLyQ0qZMT9MlbX+7bIiY=;
        b=QZJsPZov8HO/BOz3rtAqAl9ldIHmpDv054NHwg8tliOuElMW381AXaoRk8akAFMN69
         b0yIWtn9cs/v94nYcK6lCz3KxTLsiGjzcYr8KlYTrGHPGPcWkOu56BpmwhWtNec+M1F4
         mT3a2YwN8pdCYRBb3dD8lvZlORlf4HaKNR0RIiT7nCOZVoMpCwuJRPRPrlyOo0XQnn0b
         p6FOXrl9cTSbJCb7+YRcTKUX3Iom335WsKQ5PQuyYjbxnYA71IXYxaYiC0lkHLsnOGIh
         wjfDOu1+/5qko52eXqLWf3/Mh/OHPRObtCfZbtPXgss4eypKM5c9bdnrgBRRQHiU+TXc
         3OPA==
X-Gm-Message-State: AOJu0YykCmpcW2vE+g0PP4Lc9hf3GH48y9sBv5U6S0mALvpM682BufjY
	fCfa2FhJoAkwgBfI6cwhoAV6T3Xuw7Xsb5t4qbls8ekQLLRmD2V9iRD6h9PklQ==
X-Gm-Gg: Acq92OEFKcgkcWp0R/No3jQYV6QCS8fq1IaS6GjLcJsDXAVGYDfbKjYHZXSVkmAn7h1
	u3H8pKFLz+9IDEHSeHgCXfKfCgif0IqaZTIdd9Rbwp7gfHWhHDLTe9IPwfdKoe3MOcDrOT0cHw6
	mZfXBqWu68/pey443JD1owE3s4lH5J2KdznDWqkPsb2HtsFAsuYFWbSTee0gFf/hHxxZpVleyig
	vsnpprzs/M/3/c1sGmKMFQpE79+Qy2UrEFWV9LiyTMr66QmA839CoZxZcGVcJgKe5l538GyLnOt
	6Dub7YIbvTszXJYHVzu39pO1A9PlFta65rfElanuWAy0yVw/al2+MVHiTQKKRdgOclN13GCnhbh
	mIJ1hI+Krki1rmfwmJCDECIAVOeIYe9dX02FlgQZX1wqhF+ZvU0uBMYVKBckl/1Jh4oEO8wwXq7
	lUxgnuPD41zkzoo8HyFkIjXKsM5noqa/uEnCC/00AmxMQHLI6RVW6WkpKOWIJ8jopvjWWj23cnu
	5cDg9IyweaoGlaRDPR4nqkmnTun9rovHDWNKA==
X-Received: by 2002:a05:622a:488a:b0:517:94c2:1459 with SMTP id d75a77b69052e-517edd0d098mr46785801cf.3.1781187084797;
        Thu, 11 Jun 2026 07:11:24 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517ef620e44sm17844061cf.22.2026.06.11.07.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 07:11:24 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [RFC PATCH 1/3] libselinux: selinux_restorecon: use openat2 if defined
Date: Thu, 11 Jun 2026 10:10:59 -0400
Message-ID: <20260611141102.17893-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611141102.17893-1-stephen.smalley.work@gmail.com>
References: <20260611141102.17893-1-stephen.smalley.work@gmail.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update selinux_restorecon()'s safe_open() helper to use openat2()
if defined to optimize the lookup of the initial pathname. Fall
back to the existing per-component lookup on ENOSYS/EINVAL so
that pre-5.6 and seccomp-filtered environments are unaffected.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 libselinux/src/selinux_restorecon.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
index 0159fb7f..ee78eab0 100644
--- a/libselinux/src/selinux_restorecon.c
+++ b/libselinux/src/selinux_restorecon.c
@@ -25,7 +25,11 @@
 #include <sys/vfs.h>
 #include <sys/statvfs.h>
 #include <sys/utsname.h>
+#include <sys/syscall.h>
 #include <linux/magic.h>
+#ifdef __NR_openat2
+#include <linux/openat2.h>
+#endif
 #include <libgen.h>
 #include <syslog.h>
 #include <assert.h>
@@ -1114,6 +1118,25 @@ static int safe_open(const char *path, struct stat *sb)
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

