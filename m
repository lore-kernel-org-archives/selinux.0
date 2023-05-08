Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE87C77B7F
	for <selinux@archiver.kernel.org>; Mon,  8 May 2023 20:42:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjEHUmj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 8 May 2023 16:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbjEHUmj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 8 May 2023 16:42:39 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB4B5598
        for <selinux@vger.kernel.org>; Mon,  8 May 2023 13:42:37 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-b9a7c1b86e8so6583313276.2
        for <selinux@vger.kernel.org>; Mon, 08 May 2023 13:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1683578556; x=1686170556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90+Ng9xKxtbak9gPeRrz0hsuLESmF02IThMEDZGiews=;
        b=OsSbaB7bMm8NdxgVqQWjIylwFiSHsfywygqJ9rp71mN0ujnkF/aqb6+wWVRE9m0osE
         hO9gNA2+KwpIu85bitCUzqz1ZtocQHN78uzFTGGZEuQljEmQfnCRmHdzEWVu2aIpbRs3
         YasW7taQcRWVFHKQkwtN1WCfQ77sfruC6rpmUioVSeNrjLjnuUqsZ+gmBHCm+u3ibWkR
         IbSKj/VLHJQTgxWTG48SsA6fXar0EpqK921Ox/6iwzzwxwEbEfOU+43KdL+XYP6F7/Y7
         dEGie/BRkjETDLMq1tmKRvyYxMsaRLScll93ZpcaREmIR+W0bTbTh1QmAy/dKXNXYVz2
         hAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683578556; x=1686170556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90+Ng9xKxtbak9gPeRrz0hsuLESmF02IThMEDZGiews=;
        b=fVk7stMieCNR0+6O3dckAujK9F2GSjx4bf6vvaPt93FgleZMMTRPc4GHrrjVzK44il
         cTwMIJVbT6SbzCocYi8vip9Frir3NzRCPrvcOWzG9NJJp69mmaU1+SB7ks0D8a1XzEE/
         MeWMQW0wGbwrfZhjD8eyI4/YFzyIi98uxjBlNtJrC5SOkHTf0I42wi3U4FJV3RVL9/p8
         MAP5Ucmwy8IjZfXZG5MRkH6eBmi8Ax3GNyTddrjKFEyKO2hYWMCfxXQS+zCBFwuqAwps
         ZiTx7NWQzIo4Xaj2ndDSUJkdKQjHDd+0ZTc8WNj9AuQZQ3fk62ao4NNd7jXhOqYOlTdr
         kSWw==
X-Gm-Message-State: AC+VfDzKHj7it+5hMOBKih4hkD2wwD/dJ3fFwSWRQQdM5FobxrSCq6Fg
        H23r7jIS+FBvtfzRC5wQMogDr0O2dZ5EesJfIkLl3OU0CLacJDU=
X-Google-Smtp-Source: ACHHUZ7lIckyZ+2egoVH4oaVl2Var7ngoWZ5P9THzyUCdKNQFgUcm1j8yt+JhJ3lkel/wm5ZeR1CKKwNuFKuWnP5ryw=
X-Received: by 2002:a25:19d7:0:b0:b97:1e2e:a4e5 with SMTP id
 206-20020a2519d7000000b00b971e2ea4e5mr11215991ybz.40.1683578556254; Mon, 08
 May 2023 13:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230420150503.22227-1-cgzones@googlemail.com>
In-Reply-To: <20230420150503.22227-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 8 May 2023 16:42:25 -0400
Message-ID: <CAHC9VhSA_i0xcjPEkoTYhnoG4oFjzzBqmN5d47=mNuPhbpyAaQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] selinux: do not leave dangling pointer behind
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
> In case mls_context_cpy() fails due to OOM set the free'd pointer in
> context_cpy() to NULL to avoid it potentially being dereferenced or
> free'd again in future.  Freeing a NULL pointer is well-defined and a
> hard NULL dereference crash is at least not exploitable and should give
> a workable stack trace.
>
> Fixes: 12b29f34558b ("selinux: support deferred mapping of contexts")
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/ss/context.h | 1 +
>  1 file changed, 1 insertion(+)

Merged into selinux/next.

Did you actually run into a problem where the system
crashed/panic'd/etc. due to this?  I'll leave the fixes tag on this
since it is pretty minor, but generally I think it is best to reserve
the fixes tag for problems that can be triggered as a fixes tag
generally results in a stable backport, regardless of it is marked for
stable or not.

--=20
paul-moore.com
