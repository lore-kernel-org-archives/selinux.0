Subject: Re: The new audit2allow.
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: "Brian M. Williams" <bwilliams@tresys.com>, selinux@tycho.nsa.gov,
        Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1187094627.26008.149.camel@moss-spartans.epoch.ncsc.mil>
References: 
	 <6FE441CD9F0C0C479F2D88F959B01588EDEA2F@exchange.columbia.tresys.com>
	 <1187094627.26008.149.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 15 Aug 2007 09:53:33 -0400
Message-Id: <1187186013.2674.40.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-08-14 at 08:30 -0400, Stephen Smalley wrote:
> On Mon, 2007-08-13 at 16:52 -0400, Brian M. Williams wrote:
> > I am having huge issues with the new audit2allow.  The new interface
> > matching is very hit or miss, the old audit2allow -R matched the correct
> > interface about as often even if it wasn't the correct way of doing
> > things.  The formatting is a major step back IMO.  Below are the old and
> > new output formats of the call audit2allow -v.  Note that the old -v
> > flag actually gave extra information; it gave the type of denial, the
> > audit number and was well formatted.  I am at a loss to find anything
> > useful -v gives now.  Also now just getting the -R flag to work
> > correctly by finding and installing the correct headers, figuring out
> > the correct place to put them and running some program to parse the
> > header files was enough of a hassle for me to not use that feature.  The
> > addition of a newer python dependency (the python now required for the
> > toolchain is not in RHEL4 and required an update), the huge pain it is
> > just to get it to work was not worth these changes to me.  Does anyone
> > know why these changes were made?
> 
> First, the "new" audit2allow was less about audit2allow than about
> sepolgen, i.e. introducing a python module that would be a basis going
> forward for more advanced policy generation work.  audit2allow was then
> just rewritten to use sepolgen.
> 
> Second, if there are specific regressions in the new audit2allow, then
> yes, those should be corrected.  Can you provide specific examples where
> interface matching is worse - those would be useful test cases going
> forward.  The -v output was never rigorously defined (they were just
> comment lines, after all, and just to help a human reader with
> supplemental information so that he wouldn't have to go back to the
> original audit message and correlate it), and I'm not sure how TYPE=AVC
> is helpful.  Retaining the audit serial number would likely be useful.
> 

Yes - please send me logs where you get unexpected results. Also - can
you explain more what you object to in the formatting. I made the
formatting change because I found the old formatting to be very
difficult to read. I'd be happy to change the formatting to something
that makes me happy and fans of the old way happy, but I need to
understand what you object to more clearly.

Other than the audit serial number, what would you like to see in the -v
output. Also, have you found the -e output that gives lots of
information?

> Third, requiring preparsing of the headers isn't onerous; in Fedora,
> invoking sepolgen-ifgen is handled automatically by the .spec files, and
> it allows errors to be caught sooner, and it avoids the overhead of
> parsing the full headers on every run of audit2allow.
> 

And this should be invokable by a standard user if that helps.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
