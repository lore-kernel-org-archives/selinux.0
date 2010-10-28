Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9SDMplM003667
	for <selinux@tycho.nsa.gov>; Thu, 28 Oct 2010 09:22:51 -0400
Received: from mail-pw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o9SDMmLb021458
	for <selinux@tycho.nsa.gov>; Thu, 28 Oct 2010 13:22:48 GMT
Received: by pwj10 with SMTP id 10so8448pwj.12
        for <selinux@tycho.nsa.gov>; Thu, 28 Oct 2010 06:22:47 -0700 (PDT)
Message-ID: <4CC97953.60306@gmail.com>
Date: Thu, 28 Oct 2010 06:23:31 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: imsand@puzzle.ch
CC: Daniel J Walsh <dwalsh@redhat.com>, Chad Sellers <csellers@tresys.com>,
        selinux@tycho.nsa.gov
Subject: Re: Context settings after ssh login
References: <C8D3542D.BAC90%csellers@tresys.com>    <4CADF149.3040301@redhat.com> <4CAE025C.6010005@gmail.com>    <44256.193.5.216.100.1287499358.squirrel@mail.puzzle.ch>    <4CBDB14E.2030207@gmail.com>    <12764.193.5.216.100.1287503226.squirrel@mail.puzzle.ch>    <4CBDC997.6030800@gmail.com>    <10617.193.5.216.100.1287564131.squirrel@mail.puzzle.ch>    <4CBEF2B4.3050408@gmail.com>    <35906.193.5.216.100.1287584724.squirrel@mail.puzzle.ch>    <4CC3400C.8060004@gmail.com>    <30707.193.5.216.100.1287990574.squirrel@mail.puzzle.ch>    <4CC53877.7040106@gmail.com> <4CC53E5F.8060708@gmail.com> <24565.193.5.216.100.1288081632.squirrel@mail.puzzle.ch>
In-Reply-To: <24565.193.5.216.100.1288081632.squirrel@mail.puzzle.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

  hows the status with this? have you made any progreess.. one thing 
I've noticed over here, is if I use the login:
/usr/sbin/semodule login -a -s staff_u justin

sshd seems to default to user_r:user_t*  but if I tweak the login to my 
name and adjust
/etc/selinux/{$policy}/contexts/users/* to my choosen role it works to 
the modified
role(my guesss is it's maybe something with th uuid or something)

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
