Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41207C43334
	for <selinux@archiver.kernel.org>; Fri,  1 Jul 2022 01:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232487AbiGAB60 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jun 2022 21:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiGAB6Z (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jun 2022 21:58:25 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835CB13F8E
        for <selinux@vger.kernel.org>; Thu, 30 Jun 2022 18:58:24 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id cu16so2520677qvb.7
        for <selinux@vger.kernel.org>; Thu, 30 Jun 2022 18:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bigbadwolfsecurity-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Z3+6HE5tKbHDXOCNbP82c2ENcTXyrR62K2AQCDbcClA=;
        b=UWHL2kCgeaDGy71YCANeMIz6W9R8aBceAw5qMbDO7qqF2xDTl8vRyrJlmueGVz8mTl
         f9NAlEu5kl6DQgmXAIHkjHPXo4lQxHuI31IRgpFnIb9q6J6ywMM+PBUJlGgUINZUpgR/
         2LYFL23Gf+0WOUQeVX9A87JSQmKA71Dg25LlUuF6P8tcLfC+ZaeaBLPSP9Gf93NM/gur
         gjG1e9bqokOMlfL85l8pUSw3WRViA9HblKjBsCR4zxL3iOwp8OLCSZ5R7JQ1tsyGRac3
         b5xNT5EUuBhGG0XgIlM1rtnHl3gYF43OnA/Z1edvKScEQ41edrz/wxsRYHGV+KkLD8fC
         NCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Z3+6HE5tKbHDXOCNbP82c2ENcTXyrR62K2AQCDbcClA=;
        b=1NDgYnkgPkFTinmsT48rdqKPQdNxxLdnLyakZEN2AnxHGxi0D4isdsCPEZyMgQAAL3
         DPJTEAZlkYBFI2wrryFcG9osoHsTNBovoslOgPqQU4oDf4/dJJhT+/JU5RYR+KeWt3Rh
         oZFHgqBYgC3El4yYvjNDofL4K1cLtWEdCOBrBHnxcAVEpfeTqKBPBT6dV3ghb3i1aDqD
         OxvrFV72T3Ik84GqOgYcWGEcrETCMiVl7p0Pe7RXUPN96GRNXhYJO0gPzVnN+JZw+uSC
         tyRBUge4m77mZVOJaSYYuL2s+T42bVVtA+MB1teTgWQPM3GclCvUDnbQ9uNLlmU1/P4l
         GSoA==
X-Gm-Message-State: AJIora+9S6CNaKEuR/3eWxeBFDCIiEkJMI57bFd+/2RhSfUkZpXRKvzf
        NmoIvEwL9fFwudlFDZgxl4v5MND6+pwAxYSVAFEs9wHd1ugvLg==
X-Google-Smtp-Source: AGRyM1u32BkX2uC8ssoJ7B3tUNArxEKvd+4VGHcdZb5SEYHAF82lNsLq7IfhiPK+I8pv6DWIx2Jer8PqI6a5Lz1+EwA=
X-Received: by 2002:ac8:5e0c:0:b0:31b:f290:d048 with SMTP id
 h12-20020ac85e0c000000b0031bf290d048mr10793986qtx.66.1656640703462; Thu, 30
 Jun 2022 18:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfZ7=mP2eJaq2BfO3y0VnwUJaY2cS2p=HZMN71z1pKjzaT0Eg@mail.gmail.com>
In-Reply-To: <CAJfZ7=mP2eJaq2BfO3y0VnwUJaY2cS2p=HZMN71z1pKjzaT0Eg@mail.gmail.com>
From:   Karl MacMillan <karl@bigbadwolfsecurity.com>
Date:   Thu, 30 Jun 2022 21:58:13 -0400
Message-ID: <CA+EEuAiG1B8i1xTt+K1QO1UPgynZVYiRkiLTY6nTVi9Rm4uA1A@mail.gmail.com>
Subject: Re: What is "fscon" statement in a base policy?
To:     Nicolas Iooss <nicolas.iooss@m4x.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

Hi Nicolas,

I believe these are described on page 19 of the old "A Security Policy
Configuration for the Security-Enhanced Linux" [1]. There is still
support for these in the kernel [2], so it seems unwise to me to drop
them even if they are not used in policies. Good catch though!

Karl

1. https://media.defense.gov/2021/Jul/29/2002815735/-1/-1/0/SELINUX-SECURITY-POLICY-CONFIGURATION-REPORT.PDF
2. https://github.com/torvalds/linux/blob/master/security/selinux/ss/policydb.h#L228

On Thu, Jun 30, 2022 at 5:05 PM Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
>
> Hello,
>
> While studying some malloc calls in libsepol and checkpolicy, I
> stumbled upon function define_fs_context(), which allocates a
> fixed-size buffer in
> https://github.com/SELinuxProject/selinux/blob/956bda08f6183078f13b70f6aa27d0529a3ec20a/checkpolicy/policy_define.c#L4631-L4637
>
>     newc->u.name = (char *)malloc(6);
>     if (!newc->u.name) {
>         yyerror("out of memory");
>         free(newc);
>         return -1;
>     }
>     sprintf(newc->u.name, "%02x:%02x", major, minor);
>
> As major and minor are unsigned int (so 32-bit integers) without any
> value checking, there seems to be a possible heap buffer overflow
> issue. This function is called when parsing a fscon statement in a
> "base" policy. So I copied tmp/base.conf from a build of the Reference
> Policy, added "fscon 1000 1000 system_u:object_r:unlabeled_t
> system_u:object_r:unlabeled_t" right after "sid security
> system_u:object_r:security_t" (the order of the statements matters),
> and ran:
>
>     $ checkpolicy -o test.pol base.conf
>     *** buffer overflow detected ***: terminated
>     Aborted (core dumped)
>
> For whatever it's worth, the stack trace of this abort tells that the
> buffer overflow occurs in a call to __sprintf_chk(): my gcc compiler
> seems to be "smart enough" to find out that the size of newc->u.name
> was 6, and it replaced sprintf() with __sprintf_chk() to ensure that
> the buffer was not written past its bounds.
>
> Now, I can submit a patch to fix this issue, for example by replacing
> malloc()+sprintf() with asprintf() and by checking that major and
> minor are below 256. But before doing so, I was wondering: what is
> this fscon syntax? I have never encountered it, did not find any
> policy using it, and I am wondering whether we could instead drop its
> support and remove function define_fs_context() from checkpolicy.
>
> Thanks,
> Nicolas
>
