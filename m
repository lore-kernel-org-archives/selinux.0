Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7701E3DD3
	for <selinux@vger.kernel.org>; Tue,  7 Jan 2025 13:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257975; cv=none; b=OIJUaHzZgJXX9ijy6mkvlwiW73dF/pdkpdIl1ev/FheGZKxf9uhFyo5BQdbivpRvKrNZr5BGgt9p7uOu+fYrwpxY+q2Docy5GpE83u/OHnbobEOf5PXMTQhqBle7S4q7vqwpe/WoY0zMs3qN/O0spuqoDNL6zrA9RV9Gco1uQNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257975; c=relaxed/simple;
	bh=HG8JaOqn1Y5NeQADCrYsfGly98yeGV+qD9no6Ui1mvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mWDKsu0gtID9uK/Xohumx/L1yH2qLhB7XpoDjcoQ6CQfNUcz6eozhSbnGMIN9bQyUx8GEsJUduwan7/Ru8PqRhKSB85pbyxqXtW3udMucUl+Mp8a5G8XhyAENZtLc0nKV+eWv76TrL60E4JQAlKYzNMCokaEyZka2qlfYqxFefg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=pNA3MlyJ; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="pNA3MlyJ"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1736257573;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rC7+xGz0QY9RpDpUquh5uboSes6iy4vOltMv86om/e8=;
	b=pNA3MlyJNhQzgFUA82PDOC3fisZrxMSx+AzbjUAnxSCemafxuL0CfD2rvS/MzpzYLbkfrT
	j3Hq8GeRh7pTfy6afMBv6VxYWuDfo4QZD9nRoo7c1RMyL8NUsC8ngykQN9ZIq+NEd7YQnI
	ADWCutgR49Ow5bHBkaR5PJqmtiPV2AbXc7bURQF+yXAYEnMLi0cfsowBOwEmLVMKjVX0FY
	IjJgXJUstaS2rLzlJCDGwQPNYRNymtT1w0lZeAEnh50uGf4wS6dg/fXD64dqNTN3wazSa4
	1UsJW+Otwy9GoDCL0HFZH8cv6wP2PCtoi7GM2cs+FNt0+9tt8P283/b4XZochw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [RFC PATCH v2 04/17] tests: port scripts to sh and please shellcheck
Date: Tue,  7 Jan 2025 14:45:52 +0100
Message-ID: <20250107134606.37260-4-cgoettsche@seltendoof.de>
In-Reply-To: <20250107134606.37260-1-cgoettsche@seltendoof.de>
References: <20250107134606.37260-1-cgoettsche@seltendoof.de>
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
2.47.1

