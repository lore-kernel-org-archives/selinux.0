Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9PFUIeC028500
	for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2010 11:30:18 -0400
Received: from mail-pz0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o9NK4tK1016108
	for <selinux@tycho.nsa.gov>; Sat, 23 Oct 2010 20:04:56 GMT
Received: by pzk7 with SMTP id 7so488578pzk.12
        for <selinux@tycho.nsa.gov>; Sat, 23 Oct 2010 13:04:55 -0700 (PDT)
Message-ID: <4CC3400C.8060004@gmail.com>
Date: Sat, 23 Oct 2010 13:05:32 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: imsand@puzzle.ch
CC: Daniel J Walsh <dwalsh@redhat.com>, Chad Sellers <csellers@tresys.com>,
        selinux@tycho.nsa.gov
Subject: Re: Context settings after ssh login
References: <C8D3542D.BAC90%csellers@tresys.com>    <4CADF149.3040301@redhat.com> <4CAE025C.6010005@gmail.com>    <44256.193.5.216.100.1287499358.squirrel@mail.puzzle.ch>    <4CBDB14E.2030207@gmail.com>    <12764.193.5.216.100.1287503226.squirrel@mail.puzzle.ch>    <4CBDC997.6030800@gmail.com>    <10617.193.5.216.100.1287564131.squirrel@mail.puzzle.ch>    <4CBEF2B4.3050408@gmail.com> <35906.193.5.216.100.1287584724.squirrel@mail.puzzle.ch>
In-Reply-To: <35906.193.5.216.100.1287584724.squirrel@mail.puzzle.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hmm... seem to be receiving this
     **********************************************
     **      THIS IS A WARNING MESSAGE ONLY      **
     **  YOU DO NOT NEED TO RESEND YOUR MESSAGE  **
     **********************************************

The original message was received at Sat, 23 Oct 2010 06:27:55 GMT
from localhost [127.0.0.1]

when sending to selinux...(I have no idea what this is..)

Anyways I fixed(hopefully) the context issue over here(hopefully your 
experiencing something similar)

long story short when I built this package I had left out the
--with-selinux and the --with-pam switches(must have been too tired or 
something)
Anyways now Im able to login and have the correct context with both 
machines(sles11.1, and standard SELinux system)

Im wondering if they might have done the same for you?
(for pam you can change sshd to go to pam by modifying /etc/ssh/sshd_config)

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
