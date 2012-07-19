Message-ID: <1342728518.5158.5.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 1/1] GPS chip requires uart rts level control
From: Stephen Smalley <sds@tycho.nsa.gov>
To: jinlin <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com,
        jinlin
	 <jinlin.xu@sta.samsung.com>
Date: Thu, 19 Jul 2012 16:08:38 -0400
In-Reply-To: <1342305889-7675-1-git-send-email-jinlin.xu@sta.samsung.com>
References: <1342305889-7675-1-git-send-email-jinlin.xu@sta.samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2012-07-14 at 15:44 -0700, jinlin wrote:
> ---
>  sepolicy.genfs_contexts |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>  create mode 100644 sepolicy.genfs_contexts

Need to specify project on the subject line, keep the subject line
description short, and put the longer description in the body, e.g.
Subject: [PATCH 1/1] device/samsung/tuna: label gps chip

Also seems to be duplicated in a later patch.

> 
> diff --git a/sepolicy.genfs_contexts b/sepolicy.genfs_contexts
> new file mode 100644
> index 0000000..56ef603
> --- /dev/null
> +++ b/sepolicy.genfs_contexts
> @@ -0,0 +1,2 @@
> +# This proc entry is for CSR GPS chip on Samsung Tuna Board.
> +genfscon proc /mcspi1_cs3_ctrl u:object_r:gps_control:s0

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
