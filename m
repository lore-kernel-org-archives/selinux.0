Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA01812
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 12:34:38 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA17727
	for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 17:32:34 GMT
Received: from nox.lemuria.org (nox.lemuria.org [213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id RAA17722 for <selinux@tycho.nsa.gov>; Mon, 2 Dec 2002 17:32:33 GMT
Date: Mon, 2 Dec 2002 18:34:21 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Cc: Russell Coker <russell@coker.com.au>
Subject: Re: expect
Message-ID: <20021202183420.A16247@lemuria.org>
References: <200211292002.PAA23890@moss-shockers.ncsc.mil> <200212011308.58878.russell@coker.com.au> <200212020809.20563.pollard@admin.navo.hpc.mil> <200212021558.27661.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200212021558.27661.russell@coker.com.au>; from russell@coker.com.au on Mon, Dec 02, 2002 at 03:58:27PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Dec 02, 2002 at 03:58:27PM +0100, Russell Coker wrote:
> Allowing daemons the tty access could probably be addressed in another way.  
> If we had a separate role and domain for starting daemons that could be 
> entered with newrole (which then removes the need for run_init as the role 
> would not have permission to do anything other than restarting daemons) we 
> could then allow all daemons read/write/ioctl access to the terminal for it.  
> Then if we deny the daemons read access to /dev (wherever possible) and 
> /dev/pts (always) then after you exit the shell that newrole ran (relabelling 
> your tty) the daemon won't be able to access your tty or open other ttys.


I like this idea a lot. It would make a real-life admin job much, much
easier. It's not just that sometimes you have several daemons to
(re)start, it is during development that you easily restart a given
service a couple dozen times. I know I considered the password request
a nuisance after the 5th or so time.


> I believe that this isn't as good as my solution with expect, and it isn't 
> something that can be done in a hurry either.

Actually, it may turn out to be a better solution, mostly because
expect is no longer required (and a couple of the recent postings here have 
shown just why that may be a good thing).

-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
