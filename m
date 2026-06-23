Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20AE381B1F
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782223848; cv=none; b=WadHlfGRShlJKXpfQRTQPYPg3vRpg3bAFKOgzyWX/BtsXIsac9phkxm1ByoynsvidA7V46Nil0JlJDyjXvYB4wgTeWnfE/4O7cl3MReu/T5DS3j56ObWOwqxY3uckbiSAawu2SxYPhv44IxOr1GgOn0VEl0FArc6coEt/5ep9i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782223848; c=relaxed/simple;
	bh=YBz0liqV/+LzTxvg6yXcT0Jo+bwPljYsBtyxFME0CBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sV6JtlRieXf46TP7UcLHiKFSFixGdXjGBfDJdDXEC26Wwfv44xrYTw8ibb5XsKqBu5/uBnyoT2LfFge1n9EcgzOa/TORzwYKCywr1mSsziv2TOrNcOkhayxhdnM1+x1SZ6ECMMU+yN9dA05Za3YQiLaGs1yob4zLbCZ7ExFUA1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=QPpPFINp; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="QPpPFINp"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782223839;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4NXh0TMMebyZVEuXATGO+IAJunlk/BhcntmvUF0Dw4=;
	b=QPpPFINpxyNhA9UIak6nUT+hLXwTNxoRBN2s23C6reo/B0uTfuJwwT8LGuxMw11YmH1Qaq
	104qm37h7E+kqQHoR5v2M7A0KsqEZds3jrLlg63VNXq4uoGjOWb+cZGoREWiwMwlKlavHt
	DlUBXwnlga0xDF73QzF6AZvhHS6KgFHrNcveSTqRnuG6ppE4pLIptbaUCMnxlQfGJ8T3cB
	/Axh3qEhtuI0xL8P5e4Mwc7UeCrotosPNl1ObOR2Zm4WglIiKlhIUmloPqec5hq+u6zzAK
	4vVFVwWMePzbqSr9ON/R6sbajsDub2Z+xPnAHaU+jm5E74T/O+Bj4wRZj72MrA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 3/5] newrole: wait only for the forked shell
Date: Tue, 23 Jun 2026 16:10:20 +0200
Message-ID: <20260623141023.114173-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260623141023.114173-1-cgoettsche@seltendoof.de>
References: <20260623141023.114173-1-cgoettsche@seltendoof.de>
Reply-To: cgzones@googlemail.com
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Reap the known child PID instead of any child, so a process spawned by a
PAM module cannot be mistaken for the shell and cause early teardown of
the tty and session. Also report signal-killed shells as 128+signum.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/newrole/newrole.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index ef194efb..990ebc18 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -1232,12 +1232,14 @@ int main(int argc, char *argv[])
 		int status = 0;
 
 		do {
-			pid = wait(&status);
+			pid = waitpid(childPid, &status, 0);
 		} while (pid < 0 && errno == EINTR);
 
 		/* Preserve child exit status, unless there is another error. */
 		if (WIFEXITED(status))
 			exit_code = WEXITSTATUS(status);
+		else if (WIFSIGNALED(status))
+			exit_code = 128 + WTERMSIG(status);
 
 		if (restore_tty_label(fd, ttyn, tty_context, new_tty_context)) {
 			fprintf(stderr, _("Unable to restore tty label...\n"));
-- 
2.53.0

