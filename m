Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4202FC433EF
	for <selinux@archiver.kernel.org>; Tue,  7 Jun 2022 12:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiFGM2R (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jun 2022 08:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiFGM2Q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jun 2022 08:28:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7F98E5C85D
        for <selinux@vger.kernel.org>; Tue,  7 Jun 2022 05:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654604892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5i/S8CcSV1tJZQ1wWESI2ZPAhnwghpHzVc8QzMciwWk=;
        b=OdqgqjaeenVkMiHQB7cfgm2c8Z4Rv5c+M9lGYLsbE2lyM9VgvwlNLrX/rgo3dh6GcscKL+
        +cs+296nXYHDhRWqgj39ghbrcX36sUJAMzdZWNl0mNEnhQBWsZDLn+/MH1c45NV6BcPcz+
        kP0iC8X9s5VCRopwNLDY9hns+3tAAHE=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-m1yGsvtoOKastmUr2WwhyA-1; Tue, 07 Jun 2022 08:28:11 -0400
X-MC-Unique: m1yGsvtoOKastmUr2WwhyA-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-2dc7bdd666fso146517967b3.7
        for <selinux@vger.kernel.org>; Tue, 07 Jun 2022 05:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5i/S8CcSV1tJZQ1wWESI2ZPAhnwghpHzVc8QzMciwWk=;
        b=fewRo4a24zeqcC4DGv4yP/TdsiS/ryYXMR3PioOGP4aKozZk5PFYrespwqxlJ72Ggj
         9ryemV9RcMpY7LNgGMdp9dCi2zmYe2CWG2qEaOcyf56tvHsDSK+McqC1eZyG/8oBSNAr
         zbCNLTioU0BsVSBRFDTsT/YNL5IF2SFHwWcQFbm0omVrc4A1LvhT76wW7NWVEdTI5ieC
         Da1zoT75/Yz1LzuMfh1x9ceskPt1oY3Vc1dXBc9faAEvFGRjBJN4RgvDfdsfaYm1DITY
         Xy/GZTwix4FlYUtxP/OIUVjfxvdhotMf+xtOipPPiUvLWVtwjpqxF0tugim/OPL1Ys8p
         eGbQ==
X-Gm-Message-State: AOAM5339szHrUf63JfSbkOR8aMSCgWN7qcMNib4h1ilw5lgATEkv7Pdy
        iW1gjvxCncJ3F9wqYZErHyCq9wAet3S6WJLq6Ga4H43R6VT7vF240Hxhp4I/pB5eRvpEdcAp5ec
        SwspTyfm/542QHRJJ/C1n5hENI1k+xvf26A==
X-Received: by 2002:a81:848c:0:b0:30c:4684:3b6 with SMTP id u134-20020a81848c000000b0030c468403b6mr31133760ywf.77.1654604890994;
        Tue, 07 Jun 2022 05:28:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYfkqpIwUIvHo2q2BRN99lJH1RGJL5KFWzun8wDcV+LkvV2GHLwkfxkx7HsflLzeu5HdEALEtnLmGF5d1uNI4=
X-Received: by 2002:a81:848c:0:b0:30c:4684:3b6 with SMTP id
 u134-20020a81848c000000b0030c468403b6mr31133733ywf.77.1654604890694; Tue, 07
 Jun 2022 05:28:10 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNsO0HSqP2n3W_Su07LPggUm5_M1tGJBuJDW_VL-pWHOWw@mail.gmail.com>
 <CAHC9VhTqrPeqSFhBKNXvmyf-upN4L73qKSPxBSSRKa+3Ks3oPg@mail.gmail.com>
 <CAHC9VhQ9FG9kFBJrwS2P_cxkGs8frQ0b=Wz+Hu=e6mrnZXi23A@mail.gmail.com>
 <CAFqZXNs49z1z5CE_sb8_fJAOGfFNhOc2PmFY516WOSfcj-2Zfw@mail.gmail.com> <CAHC9VhRrQVNwZw6dzAiYJZxwfUwdzN7+3Ki0EEsNNupH6jphRw@mail.gmail.com>
In-Reply-To: <CAHC9VhRrQVNwZw6dzAiYJZxwfUwdzN7+3Ki0EEsNNupH6jphRw@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 7 Jun 2022 14:28:00 +0200
Message-ID: <CAFqZXNtxnzc_UYfm6Q-UWLf3zK5BNL-Miji2WJDw7Mnu+cU9TA@mail.gmail.com>
Subject: Re: Bug in SELinux SCTP ASCONF handling
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jun 3, 2022 at 12:45 AM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Jun 2, 2022 at 10:49 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > On Wed, Jun 1, 2022 at 3:32 AM Paul Moore <paul@paul-moore.com> wrote:
> > > On Tue, May 31, 2022 at 7:53 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Tue, May 31, 2022 at 1:05 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > > Hello everyone,
> > > > >
> > > > > Investigating the yet still spuriously failing SCTP ASCONF test [1]
> > > >
> > > > FWIW, I haven't seen failures with the SCTP tests when doing my
> > > > testing, but perhaps I've just been lucky with the timing windows.
> > > >
> > > > > has led me to realize that the SCTP_PARAM_* chunk handling is in fact
> > > > > severely flawed. The SCTP_PARAM_* code paths reuse the
> > > > > security_sctp_bind_connect() hook, but that hook uses the current
> > > > > task's sid when checking the socket::connect permission, which is not
> > > > > correct, since there is no guarantee on the task context in which the
> > > > > incoming ASCONF packet will be processed.
> > > > >
> > > > > The relevant selinux-testsuite test [1] expects the subject sid to be
> > > > > the one of the server, which has been true only by accident, as SCTP
> > > > > often processes the incoming ASCONF chunk via softirq right after it
> > > > > is sent.
> > > > >
> > > > > This seems tricky to fix, as we don't have any appropriate subject
> > > > > context at hand at the time of receiving the ASCONF chunk... Any
> > > > > ideas?
> > >
> > > From a quick skim of the SCTP RFCs, the ASCONF chunk is sent from a
> > > remote endpoint to update the SCTP parameters so in this case I
> > > believe the subject should be the remote peer (the association/sock's
> > > peer_secid) and the object should be the local association/socket.
> > > It's important to note that any access control checks using the remote
> > > peer label should be gated by the selinux_peerlbl_enabled() function,
> > > see selinux_socket_sock_rcv_skb() for an example.
> >
> > I don't like the idea of using peer_secid as the subject for
> > socket::connect, which normally has a task sid as the subject.
>
> While I have concerns about reusing the socket:connect permission for
> the ASCONF updates, it isn't because of the peer_secid.  The
> peer_secid represents the security label of the remote peer and it is
> the subject label for ASCONF operations.

It does make sense to use it as a subject label, but not for the
connect permission, where the convention is that the subject context
is a process context. While we don't have any hard rule against mixing
different "kinds" of contexts in the subject/target of a given
permission, it makes both figuring out AVC denials and reasoning about
policy harder and I want to avoid it wherever possible.

> > If we go this way, then I'd suggest extracting this case into a new
> > permission. Maybe sctp_socket::asconf_from? Or even split it into
> > ::add_ip_from and ::set_primary_from, as the latter is less security
> > sensitive[2]?
>
> Two thoughts in random order:
>
> * Policy capabilities would be needed as we currently apply the
> socket:connect permission to cover the ASCONF updates.

Yes.

> * We should list out all of the current ASCONF parameter changes and
> have a discussion about which ones we want to protect with access
> controls, and of those remaining controls which should be grouped (if
> any).

I agree that we should think this through before making changes. I
likely won't have enough time to implement the fixes myself, but at
least I will try to provide some food for thought for whoever will
attempt to tackle this :)

> > Also we might want to have another check over just the socket context
> > to allow/disallow ADD_IP/SET_PRIMARY regardless of the peer so that
> > there is some level of control also when peer labeling is disabled.
>
> Are you talking about something like this: "allow socket_t
> self:sctp_socket some_asconf_perm"?  I'd need to hear a good
> explanation for this and why we would need this control, because it
> doesn't make a lot of sense to me.  If you are allowing an application
> to create a SCTP socket, you are granting it permission to make use of
> SCTP, including ASCONF.

My idea is to provide policy writers/users (particularly those who
don't want to enable peer labeling) a simple way to control the usage
of ASCONF on the machine (either at global or socket level). ASCONF is
quite a niche feature of SCTP and probably won't be used by most
applications (and the SCTP RFC mandates that it be used only in
conjunction with auth chunks, which is itself another niche feature).
Given that ASCONF has security implications, I see it as a natural
requirement to be able to allow a domain to use SCTP itself, but not
to process ASCONF commands from any peer.

-- 
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

