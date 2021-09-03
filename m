Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02838C4332F
	for <selinux@archiver.kernel.org>; Fri,  3 Sep 2021 16:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D93B7610E8
	for <selinux@archiver.kernel.org>; Fri,  3 Sep 2021 16:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349856AbhICQFE (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 3 Sep 2021 12:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:39680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349812AbhICQFE (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 3 Sep 2021 12:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630685043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ElCv3KNatjZIL08Q3sItmtwzUZxx0adYt6QO0URmx6U=;
        b=dkhCVeDoH47S36ZMeybMGWSLXgZ2Gf3EuYLSOqKSPS9YZA++Zao/dtW2CHcGibMTAohcYo
        CimJjs654cZyuxljKNjuivFjx9yEsM4PmCrLWQ3OMAo1sMGlPsDjUjKvfPZ5+TMyXl44LO
        S2+otex+C7gD6J5PIZVbzMXUHiZHIA4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-zuax0mlmOp2jXY4hSL0i8w-1; Fri, 03 Sep 2021 12:04:02 -0400
X-MC-Unique: zuax0mlmOp2jXY4hSL0i8w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AA6A180FD93;
        Fri,  3 Sep 2021 16:04:01 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.22.8.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 827F9100EBC1;
        Fri,  3 Sep 2021 16:03:57 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 2158A220257; Fri,  3 Sep 2021 12:03:57 -0400 (EDT)
Date:   Fri, 3 Sep 2021 12:03:57 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Bruce Fields <bfields@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        fstests <fstests@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, virtio-fs@redhat.com,
        Daniel Walsh <dwalsh@redhat.com>,
        David Gilbert <dgilbert@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        stephen.smalley.work@gmail.com, Dave Chinner <david@fromorbit.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 3/1] xfstests: generic/062: Do not run on newer kernels
Message-ID: <YTJHbaFGJOn4TNj8@redhat.com>
References: <20210902152228.665959-1-vgoyal@redhat.com>
 <YTDyE9wVQQBxS77r@redhat.com>
 <CAHc6FU4ytU5eo4bmJcL6MW+qJZAtYTX0=wTZnv4myhDBv-qZHQ@mail.gmail.com>
 <CAHc6FU5quZWQtZ3fRfM_ZseUsweEbJA0aAkZvQEF5u9MJhrqdQ@mail.gmail.com>
 <CAPL3RVH9MDoDAdiZ-nm3a4BgmRyZJUc_PV_MpsEWiuh6QPi+pA@mail.gmail.com>
 <YTJCjGH0V5yzMnQB@redhat.com>
 <CAPL3RVFB67-AqZrjjfxueQF1Jw=LmKWzCk3Ur94EjUotYMw0AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPL3RVFB67-AqZrjjfxueQF1Jw=LmKWzCk3Ur94EjUotYMw0AA@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Sep 03, 2021 at 11:50:43AM -0400, Bruce Fields wrote:
> On Fri, Sep 3, 2021 at 11:43 AM Vivek Goyal <vgoyal@redhat.com> wrote:
> > On Fri, Sep 03, 2021 at 10:42:34AM -0400, Bruce Fields wrote:
> > > Well, we could also look at supporting trusted.* xattrs over NFS.  I
> > > don't know much about them, but it looks like it wouldn't be a lot of
> > > work to specify, especially now that we've already got user xattrs?
> > > We'd just write a new internet draft that refers to the existing
> > > user.* xattr draft for most of the details.
> >
> > Will be nice if we can support trusted.* xattrs on NFS.
> 
> Maybe I should start a separate thread for that.  Who would need to be
> on it to be sure we get this right?

I will like to be on cc list.

Vivek

