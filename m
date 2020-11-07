Return-Path: <SRS0=Z14I=EN=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107C0C388F7
	for <selinux@archiver.kernel.org>; Sat,  7 Nov 2020 14:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B547920702
	for <selinux@archiver.kernel.org>; Sat,  7 Nov 2020 14:45:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="eaibX9cM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgKGOp4 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 7 Nov 2020 09:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgKGOp4 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 7 Nov 2020 09:45:56 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D4FC0613CF
        for <selinux@vger.kernel.org>; Sat,  7 Nov 2020 06:45:55 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id e18so4206451edy.6
        for <selinux@vger.kernel.org>; Sat, 07 Nov 2020 06:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/qpoNw3J6tHKM8uLiC3wNT7O6K9SXRvx/RUvWlYfsmU=;
        b=eaibX9cM2uRoDke0DEK0slstHH1xesLDm378aloTBKIHBRyeneJFTt6Cmk42iO7Q2b
         g25bd0uzkIEWzqEqkvyQn9uzGgl2YNRjR3JndM6A8+bnPk1oT5ailY7WAAnIQ74POYuc
         BqzP6Db2ne3bvZP9SFUAYAQB2k/8DZnJVdoqK6qqfZVnU0xZpfUa+eWGixcTUrmVg1PI
         zcd32adTe14T+lbuv0wx91l/YiT9ypseq7FgFdf0Ee5hM7FIF9Fre8qJwrj2RZkOHR8B
         yFTNg1FheH+XqMXBenDKkQCg2kPEb7YvUsqBj2Nd0iTTHEfxnHRYieE+WbcCZ9eCSNwo
         6s2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/qpoNw3J6tHKM8uLiC3wNT7O6K9SXRvx/RUvWlYfsmU=;
        b=s+O67rXwhZ+jtYC/f2onFBRemm3HynqBwNvlwMwUwrsMuOFmW1UV2TYQHrMlJONB/4
         43LriWG3TskRd570oonhdA40yJZgLvYHHIumeckUn5PGBGbK0n6pGISKL08FK06z781p
         Q1HbRQv1Rn/fMPJV7C4TUKual2YLB2dAWpQyHf+h9VhmcPh3lVtpmTxw4F+m/DAFVNOW
         2KwdBhOgTG7V+6fh18vlTMSRbStRSJScAWQ7LsKolST4Zly/so8o8O0FVcqa1pGzVQuN
         cUhlejs2oCXBWrEvqOpx1sNVrewgDjx5vndJHAvl9gZt0uv9HEUbjFV9FumXygd+/L3k
         X8dQ==
X-Gm-Message-State: AOAM533/NczKiubJ2h/tya52SrJse5DPf8afYhvqBswY5mrFQm7DxxwD
        oraseJwVdq2Y2kmbZxZ9u2A/BjWnMJf//AnVSqDh
X-Google-Smtp-Source: ABdhPJzbs1Mvt5M/XwA9qU3hh7YG/JuJbD+z+t6ADidNbO2lMXes0ZIOwbGlrpVGw4aMQwGFQc1Tg6i60xzuruBmB6g=
X-Received: by 2002:a05:6402:2d7:: with SMTP id b23mr6856152edx.196.1604760352743;
 Sat, 07 Nov 2020 06:45:52 -0800 (PST)
MIME-Version: 1.0
References: <CAP2Ojcgr2NkjZxL3_Fcu2Tj00ahCOqvx+i0qzn2mcsrNE-iFrA@mail.gmail.com>
 <CAHC9VhTqYyOGSdyG0syvLG30sWC9kb_NmjbWaNrefgFkzCjDAg@mail.gmail.com> <CAP2OjciAjmgxyDZeivQcbCE-RtQtyxEg58ozw6m2JgodnoKOKg@mail.gmail.com>
In-Reply-To: <CAP2OjciAjmgxyDZeivQcbCE-RtQtyxEg58ozw6m2JgodnoKOKg@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sat, 7 Nov 2020 09:45:41 -0500
Message-ID: <CAHC9VhT27y-7=HqXjrxo6teviqPcz0_F50MTfx2AnUYKLDaexw@mail.gmail.com>
Subject: Re: Inputs for error " libselinux.so.1: cannot open shared object
 file: No such file or directory "
To:     Ashish Mishra <ashishm@mvista.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, Nov 7, 2020 at 9:31 AM Ashish Mishra <ashishm@mvista.com> wrote:
> Hi Paul ,
>
> I haven't installed any specific libraries.
>
> Will it be possible to share any pointer as to which package provide this libraries or
> Source code which one needs to compile.
>
> This is bare minimum linux setup we had .
> We are trying to add selinux support and in process of this activity , I got kernel changes.
>
> I had started with selinux notebook pdf ,
> but found difficult for me to make clear picture of components when starting fresh .
>
> Apologies is the query is very basic in nature
> Trying to get clearer picture .

You will want to start with the SELinux userspace, the upstream
project can be found here:

* https://github.com/SELinuxProject/selinux

... the latest stable release is here:

* https://github.com/SELinuxProject/selinux/releases/tag/20200710

... the README.md file has some instructions on building the userspace
tools and libraries:

* https://github.com/SELinuxProject/selinux/blob/20200710/README.md

Hopefully that helps.

-- 
paul moore
www.paul-moore.com
