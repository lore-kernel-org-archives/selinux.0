Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=168.119.48.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794308366;
	b=i9VR5CopRTNVo9Orq+yeiXshbcfFPh73HY1tEGmRB0dPmHK4whU3ru5u7LXjXALxYobP
	 Dl24u9grqed5WQGZlr1HT8SQZxunsdUF9rSGXtbCpaJeJfJPdpUeWsfgIO2o2KVMYv/SQ
	 uRD3mYWR9obw5GHsQ8z8cizAT8sLkX77365Q0YPgMqJbZLToylZF0Xyr9N3arGJMoleiG
	 c/jjDyfuxAy0NBcJy7Fxghgvl2WLsDKk/SN9YbmRG3ClvA32rH0JQtuki0dzMo6tqFbVh
	 V4/+YwaaBfWqLkdEOY8XIvUf1PkZ4ZqUAXrMPZNdQpjrTdDsGlOgQw17TkNZwdjIW+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794308366;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Reply-To:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=eLt1OGZiLJ3VZ2DsSjO3sRnVY/NKuhJXoiJalCL5pU0=;
	b=blgI1buDLo41EF3/qyAqSoqPiEU9zggcugSX+WO2efr9oimTk1L2+BSLIFfB6efyV/Xh
	 QzeRA7z39ox5U6sj7xNG61MRshccHmCODu92wlQGhfYahGm4FTyezIYcW5qhzdiEs4eER
	 3ajfKBuq/byt2NjK+2PoLr7+PbQHgV4wdEep1IUnANNstggFdcZhbtTTX4KJSTskRqxwX
	 Btpo4MPq5smEw9dfa1KOy+KPisZMlUBHW/Wbi6ynxB51sqyDJj/kjUWFzxfc6ESn0dm7r
	 +/j0381ExvLDjwMGZHwkL61iW+E8dvdCQFtNIAQZu+wnov+jq5KS6ovRVTxvg5VdXUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seltendoof.de;
	spf=pass smtp.mailfrom=seltendoof.de;
	dkim=pass header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=j5b+zXrn;
	arc=none smtp.remote-ip=168.119.48.163
Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE760A5BC3
	for <selinux@vger.kernel.org>; Tue, 10 Nov 2026 10:59:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4FE760A5BC3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.a=rsa-sha256 header.s=2023072701 header.b=j5b+zXrn
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1794308361;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eLt1OGZiLJ3VZ2DsSjO3sRnVY/NKuhJXoiJalCL5pU0=;
	b=j5b+zXrnk9Duy4mdhDJ9F5mjwwltosm6MBAiKhiJD8ltEKTrBSliHrXPabhN1YoW0be/1F
	HCgKp4F2xrLtmTY0fOPMu0ygE0q59+T/e2lbKvbeFrrV57LPX9OrLrId6ToEZIWLzm/3Wd
	/5HxVTFZWqbsHF8fSHEMQ1IvxvZZln2dehDukIZKaL0S7l1OXM6UdYDYV3LS4oahPaL2+Z
	Nc+CYXJhTlWDp0oZf9M3pjttmqXW3C8G/OZiXxpOB87grr3wftmJYOTKO/I+sNTeSQCeqL
	KsUWw0avv4Luhw7OThNQd+YSLppSnylI+v2sSylCmex0uDVfEhjJ5DJ3Q74aTg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 7/7] newrole: reset all signal dispositions on startup
Date: Tue, 10 Nov 2026 11:59:05 +0100
Message-ID: <20261110105906.58509-7-cgoettsche@seltendoof.de>
In-Reply-To: <20261110105906.58509-1-cgoettsche@seltendoof.de>
References: <20261110105906.58509-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Caught signal dispositions are reset across execve(), while ignored
dispositions are inherited. If newrole inherits SIGCHLD as SIG_IGN, the
kernel automatically reaps its child. waitpid() still waits for the child
to terminate, then fails with ECHILD instead of returning its exit status.
Since status is initialized to zero, newrole can report success even when
the child shell fails.

Reset all signal dispositions to SIG_DFL at startup instead of only
SIGHUP, so inherited SIG_IGN dispositions do not affect child reaping or
the new shell's signal handling.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/newrole/newrole.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index d1385142..1928528f 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -1040,6 +1040,7 @@ err_free:
 static int set_signal_handles(void)
 {
 	sigset_t empty;
+	int sig;
 
 	/* Empty the signal mask in case someone is blocking a signal */
 	if (sigemptyset(&empty)) {
@@ -1049,11 +1050,13 @@ static int set_signal_handles(void)
 
 	(void)sigprocmask(SIG_SETMASK, &empty, NULL);
 
-	/* Terminate on SIGHUP. */
-	if (signal(SIGHUP, SIG_DFL) == SIG_ERR) {
-		fprintf(stderr, _("Unable to set SIGHUP handler\n"));
-		return -1;
-	}
+	/* Reset every signal disposition to the default.  A handler set to a
+	 * function is already reset by the kernel across a setuid execve, but
+	 * an inherited SIG_IGN disposition survives and could otherwise subvert
+	 * e.g. SIGCHLD handling (wait()) or termination via SIGHUP.  SIGKILL and
+	 * SIGSTOP cannot be changed; ignore those (and any invalid) failures. */
+	for (sig = 1; sig < NSIG; sig++)
+		(void)signal(sig, SIG_DFL);
 
 	return 0;
 }
-- 
2.55.0

