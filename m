Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE20E3822A2
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782223847; cv=none; b=MaTiQDc6d8Qo4ts4F0uLTQi8jnqceWYVvwxQkfl5OgGlGSWzWYJk70rtMkhqsTaZpckvPEJBkJ7X51QFNuDLJMST3XOkw72WqlbWpoGcUEDWnqyl6LMztTZo3Ci2Q2ixUOWp/xLko43wI7SvVd3zqK0d01AxBMeK+K4/S88McMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782223847; c=relaxed/simple;
	bh=OUbtCDHhEoG+5TQNxfTi3k/XNZH8K8pcKLAQi7cGZqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxWJLI7yc6QYAoYFTPhk50VI6pvXqbWbHE6ffWt2TYk0llkYzQPCJpxLNVYS+Jk63NfhG2fVyOUTg6ckkXZ5458SpQLJtEgsMLlhQ1PXgZXuWH4vuf2M0W6PtlBhEqenhmxER5JutDGHqxKU4+6T/FYy2Eu5SKZSRtbp7z1o+Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=DM8RjMkr; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="DM8RjMkr"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782223839;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1APCE+prj1KnH2M2h9xT26lQ2gEXIcQs9ph50/07HVU=;
	b=DM8RjMkrH3OGL8EIYPzh2zpOIc/7DFSFKBbUa97ElVurCkYaCpgq6czUhKIo8xx3twnMht
	ynabWWAN0kEL3J1Qtfx8If73uTdigfCpzicwUSqHbMiFVKZOAm+HcbifDSGdH53WEHIiu9
	G71/z7tNxB9BK6l3K+yEw3sYIEVSC7EaJzsc8oXtVVlV6RK27rXD8Qm35+ge3Lx7/XUq2P
	Pku2jAK64Si1ZkgKqJ1/stdQ5G5fhv69uauvL+w1KPJFb2xUfpPwAliYwA1pSuNNbwo6/f
	WZi3qtd1m5IbZcPu5ttwSSor58oyJyfgKp2BHQGq06vFEZdVGDlNdfgYjnaCYw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 1/5] newrole: fix minor leaks and uninitialized status
Date: Tue, 23 Jun 2026 16:10:23 +0200
Message-ID: <20260623141023.114173-5-cgoettsche@seltendoof.de>
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

Free duplicate PAM service-name entries in process_pam_config() instead
of leaking them, free old_context in the parent branch before exiting,
and initialize the wait() status variable to 0 so WIFEXITED/WEXITSTATUS
are not applied to an indeterminate value when wait() is not reached.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/newrole/newrole.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index 8f75706e..960c8875 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -280,6 +280,11 @@ static int process_pam_config(FILE *cfg)
 				_("newrole: service name configuration hashtable overflow\n"));
 			goto err;
 		}
+		if (ret != HASHTAB_SUCCESS) {
+			/* duplicate entry: hashtab kept the first, free this one */
+			free(app);
+			free(service);
+		}
 	}
 
 	free(line_buf);
@@ -1208,7 +1213,7 @@ int main(int argc, char *argv[])
 		 */
 		pid_t pid;
 		int exit_code = 0;
-		int status;
+		int status = 0;
 
 		do {
 			pid = wait(&status);
@@ -1224,6 +1229,7 @@ int main(int argc, char *argv[])
 		}
 		freecon(tty_context);
 		freecon(new_tty_context);
+		freecon(old_context);
 		if (close(fd)) {
 			fprintf(stderr, _("Failed to close tty properly\n"));
 			exit_code = -1;
-- 
2.53.0

