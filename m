Return-Path: <SRS0=dl6L=A4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E71C433E1
	for <selinux@archiver.kernel.org>; Fri, 17 Jul 2020 11:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5250A20768
	for <selinux@archiver.kernel.org>; Fri, 17 Jul 2020 11:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IIBvYxt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbgGQLsM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jul 2020 07:48:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35280 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726013AbgGQLsL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jul 2020 07:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594986489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=B6xzuQ/IjNCWLpEq95uKxqTeMSgxYBryJkULbvZDZXA=;
        b=IIBvYxt2QnIwE3N+T7A/j5z/bKizZNqCH0R6yGpZJRcHUKxU7COq+ksddfdYd4JWCMyheA
        VRcdzW7r9iiFd0daErc6Jzx3b6QTtxc/DKyI8eo+z08bdm3T1WdUzKHQvuVygZZ8vwsbUa
        Hv7v0Xdul/8crVzQoF5o8Y6rUo0K1cE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-N8NGE20POMK_e1aL2oCkfQ-1; Fri, 17 Jul 2020 07:48:07 -0400
X-MC-Unique: N8NGE20POMK_e1aL2oCkfQ-1
Received: by mail-ej1-f72.google.com with SMTP id q11so5492619eja.3
        for <selinux@vger.kernel.org>; Fri, 17 Jul 2020 04:48:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B6xzuQ/IjNCWLpEq95uKxqTeMSgxYBryJkULbvZDZXA=;
        b=IG7j4yPc8pBkJkvGrcAPQIP+fAxagsiHwlFQcultRdBKvYTF4v0lM5MfWEfoyjHQT+
         v+Jcmi8jIxRkp1zCbn2iJ3eVHbLlCfA2BWD2hZmpGWtejgeSzeVApVyXWTaXTSsHxIvr
         eF/AE9n+/a5IsZOcZofMo4jGK6WD+VSdG1BDm7PQf5I/GH1uetB9G1kQPSyXlHlE+rYx
         lttYCbtcckIKfWi/uKRzqEzQMt07Vw+ICkvLIV7sHaE6QY6oEOID29/dWatmzuvH+txa
         u0jmTDuwJBEkfnHHFkWBQ4Uk6DiRlwPtkIxXCI/jpf4oQl1efq0QqJPs6ggxW3SHLyuN
         pJYg==
X-Gm-Message-State: AOAM530esLCXlV4f8/UUPHMYT4tFDLRxUVmsk5nlmxjptdk96vqcnra/
        B4U2H8Vd+9PHWWuewr79LQeHsyH2CU+7oeDyBPHOEHDXD+yyPYiAK0xT2+snnBk+oPyF27v8JbI
        dU1X+nTs6PH6KzMvOKQ==
X-Received: by 2002:a05:6402:3048:: with SMTP id bu8mr9126435edb.367.1594986486340;
        Fri, 17 Jul 2020 04:48:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJykXgixGLRKFCg/3401sEbnEoXH8OPqpuPL5+oeX/2Y9zO2FoBp4DkMypjUr7/EWud/JwDYaA==
X-Received: by 2002:a05:6402:3048:: with SMTP id bu8mr9126417edb.367.1594986486102;
        Fri, 17 Jul 2020 04:48:06 -0700 (PDT)
Received: from omos.redhat.com ([2a02:8308:b13f:2100:8a6a:ec88:3ed7:44b3])
        by smtp.gmail.com with ESMTPSA id x11sm7800957ejv.81.2020.07.17.04.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 04:48:05 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Cc:     James Carter <jwcart2@gmail.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Chris PeBenito <pebenito@ieee.org>,
        Petr Lautrbach <plautrba@redhat.com>
Subject: [PATCH v4 0/2] userspace: Implement new format of filename trans rules
Date:   Fri, 17 Jul 2020 13:48:02 +0200
Message-Id: <20200717114804.762125-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.26.2
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
API/ABI. I have prepared a preliminary patch to adapt setools to these
changes - I'll open a WIP pull request for it soon...

See also this discussion about the setools impact:
https://lore.kernel.org/selinux/daeae1d9-de29-aae0-6bde-3ad3427a5d42@tycho.nsa.gov/

Changes in v4:
 - rebased on top of latest master branch

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
 libsepol/src/expand.c                      |  60 +----
 libsepol/src/kernel_to_cil.c               |  24 +-
 libsepol/src/kernel_to_conf.c              |  24 +-
 libsepol/src/policydb.c                    | 299 +++++++++++++++++----
 libsepol/src/write.c                       | 101 +++++--
 9 files changed, 428 insertions(+), 199 deletions(-)

-- 
2.26.2

