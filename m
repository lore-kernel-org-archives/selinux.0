Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B25C32772
	for <selinux@archiver.kernel.org>; Tue, 23 Aug 2022 17:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiHWRoz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 23 Aug 2022 13:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiHWRoZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 23 Aug 2022 13:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0600EAB406
        for <selinux@vger.kernel.org>; Tue, 23 Aug 2022 08:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661268905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZMKSFewcopxrQz9nX9WYbfep093ndNvGcF1XJmrlWNY=;
        b=MqBIjWerlNTu2m4jBOruXVfbswx+i0GMk6lsPebfTgz8Al6ZJH/In5r2ftKoVCCGQHnPMJ
        TMs95l90nhB5t4C8rU4xCCum+ma2+dCq9WU+aOqEOO/lzjRjzmFNRNyGK2MzIfIwr8NhN/
        sbxbbEv6U4jSiMiFQm6LfufFRU9j6Jw=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-17-x38bn_UxPtqRAFCtitQxDw-1; Tue, 23 Aug 2022 11:35:03 -0400
X-MC-Unique: x38bn_UxPtqRAFCtitQxDw-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-335ff2ef600so246088937b3.18
        for <selinux@vger.kernel.org>; Tue, 23 Aug 2022 08:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZMKSFewcopxrQz9nX9WYbfep093ndNvGcF1XJmrlWNY=;
        b=gsGzRCDubuAyqN++jlyd/n5yC5EqM4R2r19hBlGPXqrKZwmLntZhiOLo8Hve9p94Sy
         i3WGq1eo3O70eJs0jwcB6x2wNODs7IH8eUZmiLQ8B/DV5cEngrVQ/KVVk0XV8JDOdWfc
         9PDQL6VFIPjoxDlR7nylH3gG4/OhHnNfJBSHvL4ALW2aG2+eei55QwV8s5JHiZSqUwAg
         VAHeZs/n8bZg7w3wxI44V1458nWHdYAjT2hPdQr4nuNoKE43yWFnI77J5JST4rKjoGgy
         8wmT8VO0pvSmey9JEsglHD3D+JpxNeHyRwqFUo06V14lA3/CE3WwhwocgA9vAYauugEe
         fodw==
X-Gm-Message-State: ACgBeo0TotkmWXCUDgp9x2crcTNU+8S2kjAinwMi5SlnxCZpw96My5Se
        Nw5lJuM8YUjDge1GwuzEfHjGefPn9KXn9dxESPcI5NN6aZAipHmdmVvkT4nDsnVk4Bn3VhupV4q
        /Jphgxg6ShFVS5z0vdasVhgPCD5D++yqUfA==
X-Received: by 2002:a0d:e252:0:b0:33b:b9e6:a2a5 with SMTP id l79-20020a0de252000000b0033bb9e6a2a5mr11492909ywe.245.1661268902918;
        Tue, 23 Aug 2022 08:35:02 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4QWTN6vl6kyE5wbCCVxpWLnmCZVe6YoyRpB+52JE1oCo72nqLm5eocfGsn7QmiVdm6PNDZaZuvbXQrQICuUlY=
X-Received: by 2002:a0d:e252:0:b0:33b:b9e6:a2a5 with SMTP id
 l79-20020a0de252000000b0033bb9e6a2a5mr11492888ywe.245.1661268902574; Tue, 23
 Aug 2022 08:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <166008317384.447519.7250489605112175227.stgit@olly>
 <CAFqZXNshzY2L1yUMyCxTa2njgScUg5gwzmq-UP4SSnFnph-XuA@mail.gmail.com> <CAHC9VhRpTR_zdj+cdeGGKoe1vZKBy4FK4JP6iyurXR0NOr2tXw@mail.gmail.com>
In-Reply-To: <CAHC9VhRpTR_zdj+cdeGGKoe1vZKBy4FK4JP6iyurXR0NOr2tXw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 23 Aug 2022 17:34:50 +0200
Message-ID: <CAFqZXNsYuxEqtGALvX7kpw4MacV0bzqBDVznGpb4672qRx+-nA@mail.gmail.com>
Subject: Re: [PATCH] selinux: SCTP fixes, including ASCONF
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

(Sorry for the late reply, I was on vacation last week.)

On Thu, Aug 11, 2022 at 5:04 PM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Aug 11, 2022 at 6:03 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Wed, Aug 10, 2022 at 12:14 AM Paul Moore <paul@paul-moore.com> wrote:
> > > This patch makes two changes to how SELinux processes SCTP traffic:
> >
> > Why one patch for two independent changes?
>
> Taken separately the REQSKB change would be somewhat difficult to
> detect as a regular user, putting the two changes into a single patch
> means that one can use the presence of the "sctp_asconf" policy
> capability as an indicator that the REQSKB fix is present in the
> running kernel.

Why would one need to detect it, though? For selinux-testsuite? For
that it will be sufficient if the REQSKB fix is applied before the
ASCONF fix. Anyway, this is bikeshedding and I don't insist on
splitting the patches, just that I don't see an obvious reason so I'd
like to understand why it's being done this way.

> > > @@ -5421,6 +5437,22 @@ static int selinux_sctp_bind_connect(struct sock *sk, int optname,
> > >                          */
> > >                         err = selinux_netlbl_socket_connect_locked(sk, addr);
> > >                         break;
> > > +               /* ASCONF checks (IETF RFC 5061) */
> > > +               case SCTP_PARAM_ADD_IP:
> > > +               case SCTP_PARAM_SET_PRIMARY:
> > > +                       if (pcap_asconf) {
> > > +                               if (peerlbl) {
> > > +                                       err = sock_has_perm_subj(sksec->peer_sid,
> > > +                                               sk, SCTP_SOCKET__ASCONF_ADDIP);
> >
> > How about splitting this into SCTP_SOCKET__ADD_IP_FROM and
> > SCTP_SOCKET__SET_PRIMARY_FROM? "_FROM" to give a hint that the
> > scontext is a peer label as with NODE__RECVFROM ...
>
> I prefer the permission names as they are (without the "_FROM" suffix)
> as they better align with the SCTP RFCs.

I don't see how the suffix is relevant to alignment to RFCs, but
anyway I'm beginning to doubt if the _FROM suffix makes that much
sense... Let's leave it at ASCONF_SOMETHING then. (But see below why I
still think it should be split into two permissions or apply only to
ADD_IP.)

> > ... and split so that one
> > can allow SET_PRIMARY and not ADD_IP, as the former is much less of a
> > security concern than the latter.
>
> I agree that ADD_IP is a much larger concern, arguably really the only
> concern, since you can't set the primary address without first adding
> it to the association.  It may sound odd, but since SET_PRIMARY MUST
> (let's use some of that RFC language here <g>) come after a matching
> ADD_IP,

I don't think that's necessarily true. 5.4 says "A sender MUST only
send a set primary request to an address that is already considered
part of the association." But the addresses in the association don't
all have to come from ASCONF, they can be also populated by the client
itself via CONNECTX. So unless I'm mistaken, it is possible to open a
multi-address association via CONNECTX and then let the remote peer
indicate its preferred primary address via SET_PRIMARY. If (at SELinux
level) I wanted to allow this scenario, but prevent the remote peer
from adding any extra addresses to the association, I wouldn't be able
to do so with this patch.

> I made them equivalent in this patch so that both would be
> covered by the same set of allow rules.  In other words, the policy
> author really only needs to worry about the ADD_IP operation since
> that is the critical parameter/op.  I did debate dropping the
> SET_PRIMARY entirely, but keeping it made the legacy case easier and
> in the peerlbl/TRUE case it still offers some value in the case where
> the SET_PRIMARY is done at a different time from the ADD_IP
> (potentially different network peer labels for each parameter/op).
>
> > Also, using the "ADDIP" name for both is just misleading as
> > SET_PRIMARY doesn't add any address, only switches between the already
> > added ones (and note that these might be added not only via a previous
> > ADD_IP, but also by the client itself via CONNECTX).
>
> Yes, I read the RFC too, but see my comments above.
>
> > > +                                       if (err)
> > > +                                               return err;
> > > +                               }
> > > +                               perm = SCTP_SOCKET__ASCONF_CONNECT;
> >
> > Again, if it was up to me, I'd split the permission up into ADD_IP and
> > SET_PRIMARY. And I'd like to reiterate once more that validating the
> > port seems unnecessary here ...
>
> To touch on the port issue quickly - while part of the motivation was
> to blend better with the existing legacy case, I think there may also
> be value in being able to control different ASCONF policies on a
> port-by-port basis.  For example, maybe you want to allow pretty much
> anything from an ASCONF perspective for the http ports but you want to
> be much more restrictive about ssh.

Hmm, I guess that might be a valid use case indeed... Though I wonder
if we shouldn't keep the "name" part in the permission name. At least
I get the impression that the "name" in  "name_connect" and
"name_bind" means we are checking against a port's label. Sorry if
that's a misunderstanding.

> > > diff --git a/security/selinux/netlabel.c b/security/selinux/netlabel.c
> > > index 1321f15799e2..28d0ead32416 100644
> > > --- a/security/selinux/netlabel.c
> > > +++ b/security/selinux/netlabel.c
> >
> > I believe you forgot to modify also
> > selinux_netlbl_sctp_assoc_request() in a similar fashion as the other
> > functions below?
>
> Good point.  I suspect selinux_netlbl_sctp_assoc_request() will be
> greatly simplified too, that will be nice.
>
> > > @@ -373,10 +373,10 @@ void selinux_netlbl_inet_csk_clone(struct sock *sk, u16 family)
> > >   */
> > >  void selinux_netlbl_sctp_sk_clone(struct sock *sk, struct sock *newsk)
> > >  {
> > > -       struct sk_security_struct *sksec = sk->sk_security;
> > >         struct sk_security_struct *newsksec = newsk->sk_security;
> > >
> > > -       newsksec->nlbl_state = sksec->nlbl_state;
> > > +       /* SCTP is multi-homed so we must label each packet based on dest IP */
> > > +       newsksec->nlbl_state = NLBL_REQSKB;
> > >  }
> > >
> > >  /**
> > > @@ -401,6 +401,17 @@ int selinux_netlbl_socket_post_create(struct sock *sk, u16 family)
> > >         secattr = selinux_netlbl_sock_genattr(sk);
> > >         if (secattr == NULL)
> > >                 return -ENOMEM;
> > > +
> > > +       /* SCTP has the ability to communicate with multiple endpoints for a
> > > +        * given association so we need to force NLBL_REQSKB so that we always
> > > +        * label traffic based on the destination endpoint and not the
> > > +        * association's connection
> > > +        */
> > > +       if (sk->sk_protocol == IPPROTO_SCTP) {
> > > +               sksec->nlbl_state = NLBL_REQSKB;
> > > +               return 0;
> > > +       }
> > > +
> > >         rc = netlbl_sock_setattr(sk, family, secattr);
> > >         switch (rc) {
> > >         case 0:
> > > @@ -548,10 +559,17 @@ static int selinux_netlbl_socket_connect_helper(struct sock *sk,
> > >         struct sk_security_struct *sksec = sk->sk_security;
> > >         struct netlbl_lsm_secattr *secattr;
> > >
> > > -       /* connected sockets are allowed to disconnect when the address family
> > > -        * is set to AF_UNSPEC, if that is what is happening we want to reset
> > > -        * the socket */
> > > -       if (addr->sa_family == AF_UNSPEC) {
> > > +       /* special handling for AF_UNSPEC and IPPROTO_SCTP:
> > > +        * - sockets are allowed to disconnect when the address family
> > > +        *   is set to AF_UNSPEC, if that is what is happening we want to reset
> > > +        *   the socket
> > > +        * - SCTP has the ability to communicate with multiple endpoints for
> > > +        *   a given association so we need to force NLBL_REQSKB so that we
> > > +        *   always label traffic based on the destination endpoint and not
> > > +        *   the association's connection, see similar comment in
> > > +        *   selinux_netlbl_socket_post_create()
> > > +        */
> > > +       if (addr->sa_family == AF_UNSPEC || sk->sk_protocol == IPPROTO_SCTP) {
> > >                 netlbl_sock_delattr(sk);
> > >                 sksec->nlbl_state = NLBL_REQSKB;
> > >                 rc = 0;
> >
> > Instead of overloading the AF_UNSPEC condition, how about just adding:
> >
> > if (sk->sk_protocol == IPPROTO_SCTP)
> >         return 0;
> >
> > ...before this one with a separate comment? Overloading the disconnect
> > condition just makes the code harder to follow.
>
> Heh.  Okay, I see your point, but if that bit of code is too hard to
> follow for someone they are going to have a very rough time with the
> rest of the kernel code ;)
>
> I'm going to leave this as-is.

Well, yes, the kernel contains a lot of ugly code, but that's no
excuse to add more... Yet, this is another bikeshedding that is maybe
worth raising but not worth arguing about, so I'm not going to scratch
it further.

> > Just bailing out in
> > the connect helper should be enough once you also patch up
> > selinux_netlbl_sctp_assoc_request(), since those are the only places
> > that could change an SCTP socket's nlbl_state away from NLBL_REQSKB or
> > set any netlabel options on it (well, except when a user explicitly
> > sets some via setsockopt(2), but in that case we probably shouldn't
> > delete them even on a disconnect...
>
> Just as a FYI, the socket_setsockopt hook prevents a user from
> overwriting an existing NetLabel socket option, and in the REQSKB case
> we either overwrite any socket inherited NetLabel socket options in
> the case of CIPSO or add another hop-by-hop option in the case of
> CALIPSO (it's quicker that way).  We don't explicitly block a user
> form setting a on-the-wire packet label using setsockopt() in the case
> where no labeling is configured in case the application wants to
> manage things on their own, but we do provide a socket-level
> permission check (socket/setopt) so that policy developers can block
> this if they want.

Well, yes, but none of that explains why we call
netlbl_sock_delattr(sk) unconditionally on disconnect. Shouldn't the
whole AF_UNSPEC block be executed only if sksec->nlbl_state ==
NLBL_CONNLABELED? Because of the guard in
selinux_netlbl_socket_connect_locked() the state can be only either
NLBL_CONNLABELED or NLBL_REQSKB here. In the case of NLBL_CONNLABELED,
deleting the NetLabel options is logical, but in the case of
NLBL_REQSKB we would be deleting options set by the user, which
doesn't seem right.

It is a pre-existing bug, but you are trying to exacerbate it even
more by reusing the conditional for SCTP, so perhaps worth addressing
beforehand.

One more side thought: It's weird that currently we will allow setting
the socket options in case of NLBL_REQSKB, but not in the case where
the socket has a NETLBL_NLTYPE_UNLABELED entry. In this case there are
no options set on the socket by NetLabel and it is marked as
NLBL_LABELED, which means that selinux_netlbl_socket_setsockopt() will
reject setting NetLabel options on it.

Oh, and while I'm at it - does anybody know what is the intent behind
the mysterious if-else in selinux_netlbl_inet_csk_clone()?

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

