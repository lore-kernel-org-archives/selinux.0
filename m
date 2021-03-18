Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB200C433DB
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 15:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A77A64F24
	for <selinux@archiver.kernel.org>; Thu, 18 Mar 2021 15:13:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbhCRPNG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Mar 2021 11:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhCRPM7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Mar 2021 11:12:59 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D67C06174A
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 08:12:59 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z7so5139500lfd.5
        for <selinux@vger.kernel.org>; Thu, 18 Mar 2021 08:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KValNlVI9Xw/dtVul7NiW4HLdLuvV5kQaRWYDWIu0Qw=;
        b=b0/DJmqdKnkfR7ic02RvPoboHwuacf3RSuxkAc6MIGRS4Ipj+H2wV7e0zHDk1w0BXi
         c5foUJU2pNwLdq+fURIieecb/Or874syi3onbxU0GIrve2UAAljpLh02mGzNa8r0/wji
         64FcAGkcFOQJFQpu9VRUlmJSSDwwKGMruN88MGiK+z/jtvpo3Iwz4ShVBDQhD7Qv5evG
         0TqO2A2qi7Biv3Fvxlxd7HeUpxhmuaR/Z3ZFNphmC+Ss4vH7bfS9Z/+QDdQAkFt5sdze
         WKL4Ltu1KR1tPfrSaxh7uox+EWkkbRJyGCIgfwTkeXI6veZecZkdXRqWFPZ0LB1X/fEi
         bjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KValNlVI9Xw/dtVul7NiW4HLdLuvV5kQaRWYDWIu0Qw=;
        b=hBfwgFc1u+0OZAH/HZRBOlEAWO4yfbriQa4QqxUeg6M96xE38jEtU86Xqk9OG+ZpkA
         aKw4IYAfzoQu/CuWiEoynZqy89vJXjgDvHpS00Zq6fTy5V0BvhnoXLXMCg4z1elAxVL4
         cE/gOeNG/Qfl1FVYuOL2NQc4VJC+jQoYCrCdkCG0s0tJK6YHYjH2CoxtnM5Txvo2qtRE
         tC1MSq8ZuHbabEOQ/yZeln2Lpya47WSPfk9RzxAPdp70vhet1Y/sTdMP1UB5+WtndUcV
         xEUoPKzvc88PvTCT1oFwf0NIwaKfblr6LxSST5XagNbDgDEhF29sXnQIlWSdNdVlfK3h
         oYKQ==
X-Gm-Message-State: AOAM531GSvc6GivujKU79xpo+ecnDXvtPyKUMsxnjxhQBGESqB8MVj06
        H7WnDud8xQb2d+kDvl7XQoP4eR6YX11+qpWCf8q5B4xC59c=
X-Google-Smtp-Source: ABdhPJxvxrHs+7y1IFZY+sgdGLw7Iunoqov3GsH57ZSGJWj9ihbEHYEn4rtn3nHblrRGuxDNyfukFPX27Cfy/3UQonQ=
X-Received: by 2002:ac2:4250:: with SMTP id m16mr5429506lfl.40.1616080377172;
 Thu, 18 Mar 2021 08:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210212185930.130477-1-omosnace@redhat.com> <20210212185930.130477-2-omosnace@redhat.com>
 <CAHC9VhQLJKjY0KSC+=f4b=8d8n-m29j_9J5r_VQ_1BpSY8WD2w@mail.gmail.com>
 <CAFqZXNuBYwAT2-vLaTM8_Zng=vh+XsY_EvnzPYM4Z=PoCydZ+A@mail.gmail.com>
 <CAHC9VhSzDVyipy2y8ONiR_Q0YG50FnCJxgHsoi9Nee09hN0WCA@mail.gmail.com>
 <20210303025558.GH6000@sequoia> <CAFqZXNszZY-6Cg0ZaSUY1Y+EvfP-0QApVTJUOQkNt5jrTSgh5w@mail.gmail.com>
 <CAHC9VhSjtP9JN4XTWi0WyWnbF2j5D5HweQn9-Okut_D==UGQ-A@mail.gmail.com>
In-Reply-To: <CAHC9VhSjtP9JN4XTWi0WyWnbF2j5D5HweQn9-Okut_D==UGQ-A@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 18 Mar 2021 11:12:45 -0400
Message-ID: <CAEjxPJ4+-PUJW+PbNDwBjoAFJTNQ-7WDNgC3zybYNo3a9eFV=w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selinux: don't log MAC_POLICY_LOAD record on
 failed policy load
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Mar 18, 2021 at 10:48 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Wed, Mar 3, 2021 at 3:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > The situation has changed a bit since that was written, though... Back
> > then after the policy had been loaded there was no way to turn back
> > and if sel_make_policy_nodes() failed, the new policy would stay and
> > selinuxfs would have been left behind in an inconsistent/broken state.
> > Now this issue is fixed and the new policy isn't actually applied
> > until the selinuxfs preparation succeeds. So from a certain POV, the
> > selinuxfs failure is no longer that fatal and could just print a
> > warning like the other error path, because the result is the same
> > after both failures (active policy and selinuxfs state remains
> > unchanged).
> >
> > Paul (or Stephen if you are reading this and have time to comment),
> > what do you think?
>
> Sorry for the late reply, I lost this in my inbox and since I already
> marked the patchset as "changes requested" in patchwork it fell off my
> radar ...
>
> Anyway, back to your question ... it does seem like pr_warn() is the
> right answer here for the reasons that Ondrej mentioned above, and I
> personally feel it is in keeping with the original patch's intention
> as well; "If the policy fails to be loaded from userspace then a
> warning message is printed ..."  However, I'm not going to lose a lot
> of sleep over differences between pr_warn() and pr_err() here, if
> someone feels strongly that it should be pr_err() and can back that up
> with some solid reasoning and/or precedence then so be it.

That's fine with me.  FWIW, I think the rationale for using
pr_warn_ratelimited() for error returns from security_load_policy()
was that the failure could be entirely userspace-induced, i.e. just
pass the kernel an invalid policy.
The pr_err() messages on sel_make_bools/classes were in contrast
entirely kernel-internal errors and could leave the system in an
inconsistent state as you noted.
