Return-Path: <selinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89436C6FD1D
	for <selinux@archiver.kernel.org>; Mon, 20 Mar 2023 14:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjCTO5S (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 20 Mar 2023 10:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjCTO4f (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 20 Mar 2023 10:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F702CFCE
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 07:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679323980;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lqapEwXOGyA2o64fD/s/T3V88BPTqTz+9DYFhKdVXPA=;
        b=WaEVsyqTxR5LvD03tNgJ7eTI+pD9IOMn8+yyj+75YCeCnMnHQSv5LRhZfPHaY9QymH0WLQ
        QvW359TUYTpPZPZYQu857wfD5zF27LHCP5te2BpVqKxUNe+Tvh3AvYXU4kBW2FWihTyKof
        QDqQxWBJH2lD4vBSJWCnSqCcKYw7DCs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-6gwJffS6N2aiQg4e5cqdUA-1; Mon, 20 Mar 2023 10:46:25 -0400
X-MC-Unique: 6gwJffS6N2aiQg4e5cqdUA-1
Received: by mail-pj1-f71.google.com with SMTP id ie21-20020a17090b401500b0023b4ba1e433so4187994pjb.0
        for <selinux@vger.kernel.org>; Mon, 20 Mar 2023 07:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679323584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqapEwXOGyA2o64fD/s/T3V88BPTqTz+9DYFhKdVXPA=;
        b=a/E4kSbWhVVsGiKn4ViSnUHXTBibU10ZmE/dDCDi1GjaALqV0Iz1LBZAIbebiK6RfO
         6RQCCkMqnKnD80fN4/1kMj+xMDSUWZL5uAQJQYrypLyVEVQWqq8I/SRTmqEIvkCSVDtI
         sNnDtw8QrxQiTBT5EFBLsSURqm0wys1BIpimAKf4tXKhcJzEnSIIsJo/wKQ3M4x//YH7
         XM/Mh+dbC/5j2ihdMhjcpKpaIM+ClBEbihHNHhbPCH+4UBgixzCC53FLOwYkHKXuwEwR
         2S+/yJk1TrgnDQMn05cvP05qGq7T7heH/RP+RJaRce0FnjSyoiaaa6/Sj6x5CnoAaYXj
         Iwww==
X-Gm-Message-State: AO0yUKXZOfwX3DeVIZuCj+4LrCj/v6tRkN0WhInSb4sj5hNLQXP93j6v
        p7Z1su2D2T8up1cgXhmuWWUXts6xBYBvYbq1GmMohAtTLOkOzuddAa82vDpGcmbvII0LBik74Pi
        UPlfDmXFoHrCaVgeV9UuefT73raS/U52dgQ==
X-Received: by 2002:a17:902:ecc6:b0:1a1:c7ea:969f with SMTP id a6-20020a170902ecc600b001a1c7ea969fmr2241699plh.2.1679323584515;
        Mon, 20 Mar 2023 07:46:24 -0700 (PDT)
X-Google-Smtp-Source: AK7set8HnslNK9kgDkRI551z1rOrxVULbLRqzSHeDwrAd5vz9DDH4PmZvTeKQzde9zlasxmdeLjXb/RKfY7N2QM0suU=
X-Received: by 2002:a17:902:ecc6:b0:1a1:c7ea:969f with SMTP id
 a6-20020a170902ecc600b001a1c7ea969fmr2241691plh.2.1679323584218; Mon, 20 Mar
 2023 07:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <87mt47ga29.fsf@defensec.nl> <CAEjxPJ51N4sguZZ6EkXDuCkaQSp1=Z8NODFbLS9B1_143ktuxA@mail.gmail.com>
 <871qljfrtz.fsf@defensec.nl> <CAFqZXNvJdb8e2b6NzC4yO7DfMc32wrRsyU160YN2Us7oZmKBeQ@mail.gmail.com>
 <87wn3bec97.fsf@defensec.nl>
In-Reply-To: <87wn3bec97.fsf@defensec.nl>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 20 Mar 2023 15:46:12 +0100
Message-ID: <CAFqZXNvULBzqMbN5ymB6fam6=CiUzikp3iWfvFj2cK++5wOwrA@mail.gmail.com>
Subject: Re: cgroup2 labeling question
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        Paul Moore <paul@paul-moore.com>, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Mar 20, 2023 at 3:19=E2=80=AFPM Dominick Grift
<dominick.grift@defensec.nl> wrote:
>
> Ondrej Mosnacek <omosnace@redhat.com> writes:
>
> > On Mon, Mar 20, 2023 at 2:59=E2=80=AFPM Dominick Grift
> > <dominick.grift@defensec.nl> wrote:
> >>
> >> Stephen Smalley <stephen.smalley.work@gmail.com> writes:
> >>
> >> > On Mon, Mar 20, 2023 at 3:25=E2=80=AFAM Dominick Grift
> >> > <dominick.grift@defensec.nl> wrote:
> >> >>
> >> >>
> >> >> Hi,
> >> >>
> >> >> I was reading this pull request [1] and looked into how I might be =
able
> >> >> to implement this in policy but there seem to be some technical
> >> >> difficulties.
> >> >>
> >> >> * I already use getfscon to seperate the systemd user.slice because=
 the
> >> >>   system manager delegates the user.slice to the user manager.
> >> >>
> >> >>   (genfscon "cgroup2" "/user.slice" cgroupfile_context)
> >> >>
> >> >>   In the past the proved to be a racy where systemd attempts to
> >> >>   write before the object has the context associated with the genfs=
con.
> >> >
> >> > I don't understand how this could be racy - genfscon-assigned contex=
ts
> >> > should be assigned when the dentry is first instantiated via
> >> > inode_donit_with_dentry and therefore the inode shouldn't be
> >> > accessible to userspace prior to this initial assignment AFAIK.
> >> > Possibly I am missing something.
> >>
> >> I recall encountering this sporadically, but I admit that it has been =
a
> >> while since I supressed it in policy. I might try to reproduce. AFAIK =
my
> >> policy is the only policy that actually labels some trees on cgroup2 f=
s
> >> with private types currently.
> >>
> >> >
> >> >>   I decided to dontaudit attempts to write to the mislabeled object=
 and
> >> >>   it *seems* as if systemd retries until it can write it i.e. when =
the
> >> >>   object carries the expected label and so that seems to work event=
ually
> >> >>   but it looks fragile.
> >> >>
> >> >> * The challenge with memory pressure implementation [2] is that the=
se
> >> >>   "memory.pressure" files end up in random locations under
> >> >>   "/system.slice" for example:
> >> >>
> >> >>   /sys/fs/cgroup/system.slice/systemd-journald.service/memory.press=
ure
> >> >>
> >> >>   Where in the above systemd-journald.service might be
> >> >>   templated (systemd-journald@FOO.service). Point is that the path =
is
> >> >>   random. genfscon does not support regex and glob. I can't do for =
example:
> >> >>
> >> >>   (genfscon "cgroup2" "/system.slice/.*/memory.pressure"
> >> >>   cgroupfile_context)
> >> >>
> >> >>   Fortunately cgroup2fs supports relabeling but if systemd has to
> >> >>   manually relabel the cgroup files then I would imagine that this =
is
> >> >>   racy as well, and that does not really solve the underlying issue=
.
> >> >>
> >> >>   I am looking for ideas and suggestions
> >> >
> >> > Optimally one of two things would happen:
> >> > 1. The kernel would label the inode correctly when it is first creat=
ed
> >> > (e.g. by augmenting genfscon to support more general matching), or
> >> > 2. The userspace component that creates these files would label them
> >> > correctly at creation (via setfscreatecon() prior to creation).
> >>
> >> Agree but 1. would require regex/glob support for genfscon and 2. thes=
e
> >> files aren't "created" by userspace AFAIK and so setfscreatecon or
> >> automatic object type transitions are probably not an option here.
> >>
> >> >
> >> > Pardon my ignorance but what creates these files initially? The kern=
el
> >> > in response to some event or systemd or some other userspace
> >> > component?
> >>
> >> Yes AFAIK it is the former (psuedo filesystem similar to procfs, debug=
fs
> >> in that sense). This is also why I don't think that the PR mentioned i=
s
> >> tested because cgroup2 fs labeling is done with genfscon and not fsuse
> >> trans or fsuse xattr so even if the files would be created by
> >> userspace (which I think is not the case) the specified automatic obje=
ct
> >> type transition rule wouldnt work.
> >
> > Actually, type transitions on cgroupfs should work - I added special
> > hooks for kernfs just for that some time ago - see kernel commits
> > d0c9c153b4bd6963c8fcccbc0caa12e8fa8d971d..e19dfdc83b60f196e0653d683499f=
7bc5548128f.
>
> Interesting. I will try this out. Would this not require at least a
> "fsuse trans" statement in policy?

No, it should work alongside genfscon. cgroupfs already was special
before that as it allowed relabeling despite genfscon being used.

>
> https://github.com/SELinuxProject/refpolicy/blob/master/policy/modules/ke=
rnel/filesystem.te#L89
>
> Also I am not sure if that support would make much sense on a filesystem
> where files are created my the kernel in reaction to some event.

It does make sense with named transitions, plus it was needed to make
even a simple parent-child inheritance work. Also, I believe some
cgroupfs files/directories (I think only directories?) can be created
by userspace, too.

--=20
Ondrej Mosnacek
Senior Software Engineer, Linux Security - SELinux kernel
Red Hat, Inc.

