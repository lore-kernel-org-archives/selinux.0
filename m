Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5049730BF4E
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780680149; cv=none; b=HYjr49OFwl3H4ELn72r1awEh33juAT6Z0L86BO9ilMIkmiOrfe5WZSUoCpO0l3+mBUVDuN5Sl5jqwjWTLBtlVb3UjhBvbX8Z6/yVULaMHMpaeRlR/Wo4wIoWsCsZwphIxgC217DPBM2WGPXd7IcdL3dAISnMVDMo61GU4SiV058=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780680149; c=relaxed/simple;
	bh=ppwMg0ObVqi1pJz2xNlmIunKluaIkHYsT/22EHrxbhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P/Fc98SK/IV/17OGMLPoiY8Z8TcS4oVE1i+xkRDQxUYw7F+rEZkdVgh+0aImo+6nyTZQUhlMMGeRit2OZI8Wefib1D8GJDhpfvCOzD8WmysCUQA+GMNVIreruyJNotiqgtK97UCPftg2Si6zA+AjZKCe3ZgomRVCSojS+gdwlfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=H/tOe/Rb; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="H/tOe/Rb"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1780680145;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2lR9m1pPU1dmkETIW0UGc5zRufOF8bjpgAQUS/+uVvw=;
	b=H/tOe/RbsM/wHk7mYs71Ph6FpKMAvwpyj6OyS2RnHV30glWKozZV1KUuEcbi2a1kU9qQkh
	a9iKT0AGBiWWp3XaeggkL7XCVXN+WYuAYk5WAve7m5b2O//yvwEiSFfK2ZSRIBzAhO01Cj
	gC+KoDLV/ZvgAHU8TFSuAw1vEYZfm6xf7QkbixXGqxc4twtF6A4WEBfhmrtsJKCZFg8ipm
	rv1fJ0KNqNH/hNYsje/J1G5duTo0tWb1sTbVJxGWU7FZKho/uShaq9sbbt1tehVl+UQeL3
	/j7jdHVjk/Zfiev79uoI1Pbolh1hGMN2r8AyJppS7OzMLJNqWG8MMBlfJuzjxA==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 01/11] libselinux: use size_t for index
Date: Fri,  5 Jun 2026 19:22:07 +0200
Message-ID: <20260605172207.222382-11-cgoettsche@seltendoof.de>
In-Reply-To: <20260605172207.222382-1-cgoettsche@seltendoof.de>
References: <20260605172207.222382-1-cgoettsche@seltendoof.de>
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

The variable is used as array index and the only caller passes already
size_t.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/src/booleans.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libselinux/src/booleans.c b/libselinux/src/booleans.c
index 4e752424..9ec46ed1 100644
--- a/libselinux/src/booleans.c
+++ b/libselinux/src/booleans.c
@@ -329,9 +329,9 @@ int security_commit_booleans(void)
 		return -1;
 }
 
-static void rollback(SELboolean *boollist, int end)
+static void rollback(SELboolean *boollist, size_t end)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < end; i++)
 		security_set_boolean(
-- 
2.53.0

