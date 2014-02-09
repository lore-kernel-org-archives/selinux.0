Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s19GUnWA020463
 for <selinux@tycho.nsa.gov>; Sun, 9 Feb 2014 11:30:49 -0500
References: <1391790157.3514.YahooMailNeo@web87902.mail.ir2.yahoo.com>
 <20140207170325.GA10040@telmora.telvanni> <4844959.FlXfI971DN@sifl>
Message-ID: <1391963266.11620.YahooMailNeo@web87906.mail.ir2.yahoo.com>
Date: Sun, 9 Feb 2014 16:27:46 +0000 (GMT)
From: Richard Haines <richard_c_haines@btinternet.com>
Subject: Re: RFC - Display context information using iproute2 ss utility
To: Paul Moore <paul@paul-moore.com>
In-Reply-To: <4844959.FlXfI971DN@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Thanks for clarifying the socket fd context.

For the iproute ss utility I was thinking of altering the man page to
reflect your comments (added below) and some testing I've done using
policy role/type and range transition statements.

Overall do you think it is worth adding the socket contexts to the ss utility.


-Z, --context
    Show SELinux security contexts. The context of the process using
    the socket and the sockets context will be displayed. The socket
    context is taken from the file descriptors inode and is not the
    actual socket context held by the kernel. Sockets are typically
    labeled with the context of the creating process, however the
    context shown will reflect any policy role, type and/or range
    transition rules applied, and is therefore a useful reference.

    For netlink(7) sockets the initiating process context is displayed
    as follows:

      1. If valid pid show the process context.

      2. If destination is kernel (pid = 0) show kernel initial context.

      3. If a unique identifier has been allocated by the kernel or
         netlink user, show context as "not available".
         This will generally indicate that a process has more
         than one netlink socket active.

Richard



----- Original Message -----
> From: Paul Moore <paul@paul-moore.com>
> To: Ole Kliemann <ole@plastictree.net>; Richard Haines <richard_c_haines@btinternet.com>
> Cc: selinux@tycho.nsa.gov
> Sent: Friday, 7 February 2014, 21:50
> Subject: Re: RFC - Display context information using iproute2 ss utility
> 
> On Friday, February 07, 2014 06:03:25 PM Ole Kliemann wrote:
>>  On Fri, Feb 07, 2014 at 04:22:37PM +0000, Richard Haines wrote:
>>  > I've been patching the iproute2 "ss" utility to display 
> the SELinux
>>  > security contexts for process and sockets, however I'm not sure
>>  > whether the socket contexts are correct (I expected most to show
>>  > system_u:object_r:....).
>>  > 
>>  > I'm taking the socket contexts from /proc/PID/fd as was mentioned 
> in
>>  > a previous email regarding socket contexts - is this correct ??
>> 
>>  I was doing it that way and it seemed to work ...
> 
> What you will see is the label of the socket's associated inode, not the 
> actual socket label.
> 
>>  ... I could even change the context using 'chcon /proc/PID/fd'.
> 
> Yes, you really shouldn't do that.  I've actually got a patch kicking 
> around 
> that I haven't had the time to test which will actually prevent you from 
> changing a socket's inode label. 
> 
>>  But I have no idea whether it is supposed to be a reliable way or
>>  any other methods exist. The whole sockfs thing kept me rather
>>  wondering...
> 
> It works as far as I know, it just turns out that it isn't quite what you 
> think it is :)
> 
> -- 
> paul moore
> www.paul-moore.com
> 
