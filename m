Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8ODvIrT017365
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 09:57:18 -0400 (EDT)
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8ODvCrq023036
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 13:57:17 GMT
Subject: Re: Regarding  Project in SELinux
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: shishir randive <send2shishir@yahoo.co.in>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <20040924120148.76005.qmail@web8401.mail.in.yahoo.com>
References: <20040924120148.76005.qmail@web8401.mail.in.yahoo.com>
Content-Type: text/plain
Message-Id: <1096034182.21017.57.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 24 Sep 2004 09:56:23 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2004-09-24 at 08:01, shishir randive wrote:
>  We found the "Implement mandatory controls for NFS  "
> looks  intresting  to work on.
> 
>  So we would like to know ,
> 
>  What are the challenges that SElinux is facing ?
> 
>  What are the challenges in implementing mandatory
> control for NFS ?
> 
>  Which is the big task for implementing the mandatory
> control for NFS ?
> 
>  Is anyone trying to implement mandatory  control for
> NFS ?
> 
> also, if someone can tell us how much time would it
> take for  implementing this ?, it'll be great so that
> we can decide if the three of us can  finish this in 6
> months.
> 

You can download experimental NFS code that adds SELinux support from
the experimental SELinux code section of the SELinux download page on
the nsa.gov website.  There is some documentation in the NFS userland
archive.

It does have some limitations, though, such as:
- Requires the same (or, at least, mostly the same) policies on the
clients and server.
- Relies too much on the client for proper access decisions.

But, for the most part, it works.

> Also,
> 
>  What are polyinstantiated directories and ports ?
> 
>  What are the challenges in Implementing 
> polyinstantiated directories ?
> 
>  What are the challenges in implementing
> polyinstantiated ports ?
> 
> also, a brief estimate on this too would be
> appreciated.  
> 
> 

See the following paper found in the SELinux background section on the
nsa.gov website:
http://www.nsa.gov/selinux/papers/flask-abs.cfm

-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
