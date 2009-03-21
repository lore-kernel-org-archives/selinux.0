Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n2LIKoMD015744
	for <selinux@tycho.nsa.gov>; Sat, 21 Mar 2009 14:20:50 -0400
Received: from ey-out-1920.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n2LIGvRq007031
	for <selinux@tycho.nsa.gov>; Sat, 21 Mar 2009 18:16:57 GMT
Received: by ey-out-1920.google.com with SMTP id 4so222767eyg.30
        for <selinux@tycho.nsa.gov>; Sat, 21 Mar 2009 11:20:48 -0700 (PDT)
Subject: Re: installing setools errors
From: Dominick Grift <domg472@gmail.com>
To: sixiaolin0 <sixiaolin067@126.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <22637000.476171237656620396.JavaMail.coremail@bj126app64.126.com>
References: 
	 <22637000.476171237656620396.JavaMail.coremail@bj126app64.126.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 21 Mar 2009 19:20:46 +0100
Message-Id: <1237659646.19699.57.camel@notebook1.grift.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2009-03-22 at 01:30 +0800, sixiaolin0 wrote:
> 
> 
> I just insalled a FC10 in my Virtul Machine.
> And when I try to install the setools,I encountered many problems
> I try to solve them ,but this one is not do easy to solve.
> Looking forward your help:
> [hechao@localhost setools-3.3.5]$ ./configure
> checking for a BSD-compatible install... /usr/bin/install -c
>     .
>     .
>     .
>     .
> checking for Tcl configuration... configure: WARNING: Can't find Tcl
> configuration definitions
>  
> I just didn't know how to solve the problem.

yum install setools

i do not see why you want to build your own setools. Fedora has it in
its repositories. ready to use.
 
> 
> 
> 
> ______________________________________________________________________
> 网易邮箱，中国第一大电子邮件服务商


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
