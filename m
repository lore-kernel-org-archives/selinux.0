Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2N5fFH5017049
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 01:41:15 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2N5fEGF021874
	for <selinux@tycho.nsa.gov>; Fri, 23 Mar 2007 05:41:15 GMT
Subject: Re: [PATCH]: Add security check before flushing SAD/SPD
From: Eric Paris <eparis@parisplace.org>
To: James Morris <jmorris@namei.org>
Cc: Joy Latten <latten@austin.ibm.com>, David Miller <davem@davemloft.net>,
        selinux@tycho.nsa.gov, netdev@vger.kernel.org,
        vyekkirala@TrustedCS.com
In-Reply-To: <Line.LNX.4.64.0703221943110.24461@d.namei>
References: <200703221835.l2MIZdDw007850@faith.austin.ibm.com>
	 <20070322.120139.74735307.davem@davemloft.net>
	 <1174598630.3085.285.camel@faith.austin.ibm.com>
	 <Line.LNX.4.64.0703221943110.24461@d.namei>
Content-Type: text/plain
Date: Fri, 23 Mar 2007 01:39:47 -0400
Message-Id: <1174628387.10788.53.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-03-22 at 19:49 -0400, James Morris wrote:
> On Thu, 22 Mar 2007, Joy Latten wrote:
> 
> > > I would look at this patch differently if there were some
> > > security level key being checked for a match here, which is
> > > an input key to the flush, but that is not what is happening
> > > here as the object is being looked at by itself.
> > 
> > Yes, I understand what you are saying.
> > I was concerned about having to check each entry
> > to flush database.
> > 
> > I did this patch because we check for authorization
> > when deleting single specified entries from the SAD/SPD. It
> > seem like a hole to me that we check for this, but that same
> > user/process can delete the entire database with no checks.
> 
> Indeed.  Removing an entry is modifying MAC policy, which requires 
> appropriate authorization.
> 
> The security label is encapsulated with the object, which is why it's 
> passed to the security layer.
> 
> Perhaps a better semantic would be to fail the entire flush operation if 
> one of the security checks failed.  e.g. loop through for permissions 
> first, then if all ok, loop through for deletion.

Maybe I'm way out on a limb here but if I am a regular user and I say
rm /tmp/* and I only have permissions to delete some of the files I
expect just those couple to be delete, not the whole operation denied.

It seems reasonable to me that the check for every policy (which is
between current->security->sid and xp->security->ctx_sid) makes sense.
There doesn't appear to me right offhand to be anything intrinsic in the
code which says that a flush request must flush everything or nothing.

In either case though proper auditing needs to be addressed.  I see that
the first patch from Joy wouldn't audit deletion failures.  It appears
to me if the check is done per policy then the security hook return code
needs to be recorded and passed to xfrm_audit_log instead of the hard
coded 1 result used now.

Assuming we go with James's double loop what should we be auditing for a
security hook denial?  Just audit the first policy entry which we tried
to remove but couldn't and then leave the rest of the auditing in those
functions the way it is now in case there was no denial, calling
xfrm_audit_log with a hard coded 1 for the result?

-Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
