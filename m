Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5764EC4167B
	for <selinux@archiver.kernel.org>; Fri,  2 Dec 2022 12:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbiLBMIp (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 2 Dec 2022 07:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbiLBMIg (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 2 Dec 2022 07:08:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B000C2D3A
        for <selinux@vger.kernel.org>; Fri,  2 Dec 2022 04:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669982850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vwl3SRXcY/J3CPdRHyPEdCs4hfziWlt8l7koAv7MvvA=;
        b=JUdOofM4K8RE754q+JNJzGkLdOh726xvTWB0htfORWOro1TaHOYREBAJcb91G4GZwLLqEz
        6bYNYWviBTrBJTU5uBwTxrqHFIsbTO3ulLO2kZt5oXYtQ6LvjVFfrJiOHqjBbsodsjyhf+
        /RiR1y0EWRHftIsxasfTNoL6AUeaSLQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-635-yxhBHgCVMs2h9Zi8-XV78g-1; Fri, 02 Dec 2022 07:07:29 -0500
X-MC-Unique: yxhBHgCVMs2h9Zi8-XV78g-1
Received: by mail-wm1-f71.google.com with SMTP id u9-20020a05600c00c900b003cfb12839d6so1833151wmm.5
        for <selinux@vger.kernel.org>; Fri, 02 Dec 2022 04:07:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vwl3SRXcY/J3CPdRHyPEdCs4hfziWlt8l7koAv7MvvA=;
        b=ZZ3hGNR7YajbWNTXrLDc/8Yz3zORlBWLRAuVOmeeQQnhBg5xLudDQvvDcmfF0WuGdM
         WRbMktwPCo6pgRmJXSrcv/f1m+xyXL+kTa33FpJZPHbrk8zQKUNEQIitzaQsgjcbylfD
         n3HZChpCcKqqrn8UgYq2ylvGShXcW0e5R6/vlT+6j30VNDkFsbc2ePRvW3Jqi8XonnyZ
         kgQ1xTtZz+KVN/KkA2lM5AbJbujkjwI1j/l4Z/mwIoQD18N4VYxpwRqZ0A0tNaaXZyM+
         NvwlkH3MYjGWDx9IrvOZ+a1qeZqDkChi9jiBUlglAUWlMPIRRI1W+4uBcDgDVJndqk+T
         7p9w==
X-Gm-Message-State: ANoB5pk8bnyHSBoEq297WXfc+VGvoy2DVR7w2oohgkgPVQ6dq8aRAR5x
        QxnTZ8dJ1Zu1um8LtksU3RksePexw9fSPcKd8aWw+9FvHG4cuJ9+ZNatqKehwpf5Cw9EOx5s6pt
        eIEjmBi5ZrZjrrQ3OXQ==
X-Received: by 2002:adf:e84c:0:b0:242:2e28:5b32 with SMTP id d12-20020adfe84c000000b002422e285b32mr7356333wrn.195.1669982847999;
        Fri, 02 Dec 2022 04:07:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6soW9/Mf3v5zQJQbs4Rg8kdcYGA8sosVl2s4EAAyIqWnvJJbBsBUSI+HiCEbDcW/IBavVHow==
X-Received: by 2002:adf:e84c:0:b0:242:2e28:5b32 with SMTP id d12-20020adfe84c000000b002422e285b32mr7356307wrn.195.1669982847665;
        Fri, 02 Dec 2022 04:07:27 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-120-203.dyn.eolo.it. [146.241.120.203])
        by smtp.gmail.com with ESMTPSA id v128-20020a1cac86000000b003cfa80443a0sm8330565wme.35.2022.12.02.04.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 04:07:27 -0800 (PST)
Message-ID: <48dd1e9b21597c46e4767290e5892c01850a45ff.camel@redhat.com>
Subject: Re: Broken SELinux/LSM labeling with MPTCP and accept(2)
From:   Paolo Abeni <pabeni@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Linux Security Module list 
        <linux-security-module@vger.kernel.org>, mptcp@lists.linux.dev,
        network dev <netdev@vger.kernel.org>,
        Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Fri, 02 Dec 2022 13:07:25 +0100
In-Reply-To: <CAHC9VhSSKN5kh9Kqgj=aCeA92bX1mJm1v4_PnRgua86OHUwE3w@mail.gmail.com>
References: <CAFqZXNs2LF-OoQBUiiSEyranJUXkPLcCfBkMkwFeM6qEwMKCTw@mail.gmail.com>
         <108a1c80eed41516f85ebb264d0f46f95e86f754.camel@redhat.com>
         <CAHC9VhSSKN5kh9Kqgj=aCeA92bX1mJm1v4_PnRgua86OHUwE3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, 2022-12-01 at 21:06 -0500, Paul Moore wrote:
> > > Any ideas, suggestions, or patches welcome!
> > 
> > I think something alike the following could work - not even tested,
> > with comments on bold assumptions.
> > 
> > I'll try to do some testing later.
> > 
> > ---
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 99f5e51d5ca4..6cad50c6fd24 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -102,6 +102,20 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
> >         if (err)
> >                 return err;
> > 
> > +       /* The first subflow can later be indirectly exposed to security
> > +        * relevant syscall alike accept() and bind(), and at this point
> > +        * carries a 'kern' related security context.
> > +        * Reset the security context to the relevant user-space one.
> > +        * Note that the following assumes security_socket_post_create()
> > +        * being idempotent
> > +        */
> > +       err = security_socket_post_create(ssock, sk->sk_family, SOCK_STREAM,
> > +                                         IPPROTO_TCP, 0);
> > +       if (err) {
> > +               sock_release(ssock);
> > +               return err;
> > +       }
> 
> I'm not sure we want to start calling security_socket_post_create()
> twice on a given socket, *maybe* it works okay now but that seems like
> an awkward constraint to put on future LSMs (or changes to existing
> ones). If we decide that the best approach is to add a LSM hook call
> here, we should create a new hook instead of reusing an existing one;
> I think this falls under Ondrej's possible solution #2.

I agree the above code is not very nice and an additional selinux hook
would be much cleaner. I tried the above path as a possible quick
fixup. AFAICS all the existing selinux modules implement the
socket_post_create() hook in such a way that calling it on an already
initialized socket yeld to the desidered result.

I agree putting additional, currently non exiting, constraint on
existing hooks is definitelly not nice. 
> 
> However, I think this simplest solution might be what I mentioned
> above as #2a, simply labeling the subflow socket properly from the
> beginning.  In the case of SELinux I think we could do that by simply
> clearing the @kern flag in the case of IPPROTO_MPTCP; completely
> untested (and likely whitespace mangled) hack shown below:
> 
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index f553c370397e..de6aa80b2319 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4562,6 +4562,7 @@ static int selinux_socket_create(int family, int type,
>        u16 secclass;
>        int rc;
> 
> +       kern = (protocol == IPPROTO_MPTCP ? 0 : kern);
>        if (kern)
>                return 0;
> 
> @@ -4584,6 +4585,7 @@ static int selinux_socket_post_create(struct
> socket *sock, int family,
>        u32 sid = SECINITSID_KERNEL;
>        int err = 0;
> 
> +       kern = (protocol == IPPROTO_MPTCP ? 0 : kern);
>        if (!kern) {
>                err = socket_sockcreate_sid(tsec, sclass, &sid);
>                if (err)
> 
> ... of course the downside is that this is not a general cross-LSM
> solution, but those are very hard, if not impossible, to create as the
> individual LSMs can vary tremendously.  There is also the downside of
> having to have a protocol specific hack in the LSM socket creation
> hooks, which is a bit of a bummer, but then again we already have to
> do so much worse elsewhere in the LSM networking hooks that this is
> far from the worst thing we've had to do.

There is a problem with the above: the relevant/affected socket is an
MPTCP subflow, which is actually a TCP socket (protocol ==
IPPROTO_TCP). Yep, MPTCP is quite a mes... complex.

I think we can't follow this later path.

If even the initially proposed hack is a no-go, another option could
possibly be the following - that is: do not touch the subflows, and try
to initilize the accepted msk context correctly.

Note that the relevant context does not held the 'sk' socket lock, nor
it could acquire it, but at least 'sk' can't be freed under the hood
and there are exiting places e.g. the unix socket accept() where
security_sock_graft() is invoked with similar (lack of) locking.

Side note: I'm confused by the selinux_sock_graft() implementation:

https://elixir.bootlin.com/linux/v6.1-rc7/source/security/selinux/hooks.c#L5243

it looks like the 'sid' is copied from the 'child' socket into the
'parent', while the sclass from the 'parent' into the 'child'. Am I
misreading it? is that intended? I would have expeted both 'sid' and
'sclass' being copied from the parent into the child. Other LSM's
sock_graft() initilize the child and leave alone the parent.

---
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 99f5e51d5ca4..b8095b8df71d 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3085,7 +3085,10 @@ struct sock *mptcp_sk_clone(const struct sock *sk,
 	/* will be fully established after successful MPC subflow creation */
 	inet_sk_state_store(nsk, TCP_SYN_RECV);
 
-	security_inet_csk_clone(nsk, req);
+	/* let's the new socket inherit the security label from the msk
+	 * listener, as the TCP reqest socket carries a kernel context
+	 */
+	security_sock_graft(nsk, sk->sk_socket);
 	bh_unlock_sock(nsk);
 
 	/* keep a single reference */


