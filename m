Subject: Re: [PATCH FOR REFERENCE ONLY] MLSXFRM-v02: Add support to
	serefpolicy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Venkat Yekkirala <vyekkirala@TrustedCS.com>,
        Joshua Brindle <jbrindle@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
        jmorris@namei.org, latten@austin.ibm.com, tjaeger@cse.psu.edu
In-Reply-To: <1157112503.26621.38.camel@moss-spartans.epoch.ncsc.mil>
References: <44BD1970.7010207@trustedcs.com>
	 <1157112503.26621.38.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 09:26:35 -0400
Message-Id: <1157117196.3199.95.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-01 at 08:08 -0400, Stephen Smalley wrote:
> On Tue, 2006-07-18 at 12:25 -0500, Venkat Yekkirala wrote:
> > This patch has been included here just for reference for anyone wanting to
> > try the patchset in enforcing mode. It will be submitted to the serefpolicy
> > list later.
> > 
> > This patch adds a polmatch avperm to arbitrate flow/state's access to
> > a xfrm policy. It also defines MLS policy for association { sendto,
> > recvfrom, polmatch }.
> > 
> > NOTE: When an inbound packet is not using an IPSec SA, a check is performed
> > between the socket label and the unlabeled sid (SYSTEM_HIGH MLS label). For
> > MLS purposes however, the target of the check should be the MLS label taken
> > from the node sid (or secmark in the new secmark world). This would present
> > a severe performance overhead (to make a new sid based on the unlabeled sid
> > with the MLS taken from the node sid or secmark and then using this sid as
> > the target). Pending reconciliation of the netlabel, ipsec and iptables contexts,
> > I have chosen to currently make an exception for unlabeled_t SAs if TE policy
> > allowed it. A similar problem exists for the outbound case and it has been similarly
> > handled in the policy below (by making an exception for unlabeled_t).
> > 
> > The mlsconstrains are from myself and the rest (sample/basic pieces to get
> > communication going without or with unlabeled IPSec) are from Joy Latten at IBM
> > (latten@austin.ibm.com).
> > 
> > diff -urpN serefpolicy-2.2.47.orig/policy/flask/access_vectors serefpolicy-2.2.47.diff/policy/flask/access_vectors
> > --- serefpolicy-2.2.47.orig/policy/flask/access_vectors	2006-07-11 05:15:39.000000000 -0500
> > +++ serefpolicy-2.2.47.diff/policy/flask/access_vectors	2006-07-11 07:43:37.000000000 -0500
> > @@ -602,6 +602,7 @@ class association
> >  	sendto
> >  	recvfrom
> >  	setcontext
> > +	polmatch
> >  }
> >  
> >  # Updated Netlink class for KOBJECT_UEVENT family.
> 
> I still don't see polmatch permission in the upstream reference policy.
> Not even a definition, much less sufficient rules to allow it when
> needed.  So 2.6.19 or the 2.6.18 kernel with the back ported patch can't
> possibly work right now for labeled networking via IPSEC, right?

The top of the email said the final patch would be submitted later.  I
never saw any submission.  Is this the patch we want use?  Other than
the permission and MLS constraints, the other parts are questionable,
since they refer to unlabeled processes.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
