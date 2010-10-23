Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o9PCkEwB029716
	for <selinux@tycho.nsa.gov>; Mon, 25 Oct 2010 08:46:14 -0400
Received: from mail-px0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id o9N6Rtto014891
	for <selinux@tycho.nsa.gov>; Sat, 23 Oct 2010 06:27:55 GMT
Received: by pxi3 with SMTP id 3so181254pxi.12
        for <selinux@tycho.nsa.gov>; Fri, 22 Oct 2010 23:27:52 -0700 (PDT)
Message-ID: <4CC2808B.40200@gmail.com>
Date: Fri, 22 Oct 2010 23:28:27 -0700
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

o.k. cleaned up this thread due to it becoming cluttered..

Right now I went and installed sles11.1 unto my machine, and got the 
policy up and running.(just have not defined any allow rules yet).

when using my iphone to sshd into the sles11.1 system Im going into the 
proper context that it should, as well as using another machine with 
SELinux on it.
If I sshd with sles11.1 into the other machine with SELinux I have the 
wrong login context, as well as using the iphone..
both give this:
iphone/sles11.1 sshd too------>other machine with SELinux gives:
id -Z
system_u:system_r:unconfined_t:s0-s0:c0.c1023

from what I remember I was doing vnc/sshd a few months ago with ipsec, 
and this was working..

abit late over here now, but what I can do is reload the system that I 
compressed and know works, to see if things are running properly, then 
see if I can narrow this down to a bisect or something.

as for sles11.1 itself the only real packages I needed to grab from the 
opensuse repos was git for the kernel, the rest is on the dvd..
(mixing sles11.1 and opensuse 11.1 breaks lots of things...)

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
