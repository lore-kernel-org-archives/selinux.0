Return-Path: <SRS0=yRyW=65=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC87C433DF
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 17:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE6D720756
	for <selinux@archiver.kernel.org>; Fri, 15 May 2020 17:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gzvrxr/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgEOR7H (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 15 May 2020 13:59:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59192 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726179AbgEOR7H (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 15 May 2020 13:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589565546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nxLt+9grmlc88gtZHInGc0hS84thWyE5Z84EQ0QEqi8=;
        b=Gzvrxr/iUuksHFZrlhedbuenWlPIXbCTDyP4wZKnDfPXMhF0NjEL1eKbXXK1/tMBuU57eI
        MZ/p5G/+SLaG4Dk0EAOlnSS5n+4aZNsx90/lko2qxRGjH9xQBaFKeml/UBEPPIYV5EcMdC
        XRgTma9D7/IBhL4cNr62uhxNAgaiyd0=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-Sk7cE955N6O2tzhyZnTP0A-1; Fri, 15 May 2020 13:59:00 -0400
X-MC-Unique: Sk7cE955N6O2tzhyZnTP0A-1
Received: by mail-oo1-f69.google.com with SMTP id h13so1769149oov.16
        for <selinux@vger.kernel.org>; Fri, 15 May 2020 10:59:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nxLt+9grmlc88gtZHInGc0hS84thWyE5Z84EQ0QEqi8=;
        b=DMGdwXFODjMBSAnKzsTZMbOjtQH1KMwE1BV6P8jmBl3GdZtXoVGP3q6Wv1rf5wtEZh
         UdW+l5mGaRj69M3mlT85NUMa0cJqoCejnAad8dObX34DM+KbzZ8P+iukEUE8/AXVbpB+
         Qc2nl6dDxD6CRuCShi3z8q+H2EG71TbF2i26RjAijE4+4KljM9g5aGP0xakK+POHjfeO
         gfcigKIS/GkQnXr2qR71g3+mRYNO/XY35N4JGFC1WkelLipN0nLXkKhB3rSHQx9Yl5X6
         Dl3AGmdOnHCt6e1BZ8FXkaWKcC2pu/FXaKtdrfwE2NcU0Q/4e/vQ4va+PBmfWdzhwQN+
         daHg==
X-Gm-Message-State: AOAM531pPhsS5U5QjePLFuFtYLW2yT/T9Kb6KdaWMLK6Ukj8eY35cvGc
        YwVhIUPNabUjZBZxUpJkafSSn5NhOfvN7vBMYKhR5+O4RbTpQSlRpqHgGFg1hiI5+hagCRdWHgm
        KdRInAFRx72/BE4EqnMkqOfh9RSVkH++sIg==
X-Received: by 2002:a9d:7d0e:: with SMTP id v14mr3328476otn.197.1589565539777;
        Fri, 15 May 2020 10:58:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyjhh0+Ud9VU2hjKnKIK5h+uxEWOHJqefP8hNhRJUjuGZlcMcHfiQNrk7HL0xbIjAqjtB8qwYEDom7D+WNgAo=
X-Received: by 2002:a9d:7d0e:: with SMTP id v14mr3328461otn.197.1589565539563;
 Fri, 15 May 2020 10:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200515173042.12666-1-william.c.roberts@intel.com>
In-Reply-To: <20200515173042.12666-1-william.c.roberts@intel.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Fri, 15 May 2020 19:58:48 +0200
Message-ID: <CAFqZXNtaSV-FHYwZ41Sp8f9eOu=RU6hSR_1Gqxb9LocaQ7BnzA@mail.gmail.com>
Subject: Re: [PATCH] README: add pkg kernel-devel to dnf command
To:     "Roberts, William C" <william.c.roberts@intel.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, May 15, 2020 at 7:31 PM <william.c.roberts@intel.com> wrote:
> From: William Roberts <william.c.roberts@intel.com>
>
> The text above states that kernel-devel is needed, but it's missing from
> the dnf command.
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  README.md | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/README.md b/README.md
> index 1f7e5d92a100..a73e9cc0c06d 100644
> --- a/README.md
> +++ b/README.md
> @@ -77,7 +77,8 @@ following command:
>                 kernel-devel \

It's actually right there already ^^

>                 quota \
>                 xfsprogs-devel \
> -               libuuid-devel
> +               libuuid-devel \
> +               kernel-devel-$(uname -r)

I proposed adding the -$(uname -r) before, but there were some valid
counterarguments. See the discussion here:
https://lore.kernel.org/selinux/CAFqZXNs5jcOOnhzT8=DQgzaf9RtBZ1=oqTU83pjVLMqPb-rzHA@mail.gmail.com/

>
>  #### Debian
>
> --
> 2.17.1
>

--
Ondrej Mosnacek <omosnace at redhat dot com>
Software Engineer, Security Technologies
Red Hat, Inc.

