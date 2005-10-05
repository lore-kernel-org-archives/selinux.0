Subject: RE: [RFC][PATCH] New interface for loading policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: "'Ivan Gyurdiev'" <ivg2@cornell.edu>, selinux@tycho.nsa.gov,
   "'Daniel J Walsh'" <dwalsh@redhat.com>, SELinux-dev@tresys.com
In-Reply-To: <1128366074.26285.210.camel@moss-spartans.epoch.ncsc.mil>
References: <200510031440.j93EebYs015780@gotham.columbia.tresys.com>
	 <1128354097.26285.126.camel@moss-spartans.epoch.ncsc.mil>
	 <1128366074.26285.210.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 05 Oct 2005 10:10:19 -0400
Message-Id: <1128521419.24059.128.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2005-10-03 at 15:01 -0400, Stephen Smalley wrote:
> Updated patches for libselinux and load_policy below.  New interface
> takes the two flag arguments, as discussed.  load_policy defaults to
> loading local user definitions but preserving current boolean values
> (setlocaldefs=1, preservebools=1), but allows disabling either or both
> behaviors via -l and -b:
> -l	Suppress loading of local users.
> -b	Suppress preservation of current booleans.
> -lb	No modification of the binary policy file at all prior to load.
> 
> /sbin/init would call the interface with (setlocaldefs=1,
> preservebools=0), equivalent to load_policy -b as before.  However, note
> that this means that the init SELinux patch still has to change when the
> new infrastructure for regenerating binary policy files upon all policy
> changes is in place, to instead call the interface with
> (setlocaldefs=0,preservebools=0), equivalent to load_policy -lb.  That
> seems unfortunate, and could be avoided if we hid the setting of
> setlocaldefs within libselinux.  Possibly libselinux could determine
> setlocaldefs automatically based on an /etc/selinux/config setting, and
> we could just change that setting when the new infrastructure is in
> place?  Thereby removing it from the load interface and dropping down to
> just the preservebools flag there?

Hi,

In addition to the questions above re setlocaldefs, I wanted to raise
the issue of how libsemanage determines the binary policy version to use
when generating the new kernel policy prior to loading.  At present,
libsemanage uses the highest version supported by the libsepol against
which it was built by default, unless configured to use a different
version number in semanage.conf, which I've previously noted is already
problematic in practice (e.g. new libsepol often shows up before a
kernel that supports the new format does, and user may choose to
continue using an older kernel even when a newer kernel becomes
available).  Since these patches remove the policy path from the
interface and always determines the path internally (starting with the
latest policy version supported by the kernel and searching downward
until it finds a policy file with a version less than or equal to that
latest version), libsemanage should instead be generating a kernel
binary policy file with the latest version supported by the running
kernel, i.e. the one obtained via security_policyvers().  Any
objections?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
