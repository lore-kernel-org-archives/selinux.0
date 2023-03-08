Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFE3C64EC4
	for <selinux@archiver.kernel.org>; Wed,  8 Mar 2023 16:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjCHQvl (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Mar 2023 11:51:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCHQvk (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Mar 2023 11:51:40 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE63C80A7
        for <selinux@vger.kernel.org>; Wed,  8 Mar 2023 08:51:38 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id qa18-20020a17090b4fd200b0023750b675f5so3015226pjb.3
        for <selinux@vger.kernel.org>; Wed, 08 Mar 2023 08:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678294298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNOsiUWkfrpIZHC5QMcI12S7qBw0yXwYuQeB2/UG1OE=;
        b=BimZhBu0UCJ9mSl4EafVGnFG6lB4UltgVlJxbWehQI/U26xEXgOPk+ElhWaqDdeU4R
         Yp+DPXR8ijkcvX84PpS2nRwQxByZGHZDB8DMlXsWhC0O2o6PBrwcd5zPAOak+f/xv4zD
         UiFdOzkziBYTTQn0/4UVjHRg7nS/2DQMhxS1+pBO7UXU6w/2s1gGDr4vtgwo7DIBi2I7
         HYT2NhOquj/mV3HQofS4ErNwohVHoBa4NjeGf2RR5klGiDpQKt84hSwRxUVbc8Iov+9R
         YpWVFgwub+R4PhtCkiuNhv8V9OnggdPRFuwbK3xgBmihhBil8mrteJMTaKGRWFJospow
         jQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678294298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNOsiUWkfrpIZHC5QMcI12S7qBw0yXwYuQeB2/UG1OE=;
        b=DXAUL3c8QBciwXRa3AoVUfd6yiE0zW0ufhz2g2M9PJp0VZPjNszaAutlD063mTKmH/
         U0r0S+27p9E+X9DRsL6cjq7jXGlcU52mx5f7+eKL+XSWHJJOrfMZzj/EQj70Vm1n8jXL
         R0D8tl9wrD3pcNq8kDiRias+KJjFqqYi/jiQI6cKQCFm9QR0rpF4uxXJwXbWS5TNlcYr
         Gpnyq1L8LnMpHcu47416X7KBVgi1lVnP3gcAPRL9DOTOtrh1bqCN13iUEnd8Fa/Qme59
         UXgeyBztkbqLAxbcDNuqRShkKvBL/gzn5z2QkaeU8vnXgFFDugrp0Biks8nkkoHGxBgh
         wyww==
X-Gm-Message-State: AO0yUKXQ7FR4VI9zmTuZ7jrNIx89TdEpvRd+xJn/Qs2ju0u1pnToAQD5
        1mzg+bF0GRv+CiGbChGi8JdazwadADYft5kmFfdwOg548bOBnIg=
X-Google-Smtp-Source: AK7set8O9Sk0ouAL4fZeNALuf83r0un/3G1XxwkJ492/erq21E6wLcjwVFdejq9zSt4aIpGPd1/lJWaq0T5tpvZrmug=
X-Received: by 2002:a17:903:2687:b0:19a:f82f:bb25 with SMTP id
 jf7-20020a170903268700b0019af82fbb25mr7219529plb.7.1678294298103; Wed, 08 Mar
 2023 08:51:38 -0800 (PST)
MIME-Version: 1.0
References: <20230307204524.214983-1-paul@paul-moore.com> <CAHk-=wi2h64sVbDRd+P5YM_C+BofhqkrvmBTyioay1ofwA9Fpw@mail.gmail.com>
In-Reply-To: <CAHk-=wi2h64sVbDRd+P5YM_C+BofhqkrvmBTyioay1ofwA9Fpw@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Mar 2023 11:51:27 -0500
Message-ID: <CAHC9VhSM-ah1VUTXQW=DVk157ANcAuiCrJEubqt5rU8ksVjwdw@mail.gmail.com>
Subject: Re: [RFC PATCH] selinux: uninline unlikely parts of avc_has_perm_noaudit()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Mar 7, 2023 at 4:00=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Mar 7, 2023 at 12:45=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > This is based on earlier patch posted to the list by Linus
>
> Ack, looks fine to me.
>
> I didn't apply it and look at code generation, but I don't see any
> reason why it would be bad, and I agree with your RCU lock cleanup
> being probably the better option (rather than having the comment about
> the odd rcu lock behavior).

It seems to be passing all our tests so I've just merged it into
selinux/next; assuming nothing strange pops up in the next several
weeks you'll see this during the next merge window.

--=20
paul-moore.com
