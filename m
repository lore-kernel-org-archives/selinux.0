Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EBDC433EF
	for <selinux@archiver.kernel.org>; Tue, 19 Jul 2022 14:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238795AbiGSOgf (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 19 Jul 2022 10:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238193AbiGSOgR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 19 Jul 2022 10:36:17 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C7E4D4D8
        for <selinux@vger.kernel.org>; Tue, 19 Jul 2022 07:28:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so9280726wmb.3
        for <selinux@vger.kernel.org>; Tue, 19 Jul 2022 07:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CkaWQG+Gs1/Da1H0Lmbob0qLS6auhAghmN2GPC7wXdw=;
        b=FadxItWt5HfEbkB3+k6otqYeEBqv4a5RkzKOxnol822zoiz3vRfGG3fwIHRNk2DyQ7
         ctnITQTcT9GyWzecLwYY4tzZFPMFtiN5fsj4cIpIwGiLKeagln0fiig2TwFoVUR7X8gO
         wrbb454HrUYfXM+k/99btV38j3XDFQGzTY8gAor4Acnz0lJrwB+IPDAndff8IEdMNqBn
         RHdjboXYD3bt6I3wuRM673l/HtlY5TrZJICRYQO4iD1ic7w7YhRNBV7llpbIn+HM0m0S
         ZVZRtqMJ10jEFXNvN9Wnc3XufgaKyycn96pfVbYoLAJtQfMSjwbP8Nca6Bqw5XHbWAyH
         JAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CkaWQG+Gs1/Da1H0Lmbob0qLS6auhAghmN2GPC7wXdw=;
        b=rd9fkhb5tevZVpznktPGtg7hHxobXupqzOcy8gSVhs8NWkjAf4ITyPxizKl4q7Rsgt
         53T9Lvcs4e/7BItHYusY8j0HTqzWPHoff05QUxOna9XspSvL3r/fusXe7t01/j6om/gd
         zN23tQxh+l1+iFV4rHxh03LhcqyhZae3jO8IQQP6+a0keiJqI0jWYm5F1RjRw7z/V2Ff
         EiauLl0vyZZ21U6ZOm7ccF/8GGbMhDXoJGMOmTDpRKbZ/hFp1Xm62TNXqixg5iw4F6U6
         /Xrh6U2q9fNFPXlYAIeAUC3cxmOSn/YHg53irbGycNS+oNTU8+kXpxe/EtrJFfHvQLi2
         fGuw==
X-Gm-Message-State: AJIora93lXfXXQuXh8BK0YHanYQfe79xj/4Y3RzlFvRZyMBn7LOWpIYI
        Osc/ii4LNw0jdBDoQzOee2vtMqPVjqS13vUHps1+4j7vag==
X-Google-Smtp-Source: AGRyM1tq9T8AhmGTCHPmTwO12qeUrBC80H1pT+rtLbJkX0qZ5S63fgLLqLN+KOHo9wpUO7HYMXL6TbWvwusOJcB24iU=
X-Received: by 2002:a7b:c381:0:b0:3a2:fe96:2ce4 with SMTP id
 s1-20020a7bc381000000b003a2fe962ce4mr28529821wmj.70.1658240930520; Tue, 19
 Jul 2022 07:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <165818338297.423746.2325119921845739520.stgit@olly> <CAFqZXNvit5QK5zGjwp1tzFKSEyz0t85iqoE=Qv_yYnNYO1tsDQ@mail.gmail.com>
In-Reply-To: <CAFqZXNvit5QK5zGjwp1tzFKSEyz0t85iqoE=Qv_yYnNYO1tsDQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Jul 2022 10:28:39 -0400
Message-ID: <CAHC9VhRCyo6Fuq1iorFJpjn2wvN2VQba87tSfNwBdjyULZc-2Q@mail.gmail.com>
Subject: Re: [PATCH] tests/sctp: remove assumptions in the SCTP tests
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jul 19, 2022 at 7:58 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Jul 19, 2022 at 12:31 AM Paul Moore <paul@paul-moore.com> wrote:
> > Rework the SCTP tests slightly to remove two assumptions which are
> > not always guaranteed to be true (below).  This should have not any
> > affect on the current test suite or released kernels, but it will
> > help ensure that the test suite continues to work with upcoming
> > kernel releases.
> >
> >  * Do not rely on IP options attached to a socket.  Depending on the
> >    kernel configuration, the on-the-wire packet labels may be
> >    generated on a per-packet basis as opposed to a per-socket basis.
>
> Could you expand a bit on why this would be a problem? It's not clear
> to me how switching to per-packet would break the tests. (Maybe I'm
> just not thinking about it hard enough, but ideally the commit message
> would explain the problem to me so I don't have to :)

NetLabel can either attach on-the-wire packet labels (IP options)
directly to the packet or to the socket, in the latter case the
network stack handles writing the on-the-wire labels to the packet
when it is generated.  Deciding on when to attach IP options
(on-the-wire labels) to the socket versus the packet is an
implementation detail and depends on the specific configuration of the
system and the protocols involved.  It is my opinion that going into
the level of detail necessary to explain the differences would involve
a discussion about how the Linux network stacks works, the design of
the NetLabel subsystem, and how the different network protocols work.
The important takeaway is that one can not safely rely on IP options
attached to a socket as a means of determining the labeling behavior
of a socket/connection/association/etc., this is why we have APIs such
as getpeercon() and the LSM specific socket options.

-- 
paul-moore.com
