MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Need to break or reduce the dependency on a static libsepol
Date: Tue, 1 Apr 2008 08:24:51 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158801CD201C@exchange.columbia.tresys.com>
In-Reply-To: <1207051630.5610.125.camel@moss-spartans.epoch.ncsc.mil>
References: <1207051630.5610.125.camel@moss-spartans.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Cc: "Chad Sellers" <csellers@tresys.com>,
        "Karl MacMillan" <kmacmillan@tresys.com>,
        "Daniel J Walsh" <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> This is likely my fault, but we're encountering increasing
> problems from growth in the set of things that depend on the
> static libsepol whenever we make a change to libsepol,
> particularly a policy version change.  We now have (at least)
> the following dependencies on it:
> checkpolicy (always true, not likely to go away) libselinux
> (for the audit2why python binding module, which used to be
> its own utility in policycoreutils) setools
> 
> Does slide also have this dependency or is it clean? Anything else to
> worry about? 
> 
> The result is that when a newer libsepol gets incorporated
> and libselinux or setools does not, we encounter breakage
> (unable to find a policy file they can read or unable to read
> the policy file at which they are pointed) or confusion
> (reading an older policy file left around from before the
> libsepol update) upon trying to use audit2why or setools.
> 
> We ran into this problem twice in rawhide / F9, once upon the
> policy capability support (policy.22) and now for permissive types
> (policy.23). 
> 
> Only real way forward that I can see it to actually
> encapsulate the interfaces required by audit2why and setools
> so that they can use the shared libsepol.

One thing that we are doing for policyrep is encapsulating all the "add
this kind of thing to a policydb" functionality because we didn't want
policyrep users to be static libsepol users. 

This has multiple disadvantages including its huge, it is slow (7 hash
lookups to add an av rule currently, since its string based) and doesn't
include the other functionality like the security server, query
functions that would be required for audit2why and setools.

After going through that effort and seeing the pain first hand I
honestly think it is a better alternative to forgo encapsulation and
just make the policydb public. Not yet though, since we ripped out all
the module stuff in it for policyrep. Since it is returning to a more
pristine state that can't realistically change much in the future maybe
it would be better for everyone to rip out the encapsulation as well.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
