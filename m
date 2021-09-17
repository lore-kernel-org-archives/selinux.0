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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727F5C433EF
	for <selinux@archiver.kernel.org>; Fri, 17 Sep 2021 13:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5105360FED
	for <selinux@archiver.kernel.org>; Fri, 17 Sep 2021 13:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235713AbhIQN2u (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 17 Sep 2021 09:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234689AbhIQN2u (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 17 Sep 2021 09:28:50 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEABCC061574
        for <selinux@vger.kernel.org>; Fri, 17 Sep 2021 06:27:27 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id g1so33107738lfj.12
        for <selinux@vger.kernel.org>; Fri, 17 Sep 2021 06:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OCGHYpLfCwenkJJx0ksBjpkZB5Yl44f9kb07nAPSrb8=;
        b=i1NzcVdtKYuLdsg8fd7k6/nj6o1TeO62uNcbYpxq47mnxr+9mWc904E2LJN0meno/h
         oHJQp69prqbZ5IejNNMjFJWGIGRf5slTvaRxvwtZg2ds7FbBk+PfhU4isO04cc6JudU/
         3IMBFDvOFjx4Zp/Ye6dKAsVmgA90/ezD3PfPSUte3gWOdKM0DAY3Rw/+xKdHgVDnaFQA
         M/UbL3EhklhNHahtbeGrJ6+dhSCNGCgM5BHziDWjx/+NfV+6Hbnmm7sGUpfpT1pWIaJR
         q6jQM0CQok2abK6UqP2TMOrEGK3SRpdXNBA7rIPKd/w/eoivx44pGCftnykVMrisWaCK
         bIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OCGHYpLfCwenkJJx0ksBjpkZB5Yl44f9kb07nAPSrb8=;
        b=XnQ+S2ftFeVE7i5H+MZQdGTs9UEl7uPAv+Pi9QFdpE97o+ND5dT4hXawr6+IjM3PRb
         xnZGDYsZhJbjtKg7AIPEKZsGVYKxtticaTuSK0T5Mq4OBROLozpNn59olcDPlg/BXKoH
         yu4UeJqv8i+sLwmhdbSaoU7GOGdFMs1Pt1/Jig+PlnfTA1XiL/qvs+8091IxCX9tf+Wf
         1Ihic0fgqK9cpFpxaXHermeiz74Rgsjf7TxXt33UxsMmIsQA5IIeMSHz1Xq3kSS6LmCU
         FV7Qmt9BBD3T5N5zBpXi5YhDWhWeTXGXkMiWSF7Z+EBCJ0WQjdAx4ZTwxS1s5u95Tq05
         SBJA==
X-Gm-Message-State: AOAM530MdCZw9yG/S6iIUrOuKx4LvGZxww5Md8un7OdjJA3/J6BA0fy9
        7TJS0Nwf9mPosaaY0I3md2sF8U0JT7KYgqFywLQqHuNw
X-Google-Smtp-Source: ABdhPJz9N+HCiWU+kOH2j295GJ5VaBPFN1ZnX7tEHwKaFqNr2Sca+RewjHr+SR21hz/0q7vSgGM9ilC1EjCVScCpUkI=
X-Received: by 2002:a05:6512:2396:: with SMTP id c22mr7478440lfv.55.1631885243006;
 Fri, 17 Sep 2021 06:27:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210915162326.392808-1-cgzones@googlemail.com>
 <CAHC9VhTcyz5i7jRiz1iAg7U_Ru1cJi6APv0GyMw408d+2aJmqw@mail.gmail.com>
 <CAJ2a_DeuF2tqQ08piCUnJZwxOkWXfu7rBOrfoRP5f4ughYxBdQ@mail.gmail.com>
 <CAHC9VhTq8dOvHzZ48guwCmR9SBSc3rd5hivb6X2aVN+QCukWew@mail.gmail.com> <CAJ2a_Df8QViZTquT0G1y=iMkLqb+W9LD2_af=-qT9Pw1T053hg@mail.gmail.com>
In-Reply-To: <CAJ2a_Df8QViZTquT0G1y=iMkLqb+W9LD2_af=-qT9Pw1T053hg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 17 Sep 2021 09:27:11 -0400
Message-ID: <CAEjxPJ4uZo0bLShWETJZ-UfwCCTp8Wk_hiL1c8AZcOyudz+Xbw@mail.gmail.com>
Subject: Re: [PATCH] selinux: enable genfscon labeling for securityfs
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 17, 2021 at 9:07 AM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Fri, 17 Sept 2021 at 04:07, Paul Moore <paul@paul-moore.com> wrote:
> >
> > On Thu, Sep 16, 2021 at 1:41 PM Christian G=C3=B6ttsche
> > <cgzones@googlemail.com> wrote:
> > > On Wed, 15 Sept 2021 at 20:28, Paul Moore <paul@paul-moore.com> wrote=
:
> > > >
> > > > On Wed, Sep 15, 2021 at 12:24 PM Christian G=C3=B6ttsche
> > > > <cgzones@googlemail.com> wrote:
> > > > >
> > > > > Add support for genfscon per-file labeling of securityfs files. T=
his allows
> > > > > for separate labels and therby permissions for different files, e=
.g.
> > > > > /sys/kernel/security/integrity/ima/policy.
> > > > >
> > > > > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> > > > > ---
> > > > >  security/selinux/hooks.c | 3 ++-
> > > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > Hi Christian,
> > > >
> > > > It would be nice if you could add some additional notes on how this
> > > > was tested to the description above.
> > > >
> > > > > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > > > > index 6517f221d52c..a18626424731 100644
> > > > > --- a/security/selinux/hooks.c
> > > > > +++ b/security/selinux/hooks.c
> > > > > @@ -760,7 +760,8 @@ static int selinux_set_mnt_opts(struct super_=
block *sb,
> > > > >             !strcmp(sb->s_type->name, "tracefs") ||
> > > > >             !strcmp(sb->s_type->name, "binder") ||
> > > > >             !strcmp(sb->s_type->name, "bpf") ||
> > > > > -           !strcmp(sb->s_type->name, "pstore"))
> > > > > +           !strcmp(sb->s_type->name, "pstore") ||
> > > > > +           !strcmp(sb->s_type->name, "securityfs"))
> > > > >                 sbsec->flags |=3D SE_SBGENFS;
> > > > >
> > > > >         if (!strcmp(sb->s_type->name, "sysfs") ||
> > > > > --
> > > > > 2.33.0
> > > >
> > > > --
> > > > paul moore
> > > > www.paul-moore.com
> > >
> > > Something like:
> > >
> > >     Add support for genfscon per-file labeling of securityfs files. T=
his allows
> > >     for separate labels and thereby access control for different file=
s.
> > >     For example a genfscon statement
> > >         genfscon securityfs /integrity/ima/policy
> > > system_u:object_r:ima_policy_t:s0
> > >     will set a specific label to the IMA policy file and thus allow t=
o
> > > control the ability
> > >     to set the IMA policy.
> > >     Setting labels directly, e.g. via chcon(1) or setfiles(8), is
> > > still not supported.
> > >
> > > ?
> >
> > That's a much better description of the functionality, especially for
> > those who may not be very familiar with SELinux, thank you.  However I
> > was hoping to also hear some confirmation that you have tested this
> > and it worked without problem?
> >
> > --
> > paul moore
> > www.paul-moore.com
>
> With the following genfscon statements
>
>     genfscon securityfs /  system_u:object_r:securityfs_t:s0
>     genfscon securityfs /integrity/ima  system_u:object_r:ima_t:s0
>     genfscon securityfs /integrity/ima/policy  system_u:object_r:ima_poli=
cy_t:s0
>     genfscon securityfs /lockdown  system_u:object_r:lockdown_t:s0
>
> the labels are
>
>     $ ls -laZ /sys/kernel/security/ /sys/kernel/security/integrity/ima/
>     /sys/kernel/security/:
>     total 0
>     drwxr-xr-x.  3 root root system_u:object_r:securityfs_t:s0 0 Sep 17 0=
9:38 .
>     drwxr-xr-x. 15 root root system_u:object_r:sysfs_t:s0      0 Sep 17 0=
9:38 ..
>     lr--r--r--.  1 root root system_u:object_r:securityfs_t:s0 0 Sep
> 17 09:38 evm -> integrity/evm/evm
>     lr--r--r--.  1 root root system_u:object_r:securityfs_t:s0 0 Sep
> 17 09:38 ima -> integrity/ima
>     drwxr-xr-x.  4 root root system_u:object_r:securityfs_t:s0 0 Sep
> 17 09:38 integrity
>     -rw-r--r--.  1 root root system_u:object_r:lockdown_t:s0   0 Sep
> 17 09:38 lockdown
>     -r--r--r--.  1 root root system_u:object_r:securityfs_t:s0 0 Sep
> 17 09:38 lsm
>
>     /sys/kernel/security/integrity/ima/:
>     total 0
>     drwxr-xr-x. 2 root root system_u:object_r:ima_t:s0        0 Sep 17 09=
:38 .
>     rwxr-xr-x. 4 root root system_u:object_r:securityfs_t:s0 0 Sep 17 09:=
38 ..
>     -r--r-----. 1 root root system_u:object_r:ima_t:s0        0 Sep 17
> 09:38 ascii_runtime_measurements
>     -r--r-----. 1 root root system_u:object_r:ima_t:s0        0 Sep 17
> 09:38 binary_runtime_measurements
>     --w-------. 1 root root system_u:object_r:ima_policy_t:s0 0 Sep 17
> 09:38 policy
>     -r--r-----. 1 root root system_u:object_r:ima_t:s0        0 Sep 17
> 09:38 runtime_measurements_count
>     -r--r-----. 1 root root system_u:object_r:ima_t:s0        0 Sep 17
> 09:38 violations
>
> and audit logs are generated like
>
>     Sep 17 09:38:28 debianBullseye audit[331]: AVC avc:  denied  {
> read } for  pid=3D331 comm=3D"systemd-tmpfile" name=3D"ima" dev=3D"securi=
tyfs"
> ino=3D167 scontext=3Dsystem_u:system_r:systemd_tmpfiles_t:s0
> tcontext=3Dsystem_u:object_r:ima_t:s0 tclass=3Ddir permissive=3D1
>     Sep 17 09:38:28 debianBullseye audit[331]: AVC avc:  denied  {
> open } for  pid=3D331 comm=3D"systemd-tmpfile"
> path=3D"/sys/kernel/security/integrity/ima" dev=3D"securityfs" ino=3D167
> scontext=3Dsystem_u:system_r:systemd_tmpfiles_t:s0
> tcontext=3Dsystem_u:object_r:ima_t:s0 tclass=3Ddir permissive=3D1
>     Sep 17 09:38:28 debianBullseye audit[331]: AVC avc:  denied  {
> getattr } for  pid=3D331 comm=3D"systemd-tmpfile"
> path=3D"/sys/kernel/security/integrity/ima/policy" dev=3D"securityfs"
> ino=3D173 scontext=3Dsystem_u:system_r:systemd_tmpfiles_t:s0
> tcontext=3Dsystem_u:object_r:ima_policy_t:s0 tclass=3Dfile permissive=3D1
>
>
> chcon(1) fails like
>
>     $ chcon -v -t securityfs_t /sys/kernel/security/integrity/ima/policy
>     changing security context of '/sys/kernel/security/integrity/ima/poli=
cy'
>     chcon: failed to change context of
> '/sys/kernel/security/integrity/ima/policy' to
> 'system_u:object_r:securityfs_t:s0': Operation not supported
>
> A file context definition of
>
>     /sys/kernel/security/integrity/ima/policy --
> gen_context(system_u:object_r:securityfs_t,s0)
>
> results in
>
>     $ matchpathcon -V /sys/kernel/security/integrity/ima/policy
>     Deprecated, use selabel_lookup
>     /sys/kernel/security/integrity/ima/policy has context
> system_u:object_r:ima_policy_t:s0, should be
> system_u:object_r:securityfs_t:s0
>     $ restorecon -vRF /sys/kernel/security/
>     # nothing #
>
> Are there any other use cases or edge cases I need to test.
>
> One thing I noticed is that a genfscon statements take affect only
> after a reboot, not after remounting the securityfs via
>
>     mount -v -o remount -t securityfs /sys/kernel/security
>
> Is this expected?

genfscon is only consulted when a dentry is first instantiated for an
inode, typically on first lookup or creation.
So you'd have to unmount all securityfs mounts to force eviction of
the existing dentries/inodes and get them re-created.
And likely can't be done if the kernel does an internal mount for its
own usage (but doesn't look like that is the case for
securityfs, just selinuxfs).
