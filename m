Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n0KHWd4d017204
	for <selinux@tycho.nsa.gov>; Tue, 20 Jan 2009 12:32:39 -0500
Received: from g5t0009.atlanta.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n0KHWbpV017027
	for <selinux@tycho.nsa.gov>; Tue, 20 Jan 2009 17:32:38 GMT
From: Paul Moore <paul.moore@hp.com>
To: russell@coker.com.au
Subject: Re: netstat -Z
Date: Tue, 20 Jan 2009 12:32:32 -0500
Cc: "SE-Linux" <selinux@tycho.nsa.gov>
References: <200901181932.37457.russell@coker.com.au>
In-Reply-To: <200901181932.37457.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901201232.32719.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sunday 18 January 2009 3:32:36 am Russell Coker wrote:
> The command "netstat -Z -t" will show two entries for a localhost
> connection and thus show the context of each end of the socket.
>
> The command "netstat -Z -x" seems to only show a single entry for the
> connection which will be from the server end.
>
> http://wiki.postgresql.org/wiki/SEPostgreSQL
>
> The above wiki page mentions "netstat -Z" and my personal
> interpretation of this was that I could use "netstat -Z" to find the
> context of a client end of a socket.  But it seems that I can only
> get the server end.
>
> Is this what is desired?

I would think that we would want to see both the client and server unix 
sockets for the same reasons that we would want to see both client and 
server inet sockets.  However, it looks like that might be the case on 
my Fedora Rawhide system (I could be wrong, I don't mess with AF_UNIX 
much)?

Looking at my system with "netstat -x -Z -p" (columns removed for 
readability) I see what looks like a unix socket server and client for 
the ACPI daemon socket:
Active UNIX domain sockets (w/o servers)

Type       State         PID/Program name    Security Context
STREAM     CONNECTED     1994/acpid          system_u:system_r:apmd_t:s0
STREAM     CONNECTED     2139/acpid.socket   system_u:system_r:hald_t:s0

... and checking to see the actual programs with "ps 1994; ps 2139" 
(columns removed for readability) I see the following:

  PID COMMAND
 1994 /usr/sbin/acpid
 2139 hald-addon-acpi: listening on acpid socket /var/run/acpid.socket

I'm pretty sure that acpid (pid 1994) open the /var/run/acpid.socket and 
writes to it (acting as server) and that hald-addon-acpi opens the 
sockets and listens for events (acting as client).  If this is in fact 
the case, everything appears okay on Rawhide.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
