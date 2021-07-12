Return-Path: <selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A4FC07E99
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 17:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97AFD61154
	for <selinux@archiver.kernel.org>; Mon, 12 Jul 2021 17:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbhGLRxb (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:53:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232979AbhGLRxa (ORCPT
        <rfc822;selinux@vger.kernel.org>); Mon, 12 Jul 2021 13:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626112241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fFWgzQHjwe/a8IqaPjJxMDhsIF8i/8K0Ya+rGP8ZwYU=;
        b=iFypeEQ+4WXO1LmKRJGE7vitcJjrCoayftHQhZDhMWc9UDnSW8mPAxnl/er2momuhRxNVn
        /KdxpMylyflNeWxf31i23T3I5DnPTB66ZpGnP4foTQhOraHWLEn9JtR5Uspc16TsHqR03Y
        bAakEJYINfQRJXSqpgpBtgKro67rQ3c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-XQPS2z1LNJaczUXwezog2g-1; Mon, 12 Jul 2021 13:50:38 -0400
X-MC-Unique: XQPS2z1LNJaczUXwezog2g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD65B9F92B;
        Mon, 12 Jul 2021 17:50:36 +0000 (UTC)
Received: from horse.redhat.com (ovpn-114-176.rdu2.redhat.com [10.10.114.176])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0A70B5C1D1;
        Mon, 12 Jul 2021 17:50:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9566922054F; Mon, 12 Jul 2021 13:50:32 -0400 (EDT)
Date:   Mon, 12 Jul 2021 13:50:32 -0400
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, virtio-fs@redhat.com, dwalsh@redhat.com,
        dgilbert@redhat.com, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        miklos@szeredi.hu, gscrivan@redhat.com, jack@suse.cz,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v2 1/1] xattr: Allow user.* xattr on symlink and special
 files
Message-ID: <20210712175032.GB502004@redhat.com>
References: <20210708175738.360757-1-vgoyal@redhat.com>
 <20210708175738.360757-2-vgoyal@redhat.com>
 <20210709091915.2bd4snyfjndexw2b@wittgenstein>
 <20210709152737.GA398382@redhat.com>
 <710d1c6f-d477-384f-0cc1-8914258f1fb1@schaufler-ca.com>
 <YOizURuWJO9DYGGk@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YOizURuWJO9DYGGk@mit.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Fri, Jul 09, 2021 at 04:36:33PM -0400, Theodore Ts'o wrote:
> On Fri, Jul 09, 2021 at 08:34:41AM -0700, Casey Schaufler wrote:
> > >> One question, do all filesystem supporting xattrs deal with setting them
> > >> on symlinks/device files correctly?
> > > Wrote a simple bash script to do setfattr/getfattr user.foo xattr on
> > > symlink and device node on ext4, xfs and btrfs and it works fine.
> > 
> > How about nfs, tmpfs, overlayfs and/or some of the other less conventional
> > filesystems?
> 
> As a suggestion, perhaps you could take your bash script and turn it
> into an xfstests test so we can more easily test various file systems,
> both now and once the commit is accepted, to look for regressions?

Sounds good. I see there is already an xattr test (generic/062) which
is broken after my patch. Current test expects that user.* xattrs will
fail on symlink/special device.

I will probably have to query kernel version and modify test so that
expect failure before a certain version and success otherwise.

Thanks
Vivek

