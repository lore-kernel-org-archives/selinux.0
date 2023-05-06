Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A4AC77B75
	for <selinux@archiver.kernel.org>; Sat,  6 May 2023 09:17:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjEFJRT (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Sat, 6 May 2023 05:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjEFJRS (ORCPT
        <rfc822;selinux@vger.kernel.org>); Sat, 6 May 2023 05:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8293F10DE
        for <selinux@vger.kernel.org>; Sat,  6 May 2023 02:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683364592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w0Rkn7fDZu22lITBkwqZ1gYTqsmZqBjd8YuJxBvfsxw=;
        b=HNF7Th723dtFn5I476vTRouLmG316hkVLUdq2DHSYdiV5jwhv724Ct1poFFsP4qFcoUEkh
        QbqPqxuPDwQP9rUD4adCJp70cxyoxz+r2k1DmAi5cEXsX7CBnDZ6QKoANfX1iP0jfo2dBm
        GhxKEHfny3Rp/fq6EUPp22qs2a7uj9M=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-_yffiySVNIe6USYXA0fjrg-1; Sat, 06 May 2023 05:16:31 -0400
X-MC-Unique: _yffiySVNIe6USYXA0fjrg-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-24e40246bb6so1294474a91.0
        for <selinux@vger.kernel.org>; Sat, 06 May 2023 02:16:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683364590; x=1685956590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0Rkn7fDZu22lITBkwqZ1gYTqsmZqBjd8YuJxBvfsxw=;
        b=eu/fq5czHQRc8dkbahBxy/PsQ7N836xSxjz1FGM+muxrNAqizk16SJFoTqIMBambpk
         vDwYx9ahBdD3+llL3p0qNiENlnoKy5NAY+m5KsyaYyOb3i3o24TicgaeApsH74g31pRV
         Koz4/l32Jb9+oREtUm5v9GOnwllolmrVoMA2oWcQQBwd8M/Siw/bbXoayeSUTPRjRoGZ
         ygJp8CoazhgSbdxVgS6vQADAmmw5QtrVCAsAc4r+FXbHTMqIq95X8qoR+7weY3SjA3jX
         ErxoTqtY8sCsYpFgYDbIYWVxfz53ovbRUpHEKt26cSTuIjsO65KEVDHa7PlhqoFyU3Wb
         Gbqw==
X-Gm-Message-State: AC+VfDwFZR606KLzmDEsFW3xs1PiovmM2ldeb+3XK3fBsT7UJVRDrgDL
        fe4UtIlQgo6FRnQznCyZlmNSx1HZ3jw3cMNkzuq13C5zn4Udygv3GT33aMUaGkPSunFOmt8/rGl
        6/hHxl7oUgiiFxLiBnIdR+nzAdfh9iNJcMQAsecA8p3fHyo4=
X-Received: by 2002:a17:90b:3648:b0:250:32e2:5681 with SMTP id nh8-20020a17090b364800b0025032e25681mr3984968pjb.6.1683364590229;
        Sat, 06 May 2023 02:16:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ751dtOpMZF9pGrxbVqcIsVth6ZG2DRs733sTystfKKZgrv65iwlHbXy0WgfcqtkIZj3iPTWFqMYOzH2lCrizA=
X-Received: by 2002:a17:90b:3648:b0:250:32e2:5681 with SMTP id
 nh8-20020a17090b364800b0025032e25681mr3984958pjb.6.1683364589953; Sat, 06 May
 2023 02:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230505224934.645040-1-paul@paul-moore.com>
In-Reply-To: <20230505224934.645040-1-paul@paul-moore.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Sat, 6 May 2023 11:16:18 +0200
Message-ID: <CAFqZXNuuH44-o0O37v8ENDi1cykv-de1KwOeYieis8DgsXXjkg@mail.gmail.com>
Subject: Re: [PATCH] selinux: remove avc_disable() as it is no longer used
To:     Paul Moore <paul@paul-moore.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Sat, May 6, 2023 at 12:51=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> With the removal of the runtime disable functionality we no longer
> have any callers of the avc_disable() function, remove it.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  security/selinux/avc.c         | 19 -------------------
>  security/selinux/include/avc.h |  3 ---
>  2 files changed, 22 deletions(-)
>
> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index eaed5c2da02b..6bc65830e1a9 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -1203,22 +1203,3 @@ u32 avc_policy_seqno(void)
>  {
>         return selinux_avc.avc_cache.latest_notif;
>  }
> -
> -void avc_disable(void)
> -{
> -       /*
> -        * If you are looking at this because you have realized that we a=
re
> -        * not destroying the avc_node_cachep it might be easy to fix, bu=
t
> -        * I don't know the memory barrier semantics well enough to know.=
  It's
> -        * possible that some other task dereferenced security_ops when
> -        * it still pointed to selinux operations.  If that is the case i=
t's
> -        * possible that it is about to use the avc and is about to need =
the
> -        * avc_node_cachep.  I know I could wrap the security.c security_=
ops call
> -        * in an rcu_lock, but seriously, it's not worth it.  Instead I j=
ust flush
> -        * the cache and get that memory back.
> -        */
> -       if (avc_node_cachep) {
> -               avc_flush();
> -               /* kmem_cache_destroy(avc_node_cachep); */
> -       }
> -}
> diff --git a/security/selinux/include/avc.h b/security/selinux/include/av=
c.h
> index 9301222c8e55..9e055f74daf6 100644
> --- a/security/selinux/include/avc.h
> +++ b/security/selinux/include/avc.h
> @@ -168,9 +168,6 @@ int avc_get_hash_stats(char *page);
>  unsigned int avc_get_cache_threshold(void);
>  void avc_set_cache_threshold(unsigned int cache_threshold);
>
> -/* Attempt to free avc node cache */
> -void avc_disable(void);
> -
>  #ifdef CONFIG_SECURITY_SELINUX_AVC_STATS
>  DECLARE_PER_CPU(struct avc_cache_stats, avc_cache_stats);
>  #endif
> --
> 2.40.1
>

The same patch (modulo subject & description) has already been posted
by Christian:
https://lore.kernel.org/selinux/20230420150503.22227-3-cgzones@googlemail.c=
om/

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

