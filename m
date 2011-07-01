Subject: Re: login process unable to execute /bin/sh
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Sam Gandhi <samgandhi9@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <BANLkTiknN0tGP7xJmUO7Enxmqw2TjtgVKg@mail.gmail.com>
References: <BANLkTiknN0tGP7xJmUO7Enxmqw2TjtgVKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 01 Jul 2011 09:24:06 -0400
Message-ID: <1309526646.31276.3.camel@moss-pluto>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2011-06-27 at 08:44 -0700, Sam Gandhi wrote:
> I have labelled login and sh as shown below.
> 
> -rwxr-xr-x    1     25024 Jun 24 22:20 system_u:object_r:login_exec_t
>  /bin/login
> -rwxr-xr-x    1          15 Jun 24 18:40 system_u:object_r:bin_t
>    /bin/sh
> 
> Following is output of ps -Z
>       1 system_u:system_r:init_t         S    init
>   583 system_u:system_r:local_login_t  S    login -- root
> 
> But when I login I see these messages :
> 
> Jan  1 10:00:23 192.168.137.1 kernel: type=1400 audit(23.040:40): avc:
>  granted  { transition } for  pid=596 comm="getty" path="/bin/login"
> dev=ubifs ino=99 scontext=system_u:system_r:initrc_t
> tcontext=system_u:system_r:local_login_t tclass=process
> Jun 28 01:30:17 192.168.137.1 kernel: type=1400
> audit(1309188617.348:46): avc:  denied  { transition } for  pid=833
> comm="login" path="/bin/sh" dev=ubifs ino=93
> scontext=system_u:system_r:local_login_t
> tcontext=root:system_r:initrc_t tclass=process
> 
> I do see following statement in policy.conf (monolithic)
> 
> allow local_login_t initrc_t:process transition;

Constraint violation.  audit2why would have told you so.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
