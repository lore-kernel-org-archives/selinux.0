Subject: Re: RFC Kernel interface to conditional policy
From: Karl MacMillan <kmacmillan@tresys.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SELinux List <SELinux@tycho.nsa.gov>, James Morris <jmorris@redhat.com>
In-Reply-To: <1070565996.17837.64.camel@moss-spartans.epoch.ncsc.mil>
References: <1070484482.3774.54.camel@colossus.columbia.tresys.com>
	 <1070565996.17837.64.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Message-Id: <1070571500.28675.30.camel@colossus.columbia.tresys.com>
Mime-Version: 1.0
Date: Thu, 04 Dec 2003 15:58:20 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2003-12-04 at 14:26, Stephen Smalley wrote:
> On Wed, 2003-12-03 at 15:48, Karl MacMillan wrote:
> > Problem
> > 1) Manipulate proc files directly. This allows fine-grained labeling of
> > the boolean files, but kernel developers seem to be frowning on new uses
> > of proc.
> > 
> > 2) Extend the selinux filesystem. This wouldn't allow fine-grained
> > labeling and would pollute the policy-neutral security server interface
> > with type enforcement policy specific functionality.
> > 
> > 3) Create a new filesystem. This would be the most work, but otherwise
> > meet our needs.
> 
> I think that the problem with any of these solutions is the need to
> revoke access to any boolean files held open at the time of the policy
> reload.  proc_kill_inodes appears to have an implementation of
> revoke-like functionality; something similar might be feasible for
> selinuxfs. 

This doesn't look too bad and is basically what I was imagining had to
be done anyway. Thanks for the pointer. As for whether the kernel
maintainers will think this is acceptable, that is another matter
entirely . . .

> I don't see any strong reason to make an entirely new
> filesystem; creating a subdirectory in selinuxfs and populating it with
> the booleans seems reasonable to me.  In the past, James has suggested
> allowing extension of selinuxfs to export other security server state,
> and this seems in line with that idea.

Great.

Karl

-- 
Karl MacMillan
Tresys Technology
kmacmillan@tresys.com
http://www.tresys.com
(410) 290-1411 x134


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
