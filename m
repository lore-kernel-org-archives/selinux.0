Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044D3C61DA4
	for <selinux@archiver.kernel.org>; Thu,  9 Mar 2023 20:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjCIUzx (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 9 Mar 2023 15:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjCIUzw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 9 Mar 2023 15:55:52 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8300AF209C
        for <selinux@vger.kernel.org>; Thu,  9 Mar 2023 12:55:51 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id v11so3329990plz.8
        for <selinux@vger.kernel.org>; Thu, 09 Mar 2023 12:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678395351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slZaH4lxamph0S9qZmeRao6lovodtsqJ7VC0THExECE=;
        b=NPjUjFlvZiRFRXbxCilwUPSHJOUzwpHhD2FtGhwQ5AIjXw8wLcwi4f6rLKKJ5Gk871
         oZ4w3pnWU9woXcQvTFygJtW9Pozv+EHKLJ8rDfkfHtCEAqnwzytbu2d2xOg/oVOf3X7s
         z7qmPTDAikcE1KM5CYCJpAMFeKgJWp6/iWWvT5IG5rNG/SDglYWGhv8nNYWzr+SktFLU
         ZqrveMk3r45Yc70Wm4VhqvAOwL14yXvXFFcBXjsgJothRguPGL+yKV3sWMQCHl9HCmKe
         xfOBSapnAa1gEDgaGuI70vshQk+xIYKm7vUqiLA8VPwArBa3O+xxzEVz3/PgElcQL0aX
         ak4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678395351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slZaH4lxamph0S9qZmeRao6lovodtsqJ7VC0THExECE=;
        b=vqg9fkNCpKTs1YpXkiKzEUQpUfXt+51IZlZHYupyBRGuyDr9I5R70HQo+all50jvzo
         wr3+HoFzs/+L1xaer9ktJdRk4rXta5fL507mdNmG7mGAK7KgzSjrKMOpO+xEva0pBuFm
         IGdfSBWu8A+dx6re4BtRzH4lPfCCliJxXmvaF4vC0q2WatRPaRhL4GyYijoVKz7FG5QS
         Te8P1rH6mourEYjtJBkE09DIAeJJEOoU3bMtjCfvYm1TC6GyRiI+WCjjCIcrPmL+Ybf0
         reGinUs9z8iG5iQ1/3/bJRJdpkOpPnyIPdzIXZ0F3sc7NZ4cG8NLtIK9kxEi+j5SVTQ5
         AN3A==
X-Gm-Message-State: AO0yUKVv7q0jPXRTwOVTOIDnn34TIZHy3ztXhJx4dCsC2A4K73g8tD+i
        stkvPtehDVvyWKh1jd5PqUkSqBIH5qCbTUb09zU=
X-Google-Smtp-Source: AK7set++SCCLWJsGjrla8NafV5OMD7Xjq+TU60MQaEVjIZOviaheZjzhy6r3j4Ttq+5UQtUey8y5bpTb1rhq5naK7U4=
X-Received: by 2002:a17:90a:8e83:b0:237:1fe0:b151 with SMTP id
 f3-20020a17090a8e8300b002371fe0b151mr8166796pjo.8.1678395350928; Thu, 09 Mar
 2023 12:55:50 -0800 (PST)
MIME-Version: 1.0
References: <20230309191741.15063-1-stephen.smalley.work@gmail.com> <CAHC9VhTCScrPmzrzSVPqF0G==4+qxd=KSeBw7s3T_46rDgKoXQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTCScrPmzrzSVPqF0G==4+qxd=KSeBw7s3T_46rDgKoXQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 9 Mar 2023 15:55:39 -0500
Message-ID: <CAEjxPJ4R0U7TL3EAjU8_nnbmgoSaO+DN9SoB+PuC1HkOcrfAuw@mail.gmail.com>
Subject: Re: [PATCH] selinux: stop passing selinux_state pointers and their offspring
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, torvalds@linux-foundation.org,
        omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 9, 2023 at 3:48=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Thu, Mar 9, 2023 at 2:18=E2=80=AFPM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > Linus observed that the pervasive passing of selinux_state pointers
> > introduced by me in commit aa8e712cee93 ("selinux: wrap global selinux
> > state") adds overhead and complexity without providing any
> > benefit. The original idea was to pave the way for SELinux namespaces
> > but those have not yet been implemented and there isn't currently
> > a concrete plan to do so. Remove the passing of the selinux_state
> > pointers, reverting to direct use of the single global selinux_state,
> > and likewise remove passing of child pointers like the selinux_avc.
> > The selinux_policy pointer remains as it is needed for atomic switching
> > of policies.
> >
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > ---
> >  security/selinux/avc.c                 | 197 ++++-----
> >  security/selinux/hooks.c               | 549 ++++++++++---------------
> >  security/selinux/ibpkey.c              |   2 +-
> >  security/selinux/ima.c                 |  37 +-
> >  security/selinux/include/avc.h         |  29 +-
> >  security/selinux/include/avc_ss.h      |   3 +-
> >  security/selinux/include/conditional.h |   4 +-
> >  security/selinux/include/ima.h         |  10 +-
> >  security/selinux/include/security.h    | 171 +++-----
> >  security/selinux/netif.c               |   2 +-
> >  security/selinux/netlabel.c            |  17 +-
> >  security/selinux/netnode.c             |   4 +-
> >  security/selinux/netport.c             |   2 +-
> >  security/selinux/selinuxfs.c           | 208 ++++------
> >  security/selinux/ss/services.c         | 346 +++++++---------
> >  security/selinux/ss/services.h         |   1 -
> >  security/selinux/status.c              |  44 +-
> >  security/selinux/xfrm.c                |  20 +-
> >  18 files changed, 651 insertions(+), 995 deletions(-)
>
> It looks like this patch was a bit too big for the mailing list; I'm
> trimming my reply to get this discussion on the list.
>
> I strongly dislike merging patches that haven't hit the list, but I do
> recognize that this is a bit of an unusual case.  Have you tried
> breaking this up into two (three?) patches?  I imagine that should be
> possible, although I worry that the time required to do that would be
> prohibitive given the change itself.
>
> If that doesn't work, an alternative might be to file a PR against our
> kernel subsystem mirror on GitHub and posting a link to the PR here.
> I don't want to encourage this as a general way of submitting SELinux
> kernel patches, but I could make an exception here.
>
> https://github.com/SELinuxProject/selinux-kernel

I'm open to suggestions but didn't see an obvious way to split it in a
manner that keeps everything in a working state after each patch.
checkpatch.pl didn't complain about the size - not sure if that is a
change in policy. Created a PR here:

https://github.com/SELinuxProject/selinux-kernel/pull/64
