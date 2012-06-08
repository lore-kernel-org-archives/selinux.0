From: Paul Moore <paul@paul-moore.com>
To: Chris PeBenito <cpebenito@tresys.com>
Cc: SELinux@tycho.nsa.gov
Subject: Re: [PATCH 2/2] Update SELinux policy capability to always check peer class.
Date: Fri, 08 Jun 2012 13:36:44 -0400
Message-ID: <4945649.oOvInFXCG6@sifl>
In-Reply-To: <1339093682-5113-2-git-send-email-cpebenito@tresys.com>
References: <1339093682-5113-1-git-send-email-cpebenito@tresys.com> <1339093682-5113-2-git-send-email-cpebenito@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thursday, June 07, 2012 02:28:02 PM Chris PeBenito wrote:
> Update the always_check_network policy capability which, when enabled,
> treats peer labeling as enabled, even if there is no Netlabel or
> labeled IPSEC configuration.
> 
> Signed-off-by: Chris PeBenito <cpebenito@tresys.com>

...

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index ec7151b..e8f612e 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -149,6 +149,24 @@ static int selinux_secmark_enabled(void)
> +static int selinux_peerlbl_enabled(void)
> +{
> +	if (selinux_policycap_alwaysnetwork)
> +		return 1;
> +	else
> +		return (netlbl_enabled() || selinux_xfrm_enabled());
> +}

Why not make this more consistent?

  return (selinux_policycap_alwaysnetwork || ...

-- 
paul moore
www.paul-moore.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
