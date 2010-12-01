Date: Thu, 2 Dec 2010 09:14:46 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, esandeen@redhat.com
Subject: Re: [PATCH] SELinux: do not compute transition labels on mountpoint
 labeled filesystems
In-Reply-To: <20101201212254.30815.38691.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.1012020911240.15100@tundra.namei.org>
References: <20101201212254.30815.38691.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 1 Dec 2010, Eric Paris wrote:

> selinux_inode_init_security computes transitions sids even for filesystems
> that use mount point labeling.  It shouldn't do that.  It should just use
> the mount point label always and no matter what.
> 
> This causes 2 problems.  1) it makes file creation slower than it needs to be
> since we calculate the transition sid and 2) it allows files to be created
> with a different label than the mount point!
> 
> # id -Z
> staff_u:sysadm_r:sysadm_t:s0-s0:c0.c1023
> # sesearch --type --class file --source sysadm_t --target tmp_t
> Found 1 semantic te rules:
>    type_transition sysadm_t tmp_t : file user_tmp_t;
> 
> # mount -o loop,context="system_u:object_r:tmp_t:s0"  /tmp/fs /mnt/tmp
> 
> # ls -lZ /mnt/tmp
> drwx------. root root system_u:object_r:tmp_t:s0       lost+found
> # touch /mnt/tmp/file1
> # ls -lZ /mnt/tmp
> -rw-r--r--. root root staff_u:object_r:user_tmp_t:s0   file1
> drwx------. root root system_u:object_r:tmp_t:s0       lost+found
> 
> Whoops, we have a mount point labeled filesystem tmp_t with a user_tmp_t
> labeled file!
>
> Signed-off-by: Eric Paris <eparis@redhat.com>
>

Reviewed-by: James Morris <jmorris@namei.org>


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
