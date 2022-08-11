Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A46FBC19F2A
	for <selinux@archiver.kernel.org>; Thu, 11 Aug 2022 15:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiHKPEl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 11 Aug 2022 11:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbiHKPEk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 11 Aug 2022 11:04:40 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22870422E4
        for <selinux@vger.kernel.org>; Thu, 11 Aug 2022 08:04:36 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id n16-20020a4a9550000000b0043568f1343bso3153701ooi.3
        for <selinux@vger.kernel.org>; Thu, 11 Aug 2022 08:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=VN6mfTUn9SW8CJ1h86IqaLlyHP5dspsHetg3Tb071cM=;
        b=6P5iWw4PzyoFfL45+KOLW8Ss5aYHs8SMhZV0D73ATjK9nLtSDG9ZZozfHRJzm9eC4q
         LdOV2oNrvmIPktUHV10yXs+URcJhKRZk+aWDWYD6lBXVHWG3fA9NIUOO0UyOzOCJAJ7t
         /e94+n+4sfsXS/vJErag1O8B7szbzfWUHannGys2IgidPiIvBMYWLNGRr/a+4ExKODLQ
         CoTiJaA/R60oq+UoJcKgkzB1cM9IZsUJyspXsQNzQKCt3IKGMak9Vz9YdbZby4yhBV3Y
         zFFsoKGZuUql/RDBrm1zxtd+hSQkL3gIa7StG1fnQeHRnON5RjE0a00/jL0+/UOSiQ4u
         LPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VN6mfTUn9SW8CJ1h86IqaLlyHP5dspsHetg3Tb071cM=;
        b=Y84xJXSRefxvjqnQ5HB9LmRHoo0vdmgbboHK/PxbC8c88EomYgbn6T6ne2B1CD61y4
         tK8E7vcmtHupMOkP+XOloHd0QqFTsU1ZBv9x02pEIeEuFX1zoXhyDPt/h/w56NMiQoGs
         D99DYtwLYLXVdhLBOur0tEXZRZkdRJZnKxTQ7CxZgL6vi6RgCDC2geTPClMhHnh4HK3Z
         oEsGAtBMqSqIbayQJ36Fdm+K3kHzPeou1zIpMtw2/mtpaGsz8UEvw4q+HZ2UwLDWvOCF
         oBfiWZVZtF4TM1Hf0Sm3njT2vVnQT3teJw8m/7CbH145K9SgeINaTtFDUtLXIMiz2FP5
         EmOw==
X-Gm-Message-State: ACgBeo21qRzUQ9flZrVAsQnyCYHz45vQl+i4wB3Tk0PJAiT3KGj0fBuI
        60SmiPwcNqEljC9g3QVHOGTKbPKGQPMs6Jit7lIS
X-Google-Smtp-Source: AA6agR75lkh5V530HmRN5pfuLZisNc78n+bvScVcYrIYPmCJyMBAT8F0+9P1x1pecdBskN8vcqQQLRpSvjC0qliR56k=
X-Received: by 2002:a4a:1103:0:b0:435:4c6c:6f92 with SMTP id
 3-20020a4a1103000000b004354c6c6f92mr11218157ooc.26.1660230275194; Thu, 11 Aug
 2022 08:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <166008317384.447519.7250489605112175227.stgit@olly> <CAFqZXNshzY2L1yUMyCxTa2njgScUg5gwzmq-UP4SSnFnph-XuA@mail.gmail.com>
In-Reply-To: <CAFqZXNshzY2L1yUMyCxTa2njgScUg5gwzmq-UP4SSnFnph-XuA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 11 Aug 2022 11:04:16 -0400
Message-ID: <CAHC9VhRpTR_zdj+cdeGGKoe1vZKBy4FK4JP6iyurXR0NOr2tXw@mail.gmail.com>
Subject: Re: [PATCH] selinux: SCTP fixes, including ASCONF
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 11, 2022 at 6:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Aug 10, 2022 at 12:14 AM Paul Moore <paul@paul-moore.com> wrote:
> > This patch makes two changes to how SELinux processes SCTP traffic:
>
> Why one patch for two independent changes?

Taken separately the REQSKB change would be somewhat difficult to
detect as a regular user, putting the two changes into a single patch
means that one can use the presence of the "sctp_asconf" policy
capability as an indicator that the REQSKB fix is present in the
running kernel.

> > @@ -5421,6 +5437,22 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
> >                          */
> >                         err = selinux_netlbl_socket_connect_locked(sk, addr);
> >                         break;
> > +               /* ASCONF checks (IETF RFC 5061) */
> > +               case SCTP_PARAM_ADD_IP:
> > +               case SCTP_PARAM_SET_PRIMARY:
> > +                       if (pcap_asconf) {
> > +                               if (peerlbl) {
> > +                                       err = sock_has_perm_subj(sksec->peer_sid,
> > +                                               sk, SCTP_SOCKET__ASCONF_ADDIP);
>
> How about splitting this into SCTP_SOCKET__ADD_IP_FROM and
> SCTP_SOCKET__SET_PRIMARY_FROM? "_FROM" to give a hint that the
> scontext is a peer label as with NODE__RECVFROM ...

I prefer the permission names as they are (without the "_FROM" suffix)
as they better align with the SCTP RFCs.

> ... and split so that one
> can allow SET_PRIMARY and not ADD_IP, as the former is much less of a
> security concern than the latter.

I agree that ADD_IP is a much larger concern, arguably really the only
concern, since you can't set the primary address without first adding
it to the association.  It may sound odd, but since SET_PRIMARY MUST
(let's use some of that RFC language here <g>) come after a matching
ADD_IP, I made them equivalent in this patch so that both would be
covered by the same set of allow rules.  In other words, the policy
author really only needs to worry about the ADD_IP operation since
that is the critical parameter/op.  I did debate dropping the
SET_PRIMARY entirely, but keeping it made the legacy case easier and
in the peerlbl/TRUE case it still offers some value in the case where
the SET_PRIMARY is done at a different time from the ADD_IP
(potentially different network peer labels for each parameter/op).

> Also, using the "ADDIP" name for both is just misleading as
> SET_PRIMARY doesn't add any address, only switches between the already
> added ones (and note that these might be added not only via a previous
> ADD_IP, but also by the client itself via CONNECTX).

Yes, I read the RFC too, but see my comments above.

> > +                                       if (err)
> > +                                               return err;
> > +                               }
> > +                               perm = SCTP_SOCKET__ASCONF_CONNECT;
>
> Again, if it was up to me, I'd split the permission up into ADD_IP and
> SET_PRIMARY. And I'd like to reiterate once more that validating the
> port seems unnecessary here ...

To touch on the port issue quickly - while part of the motivation was
to blend better with the existing legacy case, I think there may also
be value in being able to control different ASCONF policies on a
port-by-port basis.  For example, maybe you want to allow pretty much
anything from an ASCONF perspective for the http ports but you want to
be much more restrictive about ssh.

> > diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> > index 1321f15799e2..28d0ead32416 100644
> > --- a/security/selinux/netlabel.c
> > +++ b/security/selinux/netlabel.c
>
> I believe you forgot to modify also
> selinux_netlbl_sctp_assoc_request() in a similar fashion as the other
> functions below?

Good point.  I suspect selinux_netlbl_sctp_assoc_request() will be
greatly simplified too, that will be nice.

> > @@ -373,10 +373,10 @@ void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
> >   */
> >  void selinux_netlbl_sctp_sk_clone(struct sock *sk, struct sock *newsk)
> >  {
> > -       struct sk_security_struct *sksec = sk->sk_security;
> >         struct sk_security_struct *newsksec = newsk->sk_security;
> >
> > -       newsksec->nlbl_state = sksec->nlbl_state;
> > +       /* SCTP is multi-homed so we must label each packet based on dest IP */
> > +       newsksec->nlbl_state = NLBL_REQSKB;
> >  }
> >
> >  /**
> > @@ -401,6 +401,17 @@ int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
> >         secattr = selinux_netlbl_sock_genattr(sk);
> >         if (secattr == NULL)
> >                 return -ENOMEM;
> > +
> > +       /* SCTP has the ability to communicate with multiple endpoints for a
> > +        * given association so we need to force NLBL_REQSKB so that we always
> > +        * label traffic based on the destination endpoint and not the
> > +        * association's connection
> > +        */
> > +       if (sk->sk_protocol == IPPROTO_SCTP) {
> > +               sksec->nlbl_state = NLBL_REQSKB;
> > +               return 0;
> > +       }
> > +
> >         rc = netlbl_sock_setattr(sk, family, secattr);
> >         switch (rc) {
> >         case 0:
> > @@ -548,10 +559,17 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
> >         struct sk_security_struct *sksec = sk->sk_security;
> >         struct netlbl_lsm_secattr *secattr;
> >
> > -       /* connected sockets are allowed to disconnect when the address family
> > -        * is set to AF_UNSPEC, if that is what is happening we want to reset
> > -        * the socket */
> > -       if (addr->sa_family == AF_UNSPEC) {
> > +       /* special handling for AF_UNSPEC and IPPROTO_SCTP:
> > +        * - sockets are allowed to disconnect when the address family
> > +        *   is set to AF_UNSPEC, if that is what is happening we want to reset
> > +        *   the socket
> > +        * - SCTP has the ability to communicate with multiple endpoints for
> > +        *   a given association so we need to force NLBL_REQSKB so that we
> > +        *   always label traffic based on the destination endpoint and not
> > +        *   the association's connection, see similar comment in
> > +        *   selinux_netlbl_socket_post_create()
> > +        */
> > +       if (addr->sa_family == AF_UNSPEC || sk->sk_protocol == IPPROTO_SCTP) {
> >                 netlbl_sock_delattr(sk);
> >                 sksec->nlbl_state = NLBL_REQSKB;
> >                 rc = 0;
>
> Instead of overloading the AF_UNSPEC condition, how about just adding:
>
> if (sk->sk_protocol == IPPROTO_SCTP)
>         return 0;
>
> ...before this one with a separate comment? Overloading the disconnect
> condition just makes the code harder to follow.

Heh.  Okay, I see your point, but if that bit of code is too hard to
follow for someone they are going to have a very rough time with the
rest of the kernel code ;)

I'm going to leave this as-is.

> Just bailing out in
> the connect helper should be enough once you also patch up
> selinux_netlbl_sctp_assoc_request(), since those are the only places
> that could change an SCTP socket's nlbl_state away from NLBL_REQSKB or
> set any netlabel options on it (well, except when a user explicitly
> sets some via setsockopt(2), but in that case we probably shouldn't
> delete them even on a disconnect...

Just as a FYI, the socket_setsockopt hook prevents a user from
overwriting an existing NetLabel socket option, and in the REQSKB case
we either overwrite any socket inherited NetLabel socket options in
the case of CIPSO or add another hop-by-hop option in the case of
CALIPSO (it's quicker that way).  We don't explicitly block a user
form setting a on-the-wire packet label using setsockopt() in the case
where no labeling is configured in case the application wants to
manage things on their own, but we do provide a socket-level
permission check (socket/setopt) so that policy developers can block
this if they want.

-- 
paul-moore.com
