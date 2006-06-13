Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5DI3gfx001677
	for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2006 14:03:42 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id k5DI3f16016430
	for <selinux@tycho.nsa.gov>; Tue, 13 Jun 2006 18:03:41 GMT
Message-ID: <448EFE0E.3050007@gentoo.org>
Date: Tue, 13 Jun 2006 14:03:58 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: Mario Fanelli <mario.fanelli@gmail.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: R: PaX and SELinux
References: <448eef7b.4152ae7d.2d8c.ffff8908@mx.gmail.com>
In-Reply-To: <448eef7b.4152ae7d.2d8c.ffff8908@mx.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Mario Fanelli wrote:
> <snip>
> Where can I find anything about SELinux memory protection? Can I install PaX
> as patch without problem?
>   

http://people.redhat.com/drepper/selinux-mem.html
http://people.redhat.com/drepper/textrelocs.html

Yes, the patch should not cause any problems.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
