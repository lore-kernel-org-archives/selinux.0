Message-ID: <1342728774.5158.8.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH] allow camera calibration
From: Stephen Smalley <sds@tycho.nsa.gov>
To: hqjiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Thu, 19 Jul 2012 16:12:54 -0400
In-Reply-To: <1342719279-29505-1-git-send-email-hqjiang1988@gmail.com>
References: 
	<We label misc/camera(./*) with specific context (camera_calibration_file),>
	 <1342719279-29505-1-git-send-email-hqjiang1988@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2012-07-19 at 10:34 -0700, hqjiang wrote:
> ---
>  file.te        |    1 +
>  file_contexts  |    1 +
>  mediaserver.te |    4 ++++
>  3 files changed, 6 insertions(+), 0 deletions(-)

Applied to external/sepolicy.  Next time, please put the project name in
the subject line.  Also, consider using r_dir_file() for this pattern of
allow rules.

> 
> diff --git a/file.te b/file.te
> index ba85ca5..e5c8502 100644
> --- a/file.te
> +++ b/file.te
> @@ -48,6 +48,7 @@ type systemkeys_data_file, file_type, data_file_type;
>  type wifi_data_file, file_type, data_file_type;
>  type radio_data_file, file_type, data_file_type;
>  type nfc_data_file, file_type, data_file_type;
> +type camera_calibration_file, file_type, data_file_type;
>  # /data/data subdirectories - app sandboxes
>  type app_data_file, file_type, data_file_type;
>  # Default type for anything under /cache
> diff --git a/file_contexts b/file_contexts
> index bb58efe..39c4363 100644
> --- a/file_contexts
> +++ b/file_contexts
> @@ -122,6 +122,7 @@
>  /data/misc/vpn(/.*)?		u:object_r:vpn_data_file:s0
>  /data/misc/systemkeys(/.*)?	u:object_r:systemkeys_data_file:s0
>  /data/misc/wifi(/.*)?		u:object_r:wifi_data_file:s0
> +/data/misc/camera(/.*)?	u:object_r:camera_calibration_file:s0
>  # App sandboxes
>  /data/data/.*		u:object_r:app_data_file:s0
>  # Wallpaper file.
> diff --git a/mediaserver.te b/mediaserver.te
> index c6af603..8d37fb7 100644
> --- a/mediaserver.te
> +++ b/mediaserver.te
> @@ -31,3 +31,7 @@ allow mediaserver rpmsg_device:chr_file rw_file_perms;
>  
>  # Inter System processes communicate over named pipe (FIFO)
>  allow mediaserver system:fifo_file r_file_perms;
> +
> +# Camera calibration
> +allow mediaserver camera_calibration_file:dir r_dir_perms;
> +allow mediaserver camera_calibration_file:file r_file_perms;

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
