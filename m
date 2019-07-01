Return-Path: <SRS0=9hq+=U6=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152ABC5B578
	for <selinux@archiver.kernel.org>; Mon,  1 Jul 2019 20:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBA920663
	for <selinux@archiver.kernel.org>; Mon,  1 Jul 2019 20:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="zK3eddfZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfGAUkX (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 1 Jul 2019 16:40:23 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35851 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfGAUkX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 1 Jul 2019 16:40:23 -0400
Received: by mail-lf1-f68.google.com with SMTP id q26so9724494lfc.3
        for <selinux@vger.kernel.org>; Mon, 01 Jul 2019 13:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhBgh/MkgSBMv3ODP8kXtzfCmYcCK8Oylmokposzhdw=;
        b=zK3eddfZNyVy3htnMG/wmHc2lCyF/DF0DqnwwPyk46Uc4NgyQwiTCNlo3rsxCepQ/v
         BlfE9FcDzFARbkj8HovAIAKIubRkYH987WTU+mtt1kEaEFfO3vepiXY2t972NlxQVQK4
         WCdG8rMYzEEyi3IH6yfKv4uMunNp7E2kTzAkwkays3SB23Y1Lop4AJJ0MXNZJKSWnUzd
         I59KcyKvK+hS2By9mmmUlkk1G/zaqGRm91DA0LzNXNLfwfEAn2IH8FT0O9+rYL+Tukdg
         GnxMaqVIc42uypVCS2Fpf5gyOWZlLkmozGmbNTwaHKrfb+pLaJEYPcdP7bBIMuYTLxci
         sK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhBgh/MkgSBMv3ODP8kXtzfCmYcCK8Oylmokposzhdw=;
        b=jPeRl1OgD3dtbGFaCAGnJoGrD1+AKt1HN4707x2AzIPbAvzxSEaqc9gqxbVuGNnEGU
         j2YOy1100XuwoxwS/TlTErhq8i98EH48nN8/50flzutlti+9m5doOUcKHZ4pz2TrsrAP
         dBDus6NEKv5w9UjHe4flSSK7YbfJgYrxEj6cbbK2Rqctx+Me5Sbv1zl03PSOh1O0sbBh
         xd1gGwcPi8RWyXFpS6BwNinMZebSUYvC8BDlSojxpDsmEN4aIhk/pZtFFoOZ9YMiu+gJ
         a+R0aLBA1riqIjrab68fz6rCJEi3h0xPAtL6Wps5eJbCaFa9geTqfofK92fBVleO4SIF
         8mcQ==
X-Gm-Message-State: APjAAAVS63VnVFEELG2+I6edAKFdv1hdouOcYokVwEp95pa9jdgT4Oop
        69c9KKY/HbDOo91JpCfdmz/oljyN01AQMRDGJgxH
X-Google-Smtp-Source: APXvYqzzhSAHQcPRAh6guaIvbAU0FF7A23Bzg+QFUyZHVOFCRf5F152rlANY7hqDp6WfYMutSNXYgtDhVdfiL387NkA=
X-Received: by 2002:ac2:5310:: with SMTP id c16mr6363668lfh.119.1562013620246;
 Mon, 01 Jul 2019 13:40:20 -0700 (PDT)
MIME-Version: 1.0
References: <20b1e7b386ba06f013e5e4206cca1bb487d90a68.1561640731.git.rgb@redhat.com>
In-Reply-To: <20b1e7b386ba06f013e5e4206cca1bb487d90a68.1561640731.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 1 Jul 2019 16:40:08 -0400
Message-ID: <CAHC9VhTQt6t--Bo=ZwMCt4C+woNp-9LexcbMvroMC52kPwaWjQ@mail.gmail.com>
Subject: Re: [PATCH ghak57 V2] selinux: format all invalid context as untrusted
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacec <omosnace@redhat.com>,
        Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 27, 2019 at 12:48 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> The userspace tools expect all fields of the same name to be logged
> consistently with the same encoding.  Since the invalid_context fields
> contain untrusted strings in selinux_inode_setxattr()
> and selinux_setprocattr(), encode all instances of this field the same
> way as though they were untrusted even though
> compute_sid_handle_invalid_context() and security_sid_mls_copy() are
> trusted.
>
> Please see github issue
> https://github.com/linux-audit/audit-kernel/issues/57
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  security/selinux/ss/services.c | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)

Generally rc6/rc7 is a bit late for things, but this is pretty
straightforward so I think it should be safe.  Merged into
selinux/next.

-- 
paul moore
www.paul-moore.com
