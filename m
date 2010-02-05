MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] libselinux:  Only audit permissions specified by the policy
Date: Fri, 5 Feb 2010 14:45:27 -0500
Message-ID: <06A6610D4F464D4EBEAFBF2C5F86911E01A16F64@exchange2.columbia.tresys.com>
In-Reply-To: <1265379881.18100.43.camel@moss-pluto.epoch.ncsc.mil>
References: <1265379881.18100.43.camel@moss-pluto.epoch.ncsc.mil>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>, <selinux@tycho.nsa.gov>
Cc: "Chad Sellers" <csellers@tresys.com>, "Eamon Walsh" <ewalsh@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 2010-02-05 Stephen Smalley wrote:
> Only audit the permissions specified by the policy, excluding any
> permissions specified via dontaudit or not specified via auditallow.
> This only shows up when a single avc_has_perm() call is made with
> multiple permissions where some of those permissions are dontaudit'd
or
> auditallow'd while others are not.  The corresponding kernel patch has
> already been applied, see:
> http://git.kernel.org/?p=linux/kernel/git/jmorris/security-testing-
> 2.6.git;a=commit;h=b6cac5a30b325e14cda425670bb3568d3cad0aa8
> 
> Signed-off-by:  Stephen D. Smalley <sds@tycho.nsa.gov>
> 

Acked-by: Joshua Brindle <method@manicmethod.com>

> ---
> 
>  libselinux/src/avc.c |   17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> diff --git a/libselinux/src/avc.c b/libselinux/src/avc.c index
> 1c62fa3..881b915 100644
> --- a/libselinux/src/avc.c
> +++ b/libselinux/src/avc.c
> @@ -694,17 +694,14 @@ void avc_audit(security_id_t ssid, security_id_t
> tsid,
>  	access_vector_t denied, audited;
>  
>  	denied = requested & ~avd->allowed;
> -	if (denied) {
> -		audited = denied;
> -		if (!(audited & avd->auditdeny))
> -			return;
> -	} else if (!requested || result) {
> +	if (denied)
> +		audited = denied & avd->auditdeny;
> +	else if (!requested || result)
>  		audited = denied = requested;
> -	} else {
> -		audited = requested;
> -		if (!(audited & avd->auditallow))
> -			return;
> -	}
> +	else
> +		audited = requested & avd->auditallow;
> +	if (!audited)
> +		return;
>  #if 0
>  	if (!check_avc_ratelimit())
>  		return;






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
