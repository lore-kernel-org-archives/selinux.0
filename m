Return-Path: <SRS0=yj3S=6M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54D6C83000
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 12:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE804206D9
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 12:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b5NeBYTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgD1MzX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:55:23 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58110 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726620AbgD1MzX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Apr 2020 08:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588078521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Hhad6guXzZPz7zbBFdSUfK8IdNjrpDdD64VS2b2IFi0=;
        b=b5NeBYTHqGeR8rus3eWNBufxg0uESgzfpHerJK6rc+QfDjYm2+orqRnk3l7bPRcx5J4WH1
        s3RYJjLNHQCY1m5WZP42Hu0Y1t2SYuJtt1rXZysqincUe+AZloGRTZtb5lglF1vDNXc95I
        wJbU7e3gY7PHcBcdCFmnFXcKmay8L+o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-M0zKQlvcMh2WI-kjt1CzHw-1; Tue, 28 Apr 2020 08:55:20 -0400
X-MC-Unique: M0zKQlvcMh2WI-kjt1CzHw-1
Received: by mail-wr1-f70.google.com with SMTP id v9so12190651wrt.7
        for <selinux@vger.kernel.org>; Tue, 28 Apr 2020 05:55:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hhad6guXzZPz7zbBFdSUfK8IdNjrpDdD64VS2b2IFi0=;
        b=kRKVatDBmEtXtlrSTEwc/eCPI0F/6rxEQneDK5knLsE5zwfR9Ve6t2e7qPr2KVK9Qx
         0oG52giVPZNwz4RJV5OjI8lN3PPWw+10NJVEYZtOvgva24OnGoOW9zdBLcaRJlkk741I
         Z052mZMOUCi1YXD3vqVdPHCw3siy3lka+Dioa25y8ae9GDBJ7hK/GZ/8cmFxKnxb60wN
         bo7G8iGO3aOGPWRM5NgbdEEIc3L2tV9IusyOiy+n7fkFWXbyA94cpm51srN6Zq+mKrRT
         QZnO2P+UYlsEGIbcWgaR9bWwrMZ4LCSiLrMay8Ru2HmEGND+XIpxe2K5x/FJ36lKCVdP
         ZOpA==
X-Gm-Message-State: AGi0PuYihe7PM7TBV47K3IPThqgPDDrZlFhy7pBkjqOJ2YiephEGe8mh
        9MKdy+cFlV4afDGquLy+RRTMcWUqr3mc2aHzE7mbDt5M3/UdaKDSJxdPDNTWZFSfrB3zb7CbtKf
        40GuVmQQsPCfM5ZNjJw==
X-Received: by 2002:adf:dd8f:: with SMTP id x15mr35527398wrl.201.1588078518826;
        Tue, 28 Apr 2020 05:55:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ2sz240/O/QODfSv+MegjaI1QUgGJk5UinvEcs24e3qwgPFGrGuOVHdbMIWl+Nd6ldH4Pvjw==
X-Received: by 2002:adf:dd8f:: with SMTP id x15mr35527361wrl.201.1588078518540;
        Tue, 28 Apr 2020 05:55:18 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id y63sm3082438wmg.21.2020.04.28.05.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 05:55:17 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Subject: [PATCH 0/4] Inline some hashtab functions to improve performance
Date:   Tue, 28 Apr 2020 14:55:10 +0200
Message-Id: <20200428125514.2780171-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Right now, hashtab_search(), hashtab_insert(), and hashtab_map() are
defined in hashtab.c and need to call functions indirectly. It turns
out that defining (the relevent parts of) these functions inline in the
header and passing the function pointers as arguments makes them
significantly faster (at least in the hashtab_search() case).

The first two patches in the series are two small simplifications that
are not directly related, but the rest won't apply without them. The
third patch then converts the hashtab interface to prepare for the
inlining and the last one finishes the job by just moving some of the
function definitions to the header. These could be also just one patch,
but are kept separate for easier review of changes in the functions
being moved around.

For more details, please refer to the respective patch descriptions.

Ondrej Mosnacek (4):
  selinux: simplify range_write()
  selinux: do not allocate hashtabs dynamically
  selinux: prepare for inlining of hashtab functions
  selinux: complete the inlining of hashtab functions

 security/selinux/ss/conditional.c |   4 +-
 security/selinux/ss/conditional.h |   2 +-
 security/selinux/ss/hashtab.c     | 112 ++-------------
 security/selinux/ss/hashtab.h     | 101 ++++++++++---
 security/selinux/ss/mls.c         |  23 +--
 security/selinux/ss/policydb.c    | 230 ++++++++++++++++--------------
 security/selinux/ss/policydb.h    |  15 +-
 security/selinux/ss/services.c    |  54 +++----
 security/selinux/ss/symtab.c      |  25 +++-
 security/selinux/ss/symtab.h      |   5 +-
 10 files changed, 294 insertions(+), 277 deletions(-)

-- 
2.25.4

