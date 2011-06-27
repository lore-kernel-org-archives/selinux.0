Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p5RH8kk3016684
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2011 13:08:46 -0400
Received: from mail-ww0-f41.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p5RH8j8Q015827
	for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2011 17:08:45 GMT
Received: by wwi14 with SMTP id 14so2250173wwi.0
        for <selinux@tycho.nsa.gov>; Mon, 27 Jun 2011 10:08:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <BANLkTiknN0tGP7xJmUO7Enxmqw2TjtgVKg@mail.gmail.com>
References: <BANLkTiknN0tGP7xJmUO7Enxmqw2TjtgVKg@mail.gmail.com>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Mon, 27 Jun 2011 13:08:24 -0400
Message-ID: <BANLkTi=US35C1Hvth2iPfxE5FnaDqUgC4g@mail.gmail.com>
Subject: Re: login process unable to execute /bin/sh
To: Sam Gandhi <samgandhi9@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Jun 27, 2011 at 11:44, Sam Gandhi <samgandhi9@gmail.com> wrote:
> I have labelled login and sh as shown below.
>
> -rwxr-xr-x    1     25024 Jun 24 22:20 system_u:object_r:login_exec_t
>  /bin/login
> -rwxr-xr-x    1          15 Jun 24 18:40 system_u:object_r:bin_t
>   /bin/sh
>
> Following is output of ps -Z
>      1 system_u:system_r:init_t         S    init
>  583 system_u:system_r:local_login_t  S    login -- root
>
> But when I login I see these messages :
>
> Jan  1 10:00:23 192.168.137.1 kernel: type=1400 audit(23.040:40): avc:
>  granted  { transition } for  pid=596 comm="getty" path="/bin/login"
> dev=ubifs ino=99 scontext=system_u:system_r:initrc_t
> tcontext=system_u:system_r:local_login_t tclass=process
> Jun 28 01:30:17 192.168.137.1 kernel: type=1400
> audit(1309188617.348:46): avc:  denied  { transition } for  pid=833
> comm="login" path="/bin/sh" dev=ubifs ino=93
> scontext=system_u:system_r:local_login_t
> tcontext=root:system_r:initrc_t tclass=process

I believe your "getty" process should be something like "getty_t",
not "initrc_t", so probably you have the wrong label on /sbin/getty.

I don't remember if this is quite the right command, but something
along the lines of "restorecon -RF /" followed by a reboot *should*
fix all of those issues, assuming your policy file_contexts are right.

Cheers,
Kyle Moffett


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
