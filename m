Return-Path: <SRS0=0Nxr=BK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B23C433DF
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 11:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DD9F22B40
	for <selinux@archiver.kernel.org>; Fri, 31 Jul 2020 11:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XxwOKj/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732104AbgGaLKu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 31 Jul 2020 07:10:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50863 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732257AbgGaLKu (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 31 Jul 2020 07:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596193849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=w/7qyBPzP+cop/coSvjIi7GLTjFHE1KM7nl9jtrLJAc=;
        b=XxwOKj/qJ8XEtIECVyJPOUygZP6FvBh3mD6gVfKaMcrskEmymwY8gw9KQ9ZTkWJIQUxIvm
        z24i5oCAPGiLBs4H/6R3lFHktKNMRLalx1VDOsmePLBp1PDrg/AB0fuPNannLv3B0UV0Sn
        1MtgJcL/zGONj8MiyqmBFxOorH2UErI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-ewXYRxeuNiC0-ZIhNQDhVQ-1; Fri, 31 Jul 2020 07:10:45 -0400
X-MC-Unique: ewXYRxeuNiC0-ZIhNQDhVQ-1
Received: by mail-ed1-f71.google.com with SMTP id dd25so5830566edb.6
        for <selinux@vger.kernel.org>; Fri, 31 Jul 2020 04:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w/7qyBPzP+cop/coSvjIi7GLTjFHE1KM7nl9jtrLJAc=;
        b=AdW0aYGZsoXmSRyRB8RJ6Rpfq9vpmijW0xwdo2uuNCIKmotuZzZSV+pZTHNIKr5DBv
         xlqwv4lt3eZrN8VYPio99u9ED2u7QLlx896WCqxE6ni7yDHwBV04S2WcHS9R2hUkrwz9
         VrzGvd8abBXBBReD15vXB4ZqHibZ7aoRLpZw8U2AeZtsEl0sVaaoF0kQAdCnYa3HQl8m
         A2WoLQQImWb3Klic6rzIPJh8ik6RDFHIlR6J7GvqjIFzpIM8AGckJwmSGczhdSzrxjBc
         5MYK5rrUi3mZ8ESYJnimYmHQ/Ul3sVIt/+r/oZyxPLTwNCAnW5qekBHy82kL3ygWrHN4
         AFMA==
X-Gm-Message-State: AOAM532APOQmeeSXAjTrZe4CqklvXQCTrsGyobPsnpyu7U7okimn6qns
        M9z42sT14HXaJpxgSrXV0j4P1bclFBKB+D//VZdqch5NQhiDI7WC6ZPc21TdKUYFJ/UmrSNkDnb
        U8OptJhlq1kQtAXxq7A==
X-Received: by 2002:a17:906:aed0:: with SMTP id me16mr3455488ejb.288.1596193843764;
        Fri, 31 Jul 2020 04:10:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxlQ1DKKZyLaEguNREtXgrOvHdpmRshS4Ri9XopU3Vyq9i0HN5q46bB+xtm5uoXFzFRFnyFoQ==
X-Received: by 2002:a17:906:aed0:: with SMTP id me16mr3455467ejb.288.1596193843562;
        Fri, 31 Jul 2020 04:10:43 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:8a6a:ec88:3ed7:44b3])
        by smtp.gmail.com with ESMTPSA id bq8sm8935971ejb.103.2020.07.31.04.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 04:10:42 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Chris PeBenito <pebenito@ieee.org>,
        Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v6 0/2] userspace: Implement new format of filename trans rules
Date:   Fri, 31 Jul 2020 13:10:33 +0200
Message-Id: <20200731111035.498656-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These patches are the userspace side of the following kernel commits:
c3a276111ea2 ("selinux: optimize storage of filename transitions") [1]
430059024389 ("selinux: implement new format of filename transitions") [2].

The first patch changes libsepol's internal representation of filename
transition rules in a way similar to the kernel commit.

The second patch then builds upon that and implements reading and
writing of the new binary policy format that uses this representation
also in the data layout.

See individual patches for more details.

NOTE: This series unfortunately breaks the build of setools. Moreover,
when an existing build of setools dynamically links against the new
libsepol, it segfaults. Sadly, there doesn't seem to be a nice way of
handling this, since setools relies on non-public libsepol policydb
API/ABI. There is a draft PR that adapts setools to these changes here:
https://github.com/SELinuxProject/setools/pull/50

See also this discussion about the setools impact:
https://lore.kernel.org/selinux/daeae1d9-de29-aae0-6bde-3ad3427a5d42@tycho.nsa.gov/

Changes in v6:
 - simplify the interface of policydb_filetrans_insert()
   - i.e. make it possible to pass NULL to name_alloc to simplify most
     callers

Changes in v5:
 - fix comment in filename_trans_read() to not change when being moved
 - fix filename_trans_check_datum()
   - destroy temporary ebitmaps at return
   - actually iterate through datums

Changes in v4:
 - rebased on top of latest master branch

Changes in v3:
 - fixed the change in dispol.c to match the rest of the code
 - renamed the helper functions to use the "_compat" suffix rather than
   "_old" and "_new"

Changes in v2:
 - fixed counting rules when reading the new policy format

[1] https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/commit/?id=c3a276111ea2572399281988b3129683e2a6b60b
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4300590243895ac39e8c97a2f5acd004dad8a42f

Ondrej Mosnacek (2):
  libsepol,checkpolicy: optimize storage of filename transitions
  libsepol: implement POLICYDB_VERSION_COMP_FTRANS

 checkpolicy/policy_define.c                |  49 +---
 checkpolicy/test/dispol.c                  |  20 +-
 libsepol/cil/src/cil_binary.c              |  26 +-
 libsepol/include/sepol/policydb/policydb.h |  18 +-
 libsepol/src/expand.c                      |  56 +---
 libsepol/src/kernel_to_cil.c               |  24 +-
 libsepol/src/kernel_to_conf.c              |  24 +-
 libsepol/src/policydb.c                    | 314 +++++++++++++++++----
 libsepol/src/write.c                       | 101 +++++--
 9 files changed, 433 insertions(+), 199 deletions(-)

-- 
2.26.2

