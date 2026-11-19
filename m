Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093461;
	b=MuZXpWMoOgutv+FRAUjKkOCQVCn9OXdReny7hQj2jhcRrXuQke3G11u/zKamBNZbFbHH
	 Tb1Wa1BRIeyfxucOgyYmogwZsY9fYJRzzawO9Ig3kjHOcVDnRtQ1I1wfMjCQ39dOJaO85
	 zWc9kdvaeBVEu0TTyICPyVO8Dpjz/BFOCIVKP0wxleh3X1PAPh3Urssnd3XclubPx8fMF
	 JNN8gVDGZl66wcJMep84IzLo3xGqAhX6xZ4NPPhSOknIFqLFG2EycWCqLwyzL5jIMSzX7
	 mkxZ1L6gklSRBuYLShpuOKFTjLV90ZkiGBqRb9wVZ7zXOeWq0g6hr8krnZKg5fBxylQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093461;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xwXtj1swHscgimwkHdxovizDVcdSYp34iNc06Z4fmUU=;
	b=nByRe1E1htlz3LkIR5qZkUA/JeNJ4epB7zf05KkoBVMqSN5KTUKVTG81SE7BQQ0NAd+L
	 qrq0RHsiMkX9fyK441emBoYnB4dYIMCpfucsWFB3DIIGS9SDh3K4a+x8SkxNsl/JLwnG9
	 t9fVTU0GYbUF+BbMqKpLlbyw6WUgSD7sSHfdRGflZ+q3zdcl8tTREoSXOuOUkKXhbzBVp
	 WZ6MRc5bElNFWypNJ7OAosKbdvxC+V1TJQydIA+kfo7sOM0Rh5uap1/jXGiTtTaO6MxUA
	 lpgUiG+yCisOBbc1yEUL/4vOhkCWmZHZ81LTNGNdaSZy0Op14dXc6obN3/ueRGw04xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=luEZxc4W;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6D2606A32F
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 13:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C6D2606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=luEZxc4W
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-9495d543c42so213698285a.3
        for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 05:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795093460; x=1795698260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xwXtj1swHscgimwkHdxovizDVcdSYp34iNc06Z4fmUU=;
        b=luEZxc4WPZF3sip6DwlP+dPOD/zn/DgwU/CzA4tNtyOslqrS1SwtugcQcawifEOMuf
         eRXw9YpNLfDudbeIGqTrdGJ+bEf5AB1mgju8fQ0s/xbVM2gsdkM8+EW9SJ2crcZz6HPo
         OdrKvIGjkTEZ2smL69ElqV/sx5Jz50Wq6z9WU/YJmcx2hvUcTccHUpi9pJvNNf0aX71M
         aG2EisAxftSDH5z5aNLu6p0xFRWhk+RFahYur8XQl3rEdou1Xe6sTPMQ0LxzN3O/Tobq
         DX7Tsf4T+N2xnPAhgJJbec8HvRau9ttgELpwnpGzMn1lzr1UaIjMbJwfhqUBaS6p0fXd
         jUPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795093460; x=1795698260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xwXtj1swHscgimwkHdxovizDVcdSYp34iNc06Z4fmUU=;
        b=AByKDiKXr8EdcAmA3acbzRZKNtvLi3swkfWVqDlc0bVsFwPbyWQbUasQn8tq/RdcRF
         NRTLJr+ar8SGxXPRnS7vWX4Ny4me7ECCsYNSHFAUcsQyyQCJMrrb8wJcGEixew9tccAX
         pAyUXI/5J0RZ3FaOmasO3rS3zu3QzgUDyL/Y4IVmY+2B/xPzx8Z/4ptciWKMzkbphrYA
         SzJSNbzbV4xv2yWDTv/IcjoTjkmbQGdqY0NAxKWQJrJKmjf2sIFx9SpIU5dz7+rt83o0
         AIaQogPP97aYROVLz2mNXsZ0ARHxJTRzqhFMSK+/3oX6Yev1G6jOwV5cMDlBQ3kazPDK
         oRaQ==
X-Gm-Message-State: APuU4Z/eq09Jqt0kVqYdj8H6YOIWDkNQJeKRvjJKdoqlHQ0V4rDqdhGG
	c3tucvNEOOmZudtsGH2vFnUmZylFNTXNCve9qTvAxyW8jG1As47FBHlL5atNGg==
X-Gm-Gg: AYBFou0M29K5+9w6J88R6A0thBw6qH7SfjqzrFIGIECFQFHlU5XtdDW1OU7qhKNqasi
	AvYYVXxHlUdkwlMZKf/p2cYeJ+9UnvSVIPWavz6fhpAoU2ZN/vsw5trBIJKidyQXwtEoNLxFPVS
	PmTeZhMF4OuL+ziUUBXmTZ3I9PyKwJn7ONh/264EGKPEjWqtAI4e15cw2lhOPEhDy+zT3tA6pZP
	f6o9Vu7ownaGknGRmCxBp1IYD3N06q89MQ6woLSyx4ZC5XlPOiST4jhgW3XpddPKQbxdI2gk3t9
	VQNOtRhIT7GkHCsaBYlUqw2xiefmBTjMx2eVqW0vMA3TPtvxvQdO1L/YX3sdJSRvvztypEjCGrL
	7D9FEqo4TfJneG36KYVYtWVIXOfG3GaSVEIWW0Hs4hGtVtrXgxJ7r2Y1g8SIuYrICv0VyxRjZfT
	ailjrK6I7D8+uXW8zP4NXEi+ldqEs/sN20VRzl7QETtSLbvoHzLk5h/5MkrUWSxVKsrbZzlPWVN
	KwkkUmhMpuh+/3ha0A1LbfYIpyADV6eg6A33jsYDlUZmHRpK5oK7k8PJvm1h8fip6vpk7DGw+Eu
	uZsCeHLWft62vU0pO3vpjBaJxeAjYMGW4dKxj7AE3v+4NJMP9AeIAJRjh6aI7eGH1H72rt78E9b
	PqZIueFGHjilp3iF2uFfw3DxwHNHQj5j3wAt4FxEw3KrEMCZPf4r3NwHevGPZLEiMXVxlIXPJk+
	S4CdrEBmNQ2AhSgxkgzFzlP89WVWD5xJf7ng==
X-Received: by 2002:a05:620a:2a02:b0:939:6de9:4cff with SMTP id af79cd13be357-94999755c00mr1028520385a.45.1795093460231;
        Thu, 19 Nov 2026 05:04:20 -0800 (PST)
Received: from debian.. (pool-96-244-147-163.bltmmd.fios.verizon.net. [96.244.147.163])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b7c7c46sm437154385a.33.2026.11.19.05.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:04:19 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jwcart2@gmail.com,
	paul@paul-moore.com,
	jason@perfinion.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 2/3] sandbox/seunshare: SIGKILL and drain the child process group
Date: Thu, 19 Nov 2026 13:03:54 +0000
Message-ID: <20261119130355.707-2-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119130355.707-1-stephen.smalley.work@gmail.com>
References: <20261119130355.707-1-stephen.smalley.work@gmail.com>
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the sandboxed process exits, seunshare sends SIGTERM to its
process group and returns; sandbox(1) then walks the sandbox
directories. A descendant that ignores SIGTERM, or that is stll
draining, is still alive during that walk.

Send SIGKILL instead and loop until kill(-child, SIGKILL) reports
ESRCH, re-sending each pass so a process that fork()s between our
signal and its own exit is caught the next time. Bound the loop at 2s:
a grandchild stuck in uninterruptible sleep, or a zombie not yet
reaped by init, holds the pgid alive, and with the fd-based shred in
the previous commit, sandbox is safe against a survivor anyway.

The SIGINT/SIGHUP forwarder in handler() is left forwarding the
received signal so ^C still reaches the sandboxed application; the
post-wait SIGKILL sweep runs afterwards.

This does not cover a descendant that left the process group via
setsid()/setpgid() before the sweep. Placing the child in its own PID
namespace would make waitpid() returning imply no descendant exists;
that is left to a future change.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index 9f7e49da..b39ca010 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -7,6 +7,7 @@
 #include <stdbool.h>
 #include <signal.h>
 #include <sys/fsuid.h>
+#include <time.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
@@ -1274,8 +1275,25 @@ childerr:
 	waitpid(child, &status, 0);
 	status_to_retval(status, status);
 
-	/* Make sure all child processes exit */
-	kill(-child, SIGTERM);
+	/*
+	 * Make sure the child process group is gone before cleanup runs.
+	 * SIGKILL each iteration so a descendant that fork()s between our
+	 * signal and its own exit is caught on the next pass. Zombies keep
+	 * the pgid alive until init reaps them, so give this a bounded
+	 * budget; with the fd-based shred in sandbox(1), timing out here
+	 * only leaves a straggler alongside a race-free cleanup.
+	 *
+	 * This does not cover a descendant that left the process group via
+	 * setsid()/setpgid(); a PID namespace is the complete answer.
+	 */
+	for (int i = 0; i < 400; i++) {
+		struct timespec ts = { .tv_sec = 0,
+				       .tv_nsec = 5 * 1000 * 1000 };
+
+		if (kill(-child, SIGKILL) < 0 && errno == ESRCH)
+			break;
+		nanosleep(&ts, NULL);
+	}
 
 	if (execcon && kill_all)
 		fprintf(stderr,
-- 
2.47.3

