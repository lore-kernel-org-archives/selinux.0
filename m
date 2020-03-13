Return-Path: <SRS0=2KQY=46=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF85C10DCE
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 18:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6410F206CD
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 18:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYtTJq/S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCMSVj (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:21:39 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:35463 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgCMSVj (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Mar 2020 14:21:39 -0400
Received: by mail-oi1-f193.google.com with SMTP id k8so8964520oik.2
        for <selinux@vger.kernel.org>; Fri, 13 Mar 2020 11:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BwQimAqMfs8mI8byl7C9M+J/Lahjy/FS+bqU4XUA/2Y=;
        b=CYtTJq/S4q72wRZHurfw8EbCJmSUHsW0HZP+vxPO4BpJvN5lqZVaWx/2LCZ71hCVuF
         2bdx9Vyl3z1zc0faAtiessRX536d6fjepMuIv4uvLnfxXrCOZehDUy0BKAUb1xYQ4Kzc
         ggscdcIlOZS5EUu5LD5bA8nHoHSG2g3J+Cg5INaYEP/vKSZQy9xCaJYX4Nl6v1Z73muu
         +GNMisFbtALU2C9cP0GWG8c4ULozw20SYOx4ssUL0SHoprZI1k5vchFHHzGb2mjBhVmW
         OykMG1rdyanC7sX9EO3S/T9v7FL7eQkKrhQkEgO31/5/NRXS4QX+Ep7XHukIcnlDsbSo
         822w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BwQimAqMfs8mI8byl7C9M+J/Lahjy/FS+bqU4XUA/2Y=;
        b=To7/2H00M/PtAIRd2MtX2oSUKIn3kUZc6YSIYzM4LmQyJWKE0aHBARVPHCV4Ek0ANp
         z2fbWheVOow+en8UXQyx8wLIRSQPEqoD+5aL3kF6xEKCyA99LGPimK8Is0YJ/LZk+Yqg
         OGuWH0O0sYqFElkJWPFnJpx9rjCKKjIKJkfz/bev2AfXHdweETtVykrGJhs9DvmrIJj9
         FzfKI4UJC+TcmiDHEa9niz3Z7OZLrdnO9fwA/3Z9V1YU9ao8hLuLVafvv3Dd+rdvvEOM
         GeSqwRODOHhV/pPGwKOaQkUiMulVG0jCsrF4BrfJEGKY3dR2c50KFNhRFxrSQhO4unlz
         gSzQ==
X-Gm-Message-State: ANhLgQ3VwBRB+ep9O4EZNL4Uc8jNoA+3jDI8gaqQofR9CFsAJ2isgQQk
        SNsm1jFtbk3ocI5MmO9Ql90FY0Z9eWIBh8MIUX4=
X-Google-Smtp-Source: ADFU+vvJBX0/nepjsCsqn4XxOnJAF/1hROBl3uvWYfPa8rIjmYo14wLO+Yf/j82e9c3Hrq9VRimZhgVQ+v883Z/0iG0=
X-Received: by 2002:aca:a857:: with SMTP id r84mr8258317oie.65.1584123698066;
 Fri, 13 Mar 2020 11:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200312113637.20355-1-richard_c_haines@btinternet.com>
 <CAEjxPJ7Ds4J=7hO9K-B1pLXUfCgx4vFbMth-3nQW9x_4xV7S0Q@mail.gmail.com>
 <CAEjxPJ7kjzaj4bz9=_oTJrLAYmDKfMZsC_eAGDj_N7Kbxm=omg@mail.gmail.com>
 <CAEjxPJ4D7odh+f4mx==Z1YPV0=XtdLY2B9wTvfO-p4d7FZyzug@mail.gmail.com> <280fe687e65a9e316d4637281f31c9cf7adfdf5f.camel@btinternet.com>
In-Reply-To: <280fe687e65a9e316d4637281f31c9cf7adfdf5f.camel@btinternet.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 13 Mar 2020 14:22:31 -0400
Message-ID: <CAEjxPJ4NE+V67GTyiAaBb3ZX_mc5kiCOnL9pDotLb2m9z-nLWg@mail.gmail.com>
Subject: Re: [PATCH 0/2] selinux-testsuite: Use native filesystem for tests
To:     Richard Haines <richard_c_haines@btinternet.com>
Cc:     SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Scott Mayhew <smayhew@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Mar 13, 2020 at 2:18 PM Richard Haines
<richard_c_haines@btinternet.com> wrote:
>
> On Fri, 2020-03-13 at 13:21 -0400, Stephen Smalley wrote:
> > On Fri, Mar 13, 2020 at 12:04 PM Stephen Smalley
> > <stephen.smalley.work@gmail.com> wrote:
> > > On Fri, Mar 13, 2020 at 11:47 AM Stephen Smalley
> > > <stephen.smalley.work@gmail.com> wrote:
> > > > On Thu, Mar 12, 2020 at 7:37 AM Richard Haines
> > > > <richard_c_haines@btinternet.com> wrote:
> > > > > If you test on the selinux-next kernel (that has the XFS patch
> > > > > [1]) with
> > > > > the "NFS: Ensure security label is set for root inode" patch
> > > > > [2], then all
> > > > > tests should pass. Anything else will give varying amounts of
> > > > > fails.
> > > > >
> > > > > The filesystem types tested are: ext4, xfs, vfat and nfs4.
> > > > >
> > > > > I've revamped the nfs.sh to handle tests that require specific
> > > > > mount
> > > > > options, these plus many more are now in tests/nfs_filesystem.
> > > > > This only
> > > > > gets run by nfs.sh.
> > > > >
> > > > > There are two minor workarounds involving multiple mounts
> > > > > returning EBUSY.
> > > > > These are either bugs or features.
> > > > >
> > > > > [1]
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/patch/security/selinux?id=e4cfa05e9bfe286457082477b32ecd17737bdbce
> > > > > [2]
> > > > > https://lore.kernel.org/selinux/20200303225837.1557210-1-smayhew@redhat.com/
> > > >
> > > > Still failing for me:
> > > > filesystem/test ............. 13/27 Failed mount(2): Permission
> > > > denied
> > > > filesystem/test ............. 18/27
> > >
> > > Sorry, that's on me.  Wrong kernel.  Will retry...
> >
> > Same failures with the right kernel.  If I am reading it correctly,
> > the first failure is on this test:
> >
> > print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
> > print "Using mount options:\n\t$mount_opts\n";
> > $result = system(
> > "runcon -t test_filesystem_no_getattr_t $basedir/mount -s $dev -t
> > $basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v"
> > );
> > ok( $result eq 0 );
> >
> > Looks like the denial was:
> > type=SYSCALL msg=audit(03/13/2020 13:11:37.805:1605) : arch=x86_64
> > syscall=mount success=no exit=EACCES(Permission denied)
> > a0=0x7ffc28975328 a1=0x7ffc2897536b a2=0x7ffc28975386 a3=0x0 items=14
> > ppid=15745 pid=15886 auid=sds uid=root gid=root euid=root suid=root
> > fsuid=root egid=root sgid=root fsgid=root tty=pts0 ses=1 comm=mount
> > exe=/mnt/selinux-testsuite/tests/filesystem/mount
> > subj=unconfined_u:unconfined_r:test_filesystem_no_getattr_t:s0-
> > s0:c0.c1023
> > key=(null)
> > type=AVC msg=audit(03/13/2020 13:11:37.805:1605) : avc:  denied  {
> > search } for  pid=15886 comm=mount name=sds dev="0:49" ino=17039361
> > scontext=unconfined_u:unconfined_r:test_filesystem_no_getattr_t:s0-
> > s0:c0.c1023
> > tcontext=unconfined_u:object_r:user_home_dir_t:s0 tclass=dir
> > permissive=0
>
> So far I have not managed to see this problem before or after a
> restorecon. I'll investigate further and see what I can find !!!

I was wondering if it has to do with where the testsuite directory is located.
In my case, under my $HOME. Most of the test domains don't need access to
the parent directories of the test subdir because they only use
relative pathnames
but a few do require this.
