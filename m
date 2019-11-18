Return-Path: <SRS0=s9so=ZK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B361EC432C0
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 14:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A4F02075E
	for <selinux@archiver.kernel.org>; Mon, 18 Nov 2019 14:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OTuZ9IV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfKROaI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 18 Nov 2019 09:30:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26175 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726654AbfKROaI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 18 Nov 2019 09:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574087406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zdl0iC3viBhrFMwarr8KMmkr3A8Bi8VYHUWl9URB9o4=;
        b=OTuZ9IV/KxxVcM7j7Kto04xeKlUiM9BCQrSFvBWjCk0+qll1gfC3ScdkJrAdFDyRiLmAzc
        +E37A9vjgSUsSAabL1XVU8ymOe0j3bZRaPRq3C9kl70DTbb7nkyiWF5qivZXFQYirVQ8aI
        NoOgO2LiB38mBVxB4MqLZwGeKz9CMkg=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-2bK-o_nnM0egtGSLHvEYUg-1; Mon, 18 Nov 2019 09:30:00 -0500
Received: by mail-ot1-f69.google.com with SMTP id l1so10176389otr.2
        for <selinux@vger.kernel.org>; Mon, 18 Nov 2019 06:30:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NBOZN47JJ3s3lWyCnbfwXxoGJ3oczbdheq22dX1tQS8=;
        b=ufkC+LufXE7C3DFqXlR1yDlEvNaNCjJ1ext+EnSfkuNiDfOyfS6MJwNswRzjTgrjB2
         c5KQF9tl0UmWHxXTH6IKtFgRyOfEZHBbbzHyK8sljoBfs4X/dWhmkcpBFcjIv8qJ5s45
         82cfRiKqpVcuthj44xCNVswqC5QiN6Of8wSaRphbA4L4SW1Jp7zWA8GKbpBRHIEEVubn
         aMQAN/HMRgBXaBl9bHM59ul33kA4k8C335/XY2/QK5AhbF26DtVUlZcSp51NclK/Yfz2
         I+JZNiJhVBAjnE5bVsSSgVUKNGc6B7ruj/Z7WR3KiP77Z4UgjNB0tJ3dZVM2AbRdf6Pg
         sujw==
X-Gm-Message-State: APjAAAUXKv+dKHsilb+Bf9zc3E/d/XwsCWVKM7n0tSCT8HSp1rOMAp3/
        SI+Jy2NuwnNeSBdvTjg3Hep50wPRchJPIWV/Zx6l5A5I8fbUp6qPmF1mQB728dkGikChSyDi3EA
        Q8dqj/BtUg8IS7KMDggiQlMO2VNb5iG8jdQ==
X-Received: by 2002:aca:7595:: with SMTP id q143mr21376747oic.103.1574087399933;
        Mon, 18 Nov 2019 06:29:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqxiRaddUCHUfPZPNUsydHBqxCV11NSYqkaFcfLnFAuHDJWdI2vdFFbbJXMwyZvt33HTL3Bx+Z0Z9SFtxq0ZS8k=
X-Received: by 2002:aca:7595:: with SMTP id q143mr21376715oic.103.1574087399551;
 Mon, 18 Nov 2019 06:29:59 -0800 (PST)
MIME-Version: 1.0
References: <20191118123056.338496-1-omosnace@redhat.com> <20191118123056.338496-3-omosnace@redhat.com>
 <90518acb-e642-44a3-3ad1-7937d04f2a5e@tycho.nsa.gov>
In-Reply-To: <90518acb-e642-44a3-3ad1-7937d04f2a5e@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 18 Nov 2019 15:29:50 +0100
Message-ID: <CAFqZXNvOTfFLa97moEpO4tjkYPZPPq3ZOesx22Co7uLCQ38v3w@mail.gmail.com>
Subject: Re: [PATCH testsuite v3 2/3] policy: add fallbacks for
 Fedora-specific macros
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
X-MC-Unique: 2bK-o_nnM0egtGSLHvEYUg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 18, 2019 at 3:06 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 11/18/19 7:30 AM, Ondrej Mosnacek wrote:
> > dev_rw_infiniband_dev() and mount_rw_pid_files() are not defined in
> > refpolicy. Fall back to dev_rw_generic_files() and
> > mount_rw_runtime_files() if they are not defined.
> >
> > Also, userdom_search_admin_dir() is not defined in refpolicy because it
> > doesn't have admin_home_t. Fall back to
> > userdom_search_user_home_content(), which should apply for root's home
> > directory under refpolicy.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>
> Is there a reason you didn't make the changes I suggested to
> dev_rw_infiniband_dev()?

No, sorry, I forgot to address that part... again :|

>
> > ---
> >   policy/test_policy.if | 21 +++++++++++++++++++++
> >   1 file changed, 21 insertions(+)
> >
> > diff --git a/policy/test_policy.if b/policy/test_policy.if
> > index 939cd7e..38214a9 100644
> > --- a/policy/test_policy.if
> > +++ b/policy/test_policy.if
> > @@ -60,3 +60,24 @@ interface(`userdom_sysadm_entry_spec_domtrans_to',`
> >           allow $1 sysadm_t:process sigchld;
> >   ')
> >   ')
> > +
> > +# Workarounds for refpolicy:
> > +
> > +ifdef(`dev_rw_infiniband_dev', `', ` dnl
> > +interface(`dev_rw_infiniband_dev', `
> > +    dev_rw_generic_files($1)
> > +')
> > +')
> > +
> > +ifdef(`mount_rw_pid_files', `', ` dnl
> > +interface(`mount_rw_pid_files', `
> > +    mount_rw_runtime_files($1)
> > +')
> > +')
> > +
> > +# Refpolicy doesn't have admin_home_t - assume /root will be user_home=
_dir_t.
> > +ifdef(`userdom_search_admin_dir', `', ` dnl
> > +interface(`userdom_search_admin_dir', `
> > +    userdom_search_user_home_content($1)
> > +')
> > +')
> >
>

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

