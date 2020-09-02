Return-Path: <SRS0=YX5s=CL=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DD8C433E7
	for <selinux@archiver.kernel.org>; Wed,  2 Sep 2020 15:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E8820826
	for <selinux@archiver.kernel.org>; Wed,  2 Sep 2020 15:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIYvSwg9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgIBPRO (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgIBPGa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 2 Sep 2020 11:06:30 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AF2C061244
        for <selinux@vger.kernel.org>; Wed,  2 Sep 2020 08:06:30 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id u25so4545630otq.6
        for <selinux@vger.kernel.org>; Wed, 02 Sep 2020 08:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dd1w/93yso4mdRngsObHvLXopYOb+wG1Fb9NUQ4Vv54=;
        b=OIYvSwg9OfbvPmXxm5e54Nn+z/WPOVNolV38DreBVVWy5NqNqrQO2N+voQK5iMbhen
         1/eJlb0Rgs3zhT9PMg5OOsGvPsAE3vPSz+Ii2cjDZLGagintJJ/RG133FblnEMR5E6jS
         zWQ/byhOrrMwRpeB6uQwZaf832v1QNKOR0mmqqJzg2Fct/C5UJeyY9y9tXTMeYLHT5VF
         oZjyXZFKLEgUhWG6yfNL20yjr6HF0obVXajsKMn5bpi94kz8BihoGShJQScp5RU1ow3I
         GW5RROj0SYW1w0VQ1Yl5gdKW3jsw/eavR6N2EgYwqw/AflRIGs4Mc6tK56N3kBVvfJ9i
         HdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dd1w/93yso4mdRngsObHvLXopYOb+wG1Fb9NUQ4Vv54=;
        b=rdwAKNQgKxaxyvuS44DbEcA0NQshTD/bqDw6NuHNfLbGpacQJccBMmAymI+bUu7jY3
         J9T/yEWOapV8FngPIJHcF5Jnkf20zLI3EUABin1RC4gyBtmQXA0QiN7s48CEZ4jY4430
         GkggpQ3m1CpNMtebHJiFtlUxcsz7rcj1maF8aXBM4+WQ3VchbUX0Oym+pSanFOP2WqOE
         A5Fn63ujncXwzFxvDrPoNKE4hbrQmjVxo4gKIeeg9uINHp/p0fisrfY0N+vPcOkbfPgp
         ys+/tIyrvnvnct48i0IMa6Hk6U9F5eXcONWjEHORGcSrOHFuj/rahtjTGvpfV1vUOKsB
         sb4w==
X-Gm-Message-State: AOAM531HaLpWILoxskUUlKB/07ahRC9nZmMQ9fpP2bnxhRAbk2vGdGxG
        ++mPKVDdfnM5H03VarWOFcdH1wEZYigfZzyyDYk=
X-Google-Smtp-Source: ABdhPJzVCTy5i29+y2Bl/0wMO7ZAGP8Tiu62xlgHvupSgX7vix5n554VyninCEWYj3csAcPPzs5xJqdmJ10HoyTVKhM=
X-Received: by 2002:a05:6830:1be7:: with SMTP id k7mr4321776otb.162.1599059189467;
 Wed, 02 Sep 2020 08:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200902111456.20610-1-cgzones@googlemail.com>
In-Reply-To: <20200902111456.20610-1-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 2 Sep 2020 11:05:19 -0400
Message-ID: <CAEjxPJ4qNYRDOgNX4fYzJvKMg3fwAxS4xzNdG2ydiT7qyeORHA@mail.gmail.com>
Subject: Re: [RFC PATCH] sched: do not issue an audit on unprivileged operation
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Sep 2, 2020 at 7:18 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> sched_setattr(2) does via kernel/sched/core.c:__sched_setscheduler()
> issue a CAP_SYS_NICE audit unconditionally, even when the requested
> operation does not require that capability.
>
> Use an unaudited check first and perform an additional audited check
> only on an actual permission denial.

Could we just delay calling capable() until we know we need it?  Also,
this patch will need to go to the scheduler maintainers not just
selinux list.  Might want to also copy linux-security-module list
since it is relevant to all security modules that implement the
capable hook.
