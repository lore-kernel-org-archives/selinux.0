Subject: Re: Problem with semodule mls policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Russell Coker <rcoker@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <44183A48.7010005@tresys.com>
References: <44182410.1030003@redhat.com>
	 <1142434901.29737.63.camel@moss-spartans.epoch.ncsc.mil>
	 <44183A48.7010005@tresys.com>
Content-Type: text/plain
Date: Wed, 15 Mar 2006 11:35:39 -0500
Message-Id: <1142440539.4933.6.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-03-15 at 11:01 -0500, Joshua Brindle wrote:
> Stephen Smalley wrote:
> > On Wed, 2006-03-15 at 09:26 -0500, Daniel J Walsh wrote:
> >> How do I get semodule to create policy.20 at SystemHigh and everything 
> >> other files at SystemLow?
> > 
> Why do we want policy.20 at SystemHigh again? The only scenerio I can 
> think of is the user->role mappings but who will be using those rather 
> than seuser mappings? For that matter, seuser file should probably be at 
> SystemHigh...

Possibly local customizations are in view here, e.g. the contents of
interfaces.local, that are then fed into the final policy.20 emitted by
libsemanage?  seusers is the more likely concern, as you note, and it is
harder to transparently label it separately since it doesn't live in its
own dedicated subdirectory (so range_transition wouldn't help with it;
you'd need libsemanage code modification).
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
