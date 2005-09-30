Subject: RE: [RFC][PATCH] New interface for loading policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Karl MacMillan <kmacmillan@tresys.com>
Cc: selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Ivan Gyurdiev'" <ivg2@cornell.edu>, SELinux-dev@tresys.com
In-Reply-To: <200509301453.j8UEriYs008728@gotham.columbia.tresys.com>
References: <200509301453.j8UEriYs008728@gotham.columbia.tresys.com>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 10:59:26 -0400
Message-Id: <1128092366.12459.145.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2005-09-30 at 10:53 -0400, Karl MacMillan wrote:
> This will be an interface in addition to the current interface, correct?

Yes, security_load_policy(3) will still be available.  Just not used
directly any more by init or load_policy, but potentially could be used
by others if they want the low level interface.

> It depends on whether the policy server will use this interface or the
> existing security_load_policy internally to load policy. If it will use
> selinux_mkload_policy then it will need to be able to specify the path I
> think. This is especially important if the policy server will be generating
> different policies for the kernel and one or more userspace security
> servers.

Hmm...at present, libsemanage installs the binary policy to the standard
location and then invokes load_policy in direct mode, right?  Is there a
reason the policy server would operate differently?
selinux_mkload_policy is purely for the kernel policy; it will be used
by init for the initial policy load.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
