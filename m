Return-Path: <SRS0=Kf9N=CD=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E38C433E1
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 14:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31C192075F
	for <selinux@archiver.kernel.org>; Tue, 25 Aug 2020 14:06:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtpNoj1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgHYOGi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHYOGh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Aug 2020 10:06:37 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6297DC061574
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 07:06:37 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id t7so10464515otp.0
        for <selinux@vger.kernel.org>; Tue, 25 Aug 2020 07:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qBSIJ9eY2YfXT4hZ9rJtKzoXaxEWyYAI7nIKV43qbws=;
        b=WtpNoj1pCA5R1yZSKVcU/DDjDyAmVDtERajYzCVp9XZsVKUnGXgR/BPw4WlwgOnEEq
         oh050MvAiilySHTiEok3EjM5NVUVM+QSUVQLhY6utawBQSbVREZIDaAiH+q3XUjGVnW4
         AeR75lKAlYHR3vdTg6J0ATLgsH9sCu7H0PF0ixi28EjEBq62BuoKziTUFVOapmjpkHPy
         UOiigHW3cINfOeFsMRzOPy2C/wreIaAa7bLvD+S4cNQVDxS/al4toWZopoHASG8Vp1JC
         GIJBH7jlJdxHK7FUDL4791lAz6KsOecpXtBSDvcfBGnHcGdTbLa8yumZAgStUVLl4uST
         Yigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qBSIJ9eY2YfXT4hZ9rJtKzoXaxEWyYAI7nIKV43qbws=;
        b=hl8IAwmcrHMuW/5Sw93NtyoBWQfIazFn4njEL5iy9ZcTBRlI7Kiuj3TVGlkqi7neVO
         wAcPxNmyT7GgzGmDIwzA4AiBaRNnUNFoQakNfM2d0J7xvVGpacx/21230KqIKw6fod9E
         VR4avJhWcMZaugp5dnx7DgvKQGyZ479/zSGMg1zpzjyXtnP7SS5+11aDALw4xRYaJEe8
         GmjYDQiHztFYehu3f9O/D/5NUFiVIF4JaCFrEpa5Uk4IC5IKYZUi7ynL361PdJ2RA0lO
         zePGdMifFyxwOiZ7OpH7AXv7R8TWJpRCswmSqzN/DvFhhBIYQ9hjd8oHqvK+IbDfRlhn
         N6dQ==
X-Gm-Message-State: AOAM533kYAlC51gmNxJawoziZ8Cgu88tsVC67v8bMFEj/Y6Iv72d8C/5
        oOY4e1Q0/nnEEZTtfA2oDgjtKQStDu16MQWnX2A=
X-Google-Smtp-Source: ABdhPJyIZOXA2LdhsY+92dBg6H0emuzd6gBb2RJBzqryTaMLn4BlxoBBXM2YeKfCJHW4hvONbaEcD6A5+kHFuoYBdq8=
X-Received: by 2002:a9d:67d3:: with SMTP id c19mr6980333otn.162.1598364396646;
 Tue, 25 Aug 2020 07:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200820141850.60244-1-stephen.smalley.work@gmail.com>
 <CAFqZXNupb9Pk636Q=DB7zmRykdetWA0Ng7rh8KNS4f8QUpSLqg@mail.gmail.com>
 <CAEjxPJ5NhStOyzA9ea4HoGDAj1Y93T=f5iqdpbB8K_-kh3Ck+w@mail.gmail.com> <CAHC9VhSomY6oUG2q-w9ek1iuDcQymOsye4-VKH+n3sr4qPdX9g@mail.gmail.com>
In-Reply-To: <CAHC9VhSomY6oUG2q-w9ek1iuDcQymOsye4-VKH+n3sr4qPdX9g@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 25 Aug 2020 10:05:10 -0400
Message-ID: <CAEjxPJ4qzHVh2cTTo-8jhO7G+zZ5DfFPbQEs4pNZJ7zJ2cohCQ@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: enable proper lockdep checking for policy
 rcu access
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        peter enderborg <peter.enderborg@sony.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 25, 2020 at 9:15 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Fri, Aug 21, 2020 at 8:22 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> > On Fri, Aug 21, 2020 at 4:36 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > On Thu, Aug 20, 2020 at 4:19 PM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > In the previous change to convert the policy rwlock to RCU,
> > > > the update code was using rcu_dereference_check(..., 1) with
> > > > a comment to explain why it was safe without taking rcu_read_lock()
> > > > since the mutex used to provide exclusion was taken at a higher
> > > > level in selinuxfs.  This change passes the mutex down to the
> > > > necessary functions and replaces rcu_dereference_check(..., 1)
> > > > with rcu_dereference_protected(..., lockdep_is_held(mutex)) so
> > > > that lockdep checking is correctly applied and the dependency
> > > > is made explicit in the code rather than relying on comments.
> > > >
> > > > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > > > ---
> > > > This is relative to the convert policy read-write lock to RCU patch,
> > > > https://patchwork.kernel.org/patch/11724997/.
> > > >
> > > >  security/selinux/include/conditional.h |  3 +-
> > > >  security/selinux/include/security.h    |  6 ++--
> > > >  security/selinux/selinuxfs.c           | 12 ++++---
> > > >  security/selinux/ss/services.c         | 45 ++++++++------------------
> > > >  4 files changed, 26 insertions(+), 40 deletions(-)
> > >
> > > Thanks for trying this out! I indeed like it more this way. The only
> > > thing I'd suggest is to perhaps name the mutex argument a little more
> > > descriptively, e.g. "check_mutex" or "rcu_mutex". I understand it'll
> > > make it harder to wrap some of the long lines, but I tend to think
> > > it's worth it in this case.
> >
> > I considered calling it policy_mutex but wasn't sure it was
> > necessary/worthwhile and also thought it might be confusing (obvious
> > question becomes why isn't that mutex part of struct selinux_policy,
> > but that's a layering thing).  I'll wait to see what name Paul prefers
> > before spinning another patch.
>
> As I mentioned in the RCU patch thread, my preference at this point in
> time is to address this with comments and not pass the mutex into the
> security server.

One alternative would be to move the mutex from selinux_fs_info to
selinux_state, at which point the mutex would already be accessible to
the security server code through the state parameters.  This also
makes sense from the perspective that the mutex is already used to
synchronize not only selinuxfs-private state (e.g. pending bools) but
also policy changes.  I think this will be needed anyway for the
patches to measure SELinux state because that call chain does not go
through selinuxfs and thus has no access to selinux_fs_info.

>
> > > Speaking about wrapping lines... I noticed only now that in this and
> > > earlier patches you align wrapped argument lists only by tabs (without
> > > extra spaces to align to the first argument). I'm not sure what is the
> > > preferred kernel style in this case, but I personally find the finely
> > > aligned argument lists much nicer to read (and I have always been
> > > aligning them like this in my patches). Obviously, I can't enforce my
> > > preferred style here, but I thought I'd raise this, since I had the
> > > impression we were trying to follow this style previously for new code
> > > (could be just confirmation bias on my part, though) and it might not
> > > have been your intention to change it (changed editor/settings?).
> >
> > I'm using the emacs mode settings from
> > Documentation/process/codingstyle.rst.  I don't see anything in the
> > coding style document to suggest use of extra spaces for aligned
> > argument lists; if anything use of spaces rather than tabs for
> > indentation seems discouraged.  I don't really care either way but
> > would like editor settings to ensure consistency.
>
> FWIW, my preference is for aligned argument lists, for example:
>
>   void write_program(char *language,
>                      char *description);
>
> ... with the understanding that tabs are used as much as possible and
> that spaces are only used to make up the difference when the gap is
> less than a tab (8 chars).

I don't suppose you have editor settings to help automate this?
