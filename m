Return-Path: <SRS0=oQIx=32=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775F5C2D0B1
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 13:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F17214AF
	for <selinux@archiver.kernel.org>; Thu,  6 Feb 2020 13:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iPrrL0i3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgBFNNB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 6 Feb 2020 08:13:01 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41459 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726538AbgBFNNB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 6 Feb 2020 08:13:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580994780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nRLrtl7kP5tt1qfowniJ8zJJVzzgBoJTAq2ZwXthv1A=;
        b=iPrrL0i3O4EFD6hsFUV4Tym1okIGN9WNl0DBgyWTUb5Ud4SFmjpW4RL28I9uC8LV21SjL4
        EWNoi95p/P01wipnPZ6KG6HsBmv5eq8ZjLEXeE1YNC0du7cPY0HwtA0NG32+FSz/vpbCSN
        FRDWZfIU3eOPOmQi9XPckhHikF1oyes=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-9sgLk_1yN5C9en1vNLy0bg-1; Thu, 06 Feb 2020 08:12:57 -0500
X-MC-Unique: 9sgLk_1yN5C9en1vNLy0bg-1
Received: by mail-wr1-f72.google.com with SMTP id d15so3368288wru.1
        for <selinux@vger.kernel.org>; Thu, 06 Feb 2020 05:12:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nRLrtl7kP5tt1qfowniJ8zJJVzzgBoJTAq2ZwXthv1A=;
        b=QFsqa05EPVzDmwg4QWI/tlIT8PX2ieZ+IejGq4Jixkmm6+ieN35i33BEltVz5mH6E4
         SjAHOLXXf1RcS6D8VpEuV8uHwoHb5s/07YD1/axU6yOB8ItWvg6H35tfNyUMfv/8Zr+F
         MtB4czp3YiqSNpnOSn+o81fLswryzek9YxwJG7T4ktrNLY4+O8A9nRAJkxEKFped6LfQ
         o+8cPyKG9pNAyZjfm7/+6zjtudIIOSynrj/DK2+0o3ClDexR6hUIbdXfV0ItF1qgcbCc
         cOK+O4LYMF5tss6G8Ss3IP2pANui3JLtVe8awk/EI/ZrTA//ElWj8xoYcKtkSSRwxBJM
         mmZQ==
X-Gm-Message-State: APjAAAV5R2nbrtl4fkthAeb5w1RILG5Ocvex0awLIJUge17JJGazY1LP
        bMPhrXKVM1lqqISaYQBEQl2+5eMEC6VG2ygYTcY30ever9OZITcMhLXoFQDG1cXri+vp94CV2UD
        ZRt/LYOuHXWhdl31K2A==
X-Received: by 2002:a5d:5386:: with SMTP id d6mr3723830wrv.253.1580994775626;
        Thu, 06 Feb 2020 05:12:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqzHdrMabIiOhVKBGahqS41QnEPDw9aun5hBkC4o+mMpKSknYGrUVWcaWg6st8Ya5gc4VUu6qw==
X-Received: by 2002:a5d:5386:: with SMTP id d6mr3723815wrv.253.1580994775418;
        Thu, 06 Feb 2020 05:12:55 -0800 (PST)
Received: from omos.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h13sm4506472wrw.54.2020.02.06.05.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 05:12:54 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Petr Lautrbach <plautrba@redhat.com>
Subject: [RFC PATCH 0/2] userspace: Allow changing version of kernel policy built by semodule
Date:   Thu,  6 Feb 2020 14:12:51 +0100
Message-Id: <20200206131253.535302-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

See the second patch for motivation.

Passed Travis: https://travis-ci.org/WOnder93/selinux/builds/646845127

Ondrej Mosnacek (2):
  libsemanage: support changing policy version via API
  semodule: support changing policyvers via command line

 libsemanage/include/semanage/handle.h |  6 +++
 libsemanage/src/direct_api.c          |  9 ++++-
 libsemanage/src/handle.c              | 24 ++++++++++++
 libsemanage/src/handle.h              |  1 +
 libsemanage/src/libsemanage.map       |  6 +++
 libsemanage/src/semanage_store.c      | 54 ++++++++++++++++-----------
 libsemanage/src/semanage_store.h      |  6 ++-
 policycoreutils/semodule/semodule.8   |  3 ++
 policycoreutils/semodule/semodule.c   | 12 +++++-
 9 files changed, 95 insertions(+), 26 deletions(-)

-- 
2.24.1

