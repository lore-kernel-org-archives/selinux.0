Date: Tue, 19 Feb 2002 22:47:35 +0200 (EET)
From: Hacko <toltec@karai.net>
To: Lonnie Cumberland <lonnie@outstep.com>
cc: SELinux@tycho.nsa.gov
Subject: Re: ftp long time connection
In-Reply-To: <1707.192.168.1.12.1014138396.squirrel@192.168.1.2>
Message-ID: <Pine.LNX.4.44.0202192241340.5949-100000@karai.karai.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

it has nothing to do with selinux, i suppose, if you try ssh/telnet, etc -
it will be the same?

try to add the following in your /etc/hosts

#>>>
# this is in selinux /etc/hosts
# ip of example linux client is 10.20.20.40

10.20.20.40	linux-client-name
10.20.20.41	linux2-client-name

# etc
#>>>>

i hope then all will be faster ;)

regards,

Hacko



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
