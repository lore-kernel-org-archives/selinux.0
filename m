Subject: Re: [POLICYREP PATCH] Add generic iterators and a list data type
	to libsepol
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Karl MacMillan <kmacmillan@mentalrootkit.com>, selinux@tycho.nsa.gov
In-Reply-To: <462FBE8A.30308@manicmethod.com>
References: <20070420133430.9884.86379.stgit@localhost.localdomain>
	 <1177432926.24282.176.camel@moss-spartans.epoch.ncsc.mil>
	 <1177530561.14349.0.camel@localhost.localdomain>
	 <462FBE8A.30308@manicmethod.com>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 07:49:33 -0400
Message-Id: <1177588173.24282.267.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-04-25 at 16:48 -0400, Joshua Brindle wrote:
> Karl MacMillan wrote:
> > On Tue, 2007-04-24 at 12:42 -0400, Stephen Smalley wrote:
> >   
> >> On Fri, 2007-04-20 at 09:34 -0400, Karl MacMillan wrote:
> >>     
> >>> Add a generic iterator data structure and a linked-list implementation
> >>> based that uses the iterators to libsepol. Includes test cases for the
> >>> linked-list implementation.
> >>>
> >>> This version is updated to remove improper use of void** based on comments 
> >>> from James Antill.
> >>>
> >>> Signed-off-by: Karl MacMillan <kmacmillan@mentalrootkit.com>
> >>>       
> >> For the entire policyrep patch series so far,
> >>
> >> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> >>
> >> Merge at will.
> >>
> >>     
> >
> > Merged as libsepol 2.0.4.
> >   
> shouldn't this be 2.1.4 or similar since 2.0.4 will be the next revision 
> of trunk?

It doesn't actually matter, as we can update the version just before
merging to trunk.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
