Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680E0C6FA82
	for <selinux@archiver.kernel.org>; Mon, 19 Sep 2022 11:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiISL3T (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Sep 2022 07:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiISL3S (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Sep 2022 07:29:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 922BB1EAE0
        for <selinux@vger.kernel.org>; Mon, 19 Sep 2022 04:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663586956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7bgwln70bzwsj6XAuInyYwybIaejtq6319SopLYosFw=;
        b=OQO2wFSGfbkZk+Lk6Pvs0KO5Vx5i6pRpcttW8ir0Do6JYm5XD8h7XPo7aHxturR8Tb/yU0
        jCTKrWgXVAP464n9vH8I/7XorbzseKUncMlQftJ2Fy+vqZZpXswm8fuRTv/Z9Erd0P0bW9
        1S8FDh0bimyg6Ryf9va4v0LTlxJSOLE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-425-U1-RVZ4cPICjBjVxH8mhrA-1; Mon, 19 Sep 2022 07:29:05 -0400
X-MC-Unique: U1-RVZ4cPICjBjVxH8mhrA-1
Received: by mail-ej1-f72.google.com with SMTP id ne4-20020a1709077b8400b0078114a1a6d8so771797ejc.9
        for <selinux@vger.kernel.org>; Mon, 19 Sep 2022 04:29:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=7bgwln70bzwsj6XAuInyYwybIaejtq6319SopLYosFw=;
        b=IXt2pkNsVfGVaHTXAS+TxIBnv2j0zFewOjxjuJPzAqNsVdqlUnSq06EhdG4y+I9ez2
         WEnw/LwRCKyfEPiJZetCY5XA9Ac8Wk6m3K3QvRY/uZB8BWvj84dPWA34rsNQzvJCmeOD
         qORupsWCSocDU88gZq8pJOAiPu58C6/ZVECppqbAi7ISBdrug3R8BlFfuaZj0t5+njQQ
         vsLFqqNGyhAzyz+HjZhTqQ83zW3g0s87NR6/ZcqGI3hJ+M0dklRrnraRDMpHNBuTbSn1
         iEkf4sxNON7Yc1IROpChoPcimfNS4hPfLUon91/LAxT0PR8DQUMBLkQFz5JnFiajKhEg
         GUiQ==
X-Gm-Message-State: ACrzQf3X9V/zW5nyCsI4Z0oFzNO7ZVnFlJ2OP8l2o5DIREpsZJHQNS08
        UEYtpzPeNZoDus1a+WhQ1tUUO+203nsswxEpZ1P6l9JB/1YknGu7zp66y2Q3MCLxVsgpZyLuh8N
        mSPlg++3OLXyJsGTd5n5hiux6IsEp5Mniz4fjxYWnJOLq4gpkgi0wYXLow3ENx0yWZS+KEA==
X-Received: by 2002:a17:906:8a66:b0:781:714a:1f2a with SMTP id hy6-20020a1709068a6600b00781714a1f2amr1571937ejc.205.1663586943702;
        Mon, 19 Sep 2022 04:29:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7uh35K1eVBW2Yu/yGJes1WWJkvWJaqAr/JALFIBfvTQQQ6u74q77xQjOsUwECr63lRmQMiyw==
X-Received: by 2002:a17:906:8a66:b0:781:714a:1f2a with SMTP id hy6-20020a1709068a6600b00781714a1f2amr1571922ejc.205.1663586943386;
        Mon, 19 Sep 2022 04:29:03 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id u18-20020a1709061db200b007712444e98csm15453836ejh.43.2022.09.19.04.29.02
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 04:29:02 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH userspace] fixfiles: do not cross mounts when traversing directories
Date:   Mon, 19 Sep 2022 13:29:01 +0200
Message-Id: <20220919112901.1127409-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Always run find with -xdev to avoid unintended deleting/relabeling.
While this may sometimes skip subdirectories that should be relabeled,
the danger of crossing into random mounts is greater than leaving behind
some unlabeled files. The find commands are just best-effort attempts to
fix the labels anyway.

In case of /run (renamed from the deprecated /var/run), traverse
/run/user/* directories separately, as there is commonly an additional
layer of tmpfs mounted on them.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 policycoreutils/scripts/fixfiles | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
index c72ca0eb..c9ab2a93 100755
--- a/policycoreutils/scripts/fixfiles
+++ b/policycoreutils/scripts/fixfiles
@@ -153,7 +153,7 @@ newer() {
     shift
     LogReadOnly
     for m in `echo $FILESYSTEMSRW`; do
-	find $m -mount -newermt $DATE -print0 2>/dev/null | ${RESTORECON} ${FORCEFLAG} ${VERBOSE} ${THREADS} $* -i -0 -f -
+	find $m -xdev -newermt $DATE -print0 2>/dev/null | ${RESTORECON} ${FORCEFLAG} ${VERBOSE} ${THREADS} $* -i -0 -f -
     done;
 }
 
@@ -273,18 +273,22 @@ case "$RESTORE_MODE" in
 
 	UNDEFINED=`get_undefined_type` || exit $?
 	UNLABELED=`get_unlabeled_type` || exit $?
-	find /tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) \( -type s -o -type p \) -delete
-	find /tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /tmp {} \;
-	find /var/tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /var/tmp {} \;
-	find /var/run \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /var/run {} \;
-	[ ! -e /var/lib/debug ] || find /var/lib/debug \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /lib {} \;
+	find -xdev /tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) \( -type s -o -type p \) -delete
+	find -xdev /tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /tmp {} \;
+	find -xdev /var/tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /var/tmp {} \;
+	find -xdev /run \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /run {} \;
+	# /run/user/<pid> may have an additional tmpfs mounted on it
+	for userdir in /run/user/*; do
+		find -xdev "$userdir" \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference "$userdir" {} \;
+	done
+	[ ! -e /var/lib/debug ] || find -xdev /var/lib/debug \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /lib {} \;
     ;;
 esac
 }
 
 fullrelabel() {
     echo "Cleaning out /tmp"
-    find /tmp/ -mindepth 1 -delete
+    find -xdev /tmp/ -mindepth 1 -delete
     restore Relabel
 }
 
-- 
2.37.3

