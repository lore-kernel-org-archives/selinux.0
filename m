Subject: Re: extra secondary_ops for digsig
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <jbrindle@snu.edu>
Cc: SELinux <SELinux@tycho.nsa.gov>
In-Reply-To: <407E7111.506@snu.edu>
References: <407E7111.506@snu.edu>
Content-Type: text/plain
Message-Id: <1082030949.25880.23.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 15 Apr 2004 08:09:10 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-04-15 at 07:25, Joshua Brindle wrote:
> I started playing with digsig and quickly found out that selinux doesn't 
> support all the secondary ops that it requires (it isn't even set up to 
> be a secondary module, I had to fix that too so this is expected)..
> 
> Digsig is an LSM that verifies signatures on ELF binaries before they 
> are allowed to run. It requires inode_permission, file_mmap, 
> bprm_check_security and inode_unlink, I've attached a patch to add 
> these, it'd be nice to get it upstream so that this module will run as a 
> secondary to selinux without hacking (I'll send the patch for digsig to 
> their authors as well)
> 
> Just out of curiousity, why are there so few secondary_ops available? 
> Was it just decided to add them as they were required or is there a 
> different reason?

Blindly stacking two security modules can be very dangerous, so we
didn't want to encourage it.  We only added secondary ops as required.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
