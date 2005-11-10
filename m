Subject: Re: [ SEMANAGE ] Move seuser validation to proper place
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4372824F.7050904@cornell.edu>
References: <4372824F.7050904@cornell.edu>
Content-Type: text/plain
Date: Thu, 10 Nov 2005 08:43:04 -0500
Message-Id: <1131630184.19626.16.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-11-09 at 18:12 -0500, Ivan Gyurdiev wrote:
> Moves seuser validation from commit_components into merge_components.
> This is the logical place for it - it's:
> 
> 1) after modules are loaded and all components merged
> 2) inside the attach-detach section where policy has not been written 
> back to disk
> 3) still in policy_components.c, which is supposedly backend-independent 
> code.
> 
> This should result in a speedup, because the policy does not need to be 
> re-read in for the sake of seuser validation, which was occuring in 
> commit(). Note that seuser validation is incomplete at this point, since 
> MLS checks are not done.

Thanks, merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
