Subject: RE: file contexts and modularity
From: Stephen Smalley <sds@tycho.nsa.gov>
To: gyurdiev@redhat.com
Cc: Janak Desai <jdesai@us.ibm.com>, Karl MacMillan <kmacmillan@tresys.com>,
   selinux@tycho.nsa.gov, "'Daniel J Walsh'" <dwalsh@redhat.com>
In-Reply-To: <1120075381.20484.75.camel@celtics.boston.redhat.com>
References: <200506291905.j5TJ4r7f019262@gotham.columbia.tresys.com>
	 <1120073041.20484.70.camel@celtics.boston.redhat.com>
	 <1120074657.3553.217.camel@moss-spartans.epoch.ncsc.mil>
	 <1120075381.20484.75.camel@celtics.boston.redhat.com>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 16:09:31 -0400
Message-Id: <1120075771.3553.234.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-06-29 at 16:03 -0400, Ivan Gyurdiev wrote:
> > So at that point you no longer need to keep home directory contexts in
> > file_contexts at all, and you just exclude home directories from
> > relabeling.
> 
> How is the context of the bind-mounted home dir configured?

The mount point directory's context can just be a single fixed context
for all users, as it is just a mount point.

> and subdirectories? pre-created?

Optionally, but typically just created by login-style programs (ideally
via libpam) when the user first logs in at a given role.

> what determines their context?

Obtained via security_compute_member, which in turn relies on
type_member rules in the policy.  See Chad's earlier postings.  The
security_setupns() function is in our libselinux tree, but you'd also
need the patches he posted to login and friends for experimentation.

> I am trying to understand where the labeling 
> information is stored, if you want to get rid of the 
> file_contexts.homedirs file.

It is computed based on the user process' security context and the base
context on the mount point directory.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
