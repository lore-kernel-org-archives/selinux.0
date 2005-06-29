Subject: RE: file contexts and modularity
From: Ivan Gyurdiev <gyurdiev@redhat.com>
Reply-To: gyurdiev@redhat.com
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Janak Desai <jdesai@us.ibm.com>, Karl MacMillan <kmacmillan@tresys.com>,
   selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <1120075771.3553.234.camel@moss-spartans.epoch.ncsc.mil>
References: <200506291905.j5TJ4r7f019262@gotham.columbia.tresys.com>
	 <1120073041.20484.70.camel@celtics.boston.redhat.com>
	 <1120074657.3553.217.camel@moss-spartans.epoch.ncsc.mil>
	 <1120075381.20484.75.camel@celtics.boston.redhat.com>
	 <1120075771.3553.234.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 16:22:53 -0400
Message-Id: <1120076573.20484.93.camel@celtics.boston.redhat.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-06-29 at 16:09 -0400, Stephen Smalley wrote:
> On Wed, 2005-06-29 at 16:03 -0400, Ivan Gyurdiev wrote:
> > > So at that point you no longer need to keep home directory contexts in
> > > file_contexts at all, and you just exclude home directories from
> > > relabeling.
> > 
> > How is the context of the bind-mounted home dir configured?
> 
> The mount point directory's context can just be a single fixed context
> for all users, as it is just a mount point.

ok ..

> > and subdirectories? pre-created?
> 
> Optionally, but typically just created by login-style programs (ideally
> via libpam) when the user first logs in at a given role.

> > what determines their context?
> 
> Obtained via security_compute_member, which in turn relies on
> type_member rules in the policy.  See Chad's earlier postings.  The
> security_setupns() function is in our libselinux tree, but you'd also
> need the patches he posted to login and friends for experimentation.

I don't have the list archived that far back,
but from reading about this online it looks like an analog
to file_type_auto_trans, which doesn't work, because
of ambiguity. Pre-creating things is required, which
currently works via matchpathcon....

..or am I misunderstanding how this works?

> > I am trying to understand where the labeling 
> > information is stored, if you want to get rid of the 
> > file_contexts.homedirs file.
> 
> It is computed based on the user process' security context and the base
> context on the mount point directory.

That makes sense for the mount point itself, but not
for sub-content.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
