Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16359ECAAD5
	for <selinux@archiver.kernel.org>; Mon, 29 Aug 2022 18:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiH2Stu (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 29 Aug 2022 14:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiH2Stt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 29 Aug 2022 14:49:49 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4479790
        for <selinux@vger.kernel.org>; Mon, 29 Aug 2022 11:49:44 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id a9so2142650ilh.1
        for <selinux@vger.kernel.org>; Mon, 29 Aug 2022 11:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=InRd9ee9hgVTcmXd0UaIUSty5I313n+TLUulVEfdVDU=;
        b=VHzVlzJZhNQHv9u6/hirZllRm9gB3qaeoj1OfebdfufpJZ5hK+sP89fLO2xjQi6E+9
         w63wfaH2LNg+puEAeW417bkzCF2lYMp2Yc9jJ4gFVoZJw6rhZAG/JBK6czp4vgMwAFAP
         orkMjtO22ib8YEb+YSUY8rVrWkiE+mmdqxmCxLs6UUFmG4JaA8JNaUb06GvXrQxYLTzA
         8NScFwkxrfDzPP1I9dJvkilXVhmcnz9f7Hz9mm7EFafvTFPhvQ/ocvQ/M9/QwiFMPBK+
         XUqtzajS00fvimEu+U9Y9nWBP4++JF7ii7+G7Psm5Mk8lcouJ71tGj4nH0M2AikEESq0
         eBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=InRd9ee9hgVTcmXd0UaIUSty5I313n+TLUulVEfdVDU=;
        b=aGpbKATEpPYQKW2KCrwchsVuPJSgA1q0GYEvonTJxOGxRXL5+j6UcTc+t14aYH9ATM
         SXMcDD4Io477fmVi595lV2WzjIcdbqfHQeAKIbv8LhT1t3OHqQ/zWbAHyADLPtA4sFKR
         Ikb/JppwSxTmb9PtjI6ktrOkUy7B56Mw+Ne+kzUFelWVJlJXESwyw36JkkwAMO/Nrxjn
         /MNIPyg5ho7wZQqqCtLEr9wAame9A+UuAHCvMT7IyA4MunOZK7H/CGUNdMvn9HeNkO+F
         ocJF2W0HCGhlV2OocnNtRgbbFP6RWzmUbFC0iTPWYprWgz7MhVD/hGABdc1L96y8ELwS
         S1kg==
X-Gm-Message-State: ACgBeo06mgv+Zn2kzpM6ex3mlL+49FHber9aijLakJKQZgYcLSPU3Coe
        ZrL0CiNFo2rnR77RWwSscFJeXnI+lWAlhuldUFVjzVno0J4=
X-Google-Smtp-Source: AA6agR5H6USqVeVKLH4dDemHm2fQuVog07MQyNrxAri77I/cSjiigbtK+ryAUGSxNPRCUu5Ev76Ue/lCq0Twv8tW+QI=
X-Received: by 2002:a92:130f:0:b0:2e4:22c9:7721 with SMTP id
 15-20020a92130f000000b002e422c97721mr11139954ilt.34.1661798983624; Mon, 29
 Aug 2022 11:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220825132718.jnuxg7oqkmm3dx2l@jmarcin-t14s-01>
In-Reply-To: <20220825132718.jnuxg7oqkmm3dx2l@jmarcin-t14s-01>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 29 Aug 2022 14:49:32 -0400
Message-ID: <CAP+JOzR+47kdg9G7mO59XvWYk6JkbLd6W2geW6O-W7q3dH5VCw@mail.gmail.com>
Subject: Re: [PATCH] libsepol: fix missing double quotes in typetransition CIL rule
To:     Juraj Marcin <juraj@jurajmarcin.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 25, 2022 at 9:45 AM Juraj Marcin <juraj@jurajmarcin.com> wrote:
>
> CIL Reference Guide defines typetransition rule with double quotes
> around object name, but those are not present in the format string.
>
> This patch fixes this issue, so the CIL output produced by
> sepol_kernel_policydb_to_cil() is in the correct format.
>
> Signed-off-by: Juraj Marcin <juraj@jurajmarcin.com>

Despite what the CIL Reference Guide says, the quotes are not
required, but it is best practice to use them.

 Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsepol/src/kernel_to_cil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/src/kernel_to_cil.c b/libsepol/src/kernel_to_cil.c
> index 5a1336a3..ad4121d5 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -1894,7 +1894,7 @@ static int map_filename_trans_to_str(hashtab_key_t key, void *data, void *arg)
>                 ebitmap_for_each_positive_bit(&datum->stypes, node, bit) {
>                         src = pdb->p_type_val_to_name[bit];
>                         rc = strs_create_and_add(strs,
> -                                                "(typetransition %s %s %s %s %s)",
> +                                                "(typetransition %s %s %s \"%s\" %s)",
>                                                  5, src, tgt, class, filename, new);
>                         if (rc)
>                                 return rc;
> --
> 2.37.1
>
