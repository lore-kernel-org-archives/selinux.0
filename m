Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB930C433FE
	for <selinux@archiver.kernel.org>; Fri,  7 Oct 2022 13:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiJGNrX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Oct 2022 09:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiJGNrV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Oct 2022 09:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D545CC588A
        for <selinux@vger.kernel.org>; Fri,  7 Oct 2022 06:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665150440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RlKu4J0azkkK84XJbWeAgpXI/9z03rISJu/cwU49EDs=;
        b=NwV8Dp+kSDiWSbQZ9e/+wBWd4DKg2oIKvI4n2/ZhsmpxIYXW3WaRDVP4lxn+C/p7tid/63
        p7peXnGg340TScWVBAPmBy1V1veb/cmUml5FWKM1ZLw/qs5wsGBG4kagtZKajqEk9id0KM
        hz5zJYWBrGwwPeBgZ9vuJyTIBc4WhwU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-MpQkZwW8OT2pDIdB20gpKw-1; Fri, 07 Oct 2022 09:47:18 -0400
X-MC-Unique: MpQkZwW8OT2pDIdB20gpKw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2546185A78F
        for <selinux@vger.kernel.org>; Fri,  7 Oct 2022 13:47:18 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F6E02028DC1;
        Fri,  7 Oct 2022 13:47:17 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v4] fixfiles: Unmount temporary bind mounts on SIGINT
Date:   Fri,  7 Oct 2022 15:46:01 +0200
Message-Id: <20221007134600.137812-1-plautrba@redhat.com>
In-Reply-To: <CAJ2a_DeBWkHziE4+DsRqqLULtGkdX68c8jdU3Hxs++84NoPpsQ@mail.gmail.com>
References: <CAJ2a_DeBWkHziE4+DsRqqLULtGkdX68c8jdU3Hxs++84NoPpsQ@mail.gmail.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

`fixfiles -M relabel` temporary bind mounts filestems before relabeling
but it leaves a directory mounted in /tmp/tmp.XXXX when a user hits
CTRL-C. It means that if the user run `fixfiles -M relabel` again and
answered Y to clean out /tmp directory, it would remove all data from
mounted fs.

This patch changes the location where `fixfiles` mounts fs to /run, uses
private mount namespace via unshare and adds a handler for exit signals
which tries to umount fs mounted by `fixfiles`.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2125355

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
v2:

- set trap on EXIT instead of SIGINT

v3:

- use /run instead of /tmp for mountpoints

v4:

- use mount namespace as suggested by Christian Göttsche <cgzones@googlemail.com> (September 16) (inbox)


 policycoreutils/scripts/fixfiles | 36 +++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index c72ca0eb9d61..af64a5a567a6 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -207,6 +207,25 @@ rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1" | grep '^0 ' | cut -f2- -d ' '
 [ ${PIPESTATUS[0]} != 0 ] && echo "$1 not found" >/dev/stderr
 }
 
+# unmount tmp bind mount before exit
+umount_TMP_MOUNT() {
+	if [ -n "$TMP_MOUNT" ]; then
+	     umount "${TMP_MOUNT}${m}" || exit 130
+	     rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
+	fi
+	exit 130
+}
+
+fix_labels_on_mountpoint() {
+	test -z ${TMP_MOUNT+x} && echo "Unable to find temporary directory!" && exit 1
+	mkdir -p "${TMP_MOUNT}${m}" || exit 1
+	mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
+	${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $* -q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
+	umount "${TMP_MOUNT}${m}" || exit 1
+	rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
+}
+export -f fix_labels_on_mountpoint
+
 #
 # restore
 # if called with -n will only check file context
@@ -252,14 +271,15 @@ case "$RESTORE_MODE" in
 	        # we bind mount so we can fix the labels of files that have already been
 	        # mounted over
 	        for m in `echo $FILESYSTEMSRW`; do
-	            TMP_MOUNT="$(mktemp -d)"
-	            test -z ${TMP_MOUNT+x} && echo "Unable to find temporary directory!" && exit 1
-
-	            mkdir -p "${TMP_MOUNT}${m}" || exit 1
-	            mount --bind "${m}" "${TMP_MOUNT}${m}" || exit 1
-	            ${SETFILES} ${VERBOSE} ${EXCLUDEDIRS} ${FORCEFLAG} ${THREADS} $* -q ${FC} -r "${TMP_MOUNT}" "${TMP_MOUNT}${m}"
-	            umount "${TMP_MOUNT}${m}" || exit 1
-	            rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
+	          	TMP_MOUNT="$(mktemp -p /run -d fixfiles.XXXXXXXXXX)"
+	            export SETFILES VERBOSE EXCLUDEDIRS FORCEFLAG THREADS FC TMP_MOUNT m
+	            if type unshare &> /dev/null; then
+	                unshare -m bash -x -c "fix_labels_on_mountpoint" $* || exit $?
+	            else
+	                trap umount_TMP_MOUNT EXIT
+	                fix_labels_on_mountpoint $*
+	                trap EXIT
+	            fi
 	        done;
 	    fi
 	else
-- 
2.37.3

