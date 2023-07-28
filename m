Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF7DC001DE
	for <selinux@archiver.kernel.org>; Fri, 28 Jul 2023 15:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237325AbjG1Pa4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 28 Jul 2023 11:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237332AbjG1Paz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 28 Jul 2023 11:30:55 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0C635B0
        for <selinux@vger.kernel.org>; Fri, 28 Jul 2023 08:30:53 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-79a23db59c3so714710241.2
        for <selinux@vger.kernel.org>; Fri, 28 Jul 2023 08:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1690558252; x=1691163052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxwEjvRkUFUVN71dGhgtzZ8Q99oabuny5fsYWJA8fG8=;
        b=rCoyavNAP0gaR6Tbh5/h0KIfxbkq33uuai32Huo8dbH4TmL9H3iUYK/lmNCcOshEl0
         sNVz9fwJ2GRczxiuTVEJCiJoLMqJdgBrwJ6lXR5OXwthChPOxVB048X81vKKIocYt3eK
         aEMTHffz/IcYHWNBAK+S+3e7SpVzPbBDqOVnvTIJpxZdZICXea8Sb7FY0hDk1QS5gEBl
         46xcOe2xZf2+XTI8JPqgioVxwgEPIoF8Wj3loaaW037rY8Ov+jysBRUZ8md7ARaOoOry
         BRxeDGxCxapj/u4r+/4Dyw70VqvOLuURp8nzvUwWOLZHcOfQYilHrcOV/b3IDrNk5hUu
         tG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690558252; x=1691163052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxwEjvRkUFUVN71dGhgtzZ8Q99oabuny5fsYWJA8fG8=;
        b=VIKi/G6PpOBbYEWR3XxO8Yq16TUFz79NWcn3e9nFXSygFluNVfxnRNvdwmBK9G/i+L
         qM4Sv3YID1o4a5S5R0mwmRIvooXbjYuS4bKZRiQfSYiqWjiH9RjaqbZPQQxQQwO4oNcU
         agr2egp1vKMN6gJA3FUNmnu4fzPTWIICUKjvSd/BizM8Q1CmVDphT/KsUoOC4Ev5ZYq3
         M3D/MLKguorhHDr7VuFiObwza8P4dMnDfQYHteuBHB7ka5FnDAjYbpqAX1ZBZGUgIvUJ
         EeBlKgAytM4lglYxrrTjUbNUWbBX8hcfRNdEO197hSMoQKX2vSNwVFanY9PzotlxNi2z
         WMCQ==
X-Gm-Message-State: ABy/qLZxKd5dtnvcgGrlXMBOixWKRFqygghdyQO59wT2/Wj89qzz+3yM
        J0Tl9WJ0ustIKO55jObaU0LYypoXxnTrO1F7/zQEt8PI0hfIM4LNS3M=
X-Google-Smtp-Source: APBJJlGLdYG7S6LW/Cy/YzD7+3yCNcZraXtGrba9aS0QDuDlv+upJL5OKvEDADEumPtucat1Ze5frGuEL64QZx6GLVA=
X-Received: by 2002:a67:cf4d:0:b0:445:228e:62db with SMTP id
 f13-20020a67cf4d000000b00445228e62dbmr1356258vsm.8.1690558252174; Fri, 28 Jul
 2023 08:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230718184921.112786-3-cgzones@googlemail.com> <4e8ed564dd7443b84bd5b9e329efad2f.paul@paul-moore.com>
In-Reply-To: <4e8ed564dd7443b84bd5b9e329efad2f.paul@paul-moore.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 28 Jul 2023 17:30:41 +0200
Message-ID: <CAJ2a_DcojRG6N1Tgm00PLo0JjuqqmALdHQO=oJe4zYNv9gBthQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux: log missing anonclass in debug configuration
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 20 Jul 2023 at 22:21, Paul Moore <paul@paul-moore.com> wrote:
>
> On Jul 18, 2023 =3D?UTF-8?q?Christian=3D20G=3DC3=3DB6ttsche?=3D <cgzones@=
googlemail.com> wrote:
> >
> > Log under the SELinux debug configuration when a caller to the LSM hook
> > inode_init_security_anon does not pass a anonymous inode class name.
> > The class name allows policy writers to transition the anonymous inode
> > into a private type via a name based type transition.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  security/selinux/hooks.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
>
> Is this really a problem?  There are two callers in v6.5-rc2 and both
> properly populate the @name parameter.
>
> Considering how easy it is to look up the callers in the kernel source
> and ensure they are passing a valid @name parameter I'm inclined to
> leave this patch unmerged.
>
> Thoughts?

True, there are currently only two callers.  The intention was to be
notified if in the future new callers are added and author being
unaware of the effects for SELinux and the patch not noticed by the
SELinux maintainers.  Also normal users/distributions will never see
this message.

If you aren't convinced then feel free to disregard this patch.

>
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index b8a8a4f0f2ad..f6ffab9958b6 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -2918,6 +2918,17 @@ static int selinux_inode_init_security_anon(stru=
ct inode *inode,
> >       if (unlikely(!selinux_initialized()))
> >               return 0;
> >
> > +#ifdef CONFIG_SECURITY_SELINUX_DEBUG
> > +     /*
> > +      * Allow policy writers to transition the anonymous inode into
> > +      * a private type via a name based type transition.
> > +      */
> > +     if (!name) {
> > +             pr_debug("SELinux:  no class given for anonymous inode\n"=
);
> > +             dump_stack();
> > +     }
> > +#endif
> > +
> >       isec =3D selinux_inode(inode);
> >
> >       /*
> > --
> > 2.40.1
>
> --
> paul-moore.com
