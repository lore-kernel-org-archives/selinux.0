Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o7NGs3Co003302
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2010 12:54:03 -0400
Received: from mail-pv0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o7NGrqlL000907
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2010 16:53:52 GMT
Received: by pvg16 with SMTP id 16so2407196pvg.12
        for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2010 09:54:00 -0700 (PDT)
Message-ID: <4C72A7CB.1020105@gmail.com>
Date: Mon, 23 Aug 2010 09:54:35 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: imsand@puzzle.ch
CC: selinux@tycho.nsa.gov
Subject: Re: Enable selinux in SLES 11
References: <28077.193.5.216.100.1282569834.squirrel@mail.puzzle.ch>
In-Reply-To: <28077.193.5.216.100.1282569834.squirrel@mail.puzzle.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/23/2010 06:23 AM, imsand@puzzle.ch wrote:
> Hello Everybody
>
> For quite a while I've been trying to enable selinux in SLES11, but
> sestatus always show DISABLED.
>
> The following steps I've already done:
>    * installed all *selinux* packages from yast2
>    * add the following boot parameters to the kernel: security=selinux
> selinux=1 enforcing=0
>    * created /etc/selinux/config file with the that content:
>      SELINUX=enforcing
>      SELINUXTYPE=targeted
>
> What I've noticed is, that /selinux doesn't exit. I can't create that
> mountpoint manually because selinuxfs filesystem doesn't exist.
>
> Does anybody knows if that could be the reason? and if so, how do i get
> selinux work on SLES 11.
> (As far as I know SLES 11 should be prepared to use selinux as technical
> preview).
>
> Thanks in advance
> Matthias
>
>
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
>


should be working(at-least for opensuse 12),you need to mkdir /selinux
then reboot(SELinux will mount it's file-system there(but cant if the 
mount-point doesn't exist)).

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
