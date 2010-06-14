Subject: Re: [PATCH 4/4] SELinux: allow userspace to read policy back out
 of the kernel
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <20100611163723.18445.39397.stgit@paris.rdu.redhat.com>
References: <20100611163705.18445.78022.stgit@paris.rdu.redhat.com>
	 <20100611163723.18445.39397.stgit@paris.rdu.redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 14 Jun 2010 10:57:27 -0400
Message-ID: <1276527447.8863.25.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2010-06-11 at 12:37 -0400, Eric Paris wrote:
> There is interest in being able to see what the actual policy is that was
> loaded into the kernel.  The patch creates a new selinuxfs file
> /selinux/policy which can be read by userspace.  The actual policy that is
> loaded into the kernel will be written back out to userspace.

How do you expect this to be used?  As with /selinux/load, we can't use
coreutils utilities to manipulate it unfortunately.  Nor can we do
things like checkpolicy -b /selinux/policy since it doesn't support
mmap.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
