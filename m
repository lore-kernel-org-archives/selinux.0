Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k94MuO5E003371
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 18:56:24 -0400
Received: from mail5.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k94MtmlO018179
	for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2006 22:55:48 GMT
Date: Wed, 4 Oct 2006 18:56:20 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, eparis@redhat.com,
        sds@tycho.nsa.gov, vyekkirala@TrustedCS.com
Subject: Re: [PATCH 0/2] [PATCH 0/2] Updated NetLabel/secid-reconciliation
 bits and a bugfix
In-Reply-To: <45240369.4030107@hp.com>
Message-ID: <Pine.LNX.4.64.0610041855560.16024@d.namei>
References: <20061004154629.186531000@hp.com> <Pine.LNX.4.64.0610041439050.6196@d.namei>
 <45240369.4030107@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 4 Oct 2006, Paul Moore wrote:

> > So, patch 2/2 should go in on it's own against upstream?  If so, in 5B
> > future, please post such patches separately.
> 
> Yes, please commit patch 2/2 regardless as it fixes a bug which is not
> dependent on any of the secid patches which are being discussed.  My
> apologies for including it in the same patchset, I'll be sure to split
> it up next time.

Applied.

http://git.infradead.org/?p=users/jmorris/selinux-2.6.git

(This repo may move soon).


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
