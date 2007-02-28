Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1SEPq5F011605
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 09:25:52 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l1SERC2d016928
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2007 14:27:12 GMT
Subject: Re: Additional Games file context
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45E338DD.5010302@redhat.com>
References: <45E338DD.5010302@redhat.com>
Content-Type: text/plain
Date: Wed, 28 Feb 2007 09:27:00 -0500
Message-Id: <1172672820.11157.55.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 14:45 -0500, Daniel J Walsh wrote:
> plain text document attachment
> (nsaserefpolicy_policy_modules_apps_games.fc)
> --- nsaserefpolicy/policy/modules/apps/games.fc	2006-11-16 17:15:07.000000000 -0500
> +++ serefpolicy-2.5.5/policy/modules/apps/games.fc	2007-02-26 11:04:22.000000000 -0500
> @@ -2,6 +2,10 @@
>  # /usr
>  #
>  /usr/lib/games(/.*)? 		gen_context(system_u:object_r:games_exec_t,s0)
> +/usr/games/vulturesclaw/vulturesclaw -- gen_context(system_u:object_r:games_exec_t,s0)
> +/usr/games/powermanga -- gen_context(system_u:object_r:games_exec_t,s0)
> +/usr/games/nethack-3.4.3/nethack --      gen_context(system_u:object_r:games_exec_t,s0)
> +
>  
>  #
>  # /var

Merged, with a little reordering.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
