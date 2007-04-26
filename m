Subject: Re: [POLICYREP PATCH] Add generic iterators and a list data type
	to libsepol
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov
In-Reply-To: <1177595383.24282.329.camel@moss-spartans.epoch.ncsc.mil>
References: <20070420133430.9884.86379.stgit@localhost.localdomain>
	 <1177432926.24282.176.camel@moss-spartans.epoch.ncsc.mil>
	 <1177530561.14349.0.camel@localhost.localdomain>
	 <462FBE8A.30308@manicmethod.com>
	 <1177588173.24282.267.camel@moss-spartans.epoch.ncsc.mil>
	 <4630AC81.6090709@manicmethod.com>
	 <1177595383.24282.329.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 15:24:09 -0400
Message-Id: <1177615449.3405.45.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-26 at 09:49 -0400, Stephen Smalley wrote:
> On Thu, 2007-04-26 at 09:43 -0400, Joshua Brindle wrote:

<snip>

> > >>> Merged as libsepol 2.0.4.
> > >>>   
> > >>>       
> > >> shouldn't this be 2.1.4 or similar since 2.0.4 will be the next revision 
> > >> of trunk?
> > >>     
> > >
> > > It doesn't actually matter, as we can update the version just before
> > > merging to trunk.
> > >
> > >   
> > but if we ever roll up rpm's for testing this branch it will be 
> > undesirable to have overlapping versions.
> 
> I'm not sure why one would ever do that (roll up rpms, vs. just make
> install install-pywrap relabel).
> 
> Changing the {VERSION, ChangeLog} on the branch will also prevent clean
> merges from the trunk.
> 

This part was compelling to me (the merging) so I removed the version
change completely and the changelog entries.

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
