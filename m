Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BAEC433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43E592075E
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 14:05:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="bW/rocNX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgHZOFq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHZOFo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 10:05:44 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BF9C061371
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 07:05:43 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id q21so637002edv.1
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 07:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=li8UpKpsGyV3l189MXyJIaQ4CrgJme43rMUDZKsgeOw=;
        b=bW/rocNXJBz9MaeSL4chEYYe8PQH7YgZFhUoC4WJV2mvmZDUWFS4519X6NfkrbbIKj
         4r5XigjZyVQxxQt8782dzvFb2dOChjNT+QRqCtxObpsVvBNd8w+oxDpvtH7eRTEj5KIU
         Vw4aefMUZRkRW4xJejt5Ggp54eCqZhJBLFTCdwF+HZoQDDYPnKENuS42m7oRc6f7OfRF
         qeVP5cydSU1fWidy0XUJud2ZaP/GCYZnTzJWVANhjeGCsQzpcoEJHmtcC+xyUQjNnszZ
         D4Q+tQlL+L5rN0T4z39qknEKHl0hrSqRXUq6+T9D1loBhJxGwbu6o2aRqIvxt9q222Rw
         kdZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=li8UpKpsGyV3l189MXyJIaQ4CrgJme43rMUDZKsgeOw=;
        b=mckRAMtRPww4w9ZliM2/qa67p9nPkLojIwuPXtu678ZUf7PMHsBuxXir5BuJNM3+mS
         1p4HSqRvmMmCfn/VMrUrJIXIfKSQu/edE9oq487xywaXRxGiFUwecKMZke1tg8D6ieOV
         h65iichc/gdptU81OA8D73x9QXL6DtB9wlzgGqPsA71FZbzAJaffaC0A3p3xzZSvVDa5
         aYYsmf85wR4s7W9kKqXrPmbWikNjzlxVyJipbyOa9q0vQXEgRpyRk+hjgvlADu/SGXdG
         7iT44INipo2Id8InsPx2V+nRDthrIE0TKxmoj8veGjq+jfPfvg+el7oZNW3ZkVQ+whBq
         KUaQ==
X-Gm-Message-State: AOAM530BMfNVTq6IH1HWkJ94zZKVuncjFolxpjwPp6yasmhBLHfDs/i5
        D3LsZyC2xBBgxbTLYOLfLmix35WnxLygcXZ7Qsz+
X-Google-Smtp-Source: ABdhPJz9kHOeq9jlSxZOBbfhAafHcFuR/D5Q/yDc8vDgB6pQ0YjLkFlo3kcjH0vL3/mKL9dUAbKhlJjVqM2g1KgAVcQ=
X-Received: by 2002:aa7:c6ca:: with SMTP id b10mr6945883eds.269.1598450741279;
 Wed, 26 Aug 2020 07:05:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200820141850.60244-1-stephen.smalley.work@gmail.com>
 <CAFqZXNupb9Pk636Q=DB7zmRykdetWA0Ng7rh8KNS4f8QUpSLqg@mail.gmail.com>
 <CAEjxPJ5NhStOyzA9ea4HoGDAj1Y93T=f5iqdpbB8K_-kh3Ck+w@mail.gmail.com>
 <CAHC9VhSomY6oUG2q-w9ek1iuDcQymOsye4-VKH+n3sr4qPdX9g@mail.gmail.com> <CAEjxPJ4qzHVh2cTTo-8jhO7G+zZ5DfFPbQEs4pNZJ7zJ2cohCQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4qzHVh2cTTo-8jhO7G+zZ5DfFPbQEs4pNZJ7zJ2cohCQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 26 Aug 2020 10:05:30 -0400
Message-ID: <CAHC9VhT-BB-yWjeUzhn8f9ecS0iFSjFWZ4Wc+P558sgswUkd7Q@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: enable proper lockdep checking for policy
 rcu access
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        peter enderborg <peter.enderborg@sony.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 25, 2020 at 10:06 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Tue, Aug 25, 2020 at 9:15 AM Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Fri, Aug 21, 2020 at 8:22 AM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Fri, Aug 21, 2020 at 4:36 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > On Thu, Aug 20, 2020 at 4:19 PM Stephen Smalley
> > > > <stephen.smalley.work@gmail.com> wrote:

...

> > As I mentioned in the RCU patch thread, my preference at this point in
> > time is to address this with comments and not pass the mutex into the
> > security server.
>
> One alternative would be to move the mutex from selinux_fs_info to
> selinux_state, at which point the mutex would already be accessible to
> the security server code through the state parameters.  This also
> makes sense from the perspective that the mutex is already used to
> synchronize not only selinuxfs-private state (e.g. pending bools) but
> also policy changes.  I think this will be needed anyway for the
> patches to measure SELinux state because that call chain does not go
> through selinuxfs and thus has no access to selinux_fs_info.

That seems reasonable to me.

> > > > Speaking about wrapping lines... I noticed only now that in this and
> > > > earlier patches you align wrapped argument lists only by tabs (without
> > > > extra spaces to align to the first argument). I'm not sure what is the
> > > > preferred kernel style in this case, but I personally find the finely
> > > > aligned argument lists much nicer to read (and I have always been
> > > > aligning them like this in my patches). Obviously, I can't enforce my
> > > > preferred style here, but I thought I'd raise this, since I had the
> > > > impression we were trying to follow this style previously for new code
> > > > (could be just confirmation bias on my part, though) and it might not
> > > > have been your intention to change it (changed editor/settings?).
> > >
> > > I'm using the emacs mode settings from
> > > Documentation/process/codingstyle.rst.  I don't see anything in the
> > > coding style document to suggest use of extra spaces for aligned
> > > argument lists; if anything use of spaces rather than tabs for
> > > indentation seems discouraged.  I don't really care either way but
> > > would like editor settings to ensure consistency.
> >
> > FWIW, my preference is for aligned argument lists, for example:
> >
> >   void write_program(char *language,
> >                      char *description);
> >
> > ... with the understanding that tabs are used as much as possible and
> > that spaces are only used to make up the difference when the gap is
> > less than a tab (8 chars).
>
> I don't suppose you have editor settings to help automate this?

Not really, but some of that is simply because I tend to bounce around
between editors depending on what type of work I'm doing.  My fingers
have more or less gotten used to it and do the right thing as a matter
of habit these days.

In the non-kernel projects I maintain there is a script which you can
run that checks the formatting/style, and optionally fixes it for you
(in the case of C, it's a wrapper around astyle); I lean on that a lot
for those projects.  It would be nice to have something like that
here, but we would need to do a lot of style fixes first.  I keep
threatening to do that, but it never quite seems worth it; perhaps I
should start doing that slowly.

-- 
paul moore
www.paul-moore.com
