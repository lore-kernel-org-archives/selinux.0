Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB746EB64DC
	for <selinux@archiver.kernel.org>; Mon, 17 Jul 2023 12:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjGQMaK (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 17 Jul 2023 08:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGQMaJ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 17 Jul 2023 08:30:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDA0B9
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 05:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689596960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZRIEwJ11juDLN/oMKdyh+ABp1/wxZ7fMqk4UEo2kauE=;
        b=gVa3uEFiAqkIT+FycdEJMabjxUR8bJLRRZL5Xd0UFcDL/LS6mczQ02gBUh3bewK8g2Jx8I
        hmEgUAT86Pw4zjlXVAJALNtXY1SCQUd8Dc5GfAjd3j1kRdKyzDK0O60Z3IHkErE0mqgeTI
        cQqeIALzChGhTyi2bTpaMuMGZp6zYDg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-q07G0BOVMhmlsZZFvMs_rw-1; Mon, 17 Jul 2023 08:29:19 -0400
X-MC-Unique: q07G0BOVMhmlsZZFvMs_rw-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-262f872fdcdso1788461a91.1
        for <selinux@vger.kernel.org>; Mon, 17 Jul 2023 05:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689596957; x=1692188957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRIEwJ11juDLN/oMKdyh+ABp1/wxZ7fMqk4UEo2kauE=;
        b=f3QlYPmyF3XmobH8iUsfVaZQN0FfnXzMYlCu7XVEZJd/VDOWv+wxOkRgW0gVjTyM41
         80hHUXDrhrQU8qzBt688NW99LucSesvNCA8/rlk6Z3/b9fm8Ho4UttrCDqzcXkQV8LrW
         Ne9YirCJrKFez82Jju5l2EZgk5VuUp9TROF54BAUpr7Sdmx9JgnnX8s8XmueTUeAqRPq
         I5Gi1o4jnJNNtX3VP6ha1U+hIY31DSfRaodph687hcYWz4wbuvWIswEYGvZdpPQvfEYq
         Rbw95zZkr+nybokENGeSRS+2YpBKXiOqyntyTqcZioJg2c/K0gmATQIpUGOtxOh2V66p
         hqGg==
X-Gm-Message-State: ABy/qLaeXNBl5Z6ojQ5nm2z/JTIp/BZ8JLLzzBkfUFM0W/gn+Y6+dEcg
        iVYRxbjC7DhV5qTy3HD+LXT5N8GGWddH9iB0QX/0BIR2PJBKw5i8JdZwVAls2WLgBfB3l+j5u5u
        WHM+ILgWR4Z4lvRhFg7Lf6IZSpnMZfkrJJ8Op0OBE6PMQ
X-Received: by 2002:a17:90b:38cf:b0:256:857f:823d with SMTP id nn15-20020a17090b38cf00b00256857f823dmr8670117pjb.48.1689596957692;
        Mon, 17 Jul 2023 05:29:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEF9VmcT50KNGbesRWk2mdSOWVGvSHGvukiKY0Bhl+AIEvAeaexrv4LbQPK4MdyXO9+xxzWoxygDiyKZsxE8qA=
X-Received: by 2002:a17:90b:38cf:b0:256:857f:823d with SMTP id
 nn15-20020a17090b38cf00b00256857f823dmr8670107pjb.48.1689596957441; Mon, 17
 Jul 2023 05:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230714180554.17850-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20230714180554.17850-1-stephen.smalley.work@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 17 Jul 2023 14:29:06 +0200
Message-ID: <CAFqZXNuBETzsnAFhTXaH_zyv3sj+VWPRLX9Ok5qdpAptL7pxnQ@mail.gmail.com>
Subject: Re: [PATCH testsuite] policy: allow inet socket test domains to
 search user home content
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 14, 2023 at 8:07=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> This is necessary for resolving pathnames when running the testsuite
> from a user home directory.
>
> Reproducer:
> 1. Clone selinux-testsuite into home directory.
> 2. Try running it there.
>
> Before:
> inet_socket/tcp/test ........ Flag file open: Permission denied
> (test hangs)
>
> After:
> all tests complete and pass
>
> Fixes: 4dcea27ada77f51c2868095e951aab790374fba9 ("tests/inet_socket:
> cover the MPTCP protocol")
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  policy/test_inet_socket.te | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/policy/test_inet_socket.te b/policy/test_inet_socket.te
> index 47969fc..0eacb31 100644
> --- a/policy/test_inet_socket.te
> +++ b/policy/test_inet_socket.te
> @@ -154,3 +154,6 @@ allow test_inet_client_t test_server_packet_t:packet =
{ send recv };
>  # Send/recv unlabeled packets.
>  kernel_sendrecv_unlabeled_packets(inetsocketdomain)
>  kernel_recvfrom_unlabeled_peer(inetsocketdomain)
> +
> +# Search user home directories (for running testsuite from one)
> +userdom_search_user_home_content(inetsocketdomain)
> --
> 2.40.1

Thank you for the patch, although this made me realize that we can
grant userdom_search_user_home_content()/userdom_search_admin_dir() to
the whole test_domain in test_general.te to simplify the policy (there
are a few other existing uses of them in other subtests).

I posted an alternative patch to the list - please let me know if
you're okay with it.

--
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

