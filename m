Return-Path: <SRS0=RPjD=AF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB57C433E0
	for <selinux@archiver.kernel.org>; Wed, 24 Jun 2020 01:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33B822073E
	for <selinux@archiver.kernel.org>; Wed, 24 Jun 2020 01:08:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="R+hZay4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388161AbgFXBI7 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388117AbgFXBI6 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Jun 2020 21:08:58 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F7EC061573
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 18:08:56 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id mb16so703084ejb.4
        for <selinux@vger.kernel.org>; Tue, 23 Jun 2020 18:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+LSCvu6f3FjjMrksDWqB1C7ZsIEP9dwQuz62TFY2txI=;
        b=R+hZay4tvloLX96rzedk+i9Z82LSp3SXKFW59SAU3924ettCP2V//xCNy1i4Z7Geiu
         /yXBGbVu81qiMsCf4Xc8qKkMFn1rUwN4gxhhvQzU+wrI8g4XCo2fUcDPYn2wExVwvxG5
         WkdJVO3AuNpRf608mRvMopkkkc3zUXtbwk0oTDntlop9UTM6sfUatw4Xqv0Py7nJ7LrJ
         0AMQJJOmBquHLDlQxW+ekXZb3mmi1xBPbacpPfbeZhd/EDlMLfrajZ2UAH43VbNRIDJy
         glKUtPGXt/P3kEJyJI13rUsfriCA4B9HSTyz2DVJASD8QFasuA9n2uEO7wHGz+VyRyqt
         FPFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+LSCvu6f3FjjMrksDWqB1C7ZsIEP9dwQuz62TFY2txI=;
        b=m7/NwZ5F7ZqbxOqL7AsYE/n+oAajzlKg3kHP25MdECmszMFumPt6TUP6RGClwg+Fxy
         4bFj+a0kWTJSSnB9v0Mi9sW8a3Ai4T7ycvaCOBpuZd1K9cv3i25K74IY+iPvr9Zcf9vJ
         41+rXlrtzL0TBIom8jhYVdb5T/aUzFyVjJG+2p1DQkMwnw/MJUSjAxHGFk+A98GXasOq
         2ODR9xJu7eHMYNH9YGCBXaHEl+xTUzqDq+TzLcE/RtCeE0QMPkiGUM38p5r4ZxlwuJwN
         uVXmP4UMvVMHCCYPzpC3gfxCXfSA5ESJJjR5gjQyQFXHNRhSVvHpRyEztNE/9ddJQ8cP
         IQGw==
X-Gm-Message-State: AOAM532wdUOzl5DK2IRAiwLFzZB4cNAl+64Vx2gU2OwVYJcu/ycXmJuK
        p3Ez7kjiNok0S3f5C3OnCpuJYIsoNpqCVJ3PDjM7
X-Google-Smtp-Source: ABdhPJzwVgTYSvI1s/sYlAVEHO2KKp4EqyvRn3YAQFgjO5ISiuhlpHZUZUfifmjUY4S7297tqmVwQeVxkohcgFecEKw=
X-Received: by 2002:a17:906:2b81:: with SMTP id m1mr21992078ejg.488.1592960935088;
 Tue, 23 Jun 2020 18:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200617192309.69595-1-stephen.smalley.work@gmail.com> <CAEjxPJ6EHbCh+S1D8dm61Mw7YkMDHELNHVwKEtinNciaoTzYoQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ6EHbCh+S1D8dm61Mw7YkMDHELNHVwKEtinNciaoTzYoQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 Jun 2020 21:08:44 -0400
Message-ID: <CAHC9VhRGchDjwdM_KsBUnQF7krWuArYahOB+G=ZMZKd1zbUr3Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: log error messages on required process class / permissions
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        bauen1 <j2468h@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 18, 2020 at 10:03 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Wed, Jun 17, 2020 at 3:23 PM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > In general SELinux no longer treats undefined object classes or permissions
> > in the policy as a fatal error, instead handling them in accordance with
> > handle_unknown. However, the process class and process transition and
> > dyntransition permissions are still required to be defined due to
> > dependencies on these definitions for default labeling behaviors,
> > role and range transitions in older policy versions that lack an explicit
> > class field, and role allow checking.  Log error messages in these cases
> > since otherwise the policy load will fail silently with no indication
> > to the user as to the underlying cause.  While here, fix the checking for
> > process transition / dyntransition so that omitting either permission is
> > handled as an error; both are needed in order to ensure that role allow
> > checking is consistently applied.
> >
> > Reported-by: bauen1 <j2468h@googlemail.com>
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
>
> BTW I considered and even put together an initial patch to instead
> make the process class and transition permissions optional but thought
> it was unnecessary complexity for no real gain.  One would end up with
> a system where new processes would be treated like objects for
> labeling (e.g. object_r for the role, inherit type from related object
> in this case the executable file) and role allow rules would be
> unenforceable.  I suppose we could change the test of the process
> class to be based on the kernel value rather than the policy value,
> which would at least provide sane defaults for labeling.

Yes, I think this patch is fine, it seems reasonable to require some
basic policy definitions.

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
