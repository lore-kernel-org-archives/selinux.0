Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537C1C7EE23
	for <selinux@archiver.kernel.org>; Thu,  1 Jun 2023 20:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjFAUVI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 1 Jun 2023 16:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjFAUUx (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 1 Jun 2023 16:20:53 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD71E10CB
        for <selinux@vger.kernel.org>; Thu,  1 Jun 2023 13:20:27 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-565ba2c7554so13182827b3.3
        for <selinux@vger.kernel.org>; Thu, 01 Jun 2023 13:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685650805; x=1688242805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wZEzrXagpd1ZJ5FybW+SpSMtP2A4Kb7Kwz7t352G3o=;
        b=ULL5p4OGKEWTMAYj5H/gjjjRR99Zmdgk/VtUIuIwvAMkFWwQSOg6mE9tp+qlTcGyMU
         pd/xKspV/KKJd0VsKXqbwNi+IiN6leHgUNtbS02trdTElizSV4BwV9hng7UC5xXqNjKI
         bc+TJFqxDCplOIx3hsJjgTB5xnqNDvzL514N+tWu8tAajEwBsDCZDJesf9rdJZsadTLl
         dzIpL7mM5RfWFqZRS3POB4KWdJnOUnrtss5Qdp1W/DFZrCTBu8fPEtKrNZkyDp+M1XJ4
         oibMiso6ExHPm0iePnwur0ldq3fC0uWbnT00Ex4UjCB8rGz8igQqEBqt/bbf+3qZQsDZ
         j8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685650805; x=1688242805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5wZEzrXagpd1ZJ5FybW+SpSMtP2A4Kb7Kwz7t352G3o=;
        b=lRuHmqQKRh0ps6vYIEF+A+RnwPK6AgxNqIeCKTJI+Sh0IdFNiDrNWCgk2jzLBtIiKT
         YkEQWO03MFR7h0EzTJu7cQRLzothAwD4e6jMOv44c+f0oNCn7vnvxyE1r36dC/ou57Z/
         BRNTF4L0LD1t7chVe/C7koka6l8Y/bpljhhlKgGnFxa2lxPcSO1p3yrX0izo5lZ22gEZ
         VKsH2Wjl+6p0xhRtoQGgaM+yzvSLDm3NIqpU8CyyYa18dcjV2K4ZrOtqGwU7r2Z2MGJO
         /VkuuIdfMv4ZSVxY/SOn2nUTN0CEeD80HPEo8KxfmmUGnUvxCEmgyxOCM2xWbV5r29AK
         aumw==
X-Gm-Message-State: AC+VfDys9Mn3ZS51grixqAy16D2p7wHQKCOUgMf9Nw38t4ztNjuT5lFL
        4nCQVBHJDfMi0y7T7sggU8rB8jSRG8hvFeVxbBhw
X-Google-Smtp-Source: ACHHUZ7ooyhDbrvk4fGCIRVOS8dSxcUhCqxd0ePQhG1BII+do6kkPujL3e5mdU6cHoSMA8RY7Jw628NCBvpaL9FcuRg=
X-Received: by 2002:a81:8544:0:b0:568:c576:aca2 with SMTP id
 v65-20020a818544000000b00568c576aca2mr9221861ywf.49.1685650805714; Thu, 01
 Jun 2023 13:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230601180643.211112-1-paul@paul-moore.com> <275be495-96f3-8ad6-33ca-815068f3a4f2@amazon.com>
In-Reply-To: <275be495-96f3-8ad6-33ca-815068f3a4f2@amazon.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Jun 2023 16:19:54 -0400
Message-ID: <CAHC9VhQr-Mj_XXtjJ8ZnjHuna5L_z9dDPDxEDaFDWkVV-PmxhQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: don't use make's grouped targets feature yet
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     selinux@vger.kernel.org, Erwan Velu <e.velu@criteo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 1, 2023 at 3:23=E2=80=AFPM Luiz Capitulino <luizcap@amazon.com>=
 wrote:
> On 2023-06-01 14:06, Paul Moore wrote:
> >
> > The Linux Kernel currently only requires make v3.82 while the grouped
> > target functionality requires make v4.3.  Removed the grouped target
> > introduced in 4ce1f694eb5d ("selinux: ensure av_permissions.h is
> > built when needed") as well as the multiple header file targets in
> > the make rule.  This effectively reverts the problem commit.
> >
> > We will revisit this change when make >=3D 4.3 is required by the rest
> > of the kernel.
>
> Tested-by: Luiz Capitulino <luizcap@amazon.com>

Great, thanks for the help.  I'm going to merge this into
selinux/stable-6.4 and send it up to Linus as soon as the testing with
that is done (should be later tonight).

> Note for -stable: this is needed in all kernels that backported
> commit 4ce1f694eb5d
>
> Thanks, Paul!

--=20
paul-moore.com
