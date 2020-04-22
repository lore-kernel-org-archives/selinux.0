Return-Path: <SRS0=Xew/=6G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3592CC55185
	for <selinux@archiver.kernel.org>; Wed, 22 Apr 2020 21:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1195B20781
	for <selinux@archiver.kernel.org>; Wed, 22 Apr 2020 21:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="RhchmTYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgDVVKF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 22 Apr 2020 17:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgDVVJ7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 22 Apr 2020 17:09:59 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF454C03C1AB
        for <selinux@vger.kernel.org>; Wed, 22 Apr 2020 14:09:57 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id a2so3014272ejx.5
        for <selinux@vger.kernel.org>; Wed, 22 Apr 2020 14:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pEu2Bt1tsa6w0b7bq42ZOpMGSP2pzXGTr384DFiouoM=;
        b=RhchmTYderK89B8YaVxC6QZzgFQD0OdJxHIGY5s3t4Er/WHlva1prWp4hX5JrtRHvM
         2NxXRoD+9mav8cGC8ukdiks1SaYf0A/ss5QTQhkP9hUuH+mmmEutrwIuqJxRH+pXkPjN
         n1BjAiVUcgCj+geYoNoBRWrQVttO2HTQ22lEZHszQbF9QuIOVCRcHxZZPi5qY2pLc7SK
         62hnVOPIB5q7Jcn2UCktFtXKBSH4wHsmZpRMf/S1MkLZtxabF/Y8DY5HCPbgDhdNQ3Xj
         v47jQsTrULbT2NYHPloW3aYB/JTSCo+O3NmCNqCCfrKED4zz5iN5DZr28w9tvtH1wHSz
         opJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pEu2Bt1tsa6w0b7bq42ZOpMGSP2pzXGTr384DFiouoM=;
        b=tPv2tQGFLcVu9YhPFyJE+PmRGghmbYL1N2TH8ppIO5TWss3T/M8SJnfWJtIvAW2Cvw
         l7Jj2aQdM7wuPe1L/mE0n7gf6HIGhdmIC1PqI0/5WLPN4G5E85p+mRT3Dr+Y0jKXR2Sk
         1wWvVJL9gP+ytxktjP1unk8W9hcBDy0ASafq5jpKQy/McAPBjOkkdQ2Il2N17XB+yzyW
         Alue2Kln1MW0T13AuLYxLojgjkxo0uBwWjv7PJ9O/pTEne0ZwVWkr8176VdalPGcQQiP
         MlkRvhqwHI8P3rZZ2hmP+THGm88q/oqGN6POQVF+LQr4yaqVJkRTFr9Kx4ZWQZsgNjWm
         XzSQ==
X-Gm-Message-State: AGi0PuZcw5D671LQy+ES7OzMZnqorD2Q/HkdVSClSUPlsFW7DlXkd4FP
        dSMIrb0VUV4fqWJwnnz7up3s4H/FHH838kEmfit7
X-Google-Smtp-Source: APiQypLuMzn2Fcqvcv0F9XZkyuE+HFnD0yt3nmXqCfaozI4yfrCyuwTgkMfpvw5csg/HENiRR4/7BCtEFAcaRQnkdQg=
X-Received: by 2002:a17:906:4cd2:: with SMTP id q18mr269491ejt.70.1587589796101;
 Wed, 22 Apr 2020 14:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhT95GJKNTMvTtmZL35UOoVwbGH-eDWZyELb5oZ5rQU+Tw@mail.gmail.com>
 <2136640.1587472186@warthog.procyon.org.uk> <CAHC9VhQnORRaRapbb1wrUsxweJCRJ+X+RdvKw8_U0pT0fuxZ6A@mail.gmail.com>
In-Reply-To: <CAHC9VhQnORRaRapbb1wrUsxweJCRJ+X+RdvKw8_U0pT0fuxZ6A@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 22 Apr 2020 17:09:45 -0400
Message-ID: <CAHC9VhSUApfdxpFHbZLGqM1g=5XSZBYzxCCTDhhss_FidahbWw@mail.gmail.com>
Subject: Re: Problem with 9ba09998baa9 ("selinux: Implement the watch_key
 security hook") in linux-next
To:     David Howells <dhowells@redhat.com>
Cc:     keyrings@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 22, 2020 at 3:20 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Tue, Apr 21, 2020 at 8:29 AM David Howells <dhowells@redhat.com> wrote:
> > Paul Moore <paul@paul-moore.com> wrote:
> >
> > > ... in particular it is the fifth argument to avc_has_perm(),
> > > "KEY_NEED_VIEW" which is a problem.  KEY_NEED_VIEW is not a SELinux
> > > permission and would likely result in odd behavior when passed to
> > > avc_has_perm().
> >
> > I think it works because KEY_NEED_VIEW happens to coincide with KEY__VIEW.  It
> > should just use KEY__VIEW instead.
>
> Yes, it looks like it.  To be clear, it is dangerous to rely on
> permission values from outside SELinux aligning with SELinux
> permissions; changing the outside permission values w/o adjusting the
> SELinux hook code to do the necessary translation will result in some
> scary behavior (wrong permission checks).
>
> > > it probably makes the most sense to pull the permission mapping in
> > > selinux_key_permission() out into a separate function, e.g.
> > > key_perm_to_av(...)
> >
> > Agreed.  How about the attached patch?  I wonder if I should do bit-by-bit
> > translation rather than using a switch?  But then it's difficult to decide
> > what it means if someone passes in two KEY_NEED_* flags OR'd together - is it
> > either or both?
>
> Comments inline.
>
> > > and then use this newly created mapping function in [...]
> > > selinux_watch_key()
> >
> > No, I think I should just hard-code KEY__VIEW there.
>
> FWIW, my comment was based on a version of linux-next where you were
> making policycap based permission adjustments to KEY_VIEW and I
> thought you would want the same adjustments to be applied to both
> access control points.  That code appears to now be gone in
> linux-next.
>
> > ---
> > commit 70d1d82aa014ae4511976b4d80c17138006dddec
> > Author: David Howells <dhowells@redhat.com>
> > Date:   Tue Apr 21 13:15:16 2020 +0100
> >
> >     selinux: Fix use of KEY_NEED_* instead of KEY__* perms
> >
> >     selinux_key_getsecurity() is passing the KEY_NEED_* permissions to
> >     security_sid_to_context() instead of the KEY__* values.  It happens to work
> >     because the values are all coincident.
> >
> >     Fixes: d720024e94de ("[PATCH] selinux: add hooks for key subsystem")
> >     Reported-by: Paul Moore <paul@paul-moore.com>
> >     Signed-off-by: David Howells <dhowells@redhat.com>
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index 0b4e32161b77..32f7fa538c5f 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -6539,12 +6539,27 @@ static void selinux_key_free(struct key *k)
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
> > +               return 0;
> > +       }
>
> Regarding your question of permission translation via switch-statement
> as opposed to bit-by-bit comparison, I think it depends on if multiple
> permissions are going to be required in a single call to the hook.
> The failure mode for the code above if multiple permissions are
> requested is not very good, it defaults to *no* permission which means
> that if someone requested KEY_NEED_SEARCH|KEY_NEED_VIEW (or some other
> combination) then the SELinux check would not check any permissions
> ... that seems wrong to me.
>
> If we want to stick with a switch statement I think we should have it
> return -EPERM for the default case to protect against this.  We don't
> need the full 32-bits afforded us by the unsigned int.
>
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
> > @@ -6553,6 +6568,7 @@ static int selinux_key_permission(key_ref_t key_ref,
> >         if (perm == 0)
> >                 return 0;
> >
> > +       perm = selinux_keyperm_to_av(need_perm);
>
> ... and add a check for (perm < 0) as discussed above if we stick with
> the switch statement.

... and we should probably emit some sort of message to indicate that
an invalid permission set was used.

-- 
paul moore
www.paul-moore.com
