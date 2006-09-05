Subject: Re: [PATCH] newrole: use pam session management services - v4
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <method@gentoo.org>
Cc: janak@us.ibm.com, sgrubb@redhat.com, dwalsh@redaht.com, tmraz@redhat.com,
        ltcgcw@us.ibm.com, klaus@atsec.com, selinux@tycho.nsa.gov
In-Reply-To: <1157458823.15886.16.camel@twoface.columbia.tresys.com>
References: <1157403682.7223.16.camel@localhost.localdomain>
	 <1157458823.15886.16.camel@twoface.columbia.tresys.com>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 08:53:15 -0400
Message-Id: <1157460795.4014.4.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-09-05 at 08:20 -0400, Joshua Brindle wrote:
> On Mon, 2006-09-04 at 17:01 -0400, Janak Desai wrote:
> > This patch updates newrole to allow it to use pam session mangement
> > services. Currently newrole only uses the authenticaion services of
> > pam. Session management services are needed to allow pam_namespace
> > to appropriately reconfigure polyinstantiated namespace for the
> > new session being established with newrole.
> > 
> > For newrole to work correctly with pam_namespace, in addtion to
> > this patch, a patch to pam_namespace and a patch to the lssp 
> > policy will also be required. These additional patches will be
> > posted the selinux mailing list following this patch.
> > 
> > Changes since v3 of this patch, posted on 8/27/06:
> >     1. Incorporated feedback to v2
> >        a. Create/install an lspp version of newrole.pamd when
> >           building with LSPP_PRIV=y
> 
> why LSPP_PRIV? I don't think these changes are specific to lspp and
> could have other applications. Also, why another binary instead of
> handling the case where the capabilities aren't available gracefully?
> How will users who need this automatically know to run newrole.pamd?

The audit-related changes are presently conditional on LOG_AUDIT_PRIV;
he is generalizing that to LSPP_PRIV to cover both audit and namespace
functionality, both of which require a setuid newrole with certain
capabilities.  The .pamd files are pam config files, not binaries.
He is just following my comments on v3 of the patch, see my prior
posting.

> 
> >        b. Removed duplicate definition of _GNU_SOURCE
> >        c. Keep CAP_SYS_ADMIN, CAP_FOWNER, CAP_CHOWN and
> >           CAP_DAC_OVERRIDE in permitted set and raise them in the
> >           effective set prior to calling pam session management
> >           functions.
> >     2. Forward ported to the latest selinux subversion tree (version 2014)
> >        on sourceforge and tested with fedora development package
> >        policycoreutils-1.30.28-1.src.rpm.
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
