Subject: Re: [patch 1/1] libsemanage: genhomedircon remove error on missing
	HOME_DIR or HOME_ROOT
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Caleb Case <ccase@tresys.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1201096436.17665.15.camel@olympus.columbia.tresys.com>
References: <1201096436.17665.15.camel@olympus.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 24 Jan 2008 15:44:30 -0500
Message-Id: <1201207470.21288.146.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 2008-01-23 at 08:53 -0500, Caleb Case wrote:
> Removing failure condition in write_context_file when HOME_DIR or
> HOME_ROOT are not found in the contexts. This condition is not needed
> (the case where the lists are empty is handled correctly) and stops
> otherwise valid operations:
> 
> On a fresh policy store, without any modules loaded:
> 
> # semodule -s refpolicy -b /usr/share/selinux/refpolicy/base.pp
> libsemanage.semanage_install_sandbox: semanage_genhomedircon returned
> error code -1. No such file or directory.
> semodule:  Failed!

Thanks, merged.

(if you later decide that we can completely skip later processing
safely, then feel free to send a follow up patch relative to this one)

> 
> ---
>  src/genhomedircon.c |    4 ----
>  1 file changed, 4 deletions(-)
> 
> Index: libsemanage/src/genhomedircon.c
> ===================================================================
> --- libsemanage.orig/src/genhomedircon.c
> +++ libsemanage/src/genhomedircon.c
> @@ -792,10 +792,6 @@ static int write_context_file(genhomedir
>         homedir_context_tpl = make_template(s, &HOME_DIR_PRED);
>         homeroot_context_tpl = make_template(s, &HOME_ROOT_PRED);
>         user_context_tpl = make_template(s, &USER_CONTEXT_PRED);
> -       if (!homedir_context_tpl || !homeroot_context_tpl) {
> -               retval = STATUS_ERR;
> -               goto done;
> -       }
> 
>         if (setup_fallback_user(s) != 0) {
>                 retval = STATUS_ERR;
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
