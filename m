Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7LIkNag015298
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 14:46:23 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7LIkKtV022434
	for <selinux@tycho.nsa.gov>; Tue, 21 Aug 2007 18:46:21 GMT
Message-ID: <46CB32F6.3000106@manicmethod.com>
Date: Tue, 21 Aug 2007 14:46:14 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: "Todd C. Miller" <tmiller@tresys.com>
CC: SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] genhomedircon: fix find() return value usage
References: <200708202032.l7KKWWCY009001@tex.courtesan.com>
In-Reply-To: <200708202032.l7KKWWCY009001@tex.courtesan.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Todd C. Miller wrote:
> This patch fixes a bug in the genhomedircon python script that would
> ignore valid entries such as:
>
> /tmp/\.exchange-USER(/.*)?  system_u:object_r:ROLE_evolution_exchange_tmp_t:s0
>
> With this fix the python genhomedircon and the C replacement produce
> equivalent output.
>
>   
Note that this is for the stable branch only, since it conflicts with 
the pending genhomedircon replacement patch for trunk. Does anyone 
object to this going into stable?

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
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>
>   



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
