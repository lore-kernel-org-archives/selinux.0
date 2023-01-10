Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DB0C54EBC
	for <selinux@archiver.kernel.org>; Tue, 10 Jan 2023 15:31:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbjAJPac (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 10 Jan 2023 10:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238544AbjAJP16 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 10 Jan 2023 10:27:58 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514BF840A5
        for <selinux@vger.kernel.org>; Tue, 10 Jan 2023 07:27:56 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id gh17so29624994ejb.6
        for <selinux@vger.kernel.org>; Tue, 10 Jan 2023 07:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXA7WmrntHr9VrAveRxt/3RPqL+RKxCpdaryWvWvF4Y=;
        b=p1lYn+IB+GVyWXwsf89SeFi9xxMMTax5qCW9SUiMV5hV7PKOUyPcta8Wf8aUprdzYy
         cld5SaLS+PW6hk8orgRjb4il00W1oLCzfK10yxYE0zva0PLNON1DKbh0FTwARgdBnsP6
         TXc+I6D0ENDMDTxnRLp+vTYjHWcog7I+F34KXus1h/TzsQ7aHCPj/ktcTxEWrGfPrjgx
         9dApLGB1JZLeL0pgVv35RisAUwKKLuRtGKto6qGcWLA9vuEEGv7TqW5Dx87cBtnm+KRx
         DpHsJKy7GKEctdQNtC4qJToxeAAkNk031zE830olUOSVGSW3QQnrlvoZ2kRcoxDMnaSM
         d6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXA7WmrntHr9VrAveRxt/3RPqL+RKxCpdaryWvWvF4Y=;
        b=UbgHtax4HoG61StsBReycRJ1mAjPTH/KFbK5xHrDWYz1Sxo85YgRtNdIhLncBv79C0
         hsbVKUjr3TSgHXzfIpsEyxKArLhwQ+V2ORdbbbK/C9jBWtkGgc1hejqRph7dJmYRPz9i
         dTFtfNvvCHgcA0vufad2nWb1mjb9sy/9pTKpbADtkm2Qfx9xDrgatArSH7hJBRa/hsUU
         7mJXq8n6zUtTsEjw/QVlqd3bYtP7DftE/ple7rkkcmsv7pIFqg2pnpOPg0JEUHKojfkh
         Kdw90yVqm32XejxFkoZVfdLdLsZGToSBGwx1BaaQ6nqQQEQnFSNKtGPiES06I7g4ey/d
         xeWw==
X-Gm-Message-State: AFqh2kov4CQ8R28glFS1hcgA2554zBbphKAyyv9ez8sgnFEqb1BG2Hal
        KXExzaJUWyl91qvpq+f7sEprE3/bAUYBxXBrNRMCQE9tdqs=
X-Google-Smtp-Source: AMrXdXsw1LvXsyui38inHCCdCeWG/5Wea98zJiPhbb5dlQxyYemcwmxZBdGRYd4TcwiH2mjBUpMt57FOD0GS3G1Gr08=
X-Received: by 2002:a17:907:d48e:b0:84d:420c:79b0 with SMTP id
 vj14-20020a170907d48e00b0084d420c79b0mr638579ejc.511.1673364474824; Tue, 10
 Jan 2023 07:27:54 -0800 (PST)
MIME-Version: 1.0
References: <20230105171340.18444-1-cgzones@googlemail.com>
In-Reply-To: <20230105171340.18444-1-cgzones@googlemail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Tue, 10 Jan 2023 10:27:43 -0500
Message-ID: <CAP+JOzR5n9Goku3R9bMyk9466cBCDomVyv-nQFkE0Gfctv=tCw@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: do not write empty class definitions
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Jan 5, 2023 at 12:27 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Do not write class definitions for classes without any permission and
> any inherited common class.  The classes are already declared in
> write_class_decl_rules_to_conf().  Skipping those empty definitions,
> which are equal to the corresponding class declarations, will enable to
> parse the generated policy conf file with checkpolicy, as checkpolicy
> does not accept class declarations after initial sid declarations.
>
> This will enable simple round-trip tests with checkpolicy.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/kernel_to_conf.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/libsepol/src/kernel_to_conf.c b/libsepol/src/kernel_to_conf.=
c
> index 63dffd9b..73b72b5d 100644
> --- a/libsepol/src/kernel_to_conf.c
> +++ b/libsepol/src/kernel_to_conf.c
> @@ -591,16 +591,21 @@ static int write_class_and_common_rules_to_conf(FIL=
E *out, struct policydb *pdb)
>                 class =3D pdb->class_val_to_struct[i];
>                 if (!class) continue;
>                 name =3D pdb->p_class_val_to_name[i];
> -               sepol_printf(out, "class %s", name);
> -               if (class->comkey) {
> -                       sepol_printf(out, " inherits %s", class->comkey);
> -               }
>                 perms =3D class_or_common_perms_to_str(&class->permission=
s);
> -               if (perms) {
> -                       sepol_printf(out, " { %s }", perms);
> -                       free(perms);
> +               /* Do not write empty classes, their declaration was alre=
edy
> +                * printed in write_class_decl_rules_to_conf() */
> +               if (perms || class->comkey) {
> +                       sepol_printf(out, "class %s", name);
> +                       if (class->comkey) {
> +                               sepol_printf(out, " inherits %s", class->=
comkey);
> +                       }
> +
> +                       if (perms) {
> +                               sepol_printf(out, " { %s }", perms);
> +                               free(perms);
> +                       }
> +                       sepol_printf(out, "\n");
>                 }
> -               sepol_printf(out, "\n");
>         }
>
>  exit:
> --
> 2.39.0
>
