Return-Path: <SRS0=faga=6E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F64C54FCB
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D795420775
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edXKHyfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729423AbgDTPqV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbgDTPqV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 11:46:21 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41444C061A0C
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:21 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j7so1668969pgj.13
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mvx8CVPDkpLMKh1QkX8lBW0rcaH4/MGYAavupQUIPc0=;
        b=edXKHyfApQGeMfvuKqS8RF6OfnvEB6krjNaIWr9VmQZAAzhU3nIOQa1l2ir5FqvpPd
         xCC/yNCOEdMouhILjkVdmdjuZksuq2dFAAQ9lnpbkbGtCeJREGFiNWgHfkDUlUdbjcKY
         GvdCyW5xuazIIB7RylGa1zDXzLODH1jukSUTI2KO/oCK2LwAeQKWOsMEPw/BIbx6QpRe
         9YIw9QG4Z42bJMWCuT3WFCjeTd0C4xJFz1g3OaNHcvOb8RD31TWkGdIGuSGhETFkvBd2
         Xd8PVFlZZ1L4/nURLdYmgHUqDaoci5s3+q0Rkk5OmkFNWU2jBPPbPc0fbTtoPiRhOzOr
         m5AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mvx8CVPDkpLMKh1QkX8lBW0rcaH4/MGYAavupQUIPc0=;
        b=DsuEmztSHTGpXDaWxd758y7gw6wJsk7PrX1ckredC6gPae/iESTDTGRO0Z2OwgH93w
         mgtngrUJ97qVwl8MtlCtpl6sMV5NVPgJBtWkHeZOJR02PUmTcSo1RwrVXnZXptwfNFU6
         yOLznByZnbFp9eYjDOdPgrrk67aIOCWCaWIl6hD5B63ublETPZQhc6bdt2++gtuxJzb/
         IvAUmAkYxz1B5EfGCSMWiHKh1/2hfa4zOIF/eG273M0aORctDJJoBCvxwyk3dX6nty8Q
         GrBrD6RQ+QSfOLMRDhvcpJECaahwOX8om93EO2MgDLTsMbvqIhSU/NG5AUV4ZvZow6PW
         UrUw==
X-Gm-Message-State: AGi0PuZ0SEMbrlSCenoS2hQH7tgQdy/5/4f+rM2mfGdyXdLt4k3I7eCl
        M6WYMl6k/W2SCEBMCQhPNT0H5GswPsM=
X-Google-Smtp-Source: APiQypKKsdRhLhoSdSpnPduDofyN99LUR6gYnbNy3535pFX7SE1mWtVvmqX5r9BRr0+l9MeNKUKHOg==
X-Received: by 2002:a63:6f4c:: with SMTP id k73mr16857074pgc.241.1587397580788;
        Mon, 20 Apr 2020 08:46:20 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id i15sm1367507pfo.195.2020.04.20.08.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:46:20 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Subject: [PATCH v3 17/19] matchpathcon: allow use of deprecated routines
Date:   Mon, 20 Apr 2020 10:45:35 -0500
Message-Id: <20200420154537.30879-18-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420154537.30879-1-william.c.roberts@intel.com>
References: <CAJfZ7==Ote6uQWMjDfNMA=qj79u2ByrnrH==++gDOhPeYD-W5g@mail.gmail.com>
 <20200420154537.30879-1-william.c.roberts@intel.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

From: William Roberts <william.c.roberts@intel.com>

Utility matchpathcon uses the matchpathcon interface which has been
deprectaed. However, this tool will continue to live on, so allow it to
use the deprecated interface.

Signed-off-by: William Roberts <william.c.roberts@intel.com>
---
 libselinux/utils/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libselinux/utils/Makefile b/libselinux/utils/Makefile
index a5632b7c38ec..d66c333ec65a 100644
--- a/libselinux/utils/Makefile
+++ b/libselinux/utils/Makefile
@@ -58,6 +58,8 @@ sefcontext_compile: LDLIBS += $(PCRE_LDLIBS) ../src/libselinux.a -lsepol
 
 sefcontext_compile: sefcontext_compile.o ../src/regex.o
 
+matchpathcon: CFLAGS += -Wno-deprecated-declarations
+
 all: $(TARGETS)
 
 install: all
-- 
2.17.1

