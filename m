Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E759CFA373F
	for <selinux@archiver.kernel.org>; Mon, 24 Oct 2022 20:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbiJXUp3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 24 Oct 2022 16:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbiJXUoN (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 24 Oct 2022 16:44:13 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EF9B600D
        for <selinux@vger.kernel.org>; Mon, 24 Oct 2022 11:52:12 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s196so9428014pgs.3
        for <selinux@vger.kernel.org>; Mon, 24 Oct 2022 11:52:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xFRZ99MDYcvJtCDoKeZZVBWJd9/c9kMuiBfMLnLcUN8=;
        b=j4oftE7pgWT/1Al7VIHJJUAGvN6CGTb3edhRivRC71h6gglJXRSweyJHfqpPlp9dl6
         7V554K4hU9ogUCpO2hEmgFpXN8Mm50jcrKIp/hUyoreVSxLpgXNIRFrON4SzNIN36/ax
         Uon4YfwZ6cM6CfEO7Qy7vopJHsvaFSt775Fxvc9YshVmaukY4ly9KFhPPw31hxYE8ZqB
         6czxXgcrqd8/Ci0j2wT5HvfcoY3TkF94tr3U8R2twA9lLSqZCx4kfxJQEo95cevOYJvi
         /IgdkaDBlLiUcRdCLX0/YAn5cf6oDZ8JgoOmExTgY2Zk8TUJLMKyOxjvygWyO+BPQRn1
         WaJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xFRZ99MDYcvJtCDoKeZZVBWJd9/c9kMuiBfMLnLcUN8=;
        b=hrMTFHgaaCuVVTWvbll8luhFhP3gOVG0lsv+EzK2jnNgUIyinfK+L3BDWKjKSfWY2E
         6HMMeRCCDXns6iQnJNM4ehad055Puc6TNMiRDU+fasuKtZjUU3GLiIePT1fbpwTqumBB
         eCmitzuJCAStX0VIXFBVEAhxWsCxxg38j7V0dzoEAkn9ISbPpruj+1T2dU02m87CSvFB
         LFSgTpYIRcWjbyB+r3DFLTbIu4DP1ZkyKQnhtaVvdZtx+U97R3FrAyJ5Ud09Ee1EmNxb
         JuGqQoxRD/eIXEobIoVCfKulKcpyBvbluM9kdQMueoxF6E9iZrb6gWB6x4/NUbr1bFdO
         seAg==
X-Gm-Message-State: ACrzQf1/OqYR2kmWlSHLt/mUrIuos/YTVorfcE5uCu9g5SA397DpMCy0
        ku6BY4p4hSnGkhncsIPQjAtECJbGVujBRabdfckmiPCR
X-Google-Smtp-Source: AMsMyM71m1f8KMiDAVjEXzY/K0sVj8+aEUthrvMR6Ej4mMwIwmdTihrZqy/o7IuZTGTA9W2c+7TkSTRHiHlqITR+ZHc=
X-Received: by 2002:aa7:979a:0:b0:563:a69:96c7 with SMTP id
 o26-20020aa7979a000000b005630a6996c7mr34237518pfp.29.1666637486209; Mon, 24
 Oct 2022 11:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20221019190356.3092073-1-jwcart2@gmail.com>
In-Reply-To: <20221019190356.3092073-1-jwcart2@gmail.com>
From:   James Carter <jwcart2@gmail.com>
Date:   Mon, 24 Oct 2022 14:51:14 -0400
Message-ID: <CAP+JOzQ+y_iyQNqysif2b3few5JE3R=23ATeoW12XP7H94zcpA@mail.gmail.com>
Subject: Re: [PATCH] python: Do not query the local database if the fcontext
 is non-local
To:     selinux@vger.kernel.org
Cc:     vmojzis@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Oct 19, 2022 at 3:04 PM James Carter <jwcart2@gmail.com> wrote:
>
> Vit Mojzis reports that an error message is produced when modifying
> a non-local fcontext.
>
> He gives the following example:
>   # semanage fcontext -f f -m -t passwd_file_t /etc/security/opasswd
>   libsemanage.dbase_llist_query: could not query record value (No such file or directory).
>
> When modifying an fcontext, the non-local database is checked for the
> key and then, if it is not found there, the local database is checked.
> If the key doesn't exist, then an error is raised. If the key exists
> then the local database is queried first and, if that fails, the non-
> local database is queried.
>
> The error is from querying the local database when the fcontext is in
> the non-local database.
>
> Instead, if the fcontext is in the non-local database, just query
> the non-local database. Only query the local database if the
> fcontext was found in it.
>
> Reported-by: Vit Mojzis <vmojzis@redhat.com>
> Signed-off-by: James Carter <jwcart2@gmail.com>

This has been merged.
Jim

> ---
>  python/semanage/seobject.py | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/python/semanage/seobject.py b/python/semanage/seobject.py
> index 0782c082..d82da494 100644
> --- a/python/semanage/seobject.py
> +++ b/python/semanage/seobject.py
> @@ -2504,16 +2504,19 @@ class fcontextRecords(semanageRecords):
>          (rc, exists) = semanage_fcontext_exists(self.sh, k)
>          if rc < 0:
>              raise ValueError(_("Could not check if file context for %s is defined") % target)
> -        if not exists:
> +        if exists:
> +            try:
> +                (rc, fcontext) = semanage_fcontext_query(self.sh, k)
> +            except OSError:
> +                raise ValueError(_("Could not query file context for %s") % target)
> +        else:
>              (rc, exists) = semanage_fcontext_exists_local(self.sh, k)
> +            if rc < 0:
> +                raise ValueError(_("Could not check if file context for %s is defined") % target)
>              if not exists:
>                  raise ValueError(_("File context for %s is not defined") % target)
> -
> -        try:
> -            (rc, fcontext) = semanage_fcontext_query_local(self.sh, k)
> -        except OSError:
>              try:
> -                (rc, fcontext) = semanage_fcontext_query(self.sh, k)
> +                (rc, fcontext) = semanage_fcontext_query_local(self.sh, k)
>              except OSError:
>                  raise ValueError(_("Could not query file context for %s") % target)
>
> --
> 2.37.3
>
