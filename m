Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF5EC433EF
	for <selinux@archiver.kernel.org>; Tue, 12 Oct 2021 15:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0425161076
	for <selinux@archiver.kernel.org>; Tue, 12 Oct 2021 15:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbhJLPCl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 12 Oct 2021 11:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhJLPCl (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 12 Oct 2021 11:02:41 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D7FC061570
        for <selinux@vger.kernel.org>; Tue, 12 Oct 2021 08:00:39 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ec8so729388edb.6
        for <selinux@vger.kernel.org>; Tue, 12 Oct 2021 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F9v2tsR8yi6K0apGvpNwcYZaOTcOOEcmQbu1A2f9nBg=;
        b=HM4zX20pgBNz15oI7lh46YcvpRpdCBmLke4yNKcQitDMVmqdRsw3FYYiNzDP7VBhkD
         LTQyXt/6odnbENvh2kU0ZT2u1OfW63HaIZm31NFfvtL0nKXIb0weWFFwp7dfxh1TCGw9
         uq4TlP7JLk8UErAiVVPgnlgkjX6GDmjL7pPseTCyoXBT5KPuOxGekm8wsJ0aadBhAHgW
         0i4EjEmO7ZPSGALn/MYno3HjnvjPgWja1BlOuCp7PN85DsOLjvuVaK0ZWA9QdZvg3tiK
         L+3CEeb1m1SI8VU1Oec21eHx4YoBPs+eP4Hn+UmLzHyrCtF3nMpNyhv32PE1DOGGlcpl
         ciBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F9v2tsR8yi6K0apGvpNwcYZaOTcOOEcmQbu1A2f9nBg=;
        b=8Cl6LFagjgm0FyzPUSvb5uo/wY6JR5sBHDBcDbH+4Scbz67OBHkFCEx0y+ftzh6NOo
         OXVlcbRuuvEEA/9Er8hwD6+mCh7rEjGgYrbcomvFvzJysi57sAJJT9+iowmL1Oy+oQZj
         0sYBY+UkVfuNLcpaO6pAGlU5rvFdDVu/ykKKz5RWdz7xs1hPfJaAndUrKLqEIJULG2qD
         dxhkKw9iUIkuUndvQ91zTb65qUDaqkEA5PIqFIzp7RnlgOROdFnSVuviZRD5KGH+pTDd
         r5jnrJysovCm9hyew3b9UHH07CRMhjKyYH7LoMMKdK2f2X3TKn3ZMkODStn2NCxtCIo8
         k3Pg==
X-Gm-Message-State: AOAM532EQMJk7vEyK3bq8qEytnGMUmmK3g1AF0UndmZcsEKf0KAF3X+R
        h9UZXy1KhVQrGJA71GSwW+cviQcUqrCdqr0oZ5y5
X-Google-Smtp-Source: ABdhPJyII5JkgE4xi9+sdqZ8DQ6h1ycBx/7H206XZ6TG3cRAfxD39cHvFtfkawGv8c822tiy6eGYT03lOisZVF7YMOg=
X-Received: by 2002:a17:907:7601:: with SMTP id jx1mr34347014ejc.69.1634050837769;
 Tue, 12 Oct 2021 08:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210728140313.68096-1-omosnace@redhat.com> <CAHC9VhTDagTt1CKDRPkVrcvHwWPbSzzPp3HSS3ZzsbLapTBAxw@mail.gmail.com>
 <CAFqZXNuT=-m2QVgw+Awm3HcK5pt8niKb+yu2Tspy2RCsLByrWQ@mail.gmail.com>
 <CAHC9VhT6YcAWn4KrsfjpJQGDetEVy7LNh8DsrMrycW8y57Y20Q@mail.gmail.com>
 <CAHC9VhQF9R76ojBBrAQ=WHOAgHNGKJDobY+a_qohJJCQWQDw4w@mail.gmail.com>
 <CAFqZXNs_hU_r6uxiUiWPGiYhJ5EzdxMWWwtbp-ZPMfaZ1rTNCg@mail.gmail.com>
 <CAHC9VhRQdyF0tMGLgW1dzvwrKeH32z-n49ohxbhwFQLTVghxjg@mail.gmail.com> <CAFqZXNv7nWMvvZQDJjbFJ1vuyrQL=7B3Fxrsb660prJgC+jLhA@mail.gmail.com>
In-Reply-To: <CAFqZXNv7nWMvvZQDJjbFJ1vuyrQL=7B3Fxrsb660prJgC+jLhA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 12 Oct 2021 11:00:26 -0400
Message-ID: <CAHC9VhRmWFngOjAENcimNY-Ha9x8PFXuJLijqz=fn85khwDv_g@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix race condition when computing ocontext SIDs
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Sujithra Periasamy <sujithra@google.com>,
        Xinjie Zheng <xinjie@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Oct 12, 2021 at 10:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Oct 12, 2021 at 1:27 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > Okay.  I'm going to go ahead and merge this simply because it does fix
> > a visible problem, but I really would like you to revisit this in the
> > near future to see if there is a better fix.
> >
> > While I'm going to mark this with the stable tag, considering the
> > relatively low rate of occurrence on modern kernels and the fact that
> > I'm not in love with the fix, I'm going to merge this into
> > selinux/next and not selinux/stable-5.15.  This should give us another
> > couple of weeks in case you come up with a better fix in the near
> > term.
>
> OK, though it seems something went wrong when you applied the patch -
> in the commit it's missing the subject line:

Thanks for the heads-up, I fixed the subject line and force pushed the
branch.  Portions of the patch had to be merged by hand and when I
copied the description over I must have missed the subject line.

-- 
paul moore
www.paul-moore.com
