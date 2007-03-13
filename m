Subject: Re: Confirmation about task_has_security in selinuxfs.c
From: Stephen Smalley <sds@tycho.nsa.gov>
To: JanuGerman <doublemalam@yahoo.co.uk>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <537052.29906.qm@web86902.mail.ukl.yahoo.com>
References: <537052.29906.qm@web86902.mail.ukl.yahoo.com>
Content-Type: text/plain
Date: Tue, 13 Mar 2007 11:08:00 -0400
Message-Id: <1173798480.2068.51.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-03-13 at 15:01 +0000, JanuGerman wrote:
> Hi Stephen,
> 
> Is the following lines in the selinuxfs.c that gets
> the final decision from the security server:
> 
> length = security_compute_av(ssid, tsid, tclass, req,
> &avd);
>         if (length < 0)
>                goto out2;
> ...

For that particular call, yes.

> Actually, i am intrested in locating the last point at
> which the selinuxfs.c communicates with the security
> server for an access decision (no matter cached or
> not) and then conveys back the decision to the LSM
> hook.

You seem to misunderstand the purpose of selinuxfs.  selinuxfs is a
pseudo filesystem interface between applications and the SELinux kernel
module.  It isn't used by the LSM hooks called by the kernel.  The hook
functions are implemented in security/selinux/hooks.c.

> Alternatively, the point, at which the DAC checks are
> again checked by the LSM hook, which query the SElinux
> LSM. I have checked the "security.c", which contains
> the SELinux LSM hook registration but did not succeed
> to locate the point, where all these calls are taking
> place.

Perhaps an example would make things clearer.  During open(2)
processing, the fs/namei.c:permission() function is called to check
permissions.  That function first applies the usual Linux checks,
including DAC checks, and, if they pass, the function then calls the LSM
security_inode_permission() hook, which is defined by
include/linux/security.h.  If using SELinux, this hook will call
selinux_inode_permission() in security/selinux/hooks.c, which calls
inode_has_perm(), which calls avc_has_perm() in security/selinux/avc.c.
That is the access vector cache.  If there is a cache miss, then
avc_has_perm_noaudit() in avc.c will call security_compute_av() to get
the decision from the security server.  selinuxfs is not involved in
that code path.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
