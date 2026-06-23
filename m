Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7E537C929
	for <selinux@vger.kernel.org>; Tue, 23 Jun 2026 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782222153; cv=none; b=oGx+4Dc9ONyQY7AxlwMKT+hSrUpjfbOluvz8Q8yr/mWvb6ffZ8aQTtzU7RyaeeyfnANlBRQ7xKf0MNoItxe0dh4YL1bH/P2rRV4fZGJOAh7U4Z38edlxqu4N19W4AguAJQ/Rkwl91VklhZop54xsmq5uDXOJFauqQA3FB2cGMQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782222153; c=relaxed/simple;
	bh=75Z4rAtrlhbwd9Q52pBSjTeTg8Uu/u8D+Ynhd3J+BgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KCKJo+dd6SMhgLi7vS457rLiwjk6HArnlSwGwcBT3cId2jKqBYAdveQwBrnv5HvIXpIYnRstmK0oOA6b6x+i+LKLkdkwRNGvOdCpq91nIpGWJIlIvtvb7wIeT3mW16Esi6zKrmWET8kyImLg2S/pQ1j3GNz4wurRDpI9xVcglBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=V2N520rO; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="V2N520rO"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1782222150;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Dv9bcwKqpvrmgb/MMKVx653Vp0IevnmzNinX4QTRi4=;
	b=V2N520rOutsxO7we3Q/P4ACCfmSeoDYPC4QGhgtMDK8Uc8jzT6tx/kw49Phs13T8SSNpQb
	RhsB3J4b1dVp5T/yh2Tb7Coj8/0fQaHdhqhLHnwfOIZ4h+Cl6bxkF+sQPkxhSgkde8y6LO
	LjCPstXV9LGSaJxrqiZpM38HPxqS9X/WMyJ44w3SD99rTMvVhzl+clculAvgUtNHrK2G5D
	xJFqqIg2KNMTseuDlx6SR0JI3CRTUKio3YvVlS7d13F3XGa2gXoElB+tibYmgCkmeEYYrK
	3O4G/WSkF+FXOq6YpU1ZJIjeWLPRYc/h0NFJoWZy2XcWxpSL/LfdLyo3n7fZeQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 05/24] libselinux: guard possibly-NULL role/level in getdefaultcon -v output
Date: Tue, 23 Jun 2026 15:41:54 +0200
Message-ID: <20260623134215.98273-4-cgoettsche@seltendoof.de>
In-Reply-To: <20260623134215.98273-1-cgoettsche@seltendoof.de>
References: <20260623134215.98273-1-cgoettsche@seltendoof.de>
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

role is NULL unless -r is given, and level can be NULL too; passing
either to printf("%s") is undefined behavior. Print a "-" placeholder
when unset so the field stays aligned and no double space is emitted.

Assisted-by: Claude:claude-4.8-opus
Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 libselinux/utils/getdefaultcon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/libselinux/utils/getdefaultcon.c b/libselinux/utils/getdefaultcon.c
index 38057ad9..a6c780be 100644
--- a/libselinux/utils/getdefaultcon.c
+++ b/libselinux/utils/getdefaultcon.c
@@ -114,7 +114,8 @@ int main(int argc, char **argv)
 
 	if (verbose) {
 		printf("%s: %s from %s %s %s %s -> %s\n", argv[0], user,
-		       cur_context, seuser, role, level, usercon);
+		       cur_context, seuser, role ? role : "-",
+		       level ? level : "-", usercon);
 	} else {
 		printf("%s\n", usercon);
 	}
-- 
2.53.0

