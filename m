Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j1GIMRL9018748
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 13:22:27 -0500 (EST)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j1GIIoNj017158
	for <selinux@tycho.nsa.gov>; Wed, 16 Feb 2005 18:18:51 GMT
Date: Wed, 16 Feb 2005 18:31:13 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: sshd transition points
Message-ID: <20050216183113.GC6802@lkcl.net>
References: <20050215191640.GA26294@lkcl.net> <1108495342.17854.200.camel@moss-spartans.epoch.ncsc.mil> <20050215200355.GB26294@lkcl.net> <20050215225329.GH26294@lkcl.net> <20050215231707.GC29523@lkcl.net> <20050216000437.GD30341@lkcl.net> <1108559425.19756.54.camel@moss-spartans.epoch.ncsc.mil> <20050216134457.GL31121@lkcl.net> <20050216152644.GU31121@lkcl.net> <1108576417.20162.9.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1108576417.20162.9.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Feb 16, 2005 at 12:53:38PM -0500, Stephen Smalley wrote:
> On Wed, 2005-02-16 at 10:26, Luke Kenneth Casson Leighton wrote:
> > i aim to add a setcon() into sshd's "input_userauth_request()"
> > function just after the point where the username is obtained,
> > such that any unauthorised IP addresses for that username will
> > immediately stop any further TCP traffic.
> 
> And this occurs in the unprivileged child process, not the monitor?  

 looks like it, yes.

> So
> the unprivileged child will timeout waiting for further input, die, and
> the monitor will cleanup?

 yes, it most likely will have to.

> > i will add a type_transition to the policy
> > 
> > 	 type_transition sshd_priv_t user_t:process sshd_priv_user_t;
> > 
> > i will temporarily use get_default_context() - if it works - to
> > obtain the user_t context, as the 2nd argument to
> > security_compute_create().
> > 
> > i will use security_compute_create() to look up the actual context
> > in my type_transition policy rule (sshd_priv_user_t).
> 
> And where does sshd_priv_t come from?  

> Unless you make some other
> change, you are still running in sshd_t at this point, right?
 
 yes.

 i dreamed up sshd_priv_t for no particular reason other than it
 would conceivably be better to run setcon("sshd_priv_t") first
 on the unprivileged child process, followed by the
 security_compute_create(), such that creating

	type_transition sshd_priv_t user_t:process sshd_priv_user_t;

 doesn't interfere with anything to do with sshd_t.

 plus, of course, it would be possible to lock down a set
 of insanely restrictive rules for sshd_priv_t (involving
 networking and pretty much nothing else), with the implicit
 possibility that sshd_t could have some networking permissions
 removed.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
