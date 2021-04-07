Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7BFC433B4
	for <selinux@archiver.kernel.org>; Wed,  7 Apr 2021 10:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5550B6113C
	for <selinux@archiver.kernel.org>; Wed,  7 Apr 2021 10:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234398AbhDGKNU (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 7 Apr 2021 06:13:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22108 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235742AbhDGKNN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 7 Apr 2021 06:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617790383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eAqUJ+8mVii63WcNIFF6VMlfZQy9U/wnrFEGQB7i3Ag=;
        b=ZE6yMI4PwnivveHgLu1FyTDlE3HvibwxO+Srs6EUO4oqDnK+/2yvgV/f6a955te1VUgK1t
        LV8+GjbAQMasMFGhms8D3yNtF0IOETJFWkT/h3ALQaaFsvxnNMvlTtFMjBuXuMHKTdZNk9
        W8jTnhWFoZKunmbu1QdZpemAF1cJCUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-BXZVUa8ZNdGKeenpJyl1fQ-1; Wed, 07 Apr 2021 06:13:01 -0400
X-MC-Unique: BXZVUa8ZNdGKeenpJyl1fQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFE5818BA281
        for <selinux@vger.kernel.org>; Wed,  7 Apr 2021 10:13:00 +0000 (UTC)
Received: from thinkpad-work.redhat.com (unknown [10.40.194.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4288B7092D
        for <selinux@vger.kernel.org>; Wed,  7 Apr 2021 10:13:00 +0000 (UTC)
From:   Vit Mojzis <vmojzis@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH v2 2/4] [DO NOT MERGE] Install selinux-policy-devel in test environment
Date:   Wed,  7 Apr 2021 12:12:43 +0200
Message-Id: <20210407101245.276527-2-vmojzis@redhat.com>
In-Reply-To: <20210407101245.276527-1-vmojzis@redhat.com>
References: <CAEg-Je-mAOJc53LyMrmcHfgKAvaQm2-jYWKizCAjLW=15_XF3g@mail.gmail.com>
 <20210407101245.276527-1-vmojzis@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Temporary commit for testing purposes.
The change needs to be done in
https://gitlab.com/libvirt/libvirt-ci/-/blob/master/guests/lcitool/lcitool/ansible/vars/projects/libvirt.yml

Signed-off-by: Vit Mojzis <vmojzis@redhat.com>
---
 ci/containers/ci-centos-8.Dockerfile                     | 1 +
 ci/containers/ci-centos-stream.Dockerfile                | 1 +
 ci/containers/ci-fedora-32.Dockerfile                    | 1 +
 ci/containers/ci-fedora-33.Dockerfile                    | 1 +
 ci/containers/ci-fedora-rawhide-cross-mingw32.Dockerfile | 1 +
 ci/containers/ci-fedora-rawhide-cross-mingw64.Dockerfile | 1 +
 ci/containers/ci-fedora-rawhide.Dockerfile               | 1 +
 7 files changed, 7 insertions(+)

diff --git a/ci/containers/ci-centos-8.Dockerfile b/ci/containers/ci-centos-8.Dockerfile
index e600598329..7d6cbafe6b 100644
--- a/ci/containers/ci-centos-8.Dockerfile
+++ b/ci/containers/ci-centos-8.Dockerfile
@@ -84,6 +84,7 @@ RUN dnf update -y && \
         rpm-build \
         sanlock-devel \
         scrub \
+        selinux-policy-devel \
         systemtap-sdt-devel \
         wireshark-devel \
         xfsprogs-devel \
diff --git a/ci/containers/ci-centos-stream.Dockerfile b/ci/containers/ci-centos-stream.Dockerfile
index 2b51eccc8d..b4d02f4148 100644
--- a/ci/containers/ci-centos-stream.Dockerfile
+++ b/ci/containers/ci-centos-stream.Dockerfile
@@ -86,6 +86,7 @@ RUN dnf install -y centos-release-stream && \
         rpm-build \
         sanlock-devel \
         scrub \
+        selinux-policy-devel \
         systemtap-sdt-devel \
         wireshark-devel \
         xfsprogs-devel \
diff --git a/ci/containers/ci-fedora-32.Dockerfile b/ci/containers/ci-fedora-32.Dockerfile
index 71d391b7bd..3b9d98c83f 100644
--- a/ci/containers/ci-fedora-32.Dockerfile
+++ b/ci/containers/ci-fedora-32.Dockerfile
@@ -89,6 +89,7 @@ exec "$@"' > /usr/bin/nosync && \
         rpm-build \
         sanlock-devel \
         scrub \
+        selinux-policy-devel \
         sheepdog \
         systemtap-sdt-devel \
         wireshark-devel \
diff --git a/ci/containers/ci-fedora-33.Dockerfile b/ci/containers/ci-fedora-33.Dockerfile
index 5fb30380b0..c8b4dcca34 100644
--- a/ci/containers/ci-fedora-33.Dockerfile
+++ b/ci/containers/ci-fedora-33.Dockerfile
@@ -89,6 +89,7 @@ exec "$@"' > /usr/bin/nosync && \
         rpm-build \
         sanlock-devel \
         scrub \
+        selinux-policy-devel \
         sheepdog \
         systemtap-sdt-devel \
         wireshark-devel \
diff --git a/ci/containers/ci-fedora-rawhide-cross-mingw32.Dockerfile b/ci/containers/ci-fedora-rawhide-cross-mingw32.Dockerfile
index c718778acb..55825c9753 100644
--- a/ci/containers/ci-fedora-rawhide-cross-mingw32.Dockerfile
+++ b/ci/containers/ci-fedora-rawhide-cross-mingw32.Dockerfile
@@ -55,6 +55,7 @@ exec "$@"' > /usr/bin/nosync && \
         rpcgen \
         rpm-build \
         scrub \
+        selinux-policy-devel \
         sheepdog \
         zfs-fuse && \
     nosync dnf autoremove -y && \
diff --git a/ci/containers/ci-fedora-rawhide-cross-mingw64.Dockerfile b/ci/containers/ci-fedora-rawhide-cross-mingw64.Dockerfile
index 6058d0c0b2..69159a7e3c 100644
--- a/ci/containers/ci-fedora-rawhide-cross-mingw64.Dockerfile
+++ b/ci/containers/ci-fedora-rawhide-cross-mingw64.Dockerfile
@@ -55,6 +55,7 @@ exec "$@"' > /usr/bin/nosync && \
         rpcgen \
         rpm-build \
         scrub \
+        selinux-policy-devel \
         sheepdog \
         zfs-fuse && \
     nosync dnf autoremove -y && \
diff --git a/ci/containers/ci-fedora-rawhide.Dockerfile b/ci/containers/ci-fedora-rawhide.Dockerfile
index 027e8a7c41..edd9c34c46 100644
--- a/ci/containers/ci-fedora-rawhide.Dockerfile
+++ b/ci/containers/ci-fedora-rawhide.Dockerfile
@@ -90,6 +90,7 @@ exec "$@"' > /usr/bin/nosync && \
         rpm-build \
         sanlock-devel \
         scrub \
+        selinux-policy-devel \
         sheepdog \
         systemtap-sdt-devel \
         wireshark-devel \
-- 
2.30.2

