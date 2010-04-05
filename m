Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o35KG9aD028575
	for <selinux@tycho.nsa.gov>; Mon, 5 Apr 2010 16:16:09 -0400
Received: from g6t0184.atlanta.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o35KFeR2011682
	for <selinux@tycho.nsa.gov>; Mon, 5 Apr 2010 20:15:41 GMT
From: Paul Moore <paul.moore@hp.com>
To: Joe Nall <joe@nall.com>
Subject: Re: [PATCH] selinux: UNIX domain socket fixes
Date: Mon, 5 Apr 2010 16:16:06 -0400
Cc: selinux@tycho.nsa.gov
References: <20100405190124.6015.72502.stgit@flek.lan> <1A4A075E-8B71-467D-97D2-1957F38B8F57@nall.com>
In-Reply-To: <1A4A075E-8B71-467D-97D2-1957F38B8F57@nall.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201004051616.06832.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 05 April 2010 03:28:12 pm Joe Nall wrote:
> On Apr 5, 2010, at 2:01 PM, Paul Moore wrote:
> > Correct a problem where we weren't setting the peer label correctly on
> > connected UNIX domain sockets and do some other general fixup while we
> > are messing with the code.
> > 
> > Signed-off-by: Paul Moore <paul.moore@hp.com>
> 
> Paul,
> Do you have a before/after test case?

Not really a before/after no, as I don't have anything that really performs a 
getpeercon() on the client end as typically only the server side cares about 
the peer's label (or at least that has been my experience).  What I did test 
was to make sure I didn't see any regressions in the UNIX stream socket 
connections.  To accomplish that I tweaked a little SELinux aware server I use 
for testing INET sockets to make it work with UNIX sockets and connected to it 
with socat at a variety of different levels, making sure getpeercon() always 
displayed the correct level over a UNIX socket connection.

You can find a copy of my little test server at the URL below; I will caution 
you it isn't particularly well written but it works well for situations like 
these.

 * http://free.linux.hp.com/~pmoore/files/getpeercon_server.c

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
