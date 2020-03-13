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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4460DC10DCE
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 17:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1987B206B1
	for <selinux@archiver.kernel.org>; Fri, 13 Mar 2020 17:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WN7OvkKE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbgCMRUz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:20:55 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36953 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCMRUz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 13 Mar 2020 13:20:55 -0400
Received: by mail-ot1-f68.google.com with SMTP id i12so5622826otp.4
        for <selinux@vger.kernel.org>; Fri, 13 Mar 2020 10:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+saEQOa6LWWUDKhzBcZtTMjv30KrweXZ+srYgeDmCd8=;
        b=WN7OvkKEcn/X5xjwTOoy70FOGqVUjxHuF1FhAAUYoPouSP4ZYbes5khPxAlx1oC+O2
         ZUaSt/oTllezXEXTUXXeFvhcpiyzazY2DBvfMXnHGjg3fhdU7gYuaHtMBaBSWfmPHsYo
         WKRswSaOOJEoxJPfU5zCAuPb/7G6GIBnkILQw7ZUtvE0UmUVRAXdUPDPLghRnSayE2ST
         by37xjcs7/LtzzPv2l7cBcE7ZlAq+RJOpfMF5DMuK9qm3Sw+r++IzNxg1lsEc+MA8NvG
         WFT4jSzA6RXWKDjRZksCnaTpoILuSmufLtmDNT7ojqOmyzHkGPljDbLcX7AC1rWci+4B
         CHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+saEQOa6LWWUDKhzBcZtTMjv30KrweXZ+srYgeDmCd8=;
        b=lBkVzYvisnAYSmafy8cJMYZ6Skf7gNrd+W9XAMMV1YvBWHSY+SLiGwDCLyuMaX4J6x
         V153rmIXdCHlIAxkIsYyzIbi8x9m5OY9GZSecrivkL0XkNl8ApdMYdbu4kWl1r2I9Cyz
         7lMolQUNR63yZoEPWeNNI0a1t5YaEjb+0e+MxHrzZwcx1Ga/cSj2ERC9BE1MSNKMeU5o
         ww4vE9Q8JMBZJX7Yl1K0Y8gjWCZ+Tojv5ybR7q9y/0TIsHuMqzI1522q2f89MrjQSZ33
         hga0HuBMKZQjmE9wmcSf1RtOZIfJeY2GGRyni6gsQJhVF4cbGMCQr2iulIDqdVkQfhI7
         qYJg==
X-Gm-Message-State: ANhLgQ283iBABCWU/iZtscKjZezSJ4d2sCxFfn/hNqBDTkvY1+cRdnLQ
        yuaBo0nWk767wdJ8AWfpZYtRzp1HvWSKjzoRmGw=
X-Google-Smtp-Source: ADFU+vurKdB3hHuVXoGkc2Ve05wBDV1INqZ+H80yveQhFS320Ixn1ca+H2V/0Ka/sdJFjM+MY+6MmyJ8LlVoVnYZRes=
X-Received: by 2002:a9d:76c9:: with SMTP id p9mr12053987otl.135.1584120053879;
 Fri, 13 Mar 2020 10:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200312113637.20355-1-richard_c_haines@btinternet.com>
 <CAEjxPJ7Ds4J=7hO9K-B1pLXUfCgx4vFbMth-3nQW9x_4xV7S0Q@mail.gmail.com> <CAEjxPJ7kjzaj4bz9=_oTJrLAYmDKfMZsC_eAGDj_N7Kbxm=omg@mail.gmail.com>
In-Reply-To: <CAEjxPJ7kjzaj4bz9=_oTJrLAYmDKfMZsC_eAGDj_N7Kbxm=omg@mail.gmail.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Date:   Fri, 13 Mar 2020 13:21:47 -0400
Message-ID: <CAEjxPJ4D7odh+f4mx==Z1YPV0=XtdLY2B9wTvfO-p4d7FZyzug@mail.gmail.com>
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

On Fri, Mar 13, 2020 at 12:04 PM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Fri, Mar 13, 2020 at 11:47 AM Stephen Smalley
> <stephen.smalley.work@gmail.com> wrote:
> >
> > On Thu, Mar 12, 2020 at 7:37 AM Richard Haines
> > <richard_c_haines@btinternet.com> wrote:
> > >
> > > If you test on the selinux-next kernel (that has the XFS patch [1]) with
> > > the "NFS: Ensure security label is set for root inode" patch [2], then all
> > > tests should pass. Anything else will give varying amounts of fails.
> > >
> > > The filesystem types tested are: ext4, xfs, vfat and nfs4.
> > >
> > > I've revamped the nfs.sh to handle tests that require specific mount
> > > options, these plus many more are now in tests/nfs_filesystem. This only
> > > gets run by nfs.sh.
> > >
> > > There are two minor workarounds involving multiple mounts returning EBUSY.
> > > These are either bugs or features.
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/patch/security/selinux?id=e4cfa05e9bfe286457082477b32ecd17737bdbce
> > > [2] https://lore.kernel.org/selinux/20200303225837.1557210-1-smayhew@redhat.com/
> >
> > Still failing for me:
> > filesystem/test ............. 13/27 Failed mount(2): Permission denied
> > filesystem/test ............. 18/27
>
> Sorry, that's on me.  Wrong kernel.  Will retry...

Same failures with the right kernel.  If I am reading it correctly,
the first failure is on this test:

print "Mount $fs_type filesystem on $basedir/mntpoint/mp1\n";
print "Using mount options:\n\t$mount_opts\n";
$result = system(
"runcon -t test_filesystem_no_getattr_t $basedir/mount -s $dev -t
$basedir/mntpoint/mp1 -f $fs_type -o $mount_opts $v"
);
ok( $result eq 0 );

Looks like the denial was:
type=SYSCALL msg=audit(03/13/2020 13:11:37.805:1605) : arch=x86_64
syscall=mount success=no exit=EACCES(Permission denied)
a0=0x7ffc28975328 a1=0x7ffc2897536b a2=0x7ffc28975386 a3=0x0 items=14
ppid=15745 pid=15886 auid=sds uid=root gid=root euid=root suid=root
fsuid=root egid=root sgid=root fsgid=root tty=pts0 ses=1 comm=mount
exe=/mnt/selinux-testsuite/tests/filesystem/mount
subj=unconfined_u:unconfined_r:test_filesystem_no_getattr_t:s0-s0:c0.c1023
key=(null)
type=AVC msg=audit(03/13/2020 13:11:37.805:1605) : avc:  denied  {
search } for  pid=15886 comm=mount name=sds dev="0:49" ino=17039361
scontext=unconfined_u:unconfined_r:test_filesystem_no_getattr_t:s0-s0:c0.c1023
tcontext=unconfined_u:object_r:user_home_dir_t:s0 tclass=dir
permissive=0
