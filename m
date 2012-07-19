Message-ID: <1342728541.5158.6.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 1/1] add sepolicy.genfs_contexts file for
 device-specific labels
From: Stephen Smalley <sds@tycho.nsa.gov>
To: jinlin <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com,
        jinlin
	 <jinlin.xu@sta.samsung.com>
Date: Thu, 19 Jul 2012 16:09:01 -0400
In-Reply-To: <1342305889-7675-2-git-send-email-jinlin.xu@sta.samsung.com>
References: <1342305889-7675-1-git-send-email-jinlin.xu@sta.samsung.com>
	 <1342305889-7675-2-git-send-email-jinlin.xu@sta.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2012-07-14 at 15:44 -0700, jinlin wrote:
> ---
>  sepolicy.genfs_contexts |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 sepolicy.genfs_contexts

For which project(s)?  device/samsung/maguro?  Put it in the subject
line.

> 
> diff --git a/sepolicy.genfs_contexts b/sepolicy.genfs_contexts
> new file mode 100644
> index 0000000..4a4f32a
> --- /dev/null
> +++ b/sepolicy.genfs_contexts
> @@ -0,0 +1 @@
> +include(`device/samsung/tuna/sepolicy.genfs_contexts')

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
