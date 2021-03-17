Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11044C433DB
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 20:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8FC764F07
	for <selinux@archiver.kernel.org>; Wed, 17 Mar 2021 20:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbhCQURK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbhCQUQj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 17 Mar 2021 16:16:39 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B925C06175F
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 13:16:39 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id hq27so359428ejc.9
        for <selinux@vger.kernel.org>; Wed, 17 Mar 2021 13:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QEOloMvNgoHGwfPYaOtLBZt1tGk9z+wArHjNJYI6x+w=;
        b=UlaIdchIMdvi/d1HMbomidYmolKkRGGG72Ut18zENfsjoTbv1aDeRsouser7JUEzqI
         9lCfZ7qjup3e1vRK9Xu4o1tkavKruWXdMzBIVvgZal+Sm/7RZ+YYYUzbnmauXGdHEywk
         I19g8U3fx1gLO92it6EU+oyJESyO6EXh+KbyjkioJePZ9Kqq/wWEi8iEyX6Igae83hqB
         HZtVJ4mDbZNtS8YUXFkoIdVC8+WhOuUJ6SBduQUGWkIOoA49zXdj4peBD3woqzUj/UbP
         Mspw7LEf+mD+R+O1Nox5CYoU5VBRR5beWYwRY4Mbzdpf8B7qKfNpkuVfYZlEL43hYOrp
         u6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QEOloMvNgoHGwfPYaOtLBZt1tGk9z+wArHjNJYI6x+w=;
        b=Rq0oYv0FVqxPjnDHfhqiI5djcot84iUGsMzLRMCxJZKDY6Ka8kQ/iIsLrx/9Nu07Dy
         RMCBtDA6PaOBbW80dq/GSkAL8csDAXiJ/bH2ZXP0U1XgWbygNI6Qw+pQqm3xbYI5k5Iy
         py2qfAZh80p0thedeNlrbbh/8BeQ/NmTNd+9SerwujdgHaofQ3qokF/ZWevnSPxESh0N
         0+zGZoc4nXMPEk2KseAnxqF+5AcTCmw7/t027yi8WhpVxXbWijf96x73q7xNtPQw2CZQ
         bQIhRwGMiPAFgCsWOZ5SeRnab5w21APVyxdbM5Zw6grA6prPiqp8+vDG7btoODjvLkmq
         80EA==
X-Gm-Message-State: AOAM533SU2zgCjCMi9owUt1zuKD9o01A0KL1CYq2z921UPL67Y6+vubX
        q5Bjc74zfvSMK/LSwUDTW16HGwtHQ6sqr0pT1jAC
X-Google-Smtp-Source: ABdhPJwZ5eSoUqpbSZ2mwR7prPozBZU8LbvUD8YDCFfZ7b2tNkNEe3pbPcW7reGnL8Oxx4SZD9jMOJn1Hk6ZwhQ9R2s=
X-Received: by 2002:a17:906:3ac3:: with SMTP id z3mr37990797ejd.106.1616012197980;
 Wed, 17 Mar 2021 13:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210317154448.1034471-1-dbrazdil@google.com>
In-Reply-To: <20210317154448.1034471-1-dbrazdil@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 17 Mar 2021 16:16:27 -0400
Message-ID: <CAHC9VhT_+i9V9N7NAdCCUgO5xBZpffvVPeh=jK8weZr3WzZ4Bw@mail.gmail.com>
Subject: Re: [PATCH] selinux: vsock: Set SID for socket returned by accept()
To:     David Brazdil <dbrazdil@google.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Mar 17, 2021 at 11:44 AM David Brazdil <dbrazdil@google.com> wrote:
>
> For AF_VSOCK, accept() currently returns sockets that are unlabelled.
> Other socket families derive the child's SID from the SID of the parent
> and the SID of the incoming packet. This is typically done as the
> connected socket is placed in the queue that accept() removes from.
>
> Implement an LSM hook 'vsock_sk_clone' that takes the parent (server)
> and child (connection) struct socks, and assigns the parent SID to the
> child. There is no packet SID in this case.
>
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
> This is my first patch in this part of the kernel so please comment if I
> missed anything, specifically whether there is a packet SID that should
> be mixed into the child SID.
>
> Tested on Android.
>
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/lsm_hooks.h     |  7 +++++++
>  include/linux/security.h      |  5 +++++
>  net/vmw_vsock/af_vsock.c      |  1 +
>  security/security.c           |  5 +++++
>  security/selinux/hooks.c      | 10 ++++++++++
>  6 files changed, 29 insertions(+)

Additional comments below, but I think it would be a good idea for you
to test your patches on a more traditional Linux distribution as well
as Android.

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 5546710d8ac1..a9bf3b90cb2f 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -755,6 +755,7 @@ static struct sock *__vsock_create(struct net *net,
>                 vsk->buffer_size = psk->buffer_size;
>                 vsk->buffer_min_size = psk->buffer_min_size;
>                 vsk->buffer_max_size = psk->buffer_max_size;
> +               security_vsock_sk_clone(parent, sk);

Did you try calling the existing security_sk_clone() hook here?  I
would be curious to hear why it doesn't work in this case.

Feel free to educate me on AF_VSOCK, it's entirely possible I'm
misunderstanding something here :)

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index ddd097790d47..7b92d6f2e0fd 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -5616,6 +5616,15 @@ static int selinux_tun_dev_open(void *security)
>         return 0;
>  }
>
> +static void selinux_socket_vsock_sk_clone(struct sock *sock, struct sock *newsk)
> +{
> +       struct sk_security_struct *sksec_sock = sock->sk_security;
> +       struct sk_security_struct *sksec_new = newsk->sk_security;
> +
> +       /* Always returns 0 when packet SID is SECSID_NULL. */
> +       WARN_ON_ONCE(selinux_conn_sid(sksec_sock->sid, SECSID_NULL, &sksec_new->sid));
> +}

If you are using selinux_conn_sid() with the second argument always
SECSID_NULL it probably isn't the best choice; it ends up doing a
simple "sksec_new->sid = sksec_sock->sid" ... which gets us back to
this function looking like a reimplementation of
selinux_sk_clone_security(), minus the peer_sid and sclass
initializations (which should be important things to have).

I strongly suggest you try making use of the existing
security_sk_clone() hook in the vsock code, it seems like a better way
to solve this problem.

-- 
paul moore
www.paul-moore.com
