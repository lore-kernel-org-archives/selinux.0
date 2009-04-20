Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n3KGe6A6021121
	for <selinux@tycho.nsa.gov>; Mon, 20 Apr 2009 12:40:06 -0400
Received: from g1t0029.austin.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n3KGe5Hk012010
	for <selinux@tycho.nsa.gov>; Mon, 20 Apr 2009 16:40:05 GMT
From: Paul Moore <paul.moore@hp.com>
To: Justin Mattock <justinmattock@gmail.com>
Subject: Re: SELinux: unrecognized netlink message
Date: Mon, 20 Apr 2009 12:40:00 -0400
Cc: "SE-Linux" <selinux@tycho.nsa.gov>, tresys <refpolicy@oss.tresys.com>
References: <dd18b0c30904171154s571bc232q34dd4b6274f0b88d@mail.gmail.com>
In-Reply-To: <dd18b0c30904171154s571bc232q34dd4b6274f0b88d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200904201240.00400.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 17 April 2009 02:54:19 pm Justin Mattock wrote:
> I'm seeing this in dmesg:
> (as I add the allow rules to a new machine)

...

> [   23.017545] type=1401 audit(1239994223.882:3): SELinux:
> unrecognized netlink message type=28265 for sclass=43
> [   23.017547]
> [   23.017574] type=1300 audit(1239994223.882:3): arch=40000003
> syscall=4 success=yes exit=18 a0=2 a1=8064c17 a2=12 a3=12 items=0
> ppid=1690 pid=1780 auid=4294967295 uid=0 gid=0 euid=0 suid=0 fsuid=0
> egid=0 sgid=0 fsgid=0 tty=(none) ses=4294967295 comm="ip"
> exe="/sbin/ip" subj=system_u:system_r:ifconfig_t:s0 key=(null)

Well, the socket class, aka "sclass" is 43 which means it is a routing socket 
and based on the rest of the audit snippet I'm going to guess the application 
in use is "ip".  Do you get the message only once at boot?  If so it is 
probably part of the normal network configuration.

The unfortunate part is that the message type is 28265 which puts it way 
beyond the range of the routing message types that I can see in the kernel 
(include/linux/rtnetlink.h).  I'm not too familiar with the netlink routing 
socket protocol so it is possible other values are OR'd onto the basic message 
type which would bump the type field to 28265 but I somehow doubt that.

Do you know what the ip command is trying to do?

-- 
paul moore
linux @ hp


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
