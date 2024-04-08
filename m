Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C413F2561F
	for <selinux@vger.kernel.org>; Mon,  8 Apr 2024 15:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590876; cv=none; b=PVIkE/1HncpfY3FnyTWJOPkGu/+tqYf1mpRDQ8xMi3owAOWjlcARX9s0Kg8gC3qcxgD456A6ISzUrn9Tia0vwTR+gmX8JoNN1yMPXdU6X6bIO+jjUyoPzxIBPrrC32OjRHeK/QtGXYr+5v3DD4MZ3BAbeqQQ0w7RZKgL0PYGzjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590876; c=relaxed/simple;
	bh=9Zw/Vz844c/cljQWkn4IW9jwxg8a8QtINwcqEcxHxvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qLNvZqfmiMkOWKDV58QDAIIuQOhkDdm1nWL/z4TYz0cAm5CTif+8vfkqEDIxIqELalJx/Dw5oPhGzKtFceK5lxEwv8aOlS8QC+ccdfpuaWrcGZ5vZZbQcSe1iXE6CY0vgPX0UjCkvrJlzpATonMmx3+NR5kpfU3YFdSLwQAe/D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=ATqQ9DFa; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="ATqQ9DFa"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1712590871;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=GM8A5aYN/kicX2lyQVmRLBGXMMwOz3hrxIK8mDrOz3U=;
	b=ATqQ9DFaO/xX0QLqzst3mQNuEVmT/tiwJl1WF/PyJxPxomehWZlRCVZJf7zKJSX2ECV79F
	SoP1xtCv9p5zBz0defHnfKppmidi1rchfCFhaW8fFaladpB5qgMtTmIfaPd4Qh+YGj4rGz
	9qxYj049aRxopDigbFj08bLl0JigaDpErofqH0T11u9Nov2WgdiaBjM1CU1GBkiLofyJEj
	0VRVKnKm046HMeNs+WlxJoG+/pYGYE+80kJAB/PIUU8Xk7/CYci7bKjanGerP6Aw+z/UWI
	1ZpTcX9BNTA6T3x29iD36edzM32aOzQDnCKczyFF9LsphUVaDE8vuYNcXQgCRQ==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH] github: bump Python and Ruby versions
Date: Mon,  8 Apr 2024 17:41:07 +0200
Message-ID: <20240408154107.72419-1-cgoettsche@seltendoof.de>
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

Bump the maximum Python version to 3.12 and the maximum Ruby version to
3.3 in the GitHub CI.

Also bump the setup-python action to v5.

Since Python 3.12 dropped setuptools, install manually.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 .github/workflows/run_tests.yml | 43 +++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/.github/workflows/run_tests.yml b/.github/workflows/run_tests.yml
index 3bd859a3..f8b6f146 100644
--- a/.github/workflows/run_tests.yml
+++ b/.github/workflows/run_tests.yml
@@ -10,36 +10,39 @@ jobs:
       matrix:
         compiler: [gcc, clang]
         python-ruby-version:
-          - {python: '3.11', ruby: '3.1'}
-          - {python: '3.11', ruby: '3.1', other: 'test-flags-override'}
-          - {python: '3.11', ruby: '3.1', other: 'test-debug'}
-          - {python: '3.11', ruby: '3.1', other: 'linker-bfd'}
-          - {python: '3.11', ruby: '3.1', other: 'linker-gold'}
+          - {python: '3.12', ruby: '3.3'}
+          - {python: '3.12', ruby: '3.3', other: 'test-flags-override'}
+          - {python: '3.12', ruby: '3.3', other: 'test-debug'}
+          - {python: '3.12', ruby: '3.3', other: 'linker-bfd'}
+          - {python: '3.12', ruby: '3.3', other: 'linker-gold'}
           # Test several Python versions with the latest Ruby version
-          - {python: '3.10', ruby: '3.1'}
-          - {python: '3.9', ruby: '3.1'}
-          - {python: '3.8', ruby: '3.1'}
-          - {python: '3.7', ruby: '3.1'}
-          - {python: 'pypy3.7', ruby: '3.1'}
+          - {python: '3.11', ruby: '3.3'}
+          - {python: '3.10', ruby: '3.3'}
+          - {python: '3.9', ruby: '3.3'}
+          - {python: '3.8', ruby: '3.3'}
+          - {python: '3.7', ruby: '3.3'}
+          - {python: 'pypy3.7', ruby: '3.3'}
           # Test several Ruby versions with the latest Python version
-          - {python: '3.11', ruby: '3.0'}
-          - {python: '3.11', ruby: '2.7'}
-          - {python: '3.11', ruby: '2.6'}
-          - {python: '3.11', ruby: '2.5'}
+          - {python: '3.12', ruby: '3.2'}
+          - {python: '3.12', ruby: '3.1'}
+          - {python: '3.12', ruby: '3.0'}
+          - {python: '3.12', ruby: '2.7'}
+          - {python: '3.12', ruby: '2.6'}
+          - {python: '3.12', ruby: '2.5'}
         exclude:
           - compiler: clang
-            python-ruby-version: {python: '3.11', ruby: '3.1', other: 'linker-bfd'}
+            python-ruby-version: {python: '3.12', ruby: '3.3', other: 'linker-bfd'}
           - compiler: clang
-            python-ruby-version: {python: '3.11', ruby: '3.1', other: 'linker-gold'}
+            python-ruby-version: {python: '3.12', ruby: '3.3', other: 'linker-gold'}
         include:
           - compiler: gcc
-            python-ruby-version: {python: '3.11', ruby: '3.1', other: 'sanitizers'}
+            python-ruby-version: {python: '3.12', ruby: '3.3', other: 'sanitizers'}
 
     steps:
     - uses: actions/checkout@v4
 
     - name: Set up Python ${{ matrix.python-ruby-version.python }}
-      uses: actions/setup-python@v4
+      uses: actions/setup-python@v5
       with:
         python-version: ${{ matrix.python-ruby-version.python }}
 
@@ -69,6 +72,10 @@ jobs:
 
         pip install flake8
 
+    - name: Install Python setuptools
+      if: matrix.python-ruby-version.python == '3.12'
+      run: pip install setuptools
+
     - name: Install Clang
       if: ${{ matrix.compiler == 'clang' }}
       run: sudo apt-get install -qqy clang
-- 
2.43.0

