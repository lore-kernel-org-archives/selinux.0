Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD77416CFC
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 17:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780679909; cv=none; b=F+wkypV23OjbZn5N/Te7FAExLCmk9KvYRrQEKAwgKzIdwfalcpA6DsaA8Go+90g1MS843r5et5ZM6NsNFwLxNFEQSxQ/9htP37TVrSWVOIdOgNYu4nwugn9Q4ykHrPXHPAKuVTasva8zuTWeTfOKB3CrK2V2hWbNPqq+tvyFCyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780679909; c=relaxed/simple;
	bh=cAKEol7eZIwcQSxHyRy1alETlW2/D72ImuZZhyGUxys=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVOB7fe6YhSKJcSuZPH27TT7frWpGTqXnjD+Cgy44YB4Wfbx5lFBLNs7stZNs9WfYnAfk3SkBxCr855Bb1ed237e0Iym2VYOdXQkmvMhQso5oOiXI4sX3F2LD/aqVDH1bqR7rdQzhthQzDKWTWD2BhkXLVWJanmjO7w9HbrexWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TsoFk85J; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TsoFk85J"
Received: from CPC-chpeb-8M6PS.redmond.corp.microsoft.com (unknown [40.117.66.19])
	by linux.microsoft.com (Postfix) with ESMTPSA id D52FE20B716B
	for <selinux@vger.kernel.org>; Fri,  5 Jun 2026 10:18:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D52FE20B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780679893;
	bh=M09K6wQZ3f7WhnCegVHkSP5kKkCPY6NbPsour4Mf458=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TsoFk85J+W8xF8OrDPhJ7TzLz4qsU+/31lT8cTJXJOJF+A0xsG+sAXk8mtomcLoIS
	 4+N7mz4muOspz7glI23pcDed18XyVHN0J3VPUy8VoqAqmljqfOPb1EVpYrq/0HQV3G
	 H0rVwxNAREAAeZNHH4dl6hmJdoI/N6RDI/nUvxTo=
From: Chris PeBenito <chpebeni@linux.microsoft.com>
To: selinux@vger.kernel.org
Subject: [PATCH 2/3] ci: Explicitly set bash shell in build-userspace action
Date: Fri,  5 Jun 2026 17:18:24 +0000
Message-ID: <20260605171825.362853-2-chpebeni@linux.microsoft.com>
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

Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>
---
 .github/actions/build-userspace/action.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.github/actions/build-userspace/action.yml b/.github/actions/build-userspace/action.yml
index 2e4f513a..b2b0ee6a 100644
--- a/.github/actions/build-userspace/action.yml
+++ b/.github/actions/build-userspace/action.yml
@@ -31,6 +31,7 @@ runs:
         bundler-cache: true
 
     - name: Install dependencies
+      shell: bash
       run: |
         sudo apt-get update -q
         sudo apt-get install -qy --no-install-recommends \
@@ -53,9 +54,11 @@ runs:
 
     - name: Install Clang
       if: ${{ inputs.compiler == 'clang' }}
+      shell: bash
       run: sudo apt-get install -qqy clang
 
     - name: Configure the environment
+      shell: bash
       run: |
         DESTDIR=/tmp/destdir
         echo "PYTHON=python" >> $GITHUB_ENV
@@ -112,6 +115,7 @@ runs:
         cat $GITHUB_ENV
 
     - name: Display versions
+      shell: bash
       run: |
         echo "::group::Compiler ($CC):"
         $CC --version
@@ -124,6 +128,7 @@ runs:
         echo "::endgroup::"
 
     - name: Build SELinux userspace
+      shell: bash
       run: |
         echo "::group::make install"
         eval make -j$(nproc) install $EXPLICIT_MAKE_VARS -k
-- 
2.54.0

