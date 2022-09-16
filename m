Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86512C54EE9
	for <selinux@archiver.kernel.org>; Fri, 16 Sep 2022 14:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiIPOOf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Sep 2022 10:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiIPOOe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Sep 2022 10:14:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849AFBAD
        for <selinux@vger.kernel.org>; Fri, 16 Sep 2022 07:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663337667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FUIr4fOV2ORUzw+7+OOT6qVVXlOC8gO86XmVGqbmbBs=;
        b=hIGV/ldcrFlDtAZlHw3k7FJHtv6LjQH64CQOCZfdYgcPifstJuUTyjaEmlVAntXNlGasGf
        ODIEzs6dgPLpXx6fo7SpZOrnwLWscEctOxH4gz+R2077q47RizMtKSvIx0bspVBwsfhSyu
        7ys2dXXRyqKsiOj9J0nlS4UYUu0hZFc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-PZ-_7j_gPlea6ZMRzqduPA-1; Fri, 16 Sep 2022 10:14:25 -0400
X-MC-Unique: PZ-_7j_gPlea6ZMRzqduPA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 675BE101AA5B
        for <selinux@vger.kernel.org>; Fri, 16 Sep 2022 14:14:25 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.192.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8A4F728FD;
        Fri, 16 Sep 2022 14:14:24 +0000 (UTC)
From:   Petr Lautrbach <plautrba@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v3] fixfiles: Unmount temporary bind mounts on SIGINT
Date:   Fri, 16 Sep 2022 16:13:09 +0200
Message-Id: <20220916141308.72606-1-plautrba@redhat.com>
In-Reply-To: <20220915163751.41804-1-plautrba@redhat.com>
References: <20220915163751.41804-1-plautrba@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

`fixfiles -M relabel` temporary bind mounts filestems before relabeling
but it leaves a directory mounted in /tmp/tmp.XXXX when a user hits
CTRL-C. It means that if the user run `fixfiles -M relabel` again and
answered Y to clean out /tmp directory, it would remove all data from
mounted fs.

This patch changes the location where `fixfiles` mounts fs to /run and
adds a handler for exit signals which tries to umount fs mounted by
`fixfiles`.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=2125355

Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
---
v2:

- set trap on EXIT instead of SIGINT

v3:

- use /run instead of /tmp for mountpoints


 policycoreutils/scripts/fixfiles | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index c72ca0eb9d61..acf5f0996c19 100755
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
@@ -251,8 +260,9 @@ case "$RESTORE_MODE" in
 	    else
 	        # we bind mount so we can fix the labels of files that have already been
 	        # mounted over
+	        trap umount_TMP_MOUNT EXIT
 	        for m in `echo $FILESYSTEMSRW`; do
-	            TMP_MOUNT="$(mktemp -d)"
+	            TMP_MOUNT="$(mktemp -p /run -d fixfiles.XXXXXXXXXX)"
 	            test -z ${TMP_MOUNT+x} && echo "Unable to find temporary directory!" && exit 1
 
 	            mkdir -p "${TMP_MOUNT}${m}" || exit 1
@@ -261,6 +271,7 @@ case "$RESTORE_MODE" in
 	            umount "${TMP_MOUNT}${m}" || exit 1
 	            rm -rf "${TMP_MOUNT}" || echo "Error cleaning up."
 	        done;
+	        trap EXIT
 	    fi
 	else
 	    echo >&2 "fixfiles: No suitable file systems found"
-- 
2.37.3

