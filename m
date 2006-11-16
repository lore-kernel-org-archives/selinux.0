Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAGHT0HV031955
	for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 12:29:00 -0500
Received: from e1.ny.us.ibm.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAGHSFHF005113
	for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 17:28:16 GMT
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.12.11) with ESMTP id kAGHTDxW030239
	for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 12:29:13 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id kAGHT7G7238098
	for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 12:29:13 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id kAGHT4gL020639
	for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 12:29:04 -0500
Received: from [127.0.0.1] (pendarric.austin.ibm.com [9.41.46.130])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id kAGHT203020584
	for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 12:29:03 -0500
Message-ID: <455C9FD9.9010002@us.ibm.com>
Date: Thu, 16 Nov 2006 11:28:57 -0600
From: Michael C Thompson <thompsmc@us.ibm.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>
Subject: [Fwd: [redhat-lspp] mqueue filesystem labeling]
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Posted to the redhat-lspp list.

Anyone have any idea why this is labeled by default to SystemHigh?

Thanks,
Mike

-------- Original Message --------
Subject: [redhat-lspp] mqueue filesystem labeling
Date: Wed, 15 Nov 2006 00:19:03 -0200
From: Thiago Jung Bauermann <bauerman@br.ibm.com>
To: redhat-lspp <redhat-lspp@redhat.com>

Hi folks,

I am having some trouble with POSIX message queues in enforcing mode. I
hope someone can shed some light into this...

The POSIX message queue implementation uses an internal virtual
filesystem called mqueue, so processes wanting to perform operations on
POSIX message queues must have access to that filesystem.

The problem is that for some reason the mqueue filesystem is labeled at
SystemHigh, so only processes at that level are able to create message
queues.

I don't think this is breaking any functionality, so... do we care?



The only line I could find in the SELinux policy about this is:

fs_use_trans mqueue gen_context(system_u:object_r:tmpfs_t,s0);

The above says that the mqueue fs should be at SystemLow.
This is how the kernel initializes it:

SELinux: initialized (dev mqueue, type mqueue), uses transition SIDs

Even if I explicitly set a SystemLow context for the filesystem when
mounting it, it is still mounted as SystemHigh:

[root@alex mls]# mount -t mqueue mqueue /mnt
[root@alex mls]# ls -Zd /mnt
drwxrwxrwt  root root system_u:object_r:tmpfs_t:SystemHigh /mnt
[root@alex mls]# umount /mnt

[root@alex mls]# mount -o fscontext=system_u:object_r:tmpfs_t:s0 -t
mqueue mqueue /mnt
[root@alex mls]# ls -Zd /mnt
drwxrwxrwt  root root system_u:object_r:tmpfs_t:SystemHigh /mnt
[root@alex mls]# umount /mnt

[root@alex mls]# mount -o context=system_u:object_r:tmpfs_t:s0 -t mqueue
mqueue /mnt
[root@alex mls]# ls -Zd /mnt
drwxrwxrwt  root root system_u:object_r:tmpfs_t:SystemHigh /mnt



And here's the audit record generated when trying to create a message
queue in enforcing mode:

----
type=PATH msg=audit(10/31/2006 17:00:00.603:752) : item=0 name=myqueue
obj=system_u:object_r:root_t:s0
type=CWD msg=audit(10/31/2006 17:00:00.603:752) : cwd=/tmp/tests

type=MQ_OPEN msg=audit(10/31/2006 17:00:00.603:752) :
oflag=0xc2 mode=777 mq_flags=0x6d8730 mq_maxmsg=16 mq_msgsize=1
mq_curmsgs=0

type=SYSCALL msg=audit(10/31/2006 17:00:00.603:752) : arch=x86_64
syscall=mq_open success=no exit=-13(Permission denied) a0=2aaaaab1f94d
a1=c2 a2=1ff a3=7fffac4d8550 items=1 ppid=2581 pid=2608 auid=ealuser
uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root
fsgid=root tty=pts0 comm=queuetest exe=/tmp/tests/queuetest
subj=staff_u:sysadm_r:sysadm_t:s0-s15:c0.c1023 key=(null)
  ----

I got the above record by adding an audit rule for the mq_open()
syscall. I find it odd that it doesn't include an AVC message. I thought
every denial record had one...

And here's an audit record obtained in permissive mode:

----
type=PATH msg=audit(10/31/2006 17:01:12.307:764) : item=2 name=(null)
inode=418 dev=00:0d mode=dir,sticky,777 ouid=root ogid=root rdev=00:00
obj=system_u:object_r:tmpfs_t:s15:c0.c1023

type=PATH msg=audit(10/31/2006 17:01:12.307:764) : item=1 name=(null)
inode=12076 dev=00:0d mode=file,755 ouid=root ogid=root rdev=00:00
obj=staff_u:object_r:sysadm_tmpfs_t:s0

type=PATH msg=audit(10/31/2006 17:01:12.307:764) : item=0 name=myqueue
obj=system_u:object_r:root_t:s0

type=CWD msg=audit(10/31/2006 17:01:12.307:764) :
cwd=/tmp/tests

type=MQ_OPEN msg=audit(10/31/2006 17:01:12.307:764) : oflag=0xc2
mode=777 mq_flags=0x6d8730 mq_maxmsg=16 mq_msgsize=1 mq_curmsgs=0

type=SYSCALL msg=audit(10/31/2006 17:01:12.307:764) : arch=x86_64
syscall=mq_open success=yes exit=4 a0=2aaaaab1f94d a1=c2 a2=1
ff a3=7fffac4d8550 items=3 ppid=2581 pid=2608 auid=ealuser uid=root
gid=root euid=root suid=root fsuid=root egid=root sgid=root
  fsgid=root tty=pts0 comm=queuetest exe=/tmp/tests/queuetest
subj=staff_u:sysadm_r:sysadm_t:s0-s15:c0.c1023 key=(null)

  type=AVC msg=audit(10/31/2006 17:01:12.307:764) : avc:  denied
{ add_name } for  pid=2608 comm=queuetest name=myqueue scontext=
  staff_u:sysadm_r:sysadm_t:s0-s15:c0.c1023
tcontext=system_u:object_r:tmpfs_t:s15:c0.c1023 tclass=dir

  type=AVC msg=audit(10/31/2006 17:01:12.307:764) : avc:  denied
{ write } for  pid=2608 comm=queuetest name=/ dev=mqueue ino=418 s
  context=staff_u:sysadm_r:sysadm_t:s0-s15:c0.c1023
tcontext=system_u:object_r:tmpfs_t:s15:c0.c1023 tclass=dir
  ----


-- 
[]'s
Thiago Jung Bauermann
Software Engineer
IBM Linux Technology Center

--
redhat-lspp mailing list
redhat-lspp@redhat.com
https://www.redhat.com/mailman/listinfo/redhat-lspp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
