Return-Path: <SRS0=0RAF=DW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8166C433E7
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 14:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CF932075B
	for <selinux@archiver.kernel.org>; Thu, 15 Oct 2020 14:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N/dnBsAS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgJOOMo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 15 Oct 2020 10:12:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41086 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726819AbgJOOMn (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 15 Oct 2020 10:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602771162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1QR8nwxcfJ4eaIVjgWOKT7cM17iWtHQ+hqt3Mhz+uPQ=;
        b=N/dnBsASW8tm2JbFuzhMRvQvKCrW+C230dgRZDRamnT3oe0tnHH478OyNm51jn4e768Z3F
        sfGkTgG0p8qbTsyVu3kxpGAbBrNMT7Bp9Dc+KyiJKXG5gTo+MSgE0G/PuPlA+z7gaS1WUQ
        frq4QqUmBu6jHXjpML/R5IGXk2/ojJ0=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-QmR9CAWgMTmQYfSA1a_NAA-1; Thu, 15 Oct 2020 10:12:39 -0400
X-MC-Unique: QmR9CAWgMTmQYfSA1a_NAA-1
Received: by mail-lj1-f197.google.com with SMTP id r8so1263010ljp.21
        for <selinux@vger.kernel.org>; Thu, 15 Oct 2020 07:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1QR8nwxcfJ4eaIVjgWOKT7cM17iWtHQ+hqt3Mhz+uPQ=;
        b=hmRCwmb2H6MOOnu5LjJEVb+hG6VDL/IqkfecBWS6jw34LKhtn98rnhfTuaAqct+Gsy
         lIVexxH18R1XH2/I3gojEr5AMwSpL6NVeejEg1WsZkvJLMtU9ITAWFD+/Bnb2ebAIhij
         S6KXpSC+tnt//+rZ837iUamVPpkg3s+u25b3+QXKqzECqyoN3ngbJBg/pBrYlaCbDxYT
         5ii+leqV9RgdtKYYgtBQnZRaGzi2OuHUNMNK5q3yl5v9AsOHVRQLFM4whbgGQWLuG+Oq
         qIBnqEGqKC1qoY/HJIKkG9468J0Ko0qjbqlOo/k/WObfQGCxqB8+abWATXHFmupPGc2F
         gwaw==
X-Gm-Message-State: AOAM5325eEjSKcqXDxnqfPSC6YWQ0Jb6WCLIrCM/IKTs03KFhP39WCrj
        GJWVlTPU8zBFnIkpW5RXxBkTRfW5BlmEWUhAFWkOV08bszFjUan0gi/df6ZSlE/0O8AtJ71zXd2
        NDvIh2StSbqj9Vk72S6TILx1kkgxNGlclmw==
X-Received: by 2002:a2e:b009:: with SMTP id y9mr1278070ljk.372.1602771157909;
        Thu, 15 Oct 2020 07:12:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/aOtdtxG4z4awim4clnmwKhed3drJIRXbQ6v4ToN7OYoffFOrIGZeYM79BxNxMlwEd+0AEvuyb0HOCqM+b+s=
X-Received: by 2002:a2e:b009:: with SMTP id y9mr1278061ljk.372.1602771157682;
 Thu, 15 Oct 2020 07:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200922085902.18315-1-richard_c_haines@btinternet.com>
 <CAFqZXNu0KqmZcTTZHOYbz-6tFbSU5Ss=-Y1JUHsmHMEU6jmb-A@mail.gmail.com>
 <3fd9d2c2603b156dacf9c5f5c3c4926dd870fd27.camel@btinternet.com>
 <CAFqZXNveK0C98H8nhYs4_za=ydMX6jtcJ++87-1XUDpO68ygwQ@mail.gmail.com>
 <680d1208ca13571d642824dffd7adbc4d83915d6.camel@btinternet.com>
 <CAFqZXNspQBJeM1v+aExWTc4Hk2+MZ8oFaLCUWANOusboSho2Dg@mail.gmail.com> <d257ed0dcdce297d1aa026773f34d27bc3d6dfba.camel@btinternet.com>
In-Reply-To: <d257ed0dcdce297d1aa026773f34d27bc3d6dfba.camel@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 15 Oct 2020 16:12:26 +0200
Message-ID: <CAFqZXNvSPvhHtKsa7W9HwC66Bvg2NH3tfGyow3QzZJ0C3RJEpg@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] selinux-testsuite: Update SCTP asconf client/server
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Oct 15, 2020 at 3:49 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Thu, 2020-10-15 at 12:28 +0200, Ondrej Mosnacek wrote:
<snip>
> Just a thought - have you tried running the server in one terminal
> session and the client in another (I've plugged in your Fedora 32
> addresses):
>
> cd ...tests/sctp
> echo 1 > /proc/sys/net/sctp/addip_enable
> echo 1 > /proc/sys/net/sctp/addip_noauth_enable
> runcon -t sctp_asconf_params_server_t ./sctp_asconf_params_server
> 10.0.138.59 10.123.123.123 1035
>
> cd ...tests/sctp
> runcon -t sctp_asconf_deny_param_add_client_t
> ./sctp_asconf_params_client 10.0.138.59 1035

Interesting... I just tried it a couple times and it's not behaving
consistently - the first time I got "SCTP_PRIMARY_ADDR: Permission
denied", then 'Dynamic Address Reconfiguration' twice in a row, then 7
times  "SCTP_PRIMARY_ADDR: Permission denied", then 'Dynamic Address
Reconfiguration' 5 times. and then again "SCTP_PRIMARY_ADDR:
Permission denied".

I tried (manually) different delays between starting the server and
starting the client, but there didn't seem to be a pattern.

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

