Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF97CC04A95
	for <selinux@archiver.kernel.org>; Wed, 28 Sep 2022 16:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbiI1Qtb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Sep 2022 12:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiI1Qta (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Sep 2022 12:49:30 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B76D7333B
        for <selinux@vger.kernel.org>; Wed, 28 Sep 2022 09:49:28 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id d14so6919335ilf.2
        for <selinux@vger.kernel.org>; Wed, 28 Sep 2022 09:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=tyxXa+fqMw9TkY4KQgG89eDPP5BtjkA+pZDm/WZOUiI=;
        b=BdcdM2XrtsetmBhZplbKazKdWb4E6gdw2OS01Z5mTiLoaX2kosi5tKy74/MYEpktqp
         +vRZZuhzqVN9f0qIPilK3eq8V6+bt05fJC20yMi8qBxx6/XZW9ANOcXKHTP5n1L/Jf1U
         kTOztVeWsfO+YKF5wjTX3oReXyuOhDonAjj50=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=tyxXa+fqMw9TkY4KQgG89eDPP5BtjkA+pZDm/WZOUiI=;
        b=t0WSoJcTf9Cd95hQcDo1o8CaJh0K2GwulUGfKqeSYikS52hbYnJLZ9PtKW3yBMkA/y
         hzhDTCTA1RDwwjbmgQxbL+5Cnay0u0vAHRpI3DbZnLxlWrZoJdlLp+gdKDyMAE17sXGF
         zKOE5q8O2U2SWmh4kWE+iDOuWe1IT0TTt05yQa63vRy6u/9FYLQJIc2bfgENv7hbNcBv
         RfIMu/yYARXKBqryidYARTxdCeJ0PPBm1eoZ24E4REQI4eqJHAp5339ZVIHO6a5IDn2M
         DuL8nYX7qdgWJZqFT8CpN9bJvtgdhamcECvwKimr6e42BMhqDem/CEnOZhsEzefn25aL
         AMrw==
X-Gm-Message-State: ACrzQf2XwM+e9pLjeyTrgEmfupJOasf+3zytX0+1JfCVwe5h+uSwmr5m
        K3zQwHjJ3VlYE5zoU/3YdjdMT4LfOLdnCnpUX5yPOA==
X-Google-Smtp-Source: AMsMyM7+bphBwdxvhSyNVO1ypaG14gwvteR+YyN14PU7dGQeWrrAkJ7QYDW0erl81sKbHAWMj0ge880qz2QspRZ/mq0=
X-Received: by 2002:a05:6e02:2186:b0:2f5:cc0b:fb14 with SMTP id
 j6-20020a056e02218600b002f5cc0bfb14mr14894803ila.315.1664383767861; Wed, 28
 Sep 2022 09:49:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220921185426.1663357-1-jeffxu@chromium.org> <20220921185426.1663357-2-jeffxu@chromium.org>
 <CAHC9VhS-jv5cpSdq7dxFGYH=z=5grQceNMyjroeL2KHdrVUV6g@mail.gmail.com>
 <CABi2SkXRxomrYn-xUf3B+XswmQjXZUJXmYJECmr_nBfrZWwqkA@mail.gmail.com>
 <CAHC9VhRuUZxdsVQftqWa0zEuNAxk8ur0-TZp5KecJ537hRONRQ@mail.gmail.com>
 <875yhe6ial.fsf@defensec.nl> <CABi2SkW4P+s-+5X7UGYYp1tUtT350_7UfQx_KYqHAyYe31ORWw@mail.gmail.com>
 <CAHC9VhTGDJjFm-3abKtXia-k5jyz7ngV+ZcUkof-=Vt1toLyBw@mail.gmail.com>
In-Reply-To: <CAHC9VhTGDJjFm-3abKtXia-k5jyz7ngV+ZcUkof-=Vt1toLyBw@mail.gmail.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Wed, 28 Sep 2022 09:49:17 -0700
Message-ID: <CABi2SkUYUJadPMh2yNYgYBH+BqDKs8hhNg7TLKrAahKwVQRUbg@mail.gmail.com>
Subject: Re: [PATCH 1/1] Add CONFIG_SECURITY_SELINUX_PERMISSIVE_DONTAUDIT
To:     Paul Moore <paul@paul-moore.com>
Cc:     Dominick Grift <dominick.grift@defensec.nl>,
        selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        jorgelo@chromium.org, groeck@chromium.org,
        Luis Hector Chavez <lhchavez@google.com>,
        Luis Hector Chavez <lhchavez@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Sep 26, 2022 at 2:41 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Sep 26, 2022 at 2:03 PM Jeff Xu <jeffxu@chromium.org> wrote:
> > Thanks for details about the unconfined_t domain, this is one option.
> >
> > IMHO: between permissive domain + audit log and unconfined_t, there might
> > be room for letting each permissive domain decide its own audit logging
> > strategy. The reasons are ...
>
> I'm sorry, but I don't want to support a permissive mode that doesn't
> generate denial records in the upstream kernel at this point in time.
>
No problem, I understand.

Thanks
Best Regards
Jeff

> --
> paul-moore.com
