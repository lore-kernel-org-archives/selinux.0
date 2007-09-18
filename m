Subject: Re: Change default error handling in libselinux matchpathcon
	to	use syslog instead of stderr.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <46F00E55.9030100@manicmethod.com>
References: <46EFF028.4040500@redhat.com> <46F0065B.1060101@manicmethod.com>
	 <1190136184.14037.54.camel@moss-spartans.epoch.ncsc.mil>
	 <46F00E55.9030100@manicmethod.com>
Content-Type: text/plain
Date: Tue, 18 Sep 2007 13:45:43 -0400
Message-Id: <1190137543.14037.77.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-09-18 at 13:43 -0400, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Tue, 2007-09-18 at 13:09 -0400, Joshua Brindle wrote:
> >   
> >> Daniel J Walsh wrote:
> >>     
> >>> -----BEGIN PGP SIGNED MESSAGE-----
> >>> Hash: SHA1
> >>>
> >>> Current behavior causes problems with network applications.
> >>>
> >>> https://bugzilla.redhat.com/show_bug.cgi?id=273081
> >>>   
> >>>       
> >> Wait, what?
> >>
> >> I don't think it is an improvement to call the command line matchpathcon 
> >> applications and have the logs go somewhere not visible by the user. IMO 
> >> we should take the same approach libsemanage and libsepol did where the 
> >> logging callbacks can be overridden by specific users of the library but 
> >> for the command line applications the output still goes to stderr.
> >>     
> >
> > You already can override the callback (set_matchpathcon_printf), but the
> > claim in the bug report is that isn't usable from a library function
> > that calls matchpathcon because it doesn't know whether it has already
> > been set by the application.
> >   
> 
> Hrm... so the alternative is to send it to syslog? I don't buy it. Can 
> we just add an interface to see if the default callbacks have been 
> overridden?

Yep.  And it should be based on the newer interfaces.  There is already
a selinux_set_callback() and adding a selinux_get_callback() should be
trivial.  setfiles is already rewritten to use the new interfaces in
trunk, and we should be moving everything off of matchpathcon and onto
selabel_lookup.

For RHEL 5, I suppose there might be a matchpathcon-specific interface
for getting the callback.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
