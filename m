Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3D1224AFE
	for <selinux@vger.kernel.org>; Fri, 30 May 2025 11:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748606062; cv=none; b=jh4y2MCFWGWTAiWS57oI/s/vYuF/nrEhTnlfEUyoDV9oOyVKrfOiIYYT60Kz7rUAi61TVtwu6Kz7S31kifKykK83rMkjRwjtnBlKpyZnzyfzKhOB3JnQmBX9Ju4jeCQORTCBLrq/Y8XWzuKaDo7/eFwpwl/W8sm1L2ZbqWfoAMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748606062; c=relaxed/simple;
	bh=0DmOBSkGt5cVxh0tHMJ4+EUfiSoOPVe3mQwYVS8w+E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6tLGxjs1cltLG+GE9SJxXNaQkXONuyuyuxnJTh6JCd6YPwjZ2TjANxWR/yA5cjERWcUQ1lKVHxW8eI+/WYwapxKsumMQOl+cXjIgyczUI5gFrODyIrS7l9hNPT17iS9HEf6UAm1RrKm9/6x9iYzwJR49mu4r0534DdH7/AIwFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=GLcVI5wQ; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="GLcVI5wQ"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1748605726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YWPIkJqw9uPkbepOvcoYgc9p2opDyOkDc0zXlyEZYXI=;
	b=GLcVI5wQa+URE70nqHHN6iqvP0M0eC00g5DCuoN7+VC/nwvl5gfMW3Far/+rn4MopEwZpF
	pBVR69R7jBZ7/KvGu8FrhMjm7XBm/AF/5YMnfXYojUwuje6JvrZ/pUVqg92v2KT6bLUqAX
	GuXN4wVUVMGsw7dF09xjYoNe4UYZFmU7znaFnDAVjuXQxHN6MY3eY0yWyJf9LE/jXnt/8C
	X6atSjuZ4Qm5FSihwfAEpb1V+lb+CPH0F72KtT5JH/mDkHyJyM/rJl0QrdyCanE25Gpq1R
	VmPkVvOnbC73ccTyLmclGwUs6kwwRsbVR1OQsrUTMejrZOqzdPCG1ZXqcMGjAw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 2/4] libsepol: add netif_wildcard polcap
Date: Fri, 30 May 2025 13:48:34 +0200
Message-ID: <20250530114836.30643-2-cgoettsche@seltendoof.de>
In-Reply-To: <20250530114836.30643-1-cgoettsche@seltendoof.de>
References: <20250530114836.30643-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

The kernel supports wildcard in network interface names with a new
policy capability 'netif_wildcard'.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v2: add patch
---
 libsepol/include/sepol/policydb/polcaps.h | 1 +
 libsepol/src/polcaps.c                    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/libsepol/include/sepol/policydb/polcaps.h b/libsepol/include/sepol/policydb/polcaps.h
index 1aa9b30a..7bebe4da 100644
--- a/libsepol/include/sepol/policydb/polcaps.h
+++ b/libsepol/include/sepol/policydb/polcaps.h
@@ -17,6 +17,7 @@ enum {
 	POLICYDB_CAP_IOCTL_SKIP_CLOEXEC,
 	POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT,
 	POLICYDB_CAP_NETLINK_XPERM,
+	POLICYDB_CAP_NETIF_WILDCARD,
 	__POLICYDB_CAP_MAX
 };
 #define POLICYDB_CAP_MAX (__POLICYDB_CAP_MAX - 1)
diff --git a/libsepol/src/polcaps.c b/libsepol/src/polcaps.c
index 6b28c84e..ec6c902d 100644
--- a/libsepol/src/polcaps.c
+++ b/libsepol/src/polcaps.c
@@ -16,6 +16,7 @@ static const char * const polcap_names[POLICYDB_CAP_MAX + 1] = {
 	[POLICYDB_CAP_IOCTL_SKIP_CLOEXEC]		= "ioctl_skip_cloexec",
 	[POLICYDB_CAP_USERSPACE_INITIAL_CONTEXT]	= "userspace_initial_context",
 	[POLICYDB_CAP_NETLINK_XPERM]			= "netlink_xperm",
+	[POLICYDB_CAP_NETIF_WILDCARD]			= "netif_wildcard",
 };
 
 int sepol_polcap_getnum(const char *name)
-- 
2.49.0

