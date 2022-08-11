Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF9DC19F2A
	for <selinux@archiver.kernel.org>; Thu, 11 Aug 2022 10:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbiHKKDc (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Aug 2022 06:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKKDb (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Aug 2022 06:03:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 70CDD90C6D
        for <selinux@vger.kernel.org>; Thu, 11 Aug 2022 03:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660212209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uzibDDXnPSoBukMGkdEcL/bq1GIxEEWVuo+hcZrAoCw=;
        b=O19JEv3fmd78nnC8xzxzUtoMv/woGYs1Ew434l74qMdyKEdS72BS8tV4YaXErK1qrO7+cU
        8Z7n0932iGHpE757jeCk7UvDi0w332BoAPrqtVnGAT+op3vhywGHVONZ6WylZEhMeQbtB+
        k7HE3f9dEF4qDs9WhRRvqgv9tmJcMUY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-yCD3fOUtM8m6H2aAwV-J-g-1; Thu, 11 Aug 2022 06:03:28 -0400
X-MC-Unique: yCD3fOUtM8m6H2aAwV-J-g-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-329dc6c0d21so77695487b3.16
        for <selinux@vger.kernel.org>; Thu, 11 Aug 2022 03:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=uzibDDXnPSoBukMGkdEcL/bq1GIxEEWVuo+hcZrAoCw=;
        b=Ulk8xt7696JtG3EIcrXRfYAvYMpbIAy3n1hzwi+yX8E54uSChY6NU3u3F0PWujulb9
         ErNPYbJu7SbGeFuV18c/KewkRCvYWxWlpIl1FMRFuG98w/WDLCil2dBrIcL9fgR7D7VJ
         N3LOg2UI5KxQCnS7bcEARODDcQHaxNjaoMqCOzkHrgDNhZHe2uDXsyEc16h5Q3RhWUs2
         alQqLXpgkLezvkFdEVslmc9fkqmXEwxi9mq44xB1PSZ2oRB9Pe4jVNyulPstQjE/chR8
         9kgnUlid/y8fKxJBd0bEEKzN550Q/xayCHHJCACeo7TsxveCs+uAwbaIYrAGpvA+kFUp
         WbrA==
X-Gm-Message-State: ACgBeo1g3GlDiAqlLLkvRl7vZX+W9epaiCcSEymzLQgTa3xqhOiKHBL1
        my/ngvrIER9ctRegipodAaN4ZX7gukUOVtJW5EMjDh5D5MIs9Sf7SrKYr+TgPQI0zsiusyhgEEs
        NblTGRO5JKf/O2h+F43yP+oUxc0GeP4wSLQ==
X-Received: by 2002:a81:5d07:0:b0:329:8fb8:779 with SMTP id r7-20020a815d07000000b003298fb80779mr23186778ywb.77.1660212207516;
        Thu, 11 Aug 2022 03:03:27 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7RJn6xqiUP/jyDaOxFaEja0MyoDLoPFxKpznUB66rqa9wCxeYFeiKy0vDlmuuwicubbTgtN0+gQGtuFMbU5Hw=
X-Received: by 2002:a81:5d07:0:b0:329:8fb8:779 with SMTP id
 r7-20020a815d07000000b003298fb80779mr23186754ywb.77.1660212207194; Thu, 11
 Aug 2022 03:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <166008317384.447519.7250489605112175227.stgit@olly>
In-Reply-To: <166008317384.447519.7250489605112175227.stgit@olly>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 11 Aug 2022 12:03:15 +0200
Message-ID: <CAFqZXNshzY2L1yUMyCxTa2njgScUg5gwzmq-UP4SSnFnph-XuA@mail.gmail.com>
Subject: Re: [PATCH] selinux: SCTP fixes, including ASCONF
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Aug 10, 2022 at 12:14 AM Paul Moore <paul@paul-moore.com> wrote:
> This patch makes two changes to how SELinux processes SCTP traffic:

Why one patch for two independent changes?

>
> * Considering the multi-homed nature of SCTP, all SCTP traffic is
>   marked as NLBL_REQSKB from a NetLabel perspective so that
>   traffic is labeled on a per-packet basis using the destination IP,
>   and not the on-the-wire label cached at the socket layer.
>
> * New permissions have been added to the "sctp_socket" object class:
>   sctp_socket/{asconf_addip, asconf_connect}.  These new permissions
>   are gated by the "sctp_asconf" SELinux policy capability, and
>   control the ability of ASCONF to add a new IP address to an
>   association and set the primary IP of the association.  The ASCONF
>   access control points now work like the examples below; <socket> is
>   the local socket's label, <port> is the label of the network port,
>   and <peer> is the network peer label (dependent on the labeled
>   networking configuration).
>
>   - legacy policy (no sctp_asconf)
>
>     allow <socket> <port>:sctp_socket { name_connect };
>
>   - updated policy without labeled networking (enabled sctp_asconf)
>
>     allow <socket> <port>:sctp_socket { asconf_connect };
>
>   - updated policy with labeled networking (enabled sctp_asconf)
>
>     allow <peer> <socket>:sctp_socket { asconf_addip };
>     allow <socket> <port>:sctp_socket { asconf_connect };
>
> Cc: stable@vger.kernel.org
> Fixes: d452930fd3b9 ("selinux: Add SCTP support")
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/hooks.c                   |   86 +++++++++++++++++++---------
>  security/selinux/include/classmap.h        |    3 +
>  security/selinux/include/netlabel.h        |    1
>  security/selinux/include/policycap.h       |    1
>  security/selinux/include/policycap_names.h |    3 +
>  security/selinux/include/security.h        |    7 ++
>  security/selinux/netlabel.c                |   30 ++++++++--
>  7 files changed, 95 insertions(+), 36 deletions(-)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 1bbd53321d13..02751a66c5d8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c

<snip>

> @@ -5421,6 +5437,22 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
>                          */
>                         err = selinux_netlbl_socket_connect_locked(sk, addr);
>                         break;
> +               /* ASCONF checks (IETF RFC 5061) */
> +               case SCTP_PARAM_ADD_IP:
> +               case SCTP_PARAM_SET_PRIMARY:
> +                       if (pcap_asconf) {
> +                               if (peerlbl) {
> +                                       err = sock_has_perm_subj(sksec->peer_sid,
> +                                               sk, SCTP_SOCKET__ASCONF_ADDIP);

How about splitting this into SCTP_SOCKET__ADD_IP_FROM and
SCTP_SOCKET__SET_PRIMARY_FROM? "_FROM" to give a hint that the
scontext is a peer label as with NODE__RECVFROM; and split so that one
can allow SET_PRIMARY and not ADD_IP, as the former is much less of a
security concern than the latter. For example, the client could first
do connectx() with multiple addresses controlled by itself and then it
might be desirable to allow the remote peer to switch between them via
SET_PRIMARY, yet keep ADD_IP (which can actually modify the address
list) disallowed.

Also, using the "ADDIP" name for both is just misleading as
SET_PRIMARY doesn't add any address, only switches between the already
added ones (and note that these might be added not only via a previous
ADD_IP, but also by the client itself via CONNECTX).

> +                                       if (err)
> +                                               return err;
> +                               }
> +                               perm = SCTP_SOCKET__ASCONF_CONNECT;

Again, if it was up to me, I'd split the permission up into ADD_IP and
SET_PRIMARY. And I'd like to reiterate once more that validating the
port seems unnecessary here, since only the address can be changed via
ASCONF, the port is the same for the whole association (just look at
the definition of struct sctp_association for an indirect proof). If
you insist on the name_connect semantics regardless, let's at least
name the permissions "add_ip_name_connect" and
"set_primary_name_connect" so that it's clear that the tcontext is a
port context; otherwise they can be simply:

    allow <socket> self:sctp_socket { add_ip set_primary };

(Possibly all with the "asconf_" prefix for more clarity, but IMHO
it's not necessary.)

> +                       } else
> +                               perm = SCTP_SOCKET__NAME_CONNECT;
> +                       err = selinux_socket_connect_helper(sock, perm,
> +                                                           addr, len);
> +                       break;
>                 }
>
>                 if (err)

<snip>

> diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> index 1321f15799e2..28d0ead32416 100644
> --- a/security/selinux/netlabel.c
> +++ b/security/selinux/netlabel.c

I believe you forgot to modify also
selinux_netlbl_sctp_assoc_request() in a similar fashion as the other
functions below?

> @@ -373,10 +373,10 @@ void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
>   */
>  void selinux_netlbl_sctp_sk_clone(struct sock *sk, struct sock *newsk)
>  {
> -       struct sk_security_struct *sksec = sk->sk_security;
>         struct sk_security_struct *newsksec = newsk->sk_security;
>
> -       newsksec->nlbl_state = sksec->nlbl_state;
> +       /* SCTP is multi-homed so we must label each packet based on dest IP */
> +       newsksec->nlbl_state = NLBL_REQSKB;
>  }
>
>  /**
> @@ -401,6 +401,17 @@ int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
>         secattr = selinux_netlbl_sock_genattr(sk);
>         if (secattr == NULL)
>                 return -ENOMEM;
> +
> +       /* SCTP has the ability to communicate with multiple endpoints for a
> +        * given association so we need to force NLBL_REQSKB so that we always
> +        * label traffic based on the destination endpoint and not the
> +        * association's connection
> +        */
> +       if (sk->sk_protocol == IPPROTO_SCTP) {
> +               sksec->nlbl_state = NLBL_REQSKB;
> +               return 0;
> +       }
> +
>         rc = netlbl_sock_setattr(sk, family, secattr);
>         switch (rc) {
>         case 0:
> @@ -548,10 +559,17 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
>         struct sk_security_struct *sksec = sk->sk_security;
>         struct netlbl_lsm_secattr *secattr;
>
> -       /* connected sockets are allowed to disconnect when the address family
> -        * is set to AF_UNSPEC, if that is what is happening we want to reset
> -        * the socket */
> -       if (addr->sa_family == AF_UNSPEC) {
> +       /* special handling for AF_UNSPEC and IPPROTO_SCTP:
> +        * - sockets are allowed to disconnect when the address family
> +        *   is set to AF_UNSPEC, if that is what is happening we want to reset
> +        *   the socket
> +        * - SCTP has the ability to communicate with multiple endpoints for
> +        *   a given association so we need to force NLBL_REQSKB so that we
> +        *   always label traffic based on the destination endpoint and not
> +        *   the association's connection, see similar comment in
> +        *   selinux_netlbl_socket_post_create()
> +        */
> +       if (addr->sa_family == AF_UNSPEC || sk->sk_protocol == IPPROTO_SCTP) {
>                 netlbl_sock_delattr(sk);
>                 sksec->nlbl_state = NLBL_REQSKB;
>                 rc = 0;

Instead of overloading the AF_UNSPEC condition, how about just adding:

if (sk->sk_protocol == IPPROTO_SCTP)
        return 0;

...before this one with a separate comment? Overloading the disconnect
condition just makes the code harder to follow. Just bailing out in
the connect helper should be enough once you also patch up
selinux_netlbl_sctp_assoc_request(), since those are the only places
that could change an SCTP socket's nlbl_state away from NLBL_REQSKB or
set any netlabel options on it (well, except when a user explicitly
sets some via setsockopt(2), but in that case we probably shouldn't
delete them even on a disconnect... it's corner-case bugs all the way
down...).

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

