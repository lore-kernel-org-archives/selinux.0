From: Paul Moore <pmoore@redhat.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [PATCH] selinux: fix the default socket labeling in sock_graft()
Date: Thu, 10 Jul 2014 15:11:09 -0400
Message-ID: <3731034.dgD2eG8Wyv@sifl>
In-Reply-To: <53BED153.2020206@tycho.nsa.gov>
References: <20140710153728.21266.78354.stgit@localhost>
 <53BEC5B5.5020508@tycho.nsa.gov> <53BED153.2020206@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Milan Broz <gmazyland@gmail.com>, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thursday, July 10, 2014 01:45:55 PM Stephen Smalley wrote:
> Ok, I think I understand this now:  for inet and unix, sksec->sid is set
> in other hooks upon connection establishment based on the peer label -
> primarily for multi-level servers - and we are propagating it upward to
> the parent socket inode.  For others, sksec->sid is not set anywhere
> except initialized to unlabeled upon sock creation and so you are just
> pushing the parent socket inode label down to the sock in your patch.

Yep.

> It seems a bit fragile though and certainly doesn't align with the
> sock_graft hook documentation anymore.  Wondering if we should assert
> that sksec->sid is not SECINITSID_UNLABELED in the inet/inet6/unix case
> (i.e. that sksec->sid has been set prior to copying it to isec->sid) and
> that sksec->sid is SECINITSID_UNLABELED (i.e. that it has not already
> been set by the protocol implementation) in the default case.
> We need to update the hook documentation too.

Since we can't return an error code, we would be stuck with a BUG_ON() which 
is okay, but doesn't help in the situation where the kernel has compiled out 
the BUG/BUG_ON macros.  Regardless, there probably is some value in adding a 
BUG_ON(), if for no other reason than documentation.

I'll see about correcting the comment in, thanks for catching that.

-- 
paul moore
security and virtualization @ redhat
