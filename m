Subject: Re: [PATCH] semanage-functionality 11/17
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Karl MacMillan <kmacmillan@tresys.com>, selinux@tycho.nsa.gov,
   "'Joshua Brindle'" <jbrindle@tresys.com>
In-Reply-To: <43397AAA.2060807@cornell.edu>
References: <200509271249.j8RCnfYs026088@gotham.columbia.tresys.com>
	 <43397AAA.2060807@cornell.edu>
Content-Type: text/plain
Date: Tue, 27 Sep 2005 15:18:46 -0400
Message-Id: <1127848726.21671.114.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-27 at 13:00 -0400, Ivan Gyurdiev wrote:
> Karl MacMillan wrote:
> 
> >Makefile changes to build a shared libsemanage library.
> >  
> >
> I am not clear on how exporting symbols is done, but it would be better 
> if the things I'm currently working on are _not_ exported, because they 
> are in flux. What changes (if any) should I make to disable this 
> functionality?

You can mark your symbols "hidden", as libselinux does for non-static
symbols that it doesn't want exported (e.g. see libselinux/src/trans.c).
Or we can change libsemanage to use an explicit map like libsepol.

A good paper to read is
http://people.redhat.com/drepper/dsohowto.pdf
In particular, section 2.2.

We should likely be using symbol versioning as well, as discussed in
section 3.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
