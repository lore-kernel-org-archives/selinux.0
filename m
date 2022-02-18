Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E72C433F5
	for <selinux@archiver.kernel.org>; Fri, 18 Feb 2022 15:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236189AbiBRPoq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 18 Feb 2022 10:44:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiBRPoq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 18 Feb 2022 10:44:46 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A694C229E40
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 07:44:29 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id l73so8186072pge.11
        for <selinux@vger.kernel.org>; Fri, 18 Feb 2022 07:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=doT7bK7EPrJiz241mVjN8JSE6X0c4y1Cn7yH47MmQuY=;
        b=f7IrV8Co4YLWgbQabeAxKnaaARwhRRuipRCEkgrAJCQqP2XFBjrXQKuLiqPrbblMp4
         1I0PyweE1qWbuBRwiem9GlWvoesOq6Y1GB8AnDJbzrRXaD1VWQKp8irajqq+k55dCKAi
         CseUDopHDjNGPOjBaX9WvpduIweYhYqPDAMXxxYv0yiDD8iPLrA7BZIetCe3CCIYdVYV
         ASZLZRL6vD/Zv40jqnzmkhX/ZXHdMbZSSn8xdx8/UI1a++gVGYKlWrJhfahzStHzBbVt
         iFKohUn9z3TIl5lLqD6/ZqoBkVkbxJ6dRJy+TTq14nDy33ykAI0H/nBHragcZH98I9mN
         Pgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=doT7bK7EPrJiz241mVjN8JSE6X0c4y1Cn7yH47MmQuY=;
        b=n2ScURq+CIsY+OPOXVdu6E9hcMN6ClCknKnDs2nh9Y6PQs7GATTsSyXElep7sy79CS
         LwnMK4VCmR05xP4K/O6yYj7ZHyiSmtqVlqWqIeHExYienTwU0wE9cJaxEMBi9ZufZYqO
         CaSrKuXNU78rQek6owxJsJQqO/m3z/EGAaKk4papixwZft9x46eSNLHA2OOzZeD1fE9e
         pEU3llUBpupp0xVR4V8VUmyTeOP0T8uv1KuD6KCUgVKxbO2yfjYEC7nAaHvoq4tpNFIH
         alaX8xlMRbgp21yxaCwWCa6+489RcEG7+t6EMUKiO+Z3THrpYCTb9/mZXmUNU7actBku
         gKAw==
X-Gm-Message-State: AOAM530wzqd3kEq2y0/vXEPe30xVtVptqxv1bQP73rf7PngGvvBDmX8J
        JLKc3RE4AItgxPMRQlj7PpYdk4nEelMdfMAgWXuY
X-Google-Smtp-Source: ABdhPJzPTn2nMsDVP8pfZnyivdp+JN2LbHE/ubEBj9MgLJGKutLru+hZtPhdSKHgoM+BCyRoh2SY4sYUhFcJlHlQacc=
X-Received: by 2002:a63:da4d:0:b0:36c:2302:1940 with SMTP id
 l13-20020a63da4d000000b0036c23021940mr6764465pgj.261.1645199069118; Fri, 18
 Feb 2022 07:44:29 -0800 (PST)
MIME-Version: 1.0
References: <20220217142133.72205-1-cgzones@googlemail.com> <20220217142133.72205-5-cgzones@googlemail.com>
In-Reply-To: <20220217142133.72205-5-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 18 Feb 2022 10:44:18 -0500
Message-ID: <CAHC9VhQ6hTa2ZrNHBWeE2hcr9uAbD1r351oZvxRzO6H357-H0g@mail.gmail.com>
Subject: Re: [PATCH 1/5] selinux: drop return statement at end of void functions
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Serge Hallyn <serge@hallyn.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Austin Kim <austin.kim@lge.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Feb 17, 2022 at 9:22 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Those return statements at the end of a void function are redundant.
>
> Reported by clang-tidy [readability-redundant-control-flow]
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/hooks.c          | 2 --
>  security/selinux/ss/conditional.c | 2 --
>  security/selinux/ss/ebitmap.c     | 1 -
>  security/selinux/ss/mls.c         | 1 -
>  security/selinux/ss/services.c    | 2 --
>  5 files changed, 8 deletions(-)

Merged into selinux/next, thanks.

--=20
paul-moore.com
