Subject: Re: [PATCH] newrole: use pam session management services - v4
From: Joshua Brindle <method@gentoo.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: janak@us.ibm.com, sgrubb@redhat.com, dwalsh@redaht.com, tmraz@redhat.com,
        ltcgcw@us.ibm.com, klaus@atsec.com, selinux@tycho.nsa.gov
In-Reply-To: <1157460795.4014.4.camel@moss-spartans.epoch.ncsc.mil>
References: <1157403682.7223.16.camel@localhost.localdomain>
	 <1157458823.15886.16.camel@twoface.columbia.tresys.com>
	 <1157460795.4014.4.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 09:00:28 -0400
Message-Id: <1157461228.15886.21.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-09-05 at 08:53 -0400, Stephen Smalley wrote:
> On Tue, 2006-09-05 at 08:20 -0400, Joshua Brindle wrote:
> > On Mon, 2006-09-04 at 17:01 -0400, Janak Desai wrote:
> > > This patch updates newrole to allow it to use pam session mangement
> > > services. Currently newrole only uses the authenticaion services of
> > > pam. Session management services are needed to allow pam_namespace
> > > to appropriately reconfigure polyinstantiated namespace for the
> > > new session being established with newrole.
> > > 
> > > For newrole to work correctly with pam_namespace, in addtion to
> > > this patch, a patch to pam_namespace and a patch to the lssp 
> > > policy will also be required. These additional patches will be
> > > posted the selinux mailing list following this patch.
> > > 
> > > Changes since v3 of this patch, posted on 8/27/06:
> > >     1. Incorporated feedback to v2
> > >        a. Create/install an lspp version of newrole.pamd when
> > >           building with LSPP_PRIV=y
> > 
> > why LSPP_PRIV? I don't think these changes are specific to lspp and
> > could have other applications. Also, why another binary instead of
> > handling the case where the capabilities aren't available gracefully?
> > How will users who need this automatically know to run newrole.pamd?
> 
> The audit-related changes are presently conditional on LOG_AUDIT_PRIV;
> he is generalizing that to LSPP_PRIV to cover both audit and namespace
> functionality, both of which require a setuid newrole with certain
> capabilities.  The .pamd files are pam config files, not binaries.
> He is just following my comments on v3 of the patch, see my prior
> posting.

Hrm, I looked back and didn't see anything, probably didn't look hard
enough. Is it really generalized if its LSPP specific, do we not see
anyone using the pam session capabilities for reasons other than LSPP?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
