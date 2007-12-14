Subject: Re: help with an avc denial
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Clarkson, Mike R (US SSA)" <mike.clarkson@baesystems.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <FB39F4E77226B448BC1388D3BE4E00CD02773CB8@blums0008.bluelnk.net>
References: <FB39F4E77226B448BC1388D3BE4E00CD02773CB8@blums0008.bluelnk.net>
Content-Type: text/plain
Date: Fri, 14 Dec 2007 14:44:47 -0500
Message-Id: <1197661487.31325.175.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-12-14 at 11:31 -0800, Clarkson, Mike R (US SSA) wrote:
> I'm running RHEL 5.1 with the mls policy.
> 
> I'm getting an avc denial that I can't get past. Here are the entries
> from the audit log:
> 
> type=AVC msg=audit(1197658847.835:9499): avc:  denied  { create } for
> pid=20432 comm="touch" name="tmp.log"
> scontext=sysadm_u:sysadm_r:sysadm_t:s0-s4:c0.c255
> tcontext=sysadm_u:object_r:audit_log_t:s0-s4:c0.c255 tclass=file

A file should be single level, not ranged.

> type=SYSCALL msg=audit(1197658847.835:9499): arch=c000003e syscall=2
> success=no exit=-13 a0=7fff74eceb5c a1=941 a2=1b6 a3=328dd4b0ac items=0
> ppid=12410 pid=20432 auid=11000 uid=11000 gid=4500 euid=11000 suid=11000
> fsuid=11000 egid=4500 sgid=4500 fsgid=4500 tty=pts3 comm="touch"
> exe="/bin/touch" subj=sysadm_u:sysadm_r:sysadm_t:s0-s4:c0.c255
> key=(null)
> 
> 
> Here is what audit2allow returns:
> #============= sysadm_t ==============
> # src="sysadm_t" tgt="audit_log_t" class="file", perms="create"
> # comm="touch" exe="" path=""
> allow sysadm_t audit_log_t:file create;
> 
> I have entered that exact allow rule into my policy to no effect.
> 
> Audit2why indicates that the reason for the above audit log avc denial
> is a missing allow rule, as opposed to a constraint problem.
> 
> Any help would be greatly appreciated.
> Thanks
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
