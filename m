Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1GELmL9015999
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 09:21:48 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1GEIDNj020119
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 14:18:14 GMT
Date: Wed, 16 Feb 2005 14:30:30 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: sshd transition points
Message-ID: <20050216143030.GR31121@lkcl.net>
References: <20050215155323.GC23765@lkcl.net> <1108491293.17854.153.camel@moss-spartans.epoch.ncsc.mil> <20050215191640.GA26294@lkcl.net> <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil> <20050215200355.GB26294@lkcl.net> <20050215205728.GC26294@lkcl.net> <1108558973.19756.45.camel@moss-spartans.epoch.ncsc.mil> <20050216135108.GN31121@lkcl.net> <1108561272.19756.89.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1108561272.19756.89.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Feb 16, 2005 at 08:41:12AM -0500, Stephen Smalley wrote:
> On Wed, 2005-02-16 at 08:51, Luke Kenneth Casson Leighton wrote:
> >  ah, but because the unprivileged child process in this instance manages
> >  the networking, and because i wish to restrict users on a per-IP basis
> >  from being able to log in, i _do_ want to associate a user-specific
> >  domain with the unprivileged child process.
> 
> I'm not sure that this makes sense; isn't the monitor process and the
> unprivileged child process created _before_ authenticating the user?  

 ahh..... ummmm... 

> It
> isn't until you create the user privileged child process that you have
> an authenticated user identity.

 let me have a look and see if i can find out from the source code.

 once authenticated, there has to be an "unprivileged" process
 which deals with networking on behalf of the user-process,
 using pipes to communicate between the two.

 irrespective of which process it is (the monitor one, the privsep one)
 i will still need to associated a user-based context with it,
 because that process, in dealing with networking, is the only place
 where i can put the per-ip-per-user networking restrictions
 (modified/derived version of can_network).

 okay.

 sshd.c's privsep_preauth() does the fork() and the child process
 is the one that drops privileges into sshd and does the chroot.

 [after the child comes out of privsep_preauth(), it drops
  into calling do_authentication or do_authentication2, followed
  by an exit() - at line 1486 of sshd.c in openssh-3.8.1p1]

 the parent calls privsep_postauth, which sets up the pipe,
 then does a fork again.
 
 the parent then does do_setusercontext() and then goes on to
 call do_authenticated() after it comes out of privsep_postauth().

 the [second] child continuously calls monitor_read() forever.


 SO!

 it's do_
 what i need to do is to have do_authentication2() perform
 the setcon() to the intermediate "sshd_priv_<role>_t" context
 AS SOON as it is established what the username is going to be.

 then, any further networking would potentially be interrupted
 by the modified/derived can_network() function, such that
 if you ain't coming in from the right IP address, you ain't
 gonna get authenticated.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
