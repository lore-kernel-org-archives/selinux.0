Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5CEC7EE22
	for <selinux@archiver.kernel.org>; Mon,  8 May 2023 20:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjEHUuw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 May 2023 16:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjEHUuv (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 May 2023 16:50:51 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF55D5FCD
        for <selinux@vger.kernel.org>; Mon,  8 May 2023 13:50:50 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-b983027d0faso6663044276.0
        for <selinux@vger.kernel.org>; Mon, 08 May 2023 13:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1683579050; x=1686171050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dq17UP5y/DgLewgVApI9InpI5UW34W50Q1doccFH+co=;
        b=MY4Q70G5Z8nyEjqkb3HPOjTv2/DuKZWIFQXLcK3XfPVxGCtL9Y43AWjwdp6mkKAJlj
         mSabwFTX/4NGikpixZzAG5meKbA0EfoRgAfw8GcNMIekdnz5k072FaqQ0VDxc2gkyESo
         UxqmXS9K4BNunN+gUL5bywI4K6punuyLIedvxPpleoQdV4NzlLLg8bLJg1WmUVIZdDWw
         cgtqwkZoi63JfV2T/csa5BtmiEgbl6BEVmWdzwYW+ITm6J+MR+Iq/T3AIh0xPWxneMZf
         zM7AAuyFQ96nHLx3v++dsvpHBHvrx2q0piNNgLrAISQLxE1RDgBLaDYYleCgyQFeHKBs
         Ihug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683579050; x=1686171050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dq17UP5y/DgLewgVApI9InpI5UW34W50Q1doccFH+co=;
        b=aE+E7h7Hv8lI5QIgG2/kn99q77P9H7LcyxiE3YvKUoi7OHBLYBrTcUoDW/aIZn7/oQ
         ilMQ3GmBzpPqahdlX1SCNTFa9w3svrJsjNVPedcB8Oewcxs2Az1GdbL5kwOyiNqDo5qi
         tRkerCPAx13TGwEpvQPd+CexL96DW4Lg9+bsF5Hcf+mViN8uDi5NZDqVYqf7aHDaEfEK
         1zfKvywOjgxUdHXGr/YXWcecsqSqcvCZlY6FB4KUSXaES19T1QQSxtpFRh+EEW25sqcq
         SxQRjan1Lhkjq1Xt29jmnFvfN5t0aHcziCZ0jJP/Z/UgKwlWd/3b6QtBW0snosC5xAhl
         8+CA==
X-Gm-Message-State: AC+VfDwmrORtsmWmgz1ev8djwCNJ/E1z6MUBRiPOLXuPoZj2qmbQZqOk
        qXU4gLRGlwMrgkfONVf5U/WKevGwvmmQBU7InzbS6tagUg0S2bs=
X-Google-Smtp-Source: ACHHUZ75d1/8G9nkLmH5y07dn6VVSFR/FdBeS1sY16iPAZjU0Yqm8VLFaD/BBfwvQFyWv7SPHuQ+bieAkZdjmI11fG0=
X-Received: by 2002:a25:6ac6:0:b0:b9d:67a5:a725 with SMTP id
 f189-20020a256ac6000000b00b9d67a5a725mr12900516ybc.15.1683579049809; Mon, 08
 May 2023 13:50:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230420150503.22227-1-cgzones@googlemail.com> <20230420150503.22227-5-cgzones@googlemail.com>
In-Reply-To: <20230420150503.22227-5-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 May 2023 16:50:39 -0400
Message-ID: <CAHC9VhRh_J4yj7WnTfTnu=06qZHpR8mTG4wuvgXcGYo9RPsMzQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] selinux: retain const qualifier on string literal in avtab_hash_eval()
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Apr 20, 2023 at 11:05=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The second parameter `tag` of avtab_hash_eval() is only used for
> printing.
> In policydb_index() it is called with a string literal:
>
>     avtab_hash_eval(&p->te_avtab, "rules");
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/avtab.c | 2 +-
>  security/selinux/ss/avtab.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Merged into selinux/next, thanks.

--=20
paul-moore.com
