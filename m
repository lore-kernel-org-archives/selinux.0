Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA08249
	for <selinux@tycho.nsa.gov>; Mon, 6 May 2002 23:44:57 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id DAA05566
	for <selinux@tycho.nsa.gov>; Tue, 7 May 2002 03:43:43 GMT
Received: from dugite.os2.ami.com.au (IDENT:xfKbb7QKtzr7KkuLUp8//jIY235Ubs8I@c0s21.ami.com.au [203.55.31.86])
        by jazzband.ncsc.mil  with ESMTP id DAA05562 for <selinux@tycho.nsa.gov>; Tue, 7 May 2002 03:43:31 GMT
Received: from numbat.Os2.Ami.Com.Au (numbat.os2.ami.com.au [192.168.1.9])
	by dugite.os2.ami.com.au (8.11.6/8.11.2) with ESMTP id g473i8o22895
	for <selinux@tycho.nsa.gov>; Tue, 7 May 2002 11:44:08 +0800
Received: from numbat.Os2.Ami.Com.Au (summer@localhost)
	by numbat.Os2.Ami.Com.Au (8.11.6/8.11.6) with ESMTP id g473hst24495
	for <selinux@tycho.nsa.gov>; Tue, 7 May 2002 11:43:54 +0800
Message-Id: <200205070343.g473hst24495@numbat.Os2.Ami.Com.Au>
To: selinux@tycho.nsa.gov
Subject: Re: ppp 
In-Reply-To: Your message of "Tue, 07 May 2002 08:23:07 +1000."
             <20020506233551.8198F312B@lyta.coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 07 May 2002 11:43:54 +0800
From: John Summerfield <summer@os2.ami.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> It is common to install pppd in such a fashion that it can be run as 
> "pppd call server" by a regular user.
> 
> The problem is that it often starts daemons from it's ip-up script once it 
> connects, and such daemons aren't allowed to be in user_r!
> 
> I notice that the policy directive for doing an automatic role transition is 
> now deprecated.
> 
> I am thinking of writing a pppd wrapper program which runs it as 
> "system_u:system_r:pppd_t", what do you think?


There is a wrapper in Red Hat Linux. Look for usernetctl

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
