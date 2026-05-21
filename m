Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9D433987F
	for <selinux@vger.kernel.org>; Thu, 21 May 2026 15:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779378902; cv=none; b=kakk9SWNj/7w/C9hR6/jRCPiGdLPZuj2wNWskL2trpyL6I83bBDyWvl5QNE2OlIVqqyV23cimeChxH9U4yoVknRVhPG60cGQVR4QJ+1SplPNyjpn05zBIaSLSv7ZI9G1xWMVw9Xx+FBUve3gY6KdD8OnpH/9IaD2b56iIuEYZN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779378902; c=relaxed/simple;
	bh=/H+vjIGB1gFYAqYNJ0QzvIKcmjmmL7mPKgC3T5EtjfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eEo/HjWOO38HG30xwXacfOj0q9Mn5NfG82r6/6eSOS1/Bnl30qpq/TiSFGshRQXHiZc6zt0JW7R9L0piaP/9qavJ/x/3dSiiFHKbL70Xb/2/s7ay9NCX8PKlDWo/n9Khh1HSMnd9RXrBZ2rOpNARCqs4Ou6b8chMeDMdtXzcqi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8CipqvS; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8CipqvS"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-911488599e3so716858985a.3
        for <selinux@vger.kernel.org>; Thu, 21 May 2026 08:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779378900; x=1779983700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ofL731wO7JP1SSis1EXfnAptcNaFtflLncqlLWuWbzs=;
        b=H8CipqvSvoAQet+ZOH53UjCZfEyh6evUCHc8jgTN7hOhKUVpLM1ecATpJnfyGdCVEs
         m4OhQnhP9jjnKQara5hJzI85LCjBbvmMvNYqizMn7RuBXrpzOk/GEHRwuRdJ9Yw4f4yL
         lCCihmcRGHUookVXnh6ygsIRVFmV/oq7zrycBt249GgzoRQOusrEWNP6bPIMgBSa/8tH
         g5AL31nT/418UuGI4RC9CQxYXcx0Pg+kTLJjkC7vHTlM81ITpjecG0rNnqg4RimGU02o
         LiCjYRWMvac4Ai/rOJC4XO9aygUcxtpd93OxwM2sMaxzQv1GUjtn1s4wHsHfvN5HHk5B
         nRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779378900; x=1779983700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ofL731wO7JP1SSis1EXfnAptcNaFtflLncqlLWuWbzs=;
        b=Ar1sgDflh1N0oiCKJIvsF+O99n2rY3ByDOeapRs9JBe64GTHe50y11/JIiQTWGzZCM
         EmEJNi6NQoe9BJjfMirMQ2Sed3pZAEl+7J2Fw473kB2vBdOVI0BW/YxHHqFVzImszsQb
         Yr52c1W4B/mr94mTnUWMuOCtobVz/cv0v92DjPItgf5+QoXmOGgeFcjZvA0iRx72iZoL
         Tkb0Uvm8C8UJ2iK1KMWwCH1hhG76h4O60gYptbDTxJ5CfCRZ3iYzNf1iKO/Vw9VpHWjf
         /pSrpS8NtwZdlrFUMklRvxONTndSYGBFtIZ7V+WsO8A2O9mUWjkO0bmAvDM+Sa6XGrTR
         BbqA==
X-Gm-Message-State: AOJu0Yy+59GvzNx2P0EsHHGJNWxReGCAw0Uqvy210Lb4Rx1tZ4R5/SjH
	4uKqzQBU0JMoo5DhKdaNbqfjmaKi20LL7AkYH+e8FO5MKpiqD1CA1XD8RYt6dA==
X-Gm-Gg: Acq92OEGgQMGR3nzJtASKhGku5z7LHVUGY0Q2HcPT43LnzA9owmRcdbKkeWOzggk4+q
	fyQFn/YKul3OfXj/d68rSUNB4cW0RU1yVTBDSG80A/MZz4/N4/GrrVI4J0q4mevpUHqfeJCxGM3
	BH6Kcp0z+tI+HrJY2Lf3DFzymZEXZv9ew+paeYIHK+niJV9MUyMeSFRQhdIJm0drAq8rHvNwl2T
	iqnxM6qh2JT9bb1WUIiaustPJeYgYGfOrS/E/G7hV7+3nNn6DhbK0w6rjzu1P00qW+KSl8x+GCl
	50wN66kZffC2pjV0EG4xndiNUU1KiB+j8K70RWx6WA4AMRgH/0TU574SHF+XIG+LgKYVE151eri
	DStaKZtN7smahpCd6P2WL1Br0OZG2DBtw+so2N2c7tZd3rKFF5yeEFmLOnFEvQUY0dgJ9/aYuUT
	3Yq4kMbM0F9kkEe1NS0kz00EA7YyEO3CDRRPQyiHhAFDJ26gvle+y0JvJEVpGmDsYVdjK5TD68u
	B271XZ/+C7pbblt6tmzSUb7lXI=
X-Received: by 2002:a05:620a:4713:b0:910:4023:4fca with SMTP id af79cd13be357-914a2a6e149mr472350985a.18.1779378899573;
        Thu, 21 May 2026 08:54:59 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914abb9e7e1sm122925985a.23.2026.05.21.08.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 08:54:59 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] sandbox/seunshare: drop -k/--kill support
Date: Thu, 21 May 2026 11:54:44 -0400
Message-ID: <20260521155444.27110-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the -k/--kill support; it is fundamentally racy, redundant
with killall -Z, and seemingly unused by sandbox itself.
Provide an error message to the user telling them how to achieve
the same effect via killall.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 93 +--------------------------------------------
 1 file changed, 1 insertion(+), 92 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 1d13d261..a4454027 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -710,97 +710,6 @@ good:
 	return tmpdir;
 }
 
-#define PROC_BASE "/proc"
-
-static int
-killall (const char *execcon)
-{
-	DIR *dir;
-	char *scon;
-	struct dirent *de;
-	pid_t *pid_table, pid, self;
-	unsigned int i;
-	unsigned int pids, max_pids;
-	int running = 0;
-	self = getpid();
-	if (!(dir = opendir(PROC_BASE))) {
-		return -1;
-	}
-	max_pids = 256;
-	pid_table = malloc(max_pids * sizeof (pid_t));
-	if (!pid_table) {
-		(void)closedir(dir);
-		return -1;
-	}
-	pids = 0;
-	context_t con = context_new(execcon);
-	if (!con) {
-		free(pid_table);
-		(void)closedir(dir);
-		return -1;
-	}
-	const char *const mcs = context_range_get(con);
-	const char *const type = context_type_get(con);
-	if (!mcs || !type) {
-		context_free(con);
-		free(pid_table);
-		(void)closedir(dir);
-		return -1;
-	}
-	if (verbose)
-		printf("mcs=%s type=%s\n", mcs, type);
-	while ((de = readdir (dir)) != NULL) {
-		if (!(pid = (pid_t)atoi(de->d_name)) || pid == self)
-			continue;
-
-		if (pids == max_pids) {
-			max_pids *= 2;
-			if (max_pids <= pids)
-			{
-				free(pid_table);
-				(void)closedir(dir);
-				return -1;
-			}
-			pid_t *new_pid_table = reallocarray(pid_table, max_pids, sizeof(pid_t));
-			if (!new_pid_table) {
-				free(pid_table);
-				(void)closedir(dir);
-				return -1;
-			}
-			pid_table = new_pid_table;
-		}
-		pid_table[pids++] = pid;
-	}
-
-	(void)closedir(dir);
-
-	for (i = 0; i < pids; i++) {
-		pid_t id = pid_table[i];
-
-		if (getpidcon(id, &scon) == 0) {
-
-			context_t pidcon = context_new(scon);
-			if (pidcon) {
-				const char *const pmcs = context_range_get(pidcon);
-				const char *const ptype = context_type_get(pidcon);
-
-				/* Attempt to kill remaining processes */
-				if (pmcs && ptype && !strcmp(pmcs, mcs) &&
-					!strcmp(ptype, type))
-					kill(id, SIGKILL);
-
-				context_free(pidcon);
-			}
-			freecon(scon);
-		}
-		running++;
-	}
-
-	context_free(con);
-	free(pid_table);
-	return running;
-}
-
 int main(int argc, char **argv) {
 	int status = -1;
 	const char *execcon = NULL;
@@ -1253,7 +1162,7 @@ childerr:
 	kill(-child,SIGTERM);
 
 	if (execcon && kill_all)
-		killall(execcon);
+		fprintf(stderr, "-k/--kill no longer supported; run killall -Z %s\n", execcon);
 
 	if (tmpdir_r) cleanup_tmpdir(tmpdir_r, tmpdir_s, pwd, 1);
 
-- 
2.54.0

