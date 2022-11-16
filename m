Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C39CC4332F
	for <selinux@archiver.kernel.org>; Wed, 16 Nov 2022 20:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiKPUdS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 16 Nov 2022 15:33:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiKPUdR (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 16 Nov 2022 15:33:17 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BD459FDB
        for <selinux@vger.kernel.org>; Wed, 16 Nov 2022 12:33:16 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id bp15so31364744lfb.13
        for <selinux@vger.kernel.org>; Wed, 16 Nov 2022 12:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ft68Qn+m5TB3QqKmlLcx5AfI/xcPrdvVA6dBrT5EQrQ=;
        b=EWk9SvZSt/1kUQLyr2bfhHsPvE+ZS1ms4HvwL8R/u/64gbEnlbX8CDL7K4PxoqAq7J
         qVDkLcnozC+Ck9P5t812QLRARSjVQ6tzjDZj9bFeSXkeb7YoTRX2xTyqMY8OyCDq73ZV
         liKUZjltatD9Qa8mWmW/G0BP/h9mOsWIt7d7cvKSU0s7gkanCStWM5MJgbXC498+nmTO
         3wdMGEf7C3811vd+LK5gk9tkYQCVU37TiC9DFLJj7eoqjS+NRyvFLluqjPv+SB+RoyRR
         LOl6OYSdwBMLD9vppTk4wM3DWNP0nOPhVpnPXrhSX0+lT+1zADb/4TrZYCx05vOKzq80
         U+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ft68Qn+m5TB3QqKmlLcx5AfI/xcPrdvVA6dBrT5EQrQ=;
        b=EHnP6SRWfvNCPFXoma3vn8WnvVp2NzhR2DpNMM26vNcr3Wmz6bYLHXqmnPq/VCr2Is
         glSOWfnnPM28fomRnrYWmyYYBYccB/HMfpLDktZ6yoHcdJlj4qI1HzqvChHksS7NAEGH
         XYUw2uAivDKuLrAzdnjYCpt2ClIX6MmM334zOUFvAZrF9qvZgk9cY2W4rlXN6ScxgjsQ
         vpQdjUIJ0xSvk2YcOpw92n5kMMWNy81wqkDnAYs0GxpxOYN/n0Ed4Sv2XIJAjhsif2ZS
         TJOdeAw+H6817KWfX7PaRWl6StEsDrFH35E+VfLxpRRTjUCdun93SJkEF0Bl5DQdcict
         qNIg==
X-Gm-Message-State: ANoB5pndWJdfu0lDaZBezOiJNP4nRAWEK6G0ANZHS6sESb7UayMBWETu
        k7RPPWyzc8kubDOLlIUfUy87uHaD+utlE0SW+iWwYTSiMn4=
X-Google-Smtp-Source: AA0mqf4nDTOvZcpRaoQdXs7BR/bnt02ssqk6McXFoticu7hEsHwN2rkmR8qFw2CgbkE0G+xafpqPWJHJUi2GXoXF7MY=
X-Received: by 2002:a19:f004:0:b0:4b4:b5d8:880d with SMTP id
 p4-20020a19f004000000b004b4b5d8880dmr158116lfc.121.1668630794663; Wed, 16 Nov
 2022 12:33:14 -0800 (PST)
MIME-Version: 1.0
References: <20221115115536.2647075-1-lujie54@huawei.com>
In-Reply-To: <20221115115536.2647075-1-lujie54@huawei.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 16 Nov 2022 15:33:03 -0500
Message-ID: <CAP+JOzTD17kTpi-Uj=7FExieuJXMEKvdrUunu_fJw=i_BLyqbw@mail.gmail.com>
Subject: Re: [PATCH] libselinux: fix memory leaks on the audit2why module init
To:     Jie Lu <lujie54@huawei.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Nov 15, 2022 at 9:31 AM Jie Lu <lujie54@huawei.com> wrote:
>
> Signed-off-by: Jie Lu <lujie54@huawei.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libselinux/src/audit2why.c | 32 +++++++++++++++++++++++---------
>  1 file changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/libselinux/src/audit2why.c b/libselinux/src/audit2why.c
> index 44a9a341..ba1a66eb 100644
> --- a/libselinux/src/audit2why.c
> +++ b/libselinux/src/audit2why.c
> @@ -191,7 +191,7 @@ static PyObject *finish(PyObject *self __attribute__((unused)), PyObject *args)
>
>  static int __policy_init(const char *init_path)
>  {
> -       FILE *fp;
> +       FILE *fp = NULL;
>         const char *curpolicy;
>         char errormsg[PATH_MAX+1024+20];
>         struct sepol_policy_file *pf = NULL;
> @@ -235,18 +235,17 @@ static int __policy_init(const char *init_path)
>                 snprintf(errormsg, sizeof(errormsg),
>                          "policydb_init failed: %m\n");
>                 PyErr_SetString( PyExc_RuntimeError, errormsg);
> -               fclose(fp);
> -               return 1;
> +               goto err;
>         }
>         sepol_policy_file_set_fp(pf, fp);
>         if (sepol_policydb_read(avc->policydb, pf)) {
>                 snprintf(errormsg, sizeof(errormsg),
>                          "invalid binary policy %s\n", curpolicy);
>                 PyErr_SetString( PyExc_ValueError, errormsg);
> -               fclose(fp);
> -               return 1;
> +               goto err;
>         }
>         fclose(fp);
> +       fp = NULL;
>         sepol_set_policydb(&avc->policydb->p);
>         avc->handle = sepol_handle_create();
>         /* Turn off messages */
> @@ -256,13 +255,13 @@ static int __policy_init(const char *init_path)
>                               avc->policydb, &cnt);
>         if (rc < 0) {
>                 PyErr_SetString( PyExc_RuntimeError, "unable to get bool count\n");
> -               return 1;
> +               goto err;
>         }
>
>         boollist = calloc(cnt, sizeof(*boollist));
>         if (!boollist) {
>                 PyErr_SetString( PyExc_MemoryError, "Out of memory\n");
> -               return 1;
> +               goto err;
>         }
>
>         sepol_bool_iterate(avc->handle, avc->policydb,
> @@ -273,11 +272,26 @@ static int __policy_init(const char *init_path)
>         rc = sepol_sidtab_init(&sidtab);
>         if (rc < 0) {
>                 PyErr_SetString( PyExc_RuntimeError, "unable to init sidtab\n");
> -               free(boollist);
> -               return 1;
> +               goto err;
>         }
>         sepol_set_sidtab(&sidtab);
>         return 0;
> +
> +err:
> +       if (boollist)
> +               free(boollist);
> +       if (avc){
> +               if (avc->handle)
> +                       sepol_handle_destroy(avc->handle);
> +               if (avc->policydb)
> +                       sepol_policydb_free(avc->policydb);
> +               free(avc);
> +       }
> +       if (pf)
> +               sepol_policy_file_free(pf);
> +       if (fp)
> +               fclose(fp);
> +       return 1;
>  }
>
>  static PyObject *init(PyObject *self __attribute__((unused)), PyObject *args) {
> --
> 2.27.0
>
