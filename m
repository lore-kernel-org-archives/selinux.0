Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA26339
	for <selinux@tycho.nsa.gov>; Wed, 5 Jun 2002 17:36:37 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id VAA26777
	for <selinux@tycho.nsa.gov>; Wed, 5 Jun 2002 21:35:15 GMT
Received: from dugite.summer.ami.com.au (a0s04.ami.com.au [203.55.31.101])
        by jazzband.ncsc.mil  with ESMTP id VAA26765 for <selinux@tycho.nsa.gov>; Wed, 5 Jun 2002 21:34:58 GMT
Received: from numbat.Os2.Ami.Com.Au (numbat.summer.ami.com.au [192.168.1.9])
	by dugite.summer.ami.com.au (8.11.6/8.11.2) with ESMTP id g55LZoA03660
	for <selinux@tycho.nsa.gov>; Thu, 6 Jun 2002 05:35:50 +0800
Received: from numbat.Os2.Ami.Com.Au (summer@localhost)
	by numbat.Os2.Ami.Com.Au (8.11.6/8.11.6) with ESMTP id g55LZoF14397
	for <selinux@tycho.nsa.gov>; Thu, 6 Jun 2002 05:35:50 +0800
Message-Id: <200206052135.g55LZoF14397@numbat.Os2.Ami.Com.Au>
To: selinux@tycho.nsa.gov
Subject: Re: sendmail.fc and RH 7.3 
In-Reply-To: Your message of "05 Jun 2002 12:13:42 -0400."
             <1023293622.1368.5.camel@jsmith.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jun 2002 05:35:50 +0800
From: John Summerfield <summer@os2.ami.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> For some reason, in RH 7.3, sendmail is accessed by double-indirection:
> 
> /usr/sbin/sendmail is a symbolic link to /etc/alternatives/mta, which,
> in turn is a symbolic link to 
> 
>  /usr/sbin/sendmail.sendmail
> 
> (?!), so that you have to augment sendmail.fc to assign the correct type
> to /usr/sbin/sendmail.sendmail.


This is to allow the easy substitution of another MTA -m I forget which is inclluded;-)

There's a similar fiddle to allow switching between cups and LPRng.




-- 
Cheers
John Summerfield

Microsoft's most solid OS: http://www.geocities.com/rcwoolley/

Note: mail delivered to me is deemed to be intended for me, for my disposition.

==============================
If you don't like being told you're wrong,
	be right!




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
