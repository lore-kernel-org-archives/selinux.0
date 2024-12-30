Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDA4155345
	for <selinux@vger.kernel.org>; Mon, 30 Dec 2024 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735566684; cv=none; b=u/DXQerq0DaMhwMBvbwh/BrAUl9ox0Fze38LvxUQKFhklctsWqU5ab8rBJx/9Djb2JHq5IA0uz3ZQL0hJiWCSG+2Mg4ZVkXa73Py7fGb+RV1pBxUoy2op9jjMSAjWaYPTUV2/+gcLm31gPLxU9cPdYsB5JzXpEo8UyMPktbKlhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735566684; c=relaxed/simple;
	bh=Bfr54sgt8WI/61HeyGOc7P4VsZIDUlmKBsY+hO7i93k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GBvqZgVqNUSjnl9039E6vc5OLw07PK9nW7z22zyshurhCDy4636wBOsus1nZDBR8mHpmMlGkhzF5oRKggZxgh+keEPcNEgHwV8Am/k4r3sTK2c+jB9KYSDjv7EBrAicg0n83svNeNqXO5aGR3YR02Iuxui9xLokh4r0UvHJRm3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=tEryWgY2; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="tEryWgY2"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1735566677;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=T/YTEseYnaR3hOz5vEaGv8fRZkameTab2d12jeNhxx0=;
	b=tEryWgY2NC4RvLwTuAOOonIr9BqICACz8015Nqn6Hnx9yPJXi3re9oKW4ij+yfykScueEd
	zF4GZnct9nQ6eMKfsbLJXvxnOCZCXQNzylagiG+j5NoMhcpApASXmla30kvJD1fCap67ET
	VsnqrQLUu3TC5M7ZjMuL0qJdLz8GFQcdsHG5ezm2ZtBx+ua7WneJ6SwT28InEzrSrQN4Pb
	aCRtKUcLfFKVrf3+KEd3FwRuj876ZdXkXJxqKAphkZAJBDaS+k6Vttv+XpbSgodeaiw5zp
	BC9sCGQUrpBTg+Jw4cLS4byptzZKKYVF1TUIyivZ6vgUNsLtkYWM5tcM3NJfiQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] libselinux: update max node depth
Date: Mon, 30 Dec 2024 14:51:14 +0100
Message-ID: <20241230135114.41947-1-cgoettsche@seltendoof.de>
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

Bump the maximum specification node depth from 3 to 4 based on updated
benchmark on Fedora 41:

    Benchmark 1: /tmp/destdir3/sbin/restorecon -vRn /
      Time (mean ± σ):      1.397 s ±  0.018 s    [User: 0.755 s, System: 0.641 s]
      Range (min … max):    1.353 s …  1.419 s    20 runs

    Benchmark 1: /tmp/destdir4/sbin/restorecon -vRn /
      Time (mean ± σ):      1.376 s ±  0.021 s    [User: 0.737 s, System: 0.637 s]
      Range (min … max):    1.348 s …  1.414 s    20 runs

    Benchmark 1: /tmp/destdir5/sbin/restorecon -vRn /
      Time (mean ± σ):      1.389 s ±  0.021 s    [User: 0.748 s, System: 0.640 s]
      Range (min … max):    1.351 s …  1.420 s    20 runs
---
 libselinux/src/label_file.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
index 597b756e..41b2a939 100644
--- a/libselinux/src/label_file.h
+++ b/libselinux/src/label_file.h
@@ -105,10 +105,10 @@ struct literal_spec {
  * Max depth of specification nodes
  *
  * Measure before changing:
- *   - 2  leads to slower lookup
- *   - >4 require more memory (and allocations) for no performance gain
+ *   <  leads to slower lookup
+ *   >  require more memory (and allocations) for no performance gain
  */
-#define SPEC_NODE_MAX_DEPTH 3
+#define SPEC_NODE_MAX_DEPTH 4
 
 /* A specification node */
 struct spec_node {
-- 
2.45.2

