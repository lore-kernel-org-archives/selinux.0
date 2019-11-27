Return-Path: <SRS0=LgiC=ZT=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56BE5C432C0
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 15:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E2B20674
	for <selinux@archiver.kernel.org>; Wed, 27 Nov 2019 15:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eiHxWL+V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfK0P2b (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:28:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35596 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726603AbfK0P2b (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 27 Nov 2019 10:28:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574868510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=THa351C6cOylEPcsgkFF5sGkp9nzlYcdlzvwVXegfM8=;
        b=eiHxWL+VfAi15HWBfmciNZ07/2TgYlb4u5kOf6qGIPuIZb067p6eyZMzjFgkmiH7y4Tc1A
        3F0XGLapiiNjsi1pib6QP4yr4KnWfq7vQk2itJD3uzwIHrGTpZdblYvkhhfveGMrd5+jS3
        8rIzHnCyesmUxIcPhOwi9EPYaR9cr5I=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-kmGVLVgWPxO5qRifHUqghA-1; Wed, 27 Nov 2019 10:28:29 -0500
Received: by mail-oi1-f198.google.com with SMTP id a190so68035oib.1
        for <selinux@vger.kernel.org>; Wed, 27 Nov 2019 07:28:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qe229yk31R3QYzyfrxVb3kwxI8c53og32F+JuWbki5Q=;
        b=bX0Aqv6vQ0N5kh13lSdRvL5DaQn+ZL/za5PA5NhlPZHMo1K+HFkxJF3l5wamkMqWN8
         I67Bof2Gkv8MlXDZHrpqwTHhSk5MpdMh8jDQ5wMQM1NBi3MfecpnSyhUFBa73j20OqS+
         CTpp1MYGK8wMsKXepgG179JojXrwvA9b3y/NP0HIvtFKMM98K9E6oQgCXjnTz21eO0kz
         21KNoIyNlnVU874Jkt+0mTGIyA8ciHhbKM9xiHfuVxcp7BXp84fUttaq2AD8FL4Snfx0
         x6xYN6EQaaQvnfa/A1m8e0EXpvV42K2aSIx/yBc+s2PVgZYAqQfdPf9tHm8nzZZc8P/e
         BvCA==
X-Gm-Message-State: APjAAAVISRa2ir/FafFC2c2EKatTg3ZxwuNkx8IZ0r4jO02/NSZB0iM9
        VheiTUL5INaBNa6AwKCJeOSS+rzvocgpGG3e1GJA7AgO2QBizqWEyLyZo6O45fXgdnRnnyfmUNW
        KJmLnfwUUdwkMiaIFlaScbIIGVtPcl6ZzvA==
X-Received: by 2002:aca:48cb:: with SMTP id v194mr4709425oia.156.1574868508363;
        Wed, 27 Nov 2019 07:28:28 -0800 (PST)
X-Google-Smtp-Source: APXvYqwhY1XZMd6JoYO5F/1uCygj2xs8lTfJcR6rFDuqPWoOGxIPCjDu6SFyaY4bevgmvKQQB67CDSts3V6/OspOa1s=
X-Received: by 2002:aca:48cb:: with SMTP id v194mr4709406oia.156.1574868508070;
 Wed, 27 Nov 2019 07:28:28 -0800 (PST)
MIME-Version: 1.0
References: <20191127123319.814863-1-omosnace@redhat.com> <3c4cc54b-bad1-e72f-85c2-7742cbd3c425@tycho.nsa.gov>
In-Reply-To: <3c4cc54b-bad1-e72f-85c2-7742cbd3c425@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Wed, 27 Nov 2019 16:28:30 +0100
Message-ID: <CAFqZXNtv_7H_aniFEYB0dLo+k3gOK4k_JAUB92bx=pYAnmssBg@mail.gmail.com>
Subject: Re: [PATCH testsuite v5] policy: use the kernel_request_load_module() interface
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Richard Haines <richard_c_haines@btinternet.com>
X-MC-Unique: kmGVLVgWPxO5qRifHUqghA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 27, 2019 at 4:16 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 11/27/19 7:33 AM, Ondrej Mosnacek wrote:
> > ...instead of open-coding the rules. Also define a fallback to allow th=
e
> > policy to build even if the interface is not defined.
> >
> > Fixes: f5e5a0b8d005 ("selinux-testsuite: Add key_socket tests")
> > Cc: Richard Haines <richard_c_haines@btinternet.com>
> > Suggested-by: Stephen Smalley <sds@tycho.nsa.gov>
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >
> > Change in v5: call the macro only once for the whole domain
> > Change in v4: fix copy-paste mistakes spotted by Richard
> > Change in v3: use different approach as suggested by Stephen
> > Change in v2: update also tests/Makefile for consistency
> >
> >   policy/test_key_socket.te | 8 +++-----
> >   policy/test_policy.if     | 6 ++++++
> >   2 files changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/policy/test_key_socket.te b/policy/test_key_socket.te
> > index cde426b..64d2cee 100644
> > --- a/policy/test_key_socket.te
> > +++ b/policy/test_key_socket.te
> > @@ -12,8 +12,6 @@ typeattribute test_key_sock_t keysockdomain;
> >   # key_socket rules:
> >   allow test_key_sock_t self:capability { net_admin };
> >   allow test_key_sock_t self:key_socket { create write read setopt };
> > -# For CONFIG_NET_KEY=3Dm
> > -allow test_key_sock_t kernel_t:system { module_request };
> >
> >   ################## Deny capability { net_admin } ####################=
######
> >   #
> > @@ -29,7 +27,6 @@ typeattribute test_key_sock_no_net_admin_t testdomain=
;
> >   typeattribute test_key_sock_no_net_admin_t keysockdomain;
> >
> >   allow test_key_sock_no_net_admin_t self:key_socket { create write rea=
d setopt };
> > -allow test_key_sock_no_net_admin_t kernel_t:system { module_request };
> >
> >   ####################### Deny key_socket { create } ##################=
########
> >   type test_key_sock_no_create_t;
> > @@ -50,7 +47,6 @@ typeattribute test_key_sock_no_write_t keysockdomain;
> >
> >   allow test_key_sock_no_write_t self:capability { net_admin };
> >   allow test_key_sock_no_write_t self:key_socket { create read setopt }=
;
> > -allow test_key_sock_no_write_t kernel_t:system { module_request };
> >
> >   ####################### Deny key_socket { read } ####################=
######
> >   type test_key_sock_no_read_t;
> > @@ -61,10 +57,12 @@ typeattribute test_key_sock_no_read_t keysockdomain=
;
> >
> >   allow test_key_sock_no_read_t self:capability { net_admin };
> >   allow test_key_sock_no_read_t self:key_socket { create write setopt }=
;
> > -allow test_key_sock_no_read_t kernel_t:system { module_request };
> >
> >   #
> >   ########### Allow these domains to be entered from sysadm domain ####=
########
> >   #
> >   miscfiles_domain_entry_test_files(keysockdomain)
> >   userdom_sysadm_entry_spec_domtrans_to(keysockdomain)
> > +
> > +# For CONFIG_NET_KEY=3Dm
> > +kernel_request_load_module(keysockdomain)
> > diff --git a/policy/test_policy.if b/policy/test_policy.if
> > index e1175e8..3f163cb 100644
> > --- a/policy/test_policy.if
> > +++ b/policy/test_policy.if
> > @@ -82,3 +82,9 @@ interface(`userdom_search_admin_dir', `
> >       userdom_search_user_home_content($1)
> >   ')
> >   ')
> > +
> > +# If the macro isn't defined, then most probably module_request permis=
sion
>
> Sorry, I should have caught this earlier.  m4 does not do the right
> thing with embedded quotes in comments, so you can get weird effects
> after macro expansion.  I'd expand it to "is not" to be safe.

I see, will do another respin then.

>
> > +# is just not supported (and relevant operations should be just allowe=
d).
> > +ifdef(`kernel_request_load_module', `', ` dnl
> > +interface(`kernel_request_load_module', `')
> > +')
> >
>


--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

