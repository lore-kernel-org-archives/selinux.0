Return-Path: <SRS0=GpsN=BV=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB2BC433DF
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 09:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C84E207DA
	for <selinux@archiver.kernel.org>; Tue, 11 Aug 2020 09:05:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CJgWT+aI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgHKJFa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 11 Aug 2020 05:05:30 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:22285 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728224AbgHKJF3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 11 Aug 2020 05:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597136727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E5eyLlH0SUgW3vGlfGBpsjZNRzVqbafQDRWUP8nf64c=;
        b=CJgWT+aIvUgjsRGTnPZZUE4lL6neM+qtFRx8mDlOxF4ueMH8KJiMvGZwaL1ziJRiGwQGsq
        EV5NXXwoaTnbLVK+gyL+VbT+6p1ECjTf8N5ja+y4EnxMpVPmL7osL8sIQxbS8BFpdFxKNW
        905hS3QAGCFVBfNkboMI1rz5f6cLi3A=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-9PCMQqOBPsKRagrPZuoIFg-1; Tue, 11 Aug 2020 05:05:26 -0400
X-MC-Unique: 9PCMQqOBPsKRagrPZuoIFg-1
Received: by mail-lf1-f69.google.com with SMTP id w21so3904130lfk.1
        for <selinux@vger.kernel.org>; Tue, 11 Aug 2020 02:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=E5eyLlH0SUgW3vGlfGBpsjZNRzVqbafQDRWUP8nf64c=;
        b=tLOXNNP9N02u15+2JF0Xj04gw3Hepn3aCNq15QuRWxL1Hxr3y9k0IhGM9i9qsXUemM
         qvee+w1Qd9FoVputc3KvUbQyFpH8skg+yNRSlx8pPPmIocgs//J2V4hDD+TsbCo7NA4F
         3dIeWgj7ud8yTakC9HogYtwmjLdaFd0TqxsOGmkWu35YAK+lIDhEikFqT43W2sve5Zg8
         llFpDRmP7iwtAt50iUWD2vmmSLdugdWwRPguy4Ytns7S9yK88suS52nqs4L4/Tg07AyH
         eFMNMh/ckwgiG1Y0Y77hV2fasA/RfdDZOPn4HZpjIU6T65T25YM3b76o5i9zOL5+zbHV
         auuw==
X-Gm-Message-State: AOAM532eyJt6GoZrk1yHTRpEr9KI9erm9Ee4gG1s5h3SbEytbt50vWqg
        i87fJvOO48mTxYALBMAg2WgajAJeMCgB/WIFLe0kV3pJ5/VJuPrHgZUEdRBJO6BZduNaU+g437L
        ilHb3pM+Z+c7gcWAYUZB4tm0xcRfUUY3+7w==
X-Received: by 2002:a2e:86da:: with SMTP id n26mr2694222ljj.311.1597136724523;
        Tue, 11 Aug 2020 02:05:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPwLBIoGduzddOucFde4yP3SoO5Gb27ZU6UH3fMAbIspXKBOvcFZO7GePNfULiL6ieXwhu9z8L+FVDMjUfuFI=
X-Received: by 2002:a2e:86da:: with SMTP id n26mr2694212ljj.311.1597136724272;
 Tue, 11 Aug 2020 02:05:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200811084555.105374-1-omosnace@redhat.com> <20200811084555.105374-2-omosnace@redhat.com>
In-Reply-To: <20200811084555.105374-2-omosnace@redhat.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 11 Aug 2020 11:05:10 +0200
Message-ID: <CAFqZXNsZU+uwnF2zu+cQSV5jzvDsx_u_FFcWWOx6YW0we583MA@mail.gmail.com>
Subject: Re: [PATCH testsuite v2 1/2] README: add perl-lib as a dependency
To:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 11, 2020 at 10:45 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> The `lib` perl module has been split out of the `perl-interpreter`
> package in Fedora 33 into `perl-lib`. It is needed for the filesystem
> tests. Add it to the dependencies.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  README.md | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/README.md b/README.md
> index ff0a0dc..bfd5b17 100644
> --- a/README.md
> +++ b/README.md
> @@ -45,6 +45,7 @@ similar dependencies):
>  * perl-Test  _(test harness used by the testsuite)_
>  * perl-Test-Harness _(test harness used by the testsuite)_
>  * perl-Test-Simple _(for `Test::More`)_
> +* perl-lib _(for `lib`; split out from `perl-interpreter` since Fedora 33)_
>  * selinux-policy-devel _(to build the test policy)_
>  * gcc _(to build the test programs)_
>  * libselinux-devel _(to build some of the test programs)_
> @@ -65,6 +66,7 @@ following command:
>         # dnf install perl-Test \
>                 perl-Test-Harness \
>                 perl-Test-Simple \
> +               perl-lib \

Note that this package doesn't exist on the earlier versions, so the
command will now work verbatim only on F33+... I'm not sure if we want
to add --skip-broken (might silently skip necessary packages in case
of dependency problems in the repos) or just leave it be.

>                 selinux-policy-devel \
>                 gcc \
>                 libselinux-devel \
> --
> 2.26.2
>

-- 
Ondrej Mosnacek
Software Engineer, Platform Security - SELinux kernel
Red Hat, Inc.

