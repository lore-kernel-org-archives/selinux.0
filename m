Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9239xrT006724
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 23:09:59 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9239oEZ022011
	for <selinux@tycho.nsa.gov>; Sat, 2 Oct 2004 03:09:57 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Greg Norris <haphazard@kc.rr.com>
Subject: Re: need advice for ld_so_cache_t errors
Date: Sat, 2 Oct 2004 13:09:46 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <20041001233554.GA26550@yggdrasil.localdomain>
In-Reply-To: <20041001233554.GA26550@yggdrasil.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200410021309.46413.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2 Oct 2004 09:35, Greg Norris <haphazard@kc.rr.com> wrote:
> OK, I've finally reached a point where I'm switching my system from
> permissive to enforcing mode (and there was much rejoicing! ;-).  Things
> seem to be working pretty well, but I'm noticing a number of
> ld_so_cache_t errors logged...  in particular, restarting postfix causes
> an absolute FLOOD of messages such as the one below (reformatted for my
> own sanity).
>
>    Oct  1 17:16:34 sasami kernel: audit(1096668994.071:0): avc:
>      denied  { execute } for  pid=3039 path=/etc/ld.so.cache
>      dev=hda5 ino=1022 scontext=system_u:system_r:postfix_master_t
>      tcontext=system_u:object_r:ld_so_cache_t tclass=file

I have installed the same versions of libc6 and postfix as you but can not 
reproduce this.

Please show me the output of "ls -li /etc/ld.so.cache" on that machine.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
