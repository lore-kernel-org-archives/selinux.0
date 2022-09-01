Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D43EECAAD8
	for <selinux@archiver.kernel.org>; Thu,  1 Sep 2022 15:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiIAP1A (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Sep 2022 11:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234216AbiIAP0n (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Sep 2022 11:26:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC04974E26
        for <selinux@vger.kernel.org>; Thu,  1 Sep 2022 08:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662045996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=kGC9RvLszX/F52Fly+GHqDOOZPC038OUoGyy20N2fe8=;
        b=F/GvseEq137pZJHZQ7hgUdLt9b3DLURYAa2xAVuvTr+40eODQKQW/W561A+1rPp+5BRpS6
        oFcAV/81cdxm8ENb6Bum0HtIK2QplkeiUsFZUfDPXPwMFLHadw17U2ymGLtPsoCDXCxpbi
        mvxfcFLd3bSosAhZF+HhbH/XXYAI/e0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-637-b2Vj1y-aPXe8VpaeV3QsBA-1; Thu, 01 Sep 2022 11:26:35 -0400
X-MC-Unique: b2Vj1y-aPXe8VpaeV3QsBA-1
Received: by mail-ed1-f69.google.com with SMTP id m15-20020a056402430f00b00448af09b674so6584128edc.13
        for <selinux@vger.kernel.org>; Thu, 01 Sep 2022 08:26:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=kGC9RvLszX/F52Fly+GHqDOOZPC038OUoGyy20N2fe8=;
        b=Yo8fmhE1HPSk/v+HDxS0mPQ77h80jwKw7ITLah6kApruQHU/JPFUm+EIbDv7GpkKbM
         Uw+TZZ1THnChTIkfakYQJSj8UmH017FgESE7/LlFDFMkmFVH/gm/Kh6UiIFvW6Gt1k8N
         jwRqiv5hfc3vZ1rAi1E2Q8uNoBMNphbKHtWrpIY3ual04grYif3QQ8HqvBDSo054ke0o
         Wfkzji6Bc3BOrbI+cE08ZlcbfIJO6PcJnSa4uYURVp77I22zBYCfSd/HbEaGjTDIIcD8
         tOUREm81ee52WwjKtIqwx/4SGLqtNyBgGDq4CqBWAes0zHjoOW3C2tFixY/BTdydr2nb
         dpAg==
X-Gm-Message-State: ACgBeo3oTD1JAId1OdVhd8q4KCbiGEMLDhUIUkX+Yl8UReHl1ZKwow9C
        HCl2GGQOI92o5BctUSOmlSJkqqtkhBoOOWbWUav2N/kix337zXTNMJl1vbVLnbZEsbKDTtcjHat
        b3sZj9+wqPF7G1iD1NQ==
X-Received: by 2002:a17:907:2716:b0:73d:cdf9:b08a with SMTP id w22-20020a170907271600b0073dcdf9b08amr23273240ejk.463.1662045994399;
        Thu, 01 Sep 2022 08:26:34 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4QRSL2W4ltgrQ+2jhvMhXxgK8EO5Y0yo9Y0cYkz7dkRoZMMOmRYstqqGCjd+xE8U5lttpmRQ==
X-Received: by 2002:a17:907:2716:b0:73d:cdf9:b08a with SMTP id w22-20020a170907271600b0073dcdf9b08amr23273233ejk.463.1662045994222;
        Thu, 01 Sep 2022 08:26:34 -0700 (PDT)
Received: from localhost.localdomain (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o23-20020a170906775700b00730bfe6adc4sm8646031ejn.37.2022.09.01.08.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:26:33 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        Martin Pitt <mpitt@redhat.com>
Subject: [PATCH 0/2] fs: fix capable() call in simple_xattr_list()
Date:   Thu,  1 Sep 2022 17:26:30 +0200
Message-Id: <20220901152632.970018-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

The goal of these patches is to avoid calling capable() unconditionally
in simple_xattr_list(), which causes issues under SELinux (see
explanation in the second patch).

The first patch tries to make this change safer by converting
simple_xattrs to use the RCU mechanism, so that capable() is not called
while the xattrs->lock is held. I didn't find evidence that this is an
issue in the current code, but it can't hurt to make that change
either way (and it was quite straightforward).

Ondrej Mosnacek (2):
  fs: convert simple_xattrs to RCU list
  fs: don't call capable() prematurely in simple_xattr_list()

 fs/xattr.c            | 39 +++++++++++++++++++++++----------------
 include/linux/xattr.h |  1 +
 2 files changed, 24 insertions(+), 16 deletions(-)

-- 
2.37.2

