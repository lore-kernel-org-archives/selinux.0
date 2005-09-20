Subject: Re: [ SEPOL/SEMANAGE ] Boolean record
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4330648F.7040609@cornell.edu>
References: <432FBD08.2050903@cornell.edu>
	 <1127243186.14569.135.camel@moss-spartans.epoch.ncsc.mil>
	 <4330648F.7040609@cornell.edu>
Content-Type: text/plain
Date: Tue, 20 Sep 2005 15:56:18 -0400
Message-Id: <1127246178.14569.143.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-09-20 at 15:35 -0400, Ivan Gyurdiev wrote:
> >How useful is it to wrap these libsepol interfaces with libsemanage?
> >  
> >
> What do you mean?
> 
> The alternative is to either:
> - implement the same interfaces in both places (which is worse), or
> - have semanage functions take sepol data stuctures as arguments (which 
> is bad design practice).

- keep the shared libsepol, and have applications use its interfaces
directly.

> I don't think the current scheme is too bad - esp. because the wrap 
> functions are inlined.

That's what makes it seem so pointless.  If the wrap functions weren't
inlined and actually added some semantics around the libsepol
implementation, then they might make sense.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
