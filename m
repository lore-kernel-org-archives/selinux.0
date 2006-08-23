Subject: Re: [patch] libselinux:  do not set compat_net upon policy load
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, Darrel Goeddel <dgoeddel@TrustedCS.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        James Morris <jmorris@namei.org>
In-Reply-To: <1156361845.4242.18.camel@twoface.columbia.tresys.com>
References: <1156360389.8506.100.camel@moss-spartans.epoch.ncsc.mil>
	 <1156361845.4242.18.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 15:48:34 -0400
Message-Id: <1156362514.8506.108.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-08-23 at 15:37 -0400, Joshua Brindle wrote:
> On Wed, 2006-08-23 at 15:13 -0400, Stephen Smalley wrote:
> > Revert the change to automatically set /selinux/compat_net at policy
> > load time based on the policy, as this prevents compat_net from being
> > effectively used with refpolicy-based policies that include the packet
> > class definition.
> > 
> > Signed-off-by:  Stephen Smalley <sds@tycho.nsa.gov>
> > 
> 
> So it has to be set manually now? How does the setting persist?

The original idea was for it to be set manually, either via grub.conf
(if using the boot parameter) or via an rc script (if
using /selinux/compat_net).  I had modified libselinux to automatically
set it based on the policy (packet class definition) a while ago, but
that turns out to be a weak indicator and interferes with the ability of
people to force the system to use compat_net checks when using a modern
policy.  In particular, this is posing a problem for the LSPP effort,
see the redhat-lspp list.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
