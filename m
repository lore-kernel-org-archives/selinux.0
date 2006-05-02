MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: We are attempting once again to split policy out intoindividual RPMS.
Date: Tue, 2 May 2006 14:06:18 -0400
Message-ID: <6FE441CD9F0C0C479F2D88F959B0158816FEC4@exchange.columbia.tresys.com>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>, "Jeremy Katz" <katzj@redhat.com>
Cc: "Daniel J Walsh" <dwalsh@redhat.com>, "James Morris" <jmorris@redhat.com>,
        "selinux-dev" <selinux-dev@tresys.com>,
        "SE Linux" <selinux@tycho.nsa.gov>, "Paul Nasrat" <pnasrat@redhat.com>,
        "James Antill" <jantill@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Stephen Smalley [mailto:sds@tycho.nsa.gov] 
> 
> On Tue, 2006-05-02 at 12:26 -0400, Stephen Smalley wrote:
> > Ok, let's assume that we implement kernel mechanism for 
> > revalidating/updating the incore inode SIDs upon policy 
> reload.  But 
> > where does this leave us with regard to being able to meaningfully 
> > confine rpm in the future, e.g. by moving the real 
> processing into a 
> > helper and running it in different domains based on package 
> > trustworthiness and purpose?  If rpm (and potentially other 
> programs, 
> > as this becomes a tempting way to deal with e.g. 
> dump/restore) can set 
> > down arbitrary values as file contexts, then can they be 
> meaningfully 
> > restricted in any way?  To me that is the larger concern.
> 
> Ok, it has been pointed out to me that rpm and friends can 
> still be meaningfully restricted if:
> a) we still apply the usual checking on setxattr() when the 
> context is valid under the policy (thereby preventing rpm 
> from setting to a context that is known but not accessible to 
> it under the policy), and just use unlabeled_t as the target 
> context when the context is not known under the policy and 
> the process has some new privilege for setting unknown 
> contexts (so the privilege no longer confers completely 
> arbitrary values),

That is fine...

> b) we apply fine-grained access control over the policy 
> modules being loaded by rpm so that it cannot add types with 
> arbitrary permissions to the policy (so that it cannot gain 
> access to something it should not via the previously unknown 
> types it is introducing), which is necessary anyway for 
> confinement of rpm and should be addressed via the policy server.
> 

I strongly disagree with this. Not because rpm (or whatever) can subvert
the policy directly by making a new type and installing a policy that
can subvert policy. Although this is an issue because one can't
necessarilly map file types to domains with privileges, it can possibly
be controlled by policy server (assuming there are some pretty strict
metapolicy rules around).

A bigger issue (assuming we can control the former) is that an untrusted
rpm can label a file with the expectation that it will be active later.
Eg., label a malicious file passwd_exec_t before the passwd module is
installed. Wait for the passwd module to be installed (by a more trusted
RPM that has the policy rights to insert it) and viola, you have a rogue
binary that can enter passwd_t and modify shadow_t.


 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
