Return-Path: <SRS0=G5zd=6D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D7BC38A30
	for <selinux@archiver.kernel.org>; Sun, 19 Apr 2020 13:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25079206F9
	for <selinux@archiver.kernel.org>; Sun, 19 Apr 2020 13:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgDSNqv convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Sun, 19 Apr 2020 09:46:51 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:56164 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgDSNqv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 19 Apr 2020 09:46:51 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id 0A8115646D8
        for <selinux@vger.kernel.org>; Sun, 19 Apr 2020 15:46:48 +0200 (CEST)
Received: by mail-ot1-f53.google.com with SMTP id e20so5685579otl.2
        for <selinux@vger.kernel.org>; Sun, 19 Apr 2020 06:46:47 -0700 (PDT)
X-Gm-Message-State: AGi0PuaOcD59evjGk09eiFZ5rseDfkIGfAbTDrMwnA9wjadpHgou94Bl
        2iTCPAVKOzrOHeAh3S73GUMIctErElsiLHVON1s=
X-Google-Smtp-Source: APiQypKuw9DXjLT2tmDApE+1jLcI8gV1SdmYz8KLyujRKgeKTUYirER4G4WxopQdozCLjrpf8dCuAMIQf3hzuFWPfYM=
X-Received: by 2002:a9d:bca:: with SMTP id 68mr1803535oth.96.1587304006993;
 Sun, 19 Apr 2020 06:46:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200225200219.6163-1-william.c.roberts@intel.com> <20200416154352.21619-1-william.c.roberts@intel.com>
In-Reply-To: <20200416154352.21619-1-william.c.roberts@intel.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 19 Apr 2020 15:46:36 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==Ote6uQWMjDfNMA=qj79u2ByrnrH==++gDOhPeYD-W5g@mail.gmail.com>
Message-ID: <CAJfZ7==Ote6uQWMjDfNMA=qj79u2ByrnrH==++gDOhPeYD-W5g@mail.gmail.com>
Subject: Re: Annotate Deprecated Functions in libselinux
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Apr 19 15:46:48 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hello,

Does "make install && make install-pywrap" works for you? On both my
development system (Arch Linux with swig 4.0.1) and Travis-CI
(https://travis-ci.org/github/fishilico/selinux/jobs/675842719), swig
fails to build libselinux Python bindings (with your patches):

building 'selinux._selinux' extension
swigging selinuxswig_python.i to selinuxswig_python_wrap.c
swig -python -o selinuxswig_python_wrap.c selinuxswig_python.i
../include/selinux/avc.h:67: Error: Syntax error - possibly a missing semicolon.
error: command 'swig' failed with exit status 1
Makefile:133: recipe for target 'pywrap' failed

The problematic line is:

extern int sidget(security_id_t sid) __attribute__ ((deprecated));

It seems that swig does not understand this attribute.

Nicolas

On Thu, Apr 16, 2020 at 5:44 PM <bill.c.roberts@gmail.com> wrote:
>
> V2:
> - Simplified now that dso.h stuff has been removed.
> - selinux_check_passwd_access has been deprecated and now
>   both selinux_check_passwd_access and checkPasswdAccess
>   are recomending selinux_check_access.
> - matchpathcon is linked statically to get access to deprecated
>   routines and prints a deprecated warning to stderr.
>
> V1:
> I went through and annotated deprecated routines we have in
> libselinux that are mentioned to be deprecated either in code
> comments and/or manpages.
>
> External users, when compiling will see a warning similair to some
> sample output:
>
> a.c: In function ‘main’:
> a.c:18:2: warning: ‘foo’ is deprecated: foo bar msg [-Wdeprecated-declarations]
>   foo();
>   ^~~
> a.c:5:5: note: declared here
>  int foo(void) {
>      ^~~
> a.c:19:2: warning: ‘boo’ is deprecated [-Wdeprecated-declarations]
>   boo();
>   ^~~
> a.c:11:5: note: declared here
>  int boo(void) {
>
> [PATCH v2 01/18] security_load_booleans: update return comment
> [PATCH v2 02/18] security_load_booleans: annotate deprecated
> [PATCH v2 03/18] selinux_booleans_path: annotate deprecated
> [PATCH v2 04/18] selinux_users_path: annotate deprecated
> [PATCH v2 05/18] rpm_execcon: annotate deprecated
> [PATCH v2 06/18] sidget: annotate deprecated
> [PATCH v2 07/18] sidput: annotate deprecated
> [PATCH v2 08/18] checkPasswdAccess: annotate deprecated
> [PATCH v2 09/18] matchpathcon_init: annotate deprecated
> [PATCH v2 10/18] matchpathcon_fini: annotate deprecated
> [PATCH v2 11/18] matchpathcon: annotate deprecated
> [PATCH v2 12/18] avc_init: annotate deprecated
> [PATCH v2 13/18] avc: create internal avc_init interface
> [PATCH v2 14/18] matchpathcon: create internal matchpathcon_fini
> [PATCH v2 15/18] matchpathcon: create internal matchpathcon interface
> [PATCH v2 16/18] selinux_check_passwd_access: annotate deprecated
> [PATCH v2 17/18] utils: matchpathcon to use interal interfaces
> [PATCH v2 18/18] utils: matchpathcon add deprecated warning
>

