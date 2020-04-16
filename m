Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3327C2BB55
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 12:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCCE421D7E
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 12:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/aQmIIM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635883AbgDPMlX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:41:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29678 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2635842AbgDPMlS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 08:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587040877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cflvX5wUPBLiKT76h5Lj+rVYjaLj3yqBfFl26Fa2eJY=;
        b=R/aQmIIM6qmmkm86JIB+UNKO1lg53xnkeBP7QxCW45Yu2hGfS8C+lPoYrjxW7dWphf4Mho
        xuEu/2aSAbOPfsHBJ6ZHULBzlvh24s8rcL3XCpGeJ4Tjsy0C/eMfi21gvm2l36gQ7b3w69
        QOgTuOGFnYvfVulggYst3FkbKqPD+hU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-oRIn_dbwMke9F6qciN-XyA-1; Thu, 16 Apr 2020 08:41:15 -0400
X-MC-Unique: oRIn_dbwMke9F6qciN-XyA-1
Received: by mail-wm1-f72.google.com with SMTP id t62so1368456wma.0
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 05:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cflvX5wUPBLiKT76h5Lj+rVYjaLj3yqBfFl26Fa2eJY=;
        b=B3bmuvpnNrviAJ5V+xG42icVuvCVRCqT8kgPVyCmyhdY30Bi4HqKIMpidBomqG/i6s
         ONcdCuy5YNT53CQApq4v7AOyQNp/cpzBWGpj8dEsdJVwk3jw4a38UOers2Zw/xzFwXqy
         dNgz3fHAJzXMcdm2EkknqMhE3DkeQB7D/484T8ow228N6NNTNxOJrDUs2DyHaBnvfETS
         z3JN+ZPWWeOw24vAnb2Cc+d1jOg0mpiw0yOIgAS4zSTq0krZ7ZyTq4RMKOBbjUx5vzuX
         m8DbzAT51PrusRJbbyIdvHmvPSQqrxtYSm2XDjdoAD3PYh5kkMzHpv3w+Bay6+C8ZEMJ
         Rgbw==
X-Gm-Message-State: AGi0PuaZWy9l2DJ8dYzNfR4R5wFASDLaGcvhzZclGkoIAk+tG0XKLcfv
        V+zrmwOJjuZw1FFgwxzrba3jcwbTgBv6bMfaC+OOz/wQwH0FSO5FtRHEDAdqNqD0Z3rPSiN5RAV
        ILAGi13nM9OkXsM0T0A==
X-Received: by 2002:a5d:49d2:: with SMTP id t18mr17522875wrs.85.1587040874256;
        Thu, 16 Apr 2020 05:41:14 -0700 (PDT)
X-Google-Smtp-Source: APiQypKyPiEJNhANU28OzIgS5KF4o0e0jJcGv5a00uiYG21rKXYokYLITYoNBDL/Xb4q9y67+nZljg==
X-Received: by 2002:a5d:49d2:: with SMTP id t18mr17522861wrs.85.1587040874051;
        Thu, 16 Apr 2020 05:41:14 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id w6sm24059333wrm.86.2020.04.16.05.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 05:41:13 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Jeff Vander Stoep <jeffv@google.com>
Subject: [PATCH v2 0/2] Hash context structures directly
Date:   Thu, 16 Apr 2020 14:41:08 +0200
Message-Id: <20200416124110.541408-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Converting a valid context to string and hashing that is inefficient
because the conversion is slow. Instead we can hash the stucture
contents directly, which is about 10 times faster.

After that, it is possible to move the hashing under sidtab.c, which
avoids the complexity of calling context_add_hash() all over the place.

Changes in v2:
 - fix copyright year in ss/context.c
 - extract mls hashing into mls_range_hash() and put it in mls.h
 - move some changes from patch 1 into patch 2

Ondrej Mosnacek (2):
  selinux: hash context structure directly
  selinux: move context hashing under sidtab

 security/selinux/Makefile      |  2 +-
 security/selinux/ss/context.c  | 24 ++++++++++
 security/selinux/ss/context.h  | 11 +----
 security/selinux/ss/ebitmap.c  | 14 ++++++
 security/selinux/ss/ebitmap.h  |  1 +
 security/selinux/ss/mls.h      | 11 +++++
 security/selinux/ss/policydb.c |  5 --
 security/selinux/ss/services.c | 86 ++++++++++------------------------
 security/selinux/ss/services.h |  3 --
 security/selinux/ss/sidtab.c   | 32 ++++++++-----
 security/selinux/ss/sidtab.h   |  1 +
 11 files changed, 99 insertions(+), 91 deletions(-)
 create mode 100644 security/selinux/ss/context.c

-- 
2.25.2

