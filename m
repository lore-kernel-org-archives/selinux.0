Subject: Re: [PATCH] libsemanage: free policydb before fork
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@manicmethod.com>
Cc: SE Linux <selinux@tycho.nsa.gov>, Todd Miller <tmiller@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <47A6367F.5040609@manicmethod.com>
References: <47A5311F.2020703@manicmethod.com>
	 <47A6367F.5040609@manicmethod.com>
Content-Type: text/plain
Date: Mon, 04 Feb 2008 08:47:29 -0500
Message-Id: <1202132849.3070.28.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sun, 2008-02-03 at 16:47 -0500, Joshua Brindle wrote:
> Joshua Brindle wrote:
> > While testing the recent memory-related patches on a low memory machine 
> > (512m total) I found that semodule still failed. It turns out that 
> > fork() requires enough free ram for the amount of private dirty memory 
> > in the parent process to succeed (even if it is never written to in the 
> > child process). This patch moves the genhomedircon call to outside of 
> > semanage_sandbox_install so that the policydb can be freed before any 
> > forks happen. With this patch and the prior ones semodule runs fine on a 
> > 512m machine.
> > 
> > Signed-off-By: Joshua Brindle <method@manicmethod.com>
> > 
> 
> Interestingly this works sometimes and not others. I suppose it depends
> on whether the libc allocator feels like giving up the memory when we
> free the policydb or not. I am not sure what the best way to address
> this is, any ideas?

First, slightly unrelated, am I correct that only your patch for
consuming base has been merged and not my two patches thus far?  I'd
like to get those two merged before we do anything further.  Should I
commit them?  Looks like there is a minor conflict that I'll have to
resolve against your patch.

Second, have we considered dropping the separate execution of the
load_policy program and just directly invoking the libselinux function
for loading policy from libsemanage?  Might require a policy change to
allow semodule to load policy directly.

Then there is the separate execution of setfiles -c to validate the file
contexts configuration against the policy.  But that too could possibly
be replaced by direct calls to the relevant library functions.

We've encapsulated almost all of the load policy and setfiles logic in
libselinux these days, so it doesn't seem hard to eliminate the use of
separate helpers there.  And since semodule is writing out the kernel
policy file that will be loaded, we aren't actually protecting against
anything by keeping load_policy in a separate domain (this is all under
direct method, of course).

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
