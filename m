Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8822FC6FA99
	for <selinux@archiver.kernel.org>; Fri, 10 Mar 2023 16:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjCJQzz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 10 Mar 2023 11:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjCJQza (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 10 Mar 2023 11:55:30 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8010A11AB8E
        for <selinux@vger.kernel.org>; Fri, 10 Mar 2023 08:52:40 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id l18so6412177qtp.1
        for <selinux@vger.kernel.org>; Fri, 10 Mar 2023 08:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678467126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5CMIo1RgTEdXnk8yc5kybo4nqhpNN5CUr8zUX4oK+us=;
        b=lrnDPouMb5r5owfvR5+Zci1LHWbtFnaUNH68UTd37bD0mH4CiHl9GJkHEmwcatrsbI
         7rsNPRPyuz7zCrPQ132uTAk7qfaDuThT+7EYKZs33/kUjYJ0gumsVO5jEHGsYfSO9RUc
         baNj3HeZqK/FGZOG5uG8KbkXtiJPj7Ja1MfaLsSIQg5X46UpP61QSlhbhLpcGIGbuSVY
         VdKzMQz7gpMkJOIVt+j07b7SqU2coUiq62f+BrnEpGp+Z6ULRmRnk0ShPilGdNJ1MQFa
         mck4+FyxAKNfv99egl7Z58RTP62XQzDYS88Q6Plhm5dv3s8vtuEIbFazu4AArpBGCElj
         ZXbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678467126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5CMIo1RgTEdXnk8yc5kybo4nqhpNN5CUr8zUX4oK+us=;
        b=V3AlCsFKuRSrPew9Y7BzysWYOeI/sUfHmhETGVekm+upSXXtErVP8A13XnGd3/O0Dh
         I3y0B1ilTPNoKQnTTfh9FcFWolg4cyspQ8Cx888cXitdWMwLvmaPqEbATTB0jifhtwpe
         LOd8HQWyZar/RCWOUplDAjICjnw3lokwxqCUsTYZX5JBtzDPGvAT9fQO0f82FjIyOk8m
         IXgHV6uDjdLBEjSHE+XDfMbTptI+3CdoGXcU4JWk8Pt0iBvSahs43Vn5cs6rtELPqBdi
         GlrMp9rSEytx17nanPNcIVzeCRSTfoygoXX/jhm2VLb/gl94Bw9o5bYFLAoA0z8K/hEc
         FV7Q==
X-Gm-Message-State: AO0yUKVGzJP/okxBf7NUaN1DzTeO4JxuUHweyZY4ZTg6SDKh2aa64INz
        vdsK6jOesLWiN/ybZMR0+ut1k37e0IQ=
X-Google-Smtp-Source: AK7set+ZtRyBeClUYKA2Xa4ydu4UwS4VprkDbAJFdwWZURRWJnE1KAtn4u9dU0s7gxKKGHoXkY8yig==
X-Received: by 2002:a05:622a:1a1c:b0:3bf:e034:5f53 with SMTP id f28-20020a05622a1a1c00b003bfe0345f53mr43604476qtb.59.1678467125909;
        Fri, 10 Mar 2023 08:52:05 -0800 (PST)
Received: from a-gady2p56i3do.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id v24-20020a05622a189800b003bfb0ea8094sm113403qtc.83.2023.03.10.08.52.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Mar 2023 08:52:05 -0800 (PST)
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
To:     selinux@vger.kernel.org
Cc:     paul@paul-moore.com, omosnace@redhat.com,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH testsuite] defconfig: add FAT and GRE config options
Date:   Fri, 10 Mar 2023 11:50:51 -0500
Message-Id: <20230310165050.27749-1-stephen.smalley.work@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These are required for some of the fat filesystem and sctp tests to run.

Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
---
 defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/defconfig b/defconfig
index ca7a877..2783c01 100644
--- a/defconfig
+++ b/defconfig
@@ -42,6 +42,13 @@ CONFIG_IP_SCTP=m
 CONFIG_BT=m
 CONFIG_CRYPTO_USER_API=m
 
+# Network protocol implementations.
+# These are enabled to run sctp ASCONF tests using a GRE tunnel
+CONFIG_NET_IPGRE_DEMUX=m
+CONFIG_NET_IPGRE=m
+CONFIG_NET_IPGRE_BROADCAST=y
+CONFIG_IPV6_GRE=m
+
 # Netlink protocol implementations.
 # These are enabled to test the netlink socket controls in
 # tests/netlink_socket; they are not required for SELinux operation itself.
@@ -112,6 +119,7 @@ CONFIG_NFSD_V4_SECURITY_LABEL=y
 CONFIG_XFS_FS=m
 CONFIG_XFS_QUOTA=y
 CONFIG_VFAT_FS=m
+CONFIG_FAT_DEFAULT_IOCHARSET="ascii"
 
 # watch_queue for key changes.
 # They are not required for SELinux operation itself.
-- 
2.39.2

