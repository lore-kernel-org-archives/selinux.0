Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2U5XwDo012343
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 00:33:58 -0500 (EST)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2U5UBph027290
	for <selinux@tycho.nsa.gov>; Wed, 30 Mar 2005 05:30:12 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: ivg2@cornell.edu
Subject: Re: [ PATCH ] X clients cleanup patch #2
Date: Tue, 29 Mar 2005 12:12:30 +1100
Cc: dwalsh@redhat.com, selinux@tycho.nsa.gov
References: <1111972339.1119.8.camel@cobra.ivg2.net> <1111972562.1119.12.camel@cobra.ivg2.net>
In-Reply-To: <1111972562.1119.12.camel@cobra.ivg2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200503291112.33518.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Monday 28 March 2005 11:16, Ivan Gyurdiev <ivg2@cornell.edu> wrote:
> Question 1: X has the following rules:
>
> allow $1_$2_t self:unix_dgram_socket create_socket_perms;
> allow $1_$2_t self:unix_stream_socket { connectto
> create_stream_socket_perms };
>
> Removing them seems to affect most (all?) X clients.
> Are those related to establishing a connection to X,
> or are they just common frequently used rules?

If DISPLAY=:0.0 then all X clients will need such access.  DISPLAY=:0.0 is the 
default for a local X login so we should assume that every system that has X 
will need such access.

In any case "self" access isn't a security issue.

> Question 2:
>
> games, mozilla, and gift want to read /etc/mtab, and /etc/nsswitch.conf.
> Why is that neessary, and do those rules always go together?

nsswitch.conf is used for any program that does a UID->name or name->UID 
lookup.  So any operation comparable to "ls -l" will need it.  Mozilla will 
probably call getuid() and then getpwuid() to get the Unix account name for 
various things (including temporary file names I think).

/etc/mtab is unrelated.  Lots of programs read it.  For example programs that 
want to know how much disk space is free often read /etc/mtab.  Usually such 
access is not strictly necessary (the program could perform the same tasks 
without it) but sometimes the program will not be written well in this regard 
and will fail without such access.  /etc/mtab doesn't contain any secret data 
so there's no harm.  /proc/mounts is a better source of such data anyway so 
any program that can read proc_t:lnk_file and self:file can get the same data 
from a more authoritative source.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
