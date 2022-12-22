Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E0FC4167B
	for <selinux@archiver.kernel.org>; Thu, 22 Dec 2022 15:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiLVP6Z (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 22 Dec 2022 10:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234968AbiLVP6W (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 22 Dec 2022 10:58:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419CEBC8B
        for <selinux@vger.kernel.org>; Thu, 22 Dec 2022 07:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671724655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x5VXoJ1iG6D6T430sOtOSp45mTWDSL9bWW7eZEVH72Y=;
        b=QQCujgq6N6Tp9M6q3iNt44P7/JAZ3nuiXARwst/D8ZcfRXfby0ChhUsyZruMpPdqsDHB+W
        Jjj8A3qCSB31MRiAuewk9aK6IcNNhB4S7r2dZ3gqBU4cjJXeX+aOrJJH+u+hF9I0/Y4+3Y
        10dZD1a7enTA2VKU+aFlEwISbWrWbl4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-614-XLpGqhcHO7W0s-3QVFXTIQ-1; Thu, 22 Dec 2022 10:57:33 -0500
X-MC-Unique: XLpGqhcHO7W0s-3QVFXTIQ-1
Received: by mail-wm1-f70.google.com with SMTP id x10-20020a05600c420a00b003cfa33f2e7cso1033093wmh.2
        for <selinux@vger.kernel.org>; Thu, 22 Dec 2022 07:57:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x5VXoJ1iG6D6T430sOtOSp45mTWDSL9bWW7eZEVH72Y=;
        b=FPp5Y5jyfIhTMs80dHy8d/jMMM1LqwFGB+aqmF+/mWMYRR5q+xWH2rxV0B+OCDaixQ
         DflImJj0yS6UPFg1PHbZEqO0AjhlOoKXrQNlFBjwW2p5XJWrJvr1fCPfCGrKFnvsnHB8
         Vu/tbl4MLo7OZr+Uxv91mxLi5SlQpr59yxycv7aQVXmSRcegdpUHWTCL4umsa+NHLH0L
         cszPdbhb0YpHfZrDqKTI8Y6BdX8JhSIi2jkKUHRLpGIFwzh/SEwMSYv/Df1g+avHj9VE
         qbRr+FbBOkD+jmQEFVaIyuuMa8HeBVDaes2oNU3emPnTHBNoReJX01eGpb5G/si6GdYR
         DWZg==
X-Gm-Message-State: AFqh2kqovITg1krjgjzSbgbkuJ0GCCC2T//U2yRdySViD0sQf6MFny9n
        ZUkaWdh8k+CBtdlNm8ipe9m7ZB9nCFPGzxmFnuZBdHhtAc0002LesQNLgymQVLlU1KBtN9kKGQb
        Z8NxCKvKYz/DkmukvLA==
X-Received: by 2002:a05:600c:2d85:b0:3d0:7d89:2256 with SMTP id i5-20020a05600c2d8500b003d07d892256mr4667368wmg.13.1671724652794;
        Thu, 22 Dec 2022 07:57:32 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtUaa+OoEvrKP/DEfFr3TMLGonyxPaxFxG2tCDsxoPdOOnNlChgeQsMs09L7q7KAxfnNgCAew==
X-Received: by 2002:a05:600c:2d85:b0:3d0:7d89:2256 with SMTP id i5-20020a05600c2d8500b003d07d892256mr4667355wmg.13.1671724652501;
        Thu, 22 Dec 2022 07:57:32 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-101-173.dyn.eolo.it. [146.241.101.173])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b003cfa81e2eb4sm1390826wmb.38.2022.12.22.07.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 07:57:31 -0800 (PST)
Message-ID: <fd3ca85bbaceea0ef629c35a0a63129cb6090811.camel@redhat.com>
Subject: Re: [PATCH v2 2/2] selinux: Implement mptcp_add_subflow hook
From:   Paolo Abeni <pabeni@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        mptcp@lists.linux.dev
Date:   Thu, 22 Dec 2022 16:57:30 +0100
In-Reply-To: <CAHC9VhTZ-boJeMs3ir-6=rCxyfY3ROjZ4qeXyuoo5DRPBw6gew@mail.gmail.com>
References: <cover.1671469167.git.pabeni@redhat.com>
         <3074022fdca04676443a9c74f57328eb729f150e.1671469167.git.pabeni@redhat.com>
         <CAHC9VhRYr9=qKUeF0EuY46koCnkeZ5d-=umV5TxbiUZ7qNXJ6w@mail.gmail.com>
         <944c4ab043713f75ad3bb512fc146e48de7b3e25.camel@redhat.com>
         <CAHC9VhTZ-boJeMs3ir-6=rCxyfY3ROjZ4qeXyuoo5DRPBw6gew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, 2022-12-21 at 20:21 -0500, Paul Moore wrote:
> On Wed, Dec 21, 2022 at 2:24 PM Paolo Abeni <pabeni@redhat.com> wrote:
> > I just tested the other option and there is another problem :(
> 
> It's never easy, is it? ;)
> 
> > The first subflow creations happens inside af_inet->create, via the sk-
> > > sk_prot->init() hook. The security_socket_post_create() call on the
> > owning MPTCP sockets happens after that point. So we copy data from a
> > not yet initialized security context (and the test fail badly).
> 
> Hmmm.  Let's come back to this later on down this email.
> 
> > There are a few options to cope with that:
> > - [ugly hack] call  security_socket_post_create() on the mptcp code
> > before creating the subflow. I experimented this just to double the
> > problem and a possible solution.
> 
> I'm guessing "[ugly hack]" is probably a bit of an understatement.
> Let's see if we can do better before we explore this option too much
> further.

Yup, I compiled the list in "brainstom-mode", trying to include
whatever would be possible even if clearly not suitable. 

[...]

> > WDYT?
> 
> Let's go back to the the inet_create() case for a little bit.  I'm
> thinking we might be able to do something by leveraging the
> sk_alloc()->sk_prot_alloc()->security_sk_alloc() code path.  As
> inet_create() is going to be called from task context here, it seems
> like we could do the sock's sid/sclass determination here, cached in
> separate fields in the sk_security_struct if necessary, and use those
> in a new MPTCP subflow hook.  We could also update
> selinux_socket_post_create() to take advantage of this as well.  We
> could also possibly pass the proto struct into security_sk_alloc() if
> we needed to identify IPPROTO_MPTCP there as well.
> 
> I'll admit to not chasing down all the details, but I suspect this may
> be the cleanest option - thoughts?

Thanks, I did not consider such possibility!

I think we should be careful to avoid increasing sk_security_struct
size. Currently it is 16 bytes, nicely matching a kmalloc slab, any
increase will move it on kmalloc-32 bytes slab possibly causing
performance and memory regressions).

More importantly, I think there is a problem with the 
sk_clone_lock() -> sk_prot_alloc() -> security_sk_alloc()
code path. 

sk_clone_lock() happens in BH context, if security_transition_sid()
needs process context that would be a problem - quickly skimming the
code it does not look so, I need to double check.

sk_clone_lock() is in a very critical path - socket creation for
incoming connections. The sid-related operation there will be
unnecessary/discarded by later the selinux_inet_csk_clone(), this will
likelly cause performance regressions even for plain TCP sockets.

Perhaps the cleanest option could be the one involving the mptcp
refactoring, moving subflow creation at a later stage. It could have
some minor side benefit for MPTCP, too - solving:

https://github.com/multipath-tcp/mptcp_net-next/issues/290

but I'm not fond of that option because it will require quite a bit of
time: we need first to have the mptcp refactor in place and then cook
the lsm patches. I guess such process will require at least 2 release
cycles, due to the needed mptcp(netdev)/lsm trees synchronization.

If that would prove to be the most reasonable option, could we consider
to transiently merge first something alike:

https://lore.kernel.org/mptcp/CAHC9VhSQnhH3UL4gqzu+YiA1Q3YyLLCv88gLJOvw-0+uw5Lvkw@mail.gmail.com/T/#m06c612f84f6b6fe759e670573b2c8092df71607b

to have a workable short-term solution, and later revert it when the
final solution would be in place?

Thanks,

Paolo

