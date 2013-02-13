Message-ID: <511BB776.8070608@tycho.nsa.gov>
Date: Wed, 13 Feb 2013 10:55:34 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: SELinux <selinux@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>
Subject: Re: Monitoring the Openshift Logs each day for AVCs I am struct by
 how often we get AVC's for stuff that is blocked by DAC.
References: <511B982F.3050502@redhat.com>
In-Reply-To: <511B982F.3050502@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 02/13/2013 08:42 AM, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> This causes SELinux to have a bad name, and we really need to cleanup the
> kernel to make sure MAC Checks happen after DAC Checks.
>
> Here is an example, of a UID running a program that attempts to create a file
> in a directory which would be denied by dac.
>
> type=PATH msg=audit(02/12/13 05:53:32.462:691259) : item=0
> name=/var/run/netreport/3243 inode=258591 dev=ca:42 mode=dir,775 ouid=root
> ogid=root rdev=00:00 obj=system_u:object_r:var_run_t:s0
> type=CWD msg=audit(02/12/13 05:53:32.462:691259) :
> cwd=/var/lib/openshift/c323ad7c3b48426eaa8bb13f4234a5e1/diy-0.1/logs
> type=SYSCALL msg=audit(02/12/13 05:53:32.462:691259) : arch=x86_64
> syscall=open success=no exit=-13(Permission denied) a0=7fff294849b0 a1=202c1
> a2=0 a3=d items=1 ppid=3243 pid=12586 auid=c323ad7c3b48426eaa8bb13f4234a5e1
> uid=c323ad7c3b48426eaa8bb13f4234a5e1 gid=c323ad7c3b48426eaa8bb13f4234a5e1
> euid=c323ad7c3b48426eaa8bb13f4234a5e1 suid=c323ad7c3b48426eaa8bb13f4234a5e1
> fsuid=c323ad7c3b48426eaa8bb13f4234a5e1 egid=root sgid=root fsgid=root tty=pts4
> ses=37928 comm=netreport exe=/sbin/netreport
> subj=unconfined_u:system_r:openshift_t:s0:c5,c283 key=(null)
> type=AVC msg=audit(02/12/13 05:53:32.462:691259) : avc:  denied  { write } for
>   pid=12586 comm=netreport name=netreport dev=xvde2 ino=258591
> scontext=unconfined_u:system_r:openshift_t:s0:c5,c283
> tcontext=system_u:object_r:var_run_t:s0 tclass=dir
>
> As a policy writer I either have to add a bogus dontaudit on this or have
> customers,
>
> I have seen regularly seen Capability checks, rawip_sockets, mmap_zero etc
> that would be blocked by DAC, and yet we generate an ugly MAC AVC.
>
> I realize in some cases we might want to know if users are trying to do evil
> things, but almost all cases the user just is executing applications that
> generate an AVC for something that without SELinux turned on would have been

Something isn't right here, as the SELinux read/write checks do occur 
after the DAC ones (inode_permission).  Likewise for capability checks.
setattr is an unusual case due to the fact that the filesystem 
implementation combines permission checking and performing the operation 
into a single inode operation, so we have to perform our check first if 
we want to ensure it happens at all. Socket checks are a layering issue; 
LSM/SELinux hooks the generic socket layer, whereas most of the DAC 
checks occur down in the network protocol implementations; hard to fix. 
  mmap_zero was a conscious choice on Eric's part.

But your particular example doesn't make sense unless the process 
actually did pass the DAC checks for directory write.  Maybe it has the 
group in its supplementary group set?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
