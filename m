Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574036EAB0
	for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750739; cv=none; b=tZBNkr+Iyg5gOQ++BGqDXfLlwrW3G5hDQ/FA5LBjG/3VflGHbi0Uqgmyotnf/+c3PIFFWBh+QOxKKhNgWHEwHTg50joVqTKpZko9VLsE3qeJbRxAA2W7PbGUzKBWbhsWwOJ3xwYbb+0AjUrMJ+7oTTAwSm62N42FbJRH0Wq1mAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750739; c=relaxed/simple;
	bh=oL0/fNzQuT/hCitRtUWIBHEKDxL81aKilHM4GiTT+ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MH6eqLFyZ3Kpyd/GW2OlBncn3DH0nUsnHFe8dvOGln+H1XOXR5+3mrRY9gm30pkctcjh15Vl3R38ZXv/jBkp2vDBZd6ZrUvXyc5a2bvjHdOkfN231lzQ3Dr3SxzWBh+qCeWghP7mNcgelv5023c4OYbRUp0Gte0easKF4pSiGPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ltv4xctm; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ltv4xctm"
Received: by mail-qk2-f43.google.com with SMTP id d75a77b69052e-530280b8234so4837421cf.0
        for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 09:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789750730; x=1790355530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1s5GIIvO3rzWCeLt2qF8Ft6q+IryNRvD39+Oh/dVgYU=;
        b=Ltv4xctmm7mfEUQbYyzCAVGWdfo+AexTaCig9VmuU7G4BIzLkmCsLz0Rl8vJHYeHPY
         xc7bmc/qAjGIspwvFhuCFCnldFBj2Bt7OAcoqTWeU37kpGHLrpnkvsOxaq2ACESsTWrE
         NJxnvXiYFAj6lVRaeZ1YPUbRMdiWSrmkz3tFC4qjj825A9WixF4mYiRD2wLcNY0vFDM5
         Op+Qk13dyQ2FL097x0QEfm+dV15xZN/iHOJv7t4IYeecJGhVB+secX8jJ8mFI4c7ujUt
         xSZkiJpenp0drIPdOsQ3zT76hdjnNKgE2Ma+eWpVgU6KaoWySE/8uQJg22Jq+TXUkjzn
         ZMtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789750730; x=1790355530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1s5GIIvO3rzWCeLt2qF8Ft6q+IryNRvD39+Oh/dVgYU=;
        b=UMO+TakPgC7o8p1SdlglIQeTrs/WpcKaR1o7GPUB7mpzxMGAP8XMyjxn8B8/zZC5Cr
         wPwn7ydooSoMHEMliM/6U0Q4EytzWVirt5P2pEV75FBpNAdbbElE5CZgGnS+z/SF66At
         EJcG5mD4xWXBCnPnCmArQ4WydWOZZ2tA9FVRnn4fsY8wMFG5QKaZo8QxWPwgKjXz3V86
         zccBEIZeYHUWWyICEWtmvyhOrgDuUgfK0pdHfHJFeLnpMZBZ/FNX3Ty/Linznkb7yE5F
         IWiVtPPIZ5cutKF+0RJch8rM+r2zkBx7OZRiqNunfZMYEem98I382wHcz/rPY4BaNai5
         LZdA==
X-Gm-Message-State: AFuF++mnFYT0m6unz3Y8K3LRVfOjSMwERaD4xsRZ5UXkPAJXLVQst15Q
	lONybaiVZqZ6pRmSyJ/gLQ5Lx1VjUjuqXGqqlr8fRDnXLIAG1Y2GTDNtaJ+hPg==
X-Gm-Gg: AYBFou04TpR4JuBAA1aaF3Cc6VFBHkkDuVE/1zDOqEQWHB1Lu9Dni84rDjB4fe/fIgC
	y1dOlLenAj/6r9E1GZLqtxf1kZLSlkEJv/2GFeIuKs+C5d/JslqCJE6iWSAR60jIC4VtEnaWSAP
	dZyJoLKY1qhUF/XnkG+wXHzrGTwZ79DfWMurpa6GYrfOasgQE2mYtSR2DAzqBNJ7qYOyoxl8l1h
	Ym+6WCsWtMWANZZ0ifetNbhI9yybPzTMFCT5GGOtPO2MCoD+MAboWPi/ScuQm2fF/vetO+ppVmn
	WteIPUanhLEqP7mDhfjnux4tUeAp+n3+8ExBo3h1tS+MlmpCxqv+bM1ZObs4T79lSxCk/8iNeIX
	6iVEGJ0u8PxEQo/bFxq8rvfQwuTj3WQkCyQwFigVGBVt5xCgA4Ft/Op98c1uyH24BIJ2B5vwU4D
	WF9q/EnASl5fetQIrx56ofBq8iub74mlDPD9EnR0rMzGhoCCPK2Uor38VaeKz+CJhxGmurBAgCC
	yJnVndk2M0ccGhkIfrohRES/tqam9Qf8yfHx9ETu4ClLzNtuQMTTNGbF0m+e4fin1h8MdBRagAg
X-Received: by 2002:ac8:58c6:0:b0:532:9b4a:5936 with SMTP id d75a77b69052e-5329e7932d0mr50589521cf.9.1789750730489;
        Fri, 18 Sep 2026 09:58:50 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532ae5ee8dcsm1424901cf.9.2026.09.18.09.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 09:58:50 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH] policycoreutils/scripts/fixfiles: pass -I/-D through to setfiles/restorecon
Date: Fri, 18 Sep 2026 12:58:34 -0400
Message-ID: <20260918165834.30571-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: selinux@vger.kernel.org
List-Id: <selinux.vger.kernel.org>
List-Subscribe: <mailto:selinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:selinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

setfiles/restorecon -D enables per-directory security.sehash digest
tracking (skip a subtree whose stored digest matches the current
file_contexts) and -I forces the walk anyway while refreshing the
digests. As noted by issue #44, fixfiles has no way to reach either.

Add -I and -D to fixfiles and pass whichever is set as ${DIGESTFLAGS}
to every setfiles/restorecon invocation, export it into the unshare -m
subshell used with -M, and record it in /.autorelabel for onboot. -I
wins over -D (setfiles -I already implies -D).

Fixes: https://github.com/SELinuxProject/selinux/issues/44
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 policycoreutils/scripts/fixfiles   | 36 ++++++++++++++++++------------
 policycoreutils/scripts/fixfiles.8 | 28 ++++++++++++++++++-----
 2 files changed, 44 insertions(+), 20 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 493c86f9..6e93d2ba 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -92,6 +92,7 @@ fullFlag=0
 BOOTTIME=""
 VERBOSE="-p"
 FORCEFLAG=""
+DIGESTFLAG=""
 THREADS=""
 RPMFILES=""
 PREFC=""
@@ -136,7 +137,7 @@ newer() {
     shift
     LogReadOnly
     for m in `echo $FILESYSTEMSRW`; do
-	find $m -mount -newermt $DATE -print0 2>/dev/null | ${RESTORECON} ${FORCEFLAG} ${VERBOSE} ${THREADS} $* -i -0 -f -
+	find $m -mount -newermt $DATE -print0 2>/dev/null | ${RESTORECON} ${FORCEFLAG} ${DIGESTFLAG} ${VERBOSE} ${THREADS} $* -i -0 -f -
     done;
 }
 
@@ -180,7 +181,7 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
 		  esac;
 	       fi;
 	    done |
-	${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $* -i -R -f -;
+	${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${DIGESTFLAG} ${THREADS} $* -i -R -f -;
 	rm -f ${TEMPFILE} ${PREFCTEMPFILE}
 fi
 }
@@ -203,7 +204,7 @@ fix_labels_on_mountpoint() {
 	test -z ${TMP_MOUNT+x} && echo "Unable to find temporary directory!" && exit 1
 	mkdir -p "${TMP_MOUNT}${m}" || exit 1
 	mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
-	${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $* -q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
+	${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${DIGESTFLAG} ${THREADS} $* -q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
 	umount "${TMP_MOUNT}${m}" || exit 1
 	rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
 }
@@ -237,11 +238,11 @@ LogExcluded
 case "$RESTORE_MODE" in
     RPMFILES)
 	for i in `echo "$RPMFILES" | sed 's/,/ /g'`; do
-	    rpmlist $i | ${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $* -i -R -f -
+	    rpmlist $i | ${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${DIGESTFLAG} ${THREADS} $* -i -R -f -
 	done
     ;;
     FILEPATH)
-	${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $* -R -- "$FILEPATH"
+	${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${DIGESTFLAG} ${THREADS} $* -R -- "$FILEPATH"
     ;;
     *)
 	if [ -n "${FILESYSTEMSRW}" ]; then
@@ -249,13 +250,13 @@ case "$RESTORE_MODE" in
 	    echo "${OPTION}ing `echo ${FILESYSTEMSRW}`"
 
 	    if [ -z "$BIND_MOUNT_FILESYSTEMS" ]; then
-	        ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} $* -q ${THREADS} ${FC} ${FILESYSTEMSRW}
+	        ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${DIGESTFLAG} $* -q ${THREADS} ${FC} ${FILESYSTEMSRW}
 	    else
 	        # we bind mount so we can fix the labels of files that have already been
 	        # mounted over
 	        for m in `echo $FILESYSTEMSRW`; do
 	            TMP_MOUNT="$(mktemp -p /run -d fixfiles.XXXXXXXXXX)"
-	            export SETFILES VERBOSE EXCLUDEDIRS FORCEFLAG THREADS FC TMP_MOUNT m
+	            export SETFILES VERBOSE EXCLUDEDIRS FORCEFLAG DIGESTFLAG THREADS FC TMP_MOUNT m
 	            if type unshare &> /dev/null; then
 	                unshare -m bash -c "fix_labels_on_mountpoint $*" || exit $?
 	            else
@@ -323,6 +324,7 @@ case "$1" in
 	fi
 	> /.autorelabel || exit $?
 	[ -z "$FORCEFLAG" ] || echo -n "$FORCEFLAG " >> /.autorelabel
+	[ -z "$DIGESTFLAG" ] || echo -n "$DIGESTFLAG " >> /.autorelabel
 	[ -z "$BOOTTIME" ] || echo -n "-N $BOOTTIME " >> /.autorelabel
 	[ -z "$BIND_MOUNT_FILESYSTEMS" ] || echo -n "-M " >> /.autorelabel
 	[ -z "$THREADS" ] || echo -n "$THREADS " >> /.autorelabel
@@ -337,17 +339,17 @@ esac
 }
 usage() {
 	echo $"""
-Usage: $0 [-v] [-F] [-M] [-f] [-T nthreads] relabel
+Usage: $0 [-v] [-F] [-I|-D] [-M] [-f] [-T nthreads] relabel
 or
-Usage: $0 [-v] [-F] [-B | -N time ] [-T nthreads] { check | restore | verify }
+Usage: $0 [-v] [-F] [-I|-D] [-B | -N time ] [-T nthreads] { check | restore | verify }
 or
-Usage: $0 [-v] [-F] [-T nthreads] { check | restore | verify } dir/file ...
+Usage: $0 [-v] [-F] [-I|-D] [-T nthreads] { check | restore | verify } dir/file ...
 or
-Usage: $0 [-v] [-F] [-T nthreads] -R rpmpackage[,rpmpackage...] { check | restore | verify }
+Usage: $0 [-v] [-F] [-I|-D] [-T nthreads] -R rpmpackage[,rpmpackage...] { check | restore | verify }
 or
-Usage: $0 [-v] [-F] [-T nthreads] -C PREVIOUS_FILECONTEXT { check | restore | verify }
+Usage: $0 [-v] [-F] [-I|-D] [-T nthreads] -C PREVIOUS_FILECONTEXT { check | restore | verify }
 or
-Usage: $0 [-F] [-M] [-B] [-T nthreads] onboot
+Usage: $0 [-F] [-I|-D] [-M] [-B] [-T nthreads] onboot
 """
 }
 
@@ -366,7 +368,7 @@ set_restore_mode() {
 }
 
 # See how we were called.
-while getopts "N:BC:FfR:l:vMT:" i; do
+while getopts "N:BC:FIDfR:l:vMT:" i; do
     case "$i" in
 	B)
 		BOOTTIME=`/bin/who -b | awk '{print $3}'`
@@ -398,6 +400,12 @@ while getopts "N:BC:FfR:l:vMT:" i; do
 	F)
 		FORCEFLAG="-F"
 		;;
+	I)
+		DIGESTFLAG="-I"
+		;;
+	D)
+		[ -z "$DIGESTFLAG" ] && DIGESTFLAG="-D"
+		;;
 	f)
 		fullFlag=1
 		;;
diff --git a/policycoreutils/scripts/fixfiles.8 b/policycoreutils/scripts/fixfiles.8
index 928b8200..f5b5d9ac 100644
--- a/policycoreutils/scripts/fixfiles.8
+++ b/policycoreutils/scripts/fixfiles.8
@@ -6,22 +6,22 @@ fixfiles \- fix file SELinux security contexts.
 .na
 
 .B fixfiles
-.I [\-v] [\-F] [-M] [\-f] [\-T nthreads] relabel
+.I [\-v] [\-F] [\-I|\-D] [-M] [\-f] [\-T nthreads] relabel
 
 .B fixfiles
-.I [\-v] [\-F] [\-T nthreads] { check | restore | verify } dir/file ...
+.I [\-v] [\-F] [\-I|\-D] [\-T nthreads] { check | restore | verify } dir/file ...
 
 .B fixfiles
-.I [\-v] [\-F] [\-B | \-N time ] [\-T nthreads] { check | restore | verify }
+.I [\-v] [\-F] [\-I|\-D] [\-B | \-N time ] [\-T nthreads] { check | restore | verify }
 
 .B fixfiles
-.I [\-v] [\-F] [\-T nthreads] \-R rpmpackagename[,rpmpackagename...] { check | restore | verify }
+.I [\-v] [\-F] [\-I|\-D] [\-T nthreads] \-R rpmpackagename[,rpmpackagename...] { check | restore | verify }
 
 .B fixfiles
-.I [\-v] [\-F] [\-T nthreads] \-C PREVIOUS_FILECONTEXT  { check | restore | verify }
+.I [\-v] [\-F] [\-I|\-D] [\-T nthreads] \-C PREVIOUS_FILECONTEXT  { check | restore | verify }
 
 .B fixfiles
-.I [-F] [-M] [-B] [\-T nthreads] onboot
+.I [-F] [\-I|\-D] [-M] [-B] [\-T nthreads] onboot
 
 .ad
 
@@ -52,6 +52,22 @@ If specified with onboot, this fixfiles will record the current date in the /.au
 .B \-F
 Force reset of context to match file_context for customizable files
 
+.TP
+.B \-D
+Set or update per-directory
+.I security.sehash
+digests. On subsequent runs, directories whose stored digest still
+matches the current file_contexts are skipped. See
+.BR setfiles (8).
+
+.TP
+.B \-I
+Ignore existing per-directory
+.I security.sehash
+digests, so all directories are checked and their
+digests refreshed. See
+.BR setfiles (8).
+
 .TP
 .B \-f
 Clear /tmp directory with out prompt for removal.
-- 
2.55.0

