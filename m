Subject: Re: Incorrect comment or toolchain problem in refpolicy
	policy/modules/kernel/kernel.te?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ryan Bradetich <rbradetich@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <e739902b0703171534x795e8802jeec1427f63043df7@mail.gmail.com>
References: <e739902b0703171534x795e8802jeec1427f63043df7@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 09:28:50 -0400
Message-Id: <1174310930.22565.39.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2007-03-17 at 15:34 -0700, Ryan Bradetich wrote:
> Hello All,
> 
> I found the following comment in the kernel.te refpolicy module:
> 
> # These initial sids are no longer used, and can be removed:
> 
> So naturally, I attempted to remove the sids ... but I got the
> following error when compiling the policy:
> 
> Compiling refpolicy policy.21
> /usr/bin/checkpolicy policy.conf -o policy.21
> /usr/bin/checkpolicy:  loading policy configuration from policy.conf
> libsepol.policydb_load_isids: SID (null) was never defined
> make: *** [policy.21] Error 1
> 
> I do go through all the sids and commented each one out individually
> to see if there was a subset that could be removed.   What I found is
> that if any of the sids were removed, it caused a compile error.
> 
> Is the comment in the module incorrect?  Or is this a toolchain problem?

The initial SIDs are declared in the flask/ files, then mapped to
contexts by the definitions in refpolicy.  Removing them would require
removing them from both places _and_ regenerating the kernel headers
_and_ rebuilding the kernel if the removal affected the values of any
other initial SIDs (which it would if there are any other initial SIDs
that follow the removed ones in the declaration list).  Tight coupling
to the kernel, as with the class and permission definitions.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
