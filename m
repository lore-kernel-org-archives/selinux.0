Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378FEC7618E
	for <selinux@archiver.kernel.org>; Mon, 24 Apr 2023 19:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjDXTCe (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Apr 2023 15:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjDXTCd (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Apr 2023 15:02:33 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A546184
        for <selinux@vger.kernel.org>; Mon, 24 Apr 2023 12:02:32 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-504efe702d5so7105280a12.3
        for <selinux@vger.kernel.org>; Mon, 24 Apr 2023 12:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682362951; x=1684954951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6lrmicIeHGL0qo57xssdswircD9/1VajNoyUNT0Llo=;
        b=fT+Vtna3ewXA8l0tz36UZKtI06+7YIQa3GTs1+uzQcp3u0Iut3BfQzd1jurar5i7HZ
         jyYlb1BTU5CxeGTBhSn1Zc//dmapnbD5sVhrt9L8f/Vu1xWAOKzvt9Tp+xVRIuruZinq
         MC1qW9MoPUdHKCyPZwP8Z9h4qPyg9kaB2HhMLdzDiqLYJd+ejGnqvpXWGWAjZ4jgR8CL
         iMLEwlU08Tfqguo+eOMlyI+pdkQuGZnjORYYoUgzNLVCncxap25+DyJzJ91Wp4EOBgcG
         ENAYSGv0zFsaqI7Z4pXmzZ9awSPEs74iaVppoKvfNXL05zCVsPreJRYMWyD/fmvjLh+S
         Kbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682362951; x=1684954951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6lrmicIeHGL0qo57xssdswircD9/1VajNoyUNT0Llo=;
        b=BnIKy8yN75IVC+xIZelZMvCb+Ez6y5wpt7DLqQDXSv9WCaOX047sYU4hYnuq6ZW4z+
         O65All2Q/I9EWSoiD6/1tZsjjlMByNj+QgKCP77Xply8DOJp3Z7iAgMGcFJxpSUrjgk3
         fcf6lETTZr27SX+WcCJOyhaJIaLkeSD0PDN9HEhbgIyL0JjtiByRxFWM3Lcw2Lb3UrZV
         oAYv+7Kj8WQWiB35w53f4Hv9bFSfGkEUsxEVRj4kaIl8C/g0IyO4TI7JfWlSbjd4sa6+
         P9NDEyZWtvDaPjcvhnoQYCNoCDsBH+a9G5knvxN9y6WFr6j74eZ72oeCieCgmcovCOgA
         Ffmg==
X-Gm-Message-State: AAQBX9fuoaNeO9DDTjcPeewiXh8+zEaZMDZbgrn7Xa8kUdJ0ONiyughk
        CmfmBZOpBbHkh77cppuEuS0rvollFGlwiPCKnljOTCXG
X-Google-Smtp-Source: AKy350aYediU8mlgyTUrp32FKpR8EHfsW8kOnH2kA/THanN/OnUV3WzH2+EmksKFFHqqVf1sEHVY3pwkbOdsOsfdiFE=
X-Received: by 2002:a05:6402:4c6:b0:504:b177:3ef3 with SMTP id
 n6-20020a05640204c600b00504b1773ef3mr11544497edw.3.1682362951078; Mon, 24 Apr
 2023 12:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230331173442.101678-1-cgzones@googlemail.com> <361e270e-ff0f-681b-5354-fc8fe98bb26c@linux.microsoft.com>
In-Reply-To: <361e270e-ff0f-681b-5354-fc8fe98bb26c@linux.microsoft.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 24 Apr 2023 15:02:19 -0400
Message-ID: <CAP+JOzQuwp+S6F=Y0MzM35_ZTXT-FmmV8YHq8GoZQDKuONf_Wg@mail.gmail.com>
Subject: Re: [PATCH 1/3] checkpolicy: add option to skip checking neverallow rules
To:     Daniel Burgener <dburgener@linux.microsoft.com>
Cc:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 31, 2023 at 1:59=E2=80=AFPM Daniel Burgener
<dburgener@linux.microsoft.com> wrote:
>
> On 3/31/2023 1:34 PM, Christian G=C3=B6ttsche wrote:
> > Add the command line argument `-N/--disable-neverallow`, similar to
> > secilc(8), to checkpolicy(8) and checkmodule(8) to skip the check of
> > neverallow rule violations.
> >
> > This is mainly useful in development, e.g. to quickly add rules to a
> > policy without fulfilling all neverallow rules or build policies with
> > known violations.
>
> I think it might be helpful to print a quick warning along the lines of
> "Warning: neverallow checking is disabled, compiled policy may violate
> neverallow rules" or similar when the flag is set, just to double-check
> against accidental misuse.
>
> -Daniel
>

I am ok without a warning. secilc doesn't warn when disabling neverallows.
Jim
