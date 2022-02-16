Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3AEC433F5
	for <selinux@archiver.kernel.org>; Wed, 16 Feb 2022 17:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237347AbiBPRtd (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Feb 2022 12:49:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbiBPRtc (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Feb 2022 12:49:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F844254A5E
        for <selinux@vger.kernel.org>; Wed, 16 Feb 2022 09:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645033758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=90aJTfvaDsqtdYuXID3TitANv4/HDgsU+thZkE8zlVQ=;
        b=fHq1WLYpCMba3MyBa1+Bufao2Y754ffatNFhpIE9BypP0FhQl/a3fYn9uDSXbldL/RuvDp
        lO2G5iZ6Xvzj9YlGELfpSY8I8JN4DmnFOucqqoj49IQBqopLXrBeBH1fB7MlgM7a2c3gm/
        1NYbw1KzJMWLNF7IYFmp//YsFRr7UlY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-668-9IKd0NDpOYuwlP6MyGBTnA-1; Wed, 16 Feb 2022 12:49:17 -0500
X-MC-Unique: 9IKd0NDpOYuwlP6MyGBTnA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C4501853022
        for <selinux@vger.kernel.org>; Wed, 16 Feb 2022 17:49:16 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.163])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E27E7CD63;
        Wed, 16 Feb 2022 17:49:15 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] policycoreutils/fixfiles: Use parallel relabeling
Date:   Wed, 16 Feb 2022 18:49:09 +0100
Message-Id: <20220216174909.333355-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit 93902fc8340f ("setfiles/restorecon: support parallel relabeling")
implemented support for parallel relabeling in setfiles. This is
available for fixfiles now.

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/scripts/fixfiles   | 33 +++++++++++++++++-------------
 policycoreutils/scripts/fixfiles.8 | 17 +++++++++------
 2 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 6fb12e0451a9..33db1d3bfb61 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -109,6 +109,7 @@ fullFlag=0
 BOOTTIME=""
 VERBOSE="-p"
 FORCEFLAG=""
+THREADS=""
 RPMFILES=""
 PREFC=""
 RESTORE_MODE=""
@@ -152,7 +153,7 @@ newer() {
     shift
     LogReadOnly
     for m in `echo $FILESYSTEMSRW`; do
-	find $m -mount -newermt $DATE -print0 2>/dev/null | ${RESTORECON} ${FORCEFLAG} ${VERBOSE} $* -i -0 -f -
+	find $m -mount -newermt $DATE -print0 2>/dev/null | ${RESTORECON} ${FORCEFLAG} ${VERBOSE} ${THREADS} $* -i -0 -f -
     done;
 }
 
@@ -196,7 +197,7 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
 		  esac; \
 	       fi; \
 	    done | \
-	${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} $* -i -R -f -; \
+	${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $* -i -R -f -; \
 	rm -f ${TEMPFILE} ${PREFCTEMPFILE}
 fi
 }
@@ -234,11 +235,11 @@ LogExcluded
 case "$RESTORE_MODE" in
     RPMFILES)
 	for i in `echo "$RPMFILES" | sed 's/,/ /g'`; do
-	    rpmlist $i | ${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} $* -i -R -f -
+	    rpmlist $i | ${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $* -i -R -f -
 	done
     ;;
     FILEPATH)
-	${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} $* -R -- "$FILEPATH"
+	${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $* -R -- "$FILEPATH"
     ;;
     *)
 	if [ -n "${FILESYSTEMSRW}" ]; then
@@ -246,7 +247,7 @@ case "$RESTORE_MODE" in
 	    echo "${OPTION}ing `echo ${FILESYSTEMSRW}`"
 
 	    if [ -z "$BIND_MOUNT_FILESYSTEMS" ]; then
-	        ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} $* -q ${FC} ${FILESYSTEMSRW}
+	        ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} $* -q ${THREADS} ${FC} ${FILESYSTEMSRW}
 	    else
 	        # we bind mount so we can fix the labels of files that have already been
 	        # mounted over
@@ -256,7 +257,7 @@ case "$RESTORE_MODE" in
 
 	            mkdir -p "${TMP_MOUNT}${m}" || exit 1
 	            mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
-	            ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} $* -q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
+	            ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $* -q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
 	            umount "${TMP_MOUNT}${m}" || exit 1
 	            rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
 	        done;
@@ -330,7 +331,8 @@ case "$1" in
 	> /.autorelabel || exit $?
 	[ -z "$FORCEFLAG" ] || echo -n "$FORCEFLAG " >> /.autorelabel
 	[ -z "$BOOTTIME" ] || echo -N $BOOTTIME >> /.autorelabel
-	[ -z "$BIND_MOUNT_FILESYSTEMS" ] || echo "-M" >> /.autorelabel
+	[ -z "$BIND_MOUNT_FILESYSTEMS" ] || echo "-M " >> /.autorelabel
+	[ -z "$THREADS" ] || echo -n "$THREADS " >> /.autorelabel
 	# Force full relabel if SELinux is not enabled
 	selinuxenabled || echo -F > /.autorelabel
 	echo "System will relabel on next boot"
@@ -342,17 +344,17 @@ esac
 }
 usage() {
 	echo $"""
-Usage: $0 [-v] [-F] [-M] [-f] relabel
+Usage: $0 [-v] [-F] [-M] [-f] [-T nthreads] relabel
 or
-Usage: $0 [-v] [-F] [-B | -N time ] { check | restore | verify }
+Usage: $0 [-v] [-F] [-B | -N time ]  [-T nthreads] { check | restore | verify }
 or
-Usage: $0 [-v] [-F] { check | restore | verify } dir/file ...
+Usage: $0 [-v] [-F] [-T nthreads] { check | restore | verify } dir/file ...
 or
-Usage: $0 [-v] [-F] -R rpmpackage[,rpmpackage...] { check | restore | verify }
+Usage: $0 [-v] [-F] [-T nthreads] -R rpmpackage[,rpmpackage...] { check | restore | verify }
 or
-Usage: $0 [-v] [-F] -C PREVIOUS_FILECONTEXT { check | restore | verify }
+Usage: $0 [-v] [-F] [-T nthreads] -C PREVIOUS_FILECONTEXT { check | restore | verify }
 or
-Usage: $0 [-F] [-M] [-B] onboot
+Usage: $0 [-F] [-M] [-B] [-T nthreads] onboot
 """
 }
 
@@ -371,7 +373,7 @@ set_restore_mode() {
 }
 
 # See how we were called.
-while getopts "N:BC:FfR:l:vM" i; do
+while getopts "N:BC:FfR:l:vMT:" i; do
     case "$i" in
 	B)
 		BOOTTIME=`/bin/who -b | awk '{print $3}'`
@@ -406,6 +408,9 @@ while getopts "N:BC:FfR:l:vM" i; do
 	f)
 		fullFlag=1
 		;;
+	T)
+		THREADS="-T $OPTARG"
+		;;
 	*)
 	    usage
 	    exit 1
diff --git a/policycoreutils/scripts/fixfiles.8 b/policycoreutils/scripts/fixfiles.8
index c4e894e56e8f..9a317d9181e2 100644
--- a/policycoreutils/scripts/fixfiles.8
+++ b/policycoreutils/scripts/fixfiles.8
@@ -6,22 +6,22 @@ fixfiles \- fix file SELinux security contexts.
 .na
 
 .B fixfiles
-.I [\-v] [\-F] [-M] [\-f] relabel
+.I [\-v] [\-F] [-M] [\-f] [\-T nthreads] relabel
 
 .B fixfiles
-.I [\-v] [\-F] { check | restore | verify } dir/file ...
+.I [\-v] [\-F] [\-T nthreads] { check | restore | verify } dir/file ...
 
 .B fixfiles
-.I [\-v] [\-F] [\-B | \-N time ] { check | restore | verify }
+.I [\-v] [\-F] [\-B | \-N time ] [\-T nthreads] { check | restore | verify }
 
 .B fixfiles 
-.I [\-v] [\-F] \-R rpmpackagename[,rpmpackagename...] { check | restore | verify }
+.I [\-v] [\-F] [\-T nthreads] \-R rpmpackagename[,rpmpackagename...] { check | restore | verify }
 
 .B fixfiles
-.I [\-v] [\-F] \-C PREVIOUS_FILECONTEXT  { check | restore | verify }
+.I [\-v] [\-F] [\-T nthreads] \-C PREVIOUS_FILECONTEXT  { check | restore | verify }
 
 .B fixfiles
-.I [-F] [-M] [-B] onboot
+.I [-F] [-M] [-B] [\-T nthreads] onboot
 
 .ad
 
@@ -76,6 +76,11 @@ Bind mount filesystems before relabeling them, this allows fixing the context of
 .B -v
 Modify verbosity from progress to verbose. (Run restorecon with \-v instead of \-p)
 
+.TP
+.B \-T nthreads
+Use parallel relabeling, see
+.B setfiles(8)
+
 .SH "ARGUMENTS"
 One of:
 .TP 
-- 
2.34.1

