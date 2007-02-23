Subject: Re: libselinux patch
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
In-Reply-To: <451748.5368.qm@web51503.mail.yahoo.com>
References: <451748.5368.qm@web51503.mail.yahoo.com>
Content-Type: text/plain
Date: Fri, 23 Feb 2007 15:45:02 -0500
Message-Id: <1172263502.19041.136.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-02-22 at 07:48 -0800, Steve G wrote:
> Hi,
> 
> OK, I think the attached patch does _everything _ we discussed. It:
> 
> - removes 8 syscalls for the normal path
> - ensures /selinux is trully an selinuxfs
> - drops back to detecting the old way when /selinux is missing
> - changes the old way in is_enabled to use fopen for glibc internal retries
> - adds retry for EINTR in mls_enabled
> - keeps SELINUX_MAGIC private
> 
> Signed-off-by: Steve Grubb <linux_4ever@yahoo.com>

- Can drop the no-longer-used ret and rc local vars.
- Booting with the patched libselinux reveals some permission denials
due to the new attempts to statfs /selinux, e.g. audit2allow after boot
generates:
	allow mount_t security_t : filesystem getattr;
	allow restorecon_t security_t : filesystem getattr;
	allow setrans_t security_t : filesystem getattr;
Hence, we'd need to add that permission to selinux_get_fs_mount() in
refpolicy.  Fortunately, since it just falls back to the old logic if
the statfs fails, it doesn't change behavior so we don't need to
coordinate closely with the policy update.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
