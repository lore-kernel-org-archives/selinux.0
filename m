Subject: Re: I think this is equivalent to what we have
	now	and	more	efficient.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve Grubb <sgrubb@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200702251436.38681.sgrubb@redhat.com>
References: <45DDAA80.80603@redhat.com>
	 <200702221156.49050.sgrubb@redhat.com>
	 <1172234092.14363.468.camel@moss-spartans.epoch.ncsc.mil>
	 <200702251436.38681.sgrubb@redhat.com>
Content-Type: text/plain
Date: Mon, 26 Feb 2007 08:55:36 -0500
Message-Id: <1172498136.19041.198.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-02-25 at 14:36 -0500, Steve Grubb wrote:
> On Friday 23 February 2007 07:34:52 Stephen Smalley wrote:
> > So I suppose we need to retain the getcon() test.  Or institute a more
> > direct test of whether policy is loaded, e.g. new selinuxfs node that is
> > accessible to all so that it can always be read to see whether policy
> > has been loaded.
> 
> What about /selinux/policyvers ? When selinux is disabled, it does not exist. 
> When its enabled, should it tell you the version of policy that was 
> successfully loaded?

Presently it always returns the maximum policy version supported by the
kernel for use both for the initial policy load by /sbin/init and by
subsequent policy reloads.  Changing it to return the actual policy
version loaded upon the first policy load by /sbin/init would then force
all subsequent policy reloads to stay with that version even if a newer
policy toolchain and policy had been installed, until the next reboot.
I think we'd want a separate selinuxfs node for that purpose to avoid
ambiguity between the presently loaded version and the maximum supported
one.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
