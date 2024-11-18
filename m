Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB521B0F0B
	for <selinux@vger.kernel.org>; Mon, 18 Nov 2024 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731942193; cv=none; b=L0hM36C0U6xWVH+4bTZpPhxLJxe7l1MLOduSwsSEf4zgw4kXbjF0KoIyikUsBQinfHZiFZyr0UBmVFqUVbz959QkuXbZjZP8NlSlN2CjFYPCZ42M1lC5p++S5V1rdiYuzXPzYu9OClZuoSU7VGywBoDod+upD0sz8Xh+chHd20Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731942193; c=relaxed/simple;
	bh=faZRreWquVe700OZGYMSo0dSlhb7Uz0PJ11Md7W1r0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snHTWHgO8TKATOy0IsaoS4/c7d/Vuk9PR17MAcOAbfg0n8Fhu7BVnhsadkSxTLYbVyJs5XjWLZSFpe5n84UXU4fONpHL23CFDUPGoeyYRuyp046ixd2D5AGiGGD7lZZFubQJXl7zXa5Zqd8WpFgAB5h4raxa0BRcYxuuoIBgm38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=RWxscOZK; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="RWxscOZK"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1731942182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IXSqTavrILkr8R4UvsKit71r/AdRNMGLzyGo5EHv1dQ=;
	b=RWxscOZKeUc1RMFpFaAqMTa+oENw4o8ialrC2UG+m5fYlQIN9+2mcyQzzerFvKXrrbAoKk
	KCBrC64H9ZdKHKynn2jgY5C2ny+M1hYRH5j6FwWyxEWIGfZJaf9jqXbYdcfU70S3en5bCL
	hs9zMd9Ade7dK7kFurYKNmh311q2ZFIBr95w3YYZMATx1/j2eXClCVoJOWPsskLw7wrqa7
	W7Ny7op3jUGPLk9feN+31zHNDSzTmrXzw80rzWJN/KGCPW/FEfpOB/mCnv/TYJV+Rg+pS8
	F6hkwuVFVkK1BYfamF+onrF96Fm+n98/GK8dYF3+M3+Ek78XF+HHXSht0cC2Bg==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 04/17] tests: port scripts to sh and please shellcheck
Date: Mon, 18 Nov 2024 16:02:26 +0100
Message-ID: <20241118150256.135432-5-cgoettsche@seltendoof.de>
In-Reply-To: <20241118150256.135432-1-cgoettsche@seltendoof.de>
References: <20241118150256.135432-1-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

Improve portability and avoid actual issues being hidden.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
 tests/kvercmp    | 16 +++++++++-------
 tests/os_detect  | 10 ++++++----
 tests/pol_detect | 12 +++++++-----
 3 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/tests/kvercmp b/tests/kvercmp
index 3742f16..4b1e345 100755
--- a/tests/kvercmp
+++ b/tests/kvercmp
@@ -1,15 +1,17 @@
-#!/bin/bash
+#!/bin/sh
 
-function kvercmp()
+set -eu
+
+kvercmp()
 {
-	ver1=`echo $1 | sed 's/-/./'`
-	ver2=`echo $2 | sed 's/-/./'`
+	ver1=$(echo "$1" | sed 's/-/./')
+	ver2=$(echo "$2" | sed 's/-/./')
 
 	ret=0
 	i=1
-	while [ 1 ]; do
-		digit1=`echo $ver1 | cut -d . -f $i`
-		digit2=`echo $ver2 | cut -d . -f $i`
+	while true; do
+		digit1=$(echo "$ver1" | cut -d . -f $i)
+		digit2=$(echo "$ver2" | cut -d . -f $i)
 
 		if [ -z "$digit1" ]; then
 			if [ -z "$digit2" ]; then
diff --git a/tests/os_detect b/tests/os_detect
index cddcb85..6b723f6 100755
--- a/tests/os_detect
+++ b/tests/os_detect
@@ -1,8 +1,10 @@
-#!/bin/bash
+#!/bin/sh
 
-if [[ -r /etc/redhat-release ]]; then
-	ver=$(cat /etc/redhat-release | sed -ne '/^Red Hat Enterprise Linux/p')
-	if [[ -n $ver ]]; then
+set -eu
+
+if [ -r /etc/redhat-release ]; then
+	ver=$(sed -ne '/^Red Hat Enterprise Linux/p' /etc/redhat-release)
+	if [ -n "$ver" ]; then
 		echo "$ver" | \
 			sed -e 's/Red Hat Enterprise Linux[ \ta-zA-Z]*\([0-9]\+\).*/RHEL\1/'
 	fi
diff --git a/tests/pol_detect b/tests/pol_detect
index ba25b94..8c07997 100755
--- a/tests/pol_detect
+++ b/tests/pol_detect
@@ -1,4 +1,6 @@
-#!/bin/bash
+#!/bin/sh
+
+set -eu
 
 if [ $# -ne 1 ]; then
 	echo "Usage $0 <selinuxfs directory>"
@@ -8,10 +10,10 @@ fi
 # This is heuristic but seems unlikely to be wrong,
 # the kernel initial sid should always be SystemHigh
 # and SystemHigh is normally s15
-level=$(cat $1/initial_contexts/kernel | tr '\0' '\n' | cut -d: -f4)
+level=$(cat "$1/initial_contexts/kernel" | tr '\0' '\n' | cut -d: -f4)
 
-if [ -z $level ]; then echo "NON-MLS"
-elif [ $level = 's0' ]; then echo "MCS"
-elif [ $level = 's15' ]; then echo "MLS"
+if [ -z "$level" ]; then echo "NON-MLS"
+elif [ "$level" = 's0' ]; then echo "MCS"
+elif [ "$level" = 's15' ]; then echo "MLS"
 else echo "UNKNOWN"
 fi
-- 
2.45.2

