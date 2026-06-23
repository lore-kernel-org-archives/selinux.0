Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5C838228C
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782223846; cv=none; b=gpPYiv3JgcKAIr71/u3t/XTdXTjtmTJiliiwdXtBsKiWz844VIeGINuuK32VLWjP3UdtuGOZHgzJ8EylUBAIL2aatQ6wbcOJd/2EPQGw3E3dOJ1kruphHDsUAAq7+0HLZuwg/PZ9q8nMAivUp3CMeu8gWoa0MWa7CofiMFN1Arw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782223846; c=relaxed/simple;
	bh=3fOI3/JzW6YnPBiCTX/QnZuz0gomSSQE0lQjlJ4PHN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCyxS5z0J73MTho909xdZ7uQTHwXZUkbVznmEyTtWKYwhY/jCtXsNtrFkU3Lg6qdou0rTXP1Nq9zDnOXHZNG6H8fgM8ENy9Mat6rHY5MZkDdmg1tMClfi3Uvgp2zlUvcKtD0fUIfghtx3yd8sTOndOin6fluwh9UP+nlD6yn8Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=npy5ahpR; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="npy5ahpR"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782223839;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=apWm+dicf84iHLejGQFZAMUGxWVtYhb2WE6RBaCSD+8=;
	b=npy5ahpRGBKQuRP5y/pIVQ3tSST1W1YMLWeQ+pOpKZlrM0aYk/VbXTUJgYEAHdONgQ5QKt
	WRfWnhWW7Jua29jkXAgsFtLFQweFs587n7X0N00MGzrRJXxFHbEEvvsH/hFxybOcIy5q2w
	uJcFgLILut6StpI5eERCcY/9y/PsgHD8cXK+8YwSgmt5rzAsnKyO228ZZIB9QuPEp8HDSF
	/TqMUUci5ujDTo6jqVyH+D8gTJUeYMIrI5XbRrpZqhJ/w/IHTNdyMOY3O/uiFN/o2rVVWY
	PwD502OlAVLlwb0pcpPumiRG6QcpLWDzGUnVF/xLQ/btVqDoCmE6cgs7F5jbKQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 4/5] newrole: ensure the standard file descriptors are open on startup
Date: Tue, 23 Jun 2026 16:10:21 +0200
Message-ID: <20260623141023.114173-3-cgoettsche@seltendoof.de>
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

If the caller invokes newrole with fd 0, 1 or 2 closed, a descriptor
newrole subsequently opens (e.g. the tty) could be assigned one of these
numbers and later be clobbered by stdio.  Attach /dev/null to any closed
standard descriptor before doing anything else.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 policycoreutils/newrole/newrole.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/policycoreutils/newrole/newrole.c b/policycoreutils/newrole/newrole.c
index 990ebc18..09b10b35 100644
--- a/policycoreutils/newrole/newrole.c
+++ b/policycoreutils/newrole/newrole.c
@@ -1049,6 +1049,28 @@ static int set_signal_handles(void)
 	return 0;
 }
 
+/**
+ * Ensure the standard file descriptors (stdin, stdout, stderr) are open.
+ * If the caller closed any of them, attach /dev/null so that a descriptor
+ * newrole opens later cannot be silently assigned fd 0, 1 or 2 and then be
+ * clobbered (or have its content disclosed) by stdio operations.
+ *
+ * Returns zero on success, non-zero otherwise.
+ */
+static int sanitize_std_fds(void)
+{
+	int fd;
+
+	for (fd = STDIN_FILENO; fd <= STDERR_FILENO; fd++) {
+		if (fcntl(fd, F_GETFD) != -1 || errno != EBADF)
+			continue;
+		if (open("/dev/null", O_RDWR) != fd)
+			return -1;
+	}
+
+	return 0;
+}
+
 /************************************************************************
  *
  * All code used for both PAM and shadow passwd goes in this section.
@@ -1090,6 +1112,11 @@ int main(int argc, char *argv[])
 	 * if it makes sense to continue to run newrole, and setting up
 	 * a scrubbed environment.
 	 */
+	if (sanitize_std_fds()) {
+		fprintf(stderr,
+			_("Failed to sanitize standard file descriptors\n"));
+		return -1;
+	}
 	if (drop_capabilities(FALSE)) {
 		perror(_("Sorry, newrole failed to drop capabilities\n"));
 		return -1;
-- 
2.53.0

