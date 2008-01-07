Subject: Re: cant SSH/Console Login and no deny/error messages
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Jeremiah Jahn <jeremiah@goodinassociates.com>
Cc: selinux@tycho.nsa.gov, "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Joshua Brindle <method@manicmethod.com>
In-Reply-To: <1198704909.4073.858.camel@bluejay.goodinassociates.com>
References: <1198704909.4073.858.camel@bluejay.goodinassociates.com>
Content-Type: text/plain
Date: Mon, 07 Jan 2008 08:57:02 -0500
Message-Id: <1199714222.2944.122.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2007-12-26 at 15:35 -0600, Jeremiah Jahn wrote:
> I've trying to get SELinux strict up and running on a RHEL4-U4 box and
> not having much luck. I have one account and 3 programs that I need to
> protect from root. I was unable to get targeted to login under the user
> that I created, something about the policy always defaulting to user_u.
> So Fine, I tried to install the strict/ref policy from the tresys and
> cips. Dues to this being an x86_64 system, that didn't go well either.
> Trying plan C  I went with the FC3 strict policy. Obviously some
> improvemtns have been made since then, but this was the first strict
> policy I was able to install without completely hosing my system. sshd
> and login seem to really like having libselinux(64) around. 
> 
> 
> So my question here has to possible answers:
> 
> 1) where the heck can I find some rpms for RHEl4 -x86_64 and the most
> recent ref policy.

I think what some people do is to install the latest SELinux userland
into a private directory (rather than overwriting the RHEL4 provided
ones), and then when building policy, set PATH and LD_LIBRARY_PATH to
refer to that private directory, and configure semanage.conf to generate
the kernel policy version supported by the RHEL4 kernel.  That lets them
use e.g. modular policy, semanage, etc for managing policy, without
breaking dependencies of RHEL4 userland on the old libselinux for other
things.

We don't provide binary rpms of the SELinux userland, only source
tarballs.

> --OR--
> 
> 2) what could possibly be causing no [avc denied] messages to be logged.
> Most of the messages I have used with audit2allow to to try and get
> everything to work. Finally I go to the point of having no more messages
> even when rebooting the machine. If I put things into passive mode
> still no more messages, this is with constant reloading of the policy to
> clear the avc cache. 
> 
> help please.

There is the 'make clean enableaudit load' trick to remove all dontaudit
statements from the policy.

There are also certain denials that aren't audited at all in the RHEL4
kernel due to implementation issues that have since been resolved in
later kernels (such as the one used in RHEL5).  In particular,
capability checks on netlink messages.

Having gone down this path myself before, I recall one problem with
using the FC3 strict policy for RHEL4 was the introduction of the audit
system in RHEL4, leading to a requirement for the audit_write and/or
audit_control capabilities for all login-related programs.  I had to
back port those changes from a later version of the example policy.  But
you likely are better off using the refpolicy with build.conf DISTRO set
to rhel4 as your starting point than the FC3 strict policy.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
