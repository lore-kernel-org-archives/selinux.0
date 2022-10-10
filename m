Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DB4C4332F
	for <selinux@archiver.kernel.org>; Mon, 10 Oct 2022 15:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiJJPub (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Oct 2022 11:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJJPu3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Oct 2022 11:50:29 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5FF4C63B
        for <selinux@vger.kernel.org>; Mon, 10 Oct 2022 08:50:28 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id j188so6121412oih.4
        for <selinux@vger.kernel.org>; Mon, 10 Oct 2022 08:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DO4GpYcdA0tTiNcpTiMoYlXnuCvXtlp1R5KKQnxYFG4=;
        b=3e6FhGtAGmky97Bb/IyG6eDGfsrKsc5CsKU2zxNJ/ITIYbZELIJ/x9XYPkB+lvGVao
         QW2zgpMzMNT8lf6+o+tQ4fsVBiBiy185jtCZ5H27xXdS1aZCHIFj/RsiRpZ7/+Cy33d/
         WAcBOR5T7X6zX/iqfs0rH3Bio8df7czR02NYWwZlcyTrUX6+SQWyv0XQ6PvX3Rr4/iW6
         zPnKBAfxeqvXKjcE5ievcbQKsrlBZFdOPoXvesNrchGL3/AN9u6ta1F5EpxzPxyAfMt+
         /mueS5GJ8Ae30IwBgUJEDMN5yqXzirde+GTt6MQUqbpBLFGWrNjfPvM0bsjPZZoVPhL/
         xUgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DO4GpYcdA0tTiNcpTiMoYlXnuCvXtlp1R5KKQnxYFG4=;
        b=S0EJTOuQW45EFYqPyVlKfSxxLVRmsdtC+AR3iC17lNbLhG7c/FAJusgibCEjRiJCNR
         j8n4mP0e86/7MnN+R363mTXXkD9YXFdhgYEtVKPvbOsFkRXr4sy/tsHc66g070Sy6Z6x
         d1llvaDHHYtphPrTB7OHwvZAt2tn9ooq0ZUAzB4HtZperhYoAPzmTbXzZjRQNHBFwPo+
         hsU6Vo4W896RlzLc4zrrvJyVBrm3qOOtxifBo8LQec3HHy744BhWg72XDK4Trjl1aZmT
         6GOu+WojmKs91n4Ld43QnWpc9ZbqUAJ+JNTt7x89PC1c0mXo7FYvXznqnHDAkFv1F60X
         I+2w==
X-Gm-Message-State: ACrzQf38z3iDjs+epbPoR6whPxCad/MO5YrfyTxLoQVRC5iwu35Aq5bo
        Msacn40xTz6igzDTe/HrOQyAar6eQjTKEz2kLS0X
X-Google-Smtp-Source: AMsMyM69QaNjrurMuw8CbcRgunBF5eCxmJGo0F0JmERFmmGFenL8brLJv/MZHw8tiSPLRUg/OKRDlZyuEaHQ2xqyJY4=
X-Received: by 2002:a05:6808:144b:b0:350:a06a:f8cb with SMTP id
 x11-20020a056808144b00b00350a06af8cbmr14785624oiv.51.1665417027675; Mon, 10
 Oct 2022 08:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTGE1cf_WtDn4aDUY=E-m--4iZXWiNTwPZrP9AVoq17cw@mail.gmail.com>
 <CAHC9VhT2LK_P+_LuBYDEHnkNkAX6fhNArN_N5bF1qwGed+Kyww@mail.gmail.com>
 <CAADnVQ+kRCfKn6MCvfYGhpHF0fUWBU-qJqvM=1YPfj02jM9zKw@mail.gmail.com>
 <CAHC9VhRcr03ZCURFi=EJyPvB3sgi44_aC5ixazC43Zs2bNJiDw@mail.gmail.com>
 <CAADnVQJ5VgTNiEhEhOtESRrK0q3-pUSbZfAWL=tXv-s2GXqq8Q@mail.gmail.com>
 <CAHC9VhRmghJcZeUM6NS6J24tBOBxrZckwc2DqbqqqYif8hzopA@mail.gmail.com>
 <CAADnVQKe+wivnEMF99P27s9rCaOcFQcHFS5Ys+fAcF=mZS_eww@mail.gmail.com>
 <CAHC9VhQCU4wHCEF1MXm1dN_e4vqpK_Mny5Wnp8UHfaFU6rn4UA@mail.gmail.com> <CAADnVQKFON8jfrQB6wkVT4hn8UKLOFVQU4hes-XUr0P7gdvC+g@mail.gmail.com>
In-Reply-To: <CAADnVQKFON8jfrQB6wkVT4hn8UKLOFVQU4hes-XUr0P7gdvC+g@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Oct 2022 11:50:16 -0400
Message-ID: <CAHC9VhTVrWo0MrT1xXpmg_hmRyg4f3KWn1OD1B-v-xZgj-VXJQ@mail.gmail.com>
Subject: Re: SO_PEERSEC protections in sk_getsockopt()?
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Martin KaFai Lau <martin.lau@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 10, 2022 at 10:10 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Mon, Oct 10, 2022 at 6:29 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Mon, Oct 10, 2022 at 2:19 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > > On Sun, Oct 9, 2022 at 3:01 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Fri, Oct 7, 2022 at 5:55 PM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > On Fri, Oct 7, 2022 at 1:06 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > On Fri, Oct 7, 2022 at 3:13 PM Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > > On Fri, Oct 7, 2022 at 10:43 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > > > On Wed, Oct 5, 2022 at 4:44 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > > > >
> > > > > > > > > Hi Martin,
> > > > > > > > >
> > > > > > > > > In commit 4ff09db1b79b ("bpf: net: Change sk_getsockopt() to take the
> > > > > > > > > sockptr_t argument") I see you wrapped the getsockopt value/len
> > > > > > > > > pointers with sockptr_t and in the SO_PEERSEC case you pass the
> > > > > > > > > sockptr_t:user field to avoid having to update the LSM hook and
> > > > > > > > > implementations.  I think that's fine, especially as you note that
> > > > > > > > > eBPF does not support fetching the SO_PEERSEC information, but I think
> > > > > > > > > it would be good to harden this case to prevent someone from calling
> > > > > > > > > sk_getsockopt(SO_PEERSEC) with kernel pointers.  What do you think of
> > > > > > > > > something like this?
> > > > > > > > >
> > > > > > > > >   static int sk_getsockopt(...)
> > > > > > > > >   {
> > > > > > > > >     /* ... */
> > > > > > > > >     case SO_PEERSEC:
> > > > > > > > >       if (optval.is_kernel || optlen.is_kernel)
> > > > > > > > >         return -EINVAL;
> > > > > > > > >       return security_socket_getpeersec_stream(...);
> > > > > > > > >     /* ... */
> > > > > > > > >   }
> > > > > > > >
> > > > > > > > Any thoughts on this Martin, Alexei?  It would be nice to see this
> > > > > > > > fixed soon ...
> > > > > > >
> > > > > > > 'fixed' ?
> > > > > > > I don't see any bug.
> > > > > > > Maybe WARN_ON_ONCE can be added as a precaution, but also dubious value.
> > > > > >
> > > > > > Prior to the change it was impossible to call
> > > > > > sock_getsockopt(SO_PEERSEC) with a kernel address space pointer, now
> > > > > > with 4ff09db1b79b is it possible to call sk_getsockopt(SO_PEERSEC)
> > > > > > with a kernel address space pointer and cause problems.
> > > > >
> > > > > No. It's not possible. There is no path in the kernel that
> > > > > can do that.
> > > >
> > > > If we look at the very next sentence in my last reply you see that I
> > > > acknowledge that there may be no callers that currently do that, but
> > > > it seems like an easy mistake for someone to make.  I've seen kernel
> > > > coding errors similar to this in the past, it seems like a reasonable
> > > > thing to protect against, especially considering it is well outside of
> > > > any performance critical path.
> > > >
> > > > > > Perhaps there
> > > > > > are no callers in the kernel that do such a thing at the moment, but
> > > > > > it seems like an easy mistake for someone to make, and the code to
> > > > > > catch it is both trivial and out of any critical path.
> > > > >
> > > > > Not easy at all.
> > > > > There is only way place in the whole kernel that does:
> > > > >                 return sk_getsockopt(sk, SOL_SOCKET, optname,
> > > > >                                      KERNEL_SOCKPTR(optval),
> > > > >                                      KERNEL_SOCKPTR(optlen));
> > > > >
> > > > > and there is an allowlist of optname-s right in front of it.
> > > > > SO_PEERSEC is not there.
> > > > > For security_socket_getpeersec_stream to be called with kernel
> > > > > address the developer would need to add SO_PEERSEC to that allowlist.
> > > > > Which will be trivially caught during the code review.
> > > >
> > > > A couple of things come to mind ... First, the concern isn't the
> > > > existing caller(s), as mentioned above, but future callers.  Second,
> > > > while the kernel code review process is good, the number of serious
> > > > kernel bugs that have passed uncaught through the code review process
> > > > is staggering.
> > > >
> > > > > > This is one of those cases where preventing a future problem is easy,
> > > > > > I think it would be foolish of us to ignore it.
> > > > >
> > > > > Disagree. It's just a typical example of defensive programming
> > > > > which I'm strongly against.
> > > >
> > > > That's a pretty bold statement, good luck with that.
> > > >
> > > > > By that argument we should be checking all pointers for NULL
> > > > > "because it's easy to do".
> > > >
> > > > That's not the argument being made here, but based on your previous
> > > > statements of trusting code review to catch bugs and your opposition
> > > > to defensive programming it seems pretty unlikely we're going to find
> > > > common ground.
> > > >
> > > > I'll take care of this in the LSM tree.
> > >
> > > Are you saying you'll add a patch to sk_getsockopt
> > > in net/core/sock.c without going through net or bpf trees?
> > > Paul, you're crossing the line.
> >
> > I believe my exact comment was "I'll take care of this in the LSM
> > tree."  I haven't thought tpo hard about the details yet, but thinking
> > quickly I can imagine several different approaches with varying levels
> > of change required in sk_getsockopt(); it would be premature to
> > comment much beyond that.  It also looks like David Laight has similar
> > concerns, so it's possible he might work on resolving this too,
> > discussions are (obviously) ongoing.
> >
> > As far as crossing a line is concerned, I suggest you first look in
> > the mirror with respect to changes in the security/ subdir that did
> > not go through one of the LSM trees.  There are quite a few patches
> > from netdev/bpf that have touched security/ without going through a
> > LSM tree or getting a Reviewed-by/Acked-by/etc. from a LSM developer.
> > In fact I don't even have to go back a year and I see at least one
> > patch that touches code under security/ that was committed by you
> > without any LSM developer reviews/acks/etc.
>
> Since you're going to take patches to sock.c despite objections
> please make sure to add my Nack and see you at the next merge window.

I never committed to that, did I?

> Enough of this useless thread that destroyed trust and respect
> over complete non-issue.

I suggest re-reading this thread from the start in a few days, time
might soften some of your reactions and thoughts on this.

-- 
paul-moore.com
