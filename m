Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980FB329F02;
	Wed, 10 Sep 2025 19:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757532853; cv=none; b=DEwnMhR+9Vo7LzmJgjm03Rj4qfcVqXDH5LmNOmfn9xnvjf50+wkRzTwKRit3ylx0LTfbSYq8EhGeHfM8HAHnrjc6i+FOZ1s7UuW6icAZ+7tG1iwo75jRSahsaaF+RVHngjFHCPGhgKCjBfpQz+TVkd0peR+4WJDW10KHJJPXJKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757532853; c=relaxed/simple;
	bh=p1xCm2IQrI9x1ovo3ODMtxhzgLdvIhFCs2YmGl/ZhYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mpNmTENwIu8qq+GLVA+HDxwLOMckyeGlReDpgORpSHlIvK9GCifDogPf3Y0XTUl2VtFR6SOhpQeMYInaR8tT0Y9bpfqjGzqty0DR0qZ1ASNmHQQE+y4qK11zDwGJkKPvwK7q4o/PrcOKNAdrpAUSAdGPOt+06p61WZwS8sowK+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=PwvFt4B9; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="PwvFt4B9"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1757532381;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=CYPSRsKtTDCMll+paC1CVC2DCQQRXLK1f6svNzxVkYU=;
	b=PwvFt4B9RJALakAdjc9iGWR3u7gDaJlrliXEp8apyVG4qzvbIRr11C3f4+w71BVSMAbT5J
	SYsLDmKWMvDxDQfwBK0HFgWldF3gXHVTzsdUB4f2xN6egt3Ry3SQzG2v//hVj8Kmj5N65J
	5mcn1ntA23IhJnLpF3/Njq//BwId6zd+MgTlR8gX1DaeRKP1xkm67iUxfZB9xVY+tVXIwV
	pCYx2HmgjiSTBfjTL/xjN3TSPq7w3VBdimqG7Tx4thq0QuJq0NmzVUXnSlzki9ZLMr5hy8
	SrbsMeXjpQpNX1cX3a2QsY42UvHIHW51ZrpqKaBDZnXYcoheGcMzekGzTfhEcw==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH] pid: use ns_capable_noaudit() when determining net sysctl permissions
Date: Wed, 10 Sep 2025 21:26:05 +0200
Message-ID: <20250910192605.16431-1-cgoettsche@seltendoof.de>
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

The capability check should not be audited since it is only being used
to determine the inode permissions. A failed check does not indicate a
violation of security policy but, when an LSM is enabled, a denial audit
message was being generated.

The denial audit message can either lead to the capability being
unnecessarily allowed in a security policy, or being silenced potentially
masking a legitimate capability check at a later point in time.

Similar to commit d6169b0206db ("net: Use ns_capable_noaudit() when
determining net sysctl permissions")

Fixes: 7863dcc72d0f ("pid: allow pid_max to be set per pid namespace")
CC: Christian Brauner <brauner@kernel.org>
CC: linux-security-module@vger.kernel.org
CC: selinux@vger.kernel.org
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 kernel/pid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/pid.c b/kernel/pid.c
index c45a28c16cd2..d94ce0250501 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -680,7 +680,7 @@ static int pid_table_root_permissions(struct ctl_table_header *head,
 		container_of(head->set, struct pid_namespace, set);
 	int mode = table->mode;
 
-	if (ns_capable(pidns->user_ns, CAP_SYS_ADMIN) ||
+	if (ns_capable_noaudit(pidns->user_ns, CAP_SYS_ADMIN) ||
 	    uid_eq(current_euid(), make_kuid(pidns->user_ns, 0)))
 		mode = (mode & S_IRWXU) >> 6;
 	else if (in_egroup_p(make_kgid(pidns->user_ns, 0)))
-- 
2.51.0

