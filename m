Subject: Re: [PATCH] SELinux: change Kconfig to use select instead of
	depends
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Eric Paris <eparis@parisplace.org>
Cc: selinux@tycho.nsa.gov, jmorris@namei.org
In-Reply-To: <1170868063.19578.31.camel@localhost.localdomain>
References: <1170868063.19578.31.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 07 Feb 2007 12:07:27 -0500
Message-Id: <1170868047.11912.69.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-02-07 at 12:07 -0500, Eric Paris wrote:
> Changes the security/selinux/Kconfig to use select instead of depends
> for most of the SELinux requirements.  This allows the SELinux option to
> show up when people do a make config without already knowing they had to
> enable audit and other non-obvious choices.  Added a depends on SECURITY
> (which previously existed through SECURITY_NETWORK) so that SELinux
> would not always show up, but would be easy and intuitive to find.

Looks sane; only question I have is whether the NET and INET selection
should happen from SECURITY_NETWORK or NETWORK_SECMARK rather than from
SECURITY_SELINUX (and then selinux would pick it up from there).

> 
> -Eric
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>
> 
>  security/selinux/Kconfig |    7 ++++++-
>  1 files changed, 6 insertions(+), 1 deletions(-)
> 
> diff --git a/security/selinux/Kconfig b/security/selinux/Kconfig
> index 23b5104..42ae47f 100644
> --- a/security/selinux/Kconfig
> +++ b/security/selinux/Kconfig
> @@ -1,6 +1,10 @@
>  config SECURITY_SELINUX
>  	bool "NSA SELinux Support"
> -	depends on SECURITY_NETWORK && AUDIT && NET && INET
> +	depends on SECURITY
> +	select SECURITY_NETWORK
> +	select AUDIT
> +	select NET
> +	select INET
>  	select NETWORK_SECMARK
>  	default n
>  	help
> @@ -9,6 +13,7 @@ config SECURITY_SELINUX
>  	  You can obtain the policy compiler (checkpolicy), the utility for
>  	  labeling filesystems (setfiles), and an example policy configuration
>  	  from <http://www.nsa.gov/selinux/>.
> +
>  	  If you are unsure how to answer this question, answer N.
>  
>  config SECURITY_SELINUX_BOOTPARAM
> 
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
