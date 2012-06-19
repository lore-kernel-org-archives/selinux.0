Message-ID: <1340112421.18291.29.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH kernel/omap] enable secmark labeling for SE Android
 network access controls
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, method@manicmethod.com
Date: Tue, 19 Jun 2012 09:27:01 -0400
In-Reply-To: <1339872999-30243-5-git-send-email-jbrindle@tresys.com>
References: <1339872999-30243-1-git-send-email-jbrindle@tresys.com>
	 <1339872999-30243-5-git-send-email-jbrindle@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2012-06-16 at 14:56 -0400, Joshua Brindle wrote:
> Signed-off-by: Joshua Brindle <jbrindle@tresys.com>
> ---
>  arch/arm/configs/tuna_defconfig |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/configs/tuna_defconfig b/arch/arm/configs/tuna_defconfig
> index b7d903b..775e34b 100644
> --- a/arch/arm/configs/tuna_defconfig
> +++ b/arch/arm/configs/tuna_defconfig
> @@ -435,4 +435,8 @@ CONFIG_SECURITY=y
>  CONFIG_LSM_MMAP_MIN_ADDR=4096
>  CONFIG_SECURITY_NETWORK=y
>  CONFIG_SECURITY_SELINUX=y
> +CONFIG_NETWORK_SECMARK=y
> +CONFIG_NF_CONNTRACK_SECMARK=y
> +CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=y
> +CONFIG_NETFILTER_XT_TARGET_SECMARK=y

Thanks, merged.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
