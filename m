Return-Path: <SRS0=ftCu=3G=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34E0C33CB3
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 20:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3C420748
	for <selinux@archiver.kernel.org>; Fri, 17 Jan 2020 20:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqSJeTCd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgAQU0K (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Jan 2020 15:26:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21525 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727519AbgAQU0K (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Jan 2020 15:26:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579292768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nkg1urOgFy0Bp6ya4shdMEFBA/+8nDpQZs5KwBPxp0A=;
        b=eqSJeTCdmfK70ZTwGGrhbyfby3eQYusccU5KTc5kyaFRL1mi/pH5LhTEs5CArtKEYn0eTn
        Le6XlvCDq6XXZBE5dSpzi54SA7dq9E0ayKr48dDrzOf87HOtRGGjhpoBeEXyilCFkxH3RP
        HQS1KOyOH4ln1O9+FG5yPaMuDnf6u9w=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-YwHRkTB9NOiJZiLXTa9zWg-1; Fri, 17 Jan 2020 15:26:04 -0500
X-MC-Unique: YwHRkTB9NOiJZiLXTa9zWg-1
Received: by mail-oi1-f199.google.com with SMTP id w205so10084990oie.13
        for <selinux@vger.kernel.org>; Fri, 17 Jan 2020 12:26:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nkg1urOgFy0Bp6ya4shdMEFBA/+8nDpQZs5KwBPxp0A=;
        b=abhJ0MHci2tHSLIeu2MhlGI4vBL7XVX7pehQzqT+L+hhRGW2KkOE2dFNvV0FAj1pMa
         mXGfYM2Yu7bkI+Cc4juNNFOowDepFhb0m79dsj13UccnbSxlbBh5uKAetycwvlD2Nmp/
         1nst017S3HsZkVsTvuo2T5jHoJGM9mPO/DS9LWybeC/OaNUprgRpZoyN4tZbg4rG+cN+
         YRVF1kL6pRumlDVR6FRx3iM5HOxjmTPA2MulmghusucHwpRoxb4ypFXc5YoqcFdBbmCt
         RXoCvM78dq2cbRo7smpJR73hoAED4jnZQyynvYQnVxHBbH0VjWbGvpNadYLME++aic1G
         +RLg==
X-Gm-Message-State: APjAAAV2js6U5bR2ytT4pBMR+QCqK+gOMi5OEiDK3JuOnCWET9jvFXZf
        XigMsEHHiLvWJQUXKKE9mQVSWxOZaHuA8jf2OW8MFpW75bMTes+PYW1TDB3W5II83PzntfAqTFb
        rQYei82P36wBSzcNZW4msqWTf8Ai7hNYhVQ==
X-Received: by 2002:a9d:53c2:: with SMTP id i2mr6989235oth.43.1579292763833;
        Fri, 17 Jan 2020 12:26:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqwoeNpsxVU+DYPiWWBakysmPeBCoFFCKP5/zrmOU6z7mTHtyJ8CmwjG8KEbvjubbRSCxqlnQuse3jFHpOqaku4=
X-Received: by 2002:a9d:53c2:: with SMTP id i2mr6989218oth.43.1579292763525;
 Fri, 17 Jan 2020 12:26:03 -0800 (PST)
MIME-Version: 1.0
References: <20200116185127.169628-1-richard_c_haines@btinternet.com>
 <20200116185127.169628-2-richard_c_haines@btinternet.com> <69846679-c87b-875c-d78d-91cf6aeae5e2@tycho.nsa.gov>
 <0556d72199ca519fa295449bce6aabc51061c486.camel@btinternet.com>
In-Reply-To: <0556d72199ca519fa295449bce6aabc51061c486.camel@btinternet.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 17 Jan 2020 21:25:52 +0100
Message-ID: <CAFqZXNv6AEK9=+e3Gc_9TK3UhQPqFLu0jzwAPebqpSgzvFCsDg@mail.gmail.com>
Subject: Re: [PATCH V6 1/1] selinux-testsuite: Add filesystem tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jan 17, 2020 at 7:22 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
> On Fri, 2020-01-17 at 12:32 -0500, Stephen Smalley wrote:
> > On 1/16/20 1:51 PM, Richard Haines wrote:
> > > Test filesystem permissions, setfscreatecon(3), file { quotaon }
> > > and
> > > changing file context via non and name-based type_transition rules.
> > > The name-based rules only apply to MOD_POL_VERS=>11 and
> > > POL_VERS=>25
> > >
> > >  From kernels 5.5 filesystem { watch } is also tested.
> > >
> > > Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> >
> > This passes travis-ci and testing on Fedora and generally looks good
> > to
> > me.  Only question I had was whether we should be checking the
> > kernel's
> > max supported policyvers (/sys/fs/selinux/policyvers,
> > MAX_KERNEL_POLICY
> > in the policy Makefile) as well as that of checkpolicy/checkmodule,
> > because otherwise the policy might compile ok but the name-based
> > transitions will be discarded upon automatic downgrade at policy
> > load
> > time and the tests will fail.
>
> Ok I'll fix that.
>
> Ondrej - Does this work on RHEL-6. Checking just in case it fails so I
> can include any further fixes in next patch.

Yes, it passes on RHEL-6 now, thanks!

-- 
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

