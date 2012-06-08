From: Paul Moore <paul@paul-moore.com>
To: Chris PeBenito <cpebenito@tresys.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: [PATCH 1/2] Add SELinux policy capability for always checking packet class.
Date: Fri, 08 Jun 2012 13:36:35 -0400
Message-ID: <2776660.gCfiz8ed08@sifl>
In-Reply-To: <1339093682-5113-1-git-send-email-cpebenito@tresys.com>
References: <1339093682-5113-1-git-send-email-cpebenito@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, June 07, 2012 02:28:01 PM Chris PeBenito wrote:
> Currently the packet class in SELinux is not checked if there are no
> SECMARK rules in the security or mangle netfilter tables.  Some systems
> prefer that packets are always checked, for example, to protect the system
> should the netfilter rules fail to load or if the nefilter rules
> were maliciously flushed.
> 
> Add the always_check_network policy capability which, when enabled, treats
> SECMARK as enabled, even if there are no netfilter SECMARK rules.
> 
> Signed-off-by: Chris PeBenito <cpebenito@tresys.com>

...

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 372ec65..ec7151b 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c

...

>  static int selinux_secmark_enabled(void)
>  {
> -	return (atomic_read(&selinux_secmark_refcount) > 0);
> +	if (selinux_policycap_alwaysnetwork)
> +		return 1;
> +	else
> +		return (atomic_read(&selinux_secmark_refcount) > 0);
>  }

Nit picky, but why not simply:

  return (selinux_policycap_alwaysnetwork || atomic_read( ...

>  /*
> diff --git a/security/selinux/include/security.h
> b/security/selinux/include/security.h index dde2005..981c4ac 100644
> --- a/security/selinux/include/security.h
> +++ b/security/selinux/include/security.h
> @@ -68,12 +68,14 @@ extern int selinux_enabled;
>  enum {
>  	POLICYDB_CAPABILITY_NETPEER,
>  	POLICYDB_CAPABILITY_OPENPERM,
> +	POLICYDB_CAPABILITY_ALWAYSNETWORK,
>  	__POLICYDB_CAPABILITY_MAX
>  };
>  #define POLICYDB_CAPABILITY_MAX (__POLICYDB_CAPABILITY_MAX - 1)
> 
>  extern int selinux_policycap_netpeer;
>  extern int selinux_policycap_openperm;
> +extern int selinux_policycap_alwaysnetwork;

Also nit picky, but it would seem like "selinux_policycap_netalways" is a bit 
more consistent with the other variables.

> diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
> index 3ad2902..cb893f9 100644
> --- a/security/selinux/selinuxfs.c
> +++ b/security/selinux/selinuxfs.c
> @@ -44,7 +44,8 @@
>  /* Policy capability filenames */
>  static char *policycap_names[] = {
>  	"network_peer_controls",
> -	"open_perms"
> +	"open_perms",
> +	"always_check_network"
>  };

Similarly, I think "network_always" is more consistent.
 
> a/security/selinux/ss/services.c b/security/selinux/ss/services.c index
> 4321b8f..e124d8f 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -72,6 +72,7 @@
> 
>  int selinux_policycap_netpeer;
>  int selinux_policycap_openperm;
> +int selinux_policycap_alwaysnetwork;

See above.
 
-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
