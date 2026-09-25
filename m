Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A9E38E5C4
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 17:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356726; cv=none; b=oUKhjOjcQAwaVpxBa0WtEbfd9MGx7yjinXom4nW2rMDqOzBkLU+lL8zjX+NbjdObsdLsitt9bQbCSuDsnyJIBzo3ir+14MKLNX0s86fYjd3Rm40R+h8IzAQqeAQMZg/myQi85oHViIH9qFnY3ZlTNtMQQPaCqAl+oae5zb9VtOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356726; c=relaxed/simple;
	bh=pMaQ/NKt7KsgdOS4YVPfhDKYS9JIU/1bz1zuPU+D1Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MR3JfV0m0Htdl/8T6fWAdyJybusTtJRoZbDn0wJxjuA+5/eamTzdRkW42OLRraXbMluIXN/vCq8AFuRpLlpd4T86cEvG2dO45hnFAYQ9/RZwzr17doHLTs9ELV6hqH18Zm/cEqQOwJLt7TJW/k5RfhYSrJwRcJP97j2d/wOm8Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ZNGLDV8j; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ZNGLDV8j"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790356711;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6BE6j48O9sIgyh3Za6o+5ctcpmNXknxE3Gi+o8Cpj8=;
	b=ZNGLDV8j5hIsSYUhFVcd6H9pja/FF0o3/gk+N+761w05iaKByIuZlTJiKGzu6pGnNBqlTI
	S1PHeZCuHcfNCc7HSxmH3dT0kQ2UszwH+Fm7ze5JGjs3lyxkx6iR1wTVYX5PbX1l5O6nIY
	PnQFgeAJJCTYce626RWckbHH3auzEinMe8c0GXpXsjHsGCuQJFRhESUl98W05CZn+3D8oo
	1ls9n87XF0v8gmFUW9NqT7au4e1k2JPwyCooygn3J8SnaHeQ/c/hSqRgKjUMTWHrCxHRjF
	4CLyoj3BHZfak+JKgCqSrb38ETUNII168LFiz3uwF4D/8+MXQtdFfZPjelnwkw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 06/21] README.md: update the Debian dependencies
Date: Fri, 25 Sep 2026 19:17:38 +0200
Message-ID: <20260925171755.2029271-5-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
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

libselinux1-dev has been renamed to libselinux-dev after Debian 13
(trixie).  Also add packages providing tools used by the tests that are
not pulled in by the listed ones: make, lksctp-tools (checksctp),
keyutils (keyctl) and f2fs-tools (mkfs.f2fs, as in the Fedora list).

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 README.md | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/README.md b/README.md
index 5487085..7722c1d 100644
--- a/README.md
+++ b/README.md
@@ -126,20 +126,24 @@ command:
 
 	# apt-get install perl \
 		gcc \
+		make \
 		selinux-policy-dev \
-		libselinux1-dev \
+		libselinux-dev \
 		net-tools \
 		iptables \
 		libsctp-dev \
+		lksctp-tools \
 		attr \
 		libbpf-dev \
 		libkeyutils-dev \
+		keyutils \
 		linux-headers-$(uname -r) \
 		quota \
 		xfsprogs \
 		xfslibs-dev \
 		uuid-dev \
 		e2fsprogs \
+		f2fs-tools \
 		jfsutils \
 		dosfstools \
 		btrfs-progs \
@@ -148,6 +152,9 @@ command:
 		libibverbs-dev \
 		liburing-dev
 
+On Debian 13 (trixie) and older, install `libselinux1-dev` instead of
+`libselinux-dev`.
+
 On Debian prior to version 11 (bullseye) you need to build and install netlabel_tools manually:
 
     # git clone https://github.com/netlabel/netlabel_tools
-- 
2.55.0

