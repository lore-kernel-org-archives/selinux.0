Message-ID: <1344603323.10631.23.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: Possible bug in finding default context?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ole Kliemann <ole@plastictree.net>
Cc: selinux@tycho.nsa.gov
Date: Fri, 10 Aug 2012 08:55:23 -0400
In-Reply-To: <20120810085840.GA2296@telvanni>
References: <20120809174519.GE1643@telvanni>
	 <1344534512.1175.17.camel@moss-pluto.epoch.ncsc.mil>
	 <20120810085840.GA2296@telvanni>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2012-08-10 at 10:58 +0200, Ole Kliemann wrote:
> On Thu, Aug 09, 2012 at 01:48:32PM -0400, Stephen Smalley wrote:
> > On Thu, 2012-08-09 at 19:45 +0200, Ole Kliemann wrote:
> > > BTW, the exact number seems 194. 194 types associated with one 
> > > role works. 195 and it's broken.
> > > 
> > > I'm doing this on Ubuntu 12.04, so it could be the crappily 
> > > maintained selinux userland here.
> > 
> > We'd like to rip out all usage of security_compute_user()
> > aka /sys/fs/selinux/user and everything that calls it.  Previously
> > discussed on the list, although not your specific problem (presumably
> > we're hitting the selinuxfs limit on size of response for /selinux/user
> > transactions).  Take all of that logic to userspace and greatly simplify
> > it.
> 
> Since I seem to be inclined to do strange things noone really did 
> before, I have to ask this:
> 
> This is strictly a problem only for the userspace, right? The LSM 
> can handled what ever I throw at it and will always enforce the 
> policy by the letter, no matter how many types/roles/user or 
> other strange constructs whatsoever I use?

Correct.  It is a limitation of the selinuxfs API, imposing a max size
on the response payload.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
