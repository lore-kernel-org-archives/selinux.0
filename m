Subject: Re: Loading things into policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ron Kuris <rk@unify.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>, selinux@tycho.nsa.gov,
   Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <43568CE4.4030901@unify.com>
References: <43559474.1080905@cornell.edu>
	 <1129742438.2375.236.camel@moss-spartans.epoch.ncsc.mil>
	 <43568C6E.5040106@cornell.edu>  <43568CE4.4030901@unify.com>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 14:20:51 -0400
Message-Id: <1129746051.2375.272.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-19 at 11:13 -0700, Ron Kuris wrote:
> Another interesting point is that your pseudo-code suffers from a race
> condition: what if two processes try to add() at the same time?

This is an interface exposed by one shared library (libsepol) for use by
another shared library (libsemanage) acting on an in-memory data
structure (policydb) private to the calling process, so that wasn't an
issue. 

But it is moot in any case, see the follow-up discussion...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
