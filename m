Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A86C433EF
	for <selinux@archiver.kernel.org>; Tue, 14 Jun 2022 12:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242172AbiFNMwK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jun 2022 08:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiFNMwK (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jun 2022 08:52:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9C913B555
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 05:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655211124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QX5RpwY2pzyb413QSLun7oDEeDrOuNZHvGabyJOuiig=;
        b=COTtFFK02qkHf3kpjdYYlM9KwTFMuf6Sfz7I0p9UN/FLQdZDipSSAyxBa/R8+LwzwFziHx
        8yCJoFu2FFQrskqtz3kejsMj5I3+oGJzrNk/3igv2F57w+iyBdQDEgNFs5Brsj3rASu4zT
        DD+jddHVG0Pi1HJJzhu63wstKfHLHxc=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-ZnjQTHPAMP24T9KAIVe-zA-1; Tue, 14 Jun 2022 08:52:03 -0400
X-MC-Unique: ZnjQTHPAMP24T9KAIVe-zA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-30047b94aa8so24796407b3.1
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 05:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QX5RpwY2pzyb413QSLun7oDEeDrOuNZHvGabyJOuiig=;
        b=BMXMagMu14N9mSEXg6RDoYbx0o9siGhZaOkY1/UmXFgd7VciiTPCidoJOagccgW+We
         iTuFFn9aI7kBccV60mu2F/siB7AAVAFFB1rgMoL2Oc3myw10QndQRU3odN2YF5jswFZD
         H0hf23BjgN8nZVpRV8NnU72p68zIor9wkRBwkNJfwbtNNxzeA3sGIgQ/tPrkupv/fSWA
         CmpvRNC1TVIUqYEYd8HCMzevMRhL7WrUzA5OLBA9dubvHDvpEjvlaAzV5imXHlfuzJWg
         6SFBWy4xOzrkGyYphWeDpjdTloZtO+WggTKVK1RDUcsdAoEPvHGYPiq5CLvLEE9+T3nC
         YaqA==
X-Gm-Message-State: AJIora89sXB1sjcZSElzNzSZYkWy5DBHrR20mdAp5RCbNdHXnbCJquvx
        Ik/8y6e1l+r6pgI2h7puVFz7VcNpuh/r6EAwuy+GxRGVt4N4UR/5hwHpeXVqYjsvf9hrLqbXSuc
        nb77aS78F2OkEza3ReRbQQehHGdrMpZw10A==
X-Received: by 2002:a81:1e50:0:b0:30c:8246:b5a9 with SMTP id e77-20020a811e50000000b0030c8246b5a9mr5416114ywe.12.1655211122155;
        Tue, 14 Jun 2022 05:52:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1thJ6989kyYMj4CPCMlG9wm0gppd3xEi19Dr7KANXrxJsVBI2LVUzlOi5wRavG56Uoa+WG2CuQUR+4I4JtKkIM=
X-Received: by 2002:a81:1e50:0:b0:30c:8246:b5a9 with SMTP id
 e77-20020a811e50000000b0030c8246b5a9mr5416083ywe.12.1655211121783; Tue, 14
 Jun 2022 05:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNsO0HSqP2n3W_Su07LPggUm5_M1tGJBuJDW_VL-pWHOWw@mail.gmail.com>
 <CAHC9VhTqrPeqSFhBKNXvmyf-upN4L73qKSPxBSSRKa+3Ks3oPg@mail.gmail.com>
 <CAHC9VhQ9FG9kFBJrwS2P_cxkGs8frQ0b=Wz+Hu=e6mrnZXi23A@mail.gmail.com>
 <CAFqZXNs49z1z5CE_sb8_fJAOGfFNhOc2PmFY516WOSfcj-2Zfw@mail.gmail.com>
 <CAHC9VhRrQVNwZw6dzAiYJZxwfUwdzN7+3Ki0EEsNNupH6jphRw@mail.gmail.com>
 <CAFqZXNtxnzc_UYfm6Q-UWLf3zK5BNL-Miji2WJDw7Mnu+cU9TA@mail.gmail.com> <CAHC9VhRyJ5d9fZYWFVmNaKGAmZr09Lrcc+5rAXjg38GPAO=erA@mail.gmail.com>
In-Reply-To: <CAHC9VhRyJ5d9fZYWFVmNaKGAmZr09Lrcc+5rAXjg38GPAO=erA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 14 Jun 2022 14:51:50 +0200
Message-ID: <CAFqZXNtnjoLEhxguzfVKNVBAfdMdPH8ct+Zsifun4v1X=YpubQ@mail.gmail.com>
Subject: Re: Bug in SELinux SCTP ASCONF handling
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 7, 2022 at 5:08 PM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, Jun 7, 2022 at 8:28 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Fri, Jun 3, 2022 at 12:45 AM Paul Moore <paul@paul-moore.com> wrote:
> > > On Thu, Jun 2, 2022 at 10:49 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > >
> > > > On Wed, Jun 1, 2022 at 3:32 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > > On Tue, May 31, 2022 at 7:53 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > > On Tue, May 31, 2022 at 1:05 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> ...
>
> > > > > From a quick skim of the SCTP RFCs, the ASCONF chunk is sent from a
> > > > > remote endpoint to update the SCTP parameters so in this case I
> > > > > believe the subject should be the remote peer (the association/sock's
> > > > > peer_secid) and the object should be the local association/socket.
> > > > > It's important to note that any access control checks using the remote
> > > > > peer label should be gated by the selinux_peerlbl_enabled() function,
> > > > > see selinux_socket_sock_rcv_skb() for an example.
> > > >
> > > > I don't like the idea of using peer_secid as the subject for
> > > > socket::connect, which normally has a task sid as the subject.
> > >
> > > While I have concerns about reusing the socket:connect permission for
> > > the ASCONF updates, it isn't because of the peer_secid.  The
> > > peer_secid represents the security label of the remote peer and it is
> > > the subject label for ASCONF operations.
> >
> > It does make sense to use it as a subject label, but not for the
> > connect permission, where the convention is that the subject context
> > is a process context. While we don't have any hard rule against mixing
> > different "kinds" of contexts in the subject/target of a given
> > permission, it makes both figuring out AVC denials and reasoning about
> > policy harder and I want to avoid it wherever possible.
>
> The network peer label is a process label, it is intended to represent
> the security attributes of the remote process.

Hm, indeed, I misunderstood the semantics behind it. Let's disregard
that argument then.

Still, I'd say the situation "a remote process wants to potentially
redirect communication to a different address" is different enough
from "local process intends to initiate a connection to a given
endpoint" that it warrants a special permission.

> However, as I mentioned above, the socket:connect permission is likely
> not the proper permission to use in the ASCONF case.

Perhaps I missed it, but I don't think you actually stated your reason
for a different permission. Is it similar to mine above or something
different?

> > > * We should list out all of the current ASCONF parameter changes and
> > > have a discussion about which ones we want to protect with access
> > > controls, and of those remaining controls which should be grouped (if
> > > any).
> >
> > I agree that we should think this through before making changes. I
> > likely won't have enough time to implement the fixes myself, but at
> > least I will try to provide some food for thought for whoever will
> > attempt to tackle this :)
>
> That's disappointing.  I'll drop what I'm doing and work on this,
> because someone needs to fix this.

Thanks, that's commendable.

> > > > Also we might want to have another check over just the socket context
> > > > to allow/disallow ADD_IP/SET_PRIMARY regardless of the peer so that
> > > > there is some level of control also when peer labeling is disabled.
> > >
> > > Are you talking about something like this: "allow socket_t
> > > self:sctp_socket some_asconf_perm"?  I'd need to hear a good
> > > explanation for this and why we would need this control, because it
> > > doesn't make a lot of sense to me.  If you are allowing an application
> > > to create a SCTP socket, you are granting it permission to make use of
> > > SCTP, including ASCONF.
> >
> > My idea is to provide policy writers/users (particularly those who
> > don't want to enable peer labeling) a simple way to control the usage
> > of ASCONF on the machine (either at global or socket level). ASCONF is
> > quite a niche feature of SCTP and probably won't be used by most
> > applications (and the SCTP RFC mandates that it be used only in
> > conjunction with auth chunks, which is itself another niche feature).
> > Given that ASCONF has security implications, I see it as a natural
> > requirement to be able to allow a domain to use SCTP itself, but not
> > to process ASCONF commands from any peer.
>
> I'll reserve final judgement because I need to go read the ASCONF
> related RFCs instead of just skimming them, but I'm not overly swayed
> by the argument above.  SELinux should be about providing mechanisms
> which allow policy writers to control what entities on a system have
> access to a specific blob of data, restricting the details of the
> protocols which are used to access that data is getting a bit out of
> scope unless those details directly affect the ability to access the
> data.

We also restrict things like capabilities, setsched, etc. that are not
(only) about data.

Let me try a more concrete argument:
Basically, ASCONF allows any attacker who can convince a peer (that
has net.sctp.addip_enable sysctl set) to open an authenticated SCTP
connection with them to get the peer to send a packet to practically
an arbitrary IP address, which can turn into a DDoS attack if you have
many such peers. So a hypothetical administrator who is forced to
enable net.sctp.addip_enable because of one application that relies on
it might want to use SELinux to restrict this ADD_IP capability only
to sockets created by that single application and not the rest of the
SCTP users on the system, thus potentially reducing the attack
surface.

I admit it's an edge case of an edge case, but since we jump through
hoops to have SCTP properly supported in SELinux, we might as well
cover all the bases here.

> I think we should keep the name_connect check, although likely
> with a different name in the ASCONF case, however, that checks the
> socket/sock's label against the connection endpoint's addr/port and is

It only checks it against the port, not the address.

> something different from the network peer labeling controls we've been
> talking about.  Although I believe the ASCONF/name_connect check
> should address the security concerns of an ASCONF induced change
> affecting the endpoint of an SCTP connection and effectively bypassing
> the earlier name_connect check done when the connection was first
> established.

Ok, I didn't think about the name_connect check at first, but looking
closer at what sctp_process_asconf_param() does, I get the impression
that name_connect doesn't really make sense in case of neither ADD_IP
nor SET_PRIMARY, because the port is taken from the association and
not from the ASCONF chunk (i.e. it remains the same). So I don't think
it makes sense to check name_connect in the case of ASCONF, in which
case we are back to the socket-self check being needed.


--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

