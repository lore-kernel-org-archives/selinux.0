Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l581IXtO020961
	for <selinux@tycho.nsa.gov>; Thu, 7 Jun 2007 21:18:33 -0400
Received: from mail5.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l581IU6F016431
	for <selinux@tycho.nsa.gov>; Fri, 8 Jun 2007 01:18:31 GMT
Date: Thu, 7 Jun 2007 21:18:26 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov
Subject: Re: [PATCH 1/2] NetLabel: consolidate the struct socket/sock handling
 to just struct sock
In-Reply-To: <20070607153607.205559860@hp.com>
Message-ID: <Line.LNX.4.64.0706072118090.10435@d.namei>
References: <20070607153226.524778346@hp.com> <20070607153607.205559860@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 7 Jun 2007, Paul Moore wrote:

> The current NetLabel code has some redundant APIs which allow both
> "struct socket" and "struct sock" types to be used; this may have made sense at
> some point but it is wasteful now.  Remove the functions that operate on
> sockets and convert the callers.  Not only does this make the code smaller and
> more consistent but it pushes the locking burden up to the caller which can be
> more intelligent about the locks.  Also, perform the same conversion (socket
> to sock) on the SELinux/NetLabel glue code where it make sense.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>

Acked-by: James Morris <jmorris@namei.org>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
