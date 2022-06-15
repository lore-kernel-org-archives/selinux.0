Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5691FC433EF
	for <selinux@archiver.kernel.org>; Wed, 15 Jun 2022 12:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348252AbiFOMWI (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Wed, 15 Jun 2022 08:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348025AbiFOMWI (ORCPT
        <rfc822;selinux@vger.kernel.org>); Wed, 15 Jun 2022 08:22:08 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC8CE36E3D
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 05:22:05 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-10113b4c2b5so14566339fac.6
        for <selinux@vger.kernel.org>; Wed, 15 Jun 2022 05:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VUYD0zFmYLMVpsNItP9vcq/hw8v+BvGM93qMhNh8YH0=;
        b=IvBkFPFQ5YxfqobFjfViaZwqpea4jbGFoNCw+0VJrdvgRbKMHCImza4j7ExVPM8NXv
         9q9M2a4y3INpCqFpNayyeiuUL6UWyC25eKQMV73xBBHIXkqkmZmMii27odlLVPr14tuJ
         HciCZSTI0jBC2clJkTQ0gVwg69XG9sjaXT0kqn4aNRQD0Fuko9sZrLnKMG1eXLsDhZDn
         F+l0uBSBzkZaxBKeEyYPf00CqQ/GLrwlBMJY7ARrM5c4VvmDX//VNWXGx0TYtORWkFGU
         e3WYNtxKMZLyZ9REvv81SYxmt0gfDkFCgTRy5IMz1qxKKBPPnavLGTX66K3tenzpgt+v
         TC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VUYD0zFmYLMVpsNItP9vcq/hw8v+BvGM93qMhNh8YH0=;
        b=kWVsStfq6FMa4KP0s5Mo+hUi8f4ytpU7FDPclUFMq37b09smH4Ge7myl6mun0GfN2S
         IyH5COBZ6kfTva8T0srdM8hVNO1cpr2xq5AN+T8ti7DXjWspRLJ+7prqY8boECNYFpBK
         LmJyfBrAy1fH8lM85NXE3HVqIW03DKmkJjRUMn+XLbsLL3z7gc9Jc+FoOQe5zRNMwUIL
         tuzBu7dQ7eCsPXwJzv/RMZ/BaHOFRHjUp2qjYPzHQEUw6DGTTvsqj/Gh/VczAedP3h+C
         zcCVMoD1evMKYiA2U16hyhzqeO3GYQf1ZsfKV1GaeD2X5hKcGu8ON5lG2JKOqcYKItsO
         znaA==
X-Gm-Message-State: AJIora+HDGyj/ZQb9qnb5xZyLrpkh5ztr4bEvEVfJh11JAaev+OdA4np
        Wsn8nN4HnXJFT6X4OsWkdoTfqTar3+biVxMMwkY=
X-Google-Smtp-Source: AGRyM1u1oI4ILNoyYQgHS3JYkKy3QdxgBJ8KLHyII5GZ9gQau7cBhn3Si0Vu8EDNHrvZ+6KD44cVeEKZMBWw5nhvY4E=
X-Received: by 2002:a05:6870:e40c:b0:f3:2f32:7c3d with SMTP id
 n12-20020a056870e40c00b000f32f327c3dmr5271869oag.71.1655295725034; Wed, 15
 Jun 2022 05:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220614102029.13006-1-cgzones@googlemail.com>
 <20220614102029.13006-3-cgzones@googlemail.com> <CAFqZXNti4xMdGVo-D+a7-0=D3UFD2pJdZjPP3Kz0GpnU8O3UnQ@mail.gmail.com>
In-Reply-To: <CAFqZXNti4xMdGVo-D+a7-0=D3UFD2pJdZjPP3Kz0GpnU8O3UnQ@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Wed, 15 Jun 2022 14:21:53 +0200
Message-ID: <CAJ2a_DcwmtEz=4YA+5v0UCYoSjudxOy+6vKFJwUCprjdaHDhqg@mail.gmail.com>
Subject: Re: [PATCH 3/4] filesystem: allow getfilecon(3) to pass test
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 14 Jun 2022 at 15:21, Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Tue, Jun 14, 2022 at 12:21 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> >
> >     filesystem/ext4/test .. 67/83 getfilecon(3) Failed: Permission deni=
ed
> >     filesystem/ext4/test .. 71/83
> >     filesystem/ext4/test .. 75/83 # Looks like you failed 1 test of 83.
> >     filesystem/ext4/test .. Dubious, test returned 1 (wstat 256, 0x100)
> >
> >     type=3DPROCTITLE msg=3Daudit(02/05/22 11:47:03.170:7047) : proctitl=
e=3D/root/workspace/selinux/selinux-testsuite/tests/filesystem/ext4/check_m=
ount_context -r -m /root/workspace/selinux/selinux-testsu
> >     type=3DPATH msg=3Daudit(02/05/22 11:47:03.170:7047) : item=3D0 name=
=3D/root/workspace/selinux/selinux-testsuite/tests/filesystem/ext4/mntpoint=
/mp1 inode=3D390506 dev=3Dfe:01 mode=3Ddir,750 ouid=3Droot ogid=3Droot rdev=
=3D00:00 obj=3Dunconfined_u:object_r:unlabeled_t:s0 nametype=3DNORMAL cap_f=
p=3Dnone cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0 cap_frootid=3D0
> >     type=3DCWD msg=3Daudit(02/05/22 11:47:03.170:7047) : cwd=3D/root/wo=
rkspace/selinux/selinux-testsuite/tests
> >     type=3DSYSCALL msg=3Daudit(02/05/22 11:47:03.170:7047) : arch=3Dx86=
_64 syscall=3Dgetxattr success=3Dno exit=3DEACCES(Permission denied) a0=3D0=
x7ffcd27c5651 a1=3D0x7fec8529078d a2=3D0x645b39a13550 a3=3D0xff items=3D1 p=
pid=3D76535 pid=3D77228 auid=3Droot uid=3Droot gid=3Droot euid=3Droot suid=
=3Droot fsuid=3Droot egid=3Droot sgid=3Droot fsgid=3Droot tty=3Dpts1 ses=3D=
1 comm=3Dcheck_mount_con exe=3D/root/workspace/selinux/selinux-testsuite/te=
sts/filesystem/check_mount_context subj=3Dunconfined_u:unconfined_r:test_fi=
lesystem_context_t:s0-s0:c0.c1023 key=3D(null)
> >     type=3DAVC msg=3Daudit(02/05/22 11:47:03.170:7047) : avc:  denied  =
{ getattr } for  pid=3D77228 comm=3Dcheck_mount_con name=3Dmp1 dev=3D"vda1"=
 ino=3D390506 scontext=3Dunconfined_u:unconfined_r:test_filesystem_context_=
t:s0-s0:c0.c1023 tcontext=3Dunconfined_u:object_r:unlabeled_t:s0 tclass=3Dd=
ir permissive=3D0
>
> Does this happen on Debian only? Do you know why it isn't/hasn't been
> happening on Fedora/RHEL?

In fefora-policy unlabeled_t is associated with the attribute
file_type and thus the common rule

    allow test_filesystem_context_t file_type:dir { getattr open search };

grants the permission in question.

>
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  policy/test_filesystem.te | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/policy/test_filesystem.te b/policy/test_filesystem.te
> > index 4e27134..46e3f1a 100644
> > --- a/policy/test_filesystem.te
> > +++ b/policy/test_filesystem.te
> > @@ -382,7 +382,7 @@ allow test_filesystem_fscontext_t test_filesystem_c=
ontext_file_t:file { create g
> >
> >  # For testing rootcontext=3D Set mountpoint to unlabeled first
> >  allow test_filesystem_context_t test_file_t:dir { relabelfrom };
> > -allow test_filesystem_context_t unlabeled_t:dir { mounton relabelto };
> > +allow test_filesystem_context_t unlabeled_t:dir { getattr mounton rela=
belto };
> >
> >  #
> >  ####################### Rules for nfs_filesystem/test ################=
###
> > --
> > 2.36.1
> >
>
> --
> Ondrej Mosnacek
> Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>
