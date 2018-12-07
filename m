Return-Path: <SRS0=Nhvc=OQ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2353DC65BAF
	for <selinux@archiver.kernel.org>; Fri,  7 Dec 2018 06:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF9C20882
	for <selinux@archiver.kernel.org>; Fri,  7 Dec 2018 06:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDapvKmk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF9C20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbeLGGqm (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Dec 2018 01:46:42 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40229 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeLGGqj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Dec 2018 01:46:39 -0500
Received: by mail-qk1-f196.google.com with SMTP id y16so1872330qki.7
        for <selinux@vger.kernel.org>; Thu, 06 Dec 2018 22:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RNLVbES9RtUdUlQo4egiB2AZ1KkJUFsgcc85VbCjtAY=;
        b=QDapvKmkCDg8HW2hn1O5zhliDR3744vMZIu6pY8exrY/Dso9WuMAT04SED67BbAHR7
         HeApH2g9nNWSKbs8AUfiVi1SXGoue13e0xpYedSzxVFolOgG66GDIRZhRt9f3DxPDEwf
         WIw+C3gz0H8dkdxcIY5nBIUlq3D7INFKD9rz61nf/kQM6TmB2Fhvd06uVVLnZUdDMj3c
         hI7e8ZxQRV2Qw4vkvakGGmh4y0Cc/h+Vl+bk+QBjNfWfKNgChvku010bqmAn6R9CQFcg
         kPvjTeL5oXvpVlO5JM7zj88QBqndkqj8uFjwrIhAfHOG0W/2mul0qbJreIUE3yvWJMO2
         xx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RNLVbES9RtUdUlQo4egiB2AZ1KkJUFsgcc85VbCjtAY=;
        b=MHfpMBI9zTHdqAsQKstplDg8wvbnuGnshkvEHv+N8DxTpongkVsH+NquMS5uYsHLDh
         sfgnaJ1GZzvIRY/MeLkDWxUyFAploGSHXA3B+kV9KaHQ1B6nTDW7L11426e0MRXd5Pb+
         k7fY5XwGE01SdzRkePxc62WaDIC8mMYvQi6mM4l4SFNLI40aMhYAUIf+/4jHSpEm+ko7
         m8R88+lx4GvtqsNntPB0pty/eytLiNQrxi4BFlZF+j54jDaq3WjJNFl1fuAcTPMBkFpW
         49HWm1TU1xLt3uQigc35YSIwlw02cvIfUuiLluLDO7SBR+QX5xu4hKmpH7y0kjgAOIrE
         qOrg==
X-Gm-Message-State: AA+aEWb65g5jryDFfh6jj8cJJT6qHrts8FmZyE/s18hXcnqBUlZOp/+F
        9CDHtTZ1LhiqVGqwfIih7zFgQInsTiQ8CNmADsxxIg==
X-Google-Smtp-Source: AFSGD/UOq8tDyPtNhpeB8um8JlJta1sOMF7R3c9AXfdxqj3zd+zpsL+ccbgN79kRMdojz4RkTbEuzaA8S9Q/StlW0pk=
X-Received: by 2002:a37:7003:: with SMTP id l3mr865345qkc.80.1544165196978;
 Thu, 06 Dec 2018 22:46:36 -0800 (PST)
MIME-Version: 1.0
References: <20181204204209.21542-1-sds@tycho.nsa.gov> <CAHC9VhTB8ZpHt3fUL4_SY2qaYZUg4au7eLLOBgnpmT-72hmCaw@mail.gmail.com>
In-Reply-To: <CAHC9VhTB8ZpHt3fUL4_SY2qaYZUg4au7eLLOBgnpmT-72hmCaw@mail.gmail.com>
From:   BMK <bmktuwien@gmail.com>
Date:   Fri, 7 Dec 2018 07:46:25 +0100
Message-ID: <CAFSQBhEA8aNOw5xK9an+uvh6MeowRh6YYw1SC42JWfHj68iPfg@mail.gmail.com>
Subject: Re: [RFC][PATCH] selinux: avoid silent denials in permissive mode
 under RCU walk
To:     Paul Moore <paul@paul-moore.com>
Cc:     sds@tycho.nsa.gov, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Dec 7, 2018 at 12:58 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Dec 4, 2018 at 3:39 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > commit 0dc1ba24f7fff6 ("SELINUX: Make selinux cache VFS RCU walks safe")
> > results in no audit messages at all if in permissive mode because the
> > cache is updated during the rcu walk and thus no denial occurs on
> > the subsequent ref walk.  Fix this by not updating the cache when
> > performing a non-blocking permission check.  This only affects search
> > and symlink read checks during rcu walk.
> >
> > Fixes: 0dc1ba24f7fff6 ("SELINUX: Make selinux cache VFS RCU walks safe")
> > Reported-by: BMK <bmktuwien@gmail.com>
> > Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
> > ---
> >  security/selinux/avc.c         | 9 ++++++---
> >  security/selinux/hooks.c       | 4 +++-
> >  security/selinux/include/avc.h | 1 +
> >  3 files changed, 10 insertions(+), 4 deletions(-)
> >
> > diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> > index 635e5c1e3e48..f0e7bc0dc442 100644
> > --- a/security/selinux/avc.c
> > +++ b/security/selinux/avc.c
> > @@ -1021,8 +1021,10 @@ static noinline int avc_denied(struct selinux_state *state,
> >             !(avd->flags & AVD_FLAGS_PERMISSIVE))
> >                 return -EACCES;
> >
> > -       avc_update_node(state->avc, AVC_CALLBACK_GRANT, requested, driver,
> > -                       xperm, ssid, tsid, tclass, avd->seqno, NULL, flags);
> > +       if (!(flags & AVC_NONBLOCKING))
> > +               avc_update_node(state->avc, AVC_CALLBACK_GRANT, requested,
> > +                               driver, xperm, ssid, tsid, tclass, avd->seqno,
> > +                               NULL, flags);
>
> I realize the issue here is specific to the VFS code paths, but if we
> are going to introduce a general AVC flag to tell the AVC code not to
> block, it seems like we should honor it everywhere.  I would suggest
> moving the check into avc_update_node() itself (it's static, so
> hopefully any perf impact will be negligible).
>
> >         return 0;
> >  }
> >
> > @@ -1199,7 +1201,8 @@ int avc_has_perm_flags(struct selinux_state *state,
> >         struct av_decision avd;
> >         int rc, rc2;
> >
> > -       rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, requested, 0,
> > +       rc = avc_has_perm_noaudit(state, ssid, tsid, tclass, requested,
> > +                                 (flags & MAY_NOT_BLOCK) ? AVC_NONBLOCKING : 0,
> >                                   &avd);
> >
> >         rc2 = avc_audit(state, ssid, tsid, tclass, requested, &avd, rc,
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 7ce012d9ec51..9b05f84808d9 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -3196,7 +3196,9 @@ static int selinux_inode_permission(struct inode *inode, int mask)
> >                 return PTR_ERR(isec);
> >
> >         rc = avc_has_perm_noaudit(&selinux_state,
> > -                                 sid, isec->sid, isec->sclass, perms, 0, &avd);
> > +                                 sid, isec->sid, isec->sclass, perms,
> > +                                 (flags & MAY_NOT_BLOCK) ? AVC_NONBLOCKING : 0,
> > +                                 &avd);
> >         audited = avc_audit_required(perms, &avd, rc,
> >                                      from_access ? FILE__AUDIT_ACCESS : 0,
> >                                      &denied);
> > diff --git a/security/selinux/include/avc.h b/security/selinux/include/avc.h
> > index ef899bcfd2cb..74ea50977c20 100644
> > --- a/security/selinux/include/avc.h
> > +++ b/security/selinux/include/avc.h
> > @@ -142,6 +142,7 @@ static inline int avc_audit(struct selinux_state *state,
> >
> >  #define AVC_STRICT 1 /* Ignore permissive mode. */
> >  #define AVC_EXTENDED_PERMS 2   /* update extended permissions */
> > +#define AVC_NONBLOCKING    4   /* non blocking */
> >  int avc_has_perm_noaudit(struct selinux_state *state,
> >                          u32 ssid, u32 tsid,
> >                          u16 tclass, u32 requested,
> > --
> > 2.19.2
> >
>
> --
> paul moore
> www.paul-moore.com

I just want to confirm, that the patch of Stephen fixed the bug in the
kernel 4.9.
It seems to work stable now...
I'll keep an eye on it and report if any other issues should surface.
Again, thank you all so much. Really appreciate it.
