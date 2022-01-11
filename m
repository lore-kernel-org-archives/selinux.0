Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C944DC433EF
	for <selinux@archiver.kernel.org>; Tue, 11 Jan 2022 22:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345475AbiAKWIf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Jan 2022 17:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiAKWIe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Jan 2022 17:08:34 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484CEC06173F
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 14:08:34 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id 82so395689qki.10
        for <selinux@vger.kernel.org>; Tue, 11 Jan 2022 14:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xzf6/dJPmudWwBYGx+KKWoqdrszUYehWE30vM2ixlRs=;
        b=JW4zqN1sG9jweugkldKKB3e8gvurTA/LLBYgJPzhgcMnx44EaUohWu8SFF6l42U1HJ
         Gi8t9LRyQdX5sCvLsac7QwAw/PwX59Z+RJDr3Jwb2rS6CmtpzejJiOQipNPSCl3X+IFs
         3KKJtxy9O2AXcvTsg6Z9JHr9fLBseB5/ZKR5h2PzdNvd4hVIS2Y/WrTAPKFboWOfms/o
         79CzP1pK5HGqjn7uzjfzqYOIGOt5yb0ihu5ilZKAaI+ZfMfX8DOKjnZgpQfDdctvpRK9
         Ul8Q//uliepQ+uAPdXAFeHfzpDyQ5TEG3lz6XqpvkkgS5R8EEB7lNjSaGCoV8EhPPdrL
         lNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Xzf6/dJPmudWwBYGx+KKWoqdrszUYehWE30vM2ixlRs=;
        b=ljsJShEy129y0BdF9vmivUHays9XSbod+Ij8ViDAk2iD9MyWwkTi6ckGoa98jwuo52
         Y/Mz3zmY89KB/c7fCoFC7QPS8ZNy9OSs04gDMLYifJNQNgMlfvXdIIACbzAOMX4IrLkM
         kqU+3Q4aR+Ql6q9I2ljxAs4C5LIqmKyzl2eHHdsG1zi1o0TQK1XwijW6BGSvFdGmGBVO
         +ESs6ARca/N/E64hP8lmtKost1vuWmSybwT3wua31YEHw6AgQmvJUiI/tgVXgRu+gRZm
         GPHq4jDvDqwHjUWyUdIq/ueALex8G82N6qUeZVrut63STwrNa125C+PVxJ5/HhEz+fUd
         kaaQ==
X-Gm-Message-State: AOAM530wunnHiB62DVvxO7r7PpMiS0IIJcyfB778PV8908S+I/eOOR38
        UXClbqn1/VoGoQm+U3v8TD4ySYtiOrM=
X-Google-Smtp-Source: ABdhPJwIISN9ky1flAVkkDMt5RelF5I0kdYlxNjqysmgOVw19mW4wzGq0l/JXT3utVvJ3Vc45t5IRg==
X-Received: by 2002:a05:620a:704:: with SMTP id 4mr4718280qkc.48.1641938913408;
        Tue, 11 Jan 2022 14:08:33 -0800 (PST)
Received: from localhost.localdomain (c-69-250-217-147.hsd1.md.comcast.net. [69.250.217.147])
        by smtp.gmail.com with ESMTPSA id t3sm8211068qtc.7.2022.01.11.14.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 14:08:33 -0800 (PST)
From:   James Carter <jwcart2@gmail.com>
To:     selinux@vger.kernel.org
Cc:     cgzones@googlemail.com, James Carter <jwcart2@gmail.com>
Subject: [PATCH 0/2 RFC] libsepol: Adding support for not-self rules
Date:   Tue, 11 Jan 2022 17:08:21 -0500
Message-Id: <20220111220823.596065-1-jwcart2@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

These patches depend on the 16 patch set that refactors and fixes assertion checking.

The first patch is based on patches by Christian Göttsche <cgzones@googlemail.com>
sent to the list on November 23rd. His patch adding support to checkpolicy is meant
to be used with these patches.

The second patch adds support for not-self rules to CIL. Currently, it works for all
access vector rules, but I am not sure if that is needed or wise.

James Carter (2):
  libsepol: Add not self support for neverallow rules
  libsepol/cil: Add notself and minusself support to CIL

 libsepol/cil/src/cil.c                     |  12 ++
 libsepol/cil/src/cil_binary.c              |  91 ++++++++-
 libsepol/cil/src/cil_build_ast.c           |  10 +-
 libsepol/cil/src/cil_find.c                | 206 ++++++++++++++++++---
 libsepol/cil/src/cil_internal.h            |   4 +
 libsepol/cil/src/cil_resolve_ast.c         |   4 +
 libsepol/cil/src/cil_verify.c              |   3 +-
 libsepol/include/sepol/policydb/policydb.h |   3 +-
 libsepol/src/assertion.c                   | 144 +++++++++++---
 9 files changed, 467 insertions(+), 64 deletions(-)

-- 
2.31.1

