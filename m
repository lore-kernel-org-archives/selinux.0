Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3B8C433EF
	for <selinux@archiver.kernel.org>; Thu,  2 Jun 2022 22:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238410AbiFBWpo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 2 Jun 2022 18:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237041AbiFBWpn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 2 Jun 2022 18:45:43 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C0313FB7
        for <selinux@vger.kernel.org>; Thu,  2 Jun 2022 15:45:42 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u3so8216819wrg.3
        for <selinux@vger.kernel.org>; Thu, 02 Jun 2022 15:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q7szmyeK2mYL36vwLekQ9/QChCLXFZSkWKVs4j7qpx0=;
        b=UqOIwMBJ6NLe+QaKW4zRS4oPSbGlcz4k5ODCSRcoiB27ZfQOy2+Kd9xEhjToIAdQtM
         HLProkuZucNEgEnyQVMRJHOFd83kZm3Amx5ZoosaM3KOMzAbQDjnoZWaESHrp8ySKxAm
         rdyVtIADLmv42yLcU9A08hkWSlcDrGC0oNVX0DcFuJFY2z86nFngret0vBoJ8dPNsGxG
         c7skKq8wpxA65nYf0uPLUYM4vamISf+Yd1ITKqEfQ11+PJpLl0cxGPidN51m+5zdxsWH
         dvrv2wbecN/k4kxvtMXsNh3nxHJArh6XeMECR86anxIVA2KLPCsCR4w5b8lf3TIfjm7z
         r7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q7szmyeK2mYL36vwLekQ9/QChCLXFZSkWKVs4j7qpx0=;
        b=vN6dD67/3yquBSSsUSePDLOMu1hdfOTmmM06O9K5Jl+iZwzveV8y4ube3ZVvMC9xuB
         XSCs9m21FBOMq82eu5pefHYlunZt6KJwn2ZOv5+xGHnqv6oTZAtU1+dV/ELdzO5opOTO
         B7gy7tUbrj3GTpv4VNZz3mNKg8MiLui1BzrnKXE7ypk0/KEmFP/qujEpqSVOR0ddAAz8
         lbaBrMKwKpa5QMdCwPG77WXW6opWaSk8k+PwSi1iUbnH3yRWJQhtanCI+kito5wSXWvS
         iIvRCC1WKsRbutIi10NVsRP7RMwyZs0mi6AazHOUQ4lwiRJcQWTzJ6a2k1JXMNb2uapf
         oLkg==
X-Gm-Message-State: AOAM533LQ1mhm7yEcDz8mjvwEhlOvfrpDbM7l/XrXK8U0bnqOYdXymif
        ZHOpD4Hi8jA3AmliGqhbEN7EU86hrWVFlLczvEMC
X-Google-Smtp-Source: ABdhPJxTt33uL4T6NzjAyNHJ4RTTo5LcCK6keUgkL6AaXqCq0VbSfc3qSzMKhrGa9gn4PCY0Fs9GR4rasEzXGjVpoyE=
X-Received: by 2002:a05:6000:1d83:b0:20c:d508:f55a with SMTP id
 bk3-20020a0560001d8300b0020cd508f55amr5322613wrb.217.1654209940576; Thu, 02
 Jun 2022 15:45:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNsO0HSqP2n3W_Su07LPggUm5_M1tGJBuJDW_VL-pWHOWw@mail.gmail.com>
 <CAHC9VhTqrPeqSFhBKNXvmyf-upN4L73qKSPxBSSRKa+3Ks3oPg@mail.gmail.com>
 <CAHC9VhQ9FG9kFBJrwS2P_cxkGs8frQ0b=Wz+Hu=e6mrnZXi23A@mail.gmail.com> <CAFqZXNs49z1z5CE_sb8_fJAOGfFNhOc2PmFY516WOSfcj-2Zfw@mail.gmail.com>
In-Reply-To: <CAFqZXNs49z1z5CE_sb8_fJAOGfFNhOc2PmFY516WOSfcj-2Zfw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 2 Jun 2022 18:45:29 -0400
Message-ID: <CAHC9VhRrQVNwZw6dzAiYJZxwfUwdzN7+3Ki0EEsNNupH6jphRw@mail.gmail.com>
Subject: Re: Bug in SELinux SCTP ASCONF handling
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 2, 2022 at 10:49 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Wed, Jun 1, 2022 at 3:32 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Tue, May 31, 2022 at 7:53 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Tue, May 31, 2022 at 1:05 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > Hello everyone,
> > > >
> > > > Investigating the yet still spuriously failing SCTP ASCONF test [1]
> > >
> > > FWIW, I haven't seen failures with the SCTP tests when doing my
> > > testing, but perhaps I've just been lucky with the timing windows.
> > >
> > > > has led me to realize that the SCTP_PARAM_* chunk handling is in fact
> > > > severely flawed. The SCTP_PARAM_* code paths reuse the
> > > > security_sctp_bind_connect() hook, but that hook uses the current
> > > > task's sid when checking the socket::connect permission, which is not
> > > > correct, since there is no guarantee on the task context in which the
> > > > incoming ASCONF packet will be processed.
> > > >
> > > > The relevant selinux-testsuite test [1] expects the subject sid to be
> > > > the one of the server, which has been true only by accident, as SCTP
> > > > often processes the incoming ASCONF chunk via softirq right after it
> > > > is sent.
> > > >
> > > > This seems tricky to fix, as we don't have any appropriate subject
> > > > context at hand at the time of receiving the ASCONF chunk... Any
> > > > ideas?
> >
> > From a quick skim of the SCTP RFCs, the ASCONF chunk is sent from a
> > remote endpoint to update the SCTP parameters so in this case I
> > believe the subject should be the remote peer (the association/sock's
> > peer_secid) and the object should be the local association/socket.
> > It's important to note that any access control checks using the remote
> > peer label should be gated by the selinux_peerlbl_enabled() function,
> > see selinux_socket_sock_rcv_skb() for an example.
>
> I don't like the idea of using peer_secid as the subject for
> socket::connect, which normally has a task sid as the subject.

While I have concerns about reusing the socket:connect permission for
the ASCONF updates, it isn't because of the peer_secid.  The
peer_secid represents the security label of the remote peer and it is
the subject label for ASCONF operations.

> If we go this way, then I'd suggest extracting this case into a new
> permission. Maybe sctp_socket::asconf_from? Or even split it into
> ::add_ip_from and ::set_primary_from, as the latter is less security
> sensitive[2]?

Two thoughts in random order:

* Policy capabilities would be needed as we currently apply the
socket:connect permission to cover the ASCONF updates.
* We should list out all of the current ASCONF parameter changes and
have a discussion about which ones we want to protect with access
controls, and of those remaining controls which should be grouped (if
any).

> Also we might want to have another check over just the socket context
> to allow/disallow ADD_IP/SET_PRIMARY regardless of the peer so that
> there is some level of control also when peer labeling is disabled.

Are you talking about something like this: "allow socket_t
self:sctp_socket some_asconf_perm"?  I'd need to hear a good
explanation for this and why we would need this control, because it
doesn't make a lot of sense to me.  If you are allowing an application
to create a SCTP socket, you are granting it permission to make use of
SCTP, including ASCONF.

-- 
paul-moore.com
