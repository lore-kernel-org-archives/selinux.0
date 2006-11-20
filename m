Subject: Re: [redhat-lspp] mqueue filesystem labeling
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Thiago Jung Bauermann <bauerman@br.ibm.com>
Cc: redhat-lspp <redhat-lspp@redhat.com>, selinux@tycho.nsa.gov,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
In-Reply-To: <1163557143.3930.2.camel@localhost.localdomain>
References: <1163557143.3930.2.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 20 Nov 2006 12:53:09 -0500
Message-Id: <1164045189.13758.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-11-15 at 00:19 -0200, Thiago Jung Bauermann wrote:
> Hi folks,
> 
> I am having some trouble with POSIX message queues in enforcing mode. I
> hope someone can shed some light into this...
> 
> The POSIX message queue implementation uses an internal virtual
> filesystem called mqueue, so processes wanting to perform operations on
> POSIX message queues must have access to that filesystem.
> 
> The problem is that for some reason the mqueue filesystem is labeled at
> SystemHigh, so only processes at that level are able to create message
> queues.

This kind of question belongs on selinux list (cc'd above), as it is not
LSPP-specific.

With regard to your question, I believe that this is a characteristic of
fs_use_trans that has come up previously for other fs_use_trans
filesystems - the root inode is deriving its label from the kernel's
SID, and is thus inheriting SystemHigh as its level.  For devpts, this
was worked around via a restorecon /dev/pts in rc.sysinit, but the
policy now supports range_transition statements on object classes, so it
should be possible to define such a transition to label these pseudo
filesystems with a correct level.

> I don't think this is breaking any functionality, so... do we care?
> 
> 
> 
> The only line I could find in the SELinux policy about this is:
> 
> fs_use_trans mqueue gen_context(system_u:object_r:tmpfs_t,s0);
> 
> The above says that the mqueue fs should be at SystemLow.
> This is how the kernel initializes it:
> 
> SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs
> 
> Even if I explicitly set a SystemLow context for the filesystem when
> mounting it, it is still mounted as SystemHigh:
> 
> [root@alex mls]# mount -t mqueue mqueue /mnt
> [root@alex mls]# ls -Zd /mnt
> drwxrwxrwt  root root system_u:object_r:tmpfs_t:SystemHigh /mnt
> [root@alex mls]# umount /mnt
> 
> [root@alex mls]# mount -o fscontext=system_u:object_r:tmpfs_t:s0 -t
> mqueue mqueue /mnt
> [root@alex mls]# ls -Zd /mnt
> drwxrwxrwt  root root system_u:object_r:tmpfs_t:SystemHigh /mnt
> [root@alex mls]# umount /mnt
> 
> [root@alex mls]# mount -o context=system_u:object_r:tmpfs_t:s0 -t mqueue
> mqueue /mnt
> [root@alex mls]# ls -Zd /mnt
> drwxrwxrwt  root root system_u:object_r:tmpfs_t:SystemHigh /mnt
> 
> 
> 
> And here's the audit record generated when trying to create a message
> queue in enforcing mode:
> 
> ----
> type=PATH msg=audit(10/31/2006 17:00:00.603:752) : item=0 name=myqueue
> obj=system_u:object_r:root_t:s0
> type=CWD msg=audit(10/31/2006 17:00:00.603:752) : cwd=/tmp/tests
> 
> type=MQ_OPEN msg=audit(10/31/2006 17:00:00.603:752) :
> oflag=0xc2 mode=777 mq_flags=0x6d8730 mq_maxmsg=16 mq_msgsize=1
> mq_curmsgs=0
> 
> type=SYSCALL msg=audit(10/31/2006 17:00:00.603:752) : arch=x86_64
> syscall=mq_open success=no exit=-13(Permission denied) a0=2aaaaab1f94d
> a1=c2 a2=1ff a3=7fffac4d8550 items=1 ppid=2581 pid=2608 auid=ealuser
> uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root
> fsgid=root tty=pts0 comm=queuetest exe=/tmp/tests/queuetest
> subj=staff_u:sysadm_r:sysadm_t:s0-s15:c0.c1023 key=(null)
>  ----
> 
> I got the above record by adding an audit rule for the mq_open()
> syscall. I find it odd that it doesn't include an AVC message. I thought
> every denial record had one...
> 
> And here's an audit record obtained in permissive mode:
> 
> ----
> type=PATH msg=audit(10/31/2006 17:01:12.307:764) : item=2 name=(null)
> inode=418 dev=00:0d mode=dir,sticky,777 ouid=root ogid=root rdev=00:00
> obj=system_u:object_r:tmpfs_t:s15:c0.c1023
> 
> type=PATH msg=audit(10/31/2006 17:01:12.307:764) : item=1 name=(null)
> inode=12076 dev=00:0d mode=file,755 ouid=root ogid=root rdev=00:00
> obj=staff_u:object_r:sysadm_tmpfs_t:s0
> 
> type=PATH msg=audit(10/31/2006 17:01:12.307:764) : item=0 name=myqueue
> obj=system_u:object_r:root_t:s0
> 
> type=CWD msg=audit(10/31/2006 17:01:12.307:764) :
> cwd=/tmp/tests
> 
> type=MQ_OPEN msg=audit(10/31/2006 17:01:12.307:764) : oflag=0xc2
> mode=777 mq_flags=0x6d8730 mq_maxmsg=16 mq_msgsize=1 mq_curmsgs=0
> 
> type=SYSCALL msg=audit(10/31/2006 17:01:12.307:764) : arch=x86_64
> syscall=mq_open success=yes exit=4 a0=2aaaaab1f94d a1=c2 a2=1
> ff a3=7fffac4d8550 items=3 ppid=2581 pid=2608 auid=ealuser uid=root
> gid=root euid=root suid=root fsuid=root egid=root sgid=root
>  fsgid=root tty=pts0 comm=queuetest exe=/tmp/tests/queuetest
> subj=staff_u:sysadm_r:sysadm_t:s0-s15:c0.c1023 key=(null)
> 
>  type=AVC msg=audit(10/31/2006 17:01:12.307:764) : avc:  denied
> { add_name } for  pid=2608 comm=queuetest name=myqueue scontext=
>  staff_u:sysadm_r:sysadm_t:s0-s15:c0.c1023
> tcontext=system_u:object_r:tmpfs_t:s15:c0.c1023 tclass=dir
> 
>  type=AVC msg=audit(10/31/2006 17:01:12.307:764) : avc:  denied
> { write } for  pid=2608 comm=queuetest name=/ dev=mqueue ino=418 s
>  context=staff_u:sysadm_r:sysadm_t:s0-s15:c0.c1023
> tcontext=system_u:object_r:tmpfs_t:s15:c0.c1023 tclass=dir
>  ----
> 
> 
> -- 
> []'s
> Thiago Jung Bauermann
> Software Engineer
> IBM Linux Technology Center
> 
> --
> redhat-lspp mailing list
> redhat-lspp@redhat.com
> https://www.redhat.com/mailman/listinfo/redhat-lspp
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
