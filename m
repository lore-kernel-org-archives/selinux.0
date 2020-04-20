Return-Path: <SRS0=faga=6E=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6D4C3A5A0
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9F620775
	for <selinux@archiver.kernel.org>; Mon, 20 Apr 2020 15:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GHz2vfYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgDTPpq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgDTPpq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Apr 2020 11:45:46 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246FFC061A0C
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:45:46 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o15so4676367pgi.1
        for <selinux@vger.kernel.org>; Mon, 20 Apr 2020 08:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=afmkY+YFDqfaMF9gf/64bT0WI+Ajz51vQFmMlHF6iVs=;
        b=GHz2vfYZW9hhkeXlbvzP98Bn2zjXRmgXTA/L4iejSIfbXhmYqezSU2P9QKGKgBUZk1
         LT2bim3NkhDpR1WlCW6Hf93g11la1Rc78f9etQT7Mk58L3CiUB7fXhZq8vfeRqEVxDTt
         vvuyqR1lDvy3OWMOINYVCHmcHEin3YLokJJyZOhBmqJTSmLWLCwxnXGx4452SpqcIGlB
         ZYG4QvLzR8S34X6UFJMqIIhmLAsmRUXHYQg1DCy4cN13YbI48bjw6pWzJYjj+s5rd4+Y
         2coRDMKDi/I5Cmj8KNC5hDnRxJEXguVzIAo9pHVeMcdWwjsEyJogad6JjgUkRfGvIn7o
         KXfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=afmkY+YFDqfaMF9gf/64bT0WI+Ajz51vQFmMlHF6iVs=;
        b=Anj+hI8BBqh1GYWf16lbv13vunlsJvP0MYy4rqu1As1/zpYC03/3GRocT6lOUG7vyQ
         KrtYnxZQLLkJ9sGTEf0c6JWDt6yMjP8HYA/pTCuVcbBXwzaGWjWZWfFYXcBTlfo3nZ+2
         aeG33SBVnJOLbu5FpjYH928HtBA9qhyLnY7rZZnZb3HlZwe90EdqG2oLEPQ6MEGbmmH5
         XGRoB7cXBqto9vWPEmTDMSeRC0wmpf7ElCiUbxSCcuYtp1R7GrJxJJ5spKNoehUgg3jV
         +FO+JQHXNRW4hP6yoXPj5TEai51b0yJnjHQ6MMDWTN7v8qsaV0HO8PhoWZL6nq5YPQsZ
         klFQ==
X-Gm-Message-State: AGi0Puai0Jli7YtbEOZyeuoeAU89FW/Pv5qBMxttu3fv37Kr6f0fIkqZ
        VUpDu6mdir2aOadSC6DrhWNa3DKZuuQ=
X-Google-Smtp-Source: APiQypLBmV7yemwFpnupTSqaxoSPK8BAtB9oHaZQd+DGpiONAwLWrLg0bx9pyJeLO2lRFJwx/2K+mQ==
X-Received: by 2002:a62:e110:: with SMTP id q16mr14486904pfh.99.1587397545402;
        Mon, 20 Apr 2020 08:45:45 -0700 (PDT)
Received: from localhost.localdomain ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id i15sm1367507pfo.195.2020.04.20.08.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:45:44 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     nicolas.iooss@m4x.org
Cc:     bill.c.roberts@gmail.com, selinux@vger.kernel.org
Subject: [v3] Annotate Deprecated Functions in libselinux
Date:   Mon, 20 Apr 2020 10:45:18 -0500
Message-Id: <20200420154537.30879-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAJfZ7==Ote6uQWMjDfNMA=qj79u2ByrnrH==++gDOhPeYD-W5g@mail.gmail.com>
References: <CAJfZ7==Ote6uQWMjDfNMA=qj79u2ByrnrH==++gDOhPeYD-W5g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

V3:
- Made the deprecated annotation dependent on __GNUC__ like
  the __format__(printf,...) specifiers. This will allow these
  not be defined when swig is building, so this will fix the
  swig syntax issues.
- Swig's build flags include -Wno-deprecated-declarations becuase the
  bindings need to pull the fill API out, even deprecated functions.
- Rather than compile matchpathcon with static selinux, I just set its
  compile flags to include -Wno-deprecated-declarations. Essentially
  saying, yes use this old interface it's Ok in this instance.

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

[PATCH v3 01/19] security_load_booleans: update return comment
[PATCH v3 02/19] security_load_booleans: annotate deprecated
[PATCH v3 03/19] selinux_booleans_path: annotate deprecated
[PATCH v3 04/19] selinux_users_path: annotate deprecated
[PATCH v3 05/19] rpm_execcon: annotate deprecated
[PATCH v3 06/19] sidget: annotate deprecated
[PATCH v3 07/19] sidput: annotate deprecated
[PATCH v3 08/19] checkPasswdAccess: annotate deprecated
[PATCH v3 09/19] matchpathcon_init: annotate deprecated
[PATCH v3 10/19] matchpathcon_fini: annotate deprecated
[PATCH v3 11/19] matchpathcon: annotate deprecated
[PATCH v3 12/19] avc_init: annotate deprecated
[PATCH v3 13/19] avc: create internal avc_init interface
[PATCH v3 14/19] matchpathcon: create internal matchpathcon_fini
[PATCH v3 15/19] matchpathcon: create internal matchpathcon interface
[PATCH v3 16/19] selinux_check_passwd_access: annotate deprecated
[PATCH v3 17/19] matchpathcon: allow use of deprecated routines
[PATCH v3 18/19] utils: matchpathcon add deprecated warning
[PATCH v3 19/19] Makefile: swig build allow deprecated functions

