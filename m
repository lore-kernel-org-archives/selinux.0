Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D11C4332F
	for <selinux@archiver.kernel.org>; Fri, 16 Dec 2022 21:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiLPVY1 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 16 Dec 2022 16:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPVY0 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 16 Dec 2022 16:24:26 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D4461D50
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 13:24:25 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id n20so9204482ejh.0
        for <selinux@vger.kernel.org>; Fri, 16 Dec 2022 13:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c4L7amWvSpm+NCda7oBlHJhtUzN6fspEOB4J+PYnKi0=;
        b=TsnfJ/Sxnhba6NxrKEXauRbvNMX6XEIe5KLwFZaAbguw+Z+q282o4fqWs+HFfZA/dw
         iPsaiYYfxg2RiBCJxdJrkLwbOgQIKje/B1Bu+aYpzCjd8au1HiWX0ragDCVzc8zxVxm8
         /mu0rxw6oqsgB6DnykO+/9KFCp6G/KHpU0DWQ6c5QDwxMms2U3WhTqJIsdIJDttVvwOi
         TERh7iLG8rBpTUYMzplwIpmcdy9HM63TWHta5I6yWKac4X200TBNSz9/flv9B6ERED8c
         XHn8nB59Tn/N99W700Lokq/8W1MuglNsy+uRLrsVuPi+Czs8gEuO/5d5KGgRxCKv28Rg
         47Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c4L7amWvSpm+NCda7oBlHJhtUzN6fspEOB4J+PYnKi0=;
        b=DeXBDOWAyRytr7QJDiEuGwexXCyqpUTEzVD6zQL/SLXdU0xYqi9QyYCRrlUyxRXcuS
         jF1F6FyXNsSraanOefdmL9Zwu5J4dKuBz70e7DU52FhxnX769aSAs6QTJ5uX/xGlq1iG
         oGlo1qCvRWI6lg/+N2PkM5ELxTE9MZJh12QOrjuUOr9mAXEu9kNKoPb7u8hWAbD4gCze
         0pWgT2cytF2SAf3MLwE+OKXymV5B3uF/G4LK9MdXUclEzMzwtuPDKPY08p+r/ilSSPqi
         nhVABP9xhjMgkqN5xi0eg9jNQBnhaCAVuHN9+aRBeGqD5pbg++1/7puuGxGlmiKECjJV
         BNIQ==
X-Gm-Message-State: ANoB5pkKrR7KNyEVVPiVMfnamDAVjSxLZGjUMVk/fIxPhRcyJ7UR8je/
        88+OBBGMzDe10oq8JLwQ/P3s0xa8yHg7ByWndtxImRNiLJg=
X-Google-Smtp-Source: AA0mqf5auv6NaB9+w41LxaoWi1xP1LvXx7xukZrQZfBHhexmBvfFm6WyCnHUdvAq50/srXNRsZsBRlu3JmZvg7KqUEU=
X-Received: by 2002:a17:907:6d8c:b0:7c1:675d:2620 with SMTP id
 sb12-20020a1709076d8c00b007c1675d2620mr3069606ejc.100.1671225864074; Fri, 16
 Dec 2022 13:24:24 -0800 (PST)
MIME-Version: 1.0
References: <20221212174349.714152-1-lautrbach@redhat.com>
In-Reply-To: <20221212174349.714152-1-lautrbach@redhat.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Fri, 16 Dec 2022 16:24:12 -0500
Message-ID: <CAP+JOzRd2wei9QLPZU1Kzc9qJzb1NU1EwJ6FQt_iOUfKv2h2sA@mail.gmail.com>
Subject: Re: [PATCH] sepolicy: Call os.makedirs() with exist_ok=True
To:     Petr Lautrbach <lautrbach@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 12, 2022 at 12:49 PM Petr Lautrbach <lautrbach@redhat.com> wrote:
>
> Since commit 7494bb1298b3 ("sepolicy: generate man pages in parallel")
> man pages are generated in parallel and there's a race between
> os.path.exists() and os.makedirs().
>
> The check os.path.exists() is not necessary when os.makedirs() is called
> with exist_ok=True.
>
> Fixes:
> /usr/bin/sepolicy manpage -a -p /__w/usr/share/man/man8/ -w -r /__w/
> FileExistsError: [Errno 17] File exists: '/__w/usr/share/man/man8/'
>
> Signed-off-by: Petr Lautrbach <lautrbach@redhat.com>

Acked-by: James Carter <jwcart2@gmail.com>

> ---
>  python/sepolicy/sepolicy/manpage.py | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/python/sepolicy/sepolicy/manpage.py b/python/sepolicy/sepolicy/manpage.py
> index edeb3b77e759..1bff8f9acb49 100755
> --- a/python/sepolicy/sepolicy/manpage.py
> +++ b/python/sepolicy/sepolicy/manpage.py
> @@ -376,8 +376,7 @@ class ManPage:
>
>          self.fcdict = sepolicy.get_fcdict(self.fcpath)
>
> -        if not os.path.exists(path):
> -            os.makedirs(path)
> +        os.makedirs(path, exist_ok=True)
>
>          self.path = path
>
> --
> 2.38.1
>
