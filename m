Return-Path: <SRS0=yj3S=6M=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0D3C83000
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 21:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D29462072A
	for <selinux@archiver.kernel.org>; Tue, 28 Apr 2020 21:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgD1VZ2 convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:25:28 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:56489 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgD1VZ2 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Apr 2020 17:25:28 -0400
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id EA4CF5648B6
        for <selinux@vger.kernel.org>; Tue, 28 Apr 2020 23:25:24 +0200 (CEST)
Received: by mail-oo1-f43.google.com with SMTP id b17so5053174ooa.0
        for <selinux@vger.kernel.org>; Tue, 28 Apr 2020 14:25:24 -0700 (PDT)
X-Gm-Message-State: AGi0PuZvp0Bc1kP7J9XSUdgPnD2qFfSleWaoyNC3LrtP05116F26dxcH
        41xzs6ybDVk56fDQqXanwF5iksjFIqnfKe+i1wc=
X-Google-Smtp-Source: APiQypKLNh5lJi4bKOpXmIbQTMUUrnBslGCji/tr8dvcjTS6hcauMKasW0Dw0Il09roaWSt9SzP0/2EJxTHP7ap4OVk=
X-Received: by 2002:a4a:accf:: with SMTP id c15mr24414514oon.29.1588109123763;
 Tue, 28 Apr 2020 14:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200225200219.6163-1-william.c.roberts@intel.com> <20200427202315.4943-1-william.c.roberts@intel.com>
In-Reply-To: <20200427202315.4943-1-william.c.roberts@intel.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Tue, 28 Apr 2020 23:25:12 +0200
X-Gmail-Original-Message-ID: <CAJfZ7===D-jb_OGnMjyZw4JLx-=hCwUBHChHBK9h=rvwfgN15g@mail.gmail.com>
Message-ID: <CAJfZ7===D-jb_OGnMjyZw4JLx-=hCwUBHChHBK9h=rvwfgN15g@mail.gmail.com>
Subject: Re: [v4] Annotate Deprecated Functions in libselinux
To:     William Roberts <bill.c.roberts@gmail.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Tue Apr 28 23:25:25 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 27, 2020 at 10:23 PM <bill.c.roberts@gmail.com> wrote:
>
> V4:
> - Drop the internal header interfaces, they were unused and pointless.
>
> V3:
> - Made the deprecated annotation dependent on __GNUC__ like
>   the __format__(printf,...) specifiers. This will allow these
>   not be defined when swig is building, so this will fix the
>   swig syntax issues.
> - Swig's build flags include -Wno-deprecated-declarations becuase the
>   bindings need to pull the fill API out, even deprecated functions.
> - Rather than compile matchpathcon with static selinux, I just set its
>   compile flags to include -Wno-deprecated-declarations. Essentially
>   saying, yes use this old interface it's Ok in this instance.
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
>       ^~~
> a.c:19:2: warning: ‘boo’ is deprecated [-Wdeprecated-declarations]
>   boo();
>   ^~~
> a.c:11:5: note: declared here
>  int boo(void) {
>
> [PATCH v4 01/18] security_load_booleans: update return comment
> [PATCH v4 02/18] security_load_booleans: annotate deprecated
> [PATCH v4 03/18] selinux_booleans_path: annotate deprecated
> [PATCH v4 04/18] selinux_users_path: annotate deprecated
> [PATCH v4 05/18] rpm_execcon: annotate deprecated
> [PATCH v4 06/18] sidget: annotate deprecated
> [PATCH v4 07/18] sidput: annotate deprecated
> [PATCH v4 08/18] checkPasswdAccess: annotate deprecated
> [PATCH v4 09/18] matchpathcon_init: annotate deprecated
> [PATCH v4 10/18] matchpathcon_fini: annotate deprecated
> [PATCH v4 11/18] matchpathcon: annotate deprecated
> [PATCH v4 12/18] avc_init: annotate deprecated
> [PATCH v4 13/18] avc: create internal avc_init interface
> [PATCH v4 14/18] matchpathcon: create internal matchpathcon_fini
> [PATCH v4 15/18] selinux_check_passwd_access: annotate deprecated
> [PATCH v4 16/18] matchpathcon: allow use of deprecated routines
> [PATCH v4 17/18] utils: matchpathcon add deprecated warning
> [PATCH v4 18/18] Makefile: swig build allow deprecated functions

Hello,
Thanks for this v4. Some commit descriptions still use "...2" instead
of "..._internal", but I do not think this needs to be fixed in
another iteration, because the patches look otherwise good to me.

Acked-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Feel free to apply them (eventually with fixed descriptions).
Otherwise I will apply them tomorrow.
Nicolas

