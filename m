Subject: Re: [PATCH 1/2] SELinux: allow userspace to read policy back out
 of the kernel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <20100726193407.19538.67667.stgit@paris.rdu.redhat.com>
References: <20100726193407.19538.67667.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 26 Jul 2010 16:48:55 -0400
Message-ID: <1280177335.17036.5.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2010-07-26 at 15:34 -0400, Eric Paris wrote:
> There is interest in being able to see what the actual policy is that was
> loaded into the kernel.  The patch creates a new selinuxfs file
> /selinux/policy which can be read by userspace.  The actual policy that is
> loaded into the kernel will be written back out to userspace.

Can you clarify exactly how comparable the output is to the original
policy file that was loaded?  Last time you mentioned range transition
rules may be reordered, KaiGai mentioned that ebitmaps might not be
identical after conversion (losing the original startbit), and Chris
pointed out that sediff isn't sufficient for comparison as it doesn't
yet handle constraints.


> Signed-off-by: Eric Paris <eparis@redhat.com>


-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
