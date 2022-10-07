Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E25C433F5
	for <selinux@archiver.kernel.org>; Fri,  7 Oct 2022 20:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbiJGUGj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 7 Oct 2022 16:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJGUGj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 7 Oct 2022 16:06:39 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220D212C88D
        for <selinux@vger.kernel.org>; Fri,  7 Oct 2022 13:06:37 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id w196so373759oiw.8
        for <selinux@vger.kernel.org>; Fri, 07 Oct 2022 13:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+dI2GSeqJYUU8VZ2aKJL6k9zynx9se5XfKL22XwWowQ=;
        b=al0ABjNWkFFZAh7iQ4L27x4qGsHRY0vNnMx0RJ0qN7QLOJrjICk5plnwFDzomAenib
         w2NoC7ztKpZTt6kVy+SPD089/391rVSLfXEsP95Gol5Mii4jBcV0rIpdzzvcHUpMYkuF
         Cj8be0CrNRimDCNuBnxiHidP6QvyDEoBzCHjDGvGWaqiViNmgoIIiJiB/fnWplZckxd1
         NvKfMOG2rYmjQCvsb1WZvl9R+hIifk+jf7BDbnrDNh6ZjCJG01aDoaMFA8+Lsl3c4s5W
         8+JJGay00lsQpb99mzWFTNQ/j20fR0ZH2eFPZaC6xx5TZjBI9qSh1Dmrh6Lw56GPP0Nr
         WlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+dI2GSeqJYUU8VZ2aKJL6k9zynx9se5XfKL22XwWowQ=;
        b=iRjPx9L0HBBcbzMAPxkpdN7FAFQ6dViM1x9pXZ+yjyjaYi4DciyuBVkqoni49Zq7xI
         MjtDiIpHLtvLBsj1s3Ep5uH7Eg3z0TLg8shUJIbhUsGkxGX7DErQLampdboqQVtfco4D
         87s4SLXsl9N1ja8yZbzBfCz0T3iV7cZNAKB/Zp1l5RUocf+usqiFg6f8UNIdH3SzUZSe
         I/I0yipZTihkrwz2BngT+sCTyA4X2hCK9LaC6YV8Jxa6GtKgnInI8dsyTry+ZA9zVz8q
         o864N/Ju8ynQ95pHszRACPB/xELWFKA4APF8yyK0Erpw79DZ3ORuwm9KezYI1ejjoibw
         yBgw==
X-Gm-Message-State: ACrzQf2PvVzvpNz/T9/RO1vj+H/stFetsmS96pVa/ZK0lAIt+kzPsmJz
        kEs82BaMItp3U3l51QppEx64CffIeki54xSqwda0
X-Google-Smtp-Source: AMsMyM5+hZXoD89CtXWSq9MM4P/HTzsoEJT6rYk6E9rOboipkwS81po7VkITOIbCVyDQtYZ3TPTfsffkeQ7NIK83yYM=
X-Received: by 2002:a05:6808:144b:b0:350:a06a:f8cb with SMTP id
 x11-20020a056808144b00b00350a06af8cbmr8631307oiv.51.1665173196437; Fri, 07
 Oct 2022 13:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhTGE1cf_WtDn4aDUY=E-m--4iZXWiNTwPZrP9AVoq17cw@mail.gmail.com>
 <CAHC9VhT2LK_P+_LuBYDEHnkNkAX6fhNArN_N5bF1qwGed+Kyww@mail.gmail.com> <CAADnVQ+kRCfKn6MCvfYGhpHF0fUWBU-qJqvM=1YPfj02jM9zKw@mail.gmail.com>
In-Reply-To: <CAADnVQ+kRCfKn6MCvfYGhpHF0fUWBU-qJqvM=1YPfj02jM9zKw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 7 Oct 2022 16:06:25 -0400
Message-ID: <CAHC9VhRcr03ZCURFi=EJyPvB3sgi44_aC5ixazC43Zs2bNJiDw@mail.gmail.com>
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

On Fri, Oct 7, 2022 at 3:13 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> On Fri, Oct 7, 2022 at 10:43 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Wed, Oct 5, 2022 at 4:44 PM Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > Hi Martin,
> > >
> > > In commit 4ff09db1b79b ("bpf: net: Change sk_getsockopt() to take the
> > > sockptr_t argument") I see you wrapped the getsockopt value/len
> > > pointers with sockptr_t and in the SO_PEERSEC case you pass the
> > > sockptr_t:user field to avoid having to update the LSM hook and
> > > implementations.  I think that's fine, especially as you note that
> > > eBPF does not support fetching the SO_PEERSEC information, but I think
> > > it would be good to harden this case to prevent someone from calling
> > > sk_getsockopt(SO_PEERSEC) with kernel pointers.  What do you think of
> > > something like this?
> > >
> > >   static int sk_getsockopt(...)
> > >   {
> > >     /* ... */
> > >     case SO_PEERSEC:
> > >       if (optval.is_kernel || optlen.is_kernel)
> > >         return -EINVAL;
> > >       return security_socket_getpeersec_stream(...);
> > >     /* ... */
> > >   }
> >
> > Any thoughts on this Martin, Alexei?  It would be nice to see this
> > fixed soon ...
>
> 'fixed' ?
> I don't see any bug.
> Maybe WARN_ON_ONCE can be added as a precaution, but also dubious value.

Prior to the change it was impossible to call
sock_getsockopt(SO_PEERSEC) with a kernel address space pointer, now
with 4ff09db1b79b is it possible to call sk_getsockopt(SO_PEERSEC)
with a kernel address space pointer and cause problems.  Perhaps there
are no callers in the kernel that do such a thing at the moment, but
it seems like an easy mistake for someone to make, and the code to
catch it is both trivial and out of any critical path.

This is one of those cases where preventing a future problem is easy,
I think it would be foolish of us to ignore it.

--
paul-moore.com
