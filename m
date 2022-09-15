Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC8AECAAD3
	for <selinux@archiver.kernel.org>; Thu, 15 Sep 2022 12:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiIOMpA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Sep 2022 08:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiIOMoh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Sep 2022 08:44:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62445F55
        for <selinux@vger.kernel.org>; Thu, 15 Sep 2022 05:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663245868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VkTltDncBHNyxx3agv0CpXodW1FS6AWqZ6cZWy50QRY=;
        b=e18W7xwtuI8l85nByfJd2JIAZ4JGd5M40/sRQhobjyBj19Yf9qH2+IKhLTLaLb/kzSN2l3
        WabJYs+eE5u7rdXKqr35XY6Ksq9tmFilL5FjdQJkX/XbaXindLQ6150Rn07oI0WlYBbDYS
        ZBGNlNulAMZ68anIfwNLQ1MjNHcqslk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-UPbViW_SPB2ZT_QuIWBdaA-1; Thu, 15 Sep 2022 08:44:27 -0400
X-MC-Unique: UPbViW_SPB2ZT_QuIWBdaA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16B6B862FE3
        for <selinux@vger.kernel.org>; Thu, 15 Sep 2022 12:44:27 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.193.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 78C3C207B34A;
        Thu, 15 Sep 2022 12:44:26 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH] fixfiles: Unmount temporary bind mounts on SIGINT
Date:   Thu, 15 Sep 2022 14:44:18 +0200
Message-Id: <20220915124418.27156-1-plautrba@redhat.com>
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

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2125355

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
 policycoreutils/scripts/fixfiles | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index c72ca0eb9d61..6811921970f2 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -207,6 +207,15 @@ rpm -q --qf '[%{FILESTATES} %{FILENAMES}\n]' "$1" | grep '^0 ' | cut -f2- -d ' '
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
 #
 # restore
 # if called with -n will only check file context
@@ -251,6 +260,7 @@ case "$RESTORE_MODE" in
 	    else
 	        # we bind mount so we can fix the labels of files that have already been
 	        # mounted over
+	        trap umount_TMP_MOUNT SIGINT
 	        for m in `echo $FILESYSTEMSRW`; do
 	            TMP_MOUNT="$(mktemp -d)"
 	            test -z ${TMP_MOUNT+x} && echo "Unable to find temporary directory!" && exit 1
@@ -261,6 +271,7 @@ case "$RESTORE_MODE" in
 	            umount "${TMP_MOUNT}${m}" || exit 1
 	            rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
 	        done;
+	        trap SIGINT
 	    fi
 	else
 	    echo >&2 "fixfiles: No suitable file systems found"
-- 
2.37.3

