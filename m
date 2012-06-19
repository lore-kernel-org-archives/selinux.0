Message-ID: <1340107289.18291.15.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH kernel/goldfish] enable secmark labeling for SE Android
 network access controls
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux@tycho.nsa.gov, method@manicmethod.com
Date: Tue, 19 Jun 2012 08:01:29 -0400
In-Reply-To: <1339872999-30243-6-git-send-email-jbrindle@tresys.com>
References: <1339872999-30243-1-git-send-email-jbrindle@tresys.com>
	 <1339872999-30243-6-git-send-email-jbrindle@tresys.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2012-06-16 at 14:56 -0400, Joshua Brindle wrote:
> Signed-off-by: Joshua Brindle <jbrindle@tresys.com>
> ---
>  arch/x86/configs/i386_defconfig |    4 ++++
>  1 file changed, 4 insertions(+)

I would have expected these changes to go into
arch/x86/configs/goldfish_defconfig,
arch/arm/configs/goldfish_defconfig, and
arch/arm/configs/goldfish_armv7_defconfig.

> 
> diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
> index edba00d..09db997 100644
> --- a/arch/x86/configs/i386_defconfig
> +++ b/arch/x86/configs/i386_defconfig
> @@ -2128,6 +2128,10 @@ CONFIG_SECURITY_NETWORK=y
>  CONFIG_SECURITY_FILE_CAPABILITIES=y
>  # CONFIG_SECURITY_ROOTPLUG is not set
>  CONFIG_SECURITY_DEFAULT_MMAP_MIN_ADDR=65536
> +CONFIG_NETWORK_SECMARK=y
> +CONFIG_NF_CONNTRACK_SECMARK=y
> +CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=y
> +CONFIG_NETFILTER_XT_TARGET_SECMARK=y
>  CONFIG_SECURITY_SELINUX=y
>  CONFIG_SECURITY_SELINUX_BOOTPARAM=y
>  CONFIG_SECURITY_SELINUX_BOOTPARAM_VALUE=1

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
