Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA02744
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 17:03:12 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id WAA05799
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 22:01:08 GMT
Received: from unicorn.lemuria.org ([213.191.83.179])
        by jazzband.ncsc.mil  with ESMTP id WAA05795 for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 22:01:07 GMT
Date: Mon, 2 Dec 2002 23:00:47 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: expect
Message-ID: <20021202230046.A8632@lemuria.org>
References: <200211292002.PAA23890@moss-shockers.ncsc.mil> <200212021558.27661.russell@coker.com.au> <20021202183420.A16247@lemuria.org> <200212022040.26257.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200212022040.26257.russell@coker.com.au>; from russell@coker.com.au on Mon, Dec 02, 2002 at 08:40:26PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Dec 02, 2002 at 08:40:26PM +0100, Russell Coker wrote:
> > easier. It's not just that sometimes you have several daemons to
> > (re)start, it is during development that you easily restart a given
> > service a couple dozen times. I know I considered the password request
> > a nuisance after the 5th or so time.
> 
> Good point.  When doing development you tend to have a dozen x-terms open at 
> once anyway, so reserving one for starting and stopping daemons should be OK.
> 
> Although this is when having labelled X windows would be good.

Actually, most of my development work is done remotely, and so I guess
for many other people, so X isn't a factor on the server-side.


> > expect is no longer required (and a couple of the recent postings here have
> > shown just why that may be a good thing).
> 
> The only real problem we have with expect IMHO is the problem I discovered 
> where some daemons don't start because the parent exits too fast.  I expect 
> that I'll solve that soon though.

Actually, it's more a problem of "do I really want Tk on this machine,
just so that I can run SELinx?" - it is a considerably extension of the
dependencies. Maybe I'm too old-school, but I cringe everything I
select a simple packet and it wants to install two dozen libraries and
programming languages in dependencies.
Or maybe that attitude is not for the SELinux world anymore. With a
regular system, the less stuff you have on it the more secure you can
feel (less possibilities for problems). On an SELinux machine, though,
that isn't (or at least shouldn't) be true anymore.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
