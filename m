Message-ID: <552EAE75.6010003@tycho.nsa.gov>
Date: Wed, 15 Apr 2015 14:31:17 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Ben Shelton <ben.shelton@ni.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libselinux: Mount procfs before checking /proc/filesystems
References: <1429121511-16449-1-git-send-email-ben.shelton@ni.com>
In-Reply-To: <1429121511-16449-1-git-send-email-ben.shelton@ni.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/15/2015 02:11 PM, Ben Shelton wrote:
> In the case where the SELinux security module is not loaded in the
> kernel and it's early enough in the boot process that /proc has not yet
> been mounted, selinuxfs_exists() will incorrectly return 1, and
> selinux_init_load_policy() will print a message like this to the
> console:
> 
> Mount failed for selinuxfs on /sys/fs/selinux:  No such file or directory
> 
> To fix this, mount the procfs before attempting to open
> /proc/filesystems, and unmount it when done if it was initially not
> mounted.  This is the same thing that selinux_init_load_policy() does
> when reading /proc/cmdline.
> 
> Signed-off-by: Ben Shelton <ben.shelton@ni.com>
> ---
>  libselinux/src/init.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/libselinux/src/init.c b/libselinux/src/init.c
> index 6d1ef33..507f17e 100644
> --- a/libselinux/src/init.c
> +++ b/libselinux/src/init.c
> @@ -54,15 +54,20 @@ static int verify_selinuxmnt(const char *mnt)
>  
>  int selinuxfs_exists(void)
>  {
> -	int exists = 0;
> +	int exists = 0, mnt_rc = 0;
>  	FILE *fp = NULL;
>  	char *buf = NULL;
>  	size_t len;
>  	ssize_t num;
>  
> +	mnt_rc = mount("proc", "/proc", "proc", 0, 0);

You need to add a #include <sys/mount.h>

> +
>  	fp = fopen("/proc/filesystems", "r");
> -	if (!fp)
> -		return 1; /* Fail as if it exists */
> +	if (!fp) {
> +		exists = 1; /* Fail as if it exists */
> +		goto out;
> +	}
> +
>  	__fsetlocking(fp, FSETLOCKING_BYCALLER);
>  
>  	num = getline(&buf, &len, fp);
> @@ -76,6 +81,14 @@ int selinuxfs_exists(void)
>  
>  	free(buf);
>  	fclose(fp);
> +
> +out:
> +#ifndef MNT_DETACH
> +#define MNT_DETACH 2
> +#endif
> +	if (mnt_rc == 0)
> +		umount2("/proc", MNT_DETACH);
> +
>  	return exists;
>  }
>  hidden_def(selinuxfs_exists)
> 
