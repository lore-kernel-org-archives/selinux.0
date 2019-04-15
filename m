Return-Path: <SRS0=LFc9=SR=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B20EC282DA
	for <selinux@archiver.kernel.org>; Mon, 15 Apr 2019 16:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE1A221903
	for <selinux@archiver.kernel.org>; Mon, 15 Apr 2019 16:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="qUW6PqTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfDOQrF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 15 Apr 2019 12:47:05 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45635 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbfDOQrF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 15 Apr 2019 12:47:05 -0400
Received: by mail-lj1-f194.google.com with SMTP id y6so16284896ljd.12
        for <selinux@vger.kernel.org>; Mon, 15 Apr 2019 09:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oFPYO037ebhtL701zcCWX/6aC0fFQ8AaSPyAL+cXxjg=;
        b=qUW6PqTywFUUOUVXlFvfDzJrn8b5pDlJIhprfT2oGF8MJhqAdbTVIvE6USiN9Cys/0
         yJz7w7MAXcrZYKeau+4S0v3ypFFgAftXk8CAdQeQRR8BojkfplPJS0TO63WuMiJMOE3v
         J1OFF+ShN90Zuzbl6PdBZJwpYf91I4Fy5pbo1pASRYGdu6YebX7b6BAwpm5HEYwHdecm
         KUwbQUVoihOQNRMKxQ7qhHb6GhE2yOcVmKKiQZiXrZbrL7zOU1VFi0LYToD8EspVArpf
         4K4WgUOLMXM/tUfsKDQ77yXZRykq+t07HAoPAaG6Wu2jKHfnpFHsuCj3LkB7jmA2U5V0
         qsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oFPYO037ebhtL701zcCWX/6aC0fFQ8AaSPyAL+cXxjg=;
        b=hqegO1qGpvPHhqUPQAPLSJFRNbdB5fAJWWjkWpdyS96/iBM7Z4RFElrpO8yt0QLOO5
         5SP93rguAYSXJ/nUwLJX5Qx2hwAwkAl1n79aspNzjgvAahbrR4Ali61sRUseHCUyecsR
         tgiSQw8e/0oZuAkI2jSyvZSuq+LO3swoZ/+efOA1FDJWRv9q9p2ulqJS2kgiXBRb0a7T
         nkW/Mzhoapfm+d5TzLK1zvrTVyEZUoXIdrWxj1okvw7ACenOhCuq41CH3u5YRZI5fFXR
         tjbDVD7kNDbZWSq5EagdJz7XZ0sebvkUH8HHwMcxn/eQXtIfL9bG5I8S5uu7N05kEpSM
         PPJQ==
X-Gm-Message-State: APjAAAXXlH8FP4Kd6hV5Ss+puwucxgMzQFbl3OMwE7JijVmE1CIdYurx
        Gi7Z5PxX7rqae+uVdUaO5uKk0ujl56bqu2YsQKS5
X-Google-Smtp-Source: APXvYqyWUmS3E/MvaIL6ymoPtzdep29bDFVqK89RS6AIBd5jzYKYxp2SRIRLHS3/Ph/Gx+fRv/LEmQg+ektd9FB5TJI=
X-Received: by 2002:a2e:8508:: with SMTP id j8mr21919996lji.26.1555346822939;
 Mon, 15 Apr 2019 09:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <1555066776-9758-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <1555066776-9758-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 15 Apr 2019 12:46:51 -0400
Message-ID: <CAHC9VhSCNOANdB=xQnQ6=ieWWPjUpcynYF_8kDOnaAK321cacQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] selinux: Check address length before reading address family
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Apr 12, 2019 at 7:00 AM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> KMSAN will complain if valid address length passed to bind()/connect() is
> shorter than sizeof("struct sockaddr"->sa_family) bytes.
>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  security/selinux/hooks.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

A reminder to please CC the SELinux mailing list on patches such as these.

This looks good to me, and since it's specific to SELinux, I've gone
ahead and merged it into the selinux/next branch.  Thanks for your
help on this.

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index d5fdcb0d26fe..c61787b15f27 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4512,7 +4512,7 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
>                 struct lsm_network_audit net = {0,};
>                 struct sockaddr_in *addr4 = NULL;
>                 struct sockaddr_in6 *addr6 = NULL;
> -               u16 family_sa = address->sa_family;
> +               u16 family_sa;
>                 unsigned short snum;
>                 u32 sid, node_perm;
>
> @@ -4522,6 +4522,9 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
>                  * need to check address->sa_family as it is possible to have
>                  * sk->sk_family = PF_INET6 with addr->sa_family = AF_INET.
>                  */
> +               if (addrlen < offsetofend(struct sockaddr, sa_family))
> +                       return -EINVAL;
> +               family_sa = address->sa_family;
>                 switch (family_sa) {
>                 case AF_UNSPEC:
>                 case AF_INET:
> @@ -4654,6 +4657,8 @@ static int selinux_socket_connect_helper(struct socket *sock,
>                  * need to check address->sa_family as it is possible to have
>                  * sk->sk_family = PF_INET6 with addr->sa_family = AF_INET.
>                  */
> +               if (addrlen < offsetofend(struct sockaddr, sa_family))
> +                       return -EINVAL;
>                 switch (address->sa_family) {
>                 case AF_INET:
>                         addr4 = (struct sockaddr_in *)address;
> --
> 2.16.5

-- 
paul moore
www.paul-moore.com
