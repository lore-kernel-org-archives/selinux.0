Return-Path: <SRS0=r6Mn=CE=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE437C433E1
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 12:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE80208E4
	for <selinux@archiver.kernel.org>; Wed, 26 Aug 2020 12:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAPxCncw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgHZMxI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729407AbgHZMxB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 26 Aug 2020 08:53:01 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0ECC061574
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 05:53:01 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id l13so1362434otp.10
        for <selinux@vger.kernel.org>; Wed, 26 Aug 2020 05:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8OE4jJDjKPIpGBDGW0PDhHS98bm/niwX6Ql4e6W/ec4=;
        b=IAPxCncwBA8Sq2x01xgX5GSFhmy+NRM1/9blbMZhY3m5riWmBO6j2d8u/N+fYg00EX
         LZYeM6mpoENeKTrIO2yl6Ru6PIsJTgEUHyJyfrOa27j+2LmQzMLZSd6M2AH59zeixwmd
         ptM2vtjztiAdAqAs81L0m43w79uao6JJekQMDuVgAbquCcmWyh1C6NUMPDuSLSxD1Dl1
         UoEvOfdQfN/ZxgbPAH6Svc22+Y5Xcb8QxGCmm2CcbTt67Yd6PlglkjAQElPMi1XxYmza
         ng2w8YjnmquBB2uPEdcBdMU4bjO6ivYxAhdB/c3R6ciO9LybejD7/TUayuJTGI7/AePz
         Zlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8OE4jJDjKPIpGBDGW0PDhHS98bm/niwX6Ql4e6W/ec4=;
        b=CjfXz1UM/UdU5uPffn7ODWfI8nCs5k/7Wa5BYv9j8AJzuxjewwKkMVF5f9cQjUmdRf
         NtqkpWpWswoLMJZ3BGP0rvFMiJfZHwlERegm8qjCe3gQAgFMITx72qOeZGUH2UN+vnT2
         4jAegui1rB2/8icg+YK4MTCN6un45j+ZGJZs0Yxmf5tKKchdFgEQqanGa6UUEHOPYQBJ
         kebiFtmFZnUunMewAWI1cAhIe47VXB8Vil5cxpG+yxsISIBey419M+6OlnRpeCgpat7R
         fFeYTf8mONfKCk5zY6pf2LqKDcqyUWbBzHVCJj2f6hog7zWPAjW/CryShUDA1K32kzrG
         swmw==
X-Gm-Message-State: AOAM5300latxLqu8QmdwqJa6uzBIRTPn79KN67MR9+1nbphod5+vx6GP
        eHNcnLWEZDF7d2nQQDgUEdZc0BGfUO/huFUuU2Y=
X-Google-Smtp-Source: ABdhPJzg7EPaiNwJQuw/R0ZbnHQEHXuM1IlTcVt0vQseYER70aUdZY83eZVyS+sUPsDKJaBriQzi/2QAxqjOPFXAqqk=
X-Received: by 2002:a05:6830:16d8:: with SMTP id l24mr9411276otr.89.1598446380833;
 Wed, 26 Aug 2020 05:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200824131841.55687-1-cgzones@googlemail.com>
 <20200825153205.224136-1-cgzones@googlemail.com> <20200825153205.224136-2-cgzones@googlemail.com>
In-Reply-To: <20200825153205.224136-2-cgzones@googlemail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Wed, 26 Aug 2020 08:52:50 -0400
Message-ID: <CAEjxPJ6cy9C4seE3rxPxdmi5P4ET=1wj=ZaD0DErzginnmGVoA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libselinux: safely access shared memory in selinux_status_updated()
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Mike Palmiotto <mike.palmiotto@crunchydata.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 25, 2020 at 11:32 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Access the shared nenory safe in regard to consistent view of the SELinux

s/nenory/memory/

> kernel status page - not in regard to thread-safety.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: Stephen Smalley <stephen.smalley.work@gmail.com>
