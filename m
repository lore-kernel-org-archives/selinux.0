Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B862C43217
	for <selinux@archiver.kernel.org>; Wed, 20 Oct 2021 14:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E8956136F
	for <selinux@archiver.kernel.org>; Wed, 20 Oct 2021 14:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhJTOiA (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 20 Oct 2021 10:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhJTOiA (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 20 Oct 2021 10:38:00 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAE4C06161C
        for <selinux@vger.kernel.org>; Wed, 20 Oct 2021 07:35:45 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id o4so9838616oia.10
        for <selinux@vger.kernel.org>; Wed, 20 Oct 2021 07:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lYcpxAoKiR1nuz+GnuftyP+++uLEdI+oMlW79fwxW6s=;
        b=gdt5jJLAeDVmSeSw6z7r2d5sDkDLysixxfM3Jq6M6LBK4JSCGKE45KO2xfFiLNIEjY
         ERp4DitS2ViJwxVZDDR5Hwc65i50F1eJOYWRQ1x5g1q22Az85K/krgnONkngJYN/Lx/G
         qqWRUSueOjsEe/AyQwvb2Oio9Hn2axQ5EvV4Giic93xbE5NyHU2QQFQ1rcbzjFArCKJz
         qSXDQN3GkB2qBmrj75kWPAXYtiG8xx7ApukztYxymmoX1phAocWyMmCtfkwP2YI8l4oq
         f/fkdlVMyQlJKaqD8mXMOiNJo6924oVVsf/bQYyn7QnagsvH14Vgv5AVB1O5o5H000tR
         nPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lYcpxAoKiR1nuz+GnuftyP+++uLEdI+oMlW79fwxW6s=;
        b=dcHOsUCFW13enLKbKokdwTd2U52RMwjc41+sSekDO/nZ28ochTaFzNc/KotZWD9Llj
         jaA9yEMgszxYxl9Mr4RhTxNc3HlQzMPlgPnKCzVmJMSkSRpKxKJCPqUgNRHQZe5PoL6b
         ynseOG56vUxrLUtPcCgBJ090daP6MFrgcKBdmJInoYko5XUEHuk4Jp99YjRK8S9+hhj/
         xEOqbIvTv2t71uy/yJd9HTluPySF2PVzo/Ny2SCcrNVrGoBUKRxWj5KxIhaUqXU43JSJ
         vYgZYB6lETdGmGfnigr1NUsyoRMKuXWQRA5xO6la1+8uRg8zqHiI2ZixVIwspjRiZVkS
         gUnw==
X-Gm-Message-State: AOAM533+JHSC0TL3cHvtFZhkLTZpSWsMuP3TZQttAPBRPaOE+397IyUP
        yVCypYMBpdLu+qlBe5PuEBfKBsYCvrmZlOEaJJdKyM9k
X-Google-Smtp-Source: ABdhPJzhnT5rPtnt3bcNoWhSzyrpTZWLHdWgdf2C8pWfoh6IjTU8WpdayZG73p1zhMn98MqOo/PXE6N77xU7N5EQ0IU=
X-Received: by 2002:aca:c288:: with SMTP id s130mr9652538oif.138.1634740543903;
 Wed, 20 Oct 2021 07:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <87a6j3khr0.fsf@redhat.com>
In-Reply-To: <87a6j3khr0.fsf@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 20 Oct 2021 10:35:32 -0400
Message-ID: <CAP+JOzR9gbGkyrpsE_66ymkGmAmYQ-z_=rkK1ju4OUGdqEuE2A@mail.gmail.com>
Subject: Re: Release 3.3 or not?
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 20, 2021 at 8:23 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> Hello,
>
> 2 weeks ago I wrote that I would like to release 3.3 if there's no big
> change. But in the mean time some patchsets landed on mailing list, see
> bellow. My question is: do we want to wait until they are merged or it's
> ok to postpone them to 3.4 development? Please let me know.
>
> * https://patchwork.kernel.org/project/selinux/list/?series=561273&state=*
> libsepol: add fuzzer for reading binary policies
>
> it was reviewed by Jim who requested some changes.
>

I am ok with this being postponed to 3.4.
Jim

> * https://patchwork.kernel.org/project/selinux/list/?series=566429
> libsepol: do not pass NULL to memcpy
>
> v2 with requested changes, waits for review
>
>
> * https://patchwork.kernel.org/project/selinux/patch/20211015123100.15785-1-cgzones@googlemail.com/
> libselinux: use dummy variable to silence glibc 2.34 warnings
>
> reviewed by Nicolas, work in progress I guess
>
>
> * https://patchwork.kernel.org/project/selinux/list/?series=566423&state=*
> Parallel setfiles/restorecon
>
> 3rd version of the patchset, waits for review
>
>
>
> Petr
>
