Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FE1C64ED6
	for <selinux@archiver.kernel.org>; Tue, 28 Feb 2023 17:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjB1RBg (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 28 Feb 2023 12:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjB1RBe (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 28 Feb 2023 12:01:34 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7CFF9E
        for <selinux@vger.kernel.org>; Tue, 28 Feb 2023 09:01:33 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id x34so10546786pjj.0
        for <selinux@vger.kernel.org>; Tue, 28 Feb 2023 09:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1677603693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMNqOMQgsrSQIgK+2+E9sIcuoL7OJ0m5v83OM/bMu2A=;
        b=cUaH7PQ+orT2GNI4x4fXYRqbINZ2fu32S7pn0fG/k1ZJ0HyHmYidNhJfNtxoaAllWu
         ouLVut1Gf8G7dtHOrPUbq6cEE0P48kEaepmrzqXMPBCJ6aL2RAxxfC7/1rgdsNd5PPFf
         0gIzKy9rYgiq35kV1361miiYrmD3U9Skciu40DlioxVTeAF16aFOiaaVj7n+tyUovALL
         xPG7hXVmbIpV3Y0IjI7B6SzBnOKkscBe3sr2LVForFSChzHtBXReRSfdIJ8CmqDw0syN
         nlUOEY8HglKmFY3tK0qVzz6QeuHPBZxh3dJwKLDiimm7g3be1bWkabOWH4l88kDop+j8
         4MIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677603693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMNqOMQgsrSQIgK+2+E9sIcuoL7OJ0m5v83OM/bMu2A=;
        b=YY07vOPxkYjrHYkuWmPNtuJSyzzinbfqzUAg7MmJJ6C55wsSHagpRszcoKJYcy9w53
         G+qNMpY9ui25K5/9dYq0sRZkq0+4XdnYgrJRaYzT3ZrOiAD20X7E+1SCHJZiyc6H9M/o
         H8b5vyyBOQnkE9kbhCT0W9aqAoVbGDKvjoBUbX49vwCto35oX4x/WJh5X3dh9rtk13Er
         xF+mbXURVya/mYIOpU2yVaiQYCcxAWqiPj2LvRO2RSgjxAhcqVoufzob4VlhJtT48zsP
         V/5zO8cvBRBqlwdfapF13iRMx9hZscTkJXmMp9jI1SvyZSngh0EV/6B+Isth0hZvFCwY
         pjPQ==
X-Gm-Message-State: AO0yUKXmVj8YZa2zZhqwtDF1K3Z72NlVfEj9EWResQMUb5/sqGDMxkGs
        yIsCQQq+GmqFG2LDA7y/oiMhEADgjVRG8s0h6goO
X-Google-Smtp-Source: AK7set9lKHadUh8HSIetG6tzbWD+qZpb6pqYuLEi4jPB+Jf+T4AuiSmTUaVrQvv1FYTELbo8XLirsDVx85j1DtaTvZI=
X-Received: by 2002:a17:90a:17ca:b0:237:50b6:9a09 with SMTP id
 q68-20020a17090a17ca00b0023750b69a09mr1484320pja.0.1677603693349; Tue, 28 Feb
 2023 09:01:33 -0800 (PST)
MIME-Version: 1.0
References: <20230228141247.626736-1-omosnace@redhat.com> <20230228141247.626736-3-omosnace@redhat.com>
In-Reply-To: <20230228141247.626736-3-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 28 Feb 2023 12:01:22 -0500
Message-ID: <CAHC9VhT8+vFwzZk4ba5nNd8uQJj3JqqJzttV=1pLPO0U82xxXg@mail.gmail.com>
Subject: Re: [PATCH testsuite 2/3] policy: allow test_ibpkey_access_t to use
 RDMA netlink sockets
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Chris PeBenito <pebenito@ieee.org>
Cc:     selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Feb 28, 2023 at 9:13=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> ibv_get_device_list(3) first tries to get the device list via netlink
> and if that fails it falls back to getting it from sysfs. Currently the
> policy denies getting it from netlink, generating some denials. Allow
> test_ibpkey_access_t the necessary permissions so it can do it the
> preferred way and doesn't generate audit AVC noise.
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  policy/test_ibpkey.te | 1 +
>  1 file changed, 1 insertion(+)

Similar to the other policy issue, it seems like this is a general
problem and not specifically a selinux-testsuite issue, right?  If
that is the case should we fix this in refpol?  I think it's okay to
put a temporary fix in the test suite, but we should also push to fix
this in refpol.

> diff --git a/policy/test_ibpkey.te b/policy/test_ibpkey.te
> index 97f0c3c..6835897 100644
> --- a/policy/test_ibpkey.te
> +++ b/policy/test_ibpkey.te
> @@ -11,6 +11,7 @@ testsuite_domain_type(test_ibpkey_access_t)
>  typeattribute test_ibpkey_access_t ibpkeydomain;
>
>  allow test_ibpkey_access_t self:capability ipc_lock;
> +allow test_ibpkey_access_t self:netlink_rdma_socket create_socket_perms;
>
>  dev_rw_infiniband_dev(test_ibpkey_access_t)
>  dev_rw_sysfs(test_ibpkey_access_t)
> --
> 2.39.2

--=20
paul-moore.com
