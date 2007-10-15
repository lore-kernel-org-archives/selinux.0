Subject: Re: checkmodule and MLS/MCS support
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>
In-Reply-To: <4712657A.5010105@manicmethod.com>
References: <200710142206.29369.russell@coker.com.au>
	 <4712657A.5010105@manicmethod.com>
Content-Type: text/plain
Date: Mon, 15 Oct 2007 09:57:03 -0400
Message-Id: <1192456623.29203.14.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-10-14 at 14:52 -0400, Joshua Brindle wrote:
> Russell Coker wrote:
> > http://ramblingfoo.blogspot.com/2007/10/selinux-mlsmcs-support.html
> >
> > Given that everyone who is working on SE Linux seems to be working on MCS and 
> > MLS systems, would it make sense to have the default checkmodule operation be 
> > to generate modules for MLS/MCS policy?
> >   
> 
> Changing defaults is a bad idea. Gentoo, for example, builds policy on 
> end systems. Things would all of a sudden blow up on every policy 
> installation if the default changed.

True, but it does seem a bit unfortunate that one has to invoke it with
-M and -m for the common case.  audit2allow is another example where the
current default behaviors are no longer what we actually want as the
defaults.

I'd think that checkmodule could easily auto-detect base vs. non-base
from inspection of the source module, and could possibly auto-detect MLS
vs. non-MLS in a similar manner, even if only by using some syntactic
sugar pulled in via policy_module().

Although today that is all handled via the policy devel Makefile, right,
so the user just does a 'make -f /usr/share/selinux/devel/Makefile
foo.pp' and lets the Makefile figure out what options to enable as well
as hiding the multiple stages.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
