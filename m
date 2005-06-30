Subject: Re: file contexts and modularity
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: Janak Desai <janak@us.ibm.com>, Karl MacMillan <kmacmillan@tresys.com>,
   selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <1120139605.32561.28.camel@celtics.boston.redhat.com>
References: <200506291905.j5TJ4r7f019262@gotham.columbia.tresys.com>
	 <1120073041.20484.70.camel@celtics.boston.redhat.com>
	 <1120074657.3553.217.camel@moss-spartans.epoch.ncsc.mil>
	 <1120075381.20484.75.camel@celtics.boston.redhat.com>
	 <42C302F9.4080901@us.ibm.com>
	 <1120077839.20484.104.camel@celtics.boston.redhat.com>
	 <1120139605.32561.28.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Thu, 30 Jun 2005 09:58:30 -0400
Message-Id: <1120139910.11798.58.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-06-30 at 09:53 -0400, Ivan Gyurdiev wrote:
> I can see the problem being fixed if you label files under /home
> _and_ /tmp with a ROLE independent-type. This will also remove the
> need to relabel after a change in primary role, which is currently
> a major issue. However, I wasn't sure if that was being suggested? 
> Is this what we're discussing here - removing role-dependent labeling,
> since other roles' content will be hidden by polyinstantiation?

No, the derived types are still useful IMHO for isolation, and note that
the polyinstantiated directory support doesn't try to prevent access to
the other per-role directories (even when they are subdirectories of the
top-level directory, we re-bind it elsewhere to allow security-aware
applications to access it if allowed by policy and to allow programs
like su and newrole to re-bind upon role changes).  On the other hand, I
know Karl previously suggested eliminating them, but I think that would
be a real loss...

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
