Return-Path: <SRS0=oqeB=XT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FA0C432C1
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 19:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634BD20872
	for <selinux@archiver.kernel.org>; Tue, 24 Sep 2019 19:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441863AbfIXTJE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 24 Sep 2019 15:09:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36484 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441862AbfIXTJE (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 24 Sep 2019 15:09:04 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 35DC718C891A
        for <selinux@vger.kernel.org>; Tue, 24 Sep 2019 19:09:04 +0000 (UTC)
Received: from workstation.redhat.com (ovpn-204-49.brq.redhat.com [10.40.204.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E22D6012C;
        Tue, 24 Sep 2019 19:09:03 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH 1/2] policycoreutils/fixfiles: Fix [-B] [-F] onboot
Date:   Tue, 24 Sep 2019 21:08:53 +0200
Message-Id: <20190924190854.245105-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.70]); Tue, 24 Sep 2019 19:09:04 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Commit 6e289bb7bf3d ("policycoreutils: fixfiles: remove bad modes of "relabel"
command") added "$RESTORE_MODE" != DEFAULT test when onboot is used. It makes
`fixfiles -B onboot` to show usage instead of updating /.autorelabel

The code is restructured to handle -B for different modes correctly.

Fixes:
    # fixfiles -B onboot
    Usage: /usr/sbin/fixfiles [-v] [-F] [-f] relabel
    ...

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/scripts/fixfiles | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 5be9ba6e..678fca40 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -111,7 +111,7 @@ VERBOSE="-p"
 FORCEFLAG=""
 RPMFILES=""
 PREFC=""
-RESTORE_MODE="DEFAULT"
+RESTORE_MODE=""
 SETFILES=/sbin/setfiles
 RESTORECON=/sbin/restorecon
 FILESYSTEMSRW=`get_rw_labeled_mounts`
@@ -213,16 +213,17 @@ restore () {
 OPTION=$1
 shift
 
-case "$RESTORE_MODE" in
-    PREFC)
-	diff_filecontext $*
-	return
-    ;;
-    BOOTTIME)
+# [-B | -N time ]
+if [ -n "$BOOTTIME" ]; then
 	newer $BOOTTIME $*
 	return
-    ;;
-esac
+fi
+
+# -C PREVIOUS_FILECONTEXT
+if [ "$RESTORE_MODE" == PREFC ]; then
+	diff_filecontext $*
+	return
+fi
 
 [ -x /usr/sbin/genhomedircon ] && /usr/sbin/genhomedircon
 
@@ -238,7 +239,7 @@ case "$RESTORE_MODE" in
     FILEPATH)
 	${RESTORECON} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} $* -R -- "$FILEPATH"
     ;;
-    DEFAULT)
+    *)
 	if [ -n "${FILESYSTEMSRW}" ]; then
 	    LogReadOnly
 	    echo "${OPTION}ing `echo ${FILESYSTEMSRW}`"
@@ -271,7 +272,7 @@ fullrelabel() {
 
 
 relabel() {
-    if [ "$RESTORE_MODE" != DEFAULT ]; then
+    if [ -n "$RESTORE_MODE" -a "$RESTORE_MODE" != DEFAULT ]; then
 	usage
 	exit 1
     fi
@@ -305,7 +306,7 @@ case "$1" in
     verify) restore Verify -n;;
     relabel) relabel;;
     onboot)
-	if [ "$RESTORE_MODE" != DEFAULT ]; then
+	if [ -n "$RESTORE_MODE" -a "$RESTORE_MODE" != DEFAULT ]; then
 	    usage
 	    exit 1
 	fi
@@ -343,7 +344,7 @@ if [ $# -eq 0 ]; then
 fi
 
 set_restore_mode() {
-	if [ "$RESTORE_MODE" != DEFAULT ]; then
+	if [ -n "$RESTORE_MODE" ]; then
 		# can't specify two different modes
 		usage
 		exit 1
@@ -356,7 +357,7 @@ while getopts "N:BC:FfR:l:v" i; do
     case "$i" in
 	B)
 		BOOTTIME=`/bin/who -b | awk '{print $3}'`
-		set_restore_mode BOOTTIME
+		set_restore_mode DEFAULT
 		;;
 	N)
 		BOOTTIME=$OPTARG
-- 
2.23.0

