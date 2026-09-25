Received: from server02.seltendoof.de (server02.seltendoof.de [168.119.48.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4523FB7E1
	for <selinux@vger.kernel.org>; Fri, 25 Sep 2026 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.48.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790356741; cv=none; b=cLFjqEsc+LEhVJQnHWSDdABxXZHcuG4XGD2fFcHp0q3pxah6/RFWO7iG9MAxNwl4nLZbxZkqlSR8GuAFQxd+z/XISOs+taY/oCDO3UsY4E/eoIasTP+pqylmUQz1G7DhlEXPsZmbPyHLIibtN4LsBQY0OG3ZArSktnC9n3MIgHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790356741; c=relaxed/simple;
	bh=NzRD5kDrjZT89ogKgofBhUI3zCV0QegKgAgO2WHPWWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hs3zygCPksGFFK5llvgOS3svgo3eu1hnPl5Fnh7gaa4udpidTJbtdB7AGNoOHxRYXALyAc42xXYaYSPkOWyfQvoRz7xKgz9cq/+rCIo35eRxRaEwmLQPhKEpg0ZNx1Zr7O+DpjXiAQ8HJrWsHZioZyzBQExMutnHHP/nCZ8f7N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de; spf=pass smtp.mailfrom=seltendoof.de; dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b=Jzbb5PPS; arc=none smtp.client-ip=168.119.48.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seltendoof.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seltendoof.de header.i=@seltendoof.de header.b="Jzbb5PPS"
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seltendoof.de;
	s=2023072701; t=1790356712;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=48bY2Pq2fuhLvmIoZcqp095WDO4pcwrpn8Bi4ChzNcM=;
	b=Jzbb5PPS+IH58dd855aop3y9zAWjLcxOUixAILmjZ33+L4DUTLnDt7NlXz54/N1B0MCfhv
	mIiH9CwQVgjpbirNQPU/ZUq1vawGWE0YCtfIpWY/+umtM2OJAOreGLbqHZW5vy3e6RsCg7
	62xgdgEP8sE1DNi5j6SjySE1U52UtFqEI+c76rsEYNEZmWwTWTwlkrHiAfY+8/vc5KT5HJ
	5VAOW5UeNlV+GrdQ+CGW7/GWBUzVFE6hieyZ5Qxf4wSgoBcoZ2KYPwIGGu9SoLwrJoURDo
	pCNX5TfR6eANyizQ+/Q11sB44zGy5GxeYXZO9mv1wgtH65EVX2t6PFdVoQethw==
To: selinux@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
Subject: [PATCH 10/21] tests: port scripts to sh and please shellcheck
Date: Fri, 25 Sep 2026 19:17:42 +0200
Message-ID: <20260925171755.2029271-9-cgoettsche@seltendoof.de>
In-Reply-To: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
References: <20260925171755.2029271-1-cgoettsche@seltendoof.de>
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
 tests/checkreqprot/default_value.sh |  2 +-
 tests/inet_socket/test              |  2 +-
 tests/kvercmp                       | 16 +++++++++-------
 tests/os_detect                     | 10 ++++++----
 tests/overlay/cleanup-overlay       |  6 +++---
 tests/pol_detect                    | 12 +++++++-----
 6 files changed, 27 insertions(+), 21 deletions(-)

diff --git a/tests/checkreqprot/default_value.sh b/tests/checkreqprot/default_value.sh
index 2e48eb1..236f3ed 100755
--- a/tests/checkreqprot/default_value.sh
+++ b/tests/checkreqprot/default_value.sh
@@ -5,7 +5,7 @@ DISTRO=$($mydir/../os_detect)
 kvercmp=$mydir/../kvercmp
 
 if [ "$($kvercmp $(uname -r) 4.4)" -ge 0 ] ||
-	[ "$DISTRO" = "RHEL7" -a "$($kvercmp $(uname -r) 3.10.0-327)" -ge 0 ]; then
+	{ [ "$DISTRO" = "RHEL7" ] && [ "$($kvercmp $(uname -r) 3.10.0-327)" -ge 0 ]; }; then
 	grep -q 0 /sys/fs/selinux/checkreqprot 2> /dev/null
 	exit $?
 fi
diff --git a/tests/inet_socket/test b/tests/inet_socket/test
index 9f846bd..7d4989a 100755
--- a/tests/inet_socket/test
+++ b/tests/inet_socket/test
@@ -26,7 +26,7 @@ BEGIN {
 
     $test_ipsec = 0;
     if (    system("ip xfrm policy help 2>&1 | grep -q ctx") eq 0
-        and system("ip xfrm policy list &>/dev/null") eq 0 )
+        and system("ip xfrm policy list >/dev/null 2>&1") eq 0 )
     {
         $test_count += 4;
         $test_ipsec = 1;
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
diff --git a/tests/overlay/cleanup-overlay b/tests/overlay/cleanup-overlay
index 8b5836d..61c88d8 100755
--- a/tests/overlay/cleanup-overlay
+++ b/tests/overlay/cleanup-overlay
@@ -1,10 +1,10 @@
-#!/bin/bash
+#!/bin/sh
 
 BASEDIR=$1
 
 cleanup (){
-  umount $BASEDIR/container1/merged 2> /dev/null
-  rm -rf $BASEDIR/container1/ $BASEDIR/lower/
+  umount "$BASEDIR/container1/merged" 2> /dev/null
+  rm -rf "$BASEDIR/container1/" "$BASEDIR/lower/"
 }
 
 #Main script
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
2.55.0

