Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795199302;
	b=WRZY1w2NMtBDyap4/eWB5WpcPysw0zrycykaa1/zvWJO5ATQ9f62pFKJZHhDUq2E9VeG
	 8wWvTWFFlwvRL6g4FnYPqhcm8Lfs530W5JVshRF45A1xn6eu36F8OXi9vHmPalG8Eqlt7
	 c/Zo1pa87VUBCUjhKzFK69GPApkfOsVmGwRRM4R4eLqlsZMZTh7tEWqRso8wo7wM1gEB/
	 5T/1DKt54n4VxZAfROv5+XTzwL3+RcV/dRoW5CQJAm8UjNiDFZppIPHJbVPc13i1Cll6i
	 EcsHROUVLfZOZxPU5QWqneADfbXP6YJCVur5jXLX0anadfDT3XHOFY/BynhbWu/p9uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795199302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=KYw0NCKSZ05SYydlW50g24YuI59V91jMDIB9dMNtfj0=;
	b=FNdjil0nJWPq1PuFFBTRFE3AWq3oyYHzk08BGylBcPQR+VUe1QR0bKA3PXqvQlWVzf5T
	 NxhPnedPuWWp4ELJAcQwqUNbdESAfa/d492CIrXMVQBx8QBqBLIZSGnDsieB8xBVlx5Tg
	 +vnXJ5x4gtz5lJNsv9hEmayvxBhBjw4xpnsTm0H3oYj2E7t1x3fL3iNOPaU/Zb3pm79Nx
	 oAGhei/OCeUFMtlSUxKlvNm2Izi2IfC5fZeEk+p8GYJlJGFOdWWwf1bsZPlaL/yu7v/xb
	 ZSjKGCZjO6960h78Dmhq8o628aSl116kfPr4X5vYhmysn9Ul6yvaBCMwIaFa9W8V8Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oXdm42TM;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDFB606A320
	for <selinux@vger.kernel.org>; Fri, 20 Nov 2026 18:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBDFB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oXdm42TM
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-55bd96affd2so29721701cf.1
        for <selinux@vger.kernel.org>; Fri, 20 Nov 2026 10:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795199301; x=1795804101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KYw0NCKSZ05SYydlW50g24YuI59V91jMDIB9dMNtfj0=;
        b=oXdm42TMH+42psCRifGy7uJnAxzF52B15JK3e8Q2liBX7dkR3WguwZN+WXs27SfQQX
         IrvjGgrxabgudluTGC9NyVBgbYVrvXqpDMeChzwugC5D52/nW+iBRQe4LlD7mLlI4J6X
         xX84O0Lu4GZ2NV7hwlRJNSU6mkgRHiK+S+G/PVuu8q6EIIlMRc9jq+bG4rt4h9AidDFF
         IuDVDHM0wEr3yvl32njXoawLkEHChANBaic0caRGqaUkV/O4Th8G0AwBqR8/SbqGef6D
         7tUDAgq7FWAab0qRsB8g99ytHIs+MhC0f1GBpYooUnWN3nV7c4zFJsMD29x8JyhUqXIR
         vOdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795199301; x=1795804101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KYw0NCKSZ05SYydlW50g24YuI59V91jMDIB9dMNtfj0=;
        b=vjyCGcs41y4Xd7ZDlRr2+GZXKnHk3VkQXm4c5uBbPXNHI9+Hzj9kH2o+JXpy42PaL4
         ObplDEN5Ku5hWm01ahDPhMvB9tvI1wAteHGJQ6iOtEVzBOYmG3PrAsoF1JQkblipMdOc
         jA3LZOMEf+wmgpu9tHgj6TpNJRqwh6y7hjWhegoQkh2E5mgL8k7Zhf9VZP2QgzHltj5L
         W3Dd14AqAyZ4EkYpqzuYUjU2MZ02+lYae6YGrhVnSL+lNlTF2ZJao5qONXvcMjyh1q7r
         PlFeSKVVFz2FkM6u1FpcMvyjFOzKizBr/ng3qMsYN7z3lUqHxWCIQ/6q3U1Fypfcas49
         YAEg==
X-Gm-Message-State: APuU4Z+FVOSpPFqxISwZR30IBWXum0Q5jcTY2N8Vsc7xtgfczwJqaQ18
	7GUycu+VwJEKIj27OR8V2SCpvveI0ilimpqDXIyseW5glgAcKo8bG37UYuY6cJVA
X-Gm-Gg: AYBFou2BdG8sbrLsdcyxvGgHGARH8XjJrGhEpTOE94lOS5h9Z0UoAfxxBBcQWJdmEe3
	G9ieFaALKizfgy2W3zaXuuuhJgHd5HAxZ4wNvPhYT2YZrdYxj9migDzA43/kwymF8w7yLa5m8Z9
	e9B7Qx4P8NrZvAMfG6qxxMknoSQxThYW4LFVf0nJltAUBR5/3ybEvLro/bjjuAGc1w7C6K3hgxE
	ryc1VOQO0o1ScErjGtZ6iz+zXub7bwIJ1rPRHv1ctRSU3Jp6x8Rpv6wTKg2ys3uZOL+T0SK4+PS
	QUS3dRoNUK+6Hrwc+cBRO1MCcuRnJyvvroIgVTh8xo9pGNDfLofShGKqXiOr01YHd2dQs3L4FNx
	N5O/cGZzV9DBBzQNbVLrxGNw47CF45YTh0oDzxnp/bZwzazwvPw0rRH8opFQH/Y4Lr2f5gEZ9rU
	z6BR7asAyrYy5lFMtE+UI9sodwxoR7bEKCbxDPW29wVhs88EnaYNrXAE+sr2iDetj4J87LnDlWj
	Osy9ILADLHnGZYh+7v6BFF4v1zKil9eJTfKTa6Gc8EUf8xTNPQk4ZcAN62jzaqSA6rSxwY6quHe
	Di8XXcBlPGCUNvQUmjMO6M/B/3PKazMovFNoICn5YDUaQ+kUQsMI9IlKt9VWWLCgwU7pHIk96gB
	8nYsNXcLZg5Si35DK+9mxOp/tIfNgFA8vhrScNwLzT0rP696uZuyoF7FgCMATajRorhcqRBZW81
	xYRFl3ftPRgkeyKQc1PRhIYsa1dvbB4PvXwac3VZ2syUvTZQ==
X-Received: by 2002:a05:622a:8c6:b0:545:c5ec:fa50 with SMTP id d75a77b69052e-55d76a02015mr59962571cf.20.1795199300245;
        Fri, 20 Nov 2026 10:28:20 -0800 (PST)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7887b610sm28733251cf.23.2026.11.20.10.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 10:28:19 -0800 (PST)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	cahu@suse.de,
	jsegitz@suse.de,
	tweek@google.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH 1/3] .github/workflows: update python and ruby versions for ubuntu-26.04
Date: Fri, 20 Nov 2026 13:27:56 -0500
Message-ID: <20261120182758.38923-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Post: <mailto:selinux@vger.kernel.org>
List-Help: <mailto:selinux+help@vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:selinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CI fails on ubuntu-latest because it has moved to 26.04 and the
matrix referenced python and ruby versions that are no longer
available in 26.04. Update to the latest version and drop old ones.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 .github/workflows/run_tests.yml | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
index 445ccd2c..3313ccf7 100644
--- a/.github/workflows/run_tests.yml
+++ b/.github/workflows/run_tests.yml
@@ -5,38 +5,29 @@ on: [push, pull_request]
 jobs:
   build:
 
-    runs-on: ubuntu-24.04
+    runs-on: ubuntu-latest
     strategy:
       matrix:
         compiler: [gcc, clang]
         python-ruby-version:
-          - {python: '3.13', ruby: '3.3'}
-          - {python: '3.13', ruby: '3.3', other: 'test-flags-override'}
-          - {python: '3.13', ruby: '3.3', other: 'test-debug'}
-          - {python: '3.13', ruby: '3.3', other: 'linker-bfd'}
-          - {python: '3.13', ruby: '3.3', other: 'linker-gold'}
+          - {python: '3.14', ruby: '3.3'}
+          - {python: '3.14', ruby: '3.3', other: 'test-flags-override'}
+          - {python: '3.14', ruby: '3.3', other: 'test-debug'}
+          - {python: '3.14', ruby: '3.3', other: 'linker-bfd'}
+          - {python: '3.14', ruby: '3.3', other: 'linker-gold'}
           # Test several Python versions with the latest Ruby version
+          - {python: '3.13', ruby: '3.3'}
           - {python: '3.12', ruby: '3.3'}
           - {python: '3.11', ruby: '3.3'}
           - {python: '3.10', ruby: '3.3'}
-          - {python: '3.9', ruby: '3.3'}
-          - {python: '3.8', ruby: '3.3'}
-          - {python: 'pypy3.7', ruby: '3.3'}
-          # Test several Ruby versions with the latest Python version
-          - {python: '3.13', ruby: '3.2'}
-          - {python: '3.13', ruby: '3.1'}
-          - {python: '3.13', ruby: '3.0'}
-          - {python: '3.13', ruby: '2.7'}
-          - {python: '3.13', ruby: '2.6'}
-          - {python: '3.13', ruby: '2.5'}
         exclude:
           - compiler: clang
-            python-ruby-version: {python: '3.13', ruby: '3.3', other: 'linker-bfd'}
+            python-ruby-version: {python: '3.14', ruby: '3.3', other: 'linker-bfd'}
           - compiler: clang
-            python-ruby-version: {python: '3.13', ruby: '3.3', other: 'linker-gold'}
+            python-ruby-version: {python: '3.14', ruby: '3.3', other: 'linker-gold'}
         include:
           - compiler: gcc
-            python-ruby-version: {python: '3.13', ruby: '3.3', other: 'sanitizers'}
+            python-ruby-version: {python: '3.14', ruby: '3.3', other: 'sanitizers'}
 
     steps:
     - uses: actions/checkout@v7
-- 
2.56.1

