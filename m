Return-Path: <SRS0=SqeD=ZS=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A90C432C0
	for <selinux@archiver.kernel.org>; Tue, 26 Nov 2019 16:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28B520722
	for <selinux@archiver.kernel.org>; Tue, 26 Nov 2019 16:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ve2aJ6IS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbfKZQWC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 26 Nov 2019 11:22:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59009 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727796AbfKZQWC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 26 Nov 2019 11:22:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574785320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hQknZGsAYqvyrmE3qGuygjSgDJjx+8nBMvodHeYff6o=;
        b=Ve2aJ6ISFGy59hL4JYSM6y4QZL7Y9/4jT/laQ1YBzhyJbNu8P7GVaikOjkm4DBzMhX5nlI
        A/fgwjeg9cpbm/LPimAzyz2K5BSs2uiyDdYr0HZ1wL2HTSaxUdGFu6ucHAww8Gfdq94BTG
        aT1+k9Jl0hsN/9KNkHVfjuLg5D13Ad0=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-92a960oWOoWHKNyCOuOtUA-1; Tue, 26 Nov 2019 11:21:59 -0500
Received: by mail-oi1-f200.google.com with SMTP id z143so9574097oia.20
        for <selinux@vger.kernel.org>; Tue, 26 Nov 2019 08:21:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tqPYXCmEd8MDeObhixnCq7+a3i3yC0BHhYg3qguRLY4=;
        b=f7iKehVDSnH3jHimdzABb9Fv/GYG/rhz7cX8GFdi3POTL0BPSVv1fSXymFilAM9Nkn
         f2hAeIeYpLduVZO2i4lmgRoerFTNiFrajXVJfz/E50lkXvPwKpLkbXRN5QbbBQxoRzCe
         rDNO/lU/tUnBTegaEHNQVgfJKtTxjRX3TWTjBrlnupLwLTUtZ7iejs7WOM7FopmU+dB7
         lTf/fmV0xDZaEhKVc+wUKr7G3BN6D2T6PHFB3xJcW1GiyINhOpHynbnO3bZgYvSYdOIM
         SOaQvy/mOAHCozpU5YeHl+jTy5pH8kvxltExlASrW6sJHAdZdARtgOmERnRaBWEWi0bf
         c9uw==
X-Gm-Message-State: APjAAAV06O/OoJ3RKrzhTnO6Q0PQvD+hieft2lxhCFF98wUtIosLpDid
        ISpaAUvpqTw0+g2wLW0xXIQkoqO+MJWSGDF2AlWbVi4NiQQhckZThLQhdPtTjKlcDCxWCina73a
        /lRblHTIxAKj5R3O6PbkhyDkab3e1dUwnGg==
X-Received: by 2002:a9d:4042:: with SMTP id o2mr6236374oti.22.1574785318631;
        Tue, 26 Nov 2019 08:21:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqxR9rkT2Em/Fa2tgK40jGNzzU7JWsGCYfk68NKRWEPtMfJuLJBEUWgUZz5CX7jUE0IE9BxyOrhDIBc5+EcorAY=
X-Received: by 2002:a9d:4042:: with SMTP id o2mr6236346oti.22.1574785318214;
 Tue, 26 Nov 2019 08:21:58 -0800 (PST)
MIME-Version: 1.0
References: <20191126120623.736870-1-omosnace@redhat.com> <c765adb1e61950cb0f2aea6cbb7d4b94797b2a31.camel@btinternet.com>
 <2723e1c7-7e17-b8fc-757d-4a126ded8354@tycho.nsa.gov> <CAFqZXNtaDV0d1riR2kc-ygW_bfUUE+r7y0vL_4+xJ97Ff7W_sA@mail.gmail.com>
 <1dd92a7d6bbc03048a92ee5e3f37e9e17c0089de.camel@btinternet.com>
In-Reply-To: <1dd92a7d6bbc03048a92ee5e3f37e9e17c0089de.camel@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 26 Nov 2019 17:22:00 +0100
Message-ID: <CAFqZXNvbe36Ebppv3EoPXzO04ON3UOK81K3NVN7=S=TrQPJmCg@mail.gmail.com>
Subject: Re: [PATCH testsuite v3] policy: use the kernel_request_load_module() interface
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>
X-MC-Unique: 92a960oWOoWHKNyCOuOtUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 26, 2019 at 4:59 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Tue, 2019-11-26 at 16:02 +0100, Ondrej Mosnacek wrote:
> > On Tue, Nov 26, 2019 at 3:54 PM Stephen Smalley <sds@tycho.nsa.gov>
> > wrote:
> > > On 11/26/19 9:51 AM, Richard Haines wrote:
> > > > On Tue, 2019-11-26 at 13:06 +0100, Ondrej Mosnacek wrote:
> > > > > ...instead of open-coding the rules. Also define a fallback to
> > > > > allow
> > > > > the
> > > > > policy to build even if the interface is not defined.
> > > > >
> > > > > Fixes: f5e5a0b8d005 ("selinux-testsuite: Add key_socket tests")
> > > > > Cc: Richard Haines <richard_c_haines@btinternet.com>
> > > > > Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> > > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > > ---
> > > > >
> > > > > Change in v3: use different approach as suggested by Stephen
> > > > > Change in v2: update also tests/Makefile for consistency
> > > > >
> > > > >   policy/test_key_socket.te | 8 ++++----
> > > > >   policy/test_policy.if     | 6 ++++++
> > > > >   2 files changed, 10 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/policy/test_key_socket.te
> > > > > b/policy/test_key_socket.te
> > > > > index cde426b..f1c1606 100644
> > > > > --- a/policy/test_key_socket.te
> > > > > +++ b/policy/test_key_socket.te
> > > > > @@ -13,7 +13,7 @@ typeattribute test_key_sock_t keysockdomain;
> > > > >   allow test_key_sock_t self:capability { net_admin };
> > > > >   allow test_key_sock_t self:key_socket { create write read
> > > > > setopt };
> > > > >   # For CONFIG_NET_KEY=3Dm
> > > > > -allow test_key_sock_t kernel_t:system { module_request };
> > > > > +kernel_request_load_module(test_key_sock_t)
> > > > >
> > > > >   ################## Deny capability { net_admin }
> > > > > ##########################
> > > > >   #
> > > > > @@ -29,7 +29,7 @@ typeattribute test_key_sock_no_net_admin_t
> > > > > testdomain;
> > > > >   typeattribute test_key_sock_no_net_admin_t keysockdomain;
> > > > >
> > > > >   allow test_key_sock_no_net_admin_t self:key_socket { create
> > > > > write
> > > > > read setopt };
> > > > > -allow test_key_sock_no_net_admin_t kernel_t:system {
> > > > > module_request
> > > > > };
> > > > > +kernel_request_load_module(test_key_sock_t)
> > > >
> > > > All the new entries have (test_key_sock_t) ??
> > > > Anyway if you run the tests in the order they appear in 'test'
> > > > script,
> > > > then it just so happens that the module will be loaded for
> > > > test_key_sock_t as it's first. I added the others just to cover
> > > > the
> > > > cases where I sometimes run out of sequence, so you could remove
> > > > these
> > > > if required.
> >
> > *facepalm*
> >
> > Yes, sorry, I messed up the copy-paste...
> >
> > > Good catch!  Somehow I missed that.  Could probably just have a
> > > single
> > > kernel_request_load_module(keysockdomain) line?
> >
> > There is one domain (test_key_sock_no_create_t) that doesn't have the
> > rule, so probably not.
>
> That is probably one I didn't test out of sequence.
>
> I'm currently writing the TUN/TAP tests and had the same problem as
> I've left the default Fedora CONFIG_TUN=3Dm.
> I've added 'kernel_request_load_module(tuntapdomain)' to the test
> module that allows tests in any order (as I usually run rmmod just as a
> check).
>
> I'll leave it to you guys to decide what is finally best for you.

Aha, I see, so actually all the types might potentially need the rule
(if someone rmmods the module during test, for example), so it would
make more sense to allow it to the whole domain as Stephen suggested.
I didn't stop to think about it and I assumed that the one domain
didn't have the rule intentionally... I think I'll repost the patch
once more, calling the macro on the whole keysockdomain.

>
> >
> > > > >   ####################### Deny key_socket { create }
> > > > > ##########################
> > > > >   type test_key_sock_no_create_t;
> > > > > @@ -50,7 +50,7 @@ typeattribute test_key_sock_no_write_t
> > > > > keysockdomain;
> > > > >
> > > > >   allow test_key_sock_no_write_t self:capability { net_admin };
> > > > >   allow test_key_sock_no_write_t self:key_socket { create read
> > > > > setopt
> > > > > };
> > > > > -allow test_key_sock_no_write_t kernel_t:system {
> > > > > module_request };
> > > > > +kernel_request_load_module(test_key_sock_t)
> > > > >
> > > > >   ####################### Deny key_socket { read }
> > > > > ##########################
> > > > >   type test_key_sock_no_read_t;
> > > > > @@ -61,7 +61,7 @@ typeattribute test_key_sock_no_read_t
> > > > > keysockdomain;
> > > > >
> > > > >   allow test_key_sock_no_read_t self:capability { net_admin };
> > > > >   allow test_key_sock_no_read_t self:key_socket { create write
> > > > > setopt
> > > > > };
> > > > > -allow test_key_sock_no_read_t kernel_t:system { module_request
> > > > > };
> > > > > +kernel_request_load_module(test_key_sock_t)
> > > > >
> > > > >   #
> > > > >   ########### Allow these domains to be entered from sysadm
> > > > > domain
> > > > > ############
> > > > > diff --git a/policy/test_policy.if b/policy/test_policy.if
> > > > > index e1175e8..3f163cb 100644
> > > > > --- a/policy/test_policy.if
> > > > > +++ b/policy/test_policy.if
> > > > > @@ -82,3 +82,9 @@ interface(`userdom_search_admin_dir', `
> > > > >       userdom_search_user_home_content($1)
> > > > >   ')
> > > > >   ')
> > > > > +
> > > > > +# If the macro isn't defined, then most probably
> > > > > module_request
> > > > > permission
> > > > > +# is just not supported (and relevant operations should be
> > > > > just
> > > > > allowed).
> > > > > +ifdef(`kernel_request_load_module', `', ` dnl
> > > > > +interface(`kernel_request_load_module', `')
> > > > > +')
> >
> >
>


--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

