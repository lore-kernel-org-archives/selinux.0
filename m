Subject: Re: Loading things into policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <43559474.1080905@cornell.edu>
References: <43559474.1080905@cornell.edu>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 13:20:38 -0400
Message-Id: <1129742438.2375.236.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-10-18 at 20:33 -0400, Ivan Gyurdiev wrote:
> So, I have a question regarding customizations to policy.
> 
> I plan to support those functions in all databases:
> add() - add a new thing, or fail if it exists
>            (maybe add a configurable parameter saying whether we should 
> fail, or only warn if it exists)
> modify() - add a new thing, or modify it if it exists
> 
> In addition, I'm thinking of adding:
> set() - modify a thing, but don't add it if it doesn't exist (for booleans).

add() and set() as described above seem to be fundamental primitives;
modify() seems optional as it can be constructed by the caller from the
other two, i.e. if (add() < 0 && errno == EEXIST) { set(); }.

> Which of those functions should be used to load things into policy?  
> Should the load function be configurable per database? That way we can 
> specify whether each database allows overrides of the in-policy 
> defaults, or adding new things..etc.
> 
> For example, for ports only additive changes make sense to me, so we 
> could make add() as the default load function. For booleans we want 
> set() to be the default function...etc.. Maybe for users we want to 
> allow overrides as well?

I'm not clear on why you wouldn't support overrides for ports,
particularly as the base policy maps everything else left unspecified in
the reserved port range to reserved_port_t.  You might argue that should
be moved out of the base module and into the local file, but I expect
some people will need to override the base module port contexts for
specific needs no matter how much we prune it.  User overrides also can
make sense, e.g. some people may want to strip root of sysadm_r

> Should I even support all of them at the sepol layer? It might be 
> simpler to just support the one that gets used for loading in sepol, 
> since policy modifications will be done by rebuilding the policy anyway, 
> so a single load function will be used for modifications. Then 
> libsemanage could support the others on the flat file (but the 
> modification gets applied to policy by rebuilding, and calling the 
> default load function). Thoughts?

libsemanage links and expands the modules yielding a policydb, and then
libsemanage mutates the policydb via libsepol for local customizations,
and then libsemanage writes out the final binary policy image via
sepol_policydb_write.  So you still have to have the appropriate
modifiers available via libsepol to manipulate the in-memory policydb.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
