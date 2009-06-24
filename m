Subject: Re: [PATCH libselinux] check /proc/filesystems before /proc/mounts
 for selinuxfs
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@redhat.com>
Cc: selinux@tycho.nsa.gov, viro@ZenIV.linux.org.uk, method@manicmethod.com
In-Reply-To: <1245873245.11046.6.camel@dhcp235-23.rdu.redhat.com>
References: <1245873245.11046.6.camel@dhcp235-23.rdu.redhat.com>
Content-Type: text/plain
Date: Wed, 24 Jun 2009 16:18:36 -0400
Message-Id: <1245874716.9669.50.camel@moss-pluto.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-06-24 at 15:54 -0400, Eric Paris wrote:
> Al was complaining that he has selinux disabled and has 100,000+ mounts
> in /proc/mounts.  Every time he runs ls the thing takes 5 seconds
> because the libselinux constructor runs the entirety of his /proc/mounts
> looking for selinuxfs, which doesn't exist.  Speed things up by first
> checking for selinuxfs in /proc/filesystems, only if the fs is even
> registered should we bother to run all of /proc/mounts.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> 
> ---
> 
> or alternatively I'd be find if we just bailed when it wasn't /selinux,
> but that's just me.  Does anyone actually put it anywhere else?

That may make sense at this point, given that we now perform the initial
mount of selinuxfs from a libselinux function, and since it seems
unlikely that we will ever change the mount location given that scripts
and users now expect it to live at /selinux.  No strong opinion.

> diff -up libselinux-2.0.80/src/init.c.pre.filesystems libselinux-2.0.80/src/init.c
> --- libselinux-2.0.80/src/init.c.pre.filesystems	2009-06-24 15:34:25.712802612 -0400
> +++ libselinux-2.0.80/src/init.c	2009-06-24 15:39:35.767163619 -0400
> @@ -28,6 +28,7 @@ static void init_selinuxmnt(void)
>  	int rc;
>  	size_t len;
>  	ssize_t num;
> +	int exists = 0;
>  
>  	if (selinux_mnt)
>  		return;
> @@ -44,6 +45,23 @@ static void init_selinuxmnt(void)
>  		}
>  	} 
>  
> +	/* Drop back to detecting it the long way. */
> +	fp = fopen("/proc/filesystems", "r");
> +	if (!fp)
> +		return;
> +
> +	__fsetlocking(fp, FSETLOCKING_BYCALLER);
> +	while ((num = getline(&buf, &len, fp)) != -1) {
> +		if (strstr(buf, "selinuxfs")) {
> +			exists = 1;
> +			break;
> +		}
> +	}
> +	fclose(fp);
> +
> +	if (!exists)
> +		return;
> +
>  	/* At this point, the usual spot doesn't have an selinuxfs so
>  	 * we look around for it */
>  	fp = fopen("/proc/mounts", "r");
> 
> 
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
