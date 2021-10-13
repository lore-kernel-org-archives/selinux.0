Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D4CC433F5
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 20:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD727610CF
	for <selinux@archiver.kernel.org>; Wed, 13 Oct 2021 20:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhJMUg1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 13 Oct 2021 16:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhJMUg1 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 13 Oct 2021 16:36:27 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8AFC061570
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 13:34:23 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id i20so14745611edj.10
        for <selinux@vger.kernel.org>; Wed, 13 Oct 2021 13:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=nX0OIc5IFkqLxitkjs+/bYTQJHzu5cYEySXDqk5EDy8=;
        b=M4ziJ7OKz5UGTGo0nkJOGSKqZ4rDpD28D9UVsOEIghbYOiX3fjF1RBOe3GtQ+V30kI
         Md+ZEfAucjge74IdgGJIMjMfE+3TGnhNvRLTBdUB2IFgDfdLYXf3NLV9B/yjRpcuPX/k
         aasHp3VNvlSOOFxCjCWYmcmCIATOiun5WUMfaGMqmqmCyilP8ZBQAJ+dB68EVLj4Tdh+
         megbMJlUFaG5DPFi8wy0meci9Cr5ibm89nxmhPCsCSMpWgijLiLZ6UpRtTOUzv/r9ogv
         O2b3J8gvkfc2JiPtpzsZWZZDi4CVcYGglxnnYeoRF70VVdcdNYY+n/X8ed95aKNs9rtE
         WvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=nX0OIc5IFkqLxitkjs+/bYTQJHzu5cYEySXDqk5EDy8=;
        b=U93N2LOfNVV43OYFAiAi4HPCjVYgUmE71DjHpSTcMLMU1vVPg3pg+uf1di5ZOs0HZk
         tQgEjtmcYhHaSosrturdIUSAW4OZPm7of3Sr+rqjm0WLF3Nr/O9pM8r+/2nplTIl8Ou7
         mFkqQVdw2ONaX48h5+sqFCmzOe6TMGcR+3IL+d09XZ1hIA9AxHbShfeeO23YjddhCNUZ
         XTXoLtklTRi38aJDxTGgMp4oLSlIfUfey0uNqZz7JNpAyQkkz84/e8GPpqbobQWCicac
         +AmlSqOzydrtRFIAfRSSJmo5Cu/A2W/vHr/HW3Je4vbuvg9uQX78Cp9VbDsvK/ADw8eq
         t8Ng==
X-Gm-Message-State: AOAM533pFqHlEjWeZm6lZfKGxyEIU1r1TwQjpvUm+DRFAPG6HPOvq/pA
        RjDqqUlcrR6u+pZgZ/4q5lst35LDu/80XOhPWFMExSlJkg==
X-Google-Smtp-Source: ABdhPJwGT00ckCFKlAo47LtJJsmerwD8+f2t4KdvLE6oYZnjfLQ26/NPRwKPrCHmOztfyqniHJSGHUCWjp0DMXAfeIc=
X-Received: by 2002:a05:6402:5114:: with SMTP id m20mr2331484edd.256.1634157261354;
 Wed, 13 Oct 2021 13:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <163414936359.182539.7706872229418810020.stgit@olly>
In-Reply-To: <163414936359.182539.7706872229418810020.stgit@olly>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 13 Oct 2021 16:34:10 -0400
Message-ID: <CAHC9VhQcK7cFT5CVXB3g=jYgTKo1ishoe9uFX69YHtWmSm_Ubw@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix all of the W=1 build warnings
To:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 13, 2021 at 2:22 PM Paul Moore <paul@paul-moore.com> wrote:
>
> There were a number of places in the code where the function
> definition did not match the associated comment block as well
> at least one file where the appropriate header files were not
> included (missing function declaration/prototype); this patch
> fixes all of these issue such that building the SELinux code
> with "W=1" is now warning free.
>
>  % make W=1 security/selinux/
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/avc.c         |   13 ++++++++++++-
>  security/selinux/netlabel.c    |    7 +++++--
>  security/selinux/netport.c     |    2 +-
>  security/selinux/ss/hashtab.c  |    1 +
>  security/selinux/ss/mls.c      |    4 ++++
>  security/selinux/ss/services.c |   14 ++++++++++----
>  6 files changed, 33 insertions(+), 8 deletions(-)

Merged into selinux/next.

-- 
paul moore
www.paul-moore.com
