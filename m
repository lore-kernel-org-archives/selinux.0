Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 466C5C433EF
	for <selinux@archiver.kernel.org>; Tue, 14 Jun 2022 13:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243056AbiFNNWG (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 14 Jun 2022 09:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiFNNWF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 14 Jun 2022 09:22:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4987D3BBE7
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 06:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655212920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WiBrxssQpinbg5eF+ejemeyzdJpgfZMBNUH1MW9rv8U=;
        b=XL84NwSAWKQHDCDtiXEp57GY8Jxb2DssGt2mPoSVQeeIon35oC/3W9oPI4MI0aGiL9Jaaq
        X6QUFKgGkZ7TL/IGDvpla0XbvpkiWGhY6KpzwsaFb5uJv6JTholIrcK23O/rlOZV6CNku2
        BOTQo15HyAIRpyN0o8TAm+NysbSRTM4=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-cGGxADOjPTeJ5UbD9q-lPA-1; Tue, 14 Jun 2022 09:21:56 -0400
X-MC-Unique: cGGxADOjPTeJ5UbD9q-lPA-1
Received: by mail-yb1-f198.google.com with SMTP id v127-20020a256185000000b0065cbe0f6999so7547269ybb.22
        for <selinux@vger.kernel.org>; Tue, 14 Jun 2022 06:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WiBrxssQpinbg5eF+ejemeyzdJpgfZMBNUH1MW9rv8U=;
        b=XGQJ/wrBkdiUxS/r0xbQMo2a91BzG4KsHtx2ETQyQRFnJO1SZ1vZxFPwaBVMw+EkWY
         oB0eiY+bFnqK8+ykR2MuxzA3E0elnTOkq7bt6n6vQG+gHuZQTKbjgJJjFLgNmCplA2H9
         BD4uuv9ySf0sdyUQBHrxJ6kMWQiPEDCQiFHuQRGm7nHDLVOwlr7G5weAI/22QxVjOmaf
         /7na6vvYVt06qx1yHJbk4SLnAX5/T/gNm0Xnc2tG7XGM/luRXWXv5tnSwFbhEsnm/11e
         6dbpcrrvArjx6XSNrp+JuVrSc4mXVB2yZmiAeJrmNq42a1fJvzMcqvzG8CJ7byBOlolL
         N3xw==
X-Gm-Message-State: AJIora/kQXaGw2+Rl4BdbMODGqBmTFkPZAQnQXigIeIgaFFvA+fXWbsc
        H/uYO3vltIhJfHI9d2hV5kOFuaEdeUZU2B1jYS6Yz186ZIYef+c/H3T6fXKeS8WLy32/oCpm2qz
        E1qyeXheROwmTMxAfKOvt4YoX2OY1DpR+rg==
X-Received: by 2002:a81:7010:0:b0:30c:c6cf:d4af with SMTP id l16-20020a817010000000b0030cc6cfd4afmr5349023ywc.459.1655212915752;
        Tue, 14 Jun 2022 06:21:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1st4EhRxwVCuKSLOyqDeYNqXFnwGmlRV+UcmgiskaZtWFitTHvdYAZ7xu7GhcBw7apx5gvc3eL+pHEXEW1A1jE=
X-Received: by 2002:a81:7010:0:b0:30c:c6cf:d4af with SMTP id
 l16-20020a817010000000b0030cc6cfd4afmr5348982ywc.459.1655212915290; Tue, 14
 Jun 2022 06:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220614102029.13006-1-cgzones@googlemail.com> <20220614102029.13006-3-cgzones@googlemail.com>
In-Reply-To: <20220614102029.13006-3-cgzones@googlemail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Tue, 14 Jun 2022 15:21:44 +0200
Message-ID: <CAFqZXNti4xMdGVo-D+a7-0=D3UFD2pJdZjPP3Kz0GpnU8O3UnQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] filesystem: allow getfilecon(3) to pass test
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Jun 14, 2022 at 12:21 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
>     filesystem/ext4/test .. 67/83 getfilecon(3) Failed: Permission denied
>     filesystem/ext4/test .. 71/83
>     filesystem/ext4/test .. 75/83 # Looks like you failed 1 test of 83.
>     filesystem/ext4/test .. Dubious, test returned 1 (wstat 256, 0x100)
>
>     type=3DPROCTITLE msg=3Daudit(02/05/22 11:47:03.170:7047) : proctitle=
=3D/root/workspace/selinux/selinux-testsuite/tests/filesystem/ext4/check_mo=
unt_context -r -m /root/workspace/selinux/selinux-testsu
>     type=3DPATH msg=3Daudit(02/05/22 11:47:03.170:7047) : item=3D0 name=
=3D/root/workspace/selinux/selinux-testsuite/tests/filesystem/ext4/mntpoint=
/mp1 inode=3D390506 dev=3Dfe:01 mode=3Ddir,750 ouid=3Droot ogid=3Droot rdev=
=3D00:00 obj=3Dunconfined_u:object_r:unlabeled_t:s0 nametype=3DNORMAL cap_f=
p=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0 cap_frootid=3D0
>     type=3DCWD msg=3Daudit(02/05/22 11:47:03.170:7047) : cwd=3D/root/work=
space/selinux/selinux-testsuite/tests
>     type=3DSYSCALL msg=3Daudit(02/05/22 11:47:03.170:7047) : arch=3Dx86_6=
4 syscall=3Dgetxattr success=3Dno exit=3DEACCES(Permission denied) a0=3D0x7=
ffcd27c5651 a1=3D0x7fec8529078d a2=3D0x645b39a13550 a3=3D0xff items=3D1 ppi=
d=3D76535 pid=3D77228 auid=3Droot uid=3Droot gid=3Droot euid=3Droot suid=3D=
root fsuid=3Droot egid=3Droot sgid=3Droot fsgid=3Droot tty=3Dpts1 ses=3D1 c=
omm=3Dcheck_mount_con exe=3D/root/workspace/selinux/selinux-testsuite/tests=
/filesystem/check_mount_context subj=3Dunconfined_u:unconfined_r:test_files=
ystem_context_t:s0-s0:c0.c1023 key=3D(null)
>     type=3DAVC msg=3Daudit(02/05/22 11:47:03.170:7047) : avc:  denied  { =
getattr } for  pid=3D77228 comm=3Dcheck_mount_con name=3Dmp1 dev=3D"vda1" i=
no=3D390506 scontext=3Dunconfined_u:unconfined_r:test_filesystem_context_t:=
s0-s0:c0.c1023 tcontext=3Dunconfined_u:object_r:unlabeled_t:s0 tclass=3Ddir=
 permissive=3D0

Does this happen on Debian only? Do you know why it isn't/hasn't been
happening on Fedora/RHEL?

>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
>  policy/test_filesystem.te | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
> index 4e27134..46e3f1a 100644
> --- a/policy/test_filesystem.te
> +++ b/policy/test_filesystem.te
> @@ -382,7 +382,7 @@ allow test_filesystem_fscontext_t test_filesystem_con=
text_file_t:file { create g
>
>  # For testing rootcontext=3D Set mountpoint to unlabeled first
>  allow test_filesystem_context_t test_file_t:dir { relabelfrom };
> -allow test_filesystem_context_t unlabeled_t:dir { mounton relabelto };
> +allow test_filesystem_context_t unlabeled_t:dir { getattr mounton relabe=
lto };
>
>  #
>  ####################### Rules for nfs_filesystem/test ##################=
#
> --
> 2.36.1
>

--=20
Ondrej Mosnacek
Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

