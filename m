Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FC6218E91
	for <selinux@vger.kernel.org>; Wed, 13 May 2026 13:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778680127; cv=none; b=g1oc0DLJmVlsT5eEldfKDl4ArK6lEbc6i8UoTQApupJycr7ch44YLCISsQhSlolDoXDlIoLaIqiKw07xdUURnRLD7WdL1fY/T6+hwLYQLYd2+INDTNfjP+YgfHmalcg3BJvcY90BwMsSXxmeGYHht/MnMSBb+M0HBsfMi59A2lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778680127; c=relaxed/simple;
	bh=+0qjM6apYubCJ/mjt9torobtpgLwp60UHpA5VLgYW8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TXd879fvej+NOy+9nUKFOXqD9NVa4xftkuo4YaDNq9TNi3OXtBn643eWkzA9n/XROROomixzEOgvBNTbaJZpVTR/5vrsGUGri+Q9rDcUf9EkCUQ1+8mHW755gBKz5OocDQQKiGD3AxgPvqm8Yee7G6+2pQizKl0N8qvRTbuAlqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dr5MWeF+; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr5MWeF+"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8b7f937ef44so39116636d6.0
        for <selinux@vger.kernel.org>; Wed, 13 May 2026 06:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778680125; x=1779284925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QntYPz1yebYqAJtUcKOd7ecbo47VbAspyKT1U52vyoA=;
        b=Dr5MWeF+gcTM92mn4pu+Qn17vDt/8SYXScf69CFeV1Opn2KVv4naDdhwQNs5pvdxcW
         srQEhVUevjkH1qdC1HJM06Q1ovidS6N+ssyesZm9Mmtd1Jp8maVWBb6PhIpb6rdArGR5
         plFDmz25diDW9PvDpfJFJJcAybBRnz+ISPI7vJT8NlfIrx0zOABJVdGETCAjBZBTcGrc
         QJdx9iwwm1wK/rHsoDF488lsaOmxt0djo1sWqgU8Juhy7MU9T0QZY5LSn4608oENSq8K
         BEA1C7nng7xSL2DZgSuGmHG4fychTCKZpdRqI39CkB8cxYoIQ9Bai0RJkka92NOvD0Xd
         BTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778680125; x=1779284925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QntYPz1yebYqAJtUcKOd7ecbo47VbAspyKT1U52vyoA=;
        b=dhP3zyXXSIu0tznYbNJNh9m3T69cXgzI3Oodani7JENKklLMwii4OLkxjFzYUK5/Z8
         tNyVG9OQ0EDoKBbfmPKI68cfePQlASZIIFXjGpn/kKgdpWjO4t/uylM1zAYnpMuAa1l5
         Vm76tQsCUE7SnSTTKdQHEEMZFt9/d1+XrsLJ+2IBwgUFJs9cY+lFMDJOncO3i6I5BiIW
         +b0tFMRff4cvVztBWltWErHpfjWJlMASpVUeyqzmtfoOKubqpes37ij+1tsVg8inc4W3
         ZNzkv+6gDRbhGVnWugMkjBfJoMKKlzbxhgixDvTg9zd990uSdjqIy+pfojuSM38cq7tg
         xsQQ==
X-Gm-Message-State: AOJu0Yw90Ygx9dqmjxsmZ9c/5DHYLf931OWjCcw66dDjeEGOkYMXA92b
	kmld5I9g2MVRlbcGQcqUtw2iis7L+n12CNzdnWCE/JrdkEbnoHiPn5/rR1BJrQ==
X-Gm-Gg: Acq92OG2ei9RzQVtMX+f2t+3YP3/lDIWhAulY3Gaw4ww0mQJ14fRvZT2cKNwHxyM42G
	juYNEtWNbKvLq0iu7bIJHz9J0Bb9rueAcgkwhaGt89NW4aVlAD8yJ5zc18DNvLUPTX+mWoJrjCm
	ywqbhAdzlMboTj+2dOEaa37DXVGGFXp7lxDVt524yy1h7ai4/4wJipytqNpy2eYz1MVTk56zn9o
	0HmDvAhr+PNM4+GqSdCDlzi1Buvra3OIzmXZFzvOQFSCVW5A+8IDM2gbg78GfH5r0y3JrsCf6IJ
	YeFp9dCoVC7OzJSr/t93akgD5dhKJtw2sppOsHwVRgCvtvRbzIEDFNx+ksIsH6qcKoqD78zNQBY
	ObwHGCWAgGjNZMks3Nx0DYA1cbwdb36llp7Ltfu9PgKRvtJcyULdHhxOHapiO0zsP5FuddYopTf
	WZ0XkgJmOQRusS1PDXztgv53NoIMehyuTRluUksvGHtLMHnvyZc86F7En7xnF60XEyk9OFjaX+j
	z7K+QYxsqbEmRdRuJxZGa30LDvHlsrwksbisA==
X-Received: by 2002:a05:6214:766:b0:8ae:655f:28a4 with SMTP id 6a1803df08f44-8c7df7e56a7mr50401496d6.40.1778680124690;
        Wed, 13 May 2026 06:48:44 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8bf3a71be9csm157954186d6.17.2026.05.13.06.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 06:48:44 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	paul@paul-moore.com,
	perfinion@gentoo.org,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] sandbox/seunshare: prevent rsync from interpreting paths as options
Date: Wed, 13 May 2026 09:47:50 -0400
Message-ID: <20260513134749.37510-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Insert a "--" after all legitimate options before any glob or
pathnames to prevent rsync from interpreting them as options.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 985e0cfb..a48c8803 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -391,8 +391,8 @@ static int rsynccmd(const char * src, const char *dst, char ***cmd) {
 
 	free(buf); buf = NULL;
 
-	/* rsync  -trlHDq + <glob list> + dst + NULL */
-	*cmd = calloc(2 + fglob.gl_pathc + 2, sizeof(char *));
+	/* rsync -trlHDq -- <glob list> dst NULL */
+	*cmd = calloc(3 + fglob.gl_pathc + 2, sizeof(char *));
 	if (! *cmd) {
 		fprintf(stderr, _("Out of memory\n"));
 		return -1;
@@ -401,8 +401,9 @@ static int rsynccmd(const char * src, const char *dst, char ***cmd) {
 	args = *cmd;
 	strdup_or_err(args, 0, "/usr/bin/rsync");
 	strdup_or_err(args, 1, "-trlHDq");
+	strdup_or_err(args, 2, "--");
 
-	for ( i=0, index = 2; i < fglob.gl_pathc; i++) {
+	for ( i=0, index = 3; i < fglob.gl_pathc; i++) {
 		const char *path = fglob.gl_pathv[i];
 		if (bad_path(path)) continue;
 		strdup_or_err(args, index, path);
@@ -495,7 +496,7 @@ static int cleanup_tmpdir(const char *tmpdir, const char *src,
 
 	/* rsync files back */
 	if (copy_content) {
-		args = calloc(7, sizeof(char *));
+		args = calloc(8, sizeof(char *));
 		if (! args) {
 			fprintf(stderr, _("Out of memory\n"));
 			return 1;
@@ -505,17 +506,18 @@ static int cleanup_tmpdir(const char *tmpdir, const char *src,
 		strdup_or_err(args, 1, "--exclude=.X11-unix");
 		strdup_or_err(args, 2, "-utrlHDq");
 		strdup_or_err(args, 3, "--delete");
-		if (asprintf(&args[4], "%s/", tmpdir) == -1) {
+		strdup_or_err(args, 4, "--");
+		if (asprintf(&args[5], "%s/", tmpdir) == -1) {
 			fprintf(stderr, _("Out of memory\n"));
 			free_args(args);
 			return 1;
 		}
-		if (asprintf(&args[5], "%s/", src) == -1) {
+		if (asprintf(&args[6], "%s/", src) == -1) {
 			fprintf(stderr, _("Out of memory\n"));
 			free_args(args);
 			return 1;
 		}
-		args[6] = NULL;
+		args[7] = NULL;
 
 		if (spawn_command(args, pwd->pw_uid) != 0) {
 			fprintf(stderr, _("Failed to copy files from the runtime temporary directory\n"));
-- 
2.53.0

