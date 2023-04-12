Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991AAC77B6E
	for <selinux@archiver.kernel.org>; Wed, 12 Apr 2023 20:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjDLUpP (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 12 Apr 2023 16:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjDLUpO (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 12 Apr 2023 16:45:14 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DA5212E
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 13:45:13 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id u13so13364232ybu.5
        for <selinux@vger.kernel.org>; Wed, 12 Apr 2023 13:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681332313; x=1683924313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XL6T+vmm0Rc4gW66ivkbmmhK95gAuyKfoeaKPtj3Nb4=;
        b=GexvCMe4ghtbxnb4g5Q9Dz9bVjpKZHOMpEjb3z/FrzykrfttaHabfR2Fq9CdkCZQjY
         DunD9ksp6H70ApHFUb0pEh1z/xh8AGnuE4z/PTXNi4T9iYxMCXxRqI3DzV8AcmMk9hef
         3J0BSGtqvak+OAcBnxBG64Lw+Ovn3VNHO/OV56G+d8GC6hH/avPUMXiBm5/i7FqmqkSe
         MklKzYf1XPoP2Mrc+fPLw6mi+H27xQJHh9/BntZRKlo5VfZIJ1ouKNjEKZA33bsTWaDY
         aFu7cWudC0JR9oHrPpD5xLLJgO5Sl39PzML3ab+iSYtSpj+gqa2P80aHfbEVS/yjVUEc
         9QbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681332313; x=1683924313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XL6T+vmm0Rc4gW66ivkbmmhK95gAuyKfoeaKPtj3Nb4=;
        b=OHtZE2jsL+oQ2YMrgL3UI0oZH9YVjlyx5ipe0RRgwHOlzsd2Z1SpNWtOiyQffN8pZ+
         +GOTfTro+Y/jRlvfJhZftLip35l9vf06e6c51IlTzrs24olRJQxweVWZPkSDhuykyCuS
         WxB0yUKqcR0FzNkxEDLCp+KC3de9Qwas63kK1f1ldAX88U74wK+/GzaxmsfMuKgwRQL0
         yZx6mLf0cF834NyplPJeByvLuOMTwjgY1/e4VOMqq4WIvxiyp2LvZW0cPyj/QLvoHk3S
         4Ecb9hBq6sBtnIaCqFaWws4i+SRq/InnBAq5WqlWAa5RgSTKLht3RH/vyXRHIWzB4XgC
         9HcA==
X-Gm-Message-State: AAQBX9czWiOcibmvW4q47u7nDbmND3ZIDphPOPvKPG0GKszu6XWn7o+C
        7D3XyunqUFp70N2NRC/T267LNkJWE0TQkNMIoPLj
X-Google-Smtp-Source: AKy350aZu9VFCw06XkrW4Ya24zJTYMq5yPhjMOaghdQ21tD4U9hT7fRaMJWFVP9A1cumn+M8lkVOt5grukVZuqfv8hk=
X-Received: by 2002:a25:d88e:0:b0:b75:8ac3:d5d9 with SMTP id
 p136-20020a25d88e000000b00b758ac3d5d9mr4910864ybg.3.1681332312854; Wed, 12
 Apr 2023 13:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230412135919.582613-1-omosnace@redhat.com>
In-Reply-To: <20230412135919.582613-1-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 12 Apr 2023 16:45:02 -0400
Message-ID: <CAHC9VhSk-POKTV=JK6xakhL0PCB2tSe50RtBK+p=mBovprO8wQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: fix Makefile dependencies of flask.h
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Apr 12, 2023 at 9:59=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> Make the flask.h target depend on the genheaders binary instead of
> classmap.h to ensure that it is rebuilt if any of the dependencies of
> genheaders are changed.
>
> Notably this fixes flask.h not being rebuilt when
> initial_sid_to_string.h is modified.
>
> Fixes: 8753f6bec352 ("selinux: generate flask headers during kernel build=
")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  security/selinux/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks Ondrej, I just merged this into selinux/next.  You also
inspired me to fix a build bug with av_permissions.h that has bit me
once or twice :)

--=20
paul-moore.com
