Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1DE4E7819
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 15:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611112; cv=none; b=bpGrJF5X6k5bCq+fJ3vV5Xe3VymNaIaXe1chu0M8QZqal2gtCWkv4q9/l9J0uNBmwZouQ8i4XDYgQOx9wQzXogqY9KqH/k0/+nKwh5ynJ05s6bUZ1KIDUBf3/UGpRCKIC1oeKn31YTXhcQOB7jb2rili68HYmSxe5OhPUSbDxYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611112; c=relaxed/simple;
	bh=JUSgmb38PbnNABq5A83eZDkmPdu5rlyhG7tpsGpj41k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KxjYd6maKdTDBMzslKy6hGHaW9JJAhiSt8tyErky+lxukCtRruzeY4THR21z0ITXFYb6Vsgklg44Ebv+zIejx1b0Ewj1roXom/vXIPTvlyArZNUK3HIo5KXS+4Zw1GD5webrpQXVdw0GDuvf8zJbcMCpMMqjWGseO5o2mSTomzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=tDHr5hA1; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="tDHr5hA1"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790611100;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJksV2jh6Jo1tNFP1kfOutlF0XGl4ys5MAsgEowc3KE=;
	b=tDHr5hA1MWvCS7z+QmqemXDIP9oU8TqAn7MH/Pbg8JDydjxoq3FXoRR+/tqAu4tY+0hbXO
	KG0uJRHRbnZuKRcUlu1jTVmDbe2w7BkNh5w1NDI1sEm2Zsfkdjrz1dlSJkAO/l3I594+r1
	tCD0iw7AV3uoXC5C5e1cmAKefgAmRoG6DQfy7V9GLupN/OnK8PyohG7mkrQZJW7ZGkU//2
	WhsAtSu7IA6JsNkMtJB57bWwaxp6EBhT65BqQD/YGrsYRWzIeywSWGhmJDYSIfJb7UYRau
	Nj/FEcyJcfgsqCHTNCfMQeF3/S+gooFs6qBXv3lVqjiM/+AGhznaOMwrfxWFGg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 03/21] policy/test_cap_userns.te: allow searching /proc/sys/kernel
Date: Mon, 28 Sep 2026 17:57:34 +0200
Message-ID: <20260928155753.2259807-2-cgoettsche@seltendoof.de>
In-Reply-To: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
References: <20260928155753.2259807-1-cgoettsche@seltendoof.de>
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

With Reference Policy, the checkpoint_restore test in cap_userns fails,
because test_cap2_userns_t cannot reach /proc/sys/kernel/ns_last_pid:

  avc:  denied  { search } for  comm=sh name=kernel dev="proc"
    scontext=unconfined_u:unconfined_r:test_cap2_userns_t:s0-s0:c0.c1023
    tcontext=system_u:object_r:sysctl_kernel_t:s0 tclass=dir

Reference Policy's kernel_rw_kernel_ns_lastpid_sysctl() only allows
searching proc_t and sysctl_t, but not the sysctl_kernel_t directory
containing the file.  Also allow reading the kernel sysctls, which
includes searching that directory.

Fixes: f24939eedb09 ("Add tests for checkpoint_restore in cap2_userns")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: use 12 chars for commit hashes in Fixes tags
---
 policy/test_cap_userns.te | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/policy/test_cap_userns.te b/policy/test_cap_userns.te
index 2994312..6b6cebc 100644
--- a/policy/test_cap_userns.te
+++ b/policy/test_cap_userns.te
@@ -40,6 +40,8 @@ typeattribute test_no_cap2_userns_t cap2usernsdomain;
 # Rules common to both domains.
 ifdef(`kernel_rw_kernel_ns_lastpid_sysctl',`
 kernel_rw_kernel_ns_lastpid_sysctl(cap2usernsdomain)
+# The Reference Policy interface does not allow searching /proc/sys/kernel
+kernel_read_kernel_sysctls(cap2usernsdomain)
 ', `
 kernel_rw_kernel_sysctl(cap2usernsdomain)
 ')
-- 
2.55.0

