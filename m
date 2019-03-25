Return-Path: <SRS0=9nT4=R4=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0730EC43381
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 15:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68312075C
	for <selinux@archiver.kernel.org>; Mon, 25 Mar 2019 15:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbfCYPAM (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:00:12 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44969 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729036AbfCYPAM (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 25 Mar 2019 11:00:12 -0400
Received: by mail-ot1-f67.google.com with SMTP id d24so8260516otl.11
        for <selinux@vger.kernel.org>; Mon, 25 Mar 2019 08:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BiSiPWnlhOPLshaPGWib4LIF673MZcidnXgMWYfkzOM=;
        b=tIukz/8n+vjzbQoH0E1+6/F2O4JWWmJjFsCg7i1LA1KC8FQwcVObQlG0XJG0YSWsDt
         9rEinw/dfzzjZU84yrtQmH6T0VN5EkVt9c/OBHyIYhNukLoEIgkU3abKUWi0B0pWIOHz
         kZjFvGTNy7hBrPLEx4eTpAdx714sPcAEuf9gC7NVVvfeKxkVLezgCIrMsG81sBJroxFw
         ro87fK/7WrgF4NuKDz05aP8JtOxZNVIn3R6A+LVkSylV0+qb2OQpVxJdI9uGi5uy2UIp
         dnz1FvGjZhXV2zvL6QLRnD7HmknGNSbqdpLEKPxzLT5wZ0beqx4FgYdrqGXApFcO+cHF
         yRCA==
X-Gm-Message-State: APjAAAWwQxlcoKj0BtLLoN4GqOc77iq/A8nzswomkrnA3oECilYBrvMi
        QxhHernTR2B2IY/pYHhYRfkFHXEOmwIMLrzhuxlbRja9rPk=
X-Google-Smtp-Source: APXvYqxu9wCYCA1b54Swbz5BaPQvljrUOLNfR0+eQyhzOnRQQ8Zf7lj8VS8jNdPj72wvK6SHsUk3tM2Kj/qfEYYwjZ8=
X-Received: by 2002:a9d:1b2f:: with SMTP id l44mr21876otl.217.1553526011654;
 Mon, 25 Mar 2019 08:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190325081115.19874-1-omosnace@redhat.com> <CAHC9VhT+CC2+nba=am9te5oZKDp7L6xbKiYxUCeMhrGENh+JiQ@mail.gmail.com>
In-Reply-To: <CAHC9VhT+CC2+nba=am9te5oZKDp7L6xbKiYxUCeMhrGENh+JiQ@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 25 Mar 2019 16:00:00 +0100
Message-ID: <CAFqZXNtGC8yAk5z6ROHAoL5bYc+a4e8K9Pws2r3+y6yMT=jQYQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove useless assignments
To:     Paul Moore <paul@paul-moore.com>
Cc:     Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        selinux@vger.kernel.org, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 25, 2019 at 3:31 PM Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Mar 25, 2019 at 4:11 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > The code incorrectly assigned directly to the variables instead of the
> > values they point to. Since the values are already set to NULL/0 at the
> > beginning of the function, we can simply remove these useless
> > assignments.
> >
> > Reported-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
> > Fixes: fede148324c3 ("selinux: log invalid contexts in AVCs")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  security/selinux/ss/services.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> > index ec62918521b1..b18a8d7c1b5e 100644
> > --- a/security/selinux/ss/services.c
> > +++ b/security/selinux/ss/services.c
> > @@ -1318,14 +1318,11 @@ static int security_sid_to_context_core(struct selinux_state *state,
> >                 rc = -EINVAL;
> >                 goto out_unlock;
> >         }
> > -       if (only_invalid && !context->len) {
> > -               scontext = NULL;
> > -               scontext_len = 0;
> > -               rc = 0;
> > -       } else {
> > +       if (only_invalid && !context->len)
> > +               rc = 0; /* *scontext/*scontext_len are already set to NULL/0 */
>
> The compiler doesn't like that you've used "/*" inside a comment.  I'm
> surprised you didn't see this when compiling the code ... you did
> compile this before sending it to the list, right?

Hm, could be that I had to rebuild (almost) the whole tree for some
reason (git checkout across branches, probably) and the warning got
lost in the sea of build output (no -Werror here, so the build did not
fail).

>
> Anyway, the patch looks fine to me otherwise so I removed the comment
> (it was a arguably verbose anyway) and merged into selinux/next.

Fine by me, thanks!

>
> > +       else
> >                 rc = context_struct_to_string(policydb, context, scontext,
> >                                               scontext_len);
> > -       }
> >  out_unlock:
> >         read_unlock(&state->ss->policy_rwlock);
> >  out:
>
> --
> paul moore
> www.paul-moore.com

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.
