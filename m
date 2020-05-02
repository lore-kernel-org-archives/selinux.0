Return-Path: <SRS0=/Hxn=6Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516AFC3A5A9
	for <selinux@archiver.kernel.org>; Sat,  2 May 2020 19:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FC5B20735
	for <selinux@archiver.kernel.org>; Sat,  2 May 2020 19:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnvtTbL4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgEBTIi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 2 May 2020 15:08:38 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24587 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728421AbgEBTIi (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 2 May 2020 15:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588446516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Svs4mmN6D/dCtJrkeTs/7qrml5fYCJ3vqNePM0YdYEs=;
        b=AnvtTbL4Bpz8/5LHTDLABBZCIm6a4dICZrx1/SEvsnufL+Xc+OQN96K2qD8OjbDwgzJ8vl
        mdKDyXkrIEYNggS/gYQ9QwrAbgg+AV0l/MHYSrX/C0j15DD44Riw1oMIIgKyUFqf1EgnpR
        EvjY2ylVTxFzukZTYW81SktZp0hMGZg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-L61Ti7gfMgG24OaAmGxhIw-1; Sat, 02 May 2020 15:08:33 -0400
X-MC-Unique: L61Ti7gfMgG24OaAmGxhIw-1
Received: by mail-wm1-f71.google.com with SMTP id n127so1713345wme.4
        for <selinux@vger.kernel.org>; Sat, 02 May 2020 12:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Svs4mmN6D/dCtJrkeTs/7qrml5fYCJ3vqNePM0YdYEs=;
        b=sb6CYHWZuq14Q68A258psszV32GBlTafDCEXb3YlqhHloffmFf7ja5SAto+fvwAGDC
         xycMk/83AMhEDj49FRyBlxaV7MO/ywqVs5VVjLPOfag2AEoTr3GpG/rEKpouHbZ7CskZ
         vhvFc8vj87XRkTB2egEzdqXPT4XZKfZ8jDTP5KeNFq5FTZkX127/Uet3/I+kjcQ5RTQC
         NSf2w5HsP6Rud8wV/sLgysbPsggZTjY0M7D7n+3jJTlXuiNVZ2mWW1Q+QdOe1wpu1rWZ
         1Euw+8vEDWKmRve23ysfTuS/wj9hZiFEZqZqbYJ2Ymd261+yw4FZGxSKfNpmXS6B2zqd
         eB5w==
X-Gm-Message-State: AGi0PubnatJNQBdYPC1IzbQQGDvIXVCekH1QGzMwtGtsRY/wfeLRL0Sy
        Q5vYmUXXZ4lMryCnE7wr3wdljr56pTwdWn3gOIDlP9pGKgtuwuhkB4cCULPIe/1dIHvVfNuwZ2u
        gsX5ICl37b7JvVwlN+g==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr5560136wmj.3.1588446511503;
        Sat, 02 May 2020 12:08:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypLyxQbgCdeg+Gw6gu3s68dgTRIo1Y/O+RS0d05j/MISDhnZ2M014TYrEZzGzHGFOZwIbQT1OQ==
X-Received: by 2002:a7b:cd04:: with SMTP id f4mr5560126wmj.3.1588446511199;
        Sat, 02 May 2020 12:08:31 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id g186sm5514209wme.7.2020.05.02.12.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 12:08:30 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Chris PeBenito <pebenito@ieee.org>
Subject: [PATCH v3 0/2] userspace: Implement new format of filename trans rules
Date:   Sat,  2 May 2020 21:08:26 +0200
Message-Id: <20200502190828.3555858-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These patches are the userspace side of the kernel change posted at [1].

The first patch changes libsepol's internal representation of filename
transition rules in a way similar to kernel commit c3a276111ea2
("selinux: optimize storage of filename transitions") [2].

The second patch then builds upon that and implements reading and
writing of a new binary policy format that uses this representation also
in the data layout.

See individual patches for more details.

NOTE: This series unfortunately breaks the build of setools. Moreover,
when an existing build of setools dynamically links against the new
libsepol, it segfaults. Sadly, there doesn't seem to be a nice way of
handling this, since setools relies on non-public libsepol policydb
API/ABI.

Changes in v3:
 - fixed the change in dispol.c to match the rest of the code
 - renamed the helper functions to use the "_compat" suffix rather than
   "_old" and "_new"

Changes in v2:
 - fixed counting rules when reading the new policy format

[1] https://lore.kernel.org/selinux/20200327151941.95619-1-omosnace@redhat.com/T/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/commit/?id=c3a276111ea2572399281988b3129683e2a6b60b

Ondrej Mosnacek (2):
  libsepol,checkpolicy: optimize storage of filename transitions
  libsepol: implement POLICYDB_VERSION_COMP_FTRANS

 checkpolicy/policy_define.c                |  52 ++--
 checkpolicy/test/dispol.c                  |  20 +-
 libsepol/cil/src/cil_binary.c              |  29 +-
 libsepol/include/sepol/policydb/policydb.h |  18 +-
 libsepol/src/expand.c                      |  60 +---
 libsepol/src/kernel_to_cil.c               |  24 +-
 libsepol/src/kernel_to_conf.c              |  24 +-
 libsepol/src/policydb.c                    | 314 ++++++++++++++++-----
 libsepol/src/write.c                       | 101 +++++--
 9 files changed, 436 insertions(+), 206 deletions(-)

-- 
2.25.4

