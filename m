Return-Path: <SRS0=pnJ1=6L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05112C4CECC
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D787C206E2
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 20:23:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXEyjlMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgD0UXV (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726552AbgD0UXV (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 16:23:21 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B70BC0610D5
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:21 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ms17so123872pjb.0
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 13:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=20Eft2J5g1M4fyOz/hMAlrEHH7eRF6IQsNl1eFYPhl0=;
        b=SXEyjlMuP5hqv6EgcxJE0i8iv0M76VXL1AsYEE+JKKN4W9RIrY9iJGfylzutGkf7kb
         TfBgb7xFflrK9SpHzgUR6HUv/44tQfk4kaRcMUtkhEvyuullOIZ+Z750CBvf19y0KDcA
         ZXikf33EdjsMtzTgK/Umbt7NUc18VyN9SAGFl+ZRT76Ef6G60Ie3qXOTi53M6JDBBPSV
         M61LdkuBsp6n/VHZlgfROZ9W/p+OR1GuwicwcoyznM8yPDKz8JtypjeNM5Re3dOBXeNN
         Xl/kjvNBs6+RvqOJI2q9sQRoYJJdx8ejVEjEkyXrvblGviu4mvofGh6CvOUk4pVcihqV
         NGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=20Eft2J5g1M4fyOz/hMAlrEHH7eRF6IQsNl1eFYPhl0=;
        b=BAxWBd+UhmWvtpXxwrAEVXY725rHAnz/1CEL3gfEN5Oa6N9YR7uMtkrhjOnxejmZy3
         EHl2VZnaJVh9Qa6O7ELLzO3Z5re+XG9P9iZb8tarEtcR30WEu4fny3X9GsrBmneX3Oci
         IPcVpquzh2Xo62IKTNRBL49zzpbnlqevi6YEpDlY0P0MU7quFTsdKE+KlKfrCm46V9L2
         7xQZdJB18zqSGk8Ct57UIohWGubmjivx7oZr0ilBjRUFzA/tzakS+G8+mhqmK1XCNwlr
         4+4Tm2OXgxjHYQLjhPRKJqhr5qjqPpf97XT4uGlMbXFUmeG+8/fDH9TBrYBAEo6rcSJ7
         /U/Q==
X-Gm-Message-State: AGi0PuazA7tNdeOHcz356P84LnnVDyjGc4gsV+Tjnu6NhMYKOOmgQIAl
        l2ediW51iKtMX4Xp/kwOFfZV+31uf2k=
X-Google-Smtp-Source: APiQypK2h+/OVV6oibfWaOhgcI2gdtSw4VGakeZ6U7z188A3xAsy1Sm6KD6XdET7dYRJOxdP9/eefA==
X-Received: by 2002:a17:902:32b:: with SMTP id 40mr8258652pld.73.1588019000707;
        Mon, 27 Apr 2020 13:23:20 -0700 (PDT)
Received: from localhost.localdomain ([134.134.139.76])
        by smtp.gmail.com with ESMTPSA id n30sm13329438pfq.88.2020.04.27.13.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:23:20 -0700 (PDT)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     bill.c.roberts@gmail.com
Cc:     plautrba@redhat.com, sds@tycho.nsa.gov, selinux@vger.kernel.org
Subject: [v4] Annotate Deprecated Functions in libselinux
Date:   Mon, 27 Apr 2020 15:22:57 -0500
Message-Id: <20200427202315.4943-1-william.c.roberts@intel.com>
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

V4:
- Drop the internal header interfaces, they were unused and pointless.

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

[PATCH v4 01/18] security_load_booleans: update return comment
[PATCH v4 02/18] security_load_booleans: annotate deprecated
[PATCH v4 03/18] selinux_booleans_path: annotate deprecated
[PATCH v4 04/18] selinux_users_path: annotate deprecated
[PATCH v4 05/18] rpm_execcon: annotate deprecated
[PATCH v4 06/18] sidget: annotate deprecated
[PATCH v4 07/18] sidput: annotate deprecated
[PATCH v4 08/18] checkPasswdAccess: annotate deprecated
[PATCH v4 09/18] matchpathcon_init: annotate deprecated
[PATCH v4 10/18] matchpathcon_fini: annotate deprecated
[PATCH v4 11/18] matchpathcon: annotate deprecated
[PATCH v4 12/18] avc_init: annotate deprecated
[PATCH v4 13/18] avc: create internal avc_init interface
[PATCH v4 14/18] matchpathcon: create internal matchpathcon_fini
[PATCH v4 15/18] selinux_check_passwd_access: annotate deprecated
[PATCH v4 16/18] matchpathcon: allow use of deprecated routines
[PATCH v4 17/18] utils: matchpathcon add deprecated warning
[PATCH v4 18/18] Makefile: swig build allow deprecated functions

