Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 867A5ECAAA1
	for <selinux@archiver.kernel.org>; Tue, 30 Aug 2022 20:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiH3U2C (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 30 Aug 2022 16:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiH3U2B (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 30 Aug 2022 16:28:01 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899D476471
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 13:27:59 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-11f4e634072so5315365fac.13
        for <selinux@vger.kernel.org>; Tue, 30 Aug 2022 13:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ILs+3Gk6I7yM+s5w9W2XlXLcFie3L1z8g352KV+BqGM=;
        b=QS/UAm96K8CqO69ixyOwmxU+q3UF78G4ywHicDQH0UzEelZzizqIonli2UT+tc1MD0
         yoyUlEZUbx+knPIGGB6jU8gv4eUosAta5byLZ6v9hZvm8mprzY7/43zxiwSYIXKHQKyU
         D56wWVQYnwPypikBhQspsgr5ldrXNvH2oy39Tx0cC+QbD+4aM5Zvw5Jws0Y7joCaLkR0
         I6Nd8xJnR/huWRzj1P0rMaVGkxPZRIYEdPtv8AXj5IZvv6nYVToMjTP2J5ivdzwHMSCz
         YzMSAkUKGQBybw9X3bUKijVqrFU2/agxnYRoRCGod5i2tzQr7X9OY6uyQgUERUVBw+GQ
         2iFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ILs+3Gk6I7yM+s5w9W2XlXLcFie3L1z8g352KV+BqGM=;
        b=uni2jUXSfuX62qxveSNzOOH2OAJxt6VUdJfwLcfsDGIFDoZBrziuvQQpitl2Xk/lA7
         TL7As+dqNJbirZWEPCTaJnoSj2YoyyQ5wKmP9ldTbqOJqWU9tgj2IJxxaXhQhSIqKM6Z
         DNg1gtZ2XCIwEUJsrR3rsr0cL8TRCmUhnwygKcVr0pfaPi9+9uFDHl9boZ1AbESYn8X1
         xid2slgt6+5CnVCDCnrvDlLQo5vmDnWJhVp2iM0vrwNmAg/LDM5XTce5di/eqdt9Isle
         lFPudkLaWgkQ/HiYvr1CndeO2WB5yAvO3V1HBsKsT77fdo3165Clfn3HVvfsV0i0+2Ox
         YLdw==
X-Gm-Message-State: ACgBeo1Uh39ezV+VqlTd9JT3C6VJgSqvwc2Une1zrLk0x69xvAKa8znl
        NXBrURDfPo1TsEgMtKWM6x+mJvdAWat0OoWZNXJWYAukMw==
X-Google-Smtp-Source: AA6agR5GXY/SSUrrKA0f+B0gOebBUix5D+aX5TyY5xdYvfX0NMft8c+ica2iPBq+WzI+kwdMyHsXODwzMF9N6YCF8yM=
X-Received: by 2002:a05:6870:a78d:b0:11c:437b:ec70 with SMTP id
 x13-20020a056870a78d00b0011c437bec70mr11344787oao.136.1661891278876; Tue, 30
 Aug 2022 13:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220830084124.284688-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20220830084124.284688-1-ye.xingchen@zte.com.cn>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 30 Aug 2022 16:27:48 -0400
Message-ID: <CAHC9VhSGL7d_dSM-oLbH8wiAoms08U+53csKSET-gygk7gqrwQ@mail.gmail.com>
Subject: Re: [PATCH linux-next] selinux: Remove the unneeded result variable
To:     cgel.zte@gmail.com
Cc:     stephen.smalley.work@gmail.com, eparis@parisplace.org,
        selinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Aug 30, 2022 at 4:41 AM <cgel.zte@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Return the value sel_make_perm_files() directly instead of storing it
> in another redundant variable.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> ---
>  security/selinux/selinuxfs.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Merged into selinux/next, thanks.

-- 
paul-moore.com
