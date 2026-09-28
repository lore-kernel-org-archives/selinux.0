Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C194E80DE
	for <selinux@vger.kernel.org>; Mon, 28 Sep 2026 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790611111; cv=none; b=hR5/ABLu0JUm6TxfsCFBJAoA22+qORjfjy6BX6xg62vNFIxMifPIvXgeBCON8a9J7owAFN5nhKJnqoU8Vmo64r1guT/Ct6sXzmeS7VuYG0+XHZtgx8+I36AuY2gSkyquHjvTqn0i6rd8Sh+8t6myXyDD/2Lk4pO2uGXSo4umqjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790611111; c=relaxed/simple;
	bh=pMaQ/NKt7KsgdOS4YVPfhDKYS9JIU/1bz1zuPU+D1Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uSzkJt1ckbATTbPAoLy827JVYg+ITBu0Q+a9zxoACGXPpN37dq9R4rh8YEwQroKZOOaQb5XFk0puUQ4wxbF6VPlM3qssDzlQnDjlJxQmIAdkT4g3SuvC+qiVs0E+6Mrv5LYps8pyUkW1LVWVs3g5YoexTHNdImDBEQdC5RCI+6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Hbr5GGQq; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Hbr5GGQq"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790611100;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O6BE6j48O9sIgyh3Za6o+5ctcpmNXknxE3Gi+o8Cpj8=;
	b=Hbr5GGQqYSmbgqHnhoR5k0cJlT1JZ9LGjskpAaJTjoIz5xLkJ005mYDZF7djohzn3cfGO0
	sKm0D6a8W9p0bMrnjTBbsBPQ7xuqAKbVzcMQNPSwLKrx52eq21nqPi2Hc9RoQ40FMToOeR
	PdGu5hz76QtW5vXMsc/pTgQGnxLVhZoQkKWOB/K1L4oHW4b3R/cLuSJeSRmiFXmFxHW2r+
	lo1+R5KaTkwMk0dZ0GgVqDVkZTjfrjTuGYG6psB6NNYBHftlf3ILeA4+9MOG4pW5FAA1ds
	9R6RcnfoI01qOgJVC4VYFRS4xk9RI1PlAFAIj+CT0EKgATnapTd44zB4q7Wsdw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH v2 06/21] README.md: update the Debian dependencies
Date: Mon, 28 Sep 2026 17:57:37 +0200
Message-ID: <20260928155753.2259807-5-cgoettsche@seltendoof.de>
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

