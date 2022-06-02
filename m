Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AC4C433EF
	for <selinux@archiver.kernel.org>; Thu,  2 Jun 2022 14:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbiFBOtl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Jun 2022 10:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbiFBOti (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Jun 2022 10:49:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CE53187056
        for <selinux@vger.kernel.org>; Thu,  2 Jun 2022 07:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654181376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o/ftTrzrWlYlnhuWvl1ljoYD8lKpYTVNLO4bgSrmDY4=;
        b=USN5i4Z80faEuNsB9B7evHQAP5eSyCX5caVlcMjD9jrNIQrbqZxX0S1iKDZ27LD5ApKL5Z
        cM/heLEQzBxPg9PhPYbo+z9KuvGP4iQERzy200z82LyohaLOf84y9rWZ5Ttn2sHi6o+kxJ
        qdGK2oNVeCI/tJZvG7A7fqB0SkkuwZA=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-dges8EJPMP20-Gnjw9DC1g-1; Thu, 02 Jun 2022 10:49:35 -0400
X-MC-Unique: dges8EJPMP20-Gnjw9DC1g-1
Received: by mail-yb1-f198.google.com with SMTP id a68-20020a25ca47000000b006605f788ff1so938773ybg.16
        for <selinux@vger.kernel.org>; Thu, 02 Jun 2022 07:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o/ftTrzrWlYlnhuWvl1ljoYD8lKpYTVNLO4bgSrmDY4=;
        b=y/cVQaiVlIVHWLHBmyqo3VAFct6qVz7lSTdv2FzqPPe8YgFd7O/KS01aUQPgw1jKKg
         jL7q/GqyFN8MZvaBDqzfeOtMM8WtWV1Q+FJArE2F3qok1lt1IAHvqGjBUZ0yeuc7/xJJ
         jd23txcypE/K2WgLGNG/7bBfPb1S0og6stowqT5xGFiitRej0+ZEEKOSVaMctj/gNw/n
         2NVrMqKfiavaDHFSZweXpb/FN3CZNvJwyDdggC6z7V4dAA0D9jr+RZOffoVi1qBpv1RD
         HGQyWKP0qDexrD2f+NvMWVZUSqScVkc9NUTQXW6E+FKJGRMoMAJC9s8bCSz2J4v/vEWa
         ol2w==
X-Gm-Message-State: AOAM531rAgwXVe++nBOMOPC1WSz+bq5p8qfHnmgQ2zRfAjZFKSzJK06X
        541ha9AI3xEKl8rdA3MtiwQ97DnNLUavSlQ53U9KzBT/XPm6sJ8SxWqzj+V2byo9WlxpEa8E6n+
        q/2YyVvmIivYSxcChzXlOEW3eYAsKV2t3Lw==
X-Received: by 2002:a81:7010:0:b0:30c:c6cf:d4af with SMTP id l16-20020a817010000000b0030cc6cfd4afmr5649236ywc.459.1654181375030;
        Thu, 02 Jun 2022 07:49:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx72hRRKZ1nrtiY8/BUAuBrYyQ69l3kV1ikNA35bKNYIBmKOLuqfjzaWe8XQYi6FF1fnlda9CwUeskqgs4kZCI=
X-Received: by 2002:a81:7010:0:b0:30c:c6cf:d4af with SMTP id
 l16-20020a817010000000b0030cc6cfd4afmr5649212ywc.459.1654181374845; Thu, 02
 Jun 2022 07:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNsO0HSqP2n3W_Su07LPggUm5_M1tGJBuJDW_VL-pWHOWw@mail.gmail.com>
 <CAHC9VhTqrPeqSFhBKNXvmyf-upN4L73qKSPxBSSRKa+3Ks3oPg@mail.gmail.com> <CAHC9VhQ9FG9kFBJrwS2P_cxkGs8frQ0b=Wz+Hu=e6mrnZXi23A@mail.gmail.com>
In-Reply-To: <CAHC9VhQ9FG9kFBJrwS2P_cxkGs8frQ0b=Wz+Hu=e6mrnZXi23A@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 2 Jun 2022 16:49:23 +0200
Message-ID: <CAFqZXNs49z1z5CE_sb8_fJAOGfFNhOc2PmFY516WOSfcj-2Zfw@mail.gmail.com>
Subject: Re: Bug in SELinux SCTP ASCONF handling
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jun 1, 2022 at 3:32 AM Paul Moore <paul@paul-moore.com> wrote:
> On Tue, May 31, 2022 at 7:53 PM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, May 31, 2022 at 1:05 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > Hello everyone,
> > >
> > > Investigating the yet still spuriously failing SCTP ASCONF test [1]
> >
> > FWIW, I haven't seen failures with the SCTP tests when doing my
> > testing, but perhaps I've just been lucky with the timing windows.
> >
> > > has led me to realize that the SCTP_PARAM_* chunk handling is in fact
> > > severely flawed. The SCTP_PARAM_* code paths reuse the
> > > security_sctp_bind_connect() hook, but that hook uses the current
> > > task's sid when checking the socket::connect permission, which is not
> > > correct, since there is no guarantee on the task context in which the
> > > incoming ASCONF packet will be processed.
> > >
> > > The relevant selinux-testsuite test [1] expects the subject sid to be
> > > the one of the server, which has been true only by accident, as SCTP
> > > often processes the incoming ASCONF chunk via softirq right after it
> > > is sent.
> > >
> > > This seems tricky to fix, as we don't have any appropriate subject
> > > context at hand at the time of receiving the ASCONF chunk... Any
> > > ideas?
>
> From a quick skim of the SCTP RFCs, the ASCONF chunk is sent from a
> remote endpoint to update the SCTP parameters so in this case I
> believe the subject should be the remote peer (the association/sock's
> peer_secid) and the object should be the local association/socket.
> It's important to note that any access control checks using the remote
> peer label should be gated by the selinux_peerlbl_enabled() function,
> see selinux_socket_sock_rcv_skb() for an example.

I don't like the idea of using peer_secid as the subject for
socket::connect, which normally has a task sid as the subject. If we
go this way, then I'd suggest extracting this case into a new
permission. Maybe sctp_socket::asconf_from? Or even split it into
::add_ip_from and ::set_primary_from, as the latter is less security
sensitive[2]?

Also we might want to have another check over just the socket context
to allow/disallow ADD_IP/SET_PRIMARY regardless of the peer so that
there is some level of control also when peer labeling is disabled.

[2] "A sender MUST only send a set primary request to an address that
is already considered part of the association."
    https://datatracker.ietf.org/doc/html/rfc5061#section-5.4

>
> I haven't looked too closely, but my initial gut feeling would be to
> move the sock_has_perm() call out of selinux_socket_connect_helper()
> and either modify the sock_has_perm() function to take the subject as
> a parameter, or open code it inside selinux_sctp_bind_connect() using
> the peer label.  I suspect the additional parameter will be cleaner
> due to the common_audit_data requirement of avc_has_perm().
>
> --
> paul-moore.com
>
--
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

