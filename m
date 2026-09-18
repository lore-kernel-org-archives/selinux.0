Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC1351FCDA
	for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 19:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789759748; cv=none; b=Bv+TGCr6h3lb4uctsr0LSf4pJ6kmxrxDvjBwpwdlCtgGgGjSBnemYpZ2Dsnu5tvT5sYcaPA83Bvk3iofWXZCvLXOT3Uh+dCz+ZYxfP2S1pidQfH9DkOsrGjtGZ5MUwXSkt+TkGhKVUNJoa/aXLOS1Fxgz5j7FFovP3gF64PrPZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789759748; c=relaxed/simple;
	bh=QvdWBD3e5eqWgsjGcA/qw1/BgtlPwuO0407vGNXrmK0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AnrcWgQyq8dinwyxKm/2LvO4sYnImq1BQp0vmbiui6h+M2v8CGUQyFVsKiNYKhNDd8TE3m8/b/ErX9/qSZILZd9IGKwfzipHDK+rhH8zJCunKwFU0L6O/dJo+yqiN/AnVbvZjD4AGBcX1uQdkb4XulNyylXbdkoW+gHAXJOJfdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekn+4NQe; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekn+4NQe"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-939109f067eso105970085a.0
        for <selinux@vger.kernel.org>; Fri, 18 Sep 2026 12:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789759740; x=1790364540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=//vfEx2nq/6pTT6BRaRNP9X2SwEe6y4Tp9mkMLH7cAA=;
        b=ekn+4NQeK3+KmP2FbZX9Hx4tMF2BykBY3UIn3zvk2RCz8qgvBdbt180Xxg+kawrlj+
         bX46QMLuXdXbw5G1KexZDsp9eALmPSBLF6IncGzWk9umPvSvzTgxyk5AfcXsaXqhvBPH
         UDXerCDBE9c0dFOdJKJpQ3CzdoAuWDYjlwQBC1SsZm77cSDUwEuFvxqlsObd+HykkbkY
         aqEkXNyKAcGFUaU8x6Lg+JVn4WbUd8V6XsIZcmlIr0Cod+UUvjVpFgyBNjMB6KaPJGRO
         wj6pYrZu0SpgIfMo5t3KYJ71QxLqoIemLwgDSr4A79daNVNX7a9Z1k14AHGIK7arNUzC
         Hylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789759740; x=1790364540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=//vfEx2nq/6pTT6BRaRNP9X2SwEe6y4Tp9mkMLH7cAA=;
        b=E6aemoopUYlrcX6zNH4Edk9oVlWmHggvdlxVjS3aduMileehu4JjaRKY7OspOppqfm
         ka57oOt2h6+/lN4YKiOWyvYxivOcAz8pfyePi+9wK6HimDF5JSXX9v/pXJRv6EByxA4U
         /80dgPndHYz7FLR5u4S3xxrlnzNUQ4sKWqeDgq4uPVlLw49FU/prGmYBPfsK9CKoFtYP
         AaOhE1vex3oSIU/1lT/zcEKvI4o1bzA57lX8fbRzyNwoyn3MO4rrAyUEWTTf06s0Wp7g
         fUiAcrpwg65iHh4reK00EWre2pNP0CJc7KOVevz4EQ83PXpJBBrPWwYv0NEzwYnZl2+C
         DSpw==
X-Gm-Message-State: AFuF++l8uElGAR4Q0CoG6Vk27Vr2RP7u/7tLtmDc706GgVR5N9PXxKla
	DXWS6BS7SWSefcv2t6AobrZQ0G0HAvgLlNRlNqjU3de9t/i1L6U9eHEzFGKUfg==
X-Gm-Gg: AYBFou0Sytrr6jna6fdgGYNSw5ollk2BxtKlwa656iV/AI2VDsaZeGGXw8SwMNuYrJ6
	nr0DTitm6tfOmxMyG1Fj68pF+TB68Pq9JLW/hEdQDI6CN4RdKKCiHq3z/aPz2q9222tNOF6oA8M
	Sd/sKVwkW/rPMD/cukuSmX1Uq7BrPjGNcmgTMr0A4h426EYAkjBXtBdnHt0Okg4W75p2IRH+fhA
	5ywVu0jovzlvI0OUlKVvHxKrWqfKKQKIlKrRwpt/U0tgH+RhHTyVX2rk9+ZCU8P/5JF3ZJx3mAz
	XIy2fhYZz+cXEM9re0rKA0MEAJIdf86cdUvfIPdAYZS790xib1NrcW5SrKUrfi9friSeMTDiDPW
	q2SkhtjITHDccUms18WxSAQvMLGBXwjZGc+/AbYA9iDk5n9wyi/u1OWsaUR6lRW9SrSNZhSsULI
	W3KKmlToSY+kX+Avd7OvTPXXIbr1+TPPhMeJOKFPalfPrvLWHY/a2C0PhNzNbpM8CZyqIqRr2av
	7tAQuzJnwiZ+LbHwyBN6DpBOjTJewxhlRLJB9z4lLWjBirxqFZMdiB4qVozokAjoOei/A5FpYk=
X-Received: by 2002:a05:620a:808e:b0:939:7d8b:93e0 with SMTP id af79cd13be357-93bdc6a7d66mr548147385a.18.1789759739537;
        Fri, 18 Sep 2026 12:28:59 -0700 (PDT)
Received: from fedora (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93bed72215fsm20868185a.1.2026.09.18.12.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 12:28:59 -0700 (PDT)
From: Stephen Smalley <stephen.smalley.work@gmail.com>
To: selinux@vger.kernel.org
Cc: plautrba@redhat.com,
	omosnacek@gmail.com,
	jason@perfinion.com,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v2] policycoreutils/scripts/fixfiles: pass -I/-D through to setfiles/restorecon
Date: Fri, 18 Sep 2026 15:26:37 -0400
Message-ID: <20260918192636.32626-2-stephen.smalley.work@gmail.com>
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

Add -I and -D to fixfiles and pass whichever is set as ${DIGESTFLAG}
to every setfiles/restorecon invocation, export it into the unshare -m
subshell used with -M, and record it in /.autorelabel for onboot. -I
wins over -D (setfiles -I already implies -D).

Fixes: https://github.com/SELinuxProject/selinux/issues/44
Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
v2 fixes a typo in the description.

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

