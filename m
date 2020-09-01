Return-Path: <SRS0=Zo7G=CK=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D46C433E7
	for <selinux@archiver.kernel.org>; Tue,  1 Sep 2020 12:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8457206EF
	for <selinux@archiver.kernel.org>; Tue,  1 Sep 2020 12:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t54g223+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgIAMlI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbgIAMkG (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 1 Sep 2020 08:40:06 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B6AC061244
        for <selinux@vger.kernel.org>; Tue,  1 Sep 2020 05:40:06 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id x14so983263oic.9
        for <selinux@vger.kernel.org>; Tue, 01 Sep 2020 05:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BFbF30SKaBnXMYSm4PR0/9vHoePMoQt6P9TbEJ5aiDs=;
        b=t54g223+kcDxit1w4hEuCEkgL6AsM26mZNjQ2EF7p424spCST5CtrNxDnT+sMkt1b0
         74W01H+tC+9cW3PdB0VTGx0ZVQJGvzDMoxtVdUE2xhV4mhV+n51cRL5sf2FMVJuGdU8z
         GLZGeDEOLXUB1vRcmWtNaVeQ+T48r8S4Rzt0dwbPwK1bN4IScbscZM13DGlOa73udbl4
         NtB/8sZlSvTH3W0LLxIFPkWI0oK4fhR67XnYcLgeGwQ0q1IrTLafdHHahGfPnIM8wOF/
         Io9EYne5I/eJYAEdrVsIaDaazPlxQtnlTIIQ5eGrLsHqqTaXshAeH3M82yplTOkhxLcb
         FEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BFbF30SKaBnXMYSm4PR0/9vHoePMoQt6P9TbEJ5aiDs=;
        b=jIMw84iclgK6lE+cBLaIjtcS/Lmtb8KHvsoFGCyKtFFmW5wpW2E9MHlp2a1WVMn1JM
         DPm+/8yRUw7zhwlDLOCmf2c4N0XQV20+0gSeOjpz6Edh3gl7MtU3MC0R/CgDTTXvLDwk
         Ws3Thy3yjZG+HXl1/BSahcGHLhqq6hUlZiLUjffVKcn/zEzT+Ps3XoT/iqoMVG/pwbRt
         STW7+FF72hx2KrO9KHK1micyi9pO0cl5yYoH1pq03lRuX5SN6ymWJmWME7qAiMuXpN96
         lKvebfqHl195mbdWTExJwJOXRe5BHczyzfurugw7w3tQcmHl9JwmBkiVKB4U2oALgAya
         qVBw==
X-Gm-Message-State: AOAM533hCLQfdkEALo5lH0i8ctjbdZAjRYUmGRFv1LU6BhyjdZeHC1Cv
        EUYl2nioF5kzvC/v7rqinBkTJz3GvZROX3+dW6A=
X-Google-Smtp-Source: ABdhPJzEzwYOfPxtKI5Zr7sguUiIWOHgw4eNXBe/W2xwY8XSISOdlSo4SyMhODzj1U6GeIYF8Amn9ItWUQQTYlxAPW4=
X-Received: by 2002:a54:4f9b:: with SMTP id g27mr949653oiy.140.1598964005668;
 Tue, 01 Sep 2020 05:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200901114245.3657-1-liwugang@163.com>
In-Reply-To: <20200901114245.3657-1-liwugang@163.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 1 Sep 2020 08:39:55 -0400
Message-ID: <CAEjxPJ7RU037b3m0rhzNQnGFJuX9UXZirpUwEXdeQfGxjUWwDw@mail.gmail.com>
Subject: Re: [PATCH] Optimize the calculation of security.sehash
To:     liwugang <liwugang@163.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Sep 1, 2020 at 7:59 AM liwugang <liwugang@163.com> wrote:
>
> The hash of each directory should be determined by the file contexts of
> the current directory and subdirectories, but the existing logic also
> includes the ancestor directories. The first optimization is to exclude
> them. So it should be break When the first complete match found in function
> lookup_all.
>
> If the current directory has corresponding file contexts and subdirectories
> have not, subdirectories will use the current direcorty's. There is no need
> to calculate the hash for the subdirectories. It will save time, espacially
> for user data(/data/media/0/). The second optimization is not to check the
> hash of the subdirectories.
>
> Example:
> /data/(.*)?           u:object_r:system_data_file:s0
> /data/backup(/.*)?    u:object_r:backup_data_file:s0
>
> If the file context of "/data/(.*)?" changes and "/data/backup(/.*)?" does not
> change, directory(/data/backup) and the subdirectories will restorecon because of
> hash changed. But actually there is no need the restorecon.
>
> Signed-off-by: liwugang <liwugang@163.com>
> ---
>  libselinux/include/selinux/label.h            |  5 +--
>  libselinux/src/label.c                        | 11 +++---
>  libselinux/src/label_file.c                   | 17 +++++++---
>  libselinux/src/label_internal.h               |  6 ++--
>  libselinux/src/selinux_restorecon.c           | 34 ++++++++++++++-----
>  .../selabel_get_digests_all_partial_matches.c |  3 +-
>  6 files changed, 55 insertions(+), 21 deletions(-)
>
> diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
> index e8983606..d91ceb6f 100644
> --- a/libselinux/include/selinux/label.h
> +++ b/libselinux/include/selinux/label.h
> @@ -110,9 +110,10 @@ extern bool selabel_get_digests_all_partial_matches(struct selabel_handle *rec,
>                                                     const char *key,
>                                                     uint8_t **calculated_digest,
>                                                     uint8_t **xattr_digest,
> -                                                   size_t *digest_len);
> +                                                   size_t *digest_len,
> +                                                   size_t *num_matches);
>  extern bool selabel_hash_all_partial_matches(struct selabel_handle *rec,
> -                                            const char *key, uint8_t* digest);
> +                                            const char *key, uint8_t* digest, size_t *num_matches);
>
>  extern int selabel_lookup_best_match(struct selabel_handle *rec, char **con,
>                                      const char *key, const char **aliases, int type);

This is a public API and a stable ABI for libselinux, so you cannot
make incompatible changes to it.
You would need to introduce a new API with the extended interface.

> diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> index 6eeeea68..c99eb251 100644
> --- a/libselinux/src/label_file.c
> +++ b/libselinux/src/label_file.c
> @@ -955,7 +955,10 @@ static const struct spec **lookup_all(struct selabel_handle *rec,
>                                 if (match_count) {
>                                         result[*match_count] = spec;
>                                         *match_count += 1;
> -                                       // Continue to find all the matches.
> +                                       if (rc == REGEX_MATCH) {
> +                                               break;
> +                                       }
> +                                       // Continue to find the matches until the first full match found.

I'm not sure this works the way you intend.  /data/(.*)? is a full
match for /data/backup.  Do you want to stop there and not include
/data/backup(/.*)? This also changes behavior of an existing API/ABI
in an incompatible manner.

> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
> index 6993be6f..417b619c 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c

Last I looked, Android wasn't using the upstream selinux_restorecon
(which was actually a back-port / adaptation of Android's
selinux_android_restorecon to upstream) at all, so any changes here
won't actually affect Android relabeling AFAIK.
