Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3212C433F5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 19:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8507A60F22
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 19:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbhJKTnO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 15:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbhJKTnO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 15:43:14 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20D7C06161C
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 12:41:13 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id p13so72546688edw.0
        for <selinux@vger.kernel.org>; Mon, 11 Oct 2021 12:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/P5eDqGnkFMTqei8W8cogBr/ACT6bEHAZxYeHLGkxbo=;
        b=loJIvZ+1+KR0wvzPV64nR6JXN+d/9JTySVorg05IenNO25iBHQRhdOJbA6PiU95u51
         eXvP76F492Qdmx5aWBRQ/3RdNZJa3w5jSWNyQuVrkptiu3JixLdGZRJsEkmLXZabKNJe
         htOKRauVdSEop0Wp/GHLvktm9a6C1cQpsKNdWa+jROz7Ta8s622aVm3oyXXe2MX8/ltg
         hTItuzcbjdLCatXI/NokSFFjJfzo/MeuOZR0pJH+nWSYtJkic4Fok/wTlVfN0dMVqaDW
         dapSC3SPE5RYiMtaIPi41GhikpxIp1SASq9zlBjks7R1RJLXlRa0f6uTGSVHKq1y7/9a
         GUJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/P5eDqGnkFMTqei8W8cogBr/ACT6bEHAZxYeHLGkxbo=;
        b=V1YTl4Ze6RINdBGdNq9DEy35eoeO1abE7hFMRZ8ZG+CYJr0EVjoOa952tmWBAt8U7p
         2L+gNzIXd0QrwXft1210kyO62pUhRxj2myNKCpezBzYP+vXSIycrtO76K4KwwD+TzB/x
         +nDwAev2FO4NNR8s1DT+4Sf1U3wxCr3va/ViaDpWKOmPJogHcKRfUZ/KDf0iUXRZ1sFW
         UFMcSOEL7JDm8qz27qvn1UfodL0Ywmi9FxOfZn53rlC9mOz3NGIGfNYxLN+on7AY5uU+
         zyisVUthWsMDNPb81+RrV6SGnSC3g9eXf2WOsEO3gZ0QnmxcWCkZ/j41UqRUiGpyzuxF
         ayHw==
X-Gm-Message-State: AOAM530W/ncW49EU83jG6Jav8QDUM4NVB0RlzWPMk0IWBI4LCEqplqKe
        rEtnze0FtPKM5PBdPEFqB95llVGljTErwx5OwHHU
X-Google-Smtp-Source: ABdhPJzawb/YkhnqDinT3y22KHkiXsJoOEjU166pAt3faycsQ5ob6CFm0m1JWdCy4hIX13Wxz/1h8m1F71SWuQy/5W8=
X-Received: by 2002:a05:6402:5114:: with SMTP id m20mr44167328edd.256.1633981272402;
 Mon, 11 Oct 2021 12:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <20211011142416.26798-1-fw@strlen.de> <CAHC9VhRBYMMSucVbqUkcWTtyeuJ7SSuzDED=Cg=svWiaByo3Qw@mail.gmail.com>
 <CAFqZXNvHitBVyDga2CO2WAdxFwhY44xXoLkvmvVsPNGwqSe5zw@mail.gmail.com>
In-Reply-To: <CAFqZXNvHitBVyDga2CO2WAdxFwhY44xXoLkvmvVsPNGwqSe5zw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 11 Oct 2021 15:41:01 -0400
Message-ID: <CAHC9VhTW9dPDN1F2o7S8cmgU_9yBZCNmzC_-9bKXTTX6zT=Jyg@mail.gmail.com>
Subject: Re: [PATCH v2 selinux] selinux: remove unneeded ipv6 hook wrappers
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Florian Westphal <fw@strlen.de>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 11, 2021 at 2:21 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Mon, Oct 11, 2021 at 7:10 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Oct 11, 2021 at 10:25 AM Florian Westphal <fw@strlen.de> wrote:
> > >
> > > Netfilter places the protocol number the hook function is getting called
> > > from in state->pf, so we can use that instead of an extra wrapper.
> > >
> > > Signed-off-by: Florian Westphal <fw@strlen.de>
> > > ---
> > >  v2: add back '#endif /* CONFIG_NETFILTER */' erronously axed in v1.
> > >  Applies to 'next' branch of
> > >  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/
> > >
> > >  security/selinux/hooks.c | 52 ++++++++++------------------------------
> > >  1 file changed, 12 insertions(+), 40 deletions(-)
> >
> > ...
> >
> > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > index e7ebd45ca345..831b857d5dd7 100644
> > > --- a/security/selinux/hooks.c
> > > +++ b/security/selinux/hooks.c
> > > @@ -7470,38 +7442,38 @@ DEFINE_LSM(selinux) = {
> > >
> > >  static const struct nf_hook_ops selinux_nf_ops[] = {
> > >         {
> > > -               .hook =         selinux_ipv4_postroute,
> > > +               .hook =         selinux_hook_postroute,
> > >                 .pf =           NFPROTO_IPV4,
> > >                 .hooknum =      NF_INET_POST_ROUTING,
> > >                 .priority =     NF_IP_PRI_SELINUX_LAST,
> > >         },
> >
> > Thanks for the patch Florian, although the name "selinux_hook_*" seems
> > a bit ambiguous to me, after all we have a little more than 200
> > "hooks" in the SELinux LSM implementation.  Would you be okay with
> > calling the netfilter hook functions "selinux_nf_*" or something
> > similar?  If you don't have time I can do the rename during the merge
> > assuming we can all agree on a name.
>
> Since selinux_ip_forward() and selinux_ip_postroute() are used only in
> the hook functions, how about changing their signature and using them
> as hooks directly? That would solve the naming and also remove a few
> extra lines of boilerplate.

No argument against that from me, although you should be able to do
the same for selinux_ip_output() as well unless I missed a caller.

-- 
paul moore
www.paul-moore.com
