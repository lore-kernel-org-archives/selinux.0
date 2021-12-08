Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23008C433F5
	for <selinux@archiver.kernel.org>; Wed,  8 Dec 2021 20:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240095AbhLHUSW (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 8 Dec 2021 15:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbhLHUSU (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 8 Dec 2021 15:18:20 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1C4C061746
        for <selinux@vger.kernel.org>; Wed,  8 Dec 2021 12:14:48 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id o20so12253793eds.10
        for <selinux@vger.kernel.org>; Wed, 08 Dec 2021 12:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5oWqSVCqNBfUBWB9hN5Iu/Gof5bqyFXqf/WVDt/VNFk=;
        b=K4duuY/jyanAi/mns0jsjbwKxbaIfpc1jOr3aSY+qK3eZKZh2Bztr6I5VK4SySkOWQ
         D6piFKEZjqJfdOBLbjHFGh7Kj8hWdYLaE6AK9Ww7r/sN+O8wx5xb9vIBI0RhK3ICfBjC
         MsN0oo8A3Rre2ISixlhrgfRj/MIjj99WWjFTLZiv+XPUFRZohmRbJwAQigjP5eKp5WhB
         HQvUKbfcQCNESSOGyTjOTxP0kwuWvdDis4Cam4SGpyutqfbmT4zZ+/UuG3VZQt+C9ex/
         qZ8A8YVe6IrWjH9E+9tLU2cY/TmdBktATEhsEI+JSMwA6xJZCYhECtTaLDbTcasu5+mh
         ChFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5oWqSVCqNBfUBWB9hN5Iu/Gof5bqyFXqf/WVDt/VNFk=;
        b=kUIZlmZvJBn0rTzbsfUIN4qngWvRWvl6idTNkfwSd0eh5jVKfJGj7fhsZTcfZOhkzX
         NzEzc5i1VetZ5WAvAtwWvCr8NRUcgd4njur52ddph6g06XjWXINzrhzRs+pUS+PdQgfn
         vn+PC1rGDaLDttnH+6rI0mMyTRfvgIiRUK+7Gf/QymhaGiibbGHzIzR06fCvmQqlb7wB
         iN6IpZqYuHRg0UqZAxxr4IbJRo9YUeftjY+f47WgdLZbA8H9rp/Isuim3RgcdnJCGZPM
         opKgQzSFp458rYRHOBrk/MRB4P1qMF9aFOfOnFFY/qJigyNn8T+oT5Bm2gq2jcS5EjbT
         BrAw==
X-Gm-Message-State: AOAM5318mdD3Poo0JmFU0abmb2TnG7++QsL+zCBaMJnVxmgbZ+QA5V6D
        M+MMtW2PfSPgyGbuP19+A0ZJ4vEktntgt/Tg6nhZVcvbPw==
X-Google-Smtp-Source: ABdhPJww4XZH4Eo75poSEttxyCAmVsaUVoboTHX7nbaHg6K61Z9xuJ7b55p3E8hV5QVUZa6LdAFiTdky30DNd0rKOWM=
X-Received: by 2002:a05:6402:4311:: with SMTP id m17mr22281757edc.103.1638994487095;
 Wed, 08 Dec 2021 12:14:47 -0800 (PST)
MIME-Version: 1.0
References: <20211208121654.7591-1-richard_c_haines@btinternet.com> <20211208121654.7591-8-richard_c_haines@btinternet.com>
In-Reply-To: <20211208121654.7591-8-richard_c_haines@btinternet.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 8 Dec 2021 15:14:36 -0500
Message-ID: <CAHC9VhRVwwNCC3kPHi4Vm4JfJqfzVo2cQ9Wbouj3ZxERoF4V7g@mail.gmail.com>
Subject: Re: [PATCH V2 7/7] title.md: Clarify example code location
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Dec 8, 2021 at 7:17 AM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> Clarify that the example code is not embedded, but linked.
>
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
>  src/title.md | 7 +++++++
>  1 file changed, 7 insertions(+)

Merged, thank you.

-- 
paul moore
www.paul-moore.com
