Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7RHoioe023085
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 13:50:44 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7RHogQS018992
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 17:50:44 GMT
Subject: Re: [PATCH] refpolicy: apps_games changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708021958.l72JwPPn029497@redsox.boston.devel.redhat.com>
References: <200708021958.l72JwPPn029497@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Mon, 27 Aug 2007 13:49:40 -0400
Message-Id: <1188236980.6723.29.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 15:58 -0400, dwalsh@redhat.com wrote:
> Path changes for game

Merged.

> --- nsaserefpolicy/policy/modules/apps/games.fc 2007-05-29 14:10:48.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/apps/games.fc      2007-08-02 11:02:02.000000000 -0400
> @@ -1,22 +1,16 @@
>  #
>  # /usr
>  #
> -/usr/games/powermanga  --      gen_context(system_u:object_r:games_exec_t,s0)
> -/usr/games/nethack-3.4.3/nethack -- gen_context(system_u:object_r:games_exec_t,s0)
> -/usr/games/vulturesclaw/vulturesclaw -- gen_context(system_u:object_r:games_exec_t,s0)
> -/usr/games/vultureseye/vultureseye -- gen_context(system_u:object_r:games_exec_t,s0)
> -
>  /usr/lib/games(/.*)?           gen_context(system_u:object_r:games_exec_t,s0)
> +/usr/games/.*          --      gen_context(system_u:object_r:games_exec_t,s0)
> 
>  #
>  # /var
>  #
>  /var/lib/games(/.*)?           gen_context(system_u:object_r:games_data_t,s0)
> -
> -ifdef(`distro_debian', `
> -/usr/games/.*          --      gen_context(system_u:object_r:games_exec_t,s0)
>  /var/games(/.*)?               gen_context(system_u:object_r:games_data_t,s0)
> -', `
> +
> +ifdef(`distro_debian', `', `
>  /usr/bin/micq          --      gen_context(system_u:object_r:games_exec_t,s0)
>  /usr/bin/blackjack     --      gen_context(system_u:object_r:games_exec_t,s0)
>  /usr/bin/gataxx                --      gen_context(system_u:object_r:games_exec_t,s0)
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
