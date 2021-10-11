Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D855C433F5
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 20:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12AC760EE9
	for <selinux@archiver.kernel.org>; Mon, 11 Oct 2021 20:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbhJKUIW convert rfc822-to-8bit (ORCPT
        <rfc822;selinux@archiver.kernel.org>);
        Mon, 11 Oct 2021 16:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234835AbhJKUIW (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 11 Oct 2021 16:08:22 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83F4C061570;
        Mon, 11 Oct 2021 13:06:21 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1ma1Yv-00033F-K4; Mon, 11 Oct 2021 22:06:17 +0200
Date:   Mon, 11 Oct 2021 22:06:17 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Florian Westphal <fw@strlen.de>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 selinux] selinux: remove unneeded ipv6 hook wrappers
Message-ID: <20211011200617.GA2942@breakpoint.cc>
References: <20211011142416.26798-1-fw@strlen.de>
 <CAHC9VhRBYMMSucVbqUkcWTtyeuJ7SSuzDED=Cg=svWiaByo3Qw@mail.gmail.com>
 <CAFqZXNvHitBVyDga2CO2WAdxFwhY44xXoLkvmvVsPNGwqSe5zw@mail.gmail.com>
 <CAHC9VhTW9dPDN1F2o7S8cmgU_9yBZCNmzC_-9bKXTTX6zT=Jyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAHC9VhTW9dPDN1F2o7S8cmgU_9yBZCNmzC_-9bKXTTX6zT=Jyg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Paul Moore <paul@paul-moore.com> wrote:
> On Mon, Oct 11, 2021 at 2:21 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Mon, Oct 11, 2021 at 7:10 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Mon, Oct 11, 2021 at 10:25 AM Florian Westphal <fw@strlen.de> wrote:
> > > > Netfilter places the protocol number the hook function is getting called
> > > > from in state->pf, so we can use that instead of an extra wrapper.
> > > >
> > > > Signed-off-by: Florian Westphal <fw@strlen.de>
> > > > ---
> > > >  v2: add back '#endif /* CONFIG_NETFILTER */' erronously axed in v1.
> > > >  Applies to 'next' branch of
> > > >  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git/
> > > >
> > > >  security/selinux/hooks.c | 52 ++++++++++------------------------------
> > > >  1 file changed, 12 insertions(+), 40 deletions(-)
> > >
> > > ...
> > >
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index e7ebd45ca345..831b857d5dd7 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -7470,38 +7442,38 @@ DEFINE_LSM(selinux) = {
> > > >
> > > >  static const struct nf_hook_ops selinux_nf_ops[] = {
> > > >         {
> > > > -               .hook =         selinux_ipv4_postroute,
> > > > +               .hook =         selinux_hook_postroute,
> > > >                 .pf =           NFPROTO_IPV4,
> > > >                 .hooknum =      NF_INET_POST_ROUTING,
> > > >                 .priority =     NF_IP_PRI_SELINUX_LAST,
> > > >         },
> > >
> > > Thanks for the patch Florian, although the name "selinux_hook_*" seems
> > > a bit ambiguous to me, after all we have a little more than 200
> > > "hooks" in the SELinux LSM implementation.  Would you be okay with
> > > calling the netfilter hook functions "selinux_nf_*" or something
> > > similar?

Absolutely.

> > > If you don't have time I can do the rename during the merge
> > > assuming we can all agree on a name.

I'll submit a v3.

> > Since selinux_ip_forward() and selinux_ip_postroute() are used only in
> > the hook functions, how about changing their signature and using them
> > as hooks directly? That would solve the naming and also remove a few
> > extra lines of boilerplate.
> 
> No argument against that from me, although you should be able to do
> the same for selinux_ip_output() as well unless I missed a caller.

I'll have a look, thanks for the pointers.
