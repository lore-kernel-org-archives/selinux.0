Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFC5C433EF
	for <selinux@archiver.kernel.org>; Tue,  3 May 2022 18:12:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbiECSQC (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 May 2022 14:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241060AbiECSQB (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 May 2022 14:16:01 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC932C11C
        for <selinux@vger.kernel.org>; Tue,  3 May 2022 11:12:28 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o12-20020a1c4d0c000000b00393fbe2973dso1876622wmh.2
        for <selinux@vger.kernel.org>; Tue, 03 May 2022 11:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y+egqV9L8y3eFeMhv6ZutKK7T1tzLZ/rfNLG3LUNd6o=;
        b=W/34bzAh1lhBtzos8guCHd0/zX3bWvWbYuVth3hcTxYYkHVy8oT27vW0JoTNYnIj56
         ppYRvJPq7OyzwFsGqP+z4oE6BG+2mpaR4+5pw4pFPlaCoqbfjbI6pVwft2rU7WNMJx52
         SE1FMCPcPFgBdomowSbteA9bqhG2jXR8pofJYg1CeYNcyt+qM4/E1/NAGiR2ekLAyRK8
         wnnPX+3fs+qmv33h0cEFLKpbrrkwMhzI8hwsXDc1hTQArZJnRu3eJplyH86l/AvYMWC2
         yn61Gw56vdkFYK4Ed8rZr91uml9xTtIg8seEyJBZgWjcnVMJUnbOuO8ms1os2figVgAA
         iC1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y+egqV9L8y3eFeMhv6ZutKK7T1tzLZ/rfNLG3LUNd6o=;
        b=SMFJNqf1FYAuGWpEvJsHcjl51rFj6mVYHqhLygAaMjrreE7nOswJAgqe5Ie5Gmmymq
         8h2df8NRwlJ/6+UTDjSgNPtBJgO4dGAg5ifPwCaeZZWwmh2Jubv88KtK4YEy6WZKSpUQ
         uSwTQmpcWhx2KxVT3Jqbu8e8bigPecngFL5YY3pHQSUs+V/RSYud8rMjs8Lpmfc3HsHK
         DELwOYkFWcOt6mekhrPTktNHBVD1HehOONS3h6xaVj9GjjHA9Wp8Xv+rbST19Dyj6QE6
         BeIQmmA1pQ1Rnkh5v8qA1UNz//xX0my2Aq/WRA/XrPg4pIWTl1GZf1E+lzaqUnPGd/jJ
         zCpA==
X-Gm-Message-State: AOAM532oAz5QtWVeccz5BiCTY/7NXoFvlaTk5WX6D9vUHJwpAGB8ZDow
        g6lee/sjWA1D0ra6Yt6AQwnesE1EqpMthi3VzsVj
X-Google-Smtp-Source: ABdhPJytz8OX8Ah3wwE7RJmgSLXQBG6U3ZrLCpoLAL0w1L0EEegRHrgq31Ox1A7WWX2jFtHyqAazvFArl8RZTJ3ftxs=
X-Received: by 2002:a05:600c:4fc9:b0:394:4317:1aa4 with SMTP id
 o9-20020a05600c4fc900b0039443171aa4mr4289427wmq.179.1651601547037; Tue, 03
 May 2022 11:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220502141524.35268-1-cgzones@googlemail.com>
In-Reply-To: <20220502141524.35268-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 May 2022 14:12:16 -0400
Message-ID: <CAHC9VhSkR5J1KfC647C+7zmz85tj+U+y3HZ=9V9fv5KqMLF3ww@mail.gmail.com>
Subject: Re: [PATCH] selinux: include necessary headers in headers
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Zhongjun Tan <tanzhongjun@yulong.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 2, 2022 at 10:15 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Include header files required for struct or typedef declarations in
> header files.  This is for example helpful when working with an IDE, whic=
h
> needs to resolve those symbols.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  security/selinux/include/audit.h   | 3 +++
>  security/selinux/include/avc_ss.h  | 2 +-
>  security/selinux/include/ibpkey.h  | 2 ++
>  security/selinux/include/netnode.h | 2 ++
>  security/selinux/include/netport.h | 2 ++
>  security/selinux/include/xfrm.h    | 2 ++
>  6 files changed, 12 insertions(+), 1 deletion(-)

Merged into selinux/next, thanks.

--=20
paul-moore.com
