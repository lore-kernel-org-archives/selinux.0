Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hARMWTRb025315
	for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 17:32:29 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hARMVrp5014440
	for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 22:31:53 GMT
Received: from ns.sws.net.au (ns.sws.net.au [61.95.69.3])
	by jazzswing.ncsc.mil  with ESMTP id hARMVqt0014437
	for <selinux@tycho.nsa.gov>; Thu, 27 Nov 2003 22:31:52 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Tom <tom@lemuria.org>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: BSD Secure levels for linux
Date: Fri, 28 Nov 2003 09:32:15 +1100
References: <3FC54560.5050303@diyab.net> <3FC61C05.90400@diyab.net> <20031127214635.I7755@lemuria.org>
In-Reply-To: <20031127214635.I7755@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200311280932.15431.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 28 Nov 2003 07:46, Tom <tom@lemuria.org> wrote:
> On Thu, Nov 27, 2003 at 10:45:09AM -0500, Diyab wrote:
> > I never thought about something like that.  On the plus side not only
> > would you have more control over what your specific "levels" will do but
> > you can easily and securely switch between levels.  The patch I
> > mentioned does not have that functionality.
>
> Remember that it's a _feature_ of the securelevels implementation that
> you can _not_ switch back. Once locked down, nothing short of a reboot
> will unlock, and a reboot is a very noisy action in any production
> environment.

I agree that it can be desirable to not permit changing back.  But SE Linux 
policies are very flexible, so it will not be difficult for the user to 
customise their system to their own desire.  If we can provide options for 
implementing secure levels in SE Linux that are more desirable to the users 
than those offered by BSD Unix then it can only increase the number of people 
using it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
