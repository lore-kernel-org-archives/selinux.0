Subject: Re: mkdir avc
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20060922161150.72513.qmail@web51505.mail.yahoo.com>
References: <20060922161150.72513.qmail@web51505.mail.yahoo.com>
Content-Type: text/plain
Date: Fri, 22 Sep 2006 13:47:29 -0400
Message-Id: <1158947249.7748.235.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-09-22 at 09:11 -0700, Steve G wrote:
> Hi,
> 
> When there is a denial doing mkdir syscall, should there be an avc_path or path
> audit record? Example:
> 
> type=AVC msg=audit(1118918038.404:14545): avc:  denied  { create } for  pid=4407
> comm="useradd" name="usertwo" scontext=root:sysadm_r:useradd_t:s0-s15:c0.c1023
> tcontext=root:object_r:user_home_dir_t:s0 tclass=dir
> type=SYSCALL msg=audit(1118918038.404:14545): arch=c000003e syscall=83 success=no
> exit=-13 a0=813cc0 a1=0 a2=2 a3=1 items=0 ppid=4222 pid=4407 auid=0 uid=0 gid=0
> euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=pts1 comm="useradd"
> exe="/usr/sbin/useradd" subj=root:sysadm_r:useradd_t:s0-s15:c0.c1023 key=(null)
> 
> Seems like we should know the path being created or the parent dir where it
> failed.

The necessary information (vfsmount) isn't available to the AVC, so it
cannot create such a record.  I would have expected the syscall audit
record to have captured the path, but am not seeing it now either (but
do see it in older audit logs).  Regression in the audit code?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
