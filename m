Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6FDBgip017857
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 09:11:42 -0400
Received: from mail3.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6FDBesi016667
	for <selinux@tycho.nsa.gov>; Sat, 15 Jul 2006 13:11:41 GMT
Date: Sat, 15 Jul 2006 09:11:39 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, davem@davemloft.net,
        sds@epoch.ncsc.mil, jmorris@redhat.com, pratt@argus-systems.com
Subject: Re: [PATCH 3/7] NetLabel: CIPSOv4 engine
In-Reply-To: <Pine.LNX.4.64.0607150905550.24495@d.namei>
Message-ID: <Pine.LNX.4.64.0607150911210.24495@d.namei>
References: <20060714185739.780700000@flek.zko.hp.com>
 <20060714185915.270209000@flek.zko.hp.com> <Pine.LNX.4.64.0607150905550.24495@d.namei>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 15 Jul 2006, James Morris wrote:

> > +	/* XXX - In both cases, this is kinda ugly as we have to go through
> > +	   the list once to determine how large of a buffer we need,
> > +	   drop the locks, allocate the buffer, grab the locks, and
> > +	   finally fill the buffer.  The problem is that there is that
> > +	   open window where the table could grow and we will end up
> > +	   short on space. */
> 
> This needs to be fixed.

Actually, you have many of these.


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
