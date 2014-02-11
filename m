Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s1BNHknu013897
 for <selinux@tycho.nsa.gov>; Tue, 11 Feb 2014 18:17:46 -0500
Received: by mail-qg0-f45.google.com with SMTP id j5so193958qga.4
 for <selinux@tycho.nsa.gov>; Tue, 11 Feb 2014 15:17:44 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: RFC - Display context information using iproute2 ss utility
Date: Tue, 11 Feb 2014 18:17:42 -0500
Message-ID: <7783228.bfKoxQqi1y@sifl>
In-Reply-To: <1391963266.11620.YahooMailNeo@web87906.mail.ir2.yahoo.com>
References: <1391790157.3514.YahooMailNeo@web87902.mail.ir2.yahoo.com>
 <4844959.FlXfI971DN@sifl>
 <1391963266.11620.YahooMailNeo@web87906.mail.ir2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sunday, February 09, 2014 04:27:46 PM Richard Haines wrote:
> Thanks for clarifying the socket fd context.
> 
> For the iproute ss utility I was thinking of altering the man page to
> reflect your comments (added below) and some testing I've done using
> policy role/type and range transition statements.
> 
> Overall do you think it is worth adding the socket contexts to the ss
> utility.

I'm pretty conflicted on this ... at best I wonder how useful the information 
will be to users/developers and at worst I fear it could end up being 
misleading.

> -Z, --context
>     Show SELinux security contexts. The context of the process using
>     the socket and the sockets context will be displayed. The socket
>     context is taken from the file descriptors inode and is not the

I might say that the socket context is taken from the "associated inode" and 
leave the file descriptor out of it, but that is just me.  After all, there is 
a reason I'm not a writer :)

>     actual socket context held by the kernel. Sockets are typically
>     labeled with the context of the creating process, however the
>     context shown will reflect any policy role, type and/or range
>     transition rules applied, and is therefore a useful reference.
>
>     For netlink(7) sockets the initiating process context is displayed
>     as follows:
> 
>       1. If valid pid show the process context.
> 
>       2. If destination is kernel (pid = 0) show kernel initial context.
> 
>       3. If a unique identifier has been allocated by the kernel or
>          netlink user, show context as "not available".
>          This will generally indicate that a process has more
>          than one netlink socket active.
> 
> Richard

-- 
paul moore
www.paul-moore.com
