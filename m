Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i69BCKrT018548
	for <selinux@tycho.nsa.gov>; Fri, 9 Jul 2004 07:12:20 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i69BCGNR002272
	for <selinux@tycho.nsa.gov>; Fri, 9 Jul 2004 11:12:18 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Bradley Chapman <kakadu@gmail.com>
Subject: Re: An SELinux policy for Red Hat 9
Date: Fri, 9 Jul 2004 21:11:55 +1000
Cc: selinux@tycho.nsa.gov
References: <e294b46e040708131736c57b6@mail.gmail.com>
In-Reply-To: <e294b46e040708131736c57b6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200407092111.55045.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 9 Jul 2004 06:17, Bradley Chapman <kakadu@gmail.com> wrote:
> Does anyone know of a good place where I can start reading about how
> to adapt, or obtain, an SELinux policy for Red Hat 9, running the
> 2.6.7 kernel with the SELinux userspace package dated 20040628-16?

Why would you want to do that?  Consider Fedora Core 1 as RHL 10, and FC2 as 
RHL 11 an just upgrade a couple of versions to get SE Linux support.

But if you REALLY want to use RHL 9, the current policy should work OK, you 
just have to make the appropriate changes to pam, logrotate, cron, coreutils, 
etc.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
