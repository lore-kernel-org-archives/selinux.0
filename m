Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA05941
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 12:32:12 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA22158
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 16:31:01 GMT
Received: from nox.lemuria.org ([213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id QAA22150 for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 16:31:00 GMT
Date: Thu, 18 Apr 2002 18:32:58 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy question
Message-ID: <20020418183258.B7029@lemuria.org>
References: <20020418112238.A1788@lemuria.org> <20020418145101.D31F444CB8@lyta.coker.com.au> <20020418171532.B6551@lemuria.org> <20020418160829.1AF9F44D90@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020418160829.1AF9F44D90@lyta.coker.com.au>; from russell@coker.com.au on Thu, Apr 18, 2002 at 06:08:28PM +0200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 18, 2002 at 06:08:28PM +0200, Russell Coker wrote:
> > In essence, it boils down to: "a script (php, cgi, whatever) that
> > belongs to user X can only access files of user X"
> 
> Doing it for cgi is easy enough.  I could easily hack something up if the NSA 
> people don't release the MITRE code.

I guess so. The cgi gets executed in a new process, at which time a
domain transition is trivial to set up. I guess I can do that myself as
a learning excercise.


> > The sole problem being that the scripts aren't executed in the
> > unix-sense of execution, but by being loaded and interpreted by the
> > apache process.
> 
> Which means that they can't be given a different UID and therefore they can't 
> be given a different domain because domain transition can only occur at exec 
> time (just like for SUID programs).

If that is so, then my question is answered. Is execution really the
only point for a domain transition? That would make sense, but I also
see reasons for doing transitions during other file access operations
(e.g. maybe you want to get a higher protection level while certain
files are open).


> The concept you have is wrong, nothing will make domain transitions on module 
> load work.

Not on module load. The PHP module is loaded when apache starts. I want
to make a domain transition when it accesses a file. Here's a simple
flowchart:


* HTTP request incoming
* Apache main process hands request to a child or forks a new one
* Child parses request, finds URL, does URL to filename translation
* Child opens file
==> domain transition
* File is found to be a php file and is handled by the PHP module
* PHP module opens files, reads, writes, whatever
* Output sent to client
* Socket close
==> transition back to original domain


I see that this may not be possible with the current SELinux code. I'm
trying to point out that it may be useful. PHP is not the only thing
coming to mind.


Maybe apache can initiate the domain transition itself? A singular
patch in the URL parsing instance ("read target file's domain and make a
transition to it") should be feasable. As you pointed out, this would
be similiar to what suexec does.


Again, it may still be that I have a gross misunderstanding of what is
possible and what not and how things work. If so, please point my
errors out.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
