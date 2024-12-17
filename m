Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7691F543C
	for <selinux@vger.kernel.org>; Tue, 17 Dec 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734443992; cv=none; b=iVMDOlSa/JqIemFIWEPdf/YAzZMxIf/AW9o947ty1qWT6scN2kqgBvHc6PRe2rM5Ao9THsuWihyXn8ZZS4azG1Uh8Q35Dbx4/DGoVM/aoiD36wRYFqrVPrBRpNNWQgVrGEd+rXxg7LAZIyvMWh4ynWAY36C9ipaDTtLZ1OHTbZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734443992; c=relaxed/simple;
	bh=DVhsF7mNdL0nd0JOfye7CCVK4J0gc1TbvrBE3kbldEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGzn5i63T5OR58gElslIzJIogxQCh70KKfGsHFnvi8XUpGOwByr1runAmc96RfqqTRbJVApKAwzV4ylIwnBq3ap5BByuabr7ETNos05TK8PzWx3HdmQUW+OIgfrkQhU1gVBG0kq0Nsv7FUP+93IkBSZYLAK9J2A+xnnge3qC7Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=XBnYT0LA; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="XBnYT0LA"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1734443987;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0y2DNF6/okIlIXfjy5vwRKAX8Gdy3dUzG9VlFB+kdDk=;
	b=XBnYT0LAfTYNQIS9H/L7eXoK0lHexJ5hEYLhls6Qdz6V7KZGe3/LwcJcv/AdkyfzsTFE4w
	hspPpdBTm7rHBfWGmuNEgp2jpJlatQ1BDaeSL2i+6YnJvYeE74iyk27mugo5dMpzbj24f0
	gKYbau62o6J5bYZkHSQeRs8r7hyA2yypTeW/p16jvFvRerLESZg5UUK4HhgBuUkDyUiUAF
	zQqHycEONmb/5BXYEjN+YaEgNgMZhr/zmLDws+Czx310BrzsrWj7NByJHX1X/RZNklFpXr
	e4r214rYDCJKoK6W4QU4H1rxC6ldgf0/jgcxkoj6BNeyvW+8zfBLXA6AmnILQQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH 3/3] secilc/test: add test for wildcard netifcon statement
Date: Tue, 17 Dec 2024 14:59:40 +0100
Message-ID: <20241217135941.536152-2-cgoettsche@seltendoof.de>
In-Reply-To: <20241217135941.536152-1-cgoettsche@seltendoof.de>
References: <20241217135941.536152-1-cgoettsche@seltendoof.de>
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

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 secilc/test/policy.cil | 1 +
 1 file changed, 1 insertion(+)

diff --git a/secilc/test/policy.cil b/secilc/test/policy.cil
index d0d52d0d..9761fb4f 100644
--- a/secilc/test/policy.cil
+++ b/secilc/test/policy.cil
@@ -288,6 +288,7 @@
 	(portcon sctp (1024 1035) system_u_bin_t_l2h)
 	(genfscon - "/usr/bin" system_u_bin_t_l2h)
 	(netifcon eth0 system_u_bin_t_l2h system_u_bin_t_l2h) ;different contexts?
+	(netifcon podman* system_u_bin_t_l2h system_u_bin_t_l2h)
 	(fsuse xattr ext3 system_u_bin_t_l2h)
 	
 	; XEN
-- 
2.45.2

