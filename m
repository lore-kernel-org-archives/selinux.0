Message-ID: <3C4CA991.418EA214@cpcug.org>
Date: Mon, 21 Jan 2002 18:51:45 -0500
From: James Griffin <agriffin@cpcug.org>
MIME-Version: 1.0
To: clarke@cilia.org
CC: SELinux@tycho.nsa.gov
Subject: Re: ntp security policy
References: <200201212108.g0LL8tu06231@news.cilia.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Ed Clarke wrote:
> 
> Has anyone developed a security policy for ntpd?  This is probably
> simple:
> 
>         read access to:
>                 /etc/ntp.conf
>                 /etc/ntp/keys
>         read/write access to:
>                 /etc/ntp/drift
> 
> but it also has enhanced privs to permit access to the system clock
> via adjtime(x) etc. and speaks via tcp to various external peers and
> servers.

Correction. NTP uses UDP exclusively.

Jim
[ship]

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
