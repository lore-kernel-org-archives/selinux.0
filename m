Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F605C77B79
	for <selinux@archiver.kernel.org>; Thu, 13 Apr 2023 15:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjDMPUP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Apr 2023 11:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjDMPUN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 13 Apr 2023 11:20:13 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24B9AF37
        for <selinux@vger.kernel.org>; Thu, 13 Apr 2023 08:20:05 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id j10so5576955ybj.1
        for <selinux@vger.kernel.org>; Thu, 13 Apr 2023 08:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681399205; x=1683991205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KspaEPrDplSYvcKzIX5D8e6YFnwmmvrPbcdh5kQyGqQ=;
        b=eKsilHFPmEUZDQVDrV9qu6JEEtfDZIu1cSMeGpjLy2izDH0nTEnTGwBipq3zsshyab
         nhbOlmES78QjhhnMgQkj22ESrWyFzgzKzq1koPMtnDuhJUge3qys4hEgqbRg2Uaa1qMw
         D8XAmsrmTCcvyrjpC1QyWniZRlpnIicqQEPNJoWqg7dkQI8LyZEQOW9YZscE1Rg46FfH
         90OOn+GcQaMbQofV4lMHCa+6Mxyyf6vli8DxJ31t2250oaETaCK3q5KLmQriHXxUMj0F
         T4xRJw8PnKKkP7AgMCFlDutKxO0xsAk6Moug72SglwxzeceUIPyx+sIVfsM6YRewHlGa
         W9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681399205; x=1683991205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KspaEPrDplSYvcKzIX5D8e6YFnwmmvrPbcdh5kQyGqQ=;
        b=Wj2XIWGwqZEw/AlABVO4PhI8hdFIKYY4QuVfYFCcJH+eovSilxju5EfuYWtJQFwtOj
         31/pCBvEBf81jL8N+PhXnpDk75ZdwfeOAu1PV2V3oyp32i8cogqXvDSFNWSvfKGgi3dx
         dYgbXAyiB82S3FR3G26RvIMqHYlesoAsRqMNPTiTtubnZWkOsxJFDCuBk7o5rWHti5W9
         H6Qf1fzwslTwd5oOJR9RaPcXXbxC9+Ak6wweDVr9LY1Fuj/l7jegoUa174CD89GtlkwP
         NhbqU9Y+KK+Yp1+M73bjudhN5vGS8rVL6EQ4zkBBqkG9KNOGOMl6P1DmF4A704Kg4u2l
         JYqw==
X-Gm-Message-State: AAQBX9dlu3R+LYhGxSpC/JZG+0AKrXpj6eE2TKII1Ok91/NIXAAyXvfE
        +NxV8Ox02TTO0VVg9lDKYiL6lFypOMWN492yz5/j
X-Google-Smtp-Source: AKy350bJPUvWcLZaaM0kHY/y3MXoFhJfvIHrtDKoCad0pksGkPPZzxEGyK/GfpgQZ7Mj6t5iYE1p77a5Wr3zfNz/la4=
X-Received: by 2002:a25:d2ce:0:b0:b8b:f1ac:9c6c with SMTP id
 j197-20020a25d2ce000000b00b8bf1ac9c6cmr1687953ybg.3.1681399204370; Thu, 13
 Apr 2023 08:20:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAHC9VhQ7A4+msL38WpbOMYjAqLp0EtOjeLh4Dc6SQtD6OUvCQg@mail.gmail.com>
 <ZCS5oxM/m9LuidL/@x130> <CAHC9VhTvQLa=+Ykwmr_Uhgjrc6dfi24ou=NBsACkhwZN7X4EtQ@mail.gmail.com>
 <1c8a70fc-18cb-3da7-5240-b513bf1affb9@leemhuis.info> <CAHC9VhT+=DtJ1K1CJDY4=L_RRJSGqRDvnaOdA6j9n+bF7y+36A@mail.gmail.com>
 <20230410054605.GL182481@unreal> <20230413075421.044d7046@kernel.org>
In-Reply-To: <20230413075421.044d7046@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Apr 2023 11:19:53 -0400
Message-ID: <CAHC9VhRKBLHfGHvFAsmcBQQEmbOxZ=M9TE4-pV70E+Y6G=uXWA@mail.gmail.com>
Subject: Re: Potential regression/bug in net/mlx5 driver
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Saeed Mahameed <saeed@kernel.org>,
        Shay Drory <shayd@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
        selinux@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 13, 2023 at 10:54=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
> On Mon, 10 Apr 2023 08:46:05 +0300 Leon Romanovsky wrote:
> > > I haven't seen any updates from the mlx5 driver folks, although I may
> > > not have been CC'd?
> >
> > We are extremely slow these days due to combination of holidays
> > (Easter, Passover, Ramadan, spring break e.t.c).
>
> Let's get this fixed ASAP, please. I understand that there are
> holidays, but it's been over 2 weeks, and addressing regressions
> should be highest priority for any maintainer! :(
>
> From what I gather all we need here is to throw in an extra condition
> for "FW is hella old" into mlx5_core_is_management_pf(), no?

That's my gut feeling too, at least for a quick solution.  I'd offer
to cobble together a fix, but my kernel expertise ends well before I
get to the mlx5 driver :)

I have been running for a while now with that small patch reverted on
my test machines (so I can keep my tests running) and everything seems
to be okay, but there may be other issues caused by the revert that
I'm not seeing.

--=20
paul-moore.com
