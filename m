Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E96D27A462
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679910; cv=none; b=SvNzyxsl++ISDRcG9abSM/9Pd7Nq6zAf5TkxeqCLDTWc5EwL8dcQ8zi2PtFG/LJYQpRb9Qf7JcWMJoATtKuCvOC8MeNeTPuTRnausUQZk6/Tzqq5DWbMllZHpeWQ7N3DPd4ko7kvB33VPnZIMuQkcIiuYCNmyEYWTl5meeHnWfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679910; c=relaxed/simple;
	bh=qXvO3581cjgviCMcU/k3hOdPIzDObe10aQzK4rQEjoM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vh9vcrQQfiUxkuiBmCnGVG8QTl8T2RP93YQD6hifnX4Xgy/ba9iasLIW5GNsjvM21bLCxVD3H/neRs5QJlRPygP1dFmPg/MsA4Uvn4Csxh7xgXGkGKWad65hd1KBv0zDEdrtVQZ8Ia2WXs6zsxWY4hnWosK/sS/HTkZwYFpA41o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rqLs17eo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rqLs17eo"
Received: from CPC-chpeb-8M6PS.redmond.corp.microsoft.com (unknown [40.117.66.19])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9562B20B716C
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 10:18:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9562B20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780679893;
	bh=/mnMlut3wry0hipJl6l2AJV9RYtzjzh/0TGldwynmrM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=rqLs17eosCSbb0Scmey37aOkkq8fGw/7mmVpmvDbzyEwqYZpNddA2s3IcSCqxNahD
	 NWW0B+cpMc4sA/8t3Q3nwWi6cKn0A7zl4e/Orele/GJK9fjlYloR8EBJXIfNkl4nxg
	 NMX3NFZvpwyn34Xj7OZrKnRYS8g7LojtsvSdSUCo=
From: Chris PeBenito <chpebeni@linux.microsoft.com>
To: selinux@vger.kernel.org
Subject: [PATCH 3/3] ci: Add additional output grouping in build-userspace action.
Date: Fri,  5 Jun 2026 17:18:25 +0000
Message-ID: <20260605171825.362853-3-chpebeni@linux.microsoft.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605171825.362853-1-chpebeni@linux.microsoft.com>
References: <20260605171825.362853-1-chpebeni@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The action is run as a composite, so the headers for each step are lost.

Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>
---
 .github/actions/build-userspace/action.yml | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/.github/actions/build-userspace/action.yml b/.github/actions/build-userspace/action.yml
index b2b0ee6a..bad6e33d 100644
--- a/.github/actions/build-userspace/action.yml
+++ b/.github/actions/build-userspace/action.yml
@@ -33,6 +33,7 @@ runs:
     - name: Install dependencies
       shell: bash
       run: |
+        echo "::group::Install dependencies"
         sudo apt-get update -q
         sudo apt-get install -qy --no-install-recommends \
             bison \
@@ -51,15 +52,20 @@ runs:
             xmlto
 
         pip install flake8 setuptools build wheel
+        echo "::endgroup::"
 
     - name: Install Clang
       if: ${{ inputs.compiler == 'clang' }}
       shell: bash
-      run: sudo apt-get install -qqy clang
+      run: |
+        echo "::group::Install Clang"
+        sudo apt-get install -qqy clang
+        echo "::endgroup::"
 
     - name: Configure the environment
       shell: bash
       run: |
+        echo "::group::Configure the environment"
         DESTDIR=/tmp/destdir
         echo "PYTHON=python" >> $GITHUB_ENV
         echo "RUBY=ruby" >> $GITHUB_ENV
@@ -113,6 +119,7 @@ runs:
 
         # Display the final environment file, for debugging purpose
         cat $GITHUB_ENV
+        echo "::endgroup::"
 
     - name: Display versions
       shell: bash
-- 
2.54.0

