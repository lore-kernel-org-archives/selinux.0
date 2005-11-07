Subject: Re: [ SEMANAGE ] Cleanup : move some things around
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <436F7F36.5080308@cornell.edu>
References: <436DDB51.2080903@cornell.edu>
	 <1131377599.20591.32.camel@moss-spartans.epoch.ncsc.mil>
	 <436F7F36.5080308@cornell.edu>
Content-Type: text/plain
Date: Mon, 07 Nov 2005 11:11:54 -0500
Message-Id: <1131379914.20591.70.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-11-07 at 11:22 -0500, Ivan Gyurdiev wrote:
> > I'd prefer to hold cleanups until we have stabilized the functionality
> > and interfaces as desired for test1.  I'm also not clear on why we want
> > a sepol handle in the ps case.  
> >   
> .. because we'll be using the sepol records either way, so we need the 
> sepol handle..
> Not using the sepol records requires copying them over into libsemanage.

Hmmm..well, let's take that up again later.  Right now we need to deal
with finalizing the boolean support (e.g. having libsemanage use
security_set_boolean_list with permanent=0 to set the runtime boolean
values upon commit rather than loading the generated binary policy
file), and getting the migration steps in place for test1.

I committed your semanage_set_reload_bools() patch and my
semanage_is_managed() patch to sourceforge cvs, but not the cleanup
patch.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
