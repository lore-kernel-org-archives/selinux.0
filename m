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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC33C4338F
	for <selinux@archiver.kernel.org>; Wed, 28 Jul 2021 20:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F1CA6103C
	for <selinux@archiver.kernel.org>; Wed, 28 Jul 2021 20:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhG1UoF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 28 Jul 2021 16:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbhG1UoE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 28 Jul 2021 16:44:04 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AB3C061757
        for <selinux@vger.kernel.org>; Wed, 28 Jul 2021 13:44:02 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id x15so5342452oic.9
        for <selinux@vger.kernel.org>; Wed, 28 Jul 2021 13:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iVOwEI5HIXFTU7O8Fj+bDJH2/bgSILOie79haBND3wQ=;
        b=Mepa07XEW8yXiw8rgK539tYhGS0TYeBRDXwvurQi54F/4d7DaZ2+N/5ila6faV+ss5
         ejizmBbfrpbfpuMRGENc89zFKFsxFAJv0kfwMSVLKNVhH421cDVgQNYJpQVTsXsFBJBp
         uKG5cFVvzfBnz737ty5x6DF8L3zYJjWC57WusN1e9NDbue7MT4ZyIXOlHeI5W7R9xWjX
         0MWqoI4Kv+xDFU4uXYPFEUneBrC+QJkXi+GU1VPNugSY7hrfsTAhCj1jSiLefuMufC+m
         AfGpq1FwXJMU/tTMrxAtCIVhHfXrjpspdj/WirqQxL/QSZksuY5kYvrDlzHADRNcw0m0
         vwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iVOwEI5HIXFTU7O8Fj+bDJH2/bgSILOie79haBND3wQ=;
        b=hG4OP6+G05c9XQYbazzJ3W6Zuf/TkxhZjSg7KieuB8vm9xgDwctwngkF4G9EoOzYDX
         fmMuHmPZWQTKxAIdc1FZAoYZNzZDQtgH0Pgq1G+ezeOp4FU35j4u9NCWgPs/nWlMT5KZ
         Phy27HOMQEozYNkmOnWGY8Uk5u3SwWGFCDTe6Y0pdaZ2DY4siES+gVMrkLodL8NqYIYg
         te24DjipSgrA6GOqDcjM3MNgjOoF9YPMcpzzZFI9ySj4igcBX4ydgoBvr1AI6SNTTcel
         6I3liwhVtx8WZnCG6bq3LE3rhZ+eDOslDLPW2daXbujNBxsywUiqB9Vz4W6qc3X5vSoF
         lz4A==
X-Gm-Message-State: AOAM533zDOFDIQFsha7/vESeFVq35l+Gb6ZUwqDj+MW8X2I/83pVukeV
        axR5HtqCoPA2Mkt0TVah0tB58RMMJqOM5J2sCkI=
X-Google-Smtp-Source: ABdhPJwquJpNaGuQtHTg9BWTL77eqJBHTpmX+0oyhHoM0zUY+7MCDDY/6Sv5mfntEKorvSbGpM+edFsuJdTIXCdaccE=
X-Received: by 2002:a05:6808:13c7:: with SMTP id d7mr7869183oiw.138.1627505041554;
 Wed, 28 Jul 2021 13:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210728092135.132957-1-plautrba@redhat.com>
In-Reply-To: <20210728092135.132957-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Wed, 28 Jul 2021 16:43:50 -0400
Message-ID: <CAP+JOzQBmAHK3fLRhrKtaEuerBGmOj=w_+sWN34540YLf7i_vw@mail.gmail.com>
Subject: Re: [PATCH] libsemanage: Fix USE_AFTER_FREE (CWE-672) in semanage_direct_write_langext()
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Jul 28, 2021 at 5:22 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> From fclose(3):
> Upon successful completion, 0 is returned.  Otherwise, EOF is returned
> and errno is set to indicate the error. In either case, any further
> access (including another call to fclose()) to the stream results in
> undefined behavior.
>
> Fixes:
>     Error: USE_AFTER_FREE (CWE-672): [#def1]
>     libsemanage-3.2/src/direct_api.c:1023: freed_arg: "fclose" frees "fp".
>     libsemanage-3.2/src/direct_api.c:1034: use_closed_file: Calling "fclose" uses file handle "fp" after closing it.
>     # 1032|
>     # 1033|   cleanup:
>     # 1034|->   if (fp != NULL) fclose(fp);
>     # 1035|
>     # 1036|     return ret;
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/src/direct_api.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index 9a4e79385b69..f0e2300a2f58 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -1022,6 +1022,7 @@ static int semanage_direct_write_langext(semanage_handle_t *sh,
>
>         if (fclose(fp) != 0) {
>                 ERR(sh, "Unable to close %s module ext file.", modinfo->name);
> +               fp = NULL;
>                 ret = -1;
>                 goto cleanup;
>         }
> --
> 2.32.0
>
