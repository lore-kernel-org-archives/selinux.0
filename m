Date: Tue, 19 Feb 2002 17:19:19 -0500 (EST)
From: Noah silva <nsilva@atari-source.com>
To: Lonnie Cumberland <lonnie@outstep.com>
cc: SELinux@tycho.nsa.gov
Subject: Re: ftp long time connection
In-Reply-To: <1707.192.168.1.12.1014138396.squirrel@192.168.1.2>
Message-ID: <Pine.LNX.4.21.0202191639200.21141-100000@sparcy.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Are you sure that SELinux is the problem?  Usually this problem is caused
by the server doing a reverse DNS lookup on the connecting host for
logging purposes, and the DNS times out.

 -- noah silva 

On Tue, 19 Feb 2002, Lonnie Cumberland wrote:

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
> 
> 
> 
> --
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
