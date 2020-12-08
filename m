Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB84C4361B
	for <selinux@archiver.kernel.org>; Tue,  8 Dec 2020 14:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C7D523A69
	for <selinux@archiver.kernel.org>; Tue,  8 Dec 2020 14:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbgLHOgF (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 8 Dec 2020 09:36:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58967 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726738AbgLHOgF (ORCPT
        <rfc822;selinux@vger.kernel.org>); Tue, 8 Dec 2020 09:36:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607438078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yUD7GfwdffxUxibiod4nQiUdFVIxMiQbGF525+rPodI=;
        b=YUfqOEBX2rnSdchteo3QVG9ljlxEJcUmT98p9llSmuxRBnaXD6bPu0HioX8pz3/QzZ+3T8
        8i6rJtsoQDFIYUiI4XUm+Cwi42FNnbJe1cJ3ojAqppujeXAlHi/tCRXlIqyhT6Uv7DJF99
        hGmqEBZIdZK6y39u58AxbcuiDHiWE/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-91dLbZ0nP02QTxm4TZu4cA-1; Tue, 08 Dec 2020 09:34:36 -0500
X-MC-Unique: 91dLbZ0nP02QTxm4TZu4cA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3972C86ABD6;
        Tue,  8 Dec 2020 14:33:38 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-241.rdu2.redhat.com [10.10.116.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA2705C1A1;
        Tue,  8 Dec 2020 14:33:36 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 18AA9220BCF; Tue,  8 Dec 2020 09:33:36 -0500 (EST)
Date:   Tue, 8 Dec 2020 09:33:36 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Dominick Grift <dominick.grift@defensec.nl>
Cc:     Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Zdenek Pytela <zpytela@redhat.com>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: virtiofs and its optional xattr support vs. fs_use_xattr
Message-ID: <20201208143336.GB3212@redhat.com>
References: <CAFqZXNsGabHBfV36nNAVLJgEzjkBev-O3YZ1vnmXyVoaDdjiHQ@mail.gmail.com>
 <CAHC9VhRCu5W4YOzcidUhv7biVc+a4QrRknVn-57YVSM3vWZH+Q@mail.gmail.com>
 <20201207205209.GD3107@redhat.com>
 <ypjlczzlmhus.fsf@defensec.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ypjlczzlmhus.fsf@defensec.nl>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 07, 2020 at 10:22:35PM +0100, Dominick Grift wrote:
> Vivek Goyal <vgoyal@redhat.com> writes:
> 
> > On Mon, Dec 07, 2020 at 10:03:24AM -0500, Paul Moore wrote:
> >> On Mon, Dec 7, 2020 at 9:43 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >> >
> >> > Hi everyone,
> >> >
> >> > In [1] we ran into a problem with the current handling of filesystem
> >> > labeling rules. Basically, it is only possible to specify either
> >> > genfscon or fs_use_xattr for a given filesystem, but in the case of
> >> > virtiofs, certain mounts may support security xattrs, while other ones
> >> > may not.
> >> 
> >
> > [ cc virtio-fs list and miklos ]
> >> Quickly skimming the linked GH issue, it appears that the problem
> >> really lies in the fact that virtiofs allows one to enable/disable
> >> xattrs at mount time.  What isn't clear to me is why one would need to
> >> disable xattrs, can you explain that use case?  Why does enabling
> >> xattrs in virtiofs cause problems?
> >
> > Its not exactly a mount time option. Its a virtiofs file server option.
> >
> > xattr support by default is disabled because it has performance
> > penalty. Users can enable it if they want to.
> 
> if SELinux is enabled then you should preferably just use fs_use xattr unconditionally
> 
> >
> > So if virtiofsd starts without xattr support and somebody runs a
> > VM with SELinux enabled, they should still be able to mount virtiofs,
> > I guess (instead of failing it).
> 
> SELinux requires that everything is always labeled one way or another
> and so if SELinux is enabled one should either use genfscon or fs_use xattr
> 
> Since is support fs_use xattr that should be the default and if any
> would for any reason want to replace that with genfscon then that is
> something they have to address (by excluding the fs_use xattr rule and
> replacing it with a genfscon rule (not sure why anyone would ever want
> that)
> 
> Gist is that if SELinux is enabled then one of the two should be
> present, preferably fs_use xattr (so thats the default).

I understand that current state is that one needs to choose either
genfscon or fs_use_xattr depending on filesystem type. Will be nice
if this was more flexibile.

If virtiofsd is running on top of a filesystem which does not support
xattr, then also virtiofs mount will fail.

IOW, with virtiofs both kind of configurations can be easily produed
(xattr enabled or disabled). So none of the defaults (genfscon or
fs_use_xattr) seems to be ideal.

IIUC, policy is assuming that virtiofs will either always support xattr
or will not always support xattrs. Which probably is true for many
filesystems. But not necessarily in this case. So hard coding one
assumption will break other configurations. It will be nice if we there
is a way to fix this in policy.

Thanks
Vivek

