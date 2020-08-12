Return-Path: <SRS0=FvZo=BW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC623C433E0
	for <selinux@archiver.kernel.org>; Wed, 12 Aug 2020 16:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9798420829
	for <selinux@archiver.kernel.org>; Wed, 12 Aug 2020 16:21:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="jv22c9Vb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgHLQVq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgHLQVp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Aug 2020 12:21:45 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8047FC061383
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2020 09:21:45 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id s16so1896961qtn.7
        for <selinux@vger.kernel.org>; Wed, 12 Aug 2020 09:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=j/SJ1QNF721OCJDQxwhmGTboz8gjASekmj3CeXptboA=;
        b=jv22c9Vbu3d5In9U3Mzu3B7e9sC6hfhrPe91XZ6rIfPrPf/fu/m3oMhbzCFu8b6KFd
         FhKYKrt1Tu7GZEC6W6/pPZBImTKjp7J6J6ouTohZ62DVCmA8tOq9jMmjnHCUfGIN2s2k
         YAFSkBtVL+42Wuh/h6h4zUNGtRDg23xd2rFrACH2hNj8Hs7UGm5Y6GI+Wp8P5WxJomOP
         JFQp4JScxNaCmv8EM7EyvQg4aNc9DPVrgf9pIRfDv/Mmqjp4EzJAQVSRcdsoGNhZIamW
         oAeCstdVS3O2TKMQW+QjHKzEk8iuNLHFxJ4LVi17fArAyF1qAc23n/70GWgqeThYS+fu
         CfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=j/SJ1QNF721OCJDQxwhmGTboz8gjASekmj3CeXptboA=;
        b=rethpr7d8tYOT7rYEsBTVCNOSxV6sbO+ik1o+xzw1OnlR95qIvQKbAbeUiR7yBL8vo
         ukxuvcy4IyM65HC76CiyV1l514d0jHjdssOW7UlnVyGMPJ7oBrkRh1iltBEAjcJqDjSo
         8/s1MM7KrhXfeQe08TiKjEb5DNdNbU23GTgFALNvzWW2AVPgExwU6ugP24QuotDBHctI
         qhKcOABiyG/nc4M+gKl4lQmtQjtikPnR25fO/vfjOWE+RuaODxc02xmAheLgMkw8Oxlo
         VkVC7NrkH57XVd5PRRag7bIcpjfMU9O2vcCOICe6kd0QFZg7SNqlOaCMierq5TID9KkJ
         EQbw==
X-Gm-Message-State: AOAM530O2knHqxy0Wh5bYOMaohugiQOtKxKz3gHePGilLIGHi44Qu3+P
        MEX5iQBkULO0d9Fon+4gDVHgkTw/sSLF
X-Google-Smtp-Source: ABdhPJywgdIyX5+r2zEetcPaK7n4gQrHKHUdT0qXeCqAUiQSRRuVIu/493n84kKS7ZTIsRJBrtlucQ==
X-Received: by 2002:aed:3387:: with SMTP id v7mr400660qtd.318.1597249304568;
        Wed, 12 Aug 2020 09:21:44 -0700 (PDT)
Received: from [10.0.0.46] (c-24-91-201-67.hsd1.ma.comcast.net. [24.91.201.67])
        by smtp.gmail.com with ESMTPSA id k31sm2870834qtd.60.2020.08.12.09.21.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Aug 2020 09:21:43 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     Ondrej Mosnacek <omosnace@redhat.com>
CC:     SElinux list <selinux@vger.kernel.org>
Date:   Wed, 12 Aug 2020 12:21:40 -0400
Message-ID: <173e37a2620.27df.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <CAFqZXNs=Q0+ikxAxnDqj8KeVygiswW0878wg51Q=2T7_v-jq0w@mail.gmail.com>
References: <20200811084555.105374-1-omosnace@redhat.com>
 <20200811084555.105374-2-omosnace@redhat.com>
 <CAFqZXNsZU+uwnF2zu+cQSV5jzvDsx_u_FFcWWOx6YW0we583MA@mail.gmail.com>
 <CAHC9VhTGHgZu4pcAVVOUGX4yegyD8uNg85UrjG8Jtzc4=AsDVQ@mail.gmail.com>
 <CAFqZXNs=Q0+ikxAxnDqj8KeVygiswW0878wg51Q=2T7_v-jq0w@mail.gmail.com>
User-Agent: AquaMail/1.25.2-1672 (build: 102500008)
Subject: Re: [PATCH testsuite v2 1/2] README: add perl-lib as a dependency
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

I was thinking of something that stood out more, I worry the simple note in=
 the package list won't be noticed or read.

--
paul moore
www.paul-moore.com
On August 12, 2020 10:27:49 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:

> On Tue, Aug 11, 2020 at 5:11 PM Paul Moore <paul@paul-moore.com> wrote:
>> On Tue, Aug 11, 2020 at 5:05 AM Ondrej Mosnacek <omosnace@redhat.com> wr=
ote:
>>> On Tue, Aug 11, 2020 at 10:45 AM Ondrej Mosnacek <omosnace@redhat.com> =
wrote:
>>>> The `lib` perl module has been split out of the `perl-interpreter`
>>>> package in Fedora 33 into `perl-lib`. It is needed for the filesystem
>>>> tests. Add it to the dependencies.
>>>>
>>>> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
>>>> ---
>>>> README.md | 2 ++
>>>> 1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/README.md b/README.md
>>>> index ff0a0dc..bfd5b17 100644
>>>> --- a/README.md
>>>> +++ b/README.md
>>>> @@ -45,6 +45,7 @@ similar dependencies):
>>>> * perl-Test  _(test harness used by the testsuite)_
>>>> * perl-Test-Harness _(test harness used by the testsuite)_
>>>> * perl-Test-Simple _(for `Test::More`)_
>>>> +* perl-lib _(for `lib`; split out from `perl-interpreter` since Fedor=
a 33)_
>>>> * selinux-policy-devel _(to build the test policy)_
>>>> * gcc _(to build the test programs)_
>>>> * libselinux-devel _(to build some of the test programs)_
>>>> @@ -65,6 +66,7 @@ following command:
>>>>    # dnf install perl-Test \
>>>>            perl-Test-Harness \
>>>>            perl-Test-Simple \
>>>> +               perl-lib \
>>>
>>> Note that this package doesn't exist on the earlier versions, so the
>>> command will now work verbatim only on F33+... I'm not sure if we want
>>> to add --skip-broken (might silently skip necessary packages in case
>>> of dependency problems in the repos) or just leave it be.
>>
>> I agree that '--skip-broken' is probably not the best choice for the
>> reasons you already mentioned.  I might suggest that if the package is
>> not present in all of the supported versions of Fedora we should add a
>> note to the README.md explaining that.  Once the older versions become
>> unsupported the note can be removed.
>
> There is already a note in the other line added. Or did you have
> something different in mind?
>
> --
> Ondrej Mosnacek
> Software Engineer, Platform Security - SELinux kernel
> Red Hat, Inc.



