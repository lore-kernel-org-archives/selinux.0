Return-Path: <SRS0=GWJJ=7B=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_BL,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D389C433E0
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 15:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5CEC207FB
	for <selinux@archiver.kernel.org>; Tue, 19 May 2020 15:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZQkw99s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgESPPE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 May 2020 11:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbgESPPE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 May 2020 11:15:04 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AA6C08C5C0
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 08:15:04 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d3so12131pln.1
        for <selinux@vger.kernel.org>; Tue, 19 May 2020 08:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=TEDMYYAvzyjtm5PfCftcIy/KVgc7LOgfcQXEVVzdeko=;
        b=QZQkw99sZwD9OLAxqJiorb71upRtE1tNDhgzHWRBqZVrX55qy+jrUEBZVCz6pVhE5n
         Ah5oZY1M67nykP3jI1RvuXES9xBLRfHDoXGjmB1cj9dCsFsGWPAeaNfJuYSGr3jAWUdO
         Vi9RDkw7Qn1F0E21y2jLCmYKBYXNJCblEDOKcrTrAoduTyfEYTC8Y/l0chD9d1qYwSPv
         b3fkB7vNHf0fSHfn/YyfYGkHJuujRUW1OPzL+/mxPkI52t/Q4VLm+A4qeLPW+OU0Js/s
         w0iW3swoyObe+nUkBSruStBKf5o+k/Acmmd7NPUQVm3kg/J09ooeSoeEOaBb3QNjT2sR
         CUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=TEDMYYAvzyjtm5PfCftcIy/KVgc7LOgfcQXEVVzdeko=;
        b=GKZXB6VBdTWG1w+vY/21yDdMcIEUcz/eAD6+pqIoVdU0f4L3HH4z6TlqGzzToQQte/
         ziN8CnQqByREGDY0bI/cGbS9CwoZLom5mU9ez1Wg8ebJKd+m1b6pdfVDeslweYEl3zQQ
         2NmxQQ+FY4arMYVgjnykT4ex9TN9fQkIdtcJ1qZkZtbgteiWmdJENW/pEn/FOkORFDUg
         ReRfI3TkuOx9wjSgf+hln9gCbSHERAvgiTEV2SSIFJvvGrM9J9LXhjTaEqSLQ194OWYQ
         QAhm5CX3TwYVE4HTRgXuMawsNhWPieUZoTu4vv2sWEeSr3b05reih3LGg3qLFLgKG+g1
         QOUQ==
X-Gm-Message-State: AOAM533PcdQ0e5o4zf85G4e9cBcuRBpXB+Ub/Cw/NipoSX85hMldNYY5
        hCVI61E740btQkanckNxWUD2MvM2AUY=
X-Google-Smtp-Source: ABdhPJwZ/GXnvHs0OpKzxr+9qI8AVzgXW2Zitt+PSgms0vP5s1LH2iNxNeaoQ7luMKNSE1sNnaYTGg==
X-Received: by 2002:a17:90a:c385:: with SMTP id h5mr2725pjt.147.1589901303237;
        Tue, 19 May 2020 08:15:03 -0700 (PDT)
Received: from localhost.localdomain ([134.134.139.83])
        by smtp.gmail.com with ESMTPSA id i12sm2354655pjk.37.2020.05.19.08.15.02
        for <selinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 08:15:02 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     selinux@vger.kernel.org
Subject: Travis CI: Run selinux-testsuite
Date:   Tue, 19 May 2020 10:14:56 -0500
Message-Id: <20200519151457.31618-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

So I put together a patch that will let the selinux-testsuite run in a Fedora 32
KVM instance on Travis CI. The userspace selinux bits are rebuilt and installed
with the current pull-request patches on the CI build. This will help increase
automated test coverage for CI runs. This will help provide confidence that bugs
are not being introduced and that master is stable.

For an example of the run see:
  - https://travis-ci.org/github/williamcroberts/selinux/builds/688853234

Their are some new scripts in the scripts folder. I made a subdir CI to indicate
that while you can run these locally, they are really meant for the CI environment.

[PATCH] ci: run SE Linux kernel test suite

