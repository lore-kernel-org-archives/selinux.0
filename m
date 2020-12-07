Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A82FC433FE
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 20:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF43F238E3
	for <selinux@archiver.kernel.org>; Mon,  7 Dec 2020 20:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgLGUxw (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 7 Dec 2020 15:53:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33734 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbgLGUxw (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 7 Dec 2020 15:53:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607374345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=px9Zcx82A4MwL+C2lKSUkeny02ahtUYNJowCksfcBvs=;
        b=IGjAceiX6KG746qKp7YBSLN6TqufeQzU2tc8WURur/t08SPODriJxR1GrnLsGp1k3cqwBH
        nX5NTeo7/sq6lZiXoQlKXbfy/HQ/PU+tWdP+2AgOh7HrY/9q3hyCEJFwkWpC6IkWzZ28BM
        6Tl7c6qbbo63bA5Jwauopwu6b5NI+NY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36--s7tb6g5PEuRkirdoi5cXQ-1; Mon, 07 Dec 2020 15:52:24 -0500
X-MC-Unique: -s7tb6g5PEuRkirdoi5cXQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 276FF107ACF5;
        Mon,  7 Dec 2020 20:52:22 +0000 (UTC)
Received: from horse.redhat.com (ovpn-116-41.rdu2.redhat.com [10.10.116.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E9B76F960;
        Mon,  7 Dec 2020 20:52:11 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 09F96220BCF; Mon,  7 Dec 2020 15:52:10 -0500 (EST)
Date:   Mon, 7 Dec 2020 15:52:09 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        SElinux list <selinux@vger.kernel.org>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Daniel Walsh <dwalsh@redhat.com>,
        Zdenek Pytela <zpytela@redhat.com>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: virtiofs and its optional xattr support vs. fs_use_xattr
Message-ID: <20201207205209.GD3107@redhat.com>
References: <CAFqZXNsGabHBfV36nNAVLJgEzjkBev-O3YZ1vnmXyVoaDdjiHQ@mail.gmail.com>
 <CAHC9VhRCu5W4YOzcidUhv7biVc+a4QrRknVn-57YVSM3vWZH+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRCu5W4YOzcidUhv7biVc+a4QrRknVn-57YVSM3vWZH+Q@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Mon, Dec 07, 2020 at 10:03:24AM -0500, Paul Moore wrote:
> On Mon, Dec 7, 2020 at 9:43 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Hi everyone,
> >
> > In [1] we ran into a problem with the current handling of filesystem
> > labeling rules. Basically, it is only possible to specify either
> > genfscon or fs_use_xattr for a given filesystem, but in the case of
> > virtiofs, certain mounts may support security xattrs, while other ones
> > may not.
> 

[ cc virtio-fs list and miklos ]
> Quickly skimming the linked GH issue, it appears that the problem
> really lies in the fact that virtiofs allows one to enable/disable
> xattrs at mount time.  What isn't clear to me is why one would need to
> disable xattrs, can you explain that use case?  Why does enabling
> xattrs in virtiofs cause problems?

Its not exactly a mount time option. Its a virtiofs file server option.

xattr support by default is disabled because it has performance
penalty. Users can enable it if they want to.

So if virtiofsd starts without xattr support and somebody runs a
VM with SELinux enabled, they should still be able to mount virtiofs,
I guess (instead of failing it).

Thanks
Vivek

