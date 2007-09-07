Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l87CTIrB011813
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 08:29:18 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l87CTHZj016528
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 12:29:17 GMT
Subject: Re: Graphical depiction of TE policy
From: Dave Sugar <dsugar@tresys.com>
To: selinux@tycho.nsa.gov
In-Reply-To: <A9D9EDA4-EA98-465B-89C5-389E4C4E6945@nall.com>
References: <A9D9EDA4-EA98-465B-89C5-389E4C4E6945@nall.com>
Content-Type: text/plain
Date: Fri, 07 Sep 2007 08:29:14 -0400
Message-Id: <1189168154.3607.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joe,

There has been some work done on graphically representing security
policy.  A project we worked on here called CDS Framework is a tool to
graphically generate policy which is then translated into SELinux TE
policy.  See http://oss.tresys.com/projects/cdsframework

While this is not exactly what you are asking about it is related and I
wanted to mention it.  

Dave Sugar


On Thu, 2007-09-06 at 23:02 -0500, Joe Nall wrote:
> Has anyone done any work toward automatically generating graphical  
> representations of TE policy from existing policy? Perhaps have apol  
> emit dot files like doxygen?
> 
> joe
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
