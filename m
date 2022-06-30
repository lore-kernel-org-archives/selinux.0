Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDF0C433EF
	for <selinux@archiver.kernel.org>; Thu, 30 Jun 2022 18:45:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbiF3SpR (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 30 Jun 2022 14:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiF3SpQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Thu, 30 Jun 2022 14:45:16 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F9B2CDDD
        for <selinux@vger.kernel.org>; Thu, 30 Jun 2022 11:45:16 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id m24-20020a0568301e7800b00616b5c114d4so42434otr.11
        for <selinux@vger.kernel.org>; Thu, 30 Jun 2022 11:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WWlR/oqt/l5ddBe+RJCylJPY2KyqRJH4EYs6wMOLBRc=;
        b=EopE+TSmYiMA60T6+hs7CCSkTYn0G5NmqQ5KqKVEf+WPVzcJR7pbSg69VYrXLACP8Y
         fWctrGc1zDuHWWEE1Gn6Xn8WNleY/VNE5c3L4sU42z7OgKej+Qj8VRGkVpyzttsIxd4Z
         NfRpcmD7s1BI57jIEkeivcs029c9jjKjJEeZ0y8szelSCmltKFHG8EqpLWWiCWskYNyH
         VDWV+ZeCer5yiYF2covVIaZZLHXQvplYYNXMr3Dbiu7biaele+LrfKWg46Ks3isxLYu+
         nQfrC988wj6YqwcxVL4CRzhMhFwF/Sm0tFaA2zyc36nlOCF6ifcQ7MmMMeT0rU74R8oX
         brdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WWlR/oqt/l5ddBe+RJCylJPY2KyqRJH4EYs6wMOLBRc=;
        b=s0NhVfSJk603iRu5NJc9wHVHAIRMXcfuvxNZuLf6/GN7mhVyBt9VnpA13Zfql6ctsO
         vG770QSi0MUpz+cyNyzq5I8UQbRIs9W4z3YzimxhMBgExDwhYF829FV7rhygTUmVUu3g
         pWK40jEm+NiIZiMh5CKZ4Z58O3m85nS5+6wnqmQLG8Jzc2wmpqOhbHIRZKOz925o0hIv
         E4+mNHSClMsYZgCupwsEy8vWCyG1xpuhjaLRzSMgC73TMTYuqewRAgRDXpaWAS/9Qg3q
         WdKB48bAZ52kVaYrGBrn+0MOsXqr0GhqJlWsRBeRojUrzuzbu0bjfmdNA2RSfUTD0FBr
         A5pQ==
X-Gm-Message-State: AJIora9nVXVO1+Mj8vPq4ELf9Q8c96Md/A3Sb0/mlrDw6nLUjcJSbMgj
        icdysxkd/td9GevJqnQJ0i3Wp+g/Q/tw9nMjj/ughbckqyU=
X-Google-Smtp-Source: AGRyM1tKEYOB/nSDC309C4H9vIsmeaRrVbLSCu9PJdZhn3IQ3L1LgawWHT0Sq3avbdEqZpB3CzXGNLRwJtnKHLU/7/8=
X-Received: by 2002:a05:6830:2801:b0:60c:76b1:d23c with SMTP id
 w1-20020a056830280100b0060c76b1d23cmr4877668otu.154.1656614715400; Thu, 30
 Jun 2022 11:45:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220630170301.4431-1-cgzones@googlemail.com>
In-Reply-To: <20220630170301.4431-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Thu, 30 Jun 2022 14:45:04 -0400
Message-ID: <CAP+JOzR=h5BhpztbZ-z3P_vq5kk3=9gvPaDhO_Uf7KrRuAyCSw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: do not modify policy during write
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jun 30, 2022 at 1:04 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Do not modify the in memory default_range value of a class datum while
> writing a policy.
>
> While on it fix indentation.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/write.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/libsepol/src/write.c b/libsepol/src/write.c
> index 48ed21ea..a9fdf93a 100644
> --- a/libsepol/src/write.c
> +++ b/libsepol/src/write.c
> @@ -1097,16 +1097,18 @@ static int class_write(hashtab_key_t key, hashtab=
_datum_t datum, void *ptr)
>              p->policyvers >=3D POLICYDB_VERSION_NEW_OBJECT_DEFAULTS) ||
>             (p->policy_type =3D=3D POLICY_BASE &&
>              p->policyvers >=3D MOD_POLICYDB_VERSION_NEW_OBJECT_DEFAULTS)=
) {
> +               char default_range =3D cladatum->default_range;
> +
>                 buf[0] =3D cpu_to_le32(cladatum->default_user);
>                 buf[1] =3D cpu_to_le32(cladatum->default_role);
> -               if (!glblub_version && cladatum->default_range =3D=3D DEF=
AULT_GLBLUB) {
> +               if (!glblub_version && default_range =3D=3D DEFAULT_GLBLU=
B) {
>                         WARN(fp->handle,
> -                             "class %s default_range set to GLBLUB but p=
olicy version is %d (%d required), discarding",
> -                             p->p_class_val_to_name[cladatum->s.value - =
1], p->policyvers,
> -                             p->policy_type =3D=3D POLICY_KERN? POLICYDB=
_VERSION_GLBLUB:MOD_POLICYDB_VERSION_GLBLUB);
> -                        cladatum->default_range =3D 0;
> -                }
> -               buf[2] =3D cpu_to_le32(cladatum->default_range);
> +                            "class %s default_range set to GLBLUB but po=
licy version is %d (%d required), discarding",
> +                            p->p_class_val_to_name[cladatum->s.value - 1=
], p->policyvers,
> +                            p->policy_type =3D=3D POLICY_KERN? POLICYDB_=
VERSION_GLBLUB:MOD_POLICYDB_VERSION_GLBLUB);
> +                       default_range =3D 0;
> +               }
> +               buf[2] =3D cpu_to_le32(default_range);
>                 items =3D put_entry(buf, sizeof(uint32_t), 3, fp);
>                 if (items !=3D 3)
>                         return POLICYDB_ERROR;
> --
> 2.36.1
>
