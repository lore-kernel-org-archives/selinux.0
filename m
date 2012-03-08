Subject: Re: [PATCH] (SCH-i515 US LTE) Modified init.tuna.rc for proper
 labeling of /factory/* files.[PUBLIC DOMAIN]
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Bryan Hinton <bryan@bryanhinton.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1331083918-5820-1-git-send-email-bryan@bryanhinton.com>
References: <1331083918-5820-1-git-send-email-bryan@bryanhinton.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Mar 2012 10:29:39 -0500
Message-ID: <1331220579.13585.90.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-03-06 at 19:31 -0600, Bryan Hinton wrote:
> Change-Id: I48f8623ec24728517597fcd77c9c7f3fab5db9be
> ---
>  init.tuna.rc |   18 +++++++++++++++++-
>  1 files changed, 17 insertions(+), 1 deletions(-)
> 
> diff --git a/init.tuna.rc b/init.tuna.rc
> index 70f1cbe..354c292 100755
> --- a/init.tuna.rc
> +++ b/init.tuna.rc
> @@ -23,6 +23,9 @@ on post-fs-data
>  	mkdir /data/misc/camera 0770 media media
>  	mkdir /data/misc/camera/R5_MVEN003_LD2_ND0_IR0_SH0_FL1_SVEN003_DCCID1044 0770 media media
>  
> +   # remount factory as read-only
> +   mount ext4 /dev/block/platform/omap/omap_hsmmc.0/by-name/efs /factory ro remount
> +

Indentation/whitespace should match the rest of the file.  In this file,
they seem to use tabs rather than spaces.  This applies through the
changes to this file.

Also, could we do this particular change earlier, right after the
restorecon calls below?  Any reason to wait until post-fs-data?  Likely
safer to make it read-only as early as possible.

>  	setprop vold.post_fs_data_done 1
>  
>  # LTE
> @@ -56,7 +59,11 @@ on fs
>  	setprop ro.crypto.tmpfs_options size=128m,mode=0771,uid=1000,gid=1000
>  	mount ext4 /dev/block/platform/omap/omap_hsmmc.0/by-name/userdata /data wait noatime nosuid nodev nomblk_io_submit,errors=panic
>  	mount ext4 /dev/block/platform/omap/omap_hsmmc.0/by-name/cache /cache wait noatime nosuid nodev nomblk_io_submit,errors=panic
> -	mount ext4 /dev/block/platform/omap/omap_hsmmc.0/by-name/efs /factory wait ro
> +	mount ext4 /dev/block/platform/omap/omap_hsmmc.0/by-name/efs /factory wait
> +   chown radio radio /factory

They do a chown radio radio /factor down further below (along with
chmod), so you could just move the restorecon calls right after the
chown/chmod calls.  Seems like the fact that they mount it ro originally
is a bug since the chown/chmod won't work then either.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
