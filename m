Return-Path: <SRS0=0b+K=5N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B04C43331
	for <selinux@archiver.kernel.org>; Sat, 28 Mar 2020 12:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FF320723
	for <selinux@archiver.kernel.org>; Sat, 28 Mar 2020 12:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dg+o8EU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgC1MqB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 28 Mar 2020 08:46:01 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:30372 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726290AbgC1MqB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 28 Mar 2020 08:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585399560;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wd8ziv+HGAv/zDdK8rd18zEi8T01NST2lViyTQM5bFQ=;
        b=dg+o8EU9EV3xQZNe2DMb5fNexxjMkNQu1pTLxv86TITAQl26Bbg9UV6tvIjzonZE4zlig+
        3AuoDkSiCDeOSYynDPx/dsaSlYrBzzt0yrhnRqFBED0eeQEhlKRbKYKeVXqBsmnfnEf46J
        EM2eKq/KD1eQelHAwWLB4GkVYQBm2NY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-Jjb0H849NHGxRw6f9mJBzQ-1; Sat, 28 Mar 2020 08:45:55 -0400
X-MC-Unique: Jjb0H849NHGxRw6f9mJBzQ-1
Received: by mail-wr1-f72.google.com with SMTP id l17so6200582wro.3
        for <selinux@vger.kernel.org>; Sat, 28 Mar 2020 05:45:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wd8ziv+HGAv/zDdK8rd18zEi8T01NST2lViyTQM5bFQ=;
        b=GEqOBYDwzevKlcL1fB69PH8lzeM8+1nYnJcc62tBIlZGBEU6s6t7Us5aqIG3h8znJ9
         /ETKgQtFJFAPw5tehPzs09LnTXLgLHnllZ50eTUt5W5fPmQWSbgqwHmKzpp6DL5UfnW2
         VVz2d0mnGS7yLGF2W8Y60PDEGbNOiO6JjRULv5hDGo+B35ecLkgkX8E0xNGqBLC7qT8c
         ZfrkyF6RRVmZouo7ct/r31VnJ0ZrdnztbYxrJYy2SG/dX2xdW5OWPKxVCWrQWDTk3uBh
         iV79vanPTnpa9EUiGs17nEYWSZL4mKWSZtHRat5gxhZgqYA4X4gPC9ePxEgXW5sJDq4T
         mWOA==
X-Gm-Message-State: ANhLgQ1QZFlu5u/WMewLlIj+C0uZSJ3kUBfgbmzBm4ZY2osl5mfUxzBF
        Kwm1I4Tj2D+PQpdqOzHVq8f1CJ/zm6QSOMPl+4jbidZoJSzEUlwNahiohSQT+YUDFUzFZ9XqAtY
        JzIkZI0Tz0/gjQMLiBw==
X-Received: by 2002:adf:f1c4:: with SMTP id z4mr5098586wro.342.1585399554307;
        Sat, 28 Mar 2020 05:45:54 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt1eEihAId6GvFvjPwIfJ8nMQR2DY7MZhAkmXuneyyJ55YRBUX1KGnDuKXdbuEM69O/3UAL8g==
X-Received: by 2002:adf:f1c4:: with SMTP id z4mr5098563wro.342.1585399554066;
        Sat, 28 Mar 2020 05:45:54 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:f695:3ae5:c8bf:2f57])
        by smtp.gmail.com with ESMTPSA id y200sm12349156wmc.20.2020.03.28.05.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 05:45:53 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Chris PeBenito <pebenito@ieee.org>
Subject: [PATCH v2 0/2] userspace: Implement new format of filename trans rules
Date:   Sat, 28 Mar 2020 13:45:48 +0100
Message-Id: <20200328124550.199568-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.25.1
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

Changes in v2:
 - fixed counting rules when reading the new policy format

[1] https://lore.kernel.org/selinux/20200327151941.95619-1-omosnace@redhat.com/T/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/commit/?id=c3a276111ea2572399281988b3129683e2a6b60b

Ondrej Mosnacek (2):
  libsepol,checkpolicy: optimize storage of filename transitions
  libsepol: implement POLICYDB_VERSION_COMP_FTRANS

 checkpolicy/policy_define.c                |  52 ++--
 checkpolicy/test/dispol.c                  |  27 +-
 libsepol/cil/src/cil_binary.c              |  29 +-
 libsepol/include/sepol/policydb/policydb.h |  18 +-
 libsepol/src/expand.c                      |  60 +---
 libsepol/src/kernel_to_cil.c               |  24 +-
 libsepol/src/kernel_to_conf.c              |  24 +-
 libsepol/src/policydb.c                    | 314 ++++++++++++++++-----
 libsepol/src/write.c                       | 100 +++++--
 9 files changed, 441 insertions(+), 207 deletions(-)

-- 
2.25.1

