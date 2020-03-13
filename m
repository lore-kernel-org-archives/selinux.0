Return-Path: <SRS0=2KQY=46=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC615C10DCE
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 19:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FF3206CD
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 19:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OpFrut50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgCMTHE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:07:04 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40191 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726297AbgCMTHE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Mar 2020 15:07:04 -0400
Received: by mail-oi1-f195.google.com with SMTP id y71so10544126oia.7
        for <selinux@vger.kernel.org>; Fri, 13 Mar 2020 12:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lvefSvCWC85XqGnOTn8QRwYPxEkrvoibjCsIjPFJExI=;
        b=OpFrut506eK7jXaefqzaIo9Ue2yuYMbua0svGCeXjU7LhEfppz9m4CzKOfAlLqQqZ3
         QRlloAYmMeVXB8MhGXQFuhjwy4NYqEvuy2/dMufIZ+vUxmSzS4KyG1KCWtR4X1RRiLsn
         pWEu186cvvXuiShHja39SM5o8S+DLn+UuL1FgWz1og0N0y0WbTQVoP9Iv3JUkYaPOkHP
         dByu/5NX+yg2mocYJlNgmSacm+8hECP/5K59DE0FrVlZpkjCi/pUj3sGjbewlensshiZ
         cMrKQLcz+6r2w1Dg1pTuHOV6ZGVPU0zdqVgZTJtTt86SlQABZKd4l7iiu2/0YS315LpG
         vbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lvefSvCWC85XqGnOTn8QRwYPxEkrvoibjCsIjPFJExI=;
        b=pFO4S5xH+nilKnXXGJHEvtudJsEwDu5WAiK9aPObcrg8uQMqxBBKnyEdOipqSJVSz7
         nK2J7a+ha3QUnpPi0pV1En5hDr8AnFuqqPuSQTg8uzskY1noaLkP8EJd+XtPUtC+lRhp
         u7QQx+TocJ2v/1PS/eX/yKxfUsn4PcmR1Gav4my5KfaA9/hfcW1HAgPMSt7Xraj/JC9P
         3M10JZqyw/Ciqku6tykwvtRrp5rqdPSfHk6CsB4YRmR7u5EAByjU6fe3SAfMBgrG+Lxs
         QIwf/mViHrnk3XOR2H6Uu8ivHWXEHt4y/YI5X/Woqrn67+kq1Cy90WjMJ5UEV3sU6p4K
         pSrQ==
X-Gm-Message-State: ANhLgQ1ZLw1PcWkZNnYedzArz7SMqu9g7k59dGi5eHO0R0/qw2DUK7oP
        ts+Lj924peTWRE/b/+YwssEWfdeWPKcwdIBm9sXrfQ==
X-Google-Smtp-Source: ADFU+vuspMSG+s+m9wMX3gtVsJwv5wOa3bl+K3jdUsc3PIlN6Bk0zjw5Xu7TeLYv0ZwGqry130wFvUvl2L3taR1hFhM=
X-Received: by 2002:aca:5191:: with SMTP id f139mr8499475oib.140.1584126423762;
 Fri, 13 Mar 2020 12:07:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200227160257.340737-1-omosnace@redhat.com> <CAFqZXNvR6BKuk4Y3DAPUpy5kWkEJ409W1vysrQ5kxh5OsB14UQ@mail.gmail.com>
In-Reply-To: <CAFqZXNvR6BKuk4Y3DAPUpy5kWkEJ409W1vysrQ5kxh5OsB14UQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 13 Mar 2020 15:07:58 -0400
Message-ID: <CAEjxPJ5cyjyrj1F7VrmzRLw6Mm0v+3WfP3RO0arsqRhC9MfBfA@mail.gmail.com>
Subject: Re: [PATCH 0/3] libsepol: Speed up policy optimization
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        James Carter <jwcart2@tycho.nsa.gov>,
        James Carter <jwcart2@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 13, 2020 at 7:53 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Thu, Feb 27, 2020 at 5:02 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > This series contains two small changes (these don't seem to affect
> > performance measurably, but are nonetheless logical) and a patch that
> > changes how the policy optimization "type_map" helper structure is
> > represented, which speeds up the whole process.
> >
> > Ondrej Mosnacek (3):
> >   libsepol: skip unnecessary check in build_type_map()
> >   libsepol: optimize inner loop in build_type_map()
> >   libsepol: speed up policy optimization
> >
> >  libsepol/src/optimize.c | 119 +++++++++++++++++++++++++++++++---------
> >  1 file changed, 94 insertions(+), 25 deletions(-)
> >
> > --
> > 2.24.1
>
> I can see this series marked as "Changes Requested" in patchwork - is
> there anything requested other than a test for policy optimization?
> After 692716fc5fd5 ("libsepol/cil: raise default attrs_expand_size to
> 2") the second no longer leads to a different output (with expand size
> >=2).

I suppose you could move it back to New.
