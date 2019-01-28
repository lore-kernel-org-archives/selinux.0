Return-Path: <SRS0=nwiU=QE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E03C282C8
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 15:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBF520880
	for <selinux@archiver.kernel.org>; Mon, 28 Jan 2019 15:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfA1PnR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:43:17 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33644 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1PnQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 28 Jan 2019 10:43:16 -0500
Received: by mail-ot1-f67.google.com with SMTP id i20so15018487otl.0
        for <selinux@vger.kernel.org>; Mon, 28 Jan 2019 07:43:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mG6HxIO/wT8ULXEL4/CFvBccK55/f47m7a9v6Pkhm2k=;
        b=lMe8L3ZgBwTr842yzExHzHzNDUdfnV/8X2+ssQRYoNZPd/Dadkiq4rQzrKDt/snt4r
         DjgfQU7t66cNh0bgat/O9NQipOyV+f0doeDkAolko4VMmP5G8M6YasfS5E30As1js2Qj
         9fnf+yBNBLCt+gnH39dcUYO0rV1yxmcKTL7euLFJQlGb5MblsH9orD6d3radgxgwRcMw
         ofsVrns2OEbHcnDE0/3zDKdPa9tD5gBcnloA1WGk42jNjx2CAmwqo1wxVlGlSFs/0nUJ
         FQVVzuAwymOa0diWn94ge0qIE/CK0no4UPGEMbmUOAdQDqphRL0IQQLQGR5vUnmlZGfb
         RUEA==
X-Gm-Message-State: AJcUukeV6VDlaYjqtvPdc7XS4yjOXUzS77zxwOK3xYrR8Tmo5JHQlT3p
        48etCObqQ0couBlsFHOkVWe8xLT/hj1RBvdkZUNypQNb
X-Google-Smtp-Source: ALg8bN7kItO7D482oqQVRz3VXUuTQsnBTPipXuFNh+RKM79gtCWkr/yfXQBne+ASlMxUWeI2QSSkQbi+8T0V8S0XDL0=
X-Received: by 2002:a9d:1d65:: with SMTP id m92mr16990074otm.65.1548690196134;
 Mon, 28 Jan 2019 07:43:16 -0800 (PST)
MIME-Version: 1.0
References: <20190126101816.1065-1-omosnace@redhat.com> <9a9ed7ba-b4ab-34a9-4d14-81ac4a418eb4@tycho.nsa.gov>
 <CAHC9VhQuFPQ9C5=FxP1LEetZVHRsfmQV2qH5TErTaPuBW9wcsQ@mail.gmail.com>
In-Reply-To: <CAHC9VhQuFPQ9C5=FxP1LEetZVHRsfmQV2qH5TErTaPuBW9wcsQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 28 Jan 2019 16:43:06 +0100
Message-ID: <CAFqZXNsVOZi9DO9qgdvmhgtw2iKxXovpdjLzYkuLJ2M72jyVaA@mail.gmail.com>
Subject: Re: [PATCH] selinux: replace BUG_ONs with WARN_ONs in avc.c
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Jan 28, 2019 at 4:11 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Jan 28, 2019 at 8:23 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > On 1/26/19 5:18 AM, Ondrej Mosnacek wrote:
> > > These checks are only guarding against programming errors that could
> > > silently grant too many permissions. These cases are better handled with
> > > WARN_ON(), since it doesn't really help much to crash the machine in
> > > this case.
> > >
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >   security/selinux/avc.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> > > index 3a27418b20d7..84f108f4100a 100644
> > > --- a/security/selinux/avc.c
> > > +++ b/security/selinux/avc.c
> > > @@ -1059,7 +1059,7 @@ int avc_has_extended_perms(struct selinux_state *state,
> > >       int rc = 0, rc2;
> > >
> > >       xp_node = &local_xp_node;
> > > -     BUG_ON(!requested);
> > > +     WARN_ON(!requested);
> >
> > Should this be:
> >         if (WARN_ON(!requested))
> >                 return -EACCES;
>
> I think so, it would be bad not to return an error in this case (and
> the similar one below).

Makes sense... will send a v2 right away.

>
> > >
> > >       rcu_read_lock();
> > >
> > > @@ -1149,7 +1149,7 @@ inline int avc_has_perm_noaudit(struct selinux_state *state,
> > >       int rc = 0;
> > >       u32 denied;
> > >
> > > -     BUG_ON(!requested);
> > > +     WARN_ON(!requested);
> >
> > And likewise
> >
> > >
> > >       rcu_read_lock();
> > >
> > >
>
> --
> paul moore
> www.paul-moore.com

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
