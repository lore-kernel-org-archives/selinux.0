Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CC9C3DA78
	for <selinux@archiver.kernel.org>; Tue, 17 Jan 2023 16:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjAQQKS (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 17 Jan 2023 11:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjAQQKQ (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 17 Jan 2023 11:10:16 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801B12BF1C
        for <selinux@vger.kernel.org>; Tue, 17 Jan 2023 08:10:14 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id d66so20249119vsd.9
        for <selinux@vger.kernel.org>; Tue, 17 Jan 2023 08:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRPgH7wckmfNM3VUBRscr9ZZQKdV4sgR/HvV2zfHEHk=;
        b=P7Val/sPhHJdUkurUGybRsXnxH5alBw0AjGGl6aq13cfQDvO/uuzgeXQ508NCnp0Hx
         FKSU8mPc6VGHBt20Lut31J9ZLu3MtWMeHnBH/MytR1JAP8PF6mrrqYKgV6dKsqB0jKr8
         Svvm/rUgc1Vp6DUwSZoxz1wFBQNvD4z34hkpvofTdlpKEcykmoNTOdE6M+oMgB3MsBWY
         0AzyepUBjiy2bdpCD6Nxgoh9jGyOFJzVl7Ap95br1lc3tagYT7zrmxwuEAG8L/59AyMh
         Mf7oa1hGnQORR9ruoH6juGnu/gCIwyqUQnqledBW4HC6nY40WJAQNd9p0VCNNuA6KqlO
         U7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRPgH7wckmfNM3VUBRscr9ZZQKdV4sgR/HvV2zfHEHk=;
        b=DmySF3dqMIauLm4f8+1HQE3WPht3C8VxZhcDcfJc/yG4aTkYb9cXxvEdJYI2FzNGjX
         bYKeZgYR0q5I3VpQryrxB57koKSiD/jX5t6BIVoZ//J9LV5xrZAH5h36LsD4K9eCFBPG
         0o/c/It6y+PFRdzXvHtfuGRJRrRq7pTtlaV/h1cIBmS7mKCglDe1OFsPSj44O1VTmHsF
         Z3U41TvgXFqKgujuiHX+MZ1Zgr4lZA1kwaCFcvPLQqqEazVWufvz9iMw4H+tDZxhoMTE
         DERTeCHuKMf+z1lqaRwwmkwwuYcj0VgGpcOTgYuv+24sDbsvQ+XEbCpUxhVZWj2damqG
         k8Gw==
X-Gm-Message-State: AFqh2kqTzSDOATF83dMxF8tNCQRRKlvG8dDP3kOtS65c4xHAb6J0zcFs
        BhmodXqWSAUDx2Vi//d/pKXQIbzB2teIikTbD0w=
X-Google-Smtp-Source: AMrXdXvZ1Cs6iHIDJtn6veKewhj2dgPPT+V2DlUbY0AGE3wQRKH0ZIzC3X9t+hpnJo5KKZuqXUlf8Mz3jy27ZHZatRk=
X-Received: by 2002:a05:6102:330c:b0:3d3:e956:1303 with SMTP id
 v12-20020a056102330c00b003d3e9561303mr445850vsc.71.1673971813464; Tue, 17 Jan
 2023 08:10:13 -0800 (PST)
MIME-Version: 1.0
References: <20230116214626.28955-1-cgzones@googlemail.com> <CAFqZXNu-Wg=JAsAFHFW9J3DBV-7BYL2960SJnEpaP3VzOJn+Bg@mail.gmail.com>
In-Reply-To: <CAFqZXNu-Wg=JAsAFHFW9J3DBV-7BYL2960SJnEpaP3VzOJn+Bg@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Tue, 17 Jan 2023 17:10:02 +0100
Message-ID: <CAJ2a_Dfrs9H5hkzK+_uGzLyL27rMBkTeJYAXoddRPO2mRsB2ow@mail.gmail.com>
Subject: Re: [TESTSUITE PATCH] policy: drop usage of files_list_pids()
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, 17 Jan 2023 at 11:00, Ondrej Mosnacek <omosnace@redhat.com> wrote:
>
> On Mon, Jan 16, 2023 at 10:48 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> > files_list_pids() has been superseded and marked deprecated in the
> > Reference Policy since Jun 2020[1].  In the latest release it has been
> > completely removed[2].
> >
> > Grant the necessary permissions via raw rules to support recent
> > Refpolicy versions as well as old ones without the replacement
> > interface files_list_runtime().
>
> It seems the permissions aren't actually needed, at least on current
> Fedoras. Simply removing the call passes the CI:
> https://github.com/WOnder93/selinux-testsuite/commit/d0883a56d2583800a1fa=
79490097e73b842cec17

On Fedora the call of `auth_read_passwd(testsuite_domain)`[1] leads to
a call of `sssd_stream_connect()`[2], which includes
`files_search_pids()`[3].

There is no indirect call in the Debian version of Refpolicy though:

    type=3DPROCTITLE msg=3Daudit(17/01/23 16:41:13.404:577) :
proctitle=3Dkeys/keyctl_relabel system_u:object_r:test_newcon_key_t:s0
    type=3DPATH msg=3Daudit(17/01/23 16:41:13.404:577) : item=3D0
name=3D/var/run/setrans/.setrans-unix nametype=3DUNKNOWN cap_fp=3Dnone
cap_fi=3Dnone cap_fe=3D0 cap_fver=3D0 cap_frootid=3D0
    type=3DCWD msg=3Daudit(17/01/23 16:41:13.404:577) :
cwd=3D/root/workspace/selinux/selinux-testsuite/tests
    type=3DSYSCALL msg=3Daudit(17/01/23 16:41:13.404:577) : arch=3Dx86_64
syscall=3Daccess success=3Dno exit=3DEACCES(Permission denied)
a0=3D0x7ea1b2255068 a1=3DF_OK a2=3D0x7ffd39131fb0 a3=3D0xa9ab59f33f82d0d9
items=3D1 ppid=3D4569 pid=3D4593 auid=3Droot uid=3Droot gid=3Droot euid=3Dr=
oot
suid=3Droot fsuid=3Dro
ot egid=3Droot sgid=3Droot fsgid=3Droot tty=3Dpts1 ses=3D1 comm=3Dkeyctl_re=
label
exe=3D/root/workspace/selinux/selinux-testsuite/tests/keys/keyctl_relabel
subj=3Dunconfined_u:unconfined_r:test_key_t:s0-s0:c0.c1023 key=3D(null)
    type=3DAVC msg=3Daudit(17/01/23 16:41:13.404:577) : avc:  denied  {
read } for  pid=3D4593 comm=3Dkeyctl_relabel name=3Drun dev=3D"vda1"
ino=3D390346 scontext=3Dunconfined_u:unconfined_r:test_key_t:s0-s0:c0.c1023
tcontext=3Dsystem_u:object_r:var_run_t:s0 tclass=3Dlnk_file permissive=3D0

The tessuite passes nevertheless, so one could ignore or explicitly
dontaudit them.

An alternative would be to call the interfaces conditionally:

    ifdef(`files_list_pids', `
        files_list_pids(testsuite_domain)
    ')
    ifdef(`files_list_runtime', `
        files_list_runtime(testsuite_domain)
    ')

[1]: https://github.com/SELinuxProject/selinux-testsuite/blob/bbab270f66c3f=
c33b4fdc7cec8beb0003afbb4ee/policy/test_global.te#L159
[2]: https://github.com/fedora-selinux/selinux-policy/blob/33883ed0612f156e=
12dc9a0268848908052e3085/policy/modules/system/authlogin.if#L2271
[3]: https://github.com/fedora-selinux/selinux-policy/blob/25bdcfdf5821ddba=
2c47fc4306bc43debc4c0f75/policy/modules/contrib/sssd.if#L407

>
> Do you have an environment with refpolicy where you can test it? It
> would be better to just remove the interface call if it's not needed.
>
> >
> > [1]: https://github.com/SELinuxProject/refpolicy/commit/be04bb3e7e63671=
ed8a3c501a2ee76e11c3b92bb
> > [2]: https://github.com/SELinuxProject/refpolicy/commit/3ca0cd59d7a9b53=
1dd3620a02940396343fe2ed5
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > ---
> >  policy/test_global.te | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/policy/test_global.te b/policy/test_global.te
> > index e95102a..4bf30f8 100644
> > --- a/policy/test_global.te
> > +++ b/policy/test_global.te
> > @@ -121,7 +121,6 @@ allow testsuite_domain proc_t:file { getattr read o=
pen };
> >  files_list_var(testsuite_domain)

The explicit rules targeting var_t can be dropped, cause I overlooked
the `files_list_var(testsuite_domain)` call.

> >  files_list_home(testsuite_domain)
> >  dev_read_rand(testsuite_domain)
> > -files_list_pids(testsuite_domain)
> >  require {
> >         type root_t;
> >         type etc_t;
> > @@ -136,8 +135,12 @@ require {
> >         type init_t;
> >         type initrc_t;
> >         type console_device_t;
> > +       type var_t;
> > +       type var_run_t;
> >  }
> > -allow testsuite_domain { root_t etc_t bin_t sbin_t lib_t usr_t devpts_=
t }:dir list_dir_perms;
> > +allow testsuite_domain { root_t etc_t bin_t sbin_t lib_t usr_t devpts_=
t var_run_t }:dir list_dir_perms;
> > +allow testsuite_domain var_t:dir search_dir_perms;
> > +allow testsuite_domain { var_t var_run_t }:lnk_file read_lnk_file_perm=
s;
> >  allow testsuite_domain lib_t:file read_file_perms;
> >  allow testsuite_domain lib_t:lnk_file read;
> >  allow testsuite_domain etc_t:file read_file_perms;
> > --
> > 2.39.0
> >
>
> --
> Ondrej Mosnacek
> Senior Software Engineer, Linux Security - SELinux kernel
> Red Hat, Inc.
>
