Message-ID: <3C72AA1A.86892B03@quantumtek.net>
Date: Tue, 19 Feb 2002 14:40:10 -0500
From: George Fouse <gfouse@quantumtek.net>
MIME-Version: 1.0
To: Lonnie Cumberland <lonnie@outstep.com>
CC: SELinux@tycho.nsa.gov
Subject: Re: ftp long time connection
References: <1707.192.168.1.12.1014138396.squirrel@192.168.1.2>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,
I really question if this is an SELinux problem, per se.
If you wait and then finally connect, then I wonder if: 1. inetd (or
xinetd if you're using that) is configured to request the client host
identd info  (or are you using the ftp server as a daemon?), 2.doesn't
see it, and then  3.waits for the timeout interval you have set prior to
completing? Just a thought.
Lonnie Cumberland wrote:
> 
> Hello All,
> 
> I have my systems behind a firewall and am using ftp for a specific
> project.
> 
> The problem is that when I try to connect to my SELinux server from
> another Linux client that it takes about 2 - 3 minutes. I have even
> tried to give the IP instead of the host name and it still take this
> long time as well.
> 
> Any ideas on how to fix this would be greatly appreciated,
> Cheers,
> Lonnie
> 
> --
>  Lonnie Cumberland
>  OutStep Technologies Incorporated
>  (313) 832-7366
> 
>  URL: http://www.outstep.com
>  EMAIL: Lonnie@OutStep.com
>       : Lonnie_Cumberland@yahoo.com
>
--
------------------------------
George Fouse, 
President
Quantum Technology Associates
System and Network Services
------------------------------

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
