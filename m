Subject: Re: sepol_genusers
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov, Karl MacMillan <kmacmillan@tresys.com>
In-Reply-To: <42152EAB.8090600@redhat.com>
References: <1108656216.24494.65.camel@moss-spartans.epoch.ncsc.mil>
	 <42152EAB.8090600@redhat.com>
Content-Type: text/plain
Date: Fri, 18 Feb 2005 08:43:43 -0500
Message-Id: <1108734223.28149.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-02-17 at 18:54 -0500, Daniel J Walsh wrote:
> What should init do if local.users is missing?  Has bad data in it?  My 
> current patch panics the kernel and I don't think that
> is a great idea.   IE the user screws up the local.users file and we 
> can't boot.

The current sepol_genusers(3) logic should just skip invalid user
entries without returning an error, but does return errors in the cases
of:
- no system.users file
- no local.users file
- overly long line that was truncated (should likely be handled like
invalid user entries instead)
- out of memory while processing

Possibly we could change /sbin/init and load_policy to just load the
original binary policy image in the case where sepol_genusers(3) returns
an error, as it doesn't modify that image during processing - it just
creates a new image.




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
