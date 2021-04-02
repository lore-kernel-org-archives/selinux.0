Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3C31C433B4
	for <selinux@archiver.kernel.org>; Fri,  2 Apr 2021 08:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B43C6610E7
	for <selinux@archiver.kernel.org>; Fri,  2 Apr 2021 08:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbhDBI4a (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Apr 2021 04:56:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47112 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229924AbhDBI42 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Apr 2021 04:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617353785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UciShcn14LVw09YzrkdzvjCGFmIgzfmiDVqS3rOAb0o=;
        b=KGnwaHO+MCRaqC0YwBzKbGzHnqy/fUBOh0uUHMMB/6QJfDL7dPQujJoDOFFg6QLJfQK30S
        GDONepohDwdtQomGZuHA4/ore05TYy5n5ZfQGOabEOcKlCVTCQJRPFoNORlaushOpb4v9D
        /q5hyd+BfOQuPSdfZO85xoHTNndJLlo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-QxEPUS8UPFmBXuPWmWpk1A-1; Fri, 02 Apr 2021 04:56:24 -0400
X-MC-Unique: QxEPUS8UPFmBXuPWmWpk1A-1
Received: by mail-ed1-f69.google.com with SMTP id w18so4311785edu.5
        for <selinux@vger.kernel.org>; Fri, 02 Apr 2021 01:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UciShcn14LVw09YzrkdzvjCGFmIgzfmiDVqS3rOAb0o=;
        b=cmmcaZhA+YHiAHbLR9rSq9FyM8f4fMd14h9p/VnG/gnL9upYaX2tK+NIQ+CXNPKKxa
         xknJsxJZ+kUQqfzswYUhaJ+ekIrqn1QxNOxwrsVWsLWewIg8x9Vcc37hls0tLh5bsTEs
         qIZEmI0+K3O20XJDDgzhvf/wazMdlHknB6oRKLbMaDGjNJYU1dOZw9/QkJOmqmMpUMbe
         /xx5ABsJif78OQ4DWSXjonXezPoDOsvXqKVoziuewcITzV6mQOl+6SRvGUohiQtzEPPQ
         CI+x1VwD9HPv+HaRaLpriKdjLlyTbEjIMTU+AVqu8n8SWsVq8o0tZcl8PaP57PkutlY/
         IWTw==
X-Gm-Message-State: AOAM530XOrSXw5KTnJu0CekIfIP50rt/lo0i+NFZMnEeno7KiQEa5wgP
        6troG4+BjeINTLxuCBgG6zmgH874FwSKzsIXGtdr+7JdwMF2C6dESYmEQU8YoOa0MRIr24NLfEB
        olAGYZRaYj3Azi6lVvF2+ieQzjayuH5YGofqPj64jGf6cyzc6h9lbteiy1PPmbyaJrrcSDQ==
X-Received: by 2002:a17:906:f9d8:: with SMTP id lj24mr13203916ejb.200.1617353782996;
        Fri, 02 Apr 2021 01:56:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw4CM3jD2Z9iYpQN1Z76Ld8BGGcR4E4lsY9e5Fz/vbeIIJKPMIu5Rn9F/GPZ74ZaHU/b8iCFA==
X-Received: by 2002:a17:906:f9d8:: with SMTP id lj24mr13203902ejb.200.1617353782774;
        Fri, 02 Apr 2021 01:56:22 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id u13sm4019726ejn.59.2021.04.02.01.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 01:56:22 -0700 (PDT)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org, Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: [PATCH v3 0/2] selinux: fix changing booleans
Date:   Fri,  2 Apr 2021 10:56:17 +0200
Message-Id: <20210402085619.1763971-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

This series contains a patch that fixes broken conditional AV list
duplication introduced by c7c556f1e81b ("selinux: refactor changing
booleans") and a couple "and while I'm here..." cleanup patches on top.

v3:
- move the avtab_alloc_common() call in avtab_alloc() under the
  conditional block

v2:
- drop the follow-up cleanup patches from this series
- add a patch fixing the current handling of nrules/nslots being zero
- fix this handling also in the original v1 patch
- simplify the loop that computes nslots

Ondrej Mosnacek (2):
  selinux: make nslot handling in avtab more robust
  selinux: fix cond_list corruption when changing booleans

 security/selinux/ss/avtab.c       | 101 ++++++++++--------------------
 security/selinux/ss/avtab.h       |   2 +-
 security/selinux/ss/conditional.c |  12 ++--
 3 files changed, 40 insertions(+), 75 deletions(-)

-- 
2.30.2

