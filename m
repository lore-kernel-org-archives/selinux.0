Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67150C433EF
	for <selinux@archiver.kernel.org>; Fri, 17 Sep 2021 08:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5235560F6B
	for <selinux@archiver.kernel.org>; Fri, 17 Sep 2021 08:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240123AbhIQIBr (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Sep 2021 04:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbhIQIBq (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Sep 2021 04:01:46 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B89C061574
        for <selinux@vger.kernel.org>; Fri, 17 Sep 2021 01:00:25 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id n2-20020a9d6f02000000b0054455dae485so6568775otq.3
        for <selinux@vger.kernel.org>; Fri, 17 Sep 2021 01:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aFDdvjHEA9wMlxu1K4kbKzdpU3vmLZX7qcNtoGVYbks=;
        b=iJyD1ctFITOdLPXv/Sk9UNRsNrdm8Dkz5wzmP6eVMOWKGIaypKBIg08822Xsko5oFz
         ugm8XGdxz8+5dCPlOJLkjgb2ir1HGQbi0cZm4mexOLv4mDbvfAdF6hT03JimvdomJU4Q
         FKT+qGXW98AoOwUpl8ZYfsHdGtwEPMQvo3g3QA80p0J3NyYomuOmFpVU7gQ17n1YQbau
         nOd8i+6WI1TAhI1KAhDt/eS1QjNIlTLJK81FMPClU/w+bnik7IGXeyZeIQXufVeQTw8L
         xgEXQxWVYq2jreWqX6JOjbIp1X+5AwvIuGepa7bQ5zI8UZtUD2Ih9gWd33sG+s0BqqPy
         NVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aFDdvjHEA9wMlxu1K4kbKzdpU3vmLZX7qcNtoGVYbks=;
        b=j/c+nNPeQx6OfdebxNdlrkxHVphBrrzCe2k1pAZboimQCeNKPziPrYs16ZRvOrpeQL
         O2ordbKKZ4XtgA/zdltdztAw42szNypSc/wV/TX0haZ1Od0wRroZ8gf5SPc3NrvYgSmg
         IZZNgT/n80xJVIjYstZsCm+ONwbC+1J8no1cWKXqnXaIrvcNbOxGZd0rymCledBNgyZu
         m2spwcrCt+i3jH4P7kXz3GLfQlV4WSQ9WM5+Sj4XbB6nVwuOG1pOgKGz6/f/xUQJkvaA
         BpzxNZ2dJJ1r3cLfdvqiyAD64d7Ve7bUCbbjRXYje0KFT29Besg8EsAK6tKPYL48/JM/
         0GOg==
X-Gm-Message-State: AOAM533NB17xv/oBo+P0f/21hdDNJRazl0V/PglVpcz2kJuXY6+Hv9SU
        xV5RJ8Q8W0B6cgZ8hKof76NlasFW3mrk7bvoEuXRuX3+ngr6vw==
X-Google-Smtp-Source: ABdhPJwnconY+S1CvV3QSB9fIbNUebuy3nF3thaq7ZjnFju9aKao3mvsCKLlTshTKpRDdF5wvw1g+bHu2MXuc42p8mI=
X-Received: by 2002:a05:6830:2f4:: with SMTP id r20mr8108844ote.117.1631865624199;
 Fri, 17 Sep 2021 01:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210915162326.392808-1-cgzones@googlemail.com>
 <CAHC9VhTcyz5i7jRiz1iAg7U_Ru1cJi6APv0GyMw408d+2aJmqw@mail.gmail.com>
 <CAJ2a_DeuF2tqQ08piCUnJZwxOkWXfu7rBOrfoRP5f4ughYxBdQ@mail.gmail.com> <CAHC9VhTq8dOvHzZ48guwCmR9SBSc3rd5hivb6X2aVN+QCukWew@mail.gmail.com>
In-Reply-To: <CAHC9VhTq8dOvHzZ48guwCmR9SBSc3rd5hivb6X2aVN+QCukWew@mail.gmail.com>
From:   =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Date:   Fri, 17 Sep 2021 10:00:13 +0200
Message-ID: <CAJ2a_Df8QViZTquT0G1y=iMkLqb+W9LD2_af=-qT9Pw1T053hg@mail.gmail.com>
Subject: Re: [PATCH] selinux: enable genfscon labeling for securityfs
To:     Paul Moore <paul@paul-moore.com>
Cc:     SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, 17 Sept 2021 at 04:07, Paul Moore <paul@paul-moore.com> wrote:
>
> On Thu, Sep 16, 2021 at 1:41 PM Christian G=C3=B6ttsche
> <cgzones@googlemail.com> wrote:
> > On Wed, 15 Sept 2021 at 20:28, Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > On Wed, Sep 15, 2021 at 12:24 PM Christian G=C3=B6ttsche
> > > <cgzones@googlemail.com> wrote:
> > > >
> > > > Add support for genfscon per-file labeling of securityfs files. Thi=
s allows
> > > > for separate labels and therby permissions for different files, e.g=
.
> > > > /sys/kernel/security/integrity/ima/policy.
> > > >
> > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > > ---
> > > >  security/selinux/hooks.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > Hi Christian,
> > >
> > > It would be nice if you could add some additional notes on how this
> > > was tested to the description above.
> > >
> > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > index 6517f221d52c..a18626424731 100644
> > > > --- a/security/selinux/hooks.c
> > > > +++ b/security/selinux/hooks.c
> > > > @@ -760,7 +760,8 @@ static int selinux_set_mnt_opts(struct super_bl=
ock *sb,
> > > >             !strcmp(sb->s_type->name, "tracefs") ||
> > > >             !strcmp(sb->s_type->name, "binder") ||
> > > >             !strcmp(sb->s_type->name, "bpf") ||
> > > > -           !strcmp(sb->s_type->name, "pstore"))
> > > > +           !strcmp(sb->s_type->name, "pstore") ||
> > > > +           !strcmp(sb->s_type->name, "securityfs"))
> > > >                 sbsec->flags |=3D SE_SBGENFS;
> > > >
> > > >         if (!strcmp(sb->s_type->name, "sysfs") ||
> > > > --
> > > > 2.33.0
> > >
> > > --
> > > paul moore
> > > www.paul-moore.com
> >
> > Something like:
> >
> >     Add support for genfscon per-file labeling of securityfs files. Thi=
s allows
> >     for separate labels and thereby access control for different files.
> >     For example a genfscon statement
> >         genfscon securityfs /integrity/ima/policy
> > system_u:object_r:ima_policy_t:s0
> >     will set a specific label to the IMA policy file and thus allow to
> > control the ability
> >     to set the IMA policy.
> >     Setting labels directly, e.g. via chcon(1) or setfiles(8), is
> > still not supported.
> >
> > ?
>
> That's a much better description of the functionality, especially for
> those who may not be very familiar with SELinux, thank you.  However I
> was hoping to also hear some confirmation that you have tested this
> and it worked without problem?
>
> --
> paul moore
> www.paul-moore.com

With the following genfscon statements

    genfscon securityfs /  system_u:object_r:securityfs_t:s0
    genfscon securityfs /integrity/ima  system_u:object_r:ima_t:s0
    genfscon securityfs /integrity/ima/policy  system_u:object_r:ima_policy=
_t:s0
    genfscon securityfs /lockdown  system_u:object_r:lockdown_t:s0

the labels are

    $ ls -laZ /sys/kernel/security/ /sys/kernel/security/integrity/ima/
    /sys/kernel/security/:
    total 0
    drwxr-xr-x.  3 root root system_u:object_r:securityfs_t:s0 0 Sep 17 09:=
38 .
    drwxr-xr-x. 15 root root system_u:object_r:sysfs_t:s0      0 Sep 17 09:=
38 ..
    lr--r--r--.  1 root root system_u:object_r:securityfs_t:s0 0 Sep
17 09:38 evm -> integrity/evm/evm
    lr--r--r--.  1 root root system_u:object_r:securityfs_t:s0 0 Sep
17 09:38 ima -> integrity/ima
    drwxr-xr-x.  4 root root system_u:object_r:securityfs_t:s0 0 Sep
17 09:38 integrity
    -rw-r--r--.  1 root root system_u:object_r:lockdown_t:s0   0 Sep
17 09:38 lockdown
    -r--r--r--.  1 root root system_u:object_r:securityfs_t:s0 0 Sep
17 09:38 lsm

    /sys/kernel/security/integrity/ima/:
    total 0
    drwxr-xr-x. 2 root root system_u:object_r:ima_t:s0        0 Sep 17 09:3=
8 .
    rwxr-xr-x. 4 root root system_u:object_r:securityfs_t:s0 0 Sep 17 09:38=
 ..
    -r--r-----. 1 root root system_u:object_r:ima_t:s0        0 Sep 17
09:38 ascii_runtime_measurements
    -r--r-----. 1 root root system_u:object_r:ima_t:s0        0 Sep 17
09:38 binary_runtime_measurements
    --w-------. 1 root root system_u:object_r:ima_policy_t:s0 0 Sep 17
09:38 policy
    -r--r-----. 1 root root system_u:object_r:ima_t:s0        0 Sep 17
09:38 runtime_measurements_count
    -r--r-----. 1 root root system_u:object_r:ima_t:s0        0 Sep 17
09:38 violations

and audit logs are generated like

    Sep 17 09:38:28 debianBullseye audit[331]: AVC avc:  denied  {
read } for  pid=3D331 comm=3D"systemd-tmpfile" name=3D"ima" dev=3D"security=
fs"
ino=3D167 scontext=3Dsystem_u:system_r:systemd_tmpfiles_t:s0
tcontext=3Dsystem_u:object_r:ima_t:s0 tclass=3Ddir permissive=3D1
    Sep 17 09:38:28 debianBullseye audit[331]: AVC avc:  denied  {
open } for  pid=3D331 comm=3D"systemd-tmpfile"
path=3D"/sys/kernel/security/integrity/ima" dev=3D"securityfs" ino=3D167
scontext=3Dsystem_u:system_r:systemd_tmpfiles_t:s0
tcontext=3Dsystem_u:object_r:ima_t:s0 tclass=3Ddir permissive=3D1
    Sep 17 09:38:28 debianBullseye audit[331]: AVC avc:  denied  {
getattr } for  pid=3D331 comm=3D"systemd-tmpfile"
path=3D"/sys/kernel/security/integrity/ima/policy" dev=3D"securityfs"
ino=3D173 scontext=3Dsystem_u:system_r:systemd_tmpfiles_t:s0
tcontext=3Dsystem_u:object_r:ima_policy_t:s0 tclass=3Dfile permissive=3D1


chcon(1) fails like

    $ chcon -v -t securityfs_t /sys/kernel/security/integrity/ima/policy
    changing security context of '/sys/kernel/security/integrity/ima/policy=
'
    chcon: failed to change context of
'/sys/kernel/security/integrity/ima/policy' to
'system_u:object_r:securityfs_t:s0': Operation not supported

A file context definition of

    /sys/kernel/security/integrity/ima/policy --
gen_context(system_u:object_r:securityfs_t,s0)

results in

    $ matchpathcon -V /sys/kernel/security/integrity/ima/policy
    Deprecated, use selabel_lookup
    /sys/kernel/security/integrity/ima/policy has context
system_u:object_r:ima_policy_t:s0, should be
system_u:object_r:securityfs_t:s0
    $ restorecon -vRF /sys/kernel/security/
    # nothing #

Are there any other use cases or edge cases I need to test.

One thing I noticed is that a genfscon statements take affect only
after a reboot, not after remounting the securityfs via

    mount -v -o remount -t securityfs /sys/kernel/security

Is this expected?
