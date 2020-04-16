Return-Path: <SRS0=3hV4=6A=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C17C352BE
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFBD222245
	for <selinux@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Evj1NLtc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404563AbgDPPoS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404061AbgDPPoH (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Apr 2020 11:44:07 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69229C061A0C
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:07 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p8so1814294pgi.5
        for <selinux@vger.kernel.org>; Thu, 16 Apr 2020 08:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N6eo6TXULw2Cdaa2wRWiDXhWuZ85pcTm2cgwF+y4L/I=;
        b=Evj1NLtcZ97tytSLjaYY0vF7N8Pact6sLAQP0ChHPFV5lxADKkRtbmO43+yQgvpMfQ
         Xkx6NXyc8lxX10kkAiggov035ouMvk48Jds1NdAPSyHlwvBUa4CjaNNhzfX8Z03j01TS
         XGPOh+n/sh2QTqqF79UtgH2m10uJ9XZ1WXhw7l7IEoEH+LHktTll2RMfAvUQ3J1jCUWi
         dQQVpLmzq9jtSv1+zzCbmemOOtga+tduaC+MBskm0SUKR5d9ufeAqWZqFWQNKIPuLn9n
         6sgZRe8rl3dU/vUwlQe9/eRx0rwcbTXg3AmoP3DN9wpg/Q2h6uzpigXtj+OUC2zt+Epe
         2phQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N6eo6TXULw2Cdaa2wRWiDXhWuZ85pcTm2cgwF+y4L/I=;
        b=aUrqB8HOVvW+GW5MRF0foFtaBnXLCncI4iFs60k4inpdJgvPkhLzx8hqsdLp1cTe2k
         sqYnnprbGhhF2F0t2BAdbstY9+BNl4GL7z8aNeY8apedrBanz99wsjlGAN/3QDj51Dwe
         So8Ce5kALgsSrGn/CLc8ex6FK6bR2hJTrpzQF/TOYx5bK5qWQTB/4obycFgdD1/vnn2q
         q0HuShncMPa62Vk1K5Y3/J2GzW9Dg5YjFnbtoYIm0hOu+dNZg3ZuyG3eLeNNRVaklEsS
         YKRadBokDVoIPJHbgjZIjf77UIGVbMIg0oP68gy267Hhu6dBKqr1PH2kMZKfAiudsC6b
         chhA==
X-Gm-Message-State: AGi0PuYuAeGHChQZAUFd7W/PeEmzmVTgMVRK75Z9ubZCVAuQDz7ZkZyr
        LmfeA46+JOwTcoFlJ995L+GuT/duoSI=
X-Google-Smtp-Source: APiQypKtx0ZCgXqCahuX1oen8NvePE5A1Uw1M78xZq15hM3M8D/ala1Stv3kuyZdYEhgD46ww0iIzg==
X-Received: by 2002:a65:6403:: with SMTP id a3mr33454272pgv.222.1587051846823;
        Thu, 16 Apr 2020 08:44:06 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.45])
        by smtp.gmail.com with ESMTPSA id g25sm16888626pfh.55.2020.04.16.08.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:44:06 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org
Subject: Annotate Deprecated Functions in libselinux
Date:   Thu, 16 Apr 2020 10:43:34 -0500
Message-Id: <20200416154352.21619-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225200219.6163-1-william.c.roberts@intel.com>
References: <20200225200219.6163-1-william.c.roberts@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

V2:
- Simplified now that dso.h stuff has been removed.
- selinux_check_passwd_access has been deprecated and now
  both selinux_check_passwd_access and checkPasswdAccess
  are recomending selinux_check_access.
- matchpathcon is linked statically to get access to deprecated
  routines and prints a deprecated warning to stderr.

V1:
I went through and annotated deprecated routines we have in
libselinux that are mentioned to be deprecated either in code
comments and/or manpages.

External users, when compiling will see a warning similair to some
sample output:

a.c: In function ‘main’:
a.c:18:2: warning: ‘foo’ is deprecated: foo bar msg [-Wdeprecated-declarations]
  foo();
  ^~~
a.c:5:5: note: declared here
 int foo(void) {
     ^~~
a.c:19:2: warning: ‘boo’ is deprecated [-Wdeprecated-declarations]
  boo();
  ^~~
a.c:11:5: note: declared here
 int boo(void) {

[PATCH v2 01/18] security_load_booleans: update return comment
[PATCH v2 02/18] security_load_booleans: annotate deprecated
[PATCH v2 03/18] selinux_booleans_path: annotate deprecated
[PATCH v2 04/18] selinux_users_path: annotate deprecated
[PATCH v2 05/18] rpm_execcon: annotate deprecated
[PATCH v2 06/18] sidget: annotate deprecated
[PATCH v2 07/18] sidput: annotate deprecated
[PATCH v2 08/18] checkPasswdAccess: annotate deprecated
[PATCH v2 09/18] matchpathcon_init: annotate deprecated
[PATCH v2 10/18] matchpathcon_fini: annotate deprecated
[PATCH v2 11/18] matchpathcon: annotate deprecated
[PATCH v2 12/18] avc_init: annotate deprecated
[PATCH v2 13/18] avc: create internal avc_init interface
[PATCH v2 14/18] matchpathcon: create internal matchpathcon_fini
[PATCH v2 15/18] matchpathcon: create internal matchpathcon interface
[PATCH v2 16/18] selinux_check_passwd_access: annotate deprecated
[PATCH v2 17/18] utils: matchpathcon to use interal interfaces
[PATCH v2 18/18] utils: matchpathcon add deprecated warning

