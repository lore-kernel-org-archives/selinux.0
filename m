Subject: Re: [PATCH] SELINUX: add /sys/fs/selinux mount point to put
 selinuxfs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Greg KH <greg@kroah.com>
Cc: James Morris <jmorris@namei.org>, Eric Paris <eparis@parisplace.org>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Lennart Poettering
 <mzerqung@0pointer.de>,
        linux-security-module@vger.kernel.org,
        systemd-devel@lists.freedesktop.org, selinux@tycho.nsa.gov
In-Reply-To: <20110430011950.GA11566@kroah.com>
References: <20110430011950.GA11566@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 02 May 2011 09:24:40 -0400
Message-ID: <1304342680.16563.35.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2011-04-29 at 18:19 -0700, Greg KH wrote:
> From: Greg Kroah-Hartman <gregkh@suse.de>
> 
> In the interest of keeping userspace from having to create new root
> filesystems all the time, let's follow the lead of the other in-kernel
> filesystems and provide a proper mount point for it in sysfs.
> 
> For selinuxfs, this mount point should be in /sys/fs/selinux/
> 
> Cc: Stephen Smalley <sds@tycho.nsa.gov>
> Cc: James Morris <jmorris@namei.org>
> Cc: Eric Paris <eparis@parisplace.org>
> Cc: Lennart Poettering <mzerqung@0pointer.de>
> Cc: Daniel J Walsh <dwalsh@redhat.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> 
> ---
> 
> Note, patch is untested, I don't have any selinux-based machines here,
> sorry.

If I understand correctly, the patch won't change any userspace-visible
behavior until one has a new libselinux that actually mounts selinuxfs
on /sys/fs/selinux instead of /selinux, right?

At that point, we have to ensure that all userspace that directly
references /selinux rather than using libselinux is changed to use
libselinux.  You might argue that all such userspace is broken already,
but given that selinuxfs has been mounted on /selinux ever since SELinux
went into mainline in 2003 and , it is difficult to blame them.  Using
codesearch.google.com on
e.g. /selinux/enforce, /selinux/load, /selinux/booleans, /selinux/mls,
etc turns up a number of examples, including glibc (a test case),
puppet, dracut, anaconda, etc.

Policy implication:  Any program that needs to access selinuxfs will
need to be able to search sysfs too.

Added dependency:  Any system that uses SELinux will need to enable and
mount sysfs (or alternatively create at least a fake /sys/fs directory).
I assume that sysfs is fairly universal at this point though, like proc?

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index ea39cb7..2381c16 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -1897,6 +1897,7 @@ static struct file_system_type sel_fs_type = {
>  };
>  
>  struct vfsmount *selinuxfs_mount;
> +static struct kobject *selinuxfs_kobj;
>  
>  static int __init init_sel_fs(void)
>  {
> @@ -1904,9 +1905,16 @@ static int __init init_sel_fs(void)
>  
>  	if (!selinux_enabled)
>  		return 0;
> +
> +	selinux_kobj = kobject_create_and_add("selinux", fs_kobj);
> +	if (!selinux_kobj)
> +		return -ENOMEM;
> +
>  	err = register_filesystem(&sel_fs_type);
> -	if (err)
> +	if (err) {
> +		kobject_put(selinux_kobj);
>  		return err;
> +	}
>  
>  	selinuxfs_mount = kern_mount(&sel_fs_type);
>  	if (IS_ERR(selinuxfs_mount)) {
> @@ -1923,6 +1931,7 @@ __initcall(init_sel_fs);
>  #ifdef CONFIG_SECURITY_SELINUX_DISABLE
>  void exit_sel_fs(void)
>  {
> +	kobjext_put(selinux_kobj);
>  	unregister_filesystem(&sel_fs_type);
>  }
>  #endif
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
