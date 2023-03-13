Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76861C61DA4
	for <selinux@archiver.kernel.org>; Mon, 13 Mar 2023 13:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjCMNoo (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 13 Mar 2023 09:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCMNon (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 13 Mar 2023 09:44:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3051515E2
        for <selinux@vger.kernel.org>; Mon, 13 Mar 2023 06:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678715036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mGCfoLXeSqkA02L0Xgboi9ThI6BDYDDobA3aPEkTiCc=;
        b=UchJE/Z/hxU7AVhRbTRr5wqGNkG+Bd7Fs2MEaxGnTkcbXGDdmt1F84bZ3NjIbdwaYbouht
        i5M04WV/rYISq7JvsoK79cws1jVD9CExlSvsDoIa0pzSqAO0qu64AdS/+Xo1G9ylRhqsGY
        u4i4eMMiOEQVt71uVOWrw0de0+3qA7Q=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-QhFepvvWOHqYVFQeqtSU7A-1; Mon, 13 Mar 2023 09:43:54 -0400
X-MC-Unique: QhFepvvWOHqYVFQeqtSU7A-1
Received: by mail-pl1-f197.google.com with SMTP id s8-20020a170902b18800b0019c92f56a8aso7287569plr.22
        for <selinux@vger.kernel.org>; Mon, 13 Mar 2023 06:43:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678715033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGCfoLXeSqkA02L0Xgboi9ThI6BDYDDobA3aPEkTiCc=;
        b=3HiX4fWoYyG2TslFdVIa9VmBE7cWYMpTtwcqzNSpBUxir8OuIITRkzroTE2R6phf+k
         HurD4QSHojAjURnlFmUN9iLvSsiEClWV4kGqYZqkWpJmQ0T7Zpzt3I3aJukRB3EYUoht
         7Afyd+2ZiVS2pjBXCAqEVaFI2mgwiMCMH3KeK1Ct+PibfHjTErNnKj8IIYVOji0dIXoD
         lTg9HxONYXX+Osait+ks3P5txvnD/jFacD8E42bkIkLNzl+yDRIMxEU/Voy1QaNsEE7E
         NEa22YpMpl/6OeyNf/zUbHOB4QFinQGhYioJzt5j6pYo3Y7cMystRga0/0K16W+rzlcA
         nPBg==
X-Gm-Message-State: AO0yUKUXTBDajicFU3U6IRS03tytyWFY6434Z7Em/WIN/e28jRDkM6Mt
        hP23g85qHTyyVtyQxtS8vnRA+jsiGbdFUOjB99Uc/tlNC7XsVhFIZBuuNXVlZ/9jLl9UnuXO50s
        zFVbIBq/lNZXPlyYeSWxbjYv8+olU7YQLfGPJc7dk3bVyZMY=
X-Received: by 2002:a17:90a:6e06:b0:23b:5161:f66f with SMTP id b6-20020a17090a6e0600b0023b5161f66fmr1644923pjk.9.1678715033298;
        Mon, 13 Mar 2023 06:43:53 -0700 (PDT)
X-Google-Smtp-Source: AK7set+NA6syflWPUFM81/WU7QUd614oa+O8qi1dlYbI3l8kg+J+lHYIGdT7nJrYGIkFc/SHfSRZA+F6NqvpR/+GKq0=
X-Received: by 2002:a17:90a:6e06:b0:23b:5161:f66f with SMTP id
 b6-20020a17090a6e0600b0023b5161f66fmr1644920pjk.9.1678715033046; Mon, 13 Mar
 2023 06:43:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230310165050.27749-1-stephen.smalley.work@gmail.com>
In-Reply-To: <20230310165050.27749-1-stephen.smalley.work@gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 13 Mar 2023 14:43:41 +0100
Message-ID: <CAFqZXNtQSrtmDDLqic5mP-3RZ6i+OtN8B8x3Rc+TZepNN7Svag@mail.gmail.com>
Subject: Re: [PATCH testsuite] defconfig: add FAT and GRE config options
To:     Stephen Smalley <stephen.smalley.work@gmail.com>
Cc:     selinux@vger.kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 10, 2023 at 5:52=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> These are required for some of the fat filesystem and sctp tests to run.
>
> Signed-off-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> ---
>  defconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/defconfig b/defconfig
> index ca7a877..2783c01 100644
> --- a/defconfig
> +++ b/defconfig
> @@ -42,6 +42,13 @@ CONFIG_IP_SCTP=3Dm
>  CONFIG_BT=3Dm
>  CONFIG_CRYPTO_USER_API=3Dm
>
> +# Network protocol implementations.
> +# These are enabled to run sctp ASCONF tests using a GRE tunnel
> +CONFIG_NET_IPGRE_DEMUX=3Dm
> +CONFIG_NET_IPGRE=3Dm
> +CONFIG_NET_IPGRE_BROADCAST=3Dy
> +CONFIG_IPV6_GRE=3Dm
> +
>  # Netlink protocol implementations.
>  # These are enabled to test the netlink socket controls in
>  # tests/netlink_socket; they are not required for SELinux operation itse=
lf.
> @@ -112,6 +119,7 @@ CONFIG_NFSD_V4_SECURITY_LABEL=3Dy
>  CONFIG_XFS_FS=3Dm
>  CONFIG_XFS_QUOTA=3Dy
>  CONFIG_VFAT_FS=3Dm
> +CONFIG_FAT_DEFAULT_IOCHARSET=3D"ascii"
>
>  # watch_queue for key changes.
>  # They are not required for SELinux operation itself.
> --
> 2.39.2

Applied, thanks!
https://github.com/SELinuxProject/selinux-testsuite/commit/1c0b28e34eb77631=
90e3a87966cab82d9fcb50fa

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

