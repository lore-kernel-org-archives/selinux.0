Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F303F3921C8
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781123510; cv=none; b=TWCjQqkD5ZYXkeQChgkXNTTsc/RLePI8zGW9RYc1fffSxqYPNrEZUXGdWGnla2Y4AK/kQbzF4f8Q1oUrO5YkLS0erLjW5sDMn+tutpvBFtrkNjEW3KADwdYEp98ufZjLQ5MRba8Tz/qUdDLPUf1FQ0R1OlMlbbkpG6ezu4VJ3tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781123510; c=relaxed/simple;
	bh=+H3RZPpTR55oaz+zGO8d6zqHC/aJuqZizzbvBDDypqU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhKHNY+lsKHXlqbJEjM2t2ucqCKTSDMIij0pT6LmlG3MHbSf6KGz5H3OR1ksNiCV/ZmArwP5hsVJOFwtA/jNDTg9CyTIpyPwfDfwy8exhI9RJD/Qg9Ut3pvvUWkXn4kDI+Zk87fMAZHw/OZlvTnWcFnc95cICYRuyhNa7yfFREk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=htABEeSQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="htABEeSQ"
Received: from CPC-chpeb-8M6PS.redmond.corp.microsoft.com (unknown [40.117.66.19])
	by linux.microsoft.com (Postfix) with ESMTPSA id CD20320B7168
	for <selinux@vger.kernel.org>; Wed, 10 Jun 2026 13:31:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD20320B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781123483;
	bh=vvaAPbGqcX/Z73G/s48bEcXN8rkZ8Rjh9Y9+XfQ31GE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=htABEeSQiZNgayTAY66Xt67T+JhedjM0f+aBsWJ75CkNwTn00kNe3aIXD3Z5Y1XhH
	 tdLRkiAhtiJ1++/LZu/Y9w7qtB5HBrtBMyCBLYUhmB7OBvEHbswKoZXQctNVAeCnOX
	 Kw/nw3wqImaF63wcqc2kH2KmoWQkNB/no1Shsmso=
From: Chris PeBenito <chpebeni@linux.microsoft.com>
To: selinux@vger.kernel.org
Subject: [PATCH 2/2] CI: Add explicit output variable for build-userspace action.
Date: Wed, 10 Jun 2026 20:31:37 +0000
Message-ID: <20260610203137.411393-2-chpebeni@linux.microsoft.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610203137.411393-1-chpebeni@linux.microsoft.com>
References: <20260610203137.411393-1-chpebeni@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Downstream users won't have to rely on DESTDIR being set in the environment.

Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>
---
 .github/actions/build-userspace/action.yml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/.github/actions/build-userspace/action.yml b/.github/actions/build-userspace/action.yml
index f5d21b7c..03f9e0a2 100644
--- a/.github/actions/build-userspace/action.yml
+++ b/.github/actions/build-userspace/action.yml
@@ -16,6 +16,11 @@ inputs:
     required: false
     default: ''
 
+outputs:
+  DESTDIR:
+    description: The destination directory for the build
+    value: ${{ steps.config-env.outputs.DESTDIR }}
+
 runs:
   using: composite
   steps:
@@ -64,12 +69,14 @@ runs:
 
     - name: Configure the environment
       shell: bash
+      id: config-env
       run: |
         echo "::group::Configure the environment"
         DESTDIR=/tmp/destdir
         echo "PYTHON=python" >> $GITHUB_ENV
         echo "RUBY=ruby" >> $GITHUB_ENV
         echo "DESTDIR=$DESTDIR" >> $GITHUB_ENV
+        echo "DESTDIR=$DESTDIR" >> $GITHUB_OUTPUT
 
         CC=${{ inputs.compiler }}
         if [ "${{ inputs.other }}" = "linker-bfd" ] ; then
-- 
2.54.0

