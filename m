Subject: Re: New patch for libselinux
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <44982C2C.5050405@redhat.com>
References: <4497FCCF.1030805@redhat.com>
	 <1150812243.17557.79.camel@moss-spartans.epoch.ncsc.mil>
	 <44981564.9020106@redhat.com>
	 <1150822180.17557.141.camel@moss-spartans.epoch.ncsc.mil>
	 <44982C2C.5050405@redhat.com>
Content-Type: text/plain
Date: Tue, 20 Jun 2006 13:33:53 -0400
Message-Id: <1150824833.17557.180.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-06-20 at 13:11 -0400, Daniel J Walsh wrote:
> Stephen Smalley wrote:
> > I don't think we want to directly export
> > selinux_compare_context_without_user(), or if we do, we want it
> > abstracted in some manner that covers the general case.
> >
> >   
> We are using similar functions in restorecon and I think somewhere else, 
> so I thought
> it would be good to move it into libselinux.

Possibly, but _without_user is too much detail for the caller.  Caller
just wants some function that indicates equivalence (for some definition
of equivalence).  

> Not sure what you mean, You still have the other functions to use.   The 
> idea with this
> function is to compare a files on disk context with the system 
> defaults.  You could also use
> matchpathcon_init before calling this function to change the default 
> file context file?

Actually, I suppose at the point of verification, you already have the
module policy installed and integrated into the system file_contexts
file, so matchpathcon() should work.  I was thinking that rpm would have
to pass in the context originally obtained from the package header (and
saved in the rpm database?) instead.  But that should always match the
result yielded from matchpathcon once the module's .fc has been merged.

> I also want to define a function
> 
> selinux_setdefault_filecon(file)
> 
> Which would do matchpathcon/setfilecon under the covers, and do the 
> appropriate turn off translations stuff.
> Since this code is propulgating into a series of programs.  (install, 
> MAKEDEV, kadmin?, and Nautilus, restorecon and probably others.)

selinux_lsetfilecon_default(const char *path)?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
