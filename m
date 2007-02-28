Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1SL7xb1000358
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 16:07:59 -0500
Received: from mail2.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1SL9LM8012762
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 21:09:21 GMT
Date: Wed, 28 Feb 2007 16:09:19 -0500 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov
Subject: Re: [RFC 0/4] NetLabel fixups/cleanups
In-Reply-To: <20070228201419.115784233@hp.com>
Message-ID: <Line.LNX.4.64.0702281607020.10200@d.namei>
References: <20070228201419.115784233@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 28 Feb 2007, Paul Moore wrote:

> to live dangerously.  This patchset most likely needs a little more work and
> testing before I feel comfortable submitting it for inclusion, but a little
> birdie suggested I post them as an RFC patchset.

These look ok to me, and I've applied them to
git://git.infradead.org/~jmorris/selinux-2.6#for-next-kernel

It's probably too late to get non-bugfixes into 2.6.21, so they'll 
probably queue there until the next merge window opens, and also go into 
-mm.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
