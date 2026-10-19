Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F16D603190
	for <selinux@vger.kernel.org>; Mon, 19 Oct 2026 14:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418587; cv=none; b=oeOT1LeYNPChPe7verbhKG33aGN7rVs8xjmv9/UnrmNc/94b14uAO+mvrqjUCgojNOhptWKam8/tAfHSIcd9J58QqMyNJNic9RTpbVu7qp64Zg7m74z2lIqUoEAqK8DKF20sxcVM2ta6hSBc9zQFw0YmPJGb+PBaaeeHrB0rtPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418587; c=relaxed/simple;
	bh=GXkd2fB4di3QOBMWuYTo7plZjhCelo0UtUwjO4SrwCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e6nqpzQLjzzVCkq1/z+0VeMtJGjU01zWy0iwQlivewbhLzja+qsNfZCc0CX42FQ+KmKQMPB2x/3iKomkrVB1S8j20zAZAy74rg1k1o1TyNfNcdrj7SeISN9wUlO63Zzeh2joYCiY0vg1Lroh4+PHHicMOXYZp4hltt81SWInsoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l311+klj; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l311+klj"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f2ed2541aso166507185a.0
        for <selinux@vger.kernel.org>; Mon, 19 Oct 2026 07:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792418584; x=1793023384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A+5fAWqulVdb2s15orai+BOphVJNAPThSAzYaa/RZ9w=;
        b=l311+kljC6be0DxgEdOk52iJYpo6gkIuS/C//ug+q65Y9bK638EfugaVH8S7ssTWa0
         lOscQ1PXVUsHTjb2859Jei3aAnTLMNwNU8Pu6rKv7dSDUR3ymEFye88V9/Euj0QVVRm5
         3+evBWwFSQyCC6InCj6zIodVhhnD8vMW8/0cTLox6eqjrFnQtwvZaMGZ36MyhchksVVW
         0kdzmFreyu7+5x6b7SzMXR7A1J3bd0QNZiwETo9eT/LgTuEoLmnNDnnJw+I+df0Qqv1m
         j2gz57kLZ2DiBNOEdPld1SgV2FLxz7nQP6EbsLEWyOX9KmD/hqvEFG8qvpuejB08SKEs
         XblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792418584; x=1793023384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A+5fAWqulVdb2s15orai+BOphVJNAPThSAzYaa/RZ9w=;
        b=dnMif7RiM6xDW75GHCKDzP1TbDuzkGmI2k5Y648tatETGtUSJshWZA2XEEJlSMnTMx
         65TMjaUUWiMpHpp1olxUa8e5TmpVTPlxs2jHmBrxgwrDjszguh9NyTdkCugeI4+dm8Xn
         1T8Dl+zxII9nL4R8r9z+BzEZS0Yh0EbQ/y28niFrNv/gPNUzhzYQ6G/lj2GEQYmSrl8t
         GWhrj33CFTeZ57o5pZ+9Rv449QFnfqo/FbN3D3qub79b3WyuKom/wQteVeXiaB1YrCNZ
         hprPi3q2WtNeQynF4kvRHUFuk/lDOtYk8qquQ8UT8vzVKQJI7js3MiI/qoq3hBbNj2OY
         mSUQ==
X-Gm-Message-State: AFq9FYK4SUZwcijfVXgx4HMwSD46NwelHeQOY34h5q7ni5sM3dy9dSy0
	BqBQ4zRnJXQfxly87+TjQjC6/My8coOj2h99ZdSIJnMAavc8GrfO2hLJ1ifNVA7I
X-Gm-Gg: AYBFou0yBMKtaxq4NL7TU7ehHF1u8DcFPm2BqXIIK6b51jyaScGaJo3HpWalhN6NpPT
	jBFWJ/UJaZpIb9z4lbE/81UsNirLTVJyCUH3KJXyBn+93pCE8vuAKppE4oVRnTB7aaXq9LAAcca
	q4Z47hi4rbXHCPkexBDlghZMthMaFWmPkPbXtoAe1/WKXx0CKpZrg590RAHXELTPjBKPWrl12bW
	pnYW/gtUh3OBW1lTcCLa6SY/x0Va2hmTIpsyPjVPqSUHmSi+wK0dXfX9pFwb+N4RSbNvcUtTw3z
	EgogTkgzX3/+q9sTFPPIyIyJFgy3jgldluUE7xK7nNHmar2EJk8WZ1e0AOcTHpbWoe1ygH4wJ8D
	ANeBplyYYUBzpEhFjcIymJSAG+w2+u81c14mmLaHzYADUQuhgsUUBVDhvLW3a3Tk8c/hBLOkOqg
	5hf+FhS5iVWLqdxLe8jJXLxLdRZDyz7XnWjrBE2J+N5ZVN0Sm0bOf0Hy32bvT0tVJ/CuMR6jyQp
	tBUWUgieklh/iiz7MIGxgxEJBP2a5QNR4vQhUQ7NgpFwWLET7vBoNGLL1VXa/7bYrq7S/5bWDI=
X-Received: by 2002:a05:620a:2584:b0:93b:d7a4:9d4b with SMTP id af79cd13be357-93f29d4d8ddmr1267959285a.30.1792418583542;
        Mon, 19 Oct 2026 07:03:03 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f332739d7sm577938585a.28.2026.10.19.07.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:03:03 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	jwcart2@gmail.com,
	Pragati Hatkamkar <phatkamk@redhat.com>
Subject: [PATCH] policycoreutils: omit excluded mounts from the fixfiles relabel list
Date: Mon, 19 Oct 2026 10:02:49 -0400
Message-ID: <20261019140249.30088-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pragati Hatkamkar <phatkamk@redhat.com>

fixfiles logs directories from fixfiles_exclude_dirs and passes them
to setfiles with -e, but the Relabeling line and the per-mount progress
output still come from every read-write seclabel mount. setfiles prints
a 100% line for each of those arguments even when -e makes the walk
return immediately.

restore, check, verify, and relabel all use this list. Leave excluded
mounts, and mounts underneath them, out of the list that is printed and
passed to setfiles. Keep passing -e so those paths are still skipped
when reached from a parent mount.

Signed-off-by: Pragati Hatkamkar <phatkamk@redhat.com>
---
 policycoreutils/scripts/fixfiles | 37 +++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 45f2d5ce..e266da77 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -141,6 +141,32 @@ for i in ${EXCLUDEDIRS//-e / }; do
 done
 }
 
+#
+# Drop mount points that are excluded, or that sit under an excluded
+# directory, from the list printed and passed to setfiles.  -e is still
+# passed so the same paths are skipped if reached from a parent mount.
+#
+filesystems_to_relabel() {
+    local m e skip result
+    result=
+    for m in ${FILESYSTEMSRW}; do
+        skip=
+        for e in ${EXCLUDEDIRS//-e /}; do
+            e="${e%/}"
+            [ -z "$e" ] && e=/
+            case "$m" in
+            "$e"|"$e"/*)
+                skip=1
+                break
+                ;;
+            esac
+        done
+        [ -n "$skip" ] && continue
+        result="${result} ${m}"
+    done
+    echo "${result# }"
+}
+
 #
 # Find files newer then the passed in date and fix the label
 #
@@ -259,14 +285,18 @@ case "$RESTORE_MODE" in
     *)
 	if [ -n "${FILESYSTEMSRW}" ]; then
 	    LogReadOnly
-	    echo "${OPTION}ing `echo ${FILESYSTEMSRW}`"
+	    FILESYSTEMS_TO_RELABEL="`filesystems_to_relabel`"
+            if [ -z "${FILESYSTEMS_TO_RELABEL}" ]; then
+               echo >&2 "fixfiles: No suitable file systems found"
+            else
+            echo "${OPTION}ing `echo ${FILESYSTEMS_TO_RELABEL}`"
 
 	    if [ -z "$BIND_MOUNT_FILESYSTEMS" ]; then
-	        ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${DIGESTFLAG} $* -q ${THREADS} ${FC} ${FILESYSTEMSRW}
+	        ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${DIGESTFLAG} $* -q ${THREADS} ${FC} ${FILESYSTEMS_TO_RELABEL}
 	    else
 	        # we bind mount so we can fix the labels of files that have already been
 	        # mounted over
-	        for m in `echo $FILESYSTEMSRW`; do
+	        for m in `echo $FILESYSTEMS_TO_RELABEL`; do
 	            TMP_MOUNT="$(mktemp -p /run -d fixfiles.XXXXXXXXXX)"
 	            export SETFILES VERBOSE EXCLUDEDIRS FORCEFLAG DIGESTFLAG THREADS FC TMP_MOUNT m
 	            if type unshare &> /dev/null; then
@@ -278,6 +308,7 @@ case "$RESTORE_MODE" in
 	            fi
 	        done;
 	    fi
+	    fi
 	else
 	    echo >&2 "fixfiles: No suitable file systems found"
 	fi
-- 
2.56.0

