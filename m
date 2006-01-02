Message-ID: <43B975B3.4000103@tresys.com>
Date: Mon, 02 Jan 2006 13:49:23 -0500
From: Joshua Brindle <jbrindle@tresys.com>
MIME-Version: 1.0
To: Ivan Gyurdiev <ivg2@cornell.edu>
CC: SELinux List <SELinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [SEMANAGE] Optional rebuild
References: <43AC5726.8090102@cornell.edu>
In-Reply-To: <43AC5726.8090102@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ivan Gyurdiev wrote:
> This patch uses the modified flags to skip a rebuild whenever possible.
> It also adds the active boolean header to semanage.h (which I missed 
> because of diff excludes).
> It will now commit changes to the active booleans, so if no policy 
> changes are done (modified = 0), or
> changes are done, but preservebools is enabled (which it is, by 
> default), then changes to active
> booleans in the transaction will work as expected, and will not be 
> overwritten by policy booleans.

I'm not sure I understand this. If preservebools is enabled the policy 
must be rebuilt. Looking at the patch it looks like you do rebuild when 
persistent booleans are changed though.
> 
> This is also an optimization - allows running commit without rebuilding 
> the policy, which could be beneficial for read-only operations using a 
> transaction - it also seems more correct, because a read-only operation 
> should not alter the state of the system - commit should not apply any 
> changes that weren't explicit.

A commit is by definition a write operation. The user is responsible for 
  not committing if there aren't any changes.

> 
> Note that semodule -B with no arguments will break, because now the 
> build will be skipped. I haven't fixed it yet, but I've added an 
> interface for that purpose - semanage_do_rebuild, to parallel 
> semanage_do_reload (but the default in this new function is 0 - no 
> rebuilds if no changes).
> 
I see that you already sent this patch but it's better not to break 
things with the intention of fixing them later.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
