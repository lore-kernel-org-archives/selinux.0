Subject: Re: [PATCH 0/6] Drop legacy boolean/users support (setlocaldefs)
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
In-Reply-To: <1177601905.24282.354.camel@moss-spartans.epoch.ncsc.mil>
References: <1177594803.24282.322.camel@moss-spartans.epoch.ncsc.mil>
	 <4630C527.50100@manicmethod.com>
	 <1177601905.24282.354.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 26 Apr 2007 12:28:21 -0400
Message-Id: <1177604901.3405.13.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-04-26 at 11:38 -0400, Stephen Smalley wrote:
> On Thu, 2007-04-26 at 11:28 -0400, Joshua Brindle wrote:
> > Stephen Smalley wrote:
> > > The following patch series completely removes the legacy support for
> > > local boolean and user definitions (setlocaldefs) from libsepol and
> > > libselinux and updates libsemanage and policycoreutils for the resulting
> > > interface changes and removals.  As such, it requires bumping the .so
> > > versions, which has already been done on the policyrep branch (and these
> > > patches are therefore intended to be applied there first, and then
> > > merged to trunk later along with the policyrep work).
> > >
> > >   
> > Hrm, it doesn't seem appropriate to merge things entirely unrelated to 
> > the policyrep branch into that branch just because the soversion was 
> > bumped there. Karl, what do you think about this?
> 
> The alternative is to apply it in a separate branch and merge them
> separately to trunk or merge them together later and then to trunk.
> Seems less painful to get it all done together, only bump the .so
> version once, and avoid conflicts a priori by keeping it within a single
> devel branch.
> 
> So, at worst, the branch is ill-named ;)
> 

I'm fine with mixing them - I thought that the plan from the beginning
was to break compatibility once.

Karl


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
