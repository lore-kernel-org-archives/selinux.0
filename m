Subject: Re: Current/Future Plans to Support Stacking LSM Modules
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Tom Fortmann <tfortmann@xcapesolutions.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <002701c73999$4a9fe1c0$030a0a0a@ACER>
References: <002701c73999$4a9fe1c0$030a0a0a@ACER>
Content-Type: text/plain
Date: Tue, 16 Jan 2007 13:27:10 -0500
Message-Id: <1168972030.22731.129.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-01-16 at 12:08 -0600, Tom Fortmann wrote:
> Are their any current or future plans to support stacking additional
> security modules on the LSM interface?

That's more of a question for linux-security-module rather than this
list.  We don't have any plans to introduce such support to LSM, as we
think it is a bad idea.  Last time it came up (at 2006 kernel summit),
that seemed to be the consensus view.

> Alternatively, are there any current or future plans to allow the
> SELinux framework to be expanded with third party loadable modules?

Not loadable modules, no.  But adding further security models to the
SELinux security server or extending the ones that are already there is
certainly open to discussion, if a case can be made for it.  However,
you may find that the existing models are sufficient to support the
right set of goals at the kernel level, and then you can build
additional infrastructure in userspace without needing to modify the
kernel's model.

> We are working on some enhanced security solutions that require access
> to the LSM interface, but we do not want to preclude the use of
> SELinux by our customers.

What do you need that you can't obtain from SELinux or other kernel
subsystems (e.g. audit) today?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
