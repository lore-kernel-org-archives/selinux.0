Message-ID: <1343216506.31528.19.camel@moss-pluto.epoch.ncsc.mil>
Subject: Re: [PATCH 3/6] external/sepolicy: mediaserver talk to rild via
 socket
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: selinux@tycho.nsa.gov, bill.c.roberts@gmail.com
Date: Wed, 25 Jul 2012 07:41:46 -0400
In-Reply-To: <CAO-4OdEmRH9toR4QX7qnR+h1-fw9742hFUAYv3trwPzW_GbU+w@mail.gmail.com>
References: <1342739276-1686-4-git-send-email-hqjiang1988@gmail.com>
	 <1343050007.23118.28.camel@moss-pluto.epoch.ncsc.mil>
	 <CAO-4OdG2zH+9dDQYboh2itGN6a5cUMPc23TJO3vJZ6DDaR9TwA@mail.gmail.com>
	 <1343135089.2383.28.camel@moss-pluto.epoch.ncsc.mil>
	 <CAO-4OdEJJg+gnXwRL75+WdsCFMcwjRLSuWUvQjY8eM2YqAnDyA@mail.gmail.com>
	 <CAO-4OdEmRH9toR4QX7qnR+h1-fw9742hFUAYv3trwPzW_GbU+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2012-07-24 at 15:32 -0700, Haiqing Jiang wrote:
> Hi, Stephen
> 
> 
> I find the denial. But have not ideas about the exact object related
> to the denial. Please let me know your comments. Thanks. 
> 
> 
> #============= mediaserver ==============
> allow mediaserver rild:unix_stream_socket connectto;
> 
> <5>[ 9719.676422] type=1400 audit(1343162276.710:1512): avc:  denied
>  { connectto } for  pid=519 comm=42696E646572205468726561642023
> path=004D756C7469636C69656E74 scontext=u:r:mediaserver:s0
> tcontext=u:r:rild:s0 tclass=unix_stream_socket

Oh, it is a socket in the abstract namespace (path starts with the null
byte).  So it is not the /dev/socket/rild socket that is in view here.

So I guess you can add:
	allow mediaserver rild:unix_stream_socket connectto;
and not use the unix_socket_connect() macro because we do not want to
allow use of /dev/socket/rild, only the abstract socket connection.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
