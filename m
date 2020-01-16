Return-Path: <SRS0=jI/q=3F=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 841DFC33CB1
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 16:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51467206D5
	for <selinux@archiver.kernel.org>; Thu, 16 Jan 2020 16:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GD1s3RA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgAPQS0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:18:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38814 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726151AbgAPQSZ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 16 Jan 2020 11:18:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579191504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rgta2NXlR3x8VIeLI60tuhWmGjjsByzwhkGlt+Udrl4=;
        b=GD1s3RA+BO6wFyv2RglyFPYdw28+WGE1B1vh+Mgsbz357dFrghN145Jjf4rgtq5CH+gawT
        VSNsPToZnYDL/6y4Csrzm/duYzpMHnuHWT9b1Bz2Pgzat3IWiGlKYJ4yXJ2U41TCBo6B7B
        +iPSdOt/FDLX3pvCiRyx4brqp2PuShc=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-87WhGeEtPC6IaCy_qJQnvQ-1; Thu, 16 Jan 2020 11:18:23 -0500
X-MC-Unique: 87WhGeEtPC6IaCy_qJQnvQ-1
Received: by mail-ot1-f70.google.com with SMTP id w6so2983261otk.21
        for <selinux@vger.kernel.org>; Thu, 16 Jan 2020 08:18:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rgta2NXlR3x8VIeLI60tuhWmGjjsByzwhkGlt+Udrl4=;
        b=WlWpyJGg+0VWYFa3YDTvtv81D1fJzJ+gtRc2N0FdUHGaBGcBWFhl/V5C0C3zRAFKSS
         nCWwhc+lfch4lypzR5BNn3AqCqILePNjOpzW5R712Wp+s7iz/H8bXcWzmEAGbuBJwdGD
         YUcgk2Idt7nLCt9cCOITy5scPMP3c4Kk47GIo0RLiKdUZzXH+xGl5UyEPqLkCRCcHdL9
         CKd3/zhcqvllEMi1MuOcy8mnNKe4Ikk3hrBdrRXi/qkfMQiUhRgW6DmzfFD87p1UWdPL
         2f4/Kl7uw67BGiGYZTaeoJYxKwgwW4D8qs6KTm8RQphZ6V6Y9zheCSqZrkCWC6v+FOE7
         1N/Q==
X-Gm-Message-State: APjAAAXnOULlGg4QujK+VojOtvMWfrKofdY/sjhggjAkhA+ls7qPZU9J
        4EvIFCwMkYwJwR52ihCAbavotcvwPw4SSM5Gq7ignEE5n9ZQK64Gb8i8qzUHjFEnuT6hEhPwDsE
        BSVGgh3YXP9o986zzQm1vBf4cdNpLOTQ2SQ==
X-Received: by 2002:aca:f555:: with SMTP id t82mr4764231oih.103.1579191502381;
        Thu, 16 Jan 2020 08:18:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZeNzEz0AZNtLTvDXo+e1MbXs8SPSBjCXTyHqB3s4vRJupyhZcqCZXNZb+gZ6tNxaJXZsdqJQXb2XQj5bTa7A=
X-Received: by 2002:aca:f555:: with SMTP id t82mr4764214oih.103.1579191502159;
 Thu, 16 Jan 2020 08:18:22 -0800 (PST)
MIME-Version: 1.0
References: <20200116120439.303034-1-omosnace@redhat.com> <20200116120439.303034-2-omosnace@redhat.com>
 <e2af6353-25a0-30ea-8d81-30ec0d67e7d2@tycho.nsa.gov>
In-Reply-To: <e2af6353-25a0-30ea-8d81-30ec0d67e7d2@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Thu, 16 Jan 2020 17:18:10 +0100
Message-ID: <CAFqZXNuNP8=Q_oeqwU6B=tO-F6FNCJt+-5FaAki0kcx4o+p+xA@mail.gmail.com>
Subject: Re: [PATCH 1/6] selinux: do not allocate ancillary buffer on first load
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 16, 2020 at 5:02 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 1/16/20 7:04 AM, Ondrej Mosnacek wrote:
> > In security_load_policy(), we can defer allocating the newpolicydb
> > ancillary array to after checking state->initialized, thereby avoiding
> > the pointless allocation when loading policy the first time.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> What are these relative to, because they don't apply for me on
> selinux/next?  In particular they conflict with your 'treat atomic flags
> more carefully' patch.

Ah, I forgot to pull latest selinux/next before posting... They should
apply cleanly on top of d41415eb5eda ("Documentation,selinux: fix
references to old selinuxfs mount point"), but they auto-merged
cleanly when git-rebased on top of current selinux/next.

Paul, should I repost the patches or is it OK for you to apply on top
of d41415eb5eda and rebase?

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

