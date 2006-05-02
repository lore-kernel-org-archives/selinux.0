Subject: Re: We are attempting once again to split policy out into
	individual RPMS.
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Paul Nasrat <pnasrat@redhat.com>
Cc: Jeremy Katz <katzj@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>,
        James Morris <jmorris@redhat.com>, SELinux-dev@tresys.com,
        SE Linux <selinux@tycho.nsa.gov>, James Antill <jantill@redhat.com>
In-Reply-To: <1146587383.2737.35.camel@enki.eridu>
References: <44576B91.8060607@redhat.com>
	 <1146582758.13611.89.camel@moss-spartans.epoch.ncsc.mil>
	 <1146583639.32102.20.camel@orodruin.boston.redhat.com>
	 <1146587175.13611.145.camel@moss-spartans.epoch.ncsc.mil>
	 <1146587383.2737.35.camel@enki.eridu>
Content-Type: text/plain
Date: Tue, 02 May 2006 12:53:30 -0400
Message-Id: <1146588810.13611.163.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-02 at 12:29 -0400, Paul Nasrat wrote:
> On Tue, 2006-05-02 at 12:26 -0400, Stephen Smalley wrote:
> > On Tue, 2006-05-02 at 11:27 -0400, Jeremy Katz wrote:
> 
> > Ok, let's assume that we implement kernel mechanism for
> > revalidating/updating the incore inode SIDs upon policy reload.  But
> > where does this leave us with regard to being able to meaningfully
> > confine rpm in the future, e.g. by moving the real processing into a
> > helper and running it in different domains based on package
> > trustworthiness and purpose?  
> 
> Do you have any patches or information about this helper model in RPM.

I just mean separating rpm into a front-end program that determines the
right domain in which to run a back-end helper, and the back-end helper
that does most of the real processing, including loading any policy,
installing the files, running the scriptlets, etc.  Then you can have
different domains for the helper based on the trustworthiness and
purpose of the package being installed, and policy can ensure that e.g.
package foo cannot do arbitrary things on your system.

> If we are looking at moving to a helper anyway should we not be looking
> at how to implement modular policy with the helper?  
> 
> How is the helper is going to be able to access the pp file before it is
> on disk, how does it load policy, how do we ensure that transactions
> with scriptlets/triggers on a policy module update that all contexts are
> "correct" at time of running.

I don't think the helper fundamentally changes the issue.  If you want
to allow rpm (whether via helper or not) to set arbitrary file contexts
so that you do not have to load policy prior to setting down the files,
then how can we ever confine it in policy?  That's the question.  It
changes the model from one where no process is fully trusted to
completely subvert the model and everything must be explicitly allowed
by policy to one where certain processes have discretion to arbitrarily
subvert the policy and no amount of analysis of the policy is going to
tell you what can actually happen on the system.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
