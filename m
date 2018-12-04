Return-Path: <SRS0=WX8y=ON=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CA1C04EB8
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 16:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8F520659
	for <selinux@archiver.kernel.org>; Tue,  4 Dec 2018 16:15:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC8F520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeLDQP3 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:15:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeLDQP2 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Tue, 4 Dec 2018 11:15:28 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B465787629;
        Tue,  4 Dec 2018 16:15:28 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A170A1057079;
        Tue,  4 Dec 2018 16:15:06 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 3B5A42208FC; Tue,  4 Dec 2018 11:15:06 -0500 (EST)
Date:   Tue, 4 Dec 2018 11:15:06 -0500
From:   Vivek Goyal <vgoyal@redhat.com>
To:     Stephen Smalley <sds@tycho.nsa.gov>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Paul Moore <paul@paul-moore.com>, linux-kernel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org,
        Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: overlayfs access checks on underlying layers
Message-ID: <20181204161506.GB16818@redhat.com>
References: <26bce3be-49c2-cdd8-af03-1a78d0f268ae@tycho.nsa.gov>
 <CAJfpeguL9xOh9Eq8LOP=ddJ4YD6nbp2UY6e2AYDVoHeCLuVhZA@mail.gmail.com>
 <6b125e8e-413f-f8e6-c7ae-50f7235c8960@tycho.nsa.gov>
 <CAJfpegv6y56k1-Tewu-Pu3x1W75LL6qYB6Hb6=n+2BJoNfEigA@mail.gmail.com>
 <c993dba4-5129-7f04-2724-a82a1f1cafa3@tycho.nsa.gov>
 <f84bbe0b-f4c1-50e0-8c84-a6589154b3ae@tycho.nsa.gov>
 <CAJfpegtBDTMbmKd6eDxRmtSJjGN6CnpGK_QPNSsxjkOoeu=1pQ@mail.gmail.com>
 <4c20a261-5ce1-f0a2-8d40-c6032a023216@tycho.nsa.gov>
 <20181204151549.GA21509@redhat.com>
 <311721a0-26d4-3cf6-1628-acb2c2b1478b@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <311721a0-26d4-3cf6-1628-acb2c2b1478b@tycho.nsa.gov>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Tue, 04 Dec 2018 16:15:28 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Tue, Dec 04, 2018 at 10:42:35AM -0500, Stephen Smalley wrote:

[..]
> > > Yes, in that case there isn't an escalation of privilege for the mounter (I
> > > acknowledged that above).  I'm still not sure copy-up of special files is a
> > > good idea though:
> > > 
> > > - In the case of device files, there is the potential for mischief by the
> > > client task in misusing the mounter's privileges to gain access to otherwise
> > > unusable device node (nodev lower vs upper?),
> > 
> > I was thinking about it as well. But client can always bypass permissions
> > of lower device inode by first removing device file and then by doing
> > a mknod. And that will be equivalent of copy up. IOW, IIUC, we do not deny
> > mknod to client and that always creates a way for it to write to device
> > file (and it does not matter what are permissions on lower?)
> 
> I'm not sure what you mean by "we do not deny mknod to client".  Depends on
> your policy and what context the client is running in.  Plenty of situations
> where the client is not allowed to create device files directly, and the
> mounter is.
> 

Oh, I meant for the cases where policy allows client to mknod with context
label. In that case, it does not matter what's the label on lower. Client
can always bypass it by first removing device node and creating a new
device node.

Thanks
Vivek
