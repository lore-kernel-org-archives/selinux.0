Subject: Re: [PATCH 1/1] SELINUX: Bug fix in security_sid_mls_copy
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Venkat Yekkirala <vyekkirala@TrustedCS.com>
Cc: Eric Paris <eparis@parisplace.org>, James Morris <jmorris@namei.org>,
        selinux@tycho.nsa.gov, chanson@TrustedCS.com, jbrindle@tresys.com
In-Reply-To: <450F3ABE.605@trustedcs.com>
References: <450F3ABE.605@trustedcs.com>
Content-Type: text/plain
Date: Tue, 19 Sep 2006 08:40:33 -0400
Message-Id: <1158669633.15340.13.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-09-18 at 19:33 -0500, Venkat Yekkirala wrote:
> The following fixes a bug where random mem is being tampered
> with in the non-mls case; encountered by Jashua Brindle on a
> gentoo box.
> 
> Signed-off-by: Venkat Yekkirala <vyekkirala@TrustedCS.com>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

> ---
> 
> PS: NOT SURE IF THIS ALSO NEEDS TO BE SENT TO NETDEV. PLEASE LET
> ME KNOW IF I SHOULD.

Yes.  Note that it is for 2.6.19 as well as a bug fix for the prior
patches.

> 
> diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
> index 27ee28c..7eb69a6 100644
> --- a/security/selinux/ss/services.c
> +++ b/security/selinux/ss/services.c
> @@ -1841,7 +1841,7 @@ int security_sid_mls_copy(u32 sid, u32 m
>  	u32 len;
>  	int rc = 0;
>  
> -	if (!ss_initialized) {
> +	if (!ss_initialized || !selinux_mls_enabled) {
>  		*new_sid = sid;
>  		goto out;
>  	}
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
