Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A26C433B4
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 14:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 495C66140A
	for <selinux@archiver.kernel.org>; Wed, 28 Apr 2021 14:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236992AbhD1OM0 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Apr 2021 10:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhD1OM0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Apr 2021 10:12:26 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E53DC061573
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 07:11:40 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id n2so94842411ejy.7
        for <selinux@vger.kernel.org>; Wed, 28 Apr 2021 07:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JKwt2xaH+mKeaOV51kkMnZ6MJ7FYabVX0IWQ8f+rsN4=;
        b=PLDCoTQGq85l4hprRmpB9uYMNtIkEyedO2yGBwPjtcHXH9IFfcuBtVMkVSHWYru1FW
         IMAz60rGF3GtxqT5BZ8p09h2pHS71Ducvx8crK1aLK3Cthl/gSbZGmeCu4qsmjtU7tCR
         /8JwXMRSPl+zsf62GLt6uazj+efm6UddbD7h82C0Gpx8ua+nI7F3qv8lSpWamPLVjtEf
         WNl9rpOCBJDIeI+u9bq9YiZUutxsKXkEeCFOXNkCP8H8OUP4oSYcQrLT8soMWGdLuKEb
         YTNqyywgt/KEZ43wpZf5JWpcFvIMmGx0HMg6qK7RUspd7SdgCY4y5z1j1pYQly0ItDD6
         U51g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JKwt2xaH+mKeaOV51kkMnZ6MJ7FYabVX0IWQ8f+rsN4=;
        b=RUZpV0gNY2uxJWmkQR7uWveRHNe/OwYHeFkPkU/TmvpkWq4GZgd790wR1e0r7ibE64
         GiV94YqeYoQdQ/qui9I8bMbUoC9LeJVryZrzXSwdsVetLKjq52sPDlQ1j+WZPPoCTiIZ
         asjX1XDSNdCGQptn75jEBsMbTRFHzUKm2fFbcEpUDPxCfVTE2K2gfJIiotAiKeEJLNP9
         D5MMW1FDOUr7W6r0lboDgW2+D4LvN0KroWcUgo97G7z47AkadZkHkYG/aeYKWBxsR+oB
         C1U+ukfrNnkbuHrRChefbnbFy5h4I7iWy34A5Im4mpn12991euY25rkLzdhan5WvXw2v
         zh/A==
X-Gm-Message-State: AOAM531xrEqxJ2Th/AsNHG5d053V5JjFOD90hc1PTWd0ccKrdt5Pa5jV
        1IscDH3lMhsy7AmPTsiFIjO7Q/qpNK4JYWlJ401E
X-Google-Smtp-Source: ABdhPJxZwyL/nHr2oVFgPO566OWX8vJuLBS7oA0HCLg+8PF34WxZL5LltakpNwYeN/dcpcrWGn05QPxnbkJdPKEeVMg=
X-Received: by 2002:a17:906:608a:: with SMTP id t10mr29646544ejj.374.1619619098961;
 Wed, 28 Apr 2021 07:11:38 -0700 (PDT)
MIME-Version: 1.0
References: <161955450031.8261.16400002795828868356.stgit@olly> <CAFqZXNtwXv8zydfY=oZLD4Ca5m26Ci9MKmRa184GCLpx919zZQ@mail.gmail.com>
In-Reply-To: <CAFqZXNtwXv8zydfY=oZLD4Ca5m26Ci9MKmRa184GCLpx919zZQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 28 Apr 2021 10:11:28 -0400
Message-ID: <CAHC9VhR3HSjQH1DJ=uHr9JPG=iF6LcvZAq3dD6eFF=8dJfiXhA@mail.gmail.com>
Subject: Re: [PATCH 2] testsuite: fix cap_userns for kernels >= v5.12
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 28, 2021 at 6:54 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Tue, Apr 27, 2021 at 10:15 PM Paul Moore <paul@paul-moore.com> wrote:
> > Starting with Linux v5.12 CAP_SETFCAP is required to map UID 0/root.
> > This is due to kernel commit db2e718a4798 ("capabilities: require
> > CAP_SETFCAP to map uid 0").  In order to resolve this in the test
> > suite allow the cap_userns test domains to exercise the setfcap
> > capability.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  policy/test_cap_userns.te |    3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/policy/test_cap_userns.te b/policy/test_cap_userns.te
> > index ab74325..9683870 100644
> > --- a/policy/test_cap_userns.te
> > +++ b/policy/test_cap_userns.te
> > @@ -12,6 +12,9 @@ unconfined_runs_test(test_cap_userns_t)
> >  typeattribute test_cap_userns_t testdomain;
> >  typeattribute test_cap_userns_t capusernsdomain;
> >
> > +# linux >= v5.12 needs setfcap to map UID 0
> > +allow capusernsdomain self:capability setfcap;
> > +
> >  # This domain is allowed sys_admin on non-init userns for mount.
> >  allow test_cap_userns_t self:cap_userns sys_admin;
>
> Thanks! Would you mind if I move the new rule to the end of the file
> (where other rules for the attribute live) and tweak the subject line?
> The final commit is available for preview here:
> https://github.com/WOnder93/selinux-testsuite/commit/fd4254f09316f6db0410a9187cb8866571f109b5

Sure, do whatever you think is best; you can even replace my little
patch with another that you like better.  My main concern is just
making sure the test suite is fixed and working :)

-- 
paul moore
www.paul-moore.com
