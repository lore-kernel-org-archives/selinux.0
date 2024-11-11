Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE841A070E
	for <selinux@vger.kernel.org>; Mon, 11 Nov 2024 14:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731334642; cv=none; b=gao/DLUVUR4LXBoMQiqm6XI7du1SfPKGuVaSI9qU5f79K6tp69C5S/w1r19eUZF/aj0+3m230TstategFYZuV9XuHgiFnE45wBuTur2Eh5+Usf26y0CStb4Ug7eN9LdANyVvINyDNy6SZ0T5io06SWpJjKFmWFVuGU5eUl3Ie7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731334642; c=relaxed/simple;
	bh=4qCEOFCu2qIajZVZjeSLxVHJEUHQfO7yC6sSb8M5q5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ece6KLMVz0tIRuQGpXXNtc9sOeIEsSh8hJwuZtP+30qmgZ1OqUKUFaEaw27qvTnb0qWTb6lmuB6TPs+HXHQTMHNf88nWFmGmWu+LSiSTeETtQ+na+U7lXSaNl/xWxKGc01q3smEFB84ufejDy15DMhXjdtZ7tArsgi6XlsBlpyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=pq1aBRaA; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="pq1aBRaA"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731334636;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iD70GYzyUku4cZWsoZWoMmKmHLAlUXDUa7FcnUk6G3U=;
	b=pq1aBRaAIYsxCAOvyucHrtjnxUr9jvvdY/+/znupHZi5GIVtDOq5FxZvmjrFhUf5zj8hfo
	KG8yrSdryI08VLkRCEF7Ij9lTgk/cB3wbEnqbBtiodqoMRuIVyAF2J1TovmM7vi40LA9ne
	jwqy6vz8JK6Rj2srzdraDbpEuNHG4yy2HVqFBYsj036INkFDmt38cVFMXnTzkfY+MTsp6O
	vPoE8XSJSXi2zGNRbvI8C3bnpMcyTAFs4eEVjyN6WcQRbrN1JyU1TSnb9nWPdeMQ/K7arI
	LfGRVGid1vfP5evb8uvygB1zb+75yE7IMXxWlxT0LKcRI4AEm78E3JmPHNzOxQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 18/47] libsemanage: fix asprintf error branch
Date: Mon, 11 Nov 2024 15:16:37 +0100
Message-ID: <20241111141706.38039-18-cgoettsche@seltendoof.de>
In-Reply-To: <20241111141706.38039-1-cgoettsche@seltendoof.de>
References: <20241111141706.38039-1-cgoettsche@seltendoof.de>
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

The content of the first argument after a failure of asprintf(3) is
undefined and must not be used.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libsemanage/src/boolean_record.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libsemanage/src/boolean_record.c b/libsemanage/src/boolean_record.c
index 40dc6545..7878b04d 100644
--- a/libsemanage/src/boolean_record.c
+++ b/libsemanage/src/boolean_record.c
@@ -107,8 +107,10 @@ int semanage_bool_set_name(semanage_handle_t * handle,
 	end++;
 	*end = '\0';
 	rc = asprintf(&newroot, "%s%s%s", prefix, olddir, storename);
-	if (rc < 0)
+	if (rc < 0) {
+		newroot = NULL;
 		goto out;
+	}
 
 	if (strcmp(oldroot, newroot)) {
 		rc = selinux_set_policy_root(newroot);
-- 
2.45.2

