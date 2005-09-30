Message-Id: <200509301453.j8UEriYs008728@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: "'Stephen Smalley'" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Cc: "'Daniel J Walsh'" <dwalsh@redhat.com>,
   "'Ivan Gyurdiev'" <ivg2@cornell.edu>, <SELinux-dev@tresys.com>
Subject: RE: [RFC][PATCH] New interface for loading policy
Date: Fri, 30 Sep 2005 10:53:44 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <1128028816.27495.182.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> -----Original Message-----
> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> Sent: Thursday, September 29, 2005 5:20 PM
> To: selinux@tycho.nsa.gov
> Cc: Daniel J Walsh; Ivan Gyurdiev; SELinux-dev@tresys.com
> Subject: [RFC][PATCH] New interface for loading policy
> 
> Hi,
> 
> In the past, there have been discussions about the need to migrate more
> of the policy loading logic that currently resides in init and
> load_policy into a higher level libselinux function than the current
> security_load_policy(3) interface.  This will allow us to evolve that
> logic more easily, without needing to re-patch init each time (as was
> done first for the booleans and then for local users) as well as
> eliminating code duplication.
> 

This will be an interface in addition to the current interface, correct?

> Below are sample patches for libselinux and policycoreutils to implement
> a new selinux_mkload_policy(3) interface and to rewrite load_policy to
> use it.  Since load_policy presently requires that you specify the
> policy file path as an argument, I retained support for specifying the
> path in the interface, without requiring it, with load_policy warning on
> the old usage but continuing to accept it.  I did however drop the
> support for specifying a booleans file other than the default location
> entirely, as it was optional and doesn't seem to be used in practice.  I
> also retained the ability to specify whether booleans should be
> preserved across a load or reset to the policy settings in the interface
> for use by load_policy (on policy updates, when you don't want to
> disturb the active boolean settings).
> 
> However, at least the support for specifying the policy path doesn't
> seem likely to survive when the policy server is introduced.  Hence, I
> was wondering if I should just drop it now.  In that case, we need to
> decide whether load_policy will just warn about the old usage but
> proceed to load the active policy (so that current users aren't broken)
> or warn and fail in that case.
> 

It depends on whether the policy server will use this interface or the
existing security_load_policy internally to load policy. If it will use
selinux_mkload_policy then it will need to be able to specify the path I
think. This is especially important if the policy server will be generating
different policies for the kernel and one or more userspace security
servers.

Karl 

------
Karl MacMillan
Tresys Technology
http://www.tresys.com

> Comments?
> 
> --
> Stephen Smalley
> National Security Agency



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
