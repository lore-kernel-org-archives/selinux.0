Subject: Re: vmplayer problems on FC12
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bill Chimiak <wch1m1@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <201003171337.08718.w.chimiak@ieee.org>
References: <201003171337.08718.w.chimiak@ieee.org>
Content-Type: text/plain
Date: Wed, 17 Mar 2010 15:55:24 -0400
Message-Id: <1268855724.5354.29.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-03-17 at 13:37 -0400, Bill Chimiak wrote:
> I am having problems getting vmplayer (VMware Player) 
> to run on Fedora Core 12.  Any suggestions?
> 
> Here are the Raw Audit Messages:
> 
> node=localhost type=AVC msg=audit(1268701051.828:64): avc: denied { search } 
> for pid=5187 comm="portrelease" name="vmware" dev=sdd1 ino=30236681 
> scontext=unconfined_u:system_r:portreserve_t:s0 
> tcontext=unconfined_u:object_r:vmware_file_t:s0 tclass=dir
> 
> node=localhost type=SYSCALL msg=audit(1268701051.828:64): arch=40000003 
> syscall=5 success=no exit=-13 a0=bfd83dc0 a1=0 a2=0 a3=8 items=0 ppid=5179 
> pid=5187 auid=500 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 
> tty=pts7 ses=4 comm="portrelease" exe="/sbin/portreserve" 
> subj=unconfined_u:system_r:portreserve_t:s0 key=(null)
> 
> 
> The selinux troubleshooter gives this additional info:
> Summary
> SELinux is preventing /sbin/portreserve "search" access on /opt/vmware.

Ok, I don't know why portreserve is trying to search /opt/vmware
(perhaps vmware creates a symlink to a file under /opt/vmware
within /etc/portreserve?), but you can just generate a local policy
module to allow this access via audit2allow.
 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
