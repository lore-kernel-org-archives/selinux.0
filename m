Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h6N15XHa023179
	for <selinux@tycho.nsa.gov>; Tue, 22 Jul 2003 21:05:36 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h6N14RFB016188
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 01:04:27 GMT
Received: from mail.rollinghorse.com (dsl093-033-002.snd1.dsl.speakeasy.net [66.93.33.2])
	by jazzswing.ncsc.mil  with ESMTP id h6N14QGD016185
	for <selinux@tycho.nsa.gov>; Wed, 23 Jul 2003 01:04:26 GMT
Message-Id: <5.1.1.6.2.20030722180825.0a101cb0@Shire>
Date: Tue, 22 Jul 2003 18:17:19 -0700
To: Russell Coker <russell@coker.com.au>,
   Charlie Watts <st_possenti@yahoo.com>, selinux@tycho.nsa.gov
From: "Carsten P. Gehrke" <Carsten@rollinghorse.com>
Subject: Re: Linuxfromscratch.org
In-Reply-To: <200307221606.42540.russell@coker.com.au>
References: <20030722014248.34651.qmail@web40613.mail.yahoo.com>
 <20030722014248.34651.qmail@web40613.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

At 13:06 22-07-03, Russell Coker wrote:
>On Mon, 21 Jul 2003 21:42, Charlie Watts wrote:
> > I want to make a linux system from scratch. I have never compiled my
> > own kernel, but I was wondering if i could start with the SE Linux
> > kernel. I am using the instructions from linuxfromscratch.org to make
> > the system on my laptop, which is running Mandrake 9, on a i686, 512Mb
> > ram, and a 1.13 GHz P IV. Ext3 file system. Any advice would be great.
>
>I recommend that you compile your own kernel without SE Linux first, and then
>try using SE Linux after you have had some practise at building your own
>kernel.  Otherwise if you have a problem you won't know whether it's SE Linux
>related or just a general kernel build issue.

I plan to use SE Linux with an LFS system as well.  I have already 
performed on LFS installation, and have built an SEL kernel on a Red Hat 
machine.  Am I correct in assuming that the major problem will be getting 
the access controls and security policies right?  I think LFS differs a bit 
from Red Hat as far as certain users and certain files are concerned, and 
then each LFS system is different because each administrator "rolls his own".

My application for SEL would be as the OS for my firewall.


-- 
Carsten Gehrke     LFS No.: 190    using Linux since kernel 0.98
carsten@gehrke.org


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
