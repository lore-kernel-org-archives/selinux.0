Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA3B1CB31D
	for <selinux@vger.kernel.org>; Mon, 16 Jun 2025 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087863; cv=none; b=Bei+vRFbQny6iySSJx7jZRtlYumSnwpny00ZIHf/EKgI11yGm3tgYReF2TvMq1kboil8BFhRWkXdNtKH3ZMC5kpzUPatdFjv4q2OkCakpWE7zScJaxzow2RZlzLrI9YFAFF0SaRpl0p1Bkv9LDZVkRGj5DU8+JqmfYSwEMlUe24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087863; c=relaxed/simple;
	bh=0DmOBSkGt5cVxh0tHMJ4+EUfiSoOPVe3mQwYVS8w+E0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rHU/ghXGKNhGxFELl9NXUT3UO9K6MDGHmZeW1seYPLgom0p6mI1kHWTVRj4/HEOJzNYXRt20mkVuo64A9r0jBo+EL3qfi42wlaFrwc+yiKQDSdoLwFAa8rKJt0hn3McpWpSFIY68031iW7jdOkXM3Ud/Oi5c8GPUrxSPt6jiB30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=qzOgnJAB; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="qzOgnJAB"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1750087543;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YWPIkJqw9uPkbepOvcoYgc9p2opDyOkDc0zXlyEZYXI=;
	b=qzOgnJABQEdORyvNJK7P2ItIVZMlE4ock/KlMtrBSCwHeENc5Ye/q0KzJYKT9kwBDyw4Qr
	gWQ9GBQgiVI6pEkVX3Wk2tT6mIMpJi6q00u2lKPXAE8of3MegH1tSIrij0uzK79Rh/Uotm
	tb/wBJ+ieub9Tfu5HxiHFkNq+ioQpFBrToHF61rS4YujgEGz9kcpaer4FgdhFlJT1Xk4j0
	JWS7YFkUYl3ciBg8zhWM/ijKOPFV6ge5L2KgqlfShgUprFuGPE3EWaKK8K5Xm4mEY9Jsdz
	Nr7NUo5BQqQ5BVLPS6Vkdhu6SMpuqhf/8qBnTaO85LxZC7c2rG7B0k7azbLUgw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v3 2/5] libsepol: add netif_wildcard polcap
Date: Mon, 16 Jun 2025 17:25:30 +0200
Message-ID: <20250616152534.26053-1-cgoettsche@seltendoof.de>
Reply-To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
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

