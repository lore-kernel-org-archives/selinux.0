Return-Path: <SRS0=DV1m=OW=vger.kernel.org=selinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4101C65BAE
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 18:54:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D6B92086D
	for <selinux@archiver.kernel.org>; Thu, 13 Dec 2018 18:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D6B92086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=selinux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeLMSy6 (ORCPT <rfc822;selinux@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:54:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50936 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeLMSy5 (ORCPT <rfc822;selinux@vger.kernel.org>);
        Thu, 13 Dec 2018 13:54:57 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 37A1E30833A4;
        Thu, 13 Dec 2018 18:54:57 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D9E3C1992A;
        Thu, 13 Dec 2018 18:54:56 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 628C72208FC; Thu, 13 Dec 2018 13:54:56 -0500 (EST)
Date:   Thu, 13 Dec 2018 13:54:56 -0500
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
Message-ID: <20181213185456.GC4384@redhat.com>
References: <20181204154243.GA16818@redhat.com>
 <665ec6f3-f16d-681f-30d5-eface14c9808@tycho.nsa.gov>
 <20181204161747.GC16818@redhat.com>
 <e8841bf0-d6b8-0e7d-6a35-055a06441d30@tycho.nsa.gov>
 <20181205134317.GA11337@redhat.com>
 <8eb7f677-fd71-c31b-bfed-29fb7187d132@tycho.nsa.gov>
 <20181211214821.GD17242@redhat.com>
 <2e4d90ce-61e7-56b1-c161-4e5fb7236537@tycho.nsa.gov>
 <20181213145813.GB4384@redhat.com>
 <846eb23e-1188-9e45-ee0a-676d26cc715e@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <846eb23e-1188-9e45-ee0a-676d26cc715e@tycho.nsa.gov>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Thu, 13 Dec 2018 18:54:57 +0000 (UTC)
Sender: selinux-owner@vger.kernel.org
Precedence: bulk
List-ID: <selinux.vger.kernel.org>
X-Mailing-List: selinux@vger.kernel.org

On Thu, Dec 13, 2018 at 11:12:31AM -0500, Stephen Smalley wrote:

[..]
> > > > Can you elaborate a bit more on how this is leaking data through overlay
> > > > mount. If it is, then why accessing file on lower is not equivalent of
> > > > leaking of data.
> > > 
> > > In the container use case, retaining the lower label on copy-up for a
> > > context-mounted overlay permits a process in the container to leak the
> > > container data out to host files not labeled with the container label and
> > > thus potentially accessible to other containers or host processes.
> > 
> > > The
> > > container process appears to just be writing to files labeled with the
> > > container label via the overlay, but the written data and/or metadata is
> > > directly accessible through the lower label, which is likely readable to
> > > all/many containers and host processes.
> > > 
> > > In the multi-level security (MLS) use case, an analogy would a situation
> > > where you have an unclassified lower dir with some content to be shared
> > > read-only across all levels, and an overlay is context-mounted at each level
> > > with a corresponding upper dir and work dir private to that level.  If a
> > > client process at secret performs a write to a file via the secret overlay,
> > > and if the written data is stored in a file in the upper dir that inherits
> > > the label from the lower file (unclassified), then the secret process can
> > > leak data to unclassified processes at will, violating the MLS policy.
> > 
> > For the case of devices, its already happening. One might change metadata
> > of a device (hence trigger copy up). Now all writes to upper device file
> > from secret process still go to same underlying device and are still
> > readable from lower device file.
> 
> This is an argument for not copying up device files IMHO, not for preserving
> the lower label on them.

How do we handle metadata change to device node (like timestamp, ownership
change) without copy up.

Vivek
