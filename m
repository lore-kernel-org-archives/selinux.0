Return-Path: <SRS0=kOa9=25=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60728C00523
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 05:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D61B20705
	for <selinux@archiver.kernel.org>; Wed,  8 Jan 2020 05:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="JReHiQD0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgAHFcB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Jan 2020 00:32:01 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34421 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgAHFcB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Jan 2020 00:32:01 -0500
Received: by mail-lj1-f196.google.com with SMTP id z22so2028660ljg.1
        for <selinux@vger.kernel.org>; Tue, 07 Jan 2020 21:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y6uGjSvwGqyRaKbilF+7k625RyBcy6T5uOwOnttNw+g=;
        b=JReHiQD0jsrafaebTPg8BD8R/lN9G3a6tudkq5kSg2HuKcoR+/FCfrkLqyH0oqbBDD
         IFPuOLAJT6Eff/uhG0mXPwqZcLLAiM7+I/f6YEMHOdz4YYNp7YPQP+m3qvKmLgGHlghR
         vNHIE+5zQFDW2JSpa0sft3PyQFHUsimFckM15Ae0EA9uvEVP7C/07cudMgLWHk+/wY6w
         ptpXxtreX8a/Tqc8vOHG6TkvHG4jYIyfH3hYilM3IjdhG+o/20t9SuVACTKKEMvGXBAN
         br+T73fnOcW2ji3YbtBR16LffdKwQjw9QClU9SjLU2fgNVq1KUnhrPgs4cg57mGCrUvi
         C3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y6uGjSvwGqyRaKbilF+7k625RyBcy6T5uOwOnttNw+g=;
        b=EVHrE976DVDyXdMi/iQh8//uZYJawv72LfOSJ9dVwlMJCa+DGsqkU1NmvmDOVfgC6R
         57EhKPNl0fFDm9p3W9dLHwofi5LhWYfvSvRRaFp2Htdio7Q+QZfpsQzgRgkCPbQjq8GY
         wDKWAsiI2nSU0GB8rqZGKh3uPVeAfWe2Do6q2yuVk7Xa7neflA85bM3oYhxtFdX1na1U
         oQ21q0mB+CFM1kIk14pNo+Odyqv90+VHwtS8juFHzVwr6FaflvhgVZj1aywYhylB4vdp
         f7/6R9lhfx6OirX3JI41N+yIBhIH+hYWVxOJ97PFsKh7gLJCvz6jFGHu0p01YSyoT7FE
         wUaQ==
X-Gm-Message-State: APjAAAWxX/bHE0X2d6DvG0qPSwmkjYmZpdFAL9gMpAunxF4x886X9Rm1
        GOXxALYB9YFxSItSLMiKNrh26LlnEBJFVe3MUYbd
X-Google-Smtp-Source: APXvYqwUun3RHTHLjtMbXzpIHIqIE1hS6s44/RZXWtDxmUGIuRtOfcb9SadQKJhoYzwxbcuMmdQTu/dNsP3Qra3HB0Q=
X-Received: by 2002:a05:651c:118b:: with SMTP id w11mr1837093ljo.54.1578461519660;
 Tue, 07 Jan 2020 21:31:59 -0800 (PST)
MIME-Version: 1.0
References: <20200107133154.588958-1-omosnace@redhat.com> <20200107133154.588958-3-omosnace@redhat.com>
 <bad81aeb-c21f-c5be-12a1-61912d04573a@tycho.nsa.gov>
In-Reply-To: <bad81aeb-c21f-c5be-12a1-61912d04573a@tycho.nsa.gov>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Jan 2020 00:31:48 -0500
Message-ID: <CAHC9VhRMLJLSUY5VfdDRv=OuyLkvzsyqfpNhf_SfC9V8OALJ4g@mail.gmail.com>
Subject: Re: [PATCH 2/2] security, selinux: get rid of security_delete_hooks()
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        selinux@vger.kernel.org,
        John Johansen <john.johansen@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Micah Morton <mortonm@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jan 7, 2020 at 9:46 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 1/7/20 8:31 AM, Ondrej Mosnacek wrote:
> > The only user is SELinux, which is hereby converted to check the
> > disabled flag in each hook instead of removing the hooks from the list.
> >
> > The __lsm_ro_after_init macro is now removed and replaced with
> > __ro_after_init directly.
> >
> > This fixes a race condition in SELinux runtime disable, which was
> > introduced with the switch to hook lists in b1d9e6b0646d ("LSM: Switch
> > to lists of hooks").
>
> Not opposed (naturally, since I suggested it) but my impression from the
> earlier thread was that Paul preferred the less invasive approach of
> your original patch (just reordering the hooks) as a short term fix with
> an eye toward full removal of disable support in the not-too-distant future.

Unless we are seeing wide spread breakages (I don't think we are), or
we decide we can never remove the runtime disable, I still prefer the
hook-shuffle over the changes proposed in this patchset.

-- 
paul moore
www.paul-moore.com
