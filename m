Subject: Re: [ SEMANAGE ] Install seusers, rename some files
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: SELinux-dev@tresys.com, SELinux@tycho.nsa.gov, dwalsh@redhat.com
In-Reply-To: <4367DA3C.3020308@cornell.edu>
References: <4366C114.9080708@cornell.edu>
	 <1130875837.22731.289.camel@moss-spartans.epoch.ncsc.mil>
	 <4367D13A.1050305@cornell.edu>
	 <1130877661.22731.308.camel@moss-spartans.epoch.ncsc.mil>
	 <4367DA3C.3020308@cornell.edu>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 16:08:39 -0500
Message-Id: <1130879319.22731.316.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-11-01 at 16:12 -0500, Ivan Gyurdiev wrote:
> Dan, can you add such a script?
> 
> - copy /etc/selinux/?/seusers into /etc/selinux/?/modules/active/seusers
> - copy /etc/selinux/?/local.users into 
> /etc/selinux/?/modules/active/users.local [ renamed ]
> - copy /etc/selinux/?/booleans.local into 
> /etc/selinux/?/modules/active/booleans.local
> - install base module into /etc/selinux/?/modules/active/base.pp (is 
> this managed by rpm?)

For the last one, you can just do a semodule -b base.pp, and let
libsemanage handle it.  The module API already allows for such
installation of the modules, unlike the local APIs.  And while we could
add local APIs for installing an entire local file as a single
operation, I don't see the point since this only needs to happen for
migration purposes.

> > Yes.  But we need to avoid breaking use of semodule -b now via this
> > patch until such a time as the seusers support is in place, so possibly
> > I should just change the error handling here to just WARN and proceed
> > with the reload.
> Hmm... that sounds reasonable... I think.

Ok, that's what I will do for now.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
