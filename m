Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C47C54E7C
	for <selinux@archiver.kernel.org>; Tue, 14 Nov 2023 20:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbjKNUkE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Nov 2023 15:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbjKNUkD (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Nov 2023 15:40:03 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3D0F1
        for <selinux@vger.kernel.org>; Tue, 14 Nov 2023 12:39:59 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-507a3b8b113so8511416e87.0
        for <selinux@vger.kernel.org>; Tue, 14 Nov 2023 12:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699994398; x=1700599198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ZtaNttSswnaCeePggeWznLFucTRzwo6r+EPt+9gG5Y=;
        b=AJAESboNA0VYgrm4TscmzaWhikEFb0KKFmlhb0kCDmqD0q0cLpWl8l80MFUejMRQBw
         YERtCYpXcJeSjkHYZHYn7LWHhBJGVtHH5uaAzMg/bPSXoQkun1NvG7FdZyjsAz2M2TBV
         i5Jmz/4kXxyDXoIZPaqoJ0mLnueCJdjr1C4kT5esUJxW8kvEO0CEDhTaouJldMpco/Yx
         vUFQ9eAvwrWH5IaVcUXb/4UUfSuRc+p62y9Y1M0XbU4dc2Ed1ry0JG+Yg5XBx2FQd9xj
         g8N/tV3VQHWZpu4q7+CeCfbeJa3VaxcGFRRwWUEhMza6qEvHfKZCCJgehclHsibSQv00
         eQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699994398; x=1700599198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZtaNttSswnaCeePggeWznLFucTRzwo6r+EPt+9gG5Y=;
        b=PFXz9AKVUf97B7Qgf2QQoGFQIKo6jt5lpMDewzwOCBuz/QCHnYqCMdMZY4m977VUPP
         xT2zATFwy26W8Oz8UOMZubJc+0U3rLZlNsIuxKmExnLUmfhZPBepBj9GWMTJyvhLFgFo
         A7wwP1dUWSAdayI8vU6a34TexMpdov5zRsRp7zMRAhhssN+9/Sv9YcvWaiNssokTKMEx
         PjqG79u0JjdoU0WvwWnl4wkprViJDKIBDy/fUoKSd3ozw4p2hh5+EPvSYNWdG54W5VP4
         yuBq3piDmvAGVXYDNVrNQ9ys+fGWJaxSHhUGLqtrfCTFEf5JEbULdxm6jJ3f6Tg4nbAF
         F8sg==
X-Gm-Message-State: AOJu0Yw4IUl3RsUHJRf3wbaGxKnmr38c6SoOaCNh1TG3HCFeizM9PB3J
        0PAZ04D2hSvI61qVAGyC3IKPCwHjriREuFEZjjM=
X-Google-Smtp-Source: AGHT+IGr87PljOv6ujMEiQMIsvte83PVVaHsa0xV9wYKfp7v4OSITF2HrHOtU3FtBNCexdrTtPwTuJTERS0Q5UjlTB4=
X-Received: by 2002:a05:6512:3142:b0:505:7371:ec83 with SMTP id
 s2-20020a056512314200b005057371ec83mr6963743lfi.48.1699994397656; Tue, 14 Nov
 2023 12:39:57 -0800 (PST)
MIME-Version: 1.0
References: <20231113192632.22509-1-cgzones@googlemail.com>
In-Reply-To: <20231113192632.22509-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 14 Nov 2023 15:40:45 -0500
Message-ID: <CAP+JOzRbkFiQWLpxFi+VgRU3gxDSZNuXx2W1Hnk8r01NKjCOfg@mail.gmail.com>
Subject: Re: [PATCH] libsepol: validate common classes have at least one permissions
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Nov 13, 2023 at 2:26=E2=80=AFPM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> The traditional language and CIL permit common classes only to be
> defined with at least one permission.  Thus writing a common class
> without one will fail.
>
> Reported-by: oss-fuzz (issue 64059)
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/policydb_validate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/src/policydb_validate.c b/libsepol/src/policydb_val=
idate.c
> index 016ab655..1121c8bb 100644
> --- a/libsepol/src/policydb_validate.c
> +++ b/libsepol/src/policydb_validate.c
> @@ -369,7 +369,7 @@ static int validate_common_datum(sepol_handle_t *hand=
le, const common_datum_t *c
>  {
>         if (validate_value(common->s.value, &flavors[SYM_COMMONS]))
>                 goto bad;
> -       if (common->permissions.nprim > PERM_SYMTAB_SIZE)
> +       if (common->permissions.table->nel =3D=3D 0 || common->permission=
s.nprim > PERM_SYMTAB_SIZE)
>                 goto bad;
>
>         return 0;
> --
> 2.42.0
>
