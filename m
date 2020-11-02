Return-Path: <SRS0=BHhV=EI=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D17C2D0A3
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 11:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A844206F9
	for <selinux@archiver.kernel.org>; Mon,  2 Nov 2020 11:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LT74WL2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbgKBLCb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 2 Nov 2020 06:02:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48379 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728288AbgKBLCa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 2 Nov 2020 06:02:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604314949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2qNwmmZLCw70aQnzqrHWn/gIMP0HAenguTc+7gRoGbk=;
        b=LT74WL2BcbmJfAPQdjukDIwrRhmEFBCFSb8lqVPVbs3Z2fF/OR9UtBtOllwsX7fPv7pSoA
        GZv93YOR5cCBWA4XuLhSHJQqZoCi+uyA1rubM2b46LhO6LF4Qws4aSI320p51Wf9OjsG7u
        83SU80Gx+sDeAzHx4D/N55bQHl+cMsw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-U5qgQeZXOnyrbwXRGphGQw-1; Mon, 02 Nov 2020 06:02:27 -0500
X-MC-Unique: U5qgQeZXOnyrbwXRGphGQw-1
Received: by mail-ed1-f71.google.com with SMTP id h6so5965085edt.12
        for <selinux@vger.kernel.org>; Mon, 02 Nov 2020 03:02:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2qNwmmZLCw70aQnzqrHWn/gIMP0HAenguTc+7gRoGbk=;
        b=SefRQUo0CpkJo/874EgdCUOSU015/YSEzjDHtP6mDBlf4yHMEiof9U9Cjy9sy/T8ff
         UMnsqq/2J/fGuVzIfiDGpA71+UX7blbqUmvIYmQwXzYT+CY/rrcCLngJnpP1gY8Ql0K8
         /3N1HxdIfj/EVyOm5LeSBrchX52WfJixm7IwX57JCULhoMbArtp1Sh4BgmaruLy4FhyN
         O50xoGHYd4zBkukEvSQlpxlFD3Gg+rjwl6OqAy85WNglo82iIYjKeVtAeC9sstcuF0JR
         1aidA4C0K7BfqH0Gq70rzjZUcp+TBcPtoJgMcrH74X6SaH3pn5eEw8kNusAVlgzR/jvj
         ZNug==
X-Gm-Message-State: AOAM531znop9ASNKEIgoi8Z5Q971Gm65XOnZQqEEOFE9uWT9d1OqjTe3
        YJLtbic/8n4+WqY18YR/vFbf3WSUZ/ic2n7t15aHnjAcNFbqY2Gvcz7vOZkPfiAvrkOeLIglJqE
        EDFl8SrBe5oOOczogXA==
X-Received: by 2002:aa7:cb8f:: with SMTP id r15mr16129802edt.356.1604314945722;
        Mon, 02 Nov 2020 03:02:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQGrlhyoydhEecwbDy02CX28iDNAIWv1tipKOcuPSKXMW2H80ocF8HXrFlBigBrsoFvU878A==
X-Received: by 2002:aa7:cb8f:: with SMTP id r15mr16129789edt.356.1604314945530;
        Mon, 02 Nov 2020 03:02:25 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b103:4000:9293:f330:b535:b530])
        by smtp.gmail.com with ESMTPSA id j8sm7999803edk.79.2020.11.02.03.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 03:02:24 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     William Roberts <bill.c.roberts@gmail.com>
Subject: [PATCH testsuite] travis: handle the case of multiple rawhide images
Date:   Mon,  2 Nov 2020 12:02:23 +0100
Message-Id: <20201102110223.493899-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

For whatever reason, some mirrors contain more than one image version in
the directory, causing the test to bail out. This happens only sometimes
and restarting the Travis job usually helps, but it's better to adapt
the script to handle this case.

Tweak the script to pick the lexicographically last image and exit with
error only if there is no image at all.

Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 travis-ci/run-kvm-test.sh | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/travis-ci/run-kvm-test.sh b/travis-ci/run-kvm-test.sh
index 6afbf96..bb7c3b7 100755
--- a/travis-ci/run-kvm-test.sh
+++ b/travis-ci/run-kvm-test.sh
@@ -36,8 +36,9 @@ VCPUS="$(nproc)"
 #  - https://alt.fedoraproject.org/en/verify.html
 cd "$HOME"
 wget -r -nd -np -l 1 -H -e robots=off -A "*.raw.xz,*-CHECKSUM" "$BASE_URL"
-if [ $(ls -1q *.raw.xz | wc -l) -ne 1 ]; then
-    echo "$0: too many image files downloaded!" 1>&2
+latest_image="$(ls -1q *.raw.xz | tail -n 1)"
+if [ -z "$latest_image" ]; then
+    echo "$0: no image file downloaded!" 1>&2
     exit 1
 fi
 
@@ -49,7 +50,8 @@ fi
 sha256sum --ignore-missing -c ./*-CHECKSUM
 
 # Extract the image
-unxz -T0 *.raw.xz
+unxz -T0 "$latest_image"
+latest_image="${latest_image%.xz}"
 
 # Search is needed for $HOME so virt service can access the image file.
 chmod a+x "$HOME"
@@ -60,7 +62,7 @@ chmod a+x "$HOME"
 #   - Enable passwordless login
 #     - Force a relabel to fix labels on ssh keys
 #
-sudo virt-sysprep -a *.raw \
+sudo virt-sysprep -a "$latest_image" \
   --root-password password:123456 \
   --hostname fedoravm \
   --append-line '/etc/ssh/sshd_config:PermitRootLogin yes' \
@@ -81,7 +83,7 @@ sudo virt-install \
   --name fedoravm \
   --memory $MEMORY \
   --vcpus $VCPUS \
-  --disk *.raw \
+  --disk "$latest_image" \
   --import --noautoconsole
 
 #
-- 
2.26.2

