Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E9DEE14A5
	for <selinux@archiver.kernel.org>; Wed,  6 Sep 2023 15:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjIFPq5 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 6 Sep 2023 11:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjIFPq4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 6 Sep 2023 11:46:56 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87CEBC
        for <selinux@vger.kernel.org>; Wed,  6 Sep 2023 08:46:52 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6c0a3a2cc20so29141a34.0
        for <selinux@vger.kernel.org>; Wed, 06 Sep 2023 08:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694015212; x=1694620012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+/byxSrO8DRvXgUu7WdXnmFYSOYmBOV9Mq9BcIyeqpw=;
        b=VVqfSbLd48MzppdwP7lKoOKxVVASQkJh7iJGTMN8gtaluE6t7nzQOMeZy+7YBlTgnC
         ixa8paRYec0DPLAgFw+NSKrx2frE/YJ3qHyqNLIRlwe6sm+VBas/gdiarIDOTXRDPsns
         wAVHsL4mThRkPdfYZhdEjtGlCdoELTw+zbmQDDHosHF0fxXru3hI9JENMujmh/A/ALNG
         ZQhzRG20Oqsf4riSEECq2ysk7PISgjFcPhDgam8bo9nKtUTYnnEuShDYpGgZDS3Vb2et
         mhDNQGCoZUAMDjqSP+RUsqHQ/ypVJgZdqqxZcKJuotS4uB0L55dvjRK7Q4MBzDuvId70
         Yteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694015212; x=1694620012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+/byxSrO8DRvXgUu7WdXnmFYSOYmBOV9Mq9BcIyeqpw=;
        b=XimcqTbr5UVQE95LYwWhstUPjjFJSIGB4a2lm51EWvX2Ch6nWiBaspxpnAiVOr6NG6
         5HBx8Cl3R5pTchS11lk2Kt56DPVKdlH4/Is7dwWJUnfq3aAV3GtuhJBbz+E+wevTy1jL
         RQbPSSTa1FgRyWSHkrdLeHkUdVo27M32uyJUDej+V4OO5BX8eMFLk4IjgSOxS0MuCLZv
         xLlC7VGGynFnDGQe+lZ8dY7yObRcfE17MqzQit24Smv4dl/0dEso2UOpd/8bPWa1xPcB
         l68/eWG305/zJVF4fzxH1Wv3zz8FHIDc4mpMhwGfDEhYkQTYn3+f8nfFVmUqpltEde2P
         HLVA==
X-Gm-Message-State: AOJu0YymIWcxPNSDJOFlg0E/YDEDl2WAn5cuMNxhQdXh+E1ozPNVn6ng
        fm12rRP8msnZCWyNl9gEf16PBgzbhjg=
X-Google-Smtp-Source: AGHT+IHABjebt/fyDV+s13Ixsu6S3NSKDsl4fHwz/AvWa2X3ZbGrBvakyOyLUWMiy1dYSP7r9e3n9g==
X-Received: by 2002:a05:6358:41a7:b0:139:cf80:1845 with SMTP id w39-20020a05635841a700b00139cf801845mr4806537rwc.12.1694015211721;
        Wed, 06 Sep 2023 08:46:51 -0700 (PDT)
Received: from 5bc235456ce7.evoforge.org (ec2-52-70-167-183.compute-1.amazonaws.com. [52.70.167.183])
        by smtp.gmail.com with ESMTPSA id g25-20020a0caad9000000b0064f778c8165sm5518835qvb.64.2023.09.06.08.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 08:46:51 -0700 (PDT)
From:   Jacob Satterfield <jsatterfield.linux@gmail.com>
To:     selinux@vger.kernel.org
Cc:     Jacob Satterfield <jsatterfield.linux@gmail.com>,
        stephen.smalley.work@gmail.com, paul@paul-moore.com,
        omosnace@redhat.com
Subject: [PATCH 0/3] avtab hotspot optimizations
Date:   Wed,  6 Sep 2023 15:46:03 +0000
Message-ID: <20230906154611.31762-1-jsatterfield.linux@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

As the refpolicy and the default Fedora policy continue to grow in
size, especially with regard to rules / access vectors, the memory
usage of the policydb and runtime to search through it increases.
Looking at /proc/slabinfo indicates that the avtab_node_cachep
kmem_cache is significantly responsible for overall memory usage and
was a good target for optimizations. Running "perf record" on the
"load_policy" command shows that a majority of time is spent adding
rules into the avtab.

This patch series is a first attempt at optimizing these hot spots
within the security server implementation to help it scale with 
additional rules in the future.

Patches 1-2 deal specifically with the hashtable implementation within
avtab and how memory is allocated for individual nodes.

Patch 3 is a runtime optimization discovered through profiling the
"load_policy".

Jacob Satterfield (3):
  selinux: use arrays for avtab hashtable nodes
  selinux: shrink conditional avtab node array
  selinux: hweight optimization in avtab_read_item

 security/selinux/ss/avtab.c       | 143 ++++++++++++++++++------------
 security/selinux/ss/avtab.h       |  36 ++++++--
 security/selinux/ss/conditional.c |  57 +++++++-----
 security/selinux/ss/conditional.h |   2 +-
 security/selinux/ss/services.c    |  20 +++--
 5 files changed, 166 insertions(+), 92 deletions(-)

-- 
2.41.0

