Return-Path: <SRS0=rjXy=CC=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40007C433DF
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B117204FD
	for <selinux@archiver.kernel.org>; Mon, 24 Aug 2020 13:42:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siubR0wZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgHXNl6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgHXNfh (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Aug 2020 09:35:37 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3437C061573
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:35:36 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id a65so7267778otc.8
        for <selinux@vger.kernel.org>; Mon, 24 Aug 2020 06:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zsR8ckw/1Lev5akkYdrEFihyxUfRCIruPyhqU7rQ/xs=;
        b=siubR0wZ6epUzxPa/S5lS+lnj7d7CdkJNuioNdIt4EEmtrE9dOjxIbZrY8+4NRxln3
         YwEedviLEqJajayc1HfPtX55TD4+3S0fi+6C5zn5wKInSkaw+bsZJEeyYlUuuupbhzyz
         yc2rz9QKbmOnq2vIWnZ5VP3UTOIF/+L/2pLbpUkwVrwwJS5XALyy2W28qEFaRaSKwnPU
         szdxp7I9cdWhrhDvOKaR7RgxTGQxFMapETsPt2SRG9OFZfauIcgN8hKRyFTAj6gJX2Ol
         N7IXqn2hHeaxAQJQPhwpTmRdIYK9V6pbZrG16JQW+D1Y9GNlFFXVzxcc8x3VpqlcHzWm
         KFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zsR8ckw/1Lev5akkYdrEFihyxUfRCIruPyhqU7rQ/xs=;
        b=VxgeVa7YhWO3IySBZndQL9dq6p8Zx/Q8ygnYBGgtu1U+rm+mY1NIl/RIJx1oREh7ca
         eNad2F/lBQJfwcgv/qKTSGO1NjjHhSdlfwjeCTQuO0iMsacBa1A3haGgkpebSFpZx3W5
         /GOEMY5h4y+UnANf7u+6AR8pw14ZHMhzljpmPWom4NEHCjcEoqYTrnTrSxjUj6TKzSaE
         Wm4rTNAer/HpoL9OuTaYwOmQkL8iT7byPKPUxu/dFI6C0kdrMFN8QaUEzx3+V/Eb62sY
         FpXFCjEVpbekbtOuQntfCcZZeAtWG6LFK9M/pzwmMtoI7BOggYVe6Ilike/xlMxsCV9A
         2pOg==
X-Gm-Message-State: AOAM531gPdPyXjVAxetLMxeCPfnH7m0Dpq3H9v5f3cGqvx9oNNSAUpyU
        FMlvDbsnyprO83Q82bme1UcekSUhclC35Cfm3v05DKfuqWY=
X-Google-Smtp-Source: ABdhPJwLVlJPoD7XdlBB5U/F4DsdppqmjskCZdaA83tF7a5fJCYEVyR1etzjqCCwtQeuaMtKYEVAOLnMMIi2/sJE7/U=
X-Received: by 2002:a9d:67d3:: with SMTP id c19mr3583699otn.162.1598276136150;
 Mon, 24 Aug 2020 06:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200820154726.210419-1-chpebeni@linux.microsoft.com>
In-Reply-To: <20200820154726.210419-1-chpebeni@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Mon, 24 Aug 2020 09:35:25 -0400
Message-ID: <CAEjxPJ63ZLZUY-Qqk=Shf+uojEO9WVANQ0-hhTduKC+PoNX4FQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] libselinux: Remove trailing slash on selabel_file lookups.
To:     Chris PeBenito <chpebeni@linux.microsoft.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Aug 20, 2020 at 11:51 AM Chris PeBenito
<chpebeni@linux.microsoft.com> wrote:
>
> Having a trailing slash on an selabel file lookup can yield a different
> result.
>
> For example:
> /path/foo(/.*)?   user:role:type1
> /path/foo/bar  -d user:role:type2
>
> A lookup of "/path/foo/bar/" would yield user:role:type1 instead of
> user:role:type2, which is unlike typical Linux behaviors where trailing
> slashes are ignored.
>
> Many callers already strip the trailing slash before the lookup or users
> revise the file contexts to work around this.  Fix it comprehensively.
>
> Signed-off-by: Chris PeBenito <chpebeni@linux.microsoft.com>
> ---
>  libselinux/src/label_file.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 412904d1..42d9d485 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -853,7 +853,7 @@ static const struct spec **lookup_all(struct selabel_handle *rec,
>  {
>         struct saved_data *data = (struct saved_data *)rec->data;
>         struct spec *spec_arr = data->spec_arr;
> -       int i, rc, file_stem;
> +       int i, rc, file_stem, len;

size_t len?

>         mode_t mode = (mode_t)type;
>         char *clean_key = NULL;
>         const char *prev_slash, *next_slash;
> @@ -894,6 +894,22 @@ static const struct spec **lookup_all(struct selabel_handle *rec,
>                 key = clean_key;
>         }
>
> +       /* remove trailing slash */
> +       len = strlen(key);
> +       if (key[len - 1] == '/') {

What if len == 0?

> +               /* reuse clean_key from above if available */
> +               if (!clean_key) {
> +                       clean_key = (char *) malloc(len);
> +                       if (!clean_key)
> +                               goto finish;
> +
> +                       strncpy(clean_key, key, len - 1);
> +               }
> +
> +               clean_key[len - 1] = '\0';
> +               key = clean_key;
> +       }
> +
>         sub = selabel_sub_key(data, key);
>         if (sub)
>                 key = sub;
> --
> 2.26.2
>
