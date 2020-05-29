Return-Path: <SRS0=wECs=7L=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EB5C433E0
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 13:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01BFD206A1
	for <selinux@archiver.kernel.org>; Fri, 29 May 2020 13:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEj4SWyW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgE2N5Q (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 29 May 2020 09:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726476AbgE2N5Q (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 29 May 2020 09:57:16 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BCEC03E969
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 06:57:15 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m2so9038otr.12
        for <selinux@vger.kernel.org>; Fri, 29 May 2020 06:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZXdG8XIu/7grbsbVYZarf0s7kZTpThr1tL7Zy3jriQY=;
        b=FEj4SWyWyntBjlzJvyk++BZWwc5CtBEgP1tgT1Cjl3n58oq/ICKvkmy1KRwGjwmzal
         uw4/E2oGjeoZDFYTkc9mKc9zPiaFvZCgzKBo3bQUIgGknzz6h0xJh1mHWLECLRuN2+jM
         /VTs8Mngzi3UyLtOZN6ezFptf0Oss29doCckIRzdoQSkNl+YnX9egSQQm95sAd8Wrr1e
         3dwk6I5ikP5GSl9QgF/au/yyO5vtirTEU7RoEYSnDIRrD7dbP58IyCVKNhVaLdG9gWGO
         fTFfYXg8aRfFKp0vjiD7s8hcKWIvoKaNL5SpmJJ+TBCnyn4EmcHmrTiZWXICjTqRf+NA
         1Olw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZXdG8XIu/7grbsbVYZarf0s7kZTpThr1tL7Zy3jriQY=;
        b=VeUV2yhkEsjC7RQ5coHc1D5roJyIymZauxpr5Bp08EebjCXuQ+EWYkuIiyJExroVBO
         0piCiGhHrpeOphvvPQmDfGYdXK/7sNzM5gQ/1c3J+jSPWkyIOGaRuP32a9bpImEMAchI
         4705Avv2pJ1xRFoPmVRIAmVQHT3Qi22lHF6Hu1798iBYQ4W3z5DRUeZvXgUbtcB2jubn
         Tb4DpSR5gsBYG9JR9ZGlTAjbpskNToohSB+sYgHTSo6fpnutEjR0nOJkQE8mxDBob9X9
         nsHnGuPPXejVQ+Bk3Avi+MriV7Ca5bWBVVxetyfQH3Fu5DWC0qdSrS5ksxrZG0MBTOMT
         YvGg==
X-Gm-Message-State: AOAM531l8c/IpGfzHOZP+Z05LBSy/6hHVtFk/flTNVoB8cm+/lIEg87/
        FW3cYocSrAikaK8rAlCvXkIe8YGsGhOeBLeTAxU=
X-Google-Smtp-Source: ABdhPJy8p7oFnrYOf6oKWX+mCqxO7H3s1QoPGEeD+SWIF+6WKOtcN41LmpnNL5AnATxcXIC8Pj8cqU3kX0inD1EJlzU=
X-Received: by 2002:a05:6830:4c3:: with SMTP id s3mr6264349otd.162.1590760635338;
 Fri, 29 May 2020 06:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200525194750.17309-1-toiwoton@gmail.com>
In-Reply-To: <20200525194750.17309-1-toiwoton@gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 29 May 2020 09:57:04 -0400
Message-ID: <CAEjxPJ7wWgBO8qETf1bhgKhXb20zEC7SPicKG9jWdJgae4FcBg@mail.gmail.com>
Subject: Re: [PATCH] semanage bash completion: handle semanage module #246
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, May 25, 2020 at 5:50 PM Topi Miettinen <toiwoton@gmail.com> wrote:
>
> List modules for bash completion of `semanage module`.
>
> Signed-off-by: Topi Miettinen <toiwoton@gmail.com>
> ---
>  python/semanage/semanage-bash-completion.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/python/semanage/semanage-bash-completion.sh b/python/semanage/semanage-bash-completion.sh
> index 2d811c98..a3993c58 100644
> --- a/python/semanage/semanage-bash-completion.sh
> +++ b/python/semanage/semanage-bash-completion.sh
> @@ -54,6 +54,9 @@ __get_all_roles () {
>  __get_all_stores () {
>      dir -1 -F /etc/selinux/ | grep '/' | cut -d'/' -f 1
>  }
> +__get_all_modules () {
> +    semodule -l
> +}
>  __get_import_opts () { echo '$ALL_OPTS --f --input_file' ; }
>  __get_export_opts () { echo '$ALL_OPTS --f --output_file' ; }
>  __get_boolean_opts () { echo '$ALL_OPTS --on -off -1 -0' ; }
> @@ -88,6 +91,14 @@ _semanage () {
>         if   [ "$prev" = "-a" -a "$command" = "permissive" ]; then
>                 COMPREPLY=( $(compgen -W "$( __get_all_domains ) " -- "$cur") )
>                 return 0
> +       elif [ "$command" = "module" ]; then
> +               if [ "$prev" = "-a" ] || [ "$prev" = "--add" ] \

For -a we likely don't want this because the argument should be a
module file path not an already installed module name.

> +                   || [ "$prev" = "-d" ] || [ "$prev" = "--disable" ] \
> +                   || [ "$prev" = "-e" ] || [ "$prev" = "--enable" ] \
> +                   || [ "$prev" = "-r" ] || [ "$prev" = "--remove" ]; then
> +                   COMPREPLY=( $(compgen -W "$( __get_all_modules ) " -- "$cur") )
> +                   return 0
> +               fi
>         fi
>         if   [ "$verb" = "" -a "$prev" = "semanage" ]; then
>                  comps="${VERBS[*]}"
> --
> 2.26.2
>
