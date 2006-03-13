Subject: Re: Strange behaviour in MLS Policy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4415DA1E.1030208@redhat.com>
References: <4415DA1E.1030208@redhat.com>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 15:56:18 -0500
Message-Id: <1142283378.24555.83.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-03-13 at 15:46 -0500, Daniel J Walsh wrote:
> Any idea why devpts in MLS is mounting at SystemHigh?
> 
> I see no reason in policy that this would happen. 
> 
>  From reading policy I believe it should be mounting at SystemLow, the 
> same way tmpfs does.
> 
> The goal is to get it to mount at SystemLow-SystemHigh.

devpts is labeled via fs_use_trans, so the SIDs of its inodes are
computed as transition SIDs, and it therefore inherits its MLS label
from the creating task (in this case, the kernel).  See Chad Hanson's
patch from Friday to change initscripts to restorecon /dev/pts after
boot.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
