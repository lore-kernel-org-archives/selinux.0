Return-Path: <SRS0=z32U=OF=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6891BC43441
	for <selinux@archiver.kernel.org>; Mon, 26 Nov 2018 23:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B82E208E4
	for <selinux@archiver.kernel.org>; Mon, 26 Nov 2018 23:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Le3V4OLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B82E208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeK0KVa (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:21:30 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40681 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbeK0KV3 (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 27 Nov 2018 05:21:29 -0500
Received: by mail-lf1-f68.google.com with SMTP id v5so14926475lfe.7
        for <selinux@vger.kernel.org>; Mon, 26 Nov 2018 15:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sTRV2cSEJ7VsJnXk4cP2qkg0dkmd71U5ZRy112Ec21Q=;
        b=Le3V4OLoWUV0hORWYHLl3fL6bGqkFdCJBL2+pAPVRxxL6HeiiS+fI+9XeVuVoi1pQ9
         iVTfe6qtBRG81V/D8uqHg4czOAsQgwBTrJ2YsaQSSUaHFGlNGzDY6htojUmJupvK5pWx
         vZxT1mb96pSDev+oeteMa2p3pJ8PcNwnX+cGk+PQdJ7BiudW6BOEbbW47xC79Bi+TMLo
         FjtVkDtKzP74tbTvfwt0yGLmeYi7CDN4CyToA9DxsygIWE6AJXFa8D5QHeMI0+jPMH5g
         7lKQgWglv0AJ8vmfmNbvr48pO1M/1c6sVSuWd66q9hh+BBpV9OwBIN/PoehwrWD1w8Va
         SNEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sTRV2cSEJ7VsJnXk4cP2qkg0dkmd71U5ZRy112Ec21Q=;
        b=CfHds6gBuQPU9IzOFK9rB2pu3ACWyserOO/3YBIzQBmlLIqC2ZCdtEQn2wRo84XtdJ
         B/AxRyecxOVs458C/d7bgTtMWRMrcEjv/2U9ZKX0BcookP4V/bUbiv2VVI0hftoc2WrS
         8cZ9iu54D0xKuBGi4v4YUZulLcQvHe8l/nGUvYfsDoJdjmk7zJ04yQm61imNdmp9TA3r
         tZsOVUHT2KdkpN6fC8UsVsKDKWlOlYJjfS6rQsCO3V/x4pS+Y+hveOL1/9HAk011F+Ao
         KFzJWHypozwlkjwZxEozPu54Zzfxr2An4c9B6+uu70+u84qu1/Co72vZkOHtdMfu8L9R
         uYQw==
X-Gm-Message-State: AGRZ1gL/LJsw5wDh58DHJD1GqyPKGfANyhdBTfKZcEvM8eFY0Dj4sXLz
        kv6gr2QLEG7P5nq30iyVrbmp4toFaabAUMDYXb0C
X-Google-Smtp-Source: AJdET5e6vmQckSOZ4Tp/JjkZVkUgPQB+XvFmvWXjEPvyRc27lUVgFAStc0YdnkstKx4NWTUMwkZ0DpcyIEL++bc24Kc=
X-Received: by 2002:a19:f115:: with SMTP id p21mr16612063lfh.20.1543274741455;
 Mon, 26 Nov 2018 15:25:41 -0800 (PST)
MIME-Version: 1.0
References: <20181116131202.26513-1-omosnace@redhat.com> <CAHC9VhTn9qz77PQ3mboaCsNzK9D8hjYFg9z5sCWr8Yb7W2Pqxg@mail.gmail.com>
 <CAFqZXNsAHnV5RzwtONF0hJRy31qb4c=sajvaEkmEjjky4duEBA@mail.gmail.com> <CAFqZXNvSdKYr998v3hEhZu4pRwuQs8Q7qRWPhOAtLAc9__Bs6w@mail.gmail.com>
In-Reply-To: <CAFqZXNvSdKYr998v3hEhZu4pRwuQs8Q7qRWPhOAtLAc9__Bs6w@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 26 Nov 2018 18:25:30 -0500
Message-ID: <CAHC9VhTvuPvnkfgQhT4+AM3iEz4_p85QgShM_oXmpVtLKuq10Q@mail.gmail.com>
Subject: Re: [PATCH] selinux: always allow mounting submounts
To:     omosnace@redhat.com
Cc:     selinux@vger.kernel.org, ebiederm@xmission.com,
        trond.myklebust@primarydata.com, seth.forshee@canonical.com,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Wed, Nov 21, 2018 at 10:38 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> On Wed, Nov 21, 2018 at 1:41 PM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > On Tue, Nov 20, 2018 at 11:09 PM Paul Moore <paul@paul-moore.com> wrote:
> > > On Fri, Nov 16, 2018 at 8:12 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > If a superblock has the MS_SUBMOUNT flag set, we should always allow
> > > > mounting it. These mounts are done automatically by the kernel either as
> > > > part of mounting some parent mount (e.g. debugfs always mounts tracefs
> > > > under "tracing" for compatibility) or they are mounted automatically as
> > > > needed on subdirectory accesses (e.g. NFS crossmnt mounts). Since such
> > > > automounts are either an implicit consequence of the parent mount (which
> > > > is already checked) or they can happen during regular accesses (where it
> > > > doesn't make sense to check against the current task's context), the
> > > > mount permission check should be skipped for them.
> > > >
> > > > Without this patch, attempts to access contents of an automounted
> > > > directory can cause unexpected SELinux denials.
> > > >
> > > > In the current kernel tree, the MS_SUBMOUNT flag is set only via
> > > > vfs_submount(), which is called only from the following places:
> > > >  - AFS, when automounting special "symlinks" referencing other cells
> > > >  - CIFS, when automounting "referrals"
> > > >  - NFS, when automounting subtrees
> > > >  - debugfs, when automounting tracefs
> > > >
> > > > In all cases the submounts are meant to be transparent to the user and
> > > > it makes sense that if mounting the master is allowed, then so should be
> > > > the automounts. Note that CAP_SYS_ADMIN capability checking is already
> > > > skipped for (SB_KERNMOUNT|SB_SUBMOUNT) in:
> > > >  - sget_userns() in fs/super.c:
> > > >         if (!(flags & (SB_KERNMOUNT|SB_SUBMOUNT)) &&
> > > >             !(type->fs_flags & FS_USERNS_MOUNT) &&
> > > >             !capable(CAP_SYS_ADMIN))
> > > >                 return ERR_PTR(-EPERM);
> > > >  - sget() in fs/super.c:
> > > >         /* Ensure the requestor has permissions over the target filesystem */
> > > >         if (!(flags & (SB_KERNMOUNT|SB_SUBMOUNT)) && !ns_capable(user_ns, CAP_SYS_ADMIN))
> > > >                 return ERR_PTR(-EPERM);
> > > >
> > > > Verified internally on patched RHEL 7.6 with a reproducer using
> > > > NFS+httpd and selinux-tesuite.
> > >
> > > I think this all sounds reasonable, but please verify this with an
> > > upstream kernel.  Upstream our focus is on the upstream kernel
> > > (surprise!), downstream RHEL is your responsibility, not ours :)
> >
> > I tested on RHEL because that's what I can do most conveniently. I
> > don't have a very good workflow/environment for complex testing on
> > upstream right now. I don't expect the results to be any different on
> > the upstream kernel, but I understand your concern. I have been
> > thinking about some patch testing automation using Fedora Rawhide (I
> > hope that's close enough to upstream at least :), so I guess it's time
> > to get scriptin'...
>
> I have now tested it on Fedora Rawhide with a scratch kernel with this
> patch applied [1] (x86_64 only). I ran the whole selinux-testsuite
> with the submount test [2] and everything passed (except for the known
> overlay failures and skipped binder test) ...

Merged into selinux/next, thanks.

-- 
paul moore
www.paul-moore.com
