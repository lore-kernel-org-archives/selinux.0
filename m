Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13553164C7
	for <selinux@vger.kernel.org>; Tue, 14 Apr 2026 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776192011; cv=none; b=ibz/WOeovZMaP+T/EkryNIT3qtha0Hw1ka3ZX8MhQIWTgrxGr8NuhfnwtRc1iO6qDlNCMJ+brGazwVuEh+IVkAfsEa5BvEzfxIztUsc1P30b++HM9Hh8VlRvVzRYOf/s6jRmVSlSSAzH5W1IExua2Pe4PJaWT63cLYcdnjPASJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776192011; c=relaxed/simple;
	bh=+nJMICvr+2Nhe2AEqOEyRZeOkm7KMN3SvNM2HgMBed0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rlYmhhH7fglXY9rEPkPw0vYu3N/qcutN7xdeEpF7xJLlux6k+zZOgg5UOT+fU5/92cSE02ZCJdvpOegrFUTZ/4K4/MAbmu8so000WiajuwlFS7j7S7QftiasQ8CZzvgg5qyv23ial3jlx2zX2q7Y2F4C6fCQHqi7CoYTvesrFWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk; spf=pass smtp.mailfrom=posteo.uk; dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b=p2DedOnN; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.uk header.i=@posteo.uk header.b="p2DedOnN"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 3DE78240027
	for <selinux@vger.kernel.org>; Tue, 14 Apr 2026 20:40:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.uk; s=2017;
	t=1776192001; bh=IeKb0Pfvy4uGekT9wxSfHc3NglPi73yIeLzwAZ1GzBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=p2DedOnNIlzGtsNceV/J3s9p+8fQRdwJmRhhJTsPSV0ZmsQU+5/lDx6STYviRkI/r
	 NMNYoWx5AEh2ChE7twZISRP+C/cPMMJea/uyOXDpajo8vlkMpsL75A8CFcJ/alBjiV
	 xsz6HmLtAHgX5PWADSrk+LlTOJlnRnWspvUr6JJaoSmPwRoIiHl9SNaBCstplC2Gru
	 HH6xb1kJGR3LMkkzzZkD52e87gaOhTy8W2bWCNdnQjZos92L9r3cbcOFyteg2EjvPP
	 BvXgfkfE5Z0kEZIFmxIpexUwVnOY/gcU/xDkkFSXLS4SmXCITyODInh8Zx5g4sW22L
	 MHafigMwWhTDw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fwCkS1DFbz9rxG;
	Tue, 14 Apr 2026 20:40:00 +0200 (CEST)
From: Rahul Sandhu <nvraxn@posteo.uk>
To: selinux@vger.kernel.org
Cc: Rahul Sandhu <nvraxn@posteo.uk>
Subject: [PATCH] seunshare: guard fallible function calls by checking retval
Date: Tue, 14 Apr 2026 18:40:00 +0000
Message-ID: <20260414183946.3867493-2-nvraxn@posteo.uk>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1497; i=nvraxn@posteo.uk; h=from:subject; bh=+nJMICvr+2Nhe2AEqOEyRZeOkm7KMN3SvNM2HgMBed0=; b=owGbwMvMwCmc0Xus8aefgg/jabUkhsx7nZ9YfJgOvtKeq7g5aSJvnJJ291exXpfFOed3t/55t PP2OvlLHRtZGIQ5GSzFFFn272O7UfJ07u+jT153wMxhZQIZIi3SwAAELAx8uYl5pUY6Rnqm2oZ6 hkCGjhEDF6cATHXvJcZqlhauxWoyO+e7mimF7egNyYlTdd/VKNe59M10tT2uxyyYAr64vvB3SZV 9wX/JYXJNGydjQ9uHlkeTl1odlTlQ/G958Hu/I5sKZxafXqWZ7yWYs95Gc5uryJ1vrly3PFIX5c u+OfM0FQA=
X-Developer-Key: i=nvraxn@posteo.uk; a=openpgp; fpr=BFBE06D874E59DFBC5E4EB88688DC681F94E204C
Content-Transfer-Encoding: 8bit

seunshare currently segfaults is passed --kill and an invalid context
via -Z.

Signed-off-by: Rahul Sandhu <nvraxn@posteo.uk>
---
 sandbox/seunshare.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 2512a18c..e89a9fec 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -679,9 +679,19 @@ killall (const char *execcon)
 		return -1;
 	}
 	pids = 0;
-	context_t con;
-	con = context_new(execcon);
-	const char *mcs = context_range_get(con);
+	context_t con = context_new(execcon);
+	if (!con) {
+		free(pid_table);
+		(void)closedir(dir);
+		return -1;
+	}
+	const char *const mcs = context_range_get(con);
+	if (!mcs) {
+		context_free(con);
+		free(pid_table);
+		(void)closedir(dir);
+		return -1;
+	}
 	printf("mcs=%s\n", mcs);
 	while ((de = readdir (dir)) != NULL) {
 		if (!(pid = (pid_t)atoi(de->d_name)) || pid == self)
@@ -708,11 +718,13 @@ killall (const char *execcon)
 		if (getpidcon(id, &scon) == 0) {
 
 			context_t pidcon = context_new(scon);
-			/* Attempt to kill remaining processes */
-			if (strcmp(context_range_get(pidcon), mcs) == 0)
-				kill(id, SIGKILL);
+			if (pidcon) {
+				/* Attempt to kill remaining processes */
+				if (strcmp(context_range_get(pidcon), mcs) == 0)
+					kill(id, SIGKILL);
 
-			context_free(pidcon);
+				context_free(pidcon);
+			}
 			freecon(scon);
 		}
 		running++;
-- 
2.53.0

