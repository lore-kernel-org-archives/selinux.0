Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BD4C433EF
	for <selinux@archiver.kernel.org>; Thu, 18 Nov 2021 14:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4EE561406
	for <selinux@archiver.kernel.org>; Thu, 18 Nov 2021 14:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhKROuA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 18 Nov 2021 09:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhKROt7 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 18 Nov 2021 09:49:59 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5FDC061574
        for <selinux@vger.kernel.org>; Thu, 18 Nov 2021 06:46:59 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id bu18so27443342lfb.0
        for <selinux@vger.kernel.org>; Thu, 18 Nov 2021 06:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6EZZVvmji8/thdaow5RQGT3bni2cEps5P6QEzpR398E=;
        b=ktnkn3udKO2MR2v6+SiSp/jze1mOiIMoSHpQs2cKpf7pJH+r5GyiNepIWmb2mCrRgz
         U/8u1s/RxYe3NtkUhk4ulqs9yf44toCaqN397fXoh6/2gAW+0iZ7DedKLlpMJgIux42H
         y43znHzrMNQ7fVpgEmQMxlV25mSZrWSlZRg6K5nuYrWIXu+WKYhDoLTqMc5whSL0BpOd
         0Q9ct4VWISeh+ceEK+bkXtbvs0Cs1Uyk/245lK3E+cCAW1Qy1ZZf4STs/LWUDByHYac/
         CYsFVj0aiCm6aQ0fW4CnvHF98KspWoTt6S/Wv/MOFmM9Qm//QN29EZk/K/DzRbxfXjFa
         6eeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6EZZVvmji8/thdaow5RQGT3bni2cEps5P6QEzpR398E=;
        b=riPs1ZejP3DwzCwLxKvHjzmrzeQ5Ig+1kF76tLA6zJks/9QAqndstqXTmnhm43meWc
         gg1RLFXTYpFOruKHk4JCggG7jweFojveyknhLu9CQmbdIwxFkA0OpyVm+GF/PcDL9doN
         h1D3ad1pOELI0GkOKf8ciI88tNtAHi4ydJsXcN+WHmgxrgbg1yrRbyIxYOurVJf4e1cp
         mqasGB4ek/iPELyXprAYENHAn0KGxNZahWs5conULQDkkI/JDWCiSKPUiDWKYDJWslSO
         YBCCpCAagZDRGx98zOE0u/VCivEhHW13DdxgozQ0QAU5sW1iXWMbRkszJN/vVkpQ9exC
         JvwQ==
X-Gm-Message-State: AOAM531MkfRU0u953EdFLE8Tksg06q7vUX+BA7AeGWLJD8mu3RkcSRP8
        ryWb/C9NIxy4d+uFGjlorrcVlXlcpS/FxovVVJ4=
X-Google-Smtp-Source: ABdhPJwy9qM8haswzOsU/OMFMPK+R3VubgXvqeptTU7sozv+Iu8VM3qlZQLJOgAMMNz1EEP2ejIiovP7BvSEp5oVRvs=
X-Received: by 2002:a05:6512:3f2:: with SMTP id n18mr24729376lfq.646.1637246817598;
 Thu, 18 Nov 2021 06:46:57 -0800 (PST)
MIME-Version: 1.0
References: <20211110111308.3463879-1-brambonne@google.com> <CAEjxPJ5ZiVHuYNXBgkKLb2CLCkpUqo-20mAm-sqbk=zt9NH-MQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ5ZiVHuYNXBgkKLb2CLCkpUqo-20mAm-sqbk=zt9NH-MQ@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Thu, 18 Nov 2021 09:46:46 -0500
Message-ID: <CAEjxPJ6AFuND6uyph4m4FcZxQS38d-vf9z2ypC-h3vb6o5=gqg@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: Add netlink xperm support
To:     Bram Bonne <brambonne@google.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 16, 2021 at 10:41 AM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Wed, Nov 10, 2021 at 6:13 AM Bram Bonne <brambonne@google.com> wrote:
> >
> > Reuse the existing extended permissions infrastructure to support
> > sepolicy for different netlink message types.
> >
> > When individual netlink message types are omitted only the existing
> > permissions are checked. As is the case for ioctl xperms, this feature
> > is intended to provide finer granularity for nlmsg_read and nlmsg_write
> > permissions, as they may be too imprecise. For example, a single
> > NETLINK_ROUTE socket may provide access to both an interface's IP
> > address and to its ARP table, which might have different privacy
> > implications. In addition, the set of message types has grown over time,
> > so even if the current list is acceptable, future additions might not be.
> > It was suggested before on the mailing list [1] that extended permissions
> > would be a good fit for this purpose.
> >
> > Existing policy using the nlmsg_read and nlmsg_write permissions will
> > continue to work as-is. Similar to ioctl xperms, netlink xperms allow
> > for a more fine-grained policy where needed.
> >
> > Example policy on Android, preventing regular apps from accessing the
> > device's MAC address and ARP table, but allowing this access to
> > privileged apps, looks as follows:
> >
> > allow netdomain self:netlink_route_socket {
> >         create read getattr write setattr lock append connect getopt
> >         setopt shutdown nlmsg_read
> > };
> > allowxperm netdomain self:netlink_route_socket nlmsg ~{
> >         RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
> > };
> > allowxperm priv_app self:netlink_route_socket nlmsg {
> >         RTM_GETLINK RTM_GETNEIGH RTM_GETNEIGHTBL
> > };
> >
> > Android currently uses code similar to [1] as a temporary workaround to
> > limit access to certain netlink message types; our hope is that this patch
> > will allow us to move back to upstream code with an approach that works for
> > everyone.
> >
> > [1] https://lore.kernel.org/selinux/CAHC9VhRSUhozBycHMZcMaJsibJDxNMsTsKVT2zOnW=5H4R4mdg@mail.gmail.com/
> >
> > Signed-off-by: Bram Bonne <brambonne@google.com>
> > ---
> >  security/selinux/hooks.c       | 24 +++++++++++++++++++++++-
> >  security/selinux/ss/avtab.h    |  1 +
> >  security/selinux/ss/services.c | 23 ++++++++++++++++++++++-
> >  3 files changed, 46 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index e7ebd45ca345..a503865fabed 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -4662,6 +4662,28 @@ static int sock_has_perm(struct sock *sk, u32 perms)
> >                             &ad);
> >  }
> >
> > +static int nlmsg_sock_has_extended_perms(struct sock *sk, u32 perms, u16 nlmsg_type)
> > +{
> > +       struct sk_security_struct *sksec = sk->sk_security;
> > +       struct common_audit_data ad;
> > +       struct lsm_network_audit net = {0,};
> > +       u8 xperm;
> > +
> > +       if (sksec->sid == SECINITSID_KERNEL)
> > +               return 0;
> > +
> > +       ad.type = LSM_AUDIT_DATA_NET;
> > +       ad.u.net = &net;
> > +       ad.u.net->sk = sk;
> > +
> > +       // nlmsg_types comfortably fit into a single driver, see RTM_MAX in uapi/linux/rtnetlink.h
> > +       xperm = nlmsg_type & 0xff;
>
> This seems like a dangerous assumption; obviously not all netlink
> users are rtnetlink. Even if all existing netlink users follow this,
> nothing prevents userspace from creating a netlink message that
> violates it AFAIK, at which point you will just silently discard the
> higher bits. If we think we can get away with this restriction, then
> we need to enforce it here (i.e. return an error if they do not fit);
> if not,
> then we likely need to support multiple drivers with a simple mapping
> of the upper bits to driver.

Looks like generic netlink puts the family id into the message type
field, with the actual command in the separate generic netlink header
in the payload. generic netlink family ids appear to be dynamically
allocated, with GENL_MAX_ID defined as 1023. genl-ctrl-list on a
sample Linux system reports ids from 0x10 through 0x1f so those would
fit but there isn't anything in the code to prevent higher ids from
being allocated up to the max. And if someday you want to be able to
filter generic netlink messages at the per-command level, you'd
further need to deal with the separate cmd field.
