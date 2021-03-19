Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8572EC433E6
	for <selinux@archiver.kernel.org>; Fri, 19 Mar 2021 12:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B93E64F69
	for <selinux@archiver.kernel.org>; Fri, 19 Mar 2021 12:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhCSM5s (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 19 Mar 2021 08:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhCSM5X (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 19 Mar 2021 08:57:23 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B499C061765
        for <selinux@vger.kernel.org>; Fri, 19 Mar 2021 05:57:23 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id z6-20020a1c4c060000b029010f13694ba2so5170763wmf.5
        for <selinux@vger.kernel.org>; Fri, 19 Mar 2021 05:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XpPGUE6BByswa3Ep4l8WzlVumVFkgxbvdRbN1GhWJbU=;
        b=eQ2OMBnwvXNj4Zdcbf4Hf8XhhOBTeJwVU8tZfivPCrGq/tqqyHwo+0+7sVu6f/FsOF
         2OxuJiRcYb+ik93a+6pEZWp7tjd8+5ZGYphQIC53Le4n8JIjcX44lFddF1HSGvwZed2B
         Kdty/Fkttsnba/u2wxbAW5PS5T45tIkJ0NOMrBS5T1OqETZjK5ywTXFrxyTHOnG0UEDs
         YwqAQK/gQEYhzSjBYukkAxpoaF+2mwqUDnY9us+Z2wK1PX5EK6/psOtGTwp+gwxvvLao
         0b4J3h/UircWR7ovcTz20HRQhi0PF74RiV9kaVNlVJ+dVdgg+O5M2++cy91mMuVOguqX
         kI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XpPGUE6BByswa3Ep4l8WzlVumVFkgxbvdRbN1GhWJbU=;
        b=a6qoOPjUY5QXDnvfeUCSwKTmA6ytRWELXjvn2KGLRNsE/8dn7G4X3e4CCpl5zx+Io4
         0cIg4pE6YR+d94MAT9Iz6gM6fj9Q6HfFbcR6+ldUKi/HR+UDidp/nqrIvhsRNAus1C+1
         TiyXyJLegpXByZKuIEXXwPop20U6cexwpOABBsV5HIqxfG2Rx0R+ouiFSID05VOyA4U4
         9qhWDpsDndB5bu7gA/JHAXpyoRAJz/7qd6kYaZDHZX/z9PZAq7Kdpx0FTU8yus7ZBaMl
         W3CEoQaXBPE6IXh+xh2391x5vxN9nGqmm1niWDrQSZ8IUVSo9YxzsnQ4dL7CAy67KMXb
         83hQ==
X-Gm-Message-State: AOAM533tse7r+DQZJ6oEZ4TXoTCqKw+Car31Nc5R4Ux8LN3QygLmEc70
        ealNxBxGUNxRm5pMROrbNn9JQg==
X-Google-Smtp-Source: ABdhPJwFVAyOf6DKJnWgPfK9dHaCFpWzGKth3FaOBlGYV9sO/L5kI4EXuCeCC1XVjuYkH/4Z1drgHQ==
X-Received: by 2002:a1c:448a:: with SMTP id r132mr3621997wma.157.1616158641830;
        Fri, 19 Mar 2021 05:57:21 -0700 (PDT)
Received: from google.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id s84sm6605286wme.11.2021.03.19.05.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 05:57:21 -0700 (PDT)
Date:   Fri, 19 Mar 2021 12:57:16 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Kees Cook <keescook@chromium.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Alistair Delva <adelva@google.com>
Subject: Re: [PATCH] selinux: vsock: Set SID for socket returned by accept()
Message-ID: <YFSfrIZAz6zHENT7@google.com>
References: <20210317154448.1034471-1-dbrazdil@google.com>
 <CAHC9VhT_+i9V9N7NAdCCUgO5xBZpffvVPeh=jK8weZr3WzZ4Bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhT_+i9V9N7NAdCCUgO5xBZpffvVPeh=jK8weZr3WzZ4Bw@mail.gmail.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Paul,

I'll post a v2 shortly but will address your comments here.

> >  include/linux/lsm_hooks.h     |  7 +++++++
> >  include/linux/security.h      |  5 +++++
> >  net/vmw_vsock/af_vsock.c      |  1 +
> >  security/security.c           |  5 +++++
> >  security/selinux/hooks.c      | 10 ++++++++++
> >  6 files changed, 29 insertions(+)
> 
> Additional comments below, but I think it would be a good idea for you
> to test your patches on a more traditional Linux distribution as well
> as Android.
> 

No problem, I was going to add a test case into selinux-testsuite
anyway. Done now (link in v2) and tested on Fedora 33 with v5.12-rc3.

> > diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> > index 5546710d8ac1..a9bf3b90cb2f 100644
> > --- a/net/vmw_vsock/af_vsock.c
> > +++ b/net/vmw_vsock/af_vsock.c
> > @@ -755,6 +755,7 @@ static struct sock *__vsock_create(struct net *net,
> >                 vsk->buffer_size = psk->buffer_size;
> >                 vsk->buffer_min_size = psk->buffer_min_size;
> >                 vsk->buffer_max_size = psk->buffer_max_size;
> > +               security_vsock_sk_clone(parent, sk);
> 
> Did you try calling the existing security_sk_clone() hook here?  I
> would be curious to hear why it doesn't work in this case.
> 
> Feel free to educate me on AF_VSOCK, it's entirely possible I'm
> misunderstanding something here :)
> 

No, you're completely right. security_sk_clone does what's needed here.
Adding a new hook was me trying to mimic other socket families going via
selinux_conn_sid. Happy to reuse the existing hook - makes this a nice
oneliner. :)

Please note that I'm marking v2 with 'Fixes' for backporting. This does
feel to me like a bug, an integration that was never considered. Please
shout if you disagree.

-David
