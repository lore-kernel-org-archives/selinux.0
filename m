Return-Path: <SRS0=pnJ1=6L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33643C81CFF
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 22:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DE042076A
	for <selinux@archiver.kernel.org>; Mon, 27 Apr 2020 22:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="oo3D+/91"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgD0WSB (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 27 Apr 2020 18:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726224AbgD0WSA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 27 Apr 2020 18:18:00 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571B2C03C1A7
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 15:17:59 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id q8so15567200eja.2
        for <selinux@vger.kernel.org>; Mon, 27 Apr 2020 15:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UL/KOG9jWEcCXLI+hyOZaTUXJMue/WeQvcbigSn5Ae8=;
        b=oo3D+/91hLZqWrB4onHqCW6rJJEyOlyHLO7bvwoLVFRudtP0fAigCrjLn7Z9f9n+nm
         hEj3u9hPHsKPnEOAK5Tuw7pSoz/aW6wlUwqvWWuKQicUWWuwIcCJLqvP581ltLbjJwXq
         OZCg+m65Ct4APQ+nG0JRjkiyAdNiBxEySxSDLi2sQBCxdRozmkvueShw0fcCe6b+l4on
         ME874FzMO6JJiq/29jNwepCF8CUFQ/0oH++U2iexahGpYeFxeF5ESFrEC7zY1Y/k6FJS
         35UXfU5LyfP/zCORQLzV1NRM36Verhzjd0JYwN0SKQ+mzdTKei/rMyoGin1IsrPTnGn5
         VDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UL/KOG9jWEcCXLI+hyOZaTUXJMue/WeQvcbigSn5Ae8=;
        b=HO5J+BHnsRRsiMqDWOTnxQ8h1vOwAiwPQQfXfrs+qBAFhJ+ZP12e5mXtklfqr2ApZ8
         0EwfL2Itp/FQcW7HJcwGYHeotditVBnoDBOJV8UFfmxC2ODNzciYJ3hgiImpXw7H0ykm
         wrCtFgl6priaJ5liEniAr6qLD0lZ4nNDJvA27DLqIuCGkFkiY101I0p/Cwh0BanRis8A
         5tGn5MrRuRpr36P1zM4tm6y+yczD14Vz5kViwEJCynKASiM9eBOg6w3TpKWnm1LJ5N5u
         bw0jxymqgNyaj3Rmsi9pSm10nk75Iglv5pN36qr/NGjGiC94r6yxe+ekmrNtEJIrku3t
         G3OA==
X-Gm-Message-State: AGi0Pubx1ThfRntxYhnfGKQ7QY4216UMc8nwq6Ui+/XIyv5sK1PIhRGv
        iRhlh2IcFnwkvbbKO6MxTbXGGl0R137brqiKyziM
X-Google-Smtp-Source: APiQypKcaWzr+dqSzZiHdrMq3hOsjQyRzRtPnEHn5+cEMPnQPkQJKf6XD2ptG29hXT9B03+/SChoZBwUAP+jLwKJmYI=
X-Received: by 2002:a17:906:31da:: with SMTP id f26mr21210369ejf.308.1588025877826;
 Mon, 27 Apr 2020 15:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhT95GJKNTMvTtmZL35UOoVwbGH-eDWZyELb5oZ5rQU+Tw@mail.gmail.com>
 <2136640.1587472186@warthog.procyon.org.uk> <CAHC9VhQnORRaRapbb1wrUsxweJCRJ+X+RdvKw8_U0pT0fuxZ6A@mail.gmail.com>
 <3834193.1587771802@warthog.procyon.org.uk> <CAHC9VhQbhG8-ZABtkZr1FXo9cuH4_nsbB=HP_fGvW+FNQ7iAXg@mail.gmail.com>
 <355576.1587996734@warthog.procyon.org.uk> <CAEjxPJ4S0wpAtXoD1f-54qrriRC8y_hj9T5-vKOGDmf1XhOLrQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ4S0wpAtXoD1f-54qrriRC8y_hj9T5-vKOGDmf1XhOLrQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 27 Apr 2020 18:17:46 -0400
Message-ID: <CAHC9VhTSuWLheaQDXwEyELGXEJOAXoFr2--FYhiviQbDHQKhkw@mail.gmail.com>
Subject: Re: [PATCH] selinux: Fix use of KEY_NEED_* instead of KEY__* perms
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
        SElinux list <selinux@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Apr 27, 2020 at 1:02 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Mon, Apr 27, 2020 at 10:13 AM David Howells <dhowells@redhat.com> wrote:

...

> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 0b4e32161b77..6087955b49d8 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -6539,20 +6539,38 @@ static void selinux_key_free(struct key *k)
> >         kfree(ksec);
> >  }
> >
> > +static unsigned int selinux_keyperm_to_av(unsigned int need_perm)
> > +{
> > +       switch (need_perm) {
> > +       case KEY_NEED_VIEW:     return KEY__VIEW;
> > +       case KEY_NEED_READ:     return KEY__READ;
> > +       case KEY_NEED_WRITE:    return KEY__WRITE;
> > +       case KEY_NEED_SEARCH:   return KEY__SEARCH;
> > +       case KEY_NEED_LINK:     return KEY__LINK;
> > +       case KEY_NEED_SETATTR:  return KEY__SETATTR;
> > +       default:
>
> Possibly WARN() or BUG() here?  Or BUILD_BUG_ON(KEY_NEED_ALL != 0x3f)
> to force an update here
> whenever a new key permission is defined?

My vote is for a build time check via BUILD_BUG_ON() or similar
mechanism.  It's worked really well in other places, I'm thinking
specifically of the SELinux netlink mapping.

> > +               return 0;
> > +       }
> > +}
> > +
> >  static int selinux_key_permission(key_ref_t key_ref,
> >                                   const struct cred *cred,
> > -                                 unsigned perm)
> > +                                 unsigned need_perm)
> >  {
> >         struct key *key;
> >         struct key_security_struct *ksec;
> > +       unsigned int perm;
> >         u32 sid;
> >
> >         /* if no specific permissions are requested, we skip the
> >            permission check. No serious, additional covert channels
> >            appear to be created. */
> > -       if (perm == 0)
> > +       if (need_perm == 0)
> >                 return 0;
> >
> > +       perm = selinux_keyperm_to_av(need_perm);
> > +       if (perm == 0)
> > +               return -EACCES;
>
> We should log or audit some kind of message here, whether via WARN(),
> audit_log(), or something, to avoid silent denials.

Assuming we add a build time check (see above), I think a WARN here is okay.

-- 
paul moore
www.paul-moore.com
