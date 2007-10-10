Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l9AIDloF032449
	for <selinux@tycho.nsa.gov>; Wed, 10 Oct 2007 14:13:47 -0400
Received: from web36603.mail.mud.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l9AIDk6h022890
	for <selinux@tycho.nsa.gov>; Wed, 10 Oct 2007 18:13:46 GMT
Date: Wed, 10 Oct 2007 09:25:13 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: Are the reference policy abstractions the right ones?
To: Karl MacMillan <kmacmillan@mentalrootkit.com>, jwcart2@tycho.nsa.gov
Cc: SELinux <selinux@tycho.nsa.gov>, Steve Smalley <sds@epoch.ncsc.mil>
In-Reply-To: <1192028999.2898.19.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <126332.7972.qm@web36603.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Karl MacMillan <kmacmillan@mentalrootkit.com> wrote:


> Let me ask a different question. Both the old example policy and the
> reference policy accomplish the same basic thing: comprehensive
> least-privilege. The challenge with this approach is that the policy is
> closely tied to applications and brittle in the face of application
> changes.
> 
> So - are there other useful approaches that we could take? Some modified
> form of integrity policies like BIBA?

Biba (It's a name, not an acronym) has been used to effect in other
systems. Since you already have Bell&LaPadula implemented adding
Bida should be the work of an afternoon. We found that in real world
use it degenerated to a binary integrity policy pretty quickly, with
system integrity and user integrity being the only values that actually
got used. There appear to be more granularity advocates about these
days, however, so it might prove useful.

> Perhaps just for portions of the
> policy - things like hal/udev that are basically in the TCB but need to
> be protected from applications.

Explicitly and directly protecting the TCB is a good thing in
my view, although I think that it runs a bit counter to the TE
philosophy.

> Seems like a long-shot, but I thought I would ask.

A Biba integrity component, like a Bell & Lapadula sensitivity
component, ought not to be strictly necessary in a TE system. The
grand promise of TE is that such schemes are unnecessary with the
proper definition of domains. I think that the current introspection
on the policy abstraction is very well founded and that the
observations being made should be taken seriously.

I have long been of the opinion that the policy should be designed
and the applications fit into the policy rather than accepting the
behavior of applications as proper and crafting a policy that allows
for that behavior. It's the same distinction as creating a test suite
from a specification and redirecting a program's output into a file
and calling that the reference results. We can quibble about the 
degree to which each approach has been used on any given program
or subsystem, but I don't think anyone would claim the the reference
policy has an overall design. I didn't find one on the Tresys site.



Casey Schaufler
casey@schaufler-ca.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
