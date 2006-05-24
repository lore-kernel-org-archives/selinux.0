MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [RFC][PATCH] selinux:  introduce support for deferred mappingof inode security contexts
Date: Wed, 24 May 2006 13:36:21 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B01588170A74@exchange.columbia.tresys.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Jeremy Katz" <katzj@redhat.com>, "Stephen Smalley" <sds@tycho.nsa.gov>
Cc: <selinux@tycho.nsa.gov>, "selinux-dev" <selinux-dev@tresys.com>,
        "Paul Nasrat" <pnasrat@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Jeremy Katz [mailto:katzj@redhat.com] 
> 
> On Tue, 2006-05-23 at 13:15 -0400, Stephen Smalley wrote:
> > Below is an updated version of the kernel patch to support rpm 
> > labeling of files before policy load, with a couple of bug 
> fixes and a 
> > re-base to 2.6.17-rc4-mm3.  Note that before we can 
> upstream this, we 
> > need to resolve the issues of how rpm will check file label 
> validity 
> > after policy load (e.g. calling security_check_context(3) on each 
> > label from the header), what corrective action rpm will 
> take if a file 
> > label is invalid (options suggested include relabeling to 
> unlabeled_t, 
> > relabeling to the context returned by the system policy via 
> > matchpathcon, or reverting the install), and the issues 
> raised by Karl 
> > above (as they also affect the ability of rpm to perform such 
> > verification and correction sanely).
> 
> Well, given that the only labels that will end up in a header 
> will be from a policy in that package, I'm still not really 
> convinced what adding a verification step _really_ accomplishes.  
> 

There are a number of reasons the policy module insertion can fail. The
package and the base being out of sync, for example as we saw last week.
The policy server (when its deployed) denying the policy addition.
Assertion violations, hierarchical assertion violations, mutual
dependancies between modules (which you will hit btw, since you are
installing them one at a time), conflicting modules, the list goes on.

By leaving bogus labels on the filesystem you add an attack vector where
future (possibly legitimate) policy can change the behavior of the
on-disk labels (transisions, etc). Further the application you just laid
down will probably be unusable. Even if unconfined_t can execute the
unlabeled apps other labels may be affected. For example, if passwd gets
laid down with a bogus label and an unconfined user runs it (in
unconfined_t since there won't be a transition) then the shadow label
will be lost and the shadow file will be accessible to confined domains
(eg., apache).



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
