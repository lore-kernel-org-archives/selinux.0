Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5MD4aZ3031032
	for <selinux@tycho.nsa.gov>; Sun, 22 Jun 2008 09:04:36 -0400
Received: from mail.seekline.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5MD4YqT007300
	for <selinux@tycho.nsa.gov>; Sun, 22 Jun 2008 13:04:35 GMT
Subject: Re: su command not found
From: Stefan Schulze Frielinghaus <stefan@seekline.net>
To: Shintaro Fujiwara <shintaro.fujiwara@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <f71a82820806220523j36fab57fyec707a3b9d0b5810@mail.gmail.com>
References: <f71a82820806220523j36fab57fyec707a3b9d0b5810@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 22 Jun 2008 15:04:28 +0200
Message-Id: <1214139868.2493.1.camel@vogon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Maybe your logged in as staff_t? Than you're not allowed to execute any
suid file.

On Sun, 2008-06-22 at 21:23 +0900, Shintaro Fujiwara wrote:
> I suddenly came upt to a mesage in F9 that
> 
> $su command not found
> 
> Why??
> 
> -- 
> http://intrajp.no-ip.com/ Home Page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
