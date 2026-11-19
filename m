Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093463;
	b=WWKTIvfOG64R/QJkOZov7a7t2IpbIMXMBE/hUDEcjVLWah08gmB9dIv97c16R7ft8w2r
	 MiIRf+VnBrnlqG16uc6Rt9Q2KrXhpIEILKqmnI1+YeO9LxO9nJYXWVkF1ZctKdQoj5I2S
	 e1OXWvm1AHOpwtXvVHzCg+fYIdEbdrMdXWMH5/dXFvN+tRRrMYBr0z30MXbSvZKm2cP2B
	 T4D0W8XNzAd2ljMq6KzSmHpFkrddsjJYE6W6ZQFMDzyFYXipGoGn11dcl1RyIcfD8LC+M
	 /7G2xnQSuQrxf4qNHwRPP2EptBFOqVxtysQp4pcZdekml/b0SKFiMkULwRSIRJ4X9jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=kn4D/PrfX4kC8MZqkfPjeYvhZ2FWApn3TR4zGyj6rrI=;
	b=y6YAk/oiwozT47oA3vGfRkpoLD+UjDHuNC33Dj609QyT3tBeshrzwoH7ZRCDVF3SpVAN
	 dTGm8g5JzQaQExo9yrNGrhy2qYZS28bzc/qKC5FZD8wkN0F5pVCIbfKwC/8hE5ARcA0ZZ
	 Di6AU/TFHvN72KeKUuWadmlyELOg9HM7M4Tlrt9VcZoLZSrW0Vn2/NGUGguY5K+fAjhe0
	 w9ygi7VIXcGsIG1aa/0q2G3wytgsRqqMfBrXHbK4eXmkyef4dra1Ir+0k67xdAE5Q8Xy5
	 jZOq6Gso3nxzIReZo2rGx1tsoul/3BUjzGViISLBQKyxuo3MSphrUKMIdkyOF+tsoKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XJnGrvZH;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFD9606A331
	for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 13:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BEFD9606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XJnGrvZH
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9496400270fso216236885a.1
        for <selinux@vger.kernel.org>; Thu, 19 Nov 2026 05:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795093462; x=1795698262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kn4D/PrfX4kC8MZqkfPjeYvhZ2FWApn3TR4zGyj6rrI=;
        b=XJnGrvZHkhnh9K1hi+r0Mi3pXHwItWTOhreF3Av/kw2Md8QLabZnfbxaUUNGlq9D+/
         TLNDcRyXnAwOIWr64hZhmWUSq26BCzYnH0DtqzRfw0SoA6H0RpytLaxD20D5+8Ob6Gdv
         HkJNvHomU+Xg/6lAszsJAH9z8upwOE6bllYsNp14yGVIhIYCHrfqyIfRlEsOA4SOCLVa
         l5ckH/6pXly1DSGxUwIYV08zO0uYMFxv+j3lPeVXZougx+DGhqU5F385Th88VPt/FrYJ
         XPhLEXkBe9ffC4CetKA3J75gZbKzRIc7hH+EfEnNMIMbKRgfwBZfmW+WWEUv3Q1tmqfi
         WWcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795093462; x=1795698262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kn4D/PrfX4kC8MZqkfPjeYvhZ2FWApn3TR4zGyj6rrI=;
        b=YZN04nQ3rdvnSIYWD3mrGu1oWgLisvGPo6D3FX2S+G+Qk6Bus5Rz7emvxddzB4Rk8P
         iOgHHVVecmMXPx1B0cXaniQa18dxi51Nd0WdRHUgQpkfmAIrui1KgUWSICkoZ1AkWDh4
         2EXXeFvERy7Sxkp6keAEa5ye1F6FpjL5f0xTn0lRG/8lie18Yl6dbCkhQSvUZ30dXtK3
         OR66LUy8fpMgdIU7NiWu0kBajDYx8SirscO2GA2YWAVXC0iYKHGEAFH4m+FfeqHId2WV
         d1mIFBzTX9NFyzyQMjGobejfM20a+vVvpiqwRIcAVb+FLPDeGuBp0q74SBDF9/Y0bjhg
         lLww==
X-Gm-Message-State: APuU4Z8k/BxH90wyTyDJiqRrtvRtTaab5p35/bq294w4HazsqtDeuXxy
	oLU8dfVRDydWgcz795+Ii3XoPC9npt/i9S+P6vHCrXK1ubRks6UWb9qZVKLQ7g==
X-Gm-Gg: AYBFou25kDdUlb9yYCJhkTysgRB7L8EnqjNlwrmgMTwm+4ZE2O2o+8ridRpBrDuONIL
	Hhybd83yL7SEcmG5UEOUIj2aBsoABqEisq7lXXA72PwY6a2ClMnpS5euCh2u58LeNpmg4KnDVAX
	zV87+ubXpBrkTYMzsphPrRPWqI4IXwvAwh0fUn33IVOoL43FY/CcrL0sZ2fBOvwAb31AKplDLqM
	k8PtGR5Sz0vmIEHNKxXtzN88Nm6Fh0d0UMwwA7F0vrTvbnh0ouF1mkB59Wnw6bdZI8wAfkDtXrR
	jFqIkNWrNL/MTIXxem+5Anr6/f5IYGja5HAWOoFwYUUHztntbETX8p3KeCvsARMpxKSGcu5KFSE
	+pdKNxGmn88FQxuQLLWnOZk0MeK9wS4vzw2I5TnXPu0zDSwiD1b0STlzEFKTR0Rv7P3SlR/EgpA
	SCh4xMYnRJDNKEBK7gikCsij76JG5ZTAq6v3PgmDV6FaaksV0ck/1DaTXK1J0dkaG+PFWHngmHq
	9EaKiUupyP6ZkGi/84siYio2YlocROpaX7/zRC+ngxEozj8eJpSAW6aDhqvFrBFWuWQ2hC2V86e
	rsarFN2ffCsvJvoDKtI2w/1/2y4ErEeD5EaHgwKz5oND5bFYdagt4/JPmMKabFbGRNqtlpLbJiQ
	ui1RskFaA/knJ28KAoEdJex2am/loedh7cvqh9Lp8ymGDtSmxqsxjcmu5+3A1RghO1C72ENO09J
	9doTaewDPbubfL4dVI6eVV+193tJOyKE+z
X-Received: by 2002:a05:620a:2585:b0:949:727a:44e8 with SMTP id af79cd13be357-94999691795mr1037347285a.35.1795093461459;
        Thu, 19 Nov 2026 05:04:21 -0800 (PST)
Received: from debian.. (pool-96-244-147-163.bltmmd.fios.verizon.net. [96.244.147.163])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b7c7c46sm437154385a.33.2026.11.19.05.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:04:21 -0800 (PST)
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
Subject: [PATCH 3/3] sandbox/seunshare: run the sandbox in its own PID namespace
Date: Thu, 19 Nov 2026 13:03:55 +0000
Message-ID: <20261119130355.707-3-stephen.smalley.work@gmail.com>
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

The SIGKILL sweep after waitpid() only reaches the child process
group; a sandbox descendant that has called setsid() or setpgid()
escapes it and can still be running while sandbox(1) walks the sandbox
directories. The fd-based shred in sandbox is safe against that, but
leaving the escapee alive at all is avoidable.

Give the sandbox its own PID namespace so the sandboxed command is its
init: when it exits the kernel SIGKILLs every remaining descendant and
waits for the namespace to drain before the exit completes, so by the
time the outer waitpid() returns nothing from the sandbox is running.

unshare(CLONE_NEWPID) affects children only, so this needs an
intermediate process between the parent and the sandbox init. That
process takes the new session so the parent's kill(-child, ...) still
addresses the sandbox process group, ignores forwarded signals so it
outlives the sandbox, and relays its exit status. The setsid() before
execv() is dropped so the sandbox stays in that group.

/proc is left as-is; the sandbox process still has a PID in the outer
namespace so /proc/self and the /proc/self/fd/N mount helpers keep
working.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 sandbox/seunshare.c | 58 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 3 deletions(-)

diff --git a/sandbox/seunshare.c b/sandbox/seunshare.c
index b39ca010..528eefd4 100644
--- a/sandbox/seunshare.c
+++ b/sandbox/seunshare.c
@@ -1009,6 +1009,57 @@ int main(int argc, char **argv)
 		int fd_runuserdir_s = -1, fd_runtime_dir = -1;
 		int fd_tmpdir_r = -1, fd_tmp = -1, fd_var_tmp = -1;
 		struct stat sb;
+		pid_t sandbox;
+
+		/*
+		 * Put the sandbox in its own PID namespace so that when its
+		 * init (the sandboxed command) exits, the kernel SIGKILLs
+		 * every remaining descendant regardless of process group,
+		 * and does so before the parent's waitpid() can return.
+		 * This closes the setsid()/setpgid() escape the post-wait
+		 * SIGKILL sweep cannot cover.
+		 *
+		 * unshare(CLONE_NEWPID) affects subsequent children only,
+		 * so fork once more; this intermediate process is what the
+		 * parent waits on and just relays the sandbox exit status.
+		 * Take a new session first so the parent's kill(-child, ...)
+		 * addresses this process group, which the sandbox and its
+		 * well-behaved descendants stay in.
+		 */
+		if (setsid() == (pid_t)-1) {
+			perror(_("setsid"));
+			exit(-1);
+		}
+		if (unshare(CLONE_NEWPID) < 0) {
+			perror(_("Failed to create PID namespace"));
+			exit(-1);
+		}
+		sandbox = fork();
+		if (sandbox == -1) {
+			perror(_("Unable to fork"));
+			exit(-1);
+		}
+		if (sandbox > 0) {
+			int st;
+
+			/*
+			 * Ignore forwarded signals so this process outlives
+			 * the sandbox and the PID namespace guarantee holds;
+			 * the process-group signal reaches the sandbox
+			 * directly.
+			 */
+			signal(SIGINT, SIG_IGN);
+			signal(SIGHUP, SIG_IGN);
+			signal(SIGTERM, SIG_IGN);
+			signal(SIGQUIT, SIG_IGN);
+
+			if (waitpid(sandbox, &st, 0) < 0)
+				exit(-1);
+			status_to_retval(st, st);
+			exit(st);
+		}
+
+		/* PID 1 in the new namespace from here on. */
 
 		if (unshare(CLONE_NEWNS) < 0) {
 			perror(_("Failed to unshare"));
@@ -1225,7 +1276,6 @@ int main(int argc, char **argv)
 			perror(_("Failed to change dir to homedir"));
 			goto childerr;
 		}
-		setsid();
 
 		/* selinux context */
 		if (execcon) {
@@ -1283,8 +1333,10 @@ childerr:
 	 * budget; with the fd-based shred in sandbox(1), timing out here
 	 * only leaves a straggler alongside a race-free cleanup.
 	 *
-	 * This does not cover a descendant that left the process group via
-	 * setsid()/setpgid(); a PID namespace is the complete answer.
+	 * With the PID namespace above, waitpid() returning implies the
+	 * namespace has been torn down and no sandbox descendant is
+	 * running, so this sweep breaks on the first iteration; kept as
+	 * a cheap safety belt.
 	 */
 	for (int i = 0; i < 400; i++) {
 		struct timespec ts = { .tv_sec = 0,
-- 
2.47.3

