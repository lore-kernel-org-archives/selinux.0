Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA12834
	for <selinux@tycho.nsa.gov>; Sat, 6 Jul 2002 05:24:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id JAA06775
	for <selinux@tycho.nsa.gov>; Sat, 6 Jul 2002 09:22:48 GMT
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
        by jazzband.ncsc.mil  with SMTP id JAA06771 for <selinux@tycho.nsa.gov>; Sat, 6 Jul 2002 09:22:47 GMT
Message-Id: <200207060922.JAA06771@jazzband.ncsc.mil>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carstengrohmann@gmx.de>
To: jw@centraltexasit.com
Subject: Re: ReiserFS, ext3 and other file systems
Date: Sat, 6 Jul 2002 11:24:23 +0200
References: <200207060201.11154.jw@centraltexasit.com>
In-Reply-To: <200207060201.11154.jw@centraltexasit.com>
Cc: selinux@tycho.nsa.gov
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Am Samstag, 6. Juli 2002 09:01 schrieb JW:
> Hello,
>
> I was just reading the install file and I saw the statment, that "if you're
> usign ext3, be sure to enable support for it".

I think it's mean the kernel support in the SELinux kernel.

> What exactly is the nature of "ext3" support? I would not think SE Linux
> would care that much about what FS it was on.
>
> I use ReiserFS, which I am rather fond of -- does SE Linux work on that?

Yes, SELInux works on ext2, ext3 and ReiserFS fine. 

> Thanks,
>
>       JW

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
