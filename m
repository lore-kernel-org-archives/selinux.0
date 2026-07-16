Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D943B961A
	for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206382; cv=none; b=Udr8gOF/NmX1Pz4oh6cWWX8peNhjinL6o9jTZ2OQiFJbPzP/mvWCOKiNkreMJ1ohPtFXVZWoGXfXQSCX0Phw0QMitLWBubPJ6N4sk4SE8xnfXwZ3HrdFJY0kjbfsSNRNNeBwfP85/jzx8pvV4m0B+6f5Oq3M1jZJWPmJTubk0vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206382; c=relaxed/simple;
	bh=QKbGXwIUMqdhJ746LzWyd9HFyQ0rxMsKxXiB+LOsRZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cZZ5fgd1IEHmjWfsTrWdkpAXzDgE/U53d9L3asAfuECKgyqEsJzvWGdmjdpb2WU1ox+lTKROVxgP+8bYDZpc1RMJ74dyY/BBYTYJdaVPrh82+j+ZoO0/vjnK7iAkfHUKzeD5ZzUNNBjY3vk9S1qxoGzCFsR7cAMTum1n8ihkIIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2YoLQ0I; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2YoLQ0I"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8f0d6853360so46983596d6.0
        for <selinux@vger.kernel.org>; Thu, 16 Jul 2026 05:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784206380; x=1784811180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PF0//7+y5LelmqiJd7DDeUXyxmifni7v8DGOihu8xM0=;
        b=M2YoLQ0I8CjGmEjNBeJQtCv5aYw3ExMXz4xenxEJBfDsiciRcEvnWTdu+PJm3SIFb5
         8R925YgPToIHsxbLUUj5NlOiYHh9TIVmrf7dt9nIhn4ThNjOXlB8Fq6o28QJ1AF4K8rW
         zP3t0H2mJx8APHWMQUohaO8jp/426iU1YOgtIHzEsu2cRFNC7hSkTdk/82RWXWMHzjPi
         w+xqxcZIe6/zE/E7skqKvGEImvLt22jeKt8KHo/5GeaXXmPmcgjaHi6sMdipDFYfOydo
         W1gOjdHSwGkc/AA9xQYW9mGuiuCjxOjY0+3Xv/IWNT4OQTuxLjreYetrJvmhAz7Lg3+Q
         GZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784206380; x=1784811180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PF0//7+y5LelmqiJd7DDeUXyxmifni7v8DGOihu8xM0=;
        b=dTcKAVBBmXMaLUqwe7koRsLPqft5u/LEChE2a9iuqMu9YrqWrY4XG3RQK72WGxam5V
         YTsk9zbJJ3mj5KLvi0UWa0SkbNdCesb/l9xJtvS9A+xpMTSTiwcnwwHNZwdOOq/c1dlx
         PmcSMWq4d3KkxwLQdyeSFoEO72GguqLjyM9PqAMtr5Gxa41gQv4WayM+7mSN0r56FsHI
         KdGAYlCPN05ZMSOFeaUldvXNZvCfyhq9p3uovvJlrCAl8sI+gJJtRcw0TzNw7tixLCF6
         +zPorOpw1h7Wgewr8XT60ypkLzHnCpFceZX4yoKGTsyJpnHWV7CCfT+aRghDrGqnOgQ+
         EnSw==
X-Gm-Message-State: AOJu0YxETdCZ+FkOHo9JXArUY8t5lya1LyFi7NsrgPL9kmmQTzVCdIWV
	A8mVZLJPnM2Qt8zz2462ahSjB9h6T39UYKS3U8K3XF7IOmYrjmbI0kK41bxbFA==
X-Gm-Gg: AfdE7cmTTyfDjDYhtXJvhQYIQugVimuZhZjQf65e7vD/MA7XrgM9qPLErMWrr910GXC
	+S2gD68stTLvNqfG6hr4LTvMLHg6KCR4hMYZiVdBOHxMUCLqAsjlBvteHR9zlkW8GpgqLub61SO
	xlPmLRPl5cXjvqSDugDcDSy5PI/oR6BzgwJoV2p0XlmJcXfd23RtadJDCjUOMhlX46YJCnVm7mO
	YOMEPODt4rLeFyW+OvqmiKcWvi86g3teR1n3kMsELYOFSgNGXt4/TizcpI8+RhUbVQ2MDNpxLzE
	Po9UVshZfR/AUQ3DdEY4uXeKK7zvFaYnVXA8zqW5/PpnnuS9BW+rrlxOZCr943kQFNCmnudOv0c
	19zh4AOtRBtaNJA36k7LPp5wgDLD+El9zik7wHVRv3XOmGTZV0YiDPEJO3ADg9v+bZ5VZLT5mR9
	ogejzgYsTGqFGCvlGhp6nDAgGTzI+4buFKTNILFgp1p+DMGkFaM7nwBouWpq7X/tCaoleY1DGDF
	MSf8A==
X-Received: by 2002:a05:6214:3016:b0:8ef:25f0:e025 with SMTP id 6a1803df08f44-9074c8928femr120796136d6.57.1784206380369;
        Thu, 16 Jul 2026 05:53:00 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-904116650b7sm196161866d6.8.2026.07.16.05.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:53:00 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: jwcart2@gmail.com,
	plautrba@redhat.com,
	omosnace@redhat.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/2] mcstrans: defer SIGTERM cleanup to the main loop
Date: Thu, 16 Jul 2026 08:52:48 -0400
Message-ID: <20260716125249.6872-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sigterm_handler() calls cleanup_exit(), which walks and frees the
translation and color tables and unlinks the socket. None of that is
async-signal-safe; a SIGTERM arriving while the main loop is inside
malloc/free or inside finish_context_translations() during a SIGHUP
reload can deadlock or corrupt the heap.

Set a flag from the handler and let the top of the poll loop call
cleanup_exit() from normal context, matching the existing SIGHUP
restart_daemon pattern. poll() is not restarted (SA_RESTART is not
set) so a signal delivered during the blocking poll returns EINTR and
the loop rechecks the flag. The narrow check then poll window matches
the existing SIGHUP handling.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 mcstrans/src/mcstransd.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mcstrans/src/mcstransd.c b/mcstrans/src/mcstransd.c
index 5bdaadb7..3db58a17 100644
--- a/mcstrans/src/mcstransd.c
+++ b/mcstrans/src/mcstransd.c
@@ -58,6 +58,7 @@
 static int sockfd = -1; /* socket we are listening on */
 
 static volatile sig_atomic_t restart_daemon = false;
+static volatile sig_atomic_t terminate = false;
 static void cleanup_exit(int ret) __attribute__((noreturn));
 static void cleanup_exit(int ret)
 {
@@ -407,6 +408,10 @@ static void process_connections(void)
 	ufds[0].revents = 0;
 
 	while (1) {
+		if (terminate) {
+			free(ufds);
+			cleanup_exit(0);
+		}
 		if (restart_daemon) {
 			syslog(LOG_NOTICE, "Reload Translations");
 			finish_context_colors();
@@ -442,11 +447,9 @@ static void process_connections(void)
 	}
 }
 
-static void sigterm_handler(int sig) __attribute__((noreturn));
-
 static void sigterm_handler(int UNUSED(sig))
 {
-	cleanup_exit(0);
+	terminate = true;
 }
 
 static void sighup_handler(int UNUSED(sig))
-- 
2.55.0

