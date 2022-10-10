Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AD9C433F5
	for <selinux@archiver.kernel.org>; Mon, 10 Oct 2022 22:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJJWpr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 10 Oct 2022 18:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJJWpU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 10 Oct 2022 18:45:20 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9995FCF
        for <selinux@vger.kernel.org>; Mon, 10 Oct 2022 15:44:37 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id g10so6892279oif.10
        for <selinux@vger.kernel.org>; Mon, 10 Oct 2022 15:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zsbB2rGCYoi623fSJKV45hIHRrGKlZfDT44mehW/cG8=;
        b=W5c6eVu4x+3HVRv591KszOer6s+Mw9QmnzeiCovYHgGob1SrjdYtUn//QvyDSyBt4w
         Lj5E42AnYEN8v6lEf9K/GPVYVlYiDdk/a1gcMXwTJoQGSG7Wi5Urdu8NW2kN93kl9PxK
         QU8kaMayg4AWIz89tH+/Uf3n8yQWBKaVrb10FQFKR5nrT1j+vzV14TPATK3n7UvljLvT
         gra0S2SaOJRfKJQX9ZQ/cgTJi3hjBNUbXKSozCmcXjKkt4sP9LCOmjp0QIgwB83RBRFg
         bMJlZV8b5A8Vcf5Jnb0PrFSJ9qBwasSJjMn1ixSpRZ928YH0qyQoDRliRCdSS6VlSr+H
         xkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zsbB2rGCYoi623fSJKV45hIHRrGKlZfDT44mehW/cG8=;
        b=eGOxbvmDAN3qLa1VWZROE6am75jX5JIl4EZeOcOGM4yysdDwkhf0yNdCaiyhgY3IG4
         00zPGYFvfZnZWDIGgoxqxvZ1mW4jXnR8GAbOCAVJNL8dI3QFYapvuAIeJ6BiiSlTvqXD
         V2umUOC5XpUqsmZ5GBr2XLjessT+kX5bGH0vE2x89+BkIUsOo9jN34e1KZX+5hVBzbnl
         9NP4ztJ933YCAPD3D5sF0pyzrS6S2qZrzYPpyOGlXmTv1SvPaQVjRqllFewoMIEb6LRq
         ARtv4xP2TDr5elKf+xPYRFJc1uU0hjPygGDnSfJ6rqlCVDNzR+o0znasRywqjbVQhBHD
         bPOA==
X-Gm-Message-State: ACrzQf0MfC2cK7A9wL+4iCvqlnVv1n2YB76f3FiFQPE2fE6HKgIocOPG
        ofuM41Jmf0+Z6+ueBeyimDjotV6QWXRLgvqRMuWc
X-Google-Smtp-Source: AMsMyM7OgWZHOglN20o7aWnJRJY7CLKqevq3v+hZm3i7Y4mFOb9UFhi+WG52EEWyzfiYodrJ4LPDo58V1siIJtiximw=
X-Received: by 2002:a05:6808:30aa:b0:354:b221:19d9 with SMTP id
 bl42-20020a05680830aa00b00354b22119d9mr1698667oib.172.1665441875060; Mon, 10
 Oct 2022 15:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <166543910984.474337.2779830480340611497.stgit@olly>
 <CAHC9VhRfEiJunPo7bVzmPPg8UHDoFc0wvOhBaFrsLjfeDCg50g@mail.gmail.com> <4d29068f-2e42-5c3b-9b74-85dda8b50f6b@schaufler-ca.com>
In-Reply-To: <4d29068f-2e42-5c3b-9b74-85dda8b50f6b@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 10 Oct 2022 18:44:33 -0400
Message-ID: <CAHC9VhQkUNrSHqS46yXvMJyL9PmGaTE6nQQcFdmrSAAjjCd8+w@mail.gmail.com>
Subject: Re: [PATCH] lsm: make security_socket_getpeersec_stream() sockptr_t safe
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        netdev@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Oct 10, 2022 at 6:39 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 10/10/2022 3:00 PM, Paul Moore wrote:
> > On Mon, Oct 10, 2022 at 5:58 PM Paul Moore <paul@paul-moore.com> wrote:
> >> Commit 4ff09db1b79b ("bpf: net: Change sk_getsockopt() to take the
> >> sockptr_t argument") made it possible to call sk_getsockopt()
> >> with both user and kernel address space buffers through the use of
> >> the sockptr_t type.  Unfortunately at the time of conversion the
> >> security_socket_getpeersec_stream() LSM hook was written to only
> >> accept userspace buffers, and in a desire to avoid having to change
> >> the LSM hook the commit author simply passed the sockptr_t's
> >> userspace buffer pointer.  Since the only sk_getsockopt() callers
> >> at the time of conversion which used kernel sockptr_t buffers did
> >> not allow SO_PEERSEC, and hence the
> >> security_socket_getpeersec_stream() hook, this was acceptable but
> >> also very fragile as future changes presented the possibility of
> >> silently passing kernel space pointers to the LSM hook.
> >>
> >> There are several ways to protect against this, including careful
> >> code review of future commits, but since relying on code review to
> >> catch bugs is a recipe for disaster and the upstream eBPF maintainer
> >> is "strongly against defensive programming", this patch updates the
> >> LSM hook, and all of the implementations to support sockptr_t and
> >> safely handle both user and kernel space buffers.
> >>
> >> Signed-off-by: Paul Moore <paul@paul-moore.com>
> >> ---
> >>  include/linux/lsm_hook_defs.h |    2 +-
> >>  include/linux/lsm_hooks.h     |    4 ++--
> >>  include/linux/security.h      |   11 +++++++----
> >>  net/core/sock.c               |    3 ++-
> >>  security/apparmor/lsm.c       |   29 +++++++++++++----------------
> >>  security/security.c           |    6 +++---
> >>  security/selinux/hooks.c      |   13 ++++++-------
> >>  security/smack/smack_lsm.c    |   19 ++++++++++---------
> >>  8 files changed, 44 insertions(+), 43 deletions(-)
> > Casey and John, could you please look over the Smack and AppArmor bits
> > of this patch when you get a chance?  I did my best on the conversion,
> > but I would appreciate a review by the experts :)
>
> I'm off the grid until 10/20, but will add this to my do-asap stack.

No worries, this is linux-next stuff anyway so no real rush at this
point.  Enjoy the time away.

-- 
paul-moore.com
