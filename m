Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D21C433EF
	for <selinux@archiver.kernel.org>; Fri, 27 May 2022 17:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354285AbiE0ROZ (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 27 May 2022 13:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354316AbiE0ROT (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 27 May 2022 13:14:19 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CDF14087E
        for <selinux@vger.kernel.org>; Fri, 27 May 2022 10:14:13 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v4-20020a1cac04000000b00397001398c0so4897603wme.5
        for <selinux@vger.kernel.org>; Fri, 27 May 2022 10:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=g51q2mXb5+k06N8gFDAqwQ5DjvCeX9211CYuazQZoFg=;
        b=bWX3ACTE/Ce6Bl14Ahy3qgQZG5yNzXzmO22seTgEbUzK8s4B9qzlwgk+aRV1cIi5UO
         XoEj7wzSLklM85BJ+Lcy4/nSZ//iuiOnBvFjs83etGBt+fRkliAH12yd9Li8qXnP6/BD
         riOvbCjUCPpJof+Y8j+1D6ZTdlfXSUjoyqtoV+Utp9tjsBZIDNpui8Ib2XIIwoQLST3s
         zXgdoeTsfOWU8mgzme7ROlL9ZXm2lWXbF+AD/Nx/XHqp+fHVk4FGsB4gdbuq94DxppoE
         DVTVqYgWB/P3WxflI4lmynXv6y7zQ/x2yqcnjGnA9v5m1Esorkki6TMb/m/i2Nw3Cvs4
         HZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=g51q2mXb5+k06N8gFDAqwQ5DjvCeX9211CYuazQZoFg=;
        b=pF9dTH90C9ufH0OLyTnplGuFq6oca2e2Vd+pJ1bnlAGTRJlmZ++BNlzlWN8DX11D2A
         qtgWWLwZJIFyfD+bWPgeV82dgduv1pz0lQkOtfJ6O5ZU6yDvUu4dRQ+DG7aWR4GTRVMr
         xdKyEPgIyJX5ELWfvPa5oXQr6Lw1rnr7T+J3tFi+BoMROvXZuBFbF8pYJgeBN/m7I6G6
         c4uL20WhFXmoZXBCHrrYjAlXBG6Gy61Ac0sVcnPlqUdvS3onaYXA4+AthXkiR6TDef7g
         tufVHWxZlciaUx4dDEFl4regPJ5Dp4a0IYIvikZBTR1nQZ8bhmEi/jUI1/JdLf8NySJi
         G5xw==
X-Gm-Message-State: AOAM531i3o7fKvHciRK+SKbi9Mu6XU29uTtTn2owNsUmInTNOOsMDz/L
        zOEOKC32DdJphVLUeTtPBLFvvwsjhk0R9+2cfO8K4StONO1C
X-Google-Smtp-Source: ABdhPJwb4OlsR2Rmie8UABaWhXWnAaZXKDNkNVOD8nJxes0qMmbddpWlhdDPefigwLyqrDSR/lYexF2IBEOj9gorXCQ=
X-Received: by 2002:a7b:c5c6:0:b0:397:8a39:37b with SMTP id
 n6-20020a7bc5c6000000b003978a39037bmr3939550wmk.182.1653671651975; Fri, 27
 May 2022 10:14:11 -0700 (PDT)
MIME-Version: 1.0
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 27 May 2022 13:14:00 -0400
Message-ID: <CAHC9VhSJUmLmeNQBc5-ornFqtB1v1ogjmwfVBN+VKg4qK7PSuA@mail.gmail.com>
Subject: Re: [SELinux-notebook PATCH] network_support.md: clarify local port
 range and name_bind
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

My apologies for not replying directly to the original posting, for
some reason this never hit my inbox.

From: Dominick Grift @ 2022-05-23
> diff --git a/src/network_support.md b/src/network_support.md
> index bec725e..05ec0e8 100644
> --- a/src/network_support.md
> +++ b/src/network_support.md
> @@ -668,6 +668,17 @@ statements):
> semanage port -a -t my_server_port_t -p tcp -r s0 12345
> ```
>
> +Ports in the local port range can be auto-assigned by the kernel to
> +unbound sockets on first use. Controlling binding to ports is only
> +useful when the port number is a "name" (i.e. a well-defined value that
> +is expected to correspond to a specific service).
> +
> +The *name_bind* operation is not controlled on sockets associated
> +with ports in the local port range:
> +```
> +sysctl net.ipv4.ip_local_port_range
> +```
> +

Despite the sysctl name, these ports are typically referred to as
"ephemeral ports" and not "local ports".  I would suggest the text
below as an alternate solution, what do you think?

Only ports that fall outside the local, or ephemeral, port range are
subject to the additional *name_bind* access check.  You can see the
current ephemeral port range on your system by checking the
*net.ipv4.ip_local_port_range* sysctl:
```
sysctl net.ipv4.ip_local_port_range
```

-- 
paul-moore.com
