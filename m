Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA5FC433F5
	for <selinux@archiver.kernel.org>; Mon, 14 Feb 2022 14:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353793AbiBNOs4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 14 Feb 2022 09:48:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241020AbiBNOs4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 14 Feb 2022 09:48:56 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ADB4BFDF
        for <selinux@vger.kernel.org>; Mon, 14 Feb 2022 06:48:48 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id j38-20020a9d1926000000b0059fa6de6c71so11718889ota.10
        for <selinux@vger.kernel.org>; Mon, 14 Feb 2022 06:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yY6SBvo2qbcnCwjtRSeNMGOZDq7K8OjWeyGgXn+J8/I=;
        b=c762y/8kzhwXIpftYbmq3sQ3xvvMb7tBcccCFhDQW8wygXWZVOKzWz3Ip729SQ5vSi
         2Gjias6juXxULmxmwu4+IMOpB62B0UpyBtE1Sn82dM5AW5OVbVEYPTUVs+j6aM7nUOed
         2niVUSZMpUvY92xzhFZit44DzC0bJ8OzOOmaJLtUNqhyMJ2giSjt/GktItM18uv+ii4x
         BklMhdYtYk1MY8X8EwoLJ1fV+HkooN4hg0kMRpvMeaGBCfWbclYeT2p2S0tUNRMvrX/c
         jPxGpXpV/d5ym1Re7pRYyygAw85ORBjDGtrVRjCa7ysnfsU8GswDjNAmSIqjDd4VO/rO
         lzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yY6SBvo2qbcnCwjtRSeNMGOZDq7K8OjWeyGgXn+J8/I=;
        b=3cE8LcmvUmUCL8bxFQFyiz0pYGWHIR5GBJVgRUjbryVRmkRwLXANpQ21GPvgiFZN2z
         ZmhhmOYzXhR526HtPKyyvu6yPzI4zQxQwWQQAXArK4cxrDeYMQAuzbv5AXYEmaodtXdV
         QpX/4WG11Z3Sp/ETeUIAkJvab26Q3chBwxo+OLlswbcNbTZO4ts6faqrFBELLYHqokIa
         +d+xlYcj24yYp8RztFeliCX184J6PTVIAxU5iK/0yFqcNn+fGb5FExIYcZfv2qtHia1s
         mDQFHtBaZO6GysIv4k0stNLWYnoMn13L7KnQGVR7ZKKT3kUFBl6VA2tceV+Px7KXt4jy
         H/3Q==
X-Gm-Message-State: AOAM530eDCqSV0R80TInGUn0TefZXj0vyIxtBaEKnNimWUUdmhItSnis
        JS62Bh/US1h6UyXAyliijteooxAAOjaOtxkcvNfwormk
X-Google-Smtp-Source: ABdhPJxHXOHDIkqeevvDGy2ntcaFowK6tZCJbQ1jeU3l2yKWU6GT1JdH4czOSStKRngC272vsCwdxigydlkaFm6GfUM=
X-Received: by 2002:a9d:1297:: with SMTP id g23mr38076otg.154.1644850128055;
 Mon, 14 Feb 2022 06:48:48 -0800 (PST)
MIME-Version: 1.0
References: <20220114192002.730773-1-jwcart2@gmail.com> <dd96ca20-2f8f-ea6c-48b8-6649915fac1c@gmail.com>
 <CAP+JOzSeF50B5fYCLLKJpnGCXXWwxkEDEFU=61ZUY-TyLU7E+g@mail.gmail.com>
 <d6716dff-d46a-9a2f-3033-fe1bf0205681@gmail.com> <969a8728-ed17-821a-cbeb-38c0ed56e889@gmail.com>
In-Reply-To: <969a8728-ed17-821a-cbeb-38c0ed56e889@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 14 Feb 2022 09:48:37 -0500
Message-ID: <CAP+JOzTPoM0dnJThEmJO8JyAJt=E8Ccp=He33xr9TOhvs9mfEA@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol/cil: Limit the amount of reporting for
 neverallow violations
To:     bauen1 <j2468h@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Feb 11, 2022 at 8:03 PM bauen1 <j2468h@googlemail.com> wrote:
>
> Hi,
>
> On 1/19/22 14:04, bauen1 wrote:
> >
> > On 1/18/22 16:48, James Carter wrote:
> >> On Fri, Jan 14, 2022 at 2:44 PM bauen1 <j2468h@googlemail.com> wrote:
> >>>
> >>> Hi,
> >>>
> >>> as a heavy user of neverallow / neverallowx, please don't limit this.
> >>>
> >>> When adding a new neverallow rule there might quite a few types violating them, and having to rebuild the policy every 2 types would make fixing them incredibly annoying.
> >>>
> >>> If you want to limit this, then please make it opt-in or add it as a command line option.
> >>>
> >>
> >> I am trying to limit error messages because oss-fuzz seems to be good
> >> at creating policies that generate a lot of error messages and
> >> subsequently take a lot of time to process.
> >>
> >> But I am not going to do that at the expense of people actually using secilc.
> >>
> >> I was already thinking about making the amount of error reporting
> >> depending on the verbosity level. What would think of it limiting it
> >> to two by default, but unlimited at any higher verbosity level. I can
> >> even add a message to use "-v" to see all of the errors.
> >
> > Thanks, something like that would be totally fine for me.
> >
>
> I've also just noticed that typebounds will only print the first 2 violations.
> So if you make this depend on the verbosity level you might want to change that too, just to be consistent.
>

Yes, I did send out a v2 that changes the typebounds error reporting
to depend on the verbosity level as well. That patch set was sent out
on January 19th.

Thanks,
Jim


> --
> bauen1
> https://dn42.bauen1.xyz/
