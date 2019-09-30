Return-Path: <SRS0=KDcg=XZ=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F3DC32792
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 14:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B494215EA
	for <selinux@archiver.kernel.org>; Mon, 30 Sep 2019 14:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkbHaxdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730902AbfI3OWI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 30 Sep 2019 10:22:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45190 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730809AbfI3OWI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 30 Sep 2019 10:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569853327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fYQbyM2o0ha5YbChDH42sXnvCrnLreQ6vfJzi+NbOLM=;
        b=dkbHaxdSmnEbStk1rPekyHELfEntlz1FPKjgZ62RLcgqMWDGA6f1fV+dA5DJNBBLze5KPo
        VgLVPyQnRqFwx+2rgylC2ZAKr3bbYWd3Lrb0NO3VUT41raF1pitPensQyHuqhdfeg+vJoO
        iSWlDwp6qpzIEspTOVPKcpg03UFmf+o=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-5rLirV-NMreUcp3NJ71ThA-1; Mon, 30 Sep 2019 10:22:03 -0400
Received: by mail-oi1-f200.google.com with SMTP id k185so7299199oih.1
        for <selinux@vger.kernel.org>; Mon, 30 Sep 2019 07:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mwa3Vy9MWCmiKA7s7vvQVbsZ26MU9rdKstbPRCHuaZA=;
        b=rBLtUlHlLgMDnAuxI1+xgubymGrCyUJsyjM01l58/k9MqooRvbo+yZJkpozEm/rt05
         FBefnb75im5oZTuB0q4OGzfqgnJSv/FKj57i5WFLXFKvaSFQX2wY7mC38v5rl0R+9WhA
         kvrXkOaathalI9t7IILOXTgP7TCd72hDApMUTXMknsdIVWyLjkk2Lc6sfi7l0rC0jd2C
         kP0OcRLw/9msRxCI7BhWthCxcrZTRPX7oGS0Szo8HhI+ychZbjji2XyYhScAguR/lnQH
         0Lc1qV0S8R+1IwuzZnCpEVKuu+4TsJ16lXOlOb6wiXO7ZZIqBmPcF8B9MTU9KDWyGbGo
         n0Vw==
X-Gm-Message-State: APjAAAX+2hQFex7zs5GaLqPSqusRouqf3P2gJ3e20f4Sm7ApGz76U18O
        io7Ux68phcRhO2TNJuJaWe4/4htnrfsJRbb4DJqg226cSnIc1KEkl4IuCSph6ezudYyvp+XgbmD
        Rk5qY3rtAHKUjDSfl/M2LXEdz3iemma/UYg==
X-Received: by 2002:aca:e046:: with SMTP id x67mr18696549oig.156.1569853322693;
        Mon, 30 Sep 2019 07:22:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxk9P+ACA57lZy9b6uWRbjD4CvCRMCkgK8VL1TLOoaWfZdDdpX20P+wGRrm2swO3kPG5pMelwzsbNegLD+lvlo=
X-Received: by 2002:aca:e046:: with SMTP id x67mr18696530oig.156.1569853322448;
 Mon, 30 Sep 2019 07:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190930104850.5482-1-omosnace@redhat.com> <20190930104850.5482-3-omosnace@redhat.com>
 <c7521035-8608-c24e-4056-c58aa02de387@tycho.nsa.gov>
In-Reply-To: <c7521035-8608-c24e-4056-c58aa02de387@tycho.nsa.gov>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 30 Sep 2019 16:21:51 +0200
Message-ID: <CAFqZXNtngrXcMkY9XoPMo6WjcMgUfqD04iiD8nhdrezyKErerA@mail.gmail.com>
Subject: Re: [PATCH testsuite 2/3] policy: add fallbacks for Fedora-specific macros
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     SElinux list <selinux@vger.kernel.org>
X-MC-Unique: 5rLirV-NMreUcp3NJ71ThA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 30, 2019 at 3:32 PM Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 9/30/19 6:48 AM, Ondrej Mosnacek wrote:
> > dev_rw_infiniband_dev() and mount_rw_pid_files() are not defined in
> > refpolicy. Fall back to dev_rw_generic_files() and
> > mount_rw_runtime_files() if they are not defined.
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >   policy/test_policy.if | 14 ++++++++++++++
> >   1 file changed, 14 insertions(+)
> >
> > diff --git a/policy/test_policy.if b/policy/test_policy.if
> > index 40e7499..e31345e 100644
> > --- a/policy/test_policy.if
> > +++ b/policy/test_policy.if
> > @@ -71,3 +71,17 @@ interface(`userdom_search_generic_user_home_dirs', `
> >       userdom_search_user_home_content($1)
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
>
> dev_rw_infiniband_dev allows access to character and block devices
> labeled infiniband_device_t.  dev_rw_generic_files() allows access to
> _regular_ files labeled device_t. dev_rw_generic_chr_files() and
> dev_rw_generic_blk_files() would be the equivalent interfaces.
> Alternatively, we could wrap the calls in the test_ib*.te files with
> ifdefs as we do for e.g. corenet_ib_pkey and other interfaces.
> Regardless, I don't think the infiniband tests will presently work on a
> system with only refpolicy.

Fair enough, I'll switch to
dev_rw_generic_chr_files()+dev_rw_generic_blk_files(). I think it is
better to have the workaround in the common interface, as it will be a
bit easier to remove/change it in the future.

>
> > +
> > +ifdef(`mount_rw_pid_files', `', ` dnl
> > +interface(`mount_rw_pid_files', `
> > +    mount_rw_runtime_files($1)
> > +')
> > +')
> >
>

--=20
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

