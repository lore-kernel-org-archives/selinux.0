Subject: Re: [RFC] selinux-support (1.0.1) available
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1111759697.15280.53.camel@moss-spartans.epoch.ncsc.mil>
References: <1111704432.27644.62.camel@localhost.localdomain>
	 <1111759697.15280.53.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 25 Mar 2005 09:27:08 -0500
Message-Id: <1111760828.15280.65.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-03-25 at 09:08 -0500, Stephen Smalley wrote:
> Can you explain the purpose of this package?  I'm not sure I understand
> what you mean, or why the above packages would depend on it.  What is
> the purpose of the /etc/selinux.conf file in this package, and how does
> it compare to the already existing /etc/selinux/config file that is
> being used by libselinux and various scripts?  Do you expect this to
> remain Ubuntu-specific?

Another question is how are you handling the SELinux-patched userspace
in Ubuntu?  Integrated into the main packages as in Fedora or a separate
set of packages like Russell Coker's current packages for Debian?  The
former is obviously preferable if possible.

Note that you should check the latest SELinux userspace patches from the
Fedora CVS tree, as they have continued to evolve.  Note that there are
now two separate SELinux-related patches for sysvinit in the Fedora CVS
tree, sysvinit-selinux.patch and sysvinit-2.85-selgenusers.patch, where
the latter patch was a more recent change to support pulling in
local.users at policy load time without requiring a policy rebuild.
Also note that in some cases, SELinux support has gone into the main
sources in the Fedora packages and is no longer a separate patch at all
(or if a patch exists, it is a refinement of the original SELinux
support rather than the complete SELinux support), e.g. for libuser,
logrotate, passwd, prelink, etc.

-- 
Stephen Smalley <sds@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
