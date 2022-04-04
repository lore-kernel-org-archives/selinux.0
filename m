Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918A8C43217
	for <selinux@archiver.kernel.org>; Mon,  4 Apr 2022 21:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382536AbiDDVaz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380262AbiDDTYt (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 4 Apr 2022 15:24:49 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16693B295
        for <selinux@vger.kernel.org>; Mon,  4 Apr 2022 12:22:52 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id z8so11098050oix.3
        for <selinux@vger.kernel.org>; Mon, 04 Apr 2022 12:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WqHsdvRU/0ykENmNgIW+D4WkbuIiPWrv0VvIpPlw958=;
        b=cH2LsBI1mzHdw54mmcYTIyV0BZtUgjDaASfHI0fO2c9FwSg8chgz7KMaoRx4dn4Gkh
         Ywg/zG5t+1Zri5c0uFedWSvBUyoNoQaMLxalxkkGKj2MC9+CFbqfgeQRHyIq6Lnk0dEu
         LI0SKvB/2NK453FFZdRpsUWzXjO2hjNF3VhMslhOOeb4qRuvcCpO8QrubW6WijXUaR9d
         y6JGLLNAJsKoUfbJda8GpyrLYXI/41+L6INd8AsPnt5M+SYx0hVzGiPcBVnpBowMV6+t
         uLbjsV9mpZmkdMzdG42rUNpKsxjkWsKNAaX72Ne3i2FCpjCdu2V5bePktTC91FJkozjk
         X0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WqHsdvRU/0ykENmNgIW+D4WkbuIiPWrv0VvIpPlw958=;
        b=1CqdrPhdT99GncG+ErE7wYwE/tfFMsnQJZO7qzzW/PqdFiamw1CdvVgNE7Gkf4FJmq
         DPEoYzThxNnJXCn4E7twyUvXOZ5qKsbKzuvisP3IDtQDqyOCXXVKaC4XkbrmoHIEsKhw
         zGGYQVt5oGpQo9n06SqA2/KFbSxw4voJhIuZ9jLc4JsBTDNZzACh0hu+wjyLZTlT0Pnk
         p/ajTocQhfXP2RLCyTExZoZX2Ltv9SOm9qHSFWMt6Xj+zOMFeHfhlOUTtiwR4QzVd2DJ
         myi9qGCCr4YFgiWCU6+2xzhXtMf11ctNZnoOe+p7x+BSZWynxqD4xSX0W89svP8rTkOQ
         No8w==
X-Gm-Message-State: AOAM533yEth5s9+hsEn0TkV2IkxSr08OmggomJO5Q/BegHCSgux8jQg1
        FEykPJXTECmG94q02L4hVC4BNXpFF+2R72tWVbkkCX9Yavk=
X-Google-Smtp-Source: ABdhPJw+IKu4RkXwxIlrxyF/ZoLQIf02qUACluvlz8xNSzNA+AHJoAKq7owW9ZcKUXW0wt0eFng7GfD6BEx3EcGguRc=
X-Received: by 2002:a05:6808:210b:b0:2d9:a6d3:b029 with SMTP id
 r11-20020a056808210b00b002d9a6d3b029mr309551oiw.182.1649100172151; Mon, 04
 Apr 2022 12:22:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220401133549.122069-1-plautrba@redhat.com>
In-Reply-To: <20220401133549.122069-1-plautrba@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 4 Apr 2022 15:22:41 -0400
Message-ID: <CAP+JOzTF1BC6hF7-nb+qBGpoAuC_VH5Ts+=CZZGj3hE1DD=X-g@mail.gmail.com>
Subject: Re: [PATCH 1/3] libsemanage: Fix USE_AFTER_FREE (CWE-672) in semanage_direct_get_module_info()
To:     Petr Lautrbach <plautrba@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 1, 2022 at 11:54 AM Petr Lautrbach <plautrba@redhat.com> wrote:
>
> >From fclose(3):
> Upon successful completion, 0 is returned.  Otherwise, EOF is returned
> and errno is set to indicate the error. In either case, any further
> access (including another call to fclose()) to the stream results in
> undefined behavior.
>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

For all three patches:
Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  libsemanage/src/direct_api.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index d83941b05ca1..d5716ce579e9 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -2293,6 +2293,7 @@ static int semanage_direct_get_module_info(semanage_handle_t *sh,
>         tmp = NULL;
>
>         if (fclose(fp) != 0) {
> +               fp = NULL;
>                 ERR(sh,
>                     "Unable to close %s module lang ext file.",
>                     (*modinfo)->name);
> --
> 2.35.1
>
