Return-Path: <SRS0=G5zd=6D=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8E6C38A30
	for <selinux@archiver.kernel.org>; Sun, 19 Apr 2020 13:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57DBC21973
	for <selinux@archiver.kernel.org>; Sun, 19 Apr 2020 13:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbgDSNhM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 19 Apr 2020 09:37:12 -0400
Received: from mx1.polytechnique.org ([129.104.30.34]:48857 "EHLO
        mx1.polytechnique.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbgDSNhL (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 19 Apr 2020 09:37:11 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ssl.polytechnique.org (Postfix) with ESMTPSA id A481C564AC0
        for <selinux@vger.kernel.org>; Sun, 19 Apr 2020 15:37:07 +0200 (CEST)
Received: by mail-oi1-f180.google.com with SMTP id t199so6448295oif.7
        for <selinux@vger.kernel.org>; Sun, 19 Apr 2020 06:37:07 -0700 (PDT)
X-Gm-Message-State: AGi0PuZVCqeVTMbl5Wfu8/Ai0X1e1Kwcy8rzVnzu1Vw/Cma3TPgL0B/H
        rwxGfb5uMLYXZ84IaXtZhG08QvB/aaTXsvhe65E=
X-Google-Smtp-Source: APiQypKITYFzopU8kWJUqxQpmF0rFk9AKUobfJoRA41x5HF475EtYdE/EJlVG84kgWdzWjQA4+iUlNYiqsI8Qasg26Y=
X-Received: by 2002:a05:6808:3d5:: with SMTP id o21mr4026855oie.40.1587303426525;
 Sun, 19 Apr 2020 06:37:06 -0700 (PDT)
MIME-Version: 1.0
References: <CAFftDdpOQzZazxrEhZZR198GJBiuZOLBMkTnxN3_JnzyD01Kdg@mail.gmail.com>
In-Reply-To: <CAFftDdpOQzZazxrEhZZR198GJBiuZOLBMkTnxN3_JnzyD01Kdg@mail.gmail.com>
From:   Nicolas Iooss <nicolas.iooss@m4x.org>
Date:   Sun, 19 Apr 2020 15:36:55 +0200
X-Gmail-Original-Message-ID: <CAJfZ7==7Q1ur3Jozo0XBovwh6XsM17pqb=CcGv4f6RLzHxbEmQ@mail.gmail.com>
Message-ID: <CAJfZ7==7Q1ur3Jozo0XBovwh6XsM17pqb=CcGv4f6RLzHxbEmQ@mail.gmail.com>
Subject: Re: Deprecated Annotations in libselinux
To:     William Roberts <bill.c.roberts@gmail.com>,
        SElinux list <selinux@vger.kernel.org>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
X-AV-Checked: ClamAV using ClamSMTP at svoboda.polytechnique.org (Sun Apr 19 15:37:08 2020 +0200 (CEST))
X-Org-Mail: nicolas.iooss.2010@polytechnique.org
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 15, 2020 at 11:10 PM William Roberts
<bill.c.roberts@gmail.com> wrote:
>
> So I am reviving the work to look at annotating deprecated functions.
> I was wondering what folks are thinking around the utility program
> matchpathcon, since that interface is deprecated, do we want to:
>
> 1. link that statically so we can use internal (non-deprecated) functions
> 2. update it to use selabel_open and friends.
> 3. Keep it but have it print out "deprecated" and return 1.
> 4. Some mix of options 3 and 1

Hello,
I did not really follow closely why functions are getting deprecated.
>From the patch series, it appears that matchpathcon_init() is being
deprecated in favor of selabel_open(). That can make sense.

>From a CLI perspective, the interface of selabel_lookup seems to be
more complex to use that matchpathcon:

$ matchpathcon /etc/shadow
/etc/shadow system_u:object_r:shadow_t
$ selabel_lookup -b file -k /etc/shadow
Default context: system_u:object_r:shadow_t

Moreover, looking at selabel_lookup --help, it was not clear that the
file for which I wanted the context needs to be given as a -k option,
because the usage line states "[-f file]" (that means something else).
This increases the difficulty of using selabel_lookup instead of
matchpathcon. Therefore as a SELinux user, I would rather keep
matchpathcon program. Would it be difficult to implement option 2
"update matchpathcon to use selabel_open() and friends"?

That being said, if another option is chosen, I will add "alias
matchpathcon=selabel_lookup -b file -k" to my shell configuration and
be good with it. This would work for me because I never used any
option that matchpathcon provides.

Anyway, thanks for working on this subject!
Nicolas

