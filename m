Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AE93CC7FB
	for <selinux@vger.kernel.org>; Thu, 14 May 2026 12:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778760925; cv=none; b=W1ZSpzCIiNRZ0wBbrw/rE8q6+Bd73VtOMkIrNkm0tqSOxVGVWVa9rW0NavQfdwT80ziNLIodoQtQAMsPfHcK+r2iu0G3KwQawapOeyOPa64ctuAwndpePzpQBagYF/Z4Y5SVQVweLrAMEpNUorUqH9sB5wUCzMxuSlriYKIuB7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778760925; c=relaxed/simple;
	bh=Nfjd3eF7kGLaR58Gbzk5jYFO+EqwHCmrELBNM6m5zmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K04bn6KSTg3exntx8wZpV0R3F25qCui2suATUhZW8+d+mx9lWdw8/LkDvYzaJYjuD37QldTqVy34rFP0Bn+Wx0kZJm0FigGH3bcLwbB7jEAj/TwaEyCSsPMOuy2nMVy2fOtZctLdZNGnD/DWHTTaLG94mgphSRUnLEeJ2SyuHTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJxYaOGO; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJxYaOGO"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899a5db525cso49237496d6.3
        for <selinux@vger.kernel.org>; Thu, 14 May 2026 05:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778760923; x=1779365723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PmUfIQGkBxH4+9f0HZoHMJFQRC9G5pbx26FxOYwf2HE=;
        b=XJxYaOGOYmGWgZl2ExaORfCG9E51eUUeVYi1enEUiGRpA6KcWa5viRvGk6HMQYXG2M
         vUlk6C/sFsOGrO9sht+D1RR0u9f7sYOE/B+Q6WnIohMEBKaQCx4LxSjrAin+e7dDmADb
         ZoT7jQp2bb0O4jpOEa6pEz/LtOtHH8ltgbfAANSTebvwod88Wqax7bfCYZvpkxKz3rjk
         mGzaDTjn5cms2HNc8kKRlHMSxlrtyP3ZrPnrIMgvWYSwUQNVUq1ch+fKqhnntTRSx/uJ
         eue/I2XvPIG8MXWDPfMIHa1WtLv7CKqOAApzlOzuKGrMcWwaF3oIGvpI+0NUlXW4EH8H
         lMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778760923; x=1779365723;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmUfIQGkBxH4+9f0HZoHMJFQRC9G5pbx26FxOYwf2HE=;
        b=pYOTqs9KxWhCXIt46h0XrYv+qiyMwg+pJFopC72ER5aaQwtpSb7hlShQN2xksa6r1z
         kCGWZUbpPVD5lGzWEr6i1/kjE5DWDpOXUHTSLQ8RSm7BBGMV/dGBU8wRhffeUX4VPx16
         yiMObkhmMqKUoxwDBV/b38N+P2KvPXR4/uPssB5G8BtDGIIwzyXQNi4V19uVrIW4PFTI
         LC2t9XyMdpEb/azvbTaLt0+CMUCD1L12cT0Tsj4BG2CbSipdpzpyENZEheV0D8iErm/x
         3CriEI9Uw/nIuplNaOTRZiV0VOJ1DqaJzMJbMnryqfgfSGBHTC2FWYB1kei7wvl72sqG
         VgUg==
X-Gm-Message-State: AOJu0YzdgHrxbKgFdqa44rBPBIj2/TKwveQp3PG3h145Ali4F8+Ipl6G
	iLc/exTgPmPQ6D9BcDINuXBALy8WgDhQ82dO9VNNzPpq/ydZLbULJ5LcOcgdrg==
X-Gm-Gg: Acq92OEobMKm22ebByDrAb/w5MOAWbyDyJQ2z/EhSeNgKFW+FdtxDY6F2s78c5UYVVF
	hBPuNIYfQl3cQpGso1w0vmOUefiBXmvgVbIqWNSa9TXahk5QP7xd+Bm/PByl0WKXlUQ9d85smM6
	3fgy1IUZFKfmjcqdHX7GLNDPj5oaPJnk8DVG7HeYNA7jhTVz53QFyRg7t53T/RwqrdftK3K/dcu
	yUZu9LqYpluPzgl2BLHItPFSS/QKPriZ3cfaAxqidR85ZtTipB1D6k+ciP+vY3cO1LEj+JD/GEb
	JGJxA1ME/JPqUWZX5qmJpPs6hm5jz/OluGw9eHghHRJVJBaM8Og78dO7yheVGBXJ3yfV23fMH0f
	yXXtbn34cOaohr2tPSsVtxegc2+Wo5B4hw4KcprO21/LYOmXCNkhi6AtcUdgWWPPRMa6oL708RX
	XkqIIEXEXZE7ne817rc4fQ8pCYkdhKuYdQUXsq3jzWC6MNO29qtYGnDej/z3IzyCEvi5/+mntxp
	9M/2dFNpECXgEFzphyd4L51TwuRRTq+yH9lVBaq9FUGdt/o53cn75hR7Y3FWjYhfg==
X-Received: by 2002:a05:6214:428c:b0:8bd:de6d:c351 with SMTP id 6a1803df08f44-8c7deb44d43mr114513836d6.26.1778760922484;
        Thu, 14 May 2026 05:15:22 -0700 (PDT)
Received: from fuse-fed34-svr.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c9093e6d33sm22385286d6.22.2026.05.14.05.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 05:15:22 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] sandbox/seunshare: fix killall() realloc and missing type comparison
Date: Thu, 14 May 2026 08:14:25 -0400
Message-ID: <20260514121424.10481-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The killall() realloc() can produce an integer overflow.
Check and handle this correctly.

The killall() logic also only compares the MCS category set when
deciding whether to kill the process. We should at least also compare
the type to avoid incorrectly killing an unrelated process with
the same category set (e.g. if multiple applications are independently
assigning category sets on the same system). Check the type as well.

killall() still seems error prone and I couldn't find any actual users
of the -k/--kill option for seunshare. Can we just drop this?

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 fixes the signedness of "i" to match its usage.

 sandbox/seunshare.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 2eef0e2f..e20c0f87 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -680,8 +680,8 @@ killall (const char *execcon)
 	char *scon;
 	struct dirent *de;
 	pid_t *pid_table, pid, self;
-	int i;
-	int pids, max_pids;
+	unsigned int i;
+	unsigned int pids, max_pids;
 	int running = 0;
 	self = getpid();
 	if (!(dir = opendir(PROC_BASE))) {
@@ -701,26 +701,34 @@ killall (const char *execcon)
 		return -1;
 	}
 	const char *const mcs = context_range_get(con);
-	if (!mcs) {
+	const char *const type = context_type_get(con);
+	if (!mcs || !type) {
 		context_free(con);
 		free(pid_table);
 		(void)closedir(dir);
 		return -1;
 	}
-	printf("mcs=%s\n", mcs);
+	if (verbose)
+		printf("mcs=%s type=%s\n", mcs, type);
 	while ((de = readdir (dir)) != NULL) {
 		if (!(pid = (pid_t)atoi(de->d_name)) || pid == self)
 			continue;
 
 		if (pids == max_pids) {
-			pid_t *new_pid_table = realloc(pid_table, 2*pids*sizeof(pid_t));
+			max_pids *= 2;
+			if (max_pids <= pids)
+			{
+				free(pid_table);
+				(void)closedir(dir);
+				return -1;
+			}
+			pid_t *new_pid_table = reallocarray(pid_table, max_pids, sizeof(pid_t));
 			if (!new_pid_table) {
 				free(pid_table);
 				(void)closedir(dir);
 				return -1;
 			}
 			pid_table = new_pid_table;
-			max_pids *= 2;
 		}
 		pid_table[pids++] = pid;
 	}
@@ -734,8 +742,12 @@ killall (const char *execcon)
 
 			context_t pidcon = context_new(scon);
 			if (pidcon) {
+				const char *const pmcs = context_range_get(pidcon);
+				const char *const ptype = context_type_get(pidcon);
+
 				/* Attempt to kill remaining processes */
-				if (strcmp(context_range_get(pidcon), mcs) == 0)
+				if (pmcs && ptype && !strcmp(pmcs, mcs) &&
+					!strcmp(ptype, type))
 					kill(id, SIGKILL);
 
 				context_free(pidcon);
-- 
2.54.0

