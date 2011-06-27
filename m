Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p5RGlW0L015046
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2011 12:47:32 -0400
Received: from cp-out7.libero.it (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p5RGlU8Q009057
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2011 16:47:31 GMT
Message-ID: <4E08B41F.80608@trentalancia.com>
Date: Mon, 27 Jun 2011 18:47:27 +0200
From: Guido Trentalancia <guido@trentalancia.com>
MIME-Version: 1.0
To: Sam Gandhi <samgandhi9@gmail.com>
CC: selinux@tycho.nsa.gov
Subject: Re: login process unable to execute /bin/sh
References: <BANLkTiknN0tGP7xJmUO7Enxmqw2TjtgVKg@mail.gmail.com>
In-Reply-To: <BANLkTiknN0tGP7xJmUO7Enxmqw2TjtgVKg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello Sam !

At a very first sight, I have spotted something...

On 27/06/2011 17:44, Sam Gandhi wrote:
> I have labelled login and sh as shown below.
>
> -rwxr-xr-x    1     25024 Jun 24 22:20 system_u:object_r:login_exec_t
>   /bin/login
> -rwxr-xr-x    1          15 Jun 24 18:40 system_u:object_r:bin_t
>     /bin/sh
>
> Following is output of ps -Z
>        1 system_u:system_r:init_t         S    init
>    583 system_u:system_r:local_login_t  S    login -- root
>
> But when I login I see these messages :
>
> Jan  1 10:00:23 192.168.137.1 kernel: type=1400 audit(23.040:40): avc:
>   granted  { transition } for  pid=596 comm="getty" path="/bin/login"
> dev=ubifs ino=99 scontext=system_u:system_r:initrc_t
> tcontext=system_u:system_r:local_login_t tclass=process

This is one way, granted.

> Jun 28 01:30:17 192.168.137.1 kernel: type=1400
> audit(1309188617.348:46): avc:  denied  { transition } for  pid=833
> comm="login" path="/bin/sh" dev=ubifs ino=93
> scontext=system_u:system_r:local_login_t
> tcontext=root:system_r:initrc_t tclass=process

Now this is the other way, there's no rule !

> I do see following statement in policy.conf (monolithic)
>
> allow local_login_t initrc_t:process transition;

Perhaps, you should try adding the other rule ?

allow initrc_t local_login_t:process transition;

[cut]

> Can someone PLEASE help me understand why login processes is not being
> allowed to transition to /bin/sh and what do I need to do fix this?
>
> Regards,
> -Sam

Hope it helps.

Regards,

Guido

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
