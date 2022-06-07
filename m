Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F912C43334
	for <selinux@archiver.kernel.org>; Tue,  7 Jun 2022 15:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245004AbiFGPI3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 7 Jun 2022 11:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiFGPI1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 7 Jun 2022 11:08:27 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6B252E6B
        for <selinux@vger.kernel.org>; Tue,  7 Jun 2022 08:08:26 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id q15so16561637wrc.11
        for <selinux@vger.kernel.org>; Tue, 07 Jun 2022 08:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=exTq+Bm862OLyrh/xDCCgGgoem3KiGi0UWtPLOZSJCE=;
        b=7TXF3GFeVvTUpyjhfAJuHldgOXaNFuFp7LWKSO7eArrBBAXp2N8PoDhyqHuAcTwqAY
         WdpE1pwalTGIj5b6+oUxTrOZpsvmfJbi/nmXz4CUHpO2E2WoKWpfKJfOQ92iUFg36k2m
         53T0bx1XCYaVmpCtYbswGEfcfrYzHa9wLjSXFX3rvk+T/bAcYQt9NlbEcs8/A2f203B5
         Qk2uzVd635lrhAr9ha7e6nW+VDEA0fqp+AEkaZ/8hhrE26ZeLtWsIVQ9a/I7MemiRc0E
         3rt1QaJs4FjsySoP7upd5JgI7PbmqWrKtkPTXJ5PO+MdDl6LWOVS80d7U53fFu5oIOlS
         Z/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=exTq+Bm862OLyrh/xDCCgGgoem3KiGi0UWtPLOZSJCE=;
        b=nrTVak2HtYmJ36+d8lnfjGVXaZTWr2jToVu5Z/jOX60WbpjMFl/gc7vCrZm8Fk1hUR
         qRjJUb0oW4OA9uDrSlpIPg62RBHwt/jqkGtfUbiifIJYhwH01jZdMZ8QM8nw8hsUoF3E
         qXHbHmvksOGz7RoMJthorA3lcSgMQEYs7luHD01AIiO5w9EtisjgY8r/M25fZ9ug5+xv
         K4xmHrGnyMYnbdzWx1GfN8yj3/jLiRgAyXHbkSGvaTrH/bGSFzOo+ruiLaSPArLHFoZp
         Rq3OaDQBsauucCUrAmdxDHt2/OzA87gFsHI6IEtfFu8qfgA54cusLmtQABH3ctzeYLac
         QbgA==
X-Gm-Message-State: AOAM533l6y1dBmZje0Ftwzk8WziyonjimgDBKqHuX2NqP4m7JQT9T3az
        4t9L0bZSOvmVEJ4PuOww9pv0XWD9/rUz+KbSPPGU
X-Google-Smtp-Source: ABdhPJwchCTriZt82JzDxgoreqUJQ69O6XHTe1NPr9pfdjAXNAqMCiNElPk1k+dHmCLl+7y1GF0BXP4Ii7Sjvjuxy98=
X-Received: by 2002:a5d:40c5:0:b0:216:ddde:9c2e with SMTP id
 b5-20020a5d40c5000000b00216ddde9c2emr16054182wrq.241.1654614504473; Tue, 07
 Jun 2022 08:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAFqZXNsO0HSqP2n3W_Su07LPggUm5_M1tGJBuJDW_VL-pWHOWw@mail.gmail.com>
 <CAHC9VhTqrPeqSFhBKNXvmyf-upN4L73qKSPxBSSRKa+3Ks3oPg@mail.gmail.com>
 <CAHC9VhQ9FG9kFBJrwS2P_cxkGs8frQ0b=Wz+Hu=e6mrnZXi23A@mail.gmail.com>
 <CAFqZXNs49z1z5CE_sb8_fJAOGfFNhOc2PmFY516WOSfcj-2Zfw@mail.gmail.com>
 <CAHC9VhRrQVNwZw6dzAiYJZxwfUwdzN7+3Ki0EEsNNupH6jphRw@mail.gmail.com> <CAFqZXNtxnzc_UYfm6Q-UWLf3zK5BNL-Miji2WJDw7Mnu+cU9TA@mail.gmail.com>
In-Reply-To: <CAFqZXNtxnzc_UYfm6Q-UWLf3zK5BNL-Miji2WJDw7Mnu+cU9TA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 7 Jun 2022 11:08:13 -0400
Message-ID: <CAHC9VhRyJ5d9fZYWFVmNaKGAmZr09Lrcc+5rAXjg38GPAO=erA@mail.gmail.com>
Subject: Re: Bug in SELinux SCTP ASCONF handling
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 7, 2022 at 8:28 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Fri, Jun 3, 2022 at 12:45 AM Paul Moore <paul@paul-moore.com> wrote:
> > On Thu, Jun 2, 2022 at 10:49 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > >
> > > On Wed, Jun 1, 2022 at 3:32 AM Paul Moore <paul@paul-moore.com> wrote:
> > > > On Tue, May 31, 2022 at 7:53 PM Paul Moore <paul@paul-moore.com> wrote:
> > > > > On Tue, May 31, 2022 at 1:05 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:

...

> > > > From a quick skim of the SCTP RFCs, the ASCONF chunk is sent from a
> > > > remote endpoint to update the SCTP parameters so in this case I
> > > > believe the subject should be the remote peer (the association/sock's
> > > > peer_secid) and the object should be the local association/socket.
> > > > It's important to note that any access control checks using the remote
> > > > peer label should be gated by the selinux_peerlbl_enabled() function,
> > > > see selinux_socket_sock_rcv_skb() for an example.
> > >
> > > I don't like the idea of using peer_secid as the subject for
> > > socket::connect, which normally has a task sid as the subject.
> >
> > While I have concerns about reusing the socket:connect permission for
> > the ASCONF updates, it isn't because of the peer_secid.  The
> > peer_secid represents the security label of the remote peer and it is
> > the subject label for ASCONF operations.
>
> It does make sense to use it as a subject label, but not for the
> connect permission, where the convention is that the subject context
> is a process context. While we don't have any hard rule against mixing
> different "kinds" of contexts in the subject/target of a given
> permission, it makes both figuring out AVC denials and reasoning about
> policy harder and I want to avoid it wherever possible.

The network peer label is a process label, it is intended to represent
the security attributes of the remote process.

However, as I mentioned above, the socket:connect permission is likely
not the proper permission to use in the ASCONF case.

> > * We should list out all of the current ASCONF parameter changes and
> > have a discussion about which ones we want to protect with access
> > controls, and of those remaining controls which should be grouped (if
> > any).
>
> I agree that we should think this through before making changes. I
> likely won't have enough time to implement the fixes myself, but at
> least I will try to provide some food for thought for whoever will
> attempt to tackle this :)

That's disappointing.  I'll drop what I'm doing and work on this,
because someone needs to fix this.

> > > Also we might want to have another check over just the socket context
> > > to allow/disallow ADD_IP/SET_PRIMARY regardless of the peer so that
> > > there is some level of control also when peer labeling is disabled.
> >
> > Are you talking about something like this: "allow socket_t
> > self:sctp_socket some_asconf_perm"?  I'd need to hear a good
> > explanation for this and why we would need this control, because it
> > doesn't make a lot of sense to me.  If you are allowing an application
> > to create a SCTP socket, you are granting it permission to make use of
> > SCTP, including ASCONF.
>
> My idea is to provide policy writers/users (particularly those who
> don't want to enable peer labeling) a simple way to control the usage
> of ASCONF on the machine (either at global or socket level). ASCONF is
> quite a niche feature of SCTP and probably won't be used by most
> applications (and the SCTP RFC mandates that it be used only in
> conjunction with auth chunks, which is itself another niche feature).
> Given that ASCONF has security implications, I see it as a natural
> requirement to be able to allow a domain to use SCTP itself, but not
> to process ASCONF commands from any peer.

I'll reserve final judgement because I need to go read the ASCONF
related RFCs instead of just skimming them, but I'm not overly swayed
by the argument above.  SELinux should be about providing mechanisms
which allow policy writers to control what entities on a system have
access to a specific blob of data, restricting the details of the
protocols which are used to access that data is getting a bit out of
scope unless those details directly affect the ability to access the
data.  I think we should keep the name_connect check, although likely
with a different name in the ASCONF case, however, that checks the
socket/sock's label against the connection endpoint's addr/port and is
something different from the network peer labeling controls we've been
talking about.  Although I believe the ASCONF/name_connect check
should address the security concerns of an ASCONF induced change
affecting the endpoint of an SCTP connection and effectively bypassing
the earlier name_connect check done when the connection was first
established.

-- 
paul-moore.com
