Return-Path: <SRS0=1V8V=AA=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D44C433DF
	for <selinux@archiver.kernel.org>; Fri, 19 Jun 2020 13:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70C6020786
	for <selinux@archiver.kernel.org>; Fri, 19 Jun 2020 13:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBw6KcaE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgFSNKr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730182AbgFSNKo (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Jun 2020 09:10:44 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDCC1C06174E
        for <selinux@vger.kernel.org>; Fri, 19 Jun 2020 06:10:43 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id x189so11104320iof.9
        for <selinux@vger.kernel.org>; Fri, 19 Jun 2020 06:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t4MMf6xn1uTOenbrQVhEBccnGXCvWin6hmCli0i4vK8=;
        b=qBw6KcaEp8DbQzNNJzEr+zDw1fMzwYsxXMoc61etkSJ1QZyQIc1UI6vQtrcEAsSouG
         sqUA8d8C5wnsLvBL5G3YSQl9e7ak8yt6MTGQ0b3V/3PP3111zJt42Cgbuk5y7skD+BLf
         9Wy4DaXHZP93wX63uT6PH7OwSfmKnnC7wpOzNm8iIMGunxjzeDOFXzef9l7qA4EzfJGI
         thISRqbd2M1VFFxLtsBGDhEYxoKZd+aAtfz9LgsU6xthk+wFcziKzJ3CK3aXCyclZ8I4
         QvD4rNjbXK2CCkl08Vz5B21l0PeFppviLII3S9U7SU1MHV6qbbR4cQn8fet7RSpz0Czo
         C8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4MMf6xn1uTOenbrQVhEBccnGXCvWin6hmCli0i4vK8=;
        b=c6trva4ObXqn7RUH3QXAb8FO3Wbr2cj7Pih0ayBnK3siKqogVwhte8m+mdztg1L6O3
         2oju7F1rI3P9vyauI+jZC4nL0LUh3l3FvH1ga9amDYaQLmOYTXpKh/1Z/4vGbPbCcvzx
         ZElU0A1B5Dgg0NBn1osdVajcuSumqvKiAbMHfYu8zumntH3aqIKLkVB++j9EgaprZJXq
         9Xu42QgljH9xzxnnEllCA9BlCYsRWCcp3jY3bT0+haESQCCSlcZdG/ESqtIsxprpqDVl
         aoTd2dLfDxXzA88gxmaauJsg0bIQSBcaeGCa2IkipUJQ81e/HJp3RtesQJGYCdcBjtwI
         23DQ==
X-Gm-Message-State: AOAM533JkSJnABf7eU8zWv9aN3PtKQrHrtFl3ZvQU+nMK9TMhcQZvOOF
        edKOpes2Z3oAs98F4u9MQJlnjOx+ng+pUQSfeGk=
X-Google-Smtp-Source: ABdhPJx0FseqoG3lsyJtjYMsko1tL4xnC5fBcm0jydI3t3wsXAEAoNDFXFLlkX/EuxebNbea2On9r3JmY2+StUOb9Y0=
X-Received: by 2002:a6b:e60e:: with SMTP id g14mr4244267ioh.141.1592572243083;
 Fri, 19 Jun 2020 06:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <SELinuxProject/selinux+700041658+stillfailing@travis-ci.org>
 <5eeca9a6c6c3f_13f81db917afc6197f@travis-tasks-8545cf558d-gwbmp.mail>
 <20200619124723.GD785659@localhost.localdomain> <CAFqZXNtnPU++Foy+SdeVwMFqJ14tEsNnqOFHZEsbUHmYs_-0rw@mail.gmail.com>
In-Reply-To: <CAFqZXNtnPU++Foy+SdeVwMFqJ14tEsNnqOFHZEsbUHmYs_-0rw@mail.gmail.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Fri, 19 Jun 2020 08:10:32 -0500
Message-ID: <CAFftDdpjYOZ+rm5ZM-sB093+TYpdd-tnbR9-PR-R5P+Un9QXkg@mail.gmail.com>
Subject: Re: Still Failing: SELinuxProject/selinux#444 (master - b3d8b99)
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Petr Lautrbach <plautrba@redhat.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 19, 2020 at 8:02 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Fri, Jun 19, 2020 at 2:48 PM Petr Lautrbach <plautrba@redhat.com> wrote:
> > On Fri, Jun 19, 2020 at 12:03:51PM +0000, Travis CI wrote:
> > > Build Update for SELinuxProject/selinux
> > > -------------------------------------
> > >
> > > Build: #444
> > > Status: Still Failing
> > >
> > > Duration: 17 mins and 45 secs
> > > Commit: b3d8b99 (master)
> > > Author: Petr Lautrbach
> > > Message: Update VERSIONs to 3.1-rc2 for release.
> > >
> > > Signed-off-by: Petr Lautrbach <plautrba@redhat.com>
> > >
> > > View the changeset: https://github.com/SELinuxProject/selinux/compare/08f5e3017721...b3d8b99f0cb0
> > >
> > > View the full build log and details: https://travis-ci.org/github/SELinuxProject/selinux/builds/700041658?utm_medium=notification&utm_source=email
> > >
> >
> > Seems to be related to outage in Fedora infrastructure -
> > https://lists.fedoraproject.org/archives/list/devel@lists.fedoraproject.org/thread/MAGJJTVR777ARZ4TVMBQQ3YK6RC7ODE6/
> >
> > There's also ongoing datacentre move -
> > https://lists.fedoraproject.org/archives/list/devel-announce@lists.fedoraproject.org/thread/5DNRZ4OUUNGSUJONQLEXXP3CKME43SCE/
>
> Have you tried just restarting the build? Looking at the logs, it
> successfully connected to 152.19.134.145 when downloading the image,
> but then failed to connect to the same IP when downloading the
> checksum file, which would suggest the connection is just flaky and
> not completely down.

Just re-toggle the build, you will see intermittent travis failures
occasionally from issues on their end. It's happened in other
build configs as well.

>
> --
> Ondrej Mosnacek
> Software Engineer, Platform Security - SELinux kernel
> Red Hat, Inc.
>
