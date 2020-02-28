Return-Path: <SRS0=XvAr=4Q=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3224C3F2D2
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 14:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC5AF2051A
	for <selinux@archiver.kernel.org>; Fri, 28 Feb 2020 14:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ja98rwMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbgB1OFk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:05:40 -0500
Received: from mail-pj1-f50.google.com ([209.85.216.50]:50422 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbgB1OFk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Feb 2020 09:05:40 -0500
Received: by mail-pj1-f50.google.com with SMTP id r67so1355511pjb.0
        for <selinux@vger.kernel.org>; Fri, 28 Feb 2020 06:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=r5bN0njgymJd9lmpyrjOFhHpulbLo4fMz5ngLO3yFj4=;
        b=ja98rwMSHrGbimYT+sRVvIUmJzhP2J6T1Eja5cZnQxq6J/P+LLHV/XtSMlbj5B0Pe9
         C7whx3jtaFhu5jAsZrr4jks8ZSl01v9bE/IxLoZyv+SIN2tJJI8sozkEfkwOXlUEcezI
         mnm3O+dpwIlOG6jJHkcGQ4g4bdrKyuIZApVmkSDpDojQf1965JlYuWy7vhh6EhcfBU/g
         HcFfiCRhEH09zY6kCZunfd8x1TbXn8diS+Y8XVCD3YJqRYFGuYzBGzKaKFOvW/fITiBe
         XCeCJpJcIuXcvEBM0fdVkw1F3mYo53UPO1qdJV3ean5QSzh9ckq+QFzGXIj+1yF3ZY70
         8IVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=r5bN0njgymJd9lmpyrjOFhHpulbLo4fMz5ngLO3yFj4=;
        b=lloa867nzmj1WSABwwBPLx0Txt/a/b9XuP0N48w3wLRzhrPGrbPOqCAangLVVb/EiS
         LKJMDGQx7Aj33bKDeaGdFotfV0kIIsAS5msIh0UvxYEHCrKdtQbckLcevjYwFlgQ7iPb
         BSIZSulPTKZvVKeibl3d9Dsu4KiaEO4+63qj10ef7R9WOMA7Rnu+HVFpAhenagUGLWF8
         Zx7oNsPmgwOxfwrh/CAA2ZSJIGTpJ5OLTnOD3wv2gEk8wH/zaqJgFXj64A3tw6iqaS3P
         AG9O7qLBiw7YqmTHrSkNgYi6ASbH5jlNmjwa+DPL0NKfdOLyCmjwSH7sihKUNTwn8x+S
         jBTA==
X-Gm-Message-State: APjAAAV2u6gjtdCPChxKdqEEdUFlzWehRXYms2ax2gMF6IY3OM7gxD+i
        zMSuR+YYDPkh30Wx2vJNHuqrntT0
X-Google-Smtp-Source: APXvYqxYRlUE8Zxld1a6bl9l+QqKsovTY65f4mOQo/nnB4+T0dUlN3Sn7mdhMvm+/sFP5ojlIsmNQA==
X-Received: by 2002:a17:902:401:: with SMTP id 1mr4142512ple.177.1582898738654;
        Fri, 28 Feb 2020 06:05:38 -0800 (PST)
Received: from localhost.localdomain ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id t11sm2656903pjo.21.2020.02.28.06.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 06:05:38 -0800 (PST)
From:   bill.c.roberts@gmail.com
X-Google-Original-From: william.c.roberts@intel.com
To:     selinux@vger.kernel.org, drepper@redhat.com, omosnace@redhat.com,
        stephen.smalley.work@gmail.com, plautrba@redhat.com
Subject: [V2] libselinux: drop dso.h
Date:   Fri, 28 Feb 2020 08:05:20 -0600
Message-Id: <20200228140524.2404-1-william.c.roberts@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAEjxPJ4ae=FLqEDofLwSP0PEeqUqh1WtoSVFb9TrafMhawfhPg@mail.gmail.com>
References: <CAEjxPJ4ae=FLqEDofLwSP0PEeqUqh1WtoSVFb9TrafMhawfhPg@mail.gmail.com>
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Version 2:
  - adds a version to the linker script LIBSELINUX_1.0
  - Adds a patch to drop some additional symbols from the dso.
    - dir_xattr_list
    - myprintf_compat
    - unmap_class
    - unmap_perm

This four part patch series drops the dso.h and hidden_*
macros.

The old dso.h functionality provided libselinux with both control over
external exported symbols as well as ensuring internal callers call into
libselinux and not a symbol with the same name loaded by the linker
earlier in the library list.

The functionality is replaced by a linker script that requires public
API to explicitly be opt-in. The old method required that internal API
be explicitly annotated, and everything else is public. This should help
make it easier to control libselinux DSO hygene going forward.

The second functionality is replaced by compiler option
-fno-semantic-interposition

Note that clang has this enabled by default, and thus doesn't need it.

See:
  - https://stackoverflow.com/questions/35745543/new-option-in-gcc-5-3-fno-semantic-interposition

[PATCH v2 1/4] dso: drop hidden_proto and hidden_def
[PATCH v2 2/4] Makefile: add -fno-semantic-interposition
[PATCH v2 3/4] Makefile: add linker script to minimize exports
[PATCH v2 4/4] libselinux: drop symbols from map

