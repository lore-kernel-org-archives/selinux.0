Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB4EC433E6
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 10:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A9CA239D4
	for <selinux@archiver.kernel.org>; Fri, 22 Jan 2021 10:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbhAVKbI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 22 Jan 2021 05:31:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44617 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727685AbhAVK3Y (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 22 Jan 2021 05:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611311272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0oYnH5ijVQImDknEjCgOlMv5XkAsji2o0eXOtg7DOnk=;
        b=EHF9EI8rLMcwLxtJ4LhMsMStuWpsUPR9X9CtfIOPtzyGWqA5pZ/hYFq5DJ/0WSKNlBvADS
        4sYHqnn0Pocu07zQ8+/KI/u5DdlfYZnXanC/rbGFUmoutdYwG5NTJglHsVBmB++VtATLuy
        qcCdTMziMQz0DVPiVWw5eBK8SEzOtAk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-7ywrJN95NCeEstMHfg-9OQ-1; Fri, 22 Jan 2021 05:27:50 -0500
X-MC-Unique: 7ywrJN95NCeEstMHfg-9OQ-1
Received: by mail-ej1-f70.google.com with SMTP id q11so2044396ejd.0
        for <selinux@vger.kernel.org>; Fri, 22 Jan 2021 02:27:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0oYnH5ijVQImDknEjCgOlMv5XkAsji2o0eXOtg7DOnk=;
        b=Pztm5vvbuiqs/9CHogKAlaqTmmGEHVA4B/4TzQX8vU5PRoDE3dofTJC2Y8Q8yo8hL8
         lgiTsnCPOSv5MD8pBDpFC4+emOyVL9uz9HBj2yz6YVXR4hncA1vpiHSBzuBwT2W24VMB
         M1mq0NeLLxpHUdaxqHmkjWZnF4Bx9fKV119Lr66aEBFq4auGTe/tRp0+HNwHwWkKY+vI
         5UF4xptZPF8rZVTEG0FzpivFK0tnvbgMUeyCMuM5bcGPxfHH1H/btnI9Ghv8Yd05XnLo
         ldPE8CBP+QrdWjMqn9qAuzbKml4O0DfU5wRsV97FOySEYM0GZTv6TKrTT0PClRoN1gG6
         zfFA==
X-Gm-Message-State: AOAM533mO9MFvKgETBENE0UWRmg4UIYc0zwP2od+BxyUIHCSyn7+Khfg
        KWfVCK0i9qw7sHd2JIghp6Motu5961iCBEXb2CjQPLHwRvXqfyqUxlgm+YDobODCGVDcMRbNT78
        9DExBZYBLO/EsOwOpdLopg1Cbgj7FbOvIU+phMi6rw41jnvf51uJPo/hiJmbs2Xw0g5A9BQ==
X-Received: by 2002:aa7:db4e:: with SMTP id n14mr2602767edt.101.1611311269076;
        Fri, 22 Jan 2021 02:27:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyatpKKTD3A8DQl3PDb33cFOHYxGgGjqvitMr1NabJWPy2QCcH8uS1N+a9sEEG6iPn2Mka3pw==
X-Received: by 2002:aa7:db4e:: with SMTP id n14mr2602761edt.101.1611311268852;
        Fri, 22 Jan 2021 02:27:48 -0800 (PST)
Received: from omos.redhat.com ([2a02:8308:b105:dd00:277b:6436:24db:9466])
        by smtp.gmail.com with ESMTPSA id z1sm5047556edm.89.2021.01.22.02.27.48
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 02:27:48 -0800 (PST)
From:   Ondrej Mosnacek <omosnace@redhat.com>
To:     selinux@vger.kernel.org
Subject: [PATCH testsuite 0/2] Migrate CI to GH Actions
Date:   Fri, 22 Jan 2021 11:27:46 +0100
Message-Id: <20210122102748.38776-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

See individual patches for more details.

Special thanks to Nicholas Iooss, who figured out this approach.

Note: I plan to merge this tomorrow (along with the userfaultfd test)
so that we have working CI again. I might do that also earlier if
someone acks it fast ;)

Ondrej Mosnacek (2):
  check-syntax: use 'command -v' instead of 'which'
  Migrate CI to GH Actions

 .github/workflows/checks.yml |  27 +++++++
 .travis.yml                  |  40 ----------
 Vagrantfile                  |  65 ++++++++++++++++
 tools/check-syntax           |   2 +-
 travis-ci/LICENSE            |   5 --
 travis-ci/run-kvm-test.sh    | 141 -----------------------------------
 travis-ci/run-testsuite.sh   |  58 --------------
 7 files changed, 93 insertions(+), 245 deletions(-)
 create mode 100644 .github/workflows/checks.yml
 delete mode 100644 .travis.yml
 create mode 100644 Vagrantfile
 delete mode 100644 travis-ci/LICENSE
 delete mode 100755 travis-ci/run-kvm-test.sh
 delete mode 100755 travis-ci/run-testsuite.sh

-- 
2.29.2

