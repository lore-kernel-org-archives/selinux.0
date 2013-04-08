Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r38IW3rv021239
	for <selinux@tycho.nsa.gov>; Mon, 8 Apr 2013 14:32:04 -0400
From: Paul Moore <pmoore@redhat.com>
To: David Miller <davem@davemloft.net>
Cc: Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org,
        mvadkert@redhat.com, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tcp: assign the sock correctly to an outgoing SYNACK packet
Date: Mon, 08 Apr 2013 14:32 -0400
Message-ID: <31036542.d4Dp22e6Ij@sifl>
In-Reply-To: <1725553.maWFXblPLa@sifl>
References: <20130408154519.18177.57709.stgit@localhost> <1365443267.3887.28.camel@edumazet-glaptop> <1725553.maWFXblPLa@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday, April 08, 2013 02:12:01 PM Paul Moore wrote:
> On Monday, April 08, 2013 10:47:47 AM Eric Dumazet wrote:
> > On Mon, 2013-04-08 at 13:40 -0400, Paul Moore wrote:
> > > Sort of a similar problem, but not really the same.  Also, arguably,
> > > there is no real associated sock/socket for a RST so orphaning the
> > > packet makes sense. In the case of a SYNACK we can, and should,
> > > associate the packet with a sock/socket.
> > 
> > What is the intent ?
> 
> We have to do a number of painful things in SELinux because we aren't
> allowed a proper security blob (void *security) in a sk_buff.  One of those
> things ...

Actually, I wonder if this problem means it is a good time to revisit the no-
security-blob-in-sk_buff decision?  The management of the blob would be hidden 
behind the LSM hooks like everything else and it would have a number of 
advantages including making problems like we are seeing here easier to fix or 
avoid entirely.  It would also make life much easier for those of working on 
LSM stuff and it would pave the way for including network access controls in 
the stacked-LSM stuff Casey is kicking around.

I'm aware of all the arguments against, but thought it would be worth bringing 
it up again, if for no other reason than I haven't heard enough shouting yet 
today :)

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
