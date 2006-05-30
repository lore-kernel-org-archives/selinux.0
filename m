Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4UCJ0K7018949
	for <selinux@tycho.nsa.gov>; Tue, 30 May 2006 08:19:00 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4UCIxv3003977
	for <selinux@tycho.nsa.gov>; Tue, 30 May 2006 12:19:00 GMT
Message-ID: <447C383B.5040808@gentoo.org>
Date: Tue, 30 May 2006 08:19:07 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Mario Fanelli <mario.fanelli@gmail.com>
CC: SeLinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: SELinux and SID
References: <447c0b7f.192f5df9.1cbd.ffff9f01@mx.gmail.com>
In-Reply-To: <447c0b7f.192f5df9.1cbd.ffff9f01@mx.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mario Fanelli wrote:
>
> I read that SELinux uses extended attributes to maintain SID/file 
> mapping, but I have a Fedora Core 5 with an ext3 filesystem but if I 
> use getfattr command on any file I don’t obtain nothing that resembles 
> SID. Am I wrong?
>
> Where does SELinux store SID?
>
You have to tell it what attribute name you want

$ getfattr -n security.selinux .
# file: .
security.selinux="system_u:object_r:root_t:s0\000"



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
