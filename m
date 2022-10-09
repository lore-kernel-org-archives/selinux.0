Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072ADC433F5
	for <selinux@archiver.kernel.org>; Sun,  9 Oct 2022 22:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiJIWBZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sun, 9 Oct 2022 18:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbiJIWBX (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sun, 9 Oct 2022 18:01:23 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DE81D0F8
        for <selinux@vger.kernel.org>; Sun,  9 Oct 2022 15:01:22 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id x6-20020a4ac586000000b0047f8cc6dbe4so6934080oop.3
        for <selinux@vger.kernel.org>; Sun, 09 Oct 2022 15:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uCRLYNKaUNlApcpDFpNyoRTJy58BtqMBs8QGQONvN8k=;
        b=vGC2eDM3rEem/eh/5h8SDEjqOetEl07JAHYwzB9ONsarnjg7j3usGYgj54DnxwISnN
         zJb7uM4oIhyXpc84kXLleo7oYgPeZpggHIhpAlSud3HZ+U8x6UCb2MJeKWUn0dNtvMHX
         QiKZgUNGZE+TTEp2USGjQEhcGrmonl4I+UQObvkjIBPrQ8GTLtkAlELA9o+0NpFbf195
         uiZyfI6RadwMh8lW2i3BEf1VXZAopWlsLrS8w3sO11x2uEEsltqe7N6BDaT2NNxFtr8d
         /X/CODbWkumcwphx0PQANx9dRTxEyZz62XHdzRqo5GlxUGiD4yhC+jyizLgCaPqXHe6/
         dRRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uCRLYNKaUNlApcpDFpNyoRTJy58BtqMBs8QGQONvN8k=;
        b=vZXd+tTRsZ4KTOxNvwr4vnnwR7RYmGFGasNYiA3RP3plcdpUUJvSC2qR8acBA54Yyp
         ckOdk7lpF9xEcQpqDP3ZoG3SPBnngaobacP65BuPWQQkI7ArNAycEch48CK2ShZH7Zz5
         l4winVSbGu4+mZZ84qlWBdf8qJh3OpOuFRzbat2OPP+hV/conJeU5yv0mCZ5csjtnoOx
         9CvRq9Mgp3qiFmNBtB+iwid2f58AaOMvE92EuZ2899YxL/frEcu2fFk+NRvOxRsmifCw
         14NU5GMqn4Tels43QjCJdqpMheg/EOuYtnZbaNQgs8Aj17IcJTXpqWrhMWd6Vp08ZeX0
         CyhA==
X-Gm-Message-State: ACrzQf3466/i8tcOu3bkWp83mfQ6Vl05ufw6tAlne8Whg/zr5Cl/IVga
        xB6SVUEwZx879M8H+jylBPewDWpGSN24L5ceqL/K
X-Google-Smtp-Source: AMsMyM4asPKdAkOMP82nbVM7coRwFd3bhcIe35xgsbLTxbleHkmJxrxhoowiCfpYkkfMYzO+c4pIpcQeh1JWVfTh1ws=
X-Received: by 2002:a05:6830:6403:b0:661:9295:af6b with SMTP id
 cj3-20020a056830640300b006619295af6bmr2613406otb.287.1665352881919; Sun, 09
 Oct 2022 15:01:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTGE1cf_WtDn4aDUY=E-m--4iZXWiNTwPZrP9AVoq17cw@mail.gmail.com>
 <CAHC9VhT2LK_P+_LuBYDEHnkNkAX6fhNArN_N5bF1qwGed+Kyww@mail.gmail.com>
 <CAADnVQ+kRCfKn6MCvfYGhpHF0fUWBU-qJqvM=1YPfj02jM9zKw@mail.gmail.com>
 <CAHC9VhRcr03ZCURFi=EJyPvB3sgi44_aC5ixazC43Zs2bNJiDw@mail.gmail.com> <CAADnVQJ5VgTNiEhEhOtESRrK0q3-pUSbZfAWL=tXv-s2GXqq8Q@mail.gmail.com>
In-Reply-To: <CAADnVQJ5VgTNiEhEhOtESRrK0q3-pUSbZfAWL=tXv-s2GXqq8Q@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 9 Oct 2022 18:01:10 -0400
Message-ID: <CAHC9VhRmghJcZeUM6NS6J24tBOBxrZckwc2DqbqqqYif8hzopA@mail.gmail.com>
Subject: Re: SO_PEERSEC protections in sk_getsockopt()?
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Martin KaFai Lau <martin.lau@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Oct 7, 2022 at 5:55 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Fri, Oct 7, 2022 at 1:06 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Fri, Oct 7, 2022 at 3:13 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Fri, Oct 7, 2022 at 10:43 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Wed, Oct 5, 2022 at 4:44 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > >
> > > > > Hi Martin,
> > > > >
> > > > > In commit 4ff09db1b79b ("bpf: net: Change sk_getsockopt() to take the
> > > > > sockptr_t argument") I see you wrapped the getsockopt value/len
> > > > > pointers with sockptr_t and in the SO_PEERSEC case you pass the
> > > > > sockptr_t:user field to avoid having to update the LSM hook and
> > > > > implementations.  I think that's fine, especially as you note that
> > > > > eBPF does not support fetching the SO_PEERSEC information, but I think
> > > > > it would be good to harden this case to prevent someone from calling
> > > > > sk_getsockopt(SO_PEERSEC) with kernel pointers.  What do you think of
> > > > > something like this?
> > > > >
> > > > >   static int sk_getsockopt(...)
> > > > >   {
> > > > >     /* ... */
> > > > >     case SO_PEERSEC:
> > > > >       if (optval.is_kernel || optlen.is_kernel)
> > > > >         return -EINVAL;
> > > > >       return security_socket_getpeersec_stream(...);
> > > > >     /* ... */
> > > > >   }
> > > >
> > > > Any thoughts on this Martin, Alexei?  It would be nice to see this
> > > > fixed soon ...
> > >
> > > 'fixed' ?
> > > I don't see any bug.
> > > Maybe WARN_ON_ONCE can be added as a precaution, but also dubious value.
> >
> > Prior to the change it was impossible to call
> > sock_getsockopt(SO_PEERSEC) with a kernel address space pointer, now
> > with 4ff09db1b79b is it possible to call sk_getsockopt(SO_PEERSEC)
> > with a kernel address space pointer and cause problems.
>
> No. It's not possible. There is no path in the kernel that
> can do that.

If we look at the very next sentence in my last reply you see that I
acknowledge that there may be no callers that currently do that, but
it seems like an easy mistake for someone to make.  I've seen kernel
coding errors similar to this in the past, it seems like a reasonable
thing to protect against, especially considering it is well outside of
any performance critical path.

> > Perhaps there
> > are no callers in the kernel that do such a thing at the moment, but
> > it seems like an easy mistake for someone to make, and the code to
> > catch it is both trivial and out of any critical path.
>
> Not easy at all.
> There is only way place in the whole kernel that does:
>                 return sk_getsockopt(sk, SOL_SOCKET, optname,
>                                      KERNEL_SOCKPTR(optval),
>                                      KERNEL_SOCKPTR(optlen));
>
> and there is an allowlist of optname-s right in front of it.
> SO_PEERSEC is not there.
> For security_socket_getpeersec_stream to be called with kernel
> address the developer would need to add SO_PEERSEC to that allowlist.
> Which will be trivially caught during the code review.

A couple of things come to mind ... First, the concern isn't the
existing caller(s), as mentioned above, but future callers.  Second,
while the kernel code review process is good, the number of serious
kernel bugs that have passed uncaught through the code review process
is staggering.

> > This is one of those cases where preventing a future problem is easy,
> > I think it would be foolish of us to ignore it.
>
> Disagree. It's just a typical example of defensive programming
> which I'm strongly against.

That's a pretty bold statement, good luck with that.

> By that argument we should be checking all pointers for NULL
> "because it's easy to do".

That's not the argument being made here, but based on your previous
statements of trusting code review to catch bugs and your opposition
to defensive programming it seems pretty unlikely we're going to find
common ground.

I'll take care of this in the LSM tree.

-- 
paul-moore.com
