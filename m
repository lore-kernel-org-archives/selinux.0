Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94Ii5cn027103
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 14:44:05 -0400
Received: from mail3.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k94IhUUx016736
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 18:43:30 GMT
Date: Wed, 4 Oct 2006 14:44:03 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: paul.moore@hp.com
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, eparis@redhat.com,
        sds@tycho.nsa.gov, vyekkirala@TrustedCS.com
Subject: Re: [PATCH 0/2] [PATCH 0/2] Updated NetLabel/secid-reconciliation
 bits and a bugfix
In-Reply-To: <20061004154629.186531000@hp.com>
Message-ID: <Pine.LNX.4.64.0610041439050.6196@d.namei>
References: <20061004154629.186531000@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 4 Oct 2006, paul.moore@hp.com wrote:

> This patchset includes an update to the NetLabel/secid-reconciliation patch,
> replacing my "v3" patch from earlier this week, and a bugfix patch to cure a
> race condition found during testing this week.  The bugfix patch does not
> rely on the secid patches and should be merged regardless as it fixes a bug
> which has been around since the very first NetLabel patches (not sure why I
> didn't see this sooner).

So, patch 2/2 should go in on it's own against upstream?  If so, in 5B
future, please post such patches separately.

As for the rest of the network labeling, please work together with Venkat 
and the SELinux developers on a final patchset which meets all of the 
design goals and has been tested, with policy which has been merged 
upstream and is available via Fedora devel.  Please keep the discussion 
going, but ensure that the final patchset for review and merge 
consideration is a complete set against the current git kernel coming from 
one person.

Thanks,



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
