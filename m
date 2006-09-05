Subject: Re: [PATCH] newrole: use pam session management services - v4
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@gentoo.org>
Cc: janak@us.ibm.com, sgrubb@redhat.com, dwalsh@redhat.com, tmraz@redhat.com,
        ltcgcw@us.ibm.com, klaus@atsec.com, selinux@tycho.nsa.gov
In-Reply-To: <1157461228.15886.21.camel@twoface.columbia.tresys.com>
References: <1157403682.7223.16.camel@localhost.localdomain>
	 <1157458823.15886.16.camel@twoface.columbia.tresys.com>
	 <1157460795.4014.4.camel@moss-spartans.epoch.ncsc.mil>
	 <1157461228.15886.21.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 10:30:30 -0400
Message-Id: <1157466630.4014.94.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-09-05 at 09:00 -0400, Joshua Brindle wrote:
> On Tue, 2006-09-05 at 08:53 -0400, Stephen Smalley wrote:
> > On Tue, 2006-09-05 at 08:20 -0400, Joshua Brindle wrote:
> > > On Mon, 2006-09-04 at 17:01 -0400, Janak Desai wrote:
> > > > This patch updates newrole to allow it to use pam session mangement
> > > > services. Currently newrole only uses the authenticaion services of
> > > > pam. Session management services are needed to allow pam_namespace
> > > > to appropriately reconfigure polyinstantiated namespace for the
> > > > new session being established with newrole.
> > > > 
> > > > For newrole to work correctly with pam_namespace, in addtion to
> > > > this patch, a patch to pam_namespace and a patch to the lssp 
> > > > policy will also be required. These additional patches will be
> > > > posted the selinux mailing list following this patch.
> > > > 
> > > > Changes since v3 of this patch, posted on 8/27/06:
> > > >     1. Incorporated feedback to v2
> > > >        a. Create/install an lspp version of newrole.pamd when
> > > >           building with LSPP_PRIV=y
> > > 
> > > why LSPP_PRIV? I don't think these changes are specific to lspp and
> > > could have other applications. Also, why another binary instead of
> > > handling the case where the capabilities aren't available gracefully?
> > > How will users who need this automatically know to run newrole.pamd?
> > 
> > The audit-related changes are presently conditional on LOG_AUDIT_PRIV;
> > he is generalizing that to LSPP_PRIV to cover both audit and namespace
> > functionality, both of which require a setuid newrole with certain
> > capabilities.  The .pamd files are pam config files, not binaries.
> > He is just following my comments on v3 of the patch, see my prior
> > posting.
> 
> Hrm, I looked back and didn't see anything, probably didn't look hard
> enough. Is it really generalized if its LSPP specific, do we not see
> anyone using the pam session capabilities for reasons other than LSPP?

Entire thread is at:
http://marc.theaimsgroup.com/?t=115410947300001&r=1&w=2

We can't just add a pam_open_session() call to newrole without having an
actual session module in the config (otherwise, the call fails, and
newrole exits with an error, as I noted earlier in this thread), unless
there is some graceful way of dealing with that situation.  Further, the
patch also has to include changes to the capability manipulation code of
newrole to retain the capabilities required for pam_namespace until
after pam_open_session.  Hence, the patch is tightly coupled to
pam_namespace, which like the prior audit changes is motivated by LSPP.
The old LOG_AUDIT_PRIV option name was intended to connote both the
purpose (for audit support) and the fact that it required a privileged
newrole.  We could call it LOG_AUDIT_NAMESPACE_PRIV, but that takes me
back to my Ada days.  We could also try to split them up into separate
build options, but they have definite overlap (in capability
manipulation) and it isn't clear who will enable one without the other,
since they are both motivated by LSPP.

Anyway, the larger issue here is that this patch means that newrole will
retain a number of very powerful and general capabilities in its
permitted set for almost its entire execution, since the
pam_open_session has to occur late (after the setexeccon) for
pam_namespace to work.  This is in contrast to the audit changes, which
only required retaining CAP_AUDIT_WRITE, a very limited and specific
capability, and could drop all other capabilities permanently upon
startup.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
