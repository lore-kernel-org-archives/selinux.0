Message-ID: <46A0D780.6020405@redhat.com>
Date: Fri, 20 Jul 2007 11:40:48 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: Eric Paris <eparis@redhat.com>, SE Linux <selinux@tycho.nsa.gov>,
        James Morris <jmorris@namei.org>
Subject: Re: [Fwd: cups AVC...]
References: <46A0C494.7060000@redhat.com> <1184941981.17338.801.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1184941981.17338.801.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Fri, 2007-07-20 at 10:20 -0400, Daniel J Walsh wrote:
>   
>> Kernel problem?
>>     
>
> Yet another pseudo filesystem type, with no entry in policy to configure
> labeling for it.  Looks like it allocates exactly one inode that is
> shared for all instances, to be used by things like eventpoll, eventfd,
> signalfd, and timerfd.  Replaces eventpollfs.
>
> Given that there is a single shared inode, I guess you want a genfscon
> statement rather than fs_use_task, and then allow access everywhere that
> access was given for e.g. eventpollfs.
>
> Yuck.  We need a better way to handle these things, to avoid having to
> touch policy configuration each time a new pseudo fs type is introduced.
> Possibly the file_system_type structure could also specify labeling
> behavior for security modules.
>
>   
>> -------- Original Message --------
>> Subject: 	cups AVC...
>> Date: 	Fri, 20 Jul 2007 07:04:08 -0700
>> From: 	Tom London <selinux@gmail.com>
>> To: 	fedora-selinux <fedora-selinux-list@redhat.com>
>>
>>
>>
>> Seem to be getting this one from cups.  Haven't seen 'anon_inodefs' before....
>>
>> Printing to HP5MP seems to work however....
>>
>> tom
>>
>> type=AVC msg=audit(1184938825.408:32): avc:  denied  { ioctl } for
>> pid=5296 comm="cupsd" name="[eventpoll]" dev=anon_inodefs ino=385
>> scontext=system_u:system_r:cupsd_t:s0-s0:c0.c1023
>> tcontext=system_u:object_r:unlabeled_t:s0 tclass=file
>> type=SYSCALL msg=audit(1184938825.408:32): arch=40000003 syscall=54
>> success=no exit=-13 a0=1 a1=5401 a2=bfda72ac a3=bfda73cc items=0
>> ppid=5295 pid=5296 auid=500 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0
>> sgid=0 fsgid=0 tty=(none) comm="cupsd" exe="/usr/sbin/cupsd"
>> subj=system_u:system_r:cupsd_t:s0-s0:c0.c1023 key=(null)
>> type=AVC_PATH msg=audit(1184938825.408:32):  path="anon_inode:[eventpoll]"
>> type=LABEL_LEVEL_CHANGE msg=audit(1184938825.408:33): user pid=5296
>> uid=0 auid=500 subj=system_u:system_r:cupsd_t:s0-s0:c0.c1023
>> msg='printer=HP5MP uri=hp:/par/HP_LaserJet_5MP?device=/dev/parport0
>> banners=none,none range=unknown: exe="/usr/sbin/cupsd"
>> (hostname=localhost.localdomain, addr=127.0.0.1, terminal=?
>> res=success)'
>>
>>     
I am just adding:

genfscon anon_inodefs / gen_context(system_u:object_r:eventpollfs_t,s0)

Does that look ok?

 I also notice in /proc/filesystem that there is a securityfs which we 
do not define in policy.
Any idea what this is for?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
