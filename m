Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FA6C4332F
	for <selinux@archiver.kernel.org>; Mon,  7 Nov 2022 09:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiKGJaP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Nov 2022 04:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbiKGJaL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Nov 2022 04:30:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5468713F99
        for <selinux@vger.kernel.org>; Mon,  7 Nov 2022 01:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667813356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=ueseRzfUsUSsxiEfMH99LEuXwgXGbMAn/9yQFYrawLE=;
        b=Zso/1hUuyiWYDDu4r014KmC0CHKGo1UwDd+g2oExV6JdSi0NdBTPhYKND9SraqqDl2ZBaa
        KZUeQjmZ6P2K6OEgKa7mNrsNBXSypCnMQsMVdXiKIMrjH20+XcCu1L1ANn9Sb0CH1zPLdj
        1HTPTr+HE3/4vru8Ios43WE9Jnxvh/Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-LpS7iYUtO8OWwzNk6siQrQ-1; Mon, 07 Nov 2022 04:29:15 -0500
X-MC-Unique: LpS7iYUtO8OWwzNk6siQrQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09C0038012CE
        for <selinux@vger.kernel.org>; Mon,  7 Nov 2022 09:29:15 +0000 (UTC)
Received: from localhost.localdomain (ovpn-192-172.brq.redhat.com [10.40.192.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CBC24B3FC6;
        Mon,  7 Nov 2022 09:29:14 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v2] fixfiles: Unmount temporary bind mounts on SIGINT
Date:   Mon,  7 Nov 2022 10:25:05 +0100
Message-Id: <20221107092504.1088612-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

`fixfiles -M relabel` temporary bind mounts file systems before
relabeling, but it left the / directory mounted in /tmp/tmp.XXXX when a
user hit CTRL-C. It means that if the user run `fixfiles -M relabel`
again and answered Y to clean out /tmp directory, it would remove all
data from mounted fs.

This patch changes the location where `fixfiles` mounts fs to /run, uses
private mount namespace via unshare and adds a handler for exit signals
which tries to umount fs mounted by `fixfiles`.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2125355

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---

v2: fixed issues reported by Christian Göttsche <cgzones@googlemail.com>


 policycoreutils/scripts/fixfiles | 36 +++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index c72ca0eb9d61..166af6f360a2 100755
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
+	            TMP_MOUNT="$(mktemp -p /run -d fixfiles.XXXXXXXXXX)"
+	            export SETFILES VERBOSE EXCLUDEDIRS FORCEFLAG THREADS FC TMP_MOUNT m
+	            if type unshare &> /dev/null; then
+	                unshare -m bash -c "fix_labels_on_mountpoint $*" || exit $?
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

