Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p3MEZauZ013351
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2011 10:35:36 -0400
Received: from manicmethod.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p3MEZZIn004979
	for <selinux@tycho.nsa.gov>; Fri, 22 Apr 2011 14:35:35 GMT
Message-ID: <4DB19229.9090803@manicmethod.com>
Date: Fri, 22 Apr 2011 10:35:21 -0400
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
CC: selinux@tycho.nsa.gov, sds@tyho.nsa.gov
Subject: Re: Help with toolchain
References: <1303233422.2053.6.camel@localhost.localdomain>
In-Reply-To: <1303233422.2053.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Eric Paris wrote:
> I've got a minimal policy and a small policy module I wrote (ok the
> 'policy' is the kernel mdp, but who cares)
>
> I can do:
> 	checkmodule -o policy.bin policy.conf
> 	checkmodule -m -o filename.mod filename.te
>
> To generate a base module and a 'normal' module.  I can use:
> 	dismod policy.bin
> 	l
> 	filename.mod
> to load the base module and then link in the 'normal' module.  But I
> don't know to make it expand.

you could use semodule_link in policycoreutils and then gdb through 
semodule_expand.

>
> I'd like to turn the policy.conf + filename.te into a fully linked
> expanded kernel policy.X but I'm not sure what magic incantation I need
> to use.....
>
> (No cat filename.te>>  policy.conf; checkpolicy -o policy.X policy.conf
> is no adequate.  It's somewhere in expand that things seems to be
> breaking so I want as small of a policy and as small of steps as I can
> make to debug where things are dying)
>
> -Eric
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
