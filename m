Subject: Re: Replacing capability:sys_admin by other permissions
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Yuichi Nakamura <ynakam@gwu.edu>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <4gfoda$4t2vl7@iron2-mx.tops.gwu.edu>
References: <4gfoda$4t2vl7@iron2-mx.tops.gwu.edu>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 15:30:37 -0500
Message-Id: <1132173037.3901.14.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2005-11-16 at 15:09 -0500, Yuichi Nakamura wrote:
> Hi.
> 
> I am thinking whether capability:sys_admin can be replaced by other permissions. 
> I do not like capablity:sys_admin because it is not fine-grained and hard to explain to users.
> 
> I found capability:sys_admin is checked as follows.
> (1) Usage of quotactl, mount, mount, swapon, swapoff 
> (2) Set attribute to all IPC objects(IPC_SET)
> (3) Delete all IPC objects(IPC_RMID)
> (4) Set extended security attibute for file system.

If using SELinux, then the setting of the security.selinux attribute is
controlled based on the corresponding SELinux permission checks, not
CAP_SYS_ADMIN.

> (5) Use fake UID as socket credential.
> (6) Usage of sethostname, setdomainname
> (7) Can open more file than limits in /proc/sys/fs/file-max.
> (8) Allocate memory using space reserved for priviledged process.
> (9) Some ioctl operations in device drivers 

include/linux/capability.h has a list (likely incomplete or out-of-date)
of operations controlled by CAP_SYS_ADMIN.

> I think (1)-(5) can be replaced by other permissions.
> #There is other permissions that restricts (1)-(5).
> 
> However, (6)-(9) can not be replaced by other permissions.
> For example, when we want to grant "sethostname" then 
> (7),(8),(9) are also granted. It is not least-priviledge...
> 
> I think in old SELinux "sethostname, setdomainname" can be restricted.
> Will they come back again?
> 
> And I think it is natural (7) and (8) are integrated into capability:sys_resource.
> Is there plan to construct new sets of capability?
> I think POSIX capability may reduce granularity of access control.

Since LSM is in the mainline kernel, the natural approach going forward
would be to propose a LSM hook to provide finer-grained control where
desired, moving the legacy CAP_SYS_ADMIN check into the dummy and
capability modules and introducing a finer-grained permission check in
the SELinux module by adding permissions to e.g. the system class.  But
you have to be able to justify such changes, naturally.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
