Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7RF04X6008527
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 11:00:04 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l7RF02nP014704
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 15:00:02 GMT
Received: by an-out-0708.google.com with SMTP id c38so239872ana
        for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 08:00:02 -0700 (PDT)
Message-ID: <4a93f8270708270800o499f6c38sbd5363690e1976d5@mail.gmail.com>
Date: Mon, 27 Aug 2007 22:00:02 +0700
From: W <wildan.m@gmail.com>
To: selinux@tycho.nsa.gov
Subject: selinux avr32 port
Cc: "J Boedianto" <j.boedianto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Dear All,

Does any one here work on porting selinux to avr32 ? it's possible ?

I need this library to compile e2fsprogs  which use selinux by default
(if we enable  device mapper support/--enable-blkid-devmapper),

i can't find any way to disable selinux support on e2fsprogs ..

I hope this is the right mailing list to ask regarding this problem ..

Best Regards,
Wildan

-- 
---
Person who say it cannot be done should not interrupt person doing it.
Coz.....
Miracles are closer than you think ...
------------
http://wildanm.fisika.ui.edu
HP: 08888378594
Y! : hawking_123

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
