Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A23C07E99
	for <selinux@archiver.kernel.org>; Fri,  9 Jul 2021 20:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C204861241
	for <selinux@archiver.kernel.org>; Fri,  9 Jul 2021 20:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhGIUjz (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Fri, 9 Jul 2021 16:39:55 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45661 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229506AbhGIUjz (ORCPT
        <rfc822;selinux@vger.kernel.org>); Fri, 9 Jul 2021 16:39:55 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 169KaXOm025930
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Jul 2021 16:36:41 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 320F815C3C9E; Fri,  9 Jul 2021 16:36:33 -0400 (EDT)
Date:   Fri, 9 Jul 2021 16:36:33 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, virtio-fs@redhat.com, dwalsh@redhat.com,
        dgilbert@redhat.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        miklos@szeredi.hu, gscrivan@redhat.com, jack@suse.cz,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/1] xattr: Allow user.* xattr on symlink and special
 files
Message-ID: <YOizURuWJO9DYGGk@mit.edu>
References: <20210708175738.360757-1-vgoyal@redhat.com>
 <20210708175738.360757-2-vgoyal@redhat.com>
 <20210709091915.2bd4snyfjndexw2b@wittgenstein>
 <20210709152737.GA398382@redhat.com>
 <710d1c6f-d477-384f-0cc1-8914258f1fb1@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <710d1c6f-d477-384f-0cc1-8914258f1fb1@schaufler-ca.com>
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 09, 2021 at 08:34:41AM -0700, Casey Schaufler wrote:
> >> One question, do all filesystem supporting xattrs deal with setting them
> >> on symlinks/device files correctly?
> > Wrote a simple bash script to do setfattr/getfattr user.foo xattr on
> > symlink and device node on ext4, xfs and btrfs and it works fine.
> 
> How about nfs, tmpfs, overlayfs and/or some of the other less conventional
> filesystems?

As a suggestion, perhaps you could take your bash script and turn it
into an xfstests test so we can more easily test various file systems,
both now and once the commit is accepted, to look for regressions?

Cheers,

					- Ted
