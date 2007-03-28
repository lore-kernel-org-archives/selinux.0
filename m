Subject: Re: [PATCH 2/3] Refpolicy: remove a duplicate rule in the ipsec.te
	file
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Paul Moore <paul.moore@hp.com>
Cc: selinux@tycho.nsa.gov, dwalsh@redhat.com, sds@tycho.nsa.gov
In-Reply-To: <20070309203511.778297290@hp.com>
References: <20070309203327.709750017@hp.com>
	 <20070309203511.778297290@hp.com>
Content-Type: text/plain
Date: Wed, 28 Mar 2007 13:43:23 -0400
Message-Id: <1175103803.29300.99.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-03-09 at 16:33 -0400, Paul Moore wrote:
> The "seutil_read_config(setkey_t)" rule is duplicated in the IPsec
> policy file,
> it is possibile that the first occurrence is intended to be for the
> racoon_t
> domain but we'll just remove for now.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>

Merged.

> ---
>  policy/modules/system/ipsec.te |    2 --
>  1 file changed, 2 deletions(-)
> 
> Index: refpolicy/policy/modules/system/ipsec.te
> ===================================================================
> --- refpolicy.orig/policy/modules/system/ipsec.te
> +++ refpolicy/policy/modules/system/ipsec.te
> @@ -333,8 +333,6 @@ logging_send_syslog_msg(racoon_t)
> 
>  miscfiles_read_localization(racoon_t)
> 
> -seutil_read_config(setkey_t)
> -
>  ########################################
>  #
>  # Setkey local policy
> 
> --
> paul moore
> linux security @ hp
> 
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
