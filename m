Subject: Re: mounting cgroupfs causes directory search before sb
 initialization
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov,
        "rhel6-cc-external-list@redhat.com >> RHEL6-CC"
 <rhel6-cc-external-list@redhat.com>
In-Reply-To: <4DDD5BF0.2080904@redhat.com>
References: <4DDD5BF0.2080904@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 25 May 2011 16:19:21 -0400
Message-ID: <1306354761.26019.6.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2011-05-25 at 15:43 -0400, Eric Paris wrote:
> Running the RHEL6 MLS policy we find that we have trouble mounting
> cgroupfs with denials that look like so:
> 
> time->Wed May 25 13:24:28 2011
> type=PATH msg=audit(1306347868.791:11): item=0 name="/cgroup/freezer" inode=24658 dev=fd:00 mode=040755 ouid=0 ogid=0 rdev=00:00 obj=system_u:object_r:cgroup_t:s0
> type=CWD msg=audit(1306347868.791:11):  cwd="/"
> type=SYSCALL msg=audit(1306347868.791:11): arch=c000003e syscall=165 success=yes exit=0 a0=7f9561cb0481 a1=7f9561ebe414 a2=7f9561cb0481 a3=0 items=1 ppid=944 pid=945 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0 egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="cgconfigparser" exe="/sbin/cgconfigparser" subj=system_u:system_r:cgconfig_t:s0-s15:c0.c1023 key=(null)
> type=AVC msg=audit(1306347868.791:11): avc:  denied  { search } for  pid=945 comm="cgconfigparser" name="/" dev=cgroup ino=9436 scontext=system_u:system_r:cgconfig_t:s0-s15:c0.c1023 tcontext=system_u:object_r:unlabeled_t:s15:c0.c1023 tclass=dir
> 
> After quite a bit of code inspection I think I understand the problem (although not completely). I believe the problem is that during the get_sb() call cgroupfs creates not only the root directory inode but also creates files inside that directory.  During that creation of other files (like in this case "freezer") the code does:
> 
> vfs_kern_mount()
>   cgroup_get_sb()
>     cgroup_populate_dir()
>       cgroup_add_files()
>         lookup_one_len()
>         alloc_dentry()
>         d_instantiate()
> 
> It seems to use lookup_one_len() to make sure it isn't adding 
> the same file twice.  Now the problem is that since we are still 
> inside get_sb() we haven't made it to security_sb_kern_mount() 
> which actually initializes the superblock security struct (and the 
> root inode).  Thus sbsec->flags & SE_SBINITIALIZED isn't set, so 
> the root inode will not have been initialized.  Now when 
> lookup_on_len() tries to search the new root inode it's going to 
> get SECINITSID_UNLABELED.
> 
> I honestly am not sure how to fix it.  I could mark the root inode 
> PRIVATE while get_sb() was taking place, but that wouldn't work if 
> they ever started creating directory structures during mount.  
> Maybe we can somehow force the cgroup people to do the creation of 
> the files inside cgroupfs root inode after the sb is initialized?  
> I'm just not sure how to solve it.  Any ideas?

You could do what devtmpfs does, e.g.
cred = override_creds(&init_cred);
<perform internal fs operations>
revert_creds(cred);

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
