Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688DB380FFE
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 14:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782223846; cv=none; b=b51YREeL9dhf4gvnJYaUcH/sZ5wSDWBsfj1bCOd08cnvCk4/TBL9EQH/X8eMQ/7GlN6ZEQuXFAry9TysPXPws0bzs4pPa1NVVLB4+JIXfc5VEwEFrz1ZdCMVvhk1L2YkwvT4qsa2IxiZaPG4YW+r4gnq1rr8kzAbBaG8mY+ES8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782223846; c=relaxed/simple;
	bh=q7EcMp0Egn0cbe59VOx8c3LvQR8XIQgRrW1gXRoISiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwtYp7SrEAVH0efCk7kZ5A2UTfVmqLhSIuxKOabUcQeQH+1wjkHal4gnDtGFI42riWD20SokgORLyuTB4gzc/0Ued+x2zDstz6Xg96Y+Sxvwz76YWOab6vUaIpup1qfGzw/UYcVFlYyllb8qR2oUy5esGtWRU+XrOJllI8xvSco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=PFbUyQCu; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="PFbUyQCu"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782223839;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=any9xrbcIBZZWubjqvzvp/Z+QTsN0SnVQbNsQ3/PjZw=;
	b=PFbUyQCuC52dRaEguk6+meUBfkfPaO54Nji7KP0fXOYzbDVO5pnMBGqwJ47+rwY8qCV2o9
	+T0+3knbOgjNhBVm1dogIpUrYAUu22g14LNj5EFzm6wvGnMZocqIIVFWCm20tMwpSc4azK
	r7apfOUJPdUCnKAx5voCfc8+RLUUmwDL/ZHXugc0gMj0fpkqsNXTn0F8T1wqU0LupqY7/J
	LqS7TBFVS8/ABVq3huxS7aDzD6HyC2A20uJHBnOxprxODL3ogs6pqjLHfZY9BoUQ7aUdV4
	VdT86cS231sG8BByoLvGp2b4ZT/ccKDAa3QfgUtGizqUI5Q/ms2SHJlFeBLJWg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 5/5] newrole: fail closed for -l when the terminal context is unknown
Date: Tue, 23 Jun 2026 16:10:22 +0200
Message-ID: <20260623141023.114173-4-cgoettsche@seltendoof.de>
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

The -l secure-terminal check only ran when fgetfilecon() on stdin
succeeded; if it failed the level change proceeded with no securetty
check at all.  Resolve the enforcing mode and, when the terminal's
context cannot be retrieved, reject the level change while enforcing
rather than silently allowing it.

Refactor the enforcing passing to unify security_getenforce(3) calls.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/newrole/newrole.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index 09b10b35..58524b6a 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -732,21 +732,16 @@ static inline int send_audit_message(int success __attribute__((unused)),
  * in permissive mode.
  */
 static int relabel_tty(const char *ttyn, const char *new_context,
-		       char **tty_context, char **new_tty_context)
+		       char **tty_context, char **new_tty_context,
+		       int enforcing)
 {
 	int fd, rc;
-	int enforcing = security_getenforce();
 	char *tty_con = NULL;
 	char *new_tty_con = NULL;
 
 	if (!ttyn)
 		return 0;
 
-	if (enforcing < 0) {
-		fprintf(stderr, _("Could not determine enforcing mode.\n"));
-		return -1;
-	}
-
 	/* Re-open TTY descriptor */
 	fd = open(ttyn, O_RDWR | O_NONBLOCK);
 	if (fd < 0) {
@@ -856,7 +851,8 @@ skip_relabel:
 static int parse_command_line_arguments(int argc, char **argv, char *ttyn,
 					const char *old_context,
 					char **new_context,
-					int *preserve_environment)
+					int *preserve_environment,
+					int enforcing)
 {
 	int flag_index; /* flag index in argv[] */
 	int clflag; /* holds codes for command line flags */
@@ -928,6 +924,10 @@ static int parse_command_line_arguments(int argc, char **argv, char *ttyn,
 						return -1;
 					}
 					freecon(tty_con);
+				} else if (enforcing) {
+					fprintf(stderr,
+						_("Error: could not determine the security context of the terminal, not allowed to change levels\n"));
+					return -1;
 				}
 			}
 
@@ -1093,6 +1093,7 @@ int main(int argc, char *argv[])
 	int fd;
 	pid_t childPid = 0;
 	char *shell_argv0 = NULL;
+	int enforcing;
 	int rc;
 
 #ifdef USE_PAM
@@ -1139,7 +1140,8 @@ int main(int argc, char *argv[])
 		return -1;
 	}
 
-	if (security_getenforce() < 0) {
+	enforcing = security_getenforce();
+	if (enforcing < 0) {
 		fprintf(stderr, _("Could not determine enforcing mode.\n"));
 		return -1;
 	}
@@ -1162,7 +1164,8 @@ int main(int argc, char *argv[])
 	}
 
 	if (parse_command_line_arguments(argc, argv, ttyn, old_context,
-					 &new_context, &preserve_environment))
+					 &new_context, &preserve_environment,
+					 enforcing))
 		return -1;
 
 	/*
@@ -1226,7 +1229,7 @@ int main(int argc, char *argv[])
 	 * Once we authenticate the user, we know that we want to proceed with
 	 * the action. Prior to this point, no changes are made the to system.
 	 */
-	fd = relabel_tty(ttyn, new_context, &tty_context, &new_tty_context);
+	fd = relabel_tty(ttyn, new_context, &tty_context, &new_tty_context, enforcing);
 	if (fd < 0)
 		goto err_close_pam;
 
-- 
2.53.0

