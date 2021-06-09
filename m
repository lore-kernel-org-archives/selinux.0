Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3770EC48BCF
	for <selinux@archiver.kernel.org>; Wed,  9 Jun 2021 14:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18E5961364
	for <selinux@archiver.kernel.org>; Wed,  9 Jun 2021 14:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbhFIOlD (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 9 Jun 2021 10:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236482AbhFIOlC (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 9 Jun 2021 10:41:02 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FC6C061574
        for <selinux@vger.kernel.org>; Wed,  9 Jun 2021 07:38:53 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w127so25254729oig.12
        for <selinux@vger.kernel.org>; Wed, 09 Jun 2021 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PU3V+yRuTvZj7xrKNVKpeFZKYaxLgcxlZkWy5an9AcA=;
        b=Nrx2g2ZU/VWOGG4/XtFocoKwj6JPV21VAQaVKidlZ6r+eo0TrOKF2Bvn5A+DUcsiiZ
         Qp450TsPPlUlkOBKZHWvb0KmJdJOPXhYoVHa7vNDTbjogBAqr3Dqn+DYDCnbKClaoCzS
         yii2iDqCi6uFLoIEuDW+22vLsOHnvOZFzdmVVuvwrUdU3DXFfnyq1D13CjoMuqGRT280
         qQWrMjMI6LEuvk5rnfhlc48w2vKlGxYgIWM+B8TcmKl/FAVPxJldkOJhJvMaXHGOLc4C
         5K63gfy6hI97GrD2VPmKpgh03kC+JsSaPBEcuE253Tj7/qFLZB5kPSsZP5JL4Bsb7kMN
         GFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PU3V+yRuTvZj7xrKNVKpeFZKYaxLgcxlZkWy5an9AcA=;
        b=FtFrsVHIM6I9jniNAqSSin6CP59TopkyrbYT6HM3q8twc1eoQ7LKt3Pg9eVTCtRXZT
         Go0yw6Q91N6Qy82K5nSqMbtTZXzx7orQjzLZn6sCcOiJQKLEimXRxTEKNSuYiT15P9G4
         AiF7ySaTQKM78eMDBZyxa+eSAduftDdQTU4gdpUdc26fPboqiw63plw31A0wowXA8u4/
         DQYr0Knf9TmDi9Yvx5yI7gkpNbp/diS+mVVEg3as3N7lh+aYs11mFgJUoRkQk2El6x0B
         IzIVRbo2pJffUbEmwvDUaYYyPMrJ6iVjZ33F5v038DLdKr5VeLEt2uAtdqimzuwT9Wxp
         l1Kg==
X-Gm-Message-State: AOAM530aBgq9hjnxKpBJN2xzYaeDjHRCko9STOtjbL2GFRvDpGkMdkSx
        KEq/h56MEzVtqMRigIp3qf1dZRLkSkKTR6wpRyQ=
X-Google-Smtp-Source: ABdhPJy+6quopirnt2QETZKrSSENCQ7PDjpVDNTqXxyQvyYggRI0RCGwQjLq7XMCVWS/tP6+2263VvLR/GKVwe4+9nk=
X-Received: by 2002:aca:30d1:: with SMTP id w200mr18776oiw.16.1623249533271;
 Wed, 09 Jun 2021 07:38:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210608155912.32047-1-cgzones@googlemail.com> <20210608155912.32047-14-cgzones@googlemail.com>
In-Reply-To: <20210608155912.32047-14-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 9 Jun 2021 10:38:42 -0400
Message-ID: <CAP+JOzRyZ+rqdRp=SjDnjq7bqm1YO+w1EJOVCCm2O30BiKZZMg@mail.gmail.com>
Subject: Re: [PATCH 13/23] libsepol: assure string NUL-termination
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 8, 2021 at 12:00 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> ibendport_record.c: In function =E2=80=98sepol_ibendport_get_ibdev_name=
=E2=80=99:
> ibendport_record.c:169:2: error: =E2=80=98strncpy=E2=80=99 specified boun=
d 64 equals destination size [-Werror=3Dstringop-truncation]
>   169 |  strncpy(tmp_ibdev_name, ibendport->ibdev_name, IB_DEVICE_NAME_MA=
X);
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
> ibendport_record.c: In function =E2=80=98sepol_ibendport_set_ibdev_name=
=E2=80=99:
> ibendport_record.c:189:2: error: =E2=80=98strncpy=E2=80=99 specified boun=
d 64 equals destination size [-Werror=3Dstringop-truncation]
>   189 |  strncpy(tmp, ibdev_name, IB_DEVICE_NAME_MAX);
>       |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> strncpy(3) does not NUL-terminate the destination if the source is of
> the same length or longer then the specified size.
> Reduce the size to copy by 1.
>
> Found by Clang
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  libsepol/src/ibendport_record.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/src/ibendport_record.c b/libsepol/src/ibendport_rec=
ord.c
> index adf67161..2eb8ca18 100644
> --- a/libsepol/src/ibendport_record.c
> +++ b/libsepol/src/ibendport_record.c
> @@ -166,7 +166,7 @@ int sepol_ibendport_get_ibdev_name(sepol_handle_t *ha=
ndle,
>         if (sepol_ibendport_alloc_ibdev_name(handle, &tmp_ibdev_name) < 0=
)
>                 goto err;
>
> -       strncpy(tmp_ibdev_name, ibendport->ibdev_name, IB_DEVICE_NAME_MAX=
);
> +       strncpy(tmp_ibdev_name, ibendport->ibdev_name, IB_DEVICE_NAME_MAX=
 - 1);
>         *ibdev_name =3D tmp_ibdev_name;
>         return STATUS_SUCCESS;
>
> @@ -186,7 +186,7 @@ int sepol_ibendport_set_ibdev_name(sepol_handle_t *ha=
ndle,
>         if (sepol_ibendport_alloc_ibdev_name(handle, &tmp) < 0)
>                 goto err;
>
> -       strncpy(tmp, ibdev_name, IB_DEVICE_NAME_MAX);
> +       strncpy(tmp, ibdev_name, IB_DEVICE_NAME_MAX - 1);
>         free(ibendport->ibdev_name);
>         ibendport->ibdev_name =3D tmp;
>         return STATUS_SUCCESS;
> --
> 2.32.0
>

It seems like the strncpy()s at line 65 in
sepol_ibendport_key_create(), at line 233 in sepol_ibendport_clone(),
and in ibendports.c at line 37 in ibendport_from_record() also need to
be changed.
Thanks,
Jim
