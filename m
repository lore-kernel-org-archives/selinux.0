Subject: Re: overlayfs+selinux error: OPNOTSUPP
To: Matthew Cengia <mattcen@cyber.com.au>, selinux@tycho.nsa.gov
References: <20150921022517.GH22582@cyber.com.au>
 <56006BBA.4070602@tycho.nsa.gov>
Cc: russell@coker.com.au, Matthew Cengia <mattcen@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <56006CC7.2070605@tycho.nsa.gov>
Date: Mon, 21 Sep 2015 16:47:03 -0400
MIME-Version: 1.0
In-Reply-To: <56006BBA.4070602@tycho.nsa.gov>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/21/2015 04:42 PM, Stephen Smalley wrote:
> On 09/20/2015 10:25 PM, Matthew Cengia wrote:
>> NOTE: I originally sent this to LKML
>> (https://lkml.org/lkml/2015/9/17/888), but was directed here.
>>
>> Hi all,
>>
>> Please CC me directly when responding, as I'm not subscribed to the
>> mailing list.
>>
>>
>> Summary
>> -------
>> I deploy diskless Debian kiosks in prisons, for use by inmates.
>> As part of the Debian 7 to 8 upgrade, I want to enable SELinux.
>> My initrd uses overlayfs to combine a ro squashfs and a rw tmpfs.
>>
>> When I add SELinux into the mix, I get a lot of EOPNOTSUPP.
>>
>>
>> Long and boring history
>> -----------------------
>> I was happy with Debian 7 / Linux 3.16 / sysvinit / aufs.
>> Then, new hardware arrived, which needed a newer Xorg.
>> So I had to switch to Debian 8 / Linux 3.16.
>> Debian 8 defaults to systemd, so I went with that.
>>
>> I used to put $XDG_RUNTIME_DIR under a /tmp mounted -onoexec.
>> Systemd v215 is hard-coded to mount $XDG_RUNTIME_DIR as a dedicated tmpfs,
>> and provides no way to mount/remount it with -onoexec.
>>
>>     src/login/logind-user.c:336:user_mkdir_runtime_path()
>>
>> When I complained about this, regulars on #systemd on Freenode said:
>>
>>     Just use SELinux, already!
>>     -o noexec might break something, and it won't stop interpreters.
>>
>> ...which was mostly reasonable.
>> So adopting SELinux was reprioritized from "some day" to "right now!"
>>
>> aufs doesn't support SELinux, so I had to switch to overlayfs.
>> So now my target is Debian 8 / Linux 4.1 / systemd / overlayfs / SELinux.
>>
>>
>> Current problem
>> ---------------
>> When I built & booted that combination, hostnames didn't resolve.
>>
>> The initrd uses klibc ipconfig as a DHCP client,
>> then tries to create /etc/resolv.conf in the rootfs.
>> (This happens before switch_root.)
>>
>> When SELinux is enabled, resolv.conf can't be opened for writing.
>> The attached strace (output.txt) shows open(2) gets EOPNOTSUPP.
>>
>>
>> Tests completed
>> ---------------
>> This problem *ONLY* occurs in the initrd,
>> which is *BEFORE* the SELinux policy loads.
>> I'm not sure if this is relevant.
> 
> Yes, I believe it is.  Most likely culprit is:
> security/selinux/hooks.c:
>    2890 static int selinux_inode_setxattr(struct dentry *dentry, const
> char *name,
>    2891                                   const void *value, size_t
> size, int flags)
>    2892 {
>    2893         struct inode *inode = dentry->d_inode;
>    2894         struct inode_security_struct *isec = inode->i_security;
>    2895         struct superblock_security_struct *sbsec;
>    2896         struct common_audit_data ad;
>    2897         u32 newsid, sid = current_sid();
>    2898         int rc = 0;
>    2899
>    2900         if (strcmp(name, XATTR_NAME_SELINUX))
>    2901                 return selinux_inode_setotherxattr(dentry, name);
>    2902
>    2903         sbsec = inode->i_sb->s_security;
>    2904         if (!(sbsec->flags & SBLABEL_MNT))
>    2905                 return -EOPNOTSUPP;
>                                ^^^^^^^^^^^^
> That's to prevent setting SELinux attributes on a filesystem that does
> not support labeling due to use of a context= mount or policy genfscon
> rules to override any xattrs on the filesystem.  Maybe that should be
> exempted if no policy is loaded (!ss_initialized).
> 
> At this point, I have to ask:  which is easier, patching systemd to do
> what you want, loading policy earlier (in general, the earlier you load
> SELinux policy, the better), or patching the kernel.

BTW, IIUC, the reason that this manifests on an open(2) call is that
overlayfs is trying to copy-up any xattrs from the lower filesystem to
the upper filesystem when you touch the file, which triggers a
vfs_getxattr on the lower filesystem and then a vfs_setxattr on the
upper filesystem, and then we fail here.  Not something we would see on
open(2) otherwise.

> 
>>
>> This problem *DOES NOT* occur if the file/directory being written to
>> already exists in the read/write portion of the overlay mount before the
>> overlayfs is mounted. I've attached a script to demonstrate this.
>>
>> Booting the kernel with permissive=1 *DOES NOT* prevent the problem.
>>
>>
>> Test script
>> -----------
>> Attached is a script called 'bootstrap'.
>> When run on a Debian Jessie system with debootstrap, squashfs-tools, and kvm installed,
>> and selinux installed and enabled (even if it's in permissive mode),
>> 'bootstrap' will:
>>
>>  * Mount a tmpfs without -o nodev at /tmp/bootstrap/live, to build in;
>>  * Build an SOE in /tmp/bootstrap/live/;
>>  * Create a squashfs of the built system;
>>  * Leave the squashfs, kernel, and initrd in /tmp/bootstrap/live/boot/; and
>>  * Start up a VM using KVM to demonstrate the behaviour.
>>
>> The script that the initrd runs does several things, all of which are
>> detailed within the script, and in output.txt; look for lines
>> containing '-->'.
>>
>> output.txt contains a full KVM run of the system exhibiting the problem,
>> in which I've also run an 'strace touch' to demonstrate the failing
>> syscall.
>>
>>
>> Help?
>> -----
>> How can I set about debugging this problem further?
>> Has anybody dealt with this before?
>> How can I solve (or workaround) this problem?
>>
>>
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
>>
> 
