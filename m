Subject: Re: [PATCH] genhomedircon: fix find() return value usage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: "Todd C. Miller" <tmiller@tresys.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <200708202032.l7KKWWCY009001@tex.courtesan.com>
References: <200708202032.l7KKWWCY009001@tex.courtesan.com>
Content-Type: text/plain
Date: Thu, 23 Aug 2007 10:57:12 -0400
Message-Id: <1187881032.1451.493.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-08-20 at 16:32 -0400, Todd C. Miller wrote:
> This patch fixes a bug in the genhomedircon python script that would
> ignore valid entries such as:
> 
> /tmp/\.exchange-USER(/.*)?  system_u:object_r:ROLE_evolution_exchange_tmp_t:s0
> 
> With this fix the python genhomedircon and the C replacement produce
> equivalent output.
> 
> Signed-Off-By: Todd Miller <tmiller@tresys.com>
> 
> Index: policycoreutils/scripts/genhomedircon
> ===================================================================
> --- policycoreutils/scripts/genhomedircon	(revision 2519)
> +++ policycoreutils/scripts/genhomedircon	(working copy)
> @@ -272,7 +272,7 @@
>  		ret = ""
>  		fd = open(self.getHomeDirTemplate(), 'r')
>  		for i in  fd.readlines():
> -			if i.find("USER") == 1:
> +			if i.find("USER") >= 0:
>  				i = i.replace("USER", user)
>  				i = i.replace("ROLE", prefix)
>  				i = i.replace("system_u", sel_user)
> 

Thanks, merged to stable and trunk.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
