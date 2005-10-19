Subject: Re: Loading things into policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
In-Reply-To: <1129742438.2375.236.camel@moss-spartans.epoch.ncsc.mil>
References: <43559474.1080905@cornell.edu>
	 <1129742438.2375.236.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 13:31:47 -0400
Message-Id: <1129743107.2375.242.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-10-19 at 13:20 -0400, Stephen Smalley wrote:
> On Tue, 2005-10-18 at 20:33 -0400, Ivan Gyurdiev wrote:
> > Should I even support all of them at the sepol layer? It might be 
> > simpler to just support the one that gets used for loading in sepol, 
> > since policy modifications will be done by rebuilding the policy anyway, 
> > so a single load function will be used for modifications. Then 
> > libsemanage could support the others on the flat file (but the 
> > modification gets applied to policy by rebuilding, and calling the 
> > default load function). Thoughts?
> 
> libsemanage links and expands the modules yielding a policydb, and then
> libsemanage mutates the policydb via libsepol for local customizations,
> and then libsemanage writes out the final binary policy image via
> sepol_policydb_write.  So you still have to have the appropriate
> modifiers available via libsepol to manipulate the in-memory policydb.

Ah, sorry, I didn't understand your question.  Yes, given that you are
always "loading" entries from the local files into an existing policydb,
where "loading" constitutes either an add-or-modify (most kinds of
records) or a modify-only-if-exists (boolean records), it makes sense
for libsepol to only support a single interface per record type for this
operation.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
