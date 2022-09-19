Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C176C54EE9
	for <selinux@archiver.kernel.org>; Mon, 19 Sep 2022 11:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiISLfk (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 19 Sep 2022 07:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiISLfj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 19 Sep 2022 07:35:39 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747BB275CB
        for <selinux@vger.kernel.org>; Mon, 19 Sep 2022 04:35:38 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e17so40826339edc.5
        for <selinux@vger.kernel.org>; Mon, 19 Sep 2022 04:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=NiVPmsNiaj5esbdB6SUODAo+I/QZU2l7C8JPG+VkICY=;
        b=g7mOdfcELFFBNVY8bw4Lbp6qxuS1I7+WwxBlki61rUeuLo8xV41JHffryxQla7ja1/
         IJmGOd35EqHChI1e2U4l3HiKCml3OYAwPPbEqcciRNrsGlZ7xLs7FcyTyL8a/vS4CkLj
         nG/UMiRjHtpWKY0fnu8OQBPu7ncIY5kZgdQhcx2LuZ4WmtJvVxOIAXeVyyAnwbiKVceY
         3iBdrvsbM4frXKHMOF+Bj2bOUQ3qkVfv7At9Y5uwReaKxlyrg17AJ2zoElVcx0VOEuZC
         i1hv4aydDaCHt3IJ8+wvj/JeIXdWStISvKnjPLvj+gdl6f57CcA2sXuKBg35YEABi9X8
         eUHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=NiVPmsNiaj5esbdB6SUODAo+I/QZU2l7C8JPG+VkICY=;
        b=Sx2DIZDSMl2/6svOPki7vvvmO6beNGanchqTbmeuGy7pfoafEeCO6pgvIL+vBEhPMb
         eJwEMAsFGCMqgNSQ6dk0kxQIgeOCkgwjOHYIIw4Qzl7LO7TNF15psyDX1htzlTQ3U7Sk
         frfhXQLhGSdVUMkSg2w6l2d31heyHYgZcqIHk278WRaJYGz1bOe9IotD88dVLvc7sXiF
         MQ7LFF3gJCk1Td0TiKsUe9QjPDwNkifBEhxoFSdwyR1BzkLnzcsWxIZDbmZPXGrQN5OC
         gvuj8dBAqUSxZhqvB4b3PtUYYbiaSq0ocK2xMVBI5eiyyeiaQUHVIZMD/WDT9M6YNGSv
         USGg==
X-Gm-Message-State: ACrzQf0Kumf6RpKpEoG0XbPGziilFGFZ5H65r4DYvcOWQcnjp4/GolmN
        NKuO1LLdBlmRWU4WpSNRHSq/2OOIfkw15W9HQEA=
X-Google-Smtp-Source: AMsMyM4oi2yEU7omeZ9WzFaarUyLZtHGeSRt2vAQdX7GqJR+fyOt1xFN/qK+S9MnPUssMPOUMjy5Yoae/HAa16K7y/w=
X-Received: by 2002:a05:6402:3890:b0:451:ef52:8f9e with SMTP id
 fd16-20020a056402389000b00451ef528f9emr15409044edb.107.1663587336823; Mon, 19
 Sep 2022 04:35:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220919112901.1127409-1-omosnace@redhat.com>
In-Reply-To: <20220919112901.1127409-1-omosnace@redhat.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Mon, 19 Sep 2022 13:35:25 +0200
Message-ID: <CAJ2a_DcJkATZNBKH8Ua9_Wa1KKL16K-TopHQVW2hYOavPMjgWQ@mail.gmail.com>
Subject: Re: [PATCH userspace] fixfiles: do not cross mounts when traversing directories
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, 19 Sept 2022 at 13:29, Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> Always run find with -xdev to avoid unintended deleting/relabeling.
> While this may sometimes skip subdirectories that should be relabeled,
> the danger of crossing into random mounts is greater than leaving behind
> some unlabeled files. The find commands are just best-effort attempts to
> fix the labels anyway.

The xdev option does not work for bind mounts (they are still followed).

>
> In case of /run (renamed from the deprecated /var/run), traverse
> /run/user/* directories separately, as there is commonly an additional
> layer of tmpfs mounted on them.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  policycoreutils/scripts/fixfiles | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
> index c72ca0eb..c9ab2a93 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -153,7 +153,7 @@ newer() {
>      shift
>      LogReadOnly
>      for m in `echo $FILESYSTEMSRW`; do
> -       find $m -mount -newermt $DATE -print0 2>/dev/null | ${RESTORECON} ${FORCEFLAG} ${VERBOSE} ${THREADS} $* -i -0 -f -
> +       find $m -xdev -newermt $DATE -print0 2>/dev/null | ${RESTORECON} ${FORCEFLAG} ${VERBOSE} ${THREADS} $* -i -0 -f -
>      done;
>  }
>
> @@ -273,18 +273,22 @@ case "$RESTORE_MODE" in
>
>         UNDEFINED=`get_undefined_type` || exit $?
>         UNLABELED=`get_unlabeled_type` || exit $?
> -       find /tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) \( -type s -o -type p \) -delete
> -       find /tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /tmp {} \;
> -       find /var/tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /var/tmp {} \;
> -       find /var/run \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /var/run {} \;
> -       [ ! -e /var/lib/debug ] || find /var/lib/debug \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /lib {} \;
> +       find -xdev /tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) \( -type s -o -type p \) -delete
> +       find -xdev /tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /tmp {} \;
> +       find -xdev /var/tmp \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /var/tmp {} \;
> +       find -xdev /run \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /run {} \;
> +       # /run/user/<pid> may have an additional tmpfs mounted on it
> +       for userdir in /run/user/*; do
> +               find -xdev "$userdir" \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference "$userdir" {} \;
> +       done
> +       [ ! -e /var/lib/debug ] || find -xdev /var/lib/debug \( -context "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /lib {} \;
>      ;;
>  esac
>  }
>
>  fullrelabel() {
>      echo "Cleaning out /tmp"
> -    find /tmp/ -mindepth 1 -delete
> +    find -xdev /tmp/ -mindepth 1 -delete
>      restore Relabel
>  }
>
> --
> 2.37.3
>
