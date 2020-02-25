Return-Path: <SRS0=F/Jq=4N=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E584C35E0E
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF5E222C2
	for <selinux@archiver.kernel.org>; Tue, 25 Feb 2020 20:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qg7XEo4N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgBYU4t (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:56:49 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36691 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgBYU4t (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 25 Feb 2020 15:56:49 -0500
Received: by mail-ot1-f66.google.com with SMTP id j20so871154otq.3
        for <selinux@vger.kernel.org>; Tue, 25 Feb 2020 12:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ezDce+66QhzCqo26qcghcUXURI93NWtQKBbZau9gsvs=;
        b=qg7XEo4Nt8oqM5adJTpjZCS12XiysYHdk5BvZTv5igYNXzQX1YOI+dXcbO7IuGXxJp
         C9Df4Wv/TggyTMi4tVRf17TEawi4I9fkAyVtuIWOFfCqJ0hzMNV18dLEYAD0n3wThG32
         qgcPJcpPOWTRqwOdI6YKQNgyc5DMswYDTRt1/Uvse6pMMoApZ+oIHgfUBPtf/pM7LoxC
         O3YAq6y69/7fN9b0CrwTOJ+Z3zKBQe8XWSAyvny2z9Ywkvd+gcD5dIc9i4ljvGjeXmgC
         5g0gnez1wjPIVUzlZmxUA7dk+GAoE5Jwn053Q0XlMfrIEze+3jEVcDE7m1ep+BOs3ZjR
         DTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ezDce+66QhzCqo26qcghcUXURI93NWtQKBbZau9gsvs=;
        b=eHzv6NVPYeNbY9xds7YHTX/TQjpT/90bW5Jh4eH2sxDodHIdaDnvNP10Njxs2NmO0w
         z+Atdazwv3v/f62cZlqsphN5pENXJBkGqIzVSDaLmPYSbBqWctE8yk7CP3aFNQMOVwXc
         onfI9geGb/zkXbGlpJYshlX33NhuAVZockwgvj91Kx4ZzCEYLo2KvBi0BhgXb4PKzZsH
         35YDk8mW3CiHAAhcC1KyTDjouW8UBsEWqaw9aaETFj66UWfeW3n+Fda4piGLu4QcA46u
         23DowLLkk7mYzneCHVFxba6xdrS3r5Fi6jfpe6sdRQzgQTaEC8WbT9UDvLulHpYjrnWR
         sa7A==
X-Gm-Message-State: APjAAAWcskSCCGUFBX/AyLvNxb34S0/GXhCHF2bFxQMa/cd3ajt33I8l
        7uyV/jKE2ZeAOT9dSc0WaEIO0tYRylWOe8TXhno=
X-Google-Smtp-Source: APXvYqz/lXnhIcSo5PCTSgw1/LLhOx8//epWfP5LLU221T3ExFWZ+J3HgaFL3mF1gJ8GdCyvIz3DsQ8OOeKDy/jY8dM=
X-Received: by 2002:a05:6830:16c5:: with SMTP id l5mr371433otr.165.1582664208738;
 Tue, 25 Feb 2020 12:56:48 -0800 (PST)
MIME-Version: 1.0
References: <20200225200219.6163-1-william.c.roberts@intel.com> <20200225200219.6163-9-william.c.roberts@intel.com>
In-Reply-To: <20200225200219.6163-9-william.c.roberts@intel.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Tue, 25 Feb 2020 15:58:22 -0500
Message-ID: <CAEjxPJ4c2spBoAzeibC=t01WV5mdP4S-ka9iK1DdGsx6UATyrg@mail.gmail.com>
Subject: Re: [PATCH 08/17] checkPasswdAccess: annotate deprecated
To:     bill.c.roberts@gmail.com
Cc:     Stephen Smalley <sds@tycho.nsa.gov>, plautrba@redhat.com,
        selinux@vger.kernel.org,
        William Roberts <william.c.roberts@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 25, 2020 at 3:03 PM <bill.c.roberts@gmail.com> wrote:
> diff --git a/libselinux/include/selinux/selinux.h b/libselinux/include/selinux/selinux.h
> index e531f927be1e..3704eabc7545 100644
> --- a/libselinux/include/selinux/selinux.h
> +++ b/libselinux/include/selinux/selinux.h
> @@ -603,7 +603,8 @@ extern int selinux_check_access(const char * scon, const char * tcon, const char
>  /* Check a permission in the passwd class.
>     Return 0 if granted or -1 otherwise. */
>  extern int selinux_check_passwd_access(access_vector_t requested);
> -extern int checkPasswdAccess(access_vector_t requested);
> +extern int checkPasswdAccess(access_vector_t requested)
> +   __attribute__ ((deprecated("Use selinux_check_passwd_access")));

I'd actually recommend deprecating that one too and recommending the
use of selinux_check_access() instead.
That way they get dynamic lookup of the permission and handling of
per-domain permissive and handle_unknown settings.
Only drawback is that they have to call getprevcon_raw() themselves
first and pass it in.
