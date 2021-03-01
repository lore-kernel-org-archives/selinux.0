Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F5EC43381
	for <selinux@archiver.kernel.org>; Mon,  1 Mar 2021 17:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A8F165278
	for <selinux@archiver.kernel.org>; Mon,  1 Mar 2021 17:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbhCAR3x (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Mar 2021 12:29:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60112 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237911AbhCARVA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Mar 2021 12:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614619169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sQJNdQOa4Fxg9rEeXFCUFrldT8uEc3fyCERILixgnB8=;
        b=KpAetOCtMNCf4mt1M7BNsAaWRV3FmeJRxAB7Dh68iNbD8AHoaAa4NZ/cCYtrDWoJZA9DmH
        LYVm7F0D7Rjd6mvIlxCM4Q4UhAhPTRH+AITuz0Dl8EzF+nwdvX8wR8phZqVmn8vYxb48Jf
        w3bWqa3T047WMNYAfQbk1NDW3sEe2ZU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-adbTffZQNK-U6IBjelcsRg-1; Mon, 01 Mar 2021 12:19:26 -0500
X-MC-Unique: adbTffZQNK-U6IBjelcsRg-1
Received: by mail-ej1-f72.google.com with SMTP id jo6so4879911ejb.13
        for <selinux@vger.kernel.org>; Mon, 01 Mar 2021 09:19:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sQJNdQOa4Fxg9rEeXFCUFrldT8uEc3fyCERILixgnB8=;
        b=Vew0wBFbL4oEZgTNdVq/X6xhJ8sL8cz6rSjVixy+etzOO40LF9n+zpsrBzKrVhMPGz
         DVJq9vn8FTXyKCsBwkaijtKXym9KiDhRmjS26T2QDCJgVcqQrEQ4q0dd2X70tXsiWu8n
         KcUaHSGbDmPqieVe/5CQ5xqJXKGBx4/e9Vygl/SVs/o2bDBODDs1CLafurN1wpyJ0Ozj
         wl3sLXiRuo0bjO4A3jTkBGYHE8ky7UuPgIsTAzDsokjDnp3IxKyL3c1ujlDgPfYNHwt6
         6ZbwEtxNfkV3EOrV6OJcS78vghWFtzgG0dUARLZGBjP86vZsyIxeQFVDwCufWxGvf+l+
         817g==
X-Gm-Message-State: AOAM530eOhcnXF8G9GgnrW3a19+3kGtieA9dxC1fbNHheNpIvkIKxapT
        rxAGvLFHEYVtGvBEBaoRfd/ShZMnJALNfpU6UhhZYOi22kuIxdkbk6b6E42Hy8TCpf6bcCpe2Lp
        cH79XgLys0VB2YP80XLKFegGXVaKKswN8T4xPXU8FEF2eycCnm5wF+1yl9dsZEH43pHySxQ==
X-Received: by 2002:a17:906:95d1:: with SMTP id n17mr5091944ejy.394.1614619165358;
        Mon, 01 Mar 2021 09:19:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwjsSZ4ENV5TzvDzxudmDp/RCeNOXmwsgKwn6iq6J+laKzDPEeEQWH93dRhwfdmoH+j+Fq9dw==
X-Received: by 2002:a17:906:95d1:: with SMTP id n17mr5091927ejy.394.1614619165188;
        Mon, 01 Mar 2021 09:19:25 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id hq14sm13383803ejc.30.2021.03.01.09.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 09:19:24 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Zdenek Pytela <zpytela@redhat.com>
Subject: [PATCH userspace] fixfiles: do not exclude /dev and /run in -C mode
Date:   Mon,  1 Mar 2021 18:19:22 +0100
Message-Id: <20210301171922.321907-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I can't think of a good reason why they should be excluded. On the
contrary, excluding them can cause trouble very easily if some labeling
rules for these directories change. For example, we changed the label
for /dev/nvme* from nvme_device_t to fixed_disk_device_t in Fedora
(updating the allow rules accordingly) and after policy update they
ended up with an invalid context, causing denials.

Thus, remove /dev and /run from the excludes. While there, also add
/root to the basic excludes to match the regex that excludes fc rules
(that should be effectively no functional change).

I did a sanity check on my system by running `restorecon -nv /dev /run`
and it didn't report any label differences.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policycoreutils/scripts/fixfiles | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index 30dadb4f..6fb12e04 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -162,7 +162,7 @@ newer() {
 #
 diff_filecontext() {
 EXCLUDEDIRS="`exclude_dirs_from_relabelling`"
-for i in /sys /proc /dev /run /mnt /var/tmp /var/lib/BackupPC /home /tmp /dev; do
+for i in /sys /proc /mnt /var/tmp /var/lib/BackupPC /home /root /tmp; do
     [ -e $i ]  && EXCLUDEDIRS="${EXCLUDEDIRS} -e $i";
 done
 LogExcluded
@@ -175,7 +175,7 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
 	sed -r -e 's,:s0, ,g' $FC | sort -u | \
 	/usr/bin/diff -b ${PREFCTEMPFILE} - | \
 	    grep '^[<>]'|cut -c3-| grep ^/ | \
-	    egrep -v '(^/home|^/root|^/tmp|^/dev)' |\
+	    egrep -v '(^/home|^/root|^/tmp)' |\
 	sed -r -e 's,[[:blank:]].*,,g' \
 	       -e 's|\(([/[:alnum:]]+)\)\?|{\1,}|g' \
 	       -e 's|([/[:alnum:]])\?|{\1,}|g' \
-- 
2.29.2

