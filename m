Date: Thu, 28 Mar 2002 08:17:39 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200203281417.IAA96290@tomcat.admin.navo.hpc.mil>
To: r2q2@rocketmail.com, SeLinux@tycho.nsa.gov
Subject: Re: Java intragration
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 R2-Q2 <r2q2@rocketmail.com>:
> 
> Would it be a good idea to intragrate Java into the operating system.
> Possibally it could be faster if it was. Java is known to be secure and
> there are many open source vm's out there. Or we just could install it
> into the OS using SUN's or IBM's version. Though probally SUN because
> they have the latest version.

I think you will find the memory management model used to track objects
to be too incompatable with kernel memory management. Most of the JVMs
I have run across (only two, so limited experience here) indicate that
they expect a flat memory modle, and do not handle holes in memory at
all since that breaks the security model being implemented.

Now if it were the JavaOS now, that is a different animal. But it isn't
Linux.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
