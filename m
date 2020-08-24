Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53DCAC433DF
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 08:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2513A2074D
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 08:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TKxXts+Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgHXIBi (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgHXIBh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 04:01:37 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A633C061573
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 01:01:37 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id i129so3964224vsi.3
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 01:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B9rqT6PPn/roxYtGSUaIhpBUEFtU5jcHcVNdXLvHhck=;
        b=TKxXts+YsXgkGvaRpPo3eAytrTi2BJAovHwZviLK3XYtYpn/VQzpjHyouT7hcSiK4q
         NFHysoO9gAm3eYDMNsrMchjrhBa1ApQVuLvF8N8caEpi8Ulz8w5TqS8mS+fcHkZgFZOj
         Q7vkIm3n1GmHqwaK8FuVg6znxqvMsYAe9FWwfuZObcU4YBUtbyBJtZOA3dgacWLAntf6
         b6FhILJ/nPfkhf74OmAOFw2A7/TZwWaqnLxoyYS0kT0yaNyIZ6MxBcR9NB1Jz9Ph7Crj
         zPCI8tAuesdKh2LGmnHS4jNXmvpgJwunj6/+4HzGrXAmlkO2TgjSlY3Sasjnw8IV1fFb
         tIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B9rqT6PPn/roxYtGSUaIhpBUEFtU5jcHcVNdXLvHhck=;
        b=Xow9i4A6cPDYHpjqcG2LjaM+TPANg9sFMIrOttRmU0booGuKtuHA2xpGjeg1PNMRXn
         LNdDiONSHIqQMEfJD/a69TwbpvUeHSwBRR958lCXNbE0C38LuTT5asacK/UlyysDQtCq
         TIc5hFnIV2cKUINTWiuRfNpZ1yc5LZiLcPq7JM0lyHo3fNS5BniZbifWmdKJooU2MLuP
         TptLAtKwF/OI2UuxpMIqcuaaYdwvbQMHG1D5KR/t+0AH933ZnpHb9UChGV8sxcru+nas
         T8HuBz/U5G1raUfKpATNyJAmlosuUGiEvYnxYmvH41r86Md75DDBQEyQez2cJsCclMFH
         RYVA==
X-Gm-Message-State: AOAM530MU8v1HxULMC5TdBnJDyPEnr3m7UMIHJ05ym1HjRZOMIHRcH2Q
        lxks9W1XvIkE3CtJkMEvCixWdF+OZpogauFfGOoX4Q==
X-Google-Smtp-Source: ABdhPJzft37J4VICCSjVtBl9nKOxrITQP8ZGt7T5d33gdlPINv/njqOLUxnHNKgaxwqqBD9jIFsux7Fu6SCOFJ2J+hY=
X-Received: by 2002:a67:d216:: with SMTP id y22mr1802258vsi.135.1598256096077;
 Mon, 24 Aug 2020 01:01:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200821140836.3707282-1-tweek@google.com> <20200821140836.3707282-2-tweek@google.com>
 <CAHC9VhRiz1ezDj6J5Yuv17EU8nnrOBKfHScB-njVUKptSoxowg@mail.gmail.com>
In-Reply-To: <CAHC9VhRiz1ezDj6J5Yuv17EU8nnrOBKfHScB-njVUKptSoxowg@mail.gmail.com>
From:   =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date:   Mon, 24 Aug 2020 10:01:19 +0200
Message-ID: <CA+zpnLd2wth_5agN4rdchwKvvxiDxjt9++3gWi=7NLACDW2jeQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] selinux: add tracepoint on audited events
To:     Paul Moore <paul@paul-moore.com>
Cc:     Nick Kralevich <nnk@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Peter Enderborg <peter.enderborg@sony.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

> Merged into selinux/next, thanks!

Thanks everyone for the reviews and constructive feedback!
