Message-ID: <51E3F42A.1060300@tycho.nsa.gov>
Date: Mon, 15 Jul 2013 09:07:54 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>
CC: Andy Ruch <adruch2002@yahoo.com>, SELinux ML <selinux@tycho.nsa.gov>,
        Eric Paris <eparis@redhat.com>
Subject: Re: AVC for unlabeled_t on cgroup
References: <1373567937.10428.YahooMailNeo@web163406.mail.gq1.yahoo.com> <20130713174723.GA5347@siphos.be>
In-Reply-To: <20130713174723.GA5347@siphos.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 07/13/2013 01:48 PM, Sven Vermeulen wrote:
> On Thu, Jul 11, 2013 at 11:38:57AM -0700, Andy Ruch wrote:
>> I'm implementing a restrictive policy for RHEL 6.3 based on CLIP. I've enabled the cgroup module but I'm still seeing the AVC below. This is just one of a dozen similar AVC's for different inodes. When I look at the /cgroup after the system boots, everything has a cgroup_t label. Where would the unlabeled_t be coming from?
>>
>>
>>
>> type=SYSCALL msg=audit(07/11/2013 17:25:38.885:7) : arch=x86_64 syscall=mount success=yes exit=0 a0=7f57846ac4c1 a1=7f57848b03c0 a2=7f57846ac4c1 a3=0 items=0 ppid=1177 pid=1178 auid=unset uid=root gid=root euid=root suid=root fsuid=root egid=root sgid=root fsgid=root tty=(none) ses=unset comm=cgconfigparser exe=/sbin/cgconfigparser subj=system_u:system_r:cgconfig_t:s0 key=(null)
>>
>> type=AVC msg=audit(07/11/2013 17:25:38.885:7) : avc:  denied  { search } for  pid=1178 comm=cgconfigparser name=/ dev=cgroup ino=12518 scontext=system_u:system_r:kernel_t:s0 tcontext=system_u:object_r:unlabeled_t:s0 tclass=dir
>
> The cgroup_t label might be put on it afterwards (check your udev rules and
> scripts to see if they don't relabel files), but my guess is that the
> directory is marked as unlabeled_t and that cgroup file system is mounted on
> top of it later. Once it is mounted, you see the context of the files (and
> directories) in the mounted file system, which is cgroup_t.
>
> Try bindmounting root elsewhere and see what the label is of the directory.
>
> Also, the process cgconfigparser is running as kernel_t, which we probably
> don't want. The kernel is probably configured to trigger that script
> somewhere (or through another script) and because there is no transition
> defined, the script remains running as kernel_t.
>
> For instance, in Gentoo, we have a script that is called after the last task
> is removed from a control group; we mark that script as a specific exec
> script (openrc_cgroup_release_exec_t here) and have a transition from
> kernel_t to openrc_cgroup_release_t upon execution.
>
> This is through cgroup's notify_on_release implementation (release agent).
> Perhaps the cgconfigparser is also executed through a cgroup feature by the
> kernel?

No, it is an internal credential switch by the kernel when populating 
the cgroup directory.  See:

commit 2ce9738bac1b386f46e8478fd2c263460e7c2b09
Author: eparis@redhat <eparis@redhat>
Date:   Thu Jun 2 21:20:51 2011 +1000

     cgroupfs: use init_cred when populating new cgroupfs mount

     We recently found that in some configurations SELinux was blocking 
the abili
     for cgroupfs to be mounted.  The reason for this is because 
cgroupfs creates
     files and directories during the get_sb() call and also uses 
lookup_one_len(
     during that same get_sb() call.  This is a problem since the security
     subsystem cannot initialize the superblock and the inodes in that 
filesystem
     until after the get_sb() call returns.  Thus we leave the inodes in
     an unitialized state during get_sb().  For the vast majority of 
filesystems
     this is not an issue, but since cgroupfs uses lookup_on_len() it does
     search permission checks on the directories in the path it walks. 
Since the
     inode security state is not set up SELinux does these checks as if 
the inode
     were 'unlabeled.'

     Many 'normal' userspace process do not have permission to interact with
     unlabeled inodes.  The solution presented here is to do the 
permission check
     of path walk and inode creation as the kernel rather than as the 
task that
     called mount.  Since the kernel has permission to read/write/create
     unlabeled inodes the get_sb() call will complete successfully and 
the SELinu
     code will be able to initialize the superblock and those inodes 
created duri
     the get_sb() call.

     This appears to be the same solution used by other filesystems such 
as devtm
     to solve the same issue and should thus have no negative impact on 
other LSM
     which currently work.

     Signed-off-by: Eric Paris <eparis@redhat.com>
     Acked-by: Paul Menage <menage@google.com>
     Signed-off-by: James Morris <jmorris@namei.org>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
