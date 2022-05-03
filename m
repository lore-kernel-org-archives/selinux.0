Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1038C433EF
	for <selinux@archiver.kernel.org>; Tue,  3 May 2022 19:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbiECUCq (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 3 May 2022 16:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbiECUCp (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 3 May 2022 16:02:45 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E8F7403C3
        for <selinux@vger.kernel.org>; Tue,  3 May 2022 12:59:12 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so3219941pjb.5
        for <selinux@vger.kernel.org>; Tue, 03 May 2022 12:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=br876lXgoKnwNSah9sz+Nro9CuCjWyEdAR5ePv2IfYc=;
        b=6fuea+VF2h7bfZGs4cNm6a/vwBAOvCpaUnQ4ck8ginaLolPOwrrZQP+oOTTEiMNhT8
         I6J0sI+mHmDRQuYDcG6bFQ4nCzwZOUX4fO+fzzywiBtzPHy3QkYGA3KiEx0Y7O40yV7S
         qOMqt50XcklYwLTzEfbFIhHalmMuEFCyHg8cCKsidEnACQj9itWPCqDRmbXwtikUmjVe
         gXdIuRsTzljxw8/JnOtusAf8OSXimTvZubtWOFWUI4f9LfCOsC5IbvYzQZowuQ2hAXoE
         OFvsgRnK4Lm2oYtHZcnyGtfrfmYX8MU+Lp8u0Ki4X1amSfvFQFX292i6SM/BvcxsCDt3
         l9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=br876lXgoKnwNSah9sz+Nro9CuCjWyEdAR5ePv2IfYc=;
        b=KaOXjzTzpJmvauBnOg1puzgil/t2kg6X3frBMG1y/1VQPGcPZtzt4WIc33tZUMwrMi
         i06s/NuyIjuiGz2z14lOTCGhY1aev3RcCEs+oO0Yfl+Ez2Fnz3UCnCNax2DWWgnoY9Sx
         7rHKeMc1eRXuiXhqc/0TPDKA6Q1ZfXt6tbju4Wz0KhzbeLTy2ut6+JJZHyJrPJwldvH9
         z6oyiE8njL90TZS6aryiNmGeDRCVsxDIAPzjgekW+m/NLEjIl4cnKiJg7DQugs5oSwCX
         xpkAP87bjImDrlyAkl4ALqDPqUacweTbOUkbm5Sg8wEed4P+irP+Cy3XcbrLSy9zKuXS
         dOsg==
X-Gm-Message-State: AOAM532dPlA/X9oYrPtgBoQ8ILIqxNRNZJTDgO7bk6Pvq6lrTkGhBU9+
        34Z000+A87PuCl38jzPRvasB2QleEnm78VchsFbA
X-Google-Smtp-Source: ABdhPJw9EKdTly/DgbIhDLGWnjmswNtCrk+mCRGjhS0WEEm/jYfwLptQ0upL2OqF4YBy3SqWNTxHqLPrA3t+E5bU2ZM=
X-Received: by 2002:a17:902:b094:b0:15c:dee8:74c8 with SMTP id
 p20-20020a170902b09400b0015cdee874c8mr18054438plr.6.1651607951529; Tue, 03
 May 2022 12:59:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220308165527.45456-1-cgzones@googlemail.com> <20220502144345.81949-1-cgzones@googlemail.com>
In-Reply-To: <20220502144345.81949-1-cgzones@googlemail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 3 May 2022 15:59:00 -0400
Message-ID: <CAHC9VhRhi_dA5XyvQpBmh3aBz-zLp9y4iGuGc4pV2qKc=Q-ouw@mail.gmail.com>
Subject: Re: [PATCH v3] selinux: declare data arrays const
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jeremy Kerr <jk@codeconstruct.com.au>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Michal Orzel <michalorzel.eng@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Austin Kim <austin.kim@lge.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 2, 2022 at 10:43 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The arrays for the policy capability names, the initial sid identifiers
> and the class and permission names are not changed at runtime.  Declare
> them const to avoid accidental modification.
>
> Do not override the classmap and the initial sid list in the build time
> script genheaders.
>
> Check flose(3) is successful in genheaders.c, otherwise the written data
> might be corrupted or incomplete.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v2:
>   Drop const exemption for genheaders script by rewriting stoupperx().
> v3:
>   - Declare some additional data array const
>   - Do not use static buffer in genheaders.c::stoupperx()
>   - Check fclose(3) in genheaders.c
> ---
>  scripts/selinux/genheaders/genheaders.c       | 75 +++++++++++--------
>  scripts/selinux/mdp/mdp.c                     |  4 +-
>  security/selinux/avc.c                        |  2 +-
>  security/selinux/include/avc_ss.h             |  2 +-
>  security/selinux/include/classmap.h           |  2 +-
>  .../selinux/include/initial_sid_to_string.h   |  4 +-
>  security/selinux/include/policycap.h          |  2 +-
>  security/selinux/include/policycap_names.h    |  2 +-
>  security/selinux/ss/avtab.c                   |  2 +-
>  security/selinux/ss/policydb.c                | 36 ++++-----
>  security/selinux/ss/services.c                |  4 +-
>  11 files changed, 72 insertions(+), 63 deletions(-)

Thanks this revision is much better, merged into selinux/next.  I did
have to apply parts of this patch manually, so if you notice anything
wrong with the commit please let me know.

--=20
paul-moore.com
