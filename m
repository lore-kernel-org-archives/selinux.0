Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB1A1519B4
	for <selinux@vger.kernel.org>; Wed, 13 May 2026 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778689337; cv=none; b=u8cAzyuaupnXb42dsw+WWzS6D4As7DFQ3Qi6UP1VyopbP2lORwAA/yHTqTflSuv2yu//6LXbaZntOlY6TOx9jrMQwwuG3bB+qfeKQJOHjSkSHBNtaluBTCtM+qrextjsgcSl1sL9TJYcxT8P7xKb2+cMd/LzXuDw/JAGMW7E6/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778689337; c=relaxed/simple;
	bh=YYDmIPxL9wT+lR0NJThNEi2gtnvvOUpYODSba7lnSqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MQLWvDN9Wd1cODtfA432f1t+F4UktIS88YBUQdv0XeyX7Itmf5+qV3sutC31eoIdxGVwIO+d2jfdcOrxVBW5EpPtqB7aYhtCelgxH1Lzd+AcNQQ/4zGZMGCs6Q9bxJxUtt2ttFKd32TfZ3bIrwjfHalwQoRh9QWEwz1Ff9oB3Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bElGLlBk; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bElGLlBk"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50e5dbd8e0eso70296151cf.1
        for <selinux@vger.kernel.org>; Wed, 13 May 2026 09:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778689333; x=1779294133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jc+jX2wFrnKqlC4qCehvvHUTApjTN/fWC2qI8GYpdV0=;
        b=bElGLlBkrXEjH+WY4e8ABYABfnvfthC5bjNSkFmGwuazF9jqhh305U7Tr9yPi5Kzap
         K4j39787+dxLNPIkNf0gsDsFoZrtvrh6v03NFdYnX9N9oJ2NchnKiqK1KU6r2xhCyn3M
         qHpALXajTkXbKO6CtkX5EVSciUiYvfpiQfiYs6kIZLy8s7PcDzhC3f8qhI4EnacbwrTq
         aMz4cAAusbJQ3ARpNJKAqEjUEQbXdMPU9+D9TfquRHpheLQ8jg3bBqLtWvHid5xvdC3D
         1DelxyTwyf86EYQYMnuagJbJjwrWp8hjAqWLoN711c5oHeoOhFhdNQPnqtA0JGs0x7Iq
         qw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778689333; x=1779294133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jc+jX2wFrnKqlC4qCehvvHUTApjTN/fWC2qI8GYpdV0=;
        b=JpPX+zh6pb6gmfLrYUN5tOropgzEosM8bZf/181rnf8jcwyL5ram0UbMeQbMmFdVAo
         nA/EdquzYZSu+Sd3aaCxIvi+RWmFK7cfSRn55eNJgng7R8KOAqgATe87UhbbiUUj/ymn
         K6MZshdI9CupOkOYAi5HREAsmMkrTZ/DH6q46KYvm+F7YvYk8Gw1koiH+KbYsdsL4HnG
         IQqKUTyjZc1klDExfc4SqvqyYV+Ezdv6+PCk3f96BtiZuYZioF5/QFT46YsQ5ECon9bU
         Dki0+Ov3VNLDTHxrIvJw8WMZoznsY5/cgJZOFsIxKu01Da1KA+qJnZFOM2yVIrtROKQy
         wR8w==
X-Gm-Message-State: AOJu0YwQ2DjT7FIKV7L/EV3o5HVO7schC/eyVh8GkJ+PfyNYotXis6eC
	j380NsDLIUpWRZWvG1x/92BHxIBGi6OkNAXW480MXZ7kr9Tv/Pc5UJgVwZjnPQ==
X-Gm-Gg: Acq92OFy/ykIax/fdolf5yle9uIy/7qtJqE07zsGqKbA5vIk8IT+A8aDqT4n+vvb3pj
	ZDC14O/dORzBmLHXA8EiwZXTXMknxYtFx7qN4gxWuqck6wTZkrllXIzLkd1fxwuDZXpTM28LZQc
	ErKLfghUEygPJgg4jDxEoSTm7mN/6Aox1RlNJhCk9hvkhojRMeCceFxyeZ9oMbqi6z0s1LSHlsm
	f5RSNi+8M0WXMdPRGXa+12fW7YWHAuGsLclMqrvS0+6ExEpSKGjK6vHwK+MFyiR9niwWlzEtObX
	BUxly1h+bn6fccxM1Hd/Ubp8PxvmvoerODQa9hLZrW9Ppf/9V/VLuX3EqafZGxFBW3YLtAY7dnN
	TOaF4KyNGUFkQNg/3twl3ecDx26qA7hB4RqIiuuGIU3rkkzEqZUGraes8tSrMB5W2b0MCEsKihB
	N73Fth73AUm9gp553N4igr8JH3zXi/8Pcwkk9ikk1EqD6Q1WjuEWyfW3p/fpwnVLc/wJLOssGWF
	OrH8tuzOawLEi7rNVMUrfS3B08=
X-Received: by 2002:ac8:5e51:0:b0:50e:5752:d1bb with SMTP id d75a77b69052e-5162f43fbaemr52884271cf.4.1778689332545;
        Wed, 13 May 2026 09:22:12 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5149bf65846sm136022341cf.19.2026.05.13.09.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 09:22:12 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] sandbox/seunshare: fix killall() realloc and missing type comparison
Date: Wed, 13 May 2026 12:21:47 -0400
Message-ID: <20260513162147.42276-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.53.0
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
 sandbox/seunshare.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 2eef0e2f..5ed690eb 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -681,7 +681,7 @@ killall (const char *execcon)
 	struct dirent *de;
 	pid_t *pid_table, pid, self;
 	int i;
-	int pids, max_pids;
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
2.53.0

