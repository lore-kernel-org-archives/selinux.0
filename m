Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i953jsrT023548
	for <selinux@tycho.nsa.gov>; Mon, 4 Oct 2004 23:45:54 -0400 (EDT)
Received: from rwcrmhc11.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i953ikYE000954
	for <selinux@tycho.nsa.gov>; Tue, 5 Oct 2004 03:44:47 GMT
Message-ID: <416218F1.2030105@comcast.net>
Date: Mon, 04 Oct 2004 20:45:53 -0700
From: Tom London <selinux@comcast.net>
MIME-Version: 1.0
To: Greg Norris <haphazard@kc.rr.com>
CC: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: need advice for ld_so_cache_t errors
References: <20041001233554.GA26550@yggdrasil.localdomain> <20041002043740.GA28765@yggdrasil.localdomain> <20041002165041.GB30426@yggdrasil.localdomain> <200410040108.35839.russell@coker.com.au> <20041004014820.GA25896@yggdrasil.localdomain> <20041005003015.GA31681@yggdrasil.localdomain> <20041005010057.GA31754@yggdrasil.localdomain>
In-Reply-To: <20041005010057.GA31754@yggdrasil.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

see: https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=133505

Believe there is a bug in mprotect().

tom

Greg Norris wrote:

>Ok, I've (finally) figured out what's actually failing.  When I strace a 
>tail command on my selinux box, the following entries seem of interest:
>
>   open("/etc/ld.so.cache", O_RDONLY)      = 3
>   fstat64(3, {st_mode=S_IFREG|0644, st_size=11997, ...}) = 0
>   old_mmap(NULL, 11997, PROT_READ, MAP_PRIVATE, 3, 0) = -1 EACCES (Permission denied)
>   close(3)                                = 0
>
>   open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = 3
>   fstat64(3, {st_mode=S_IFREG|0644, st_size=1589840, ...}) = 0
>   mmap2(NULL, 1589840, PROT_READ, MAP_PRIVATE, 3, 0) = -1 EACCES (Permission denied)
>   close(3)                                = 0
>
>When I strace the same command on my non-selinux box (also running
>Debian sid), both of the mmaps are successful.  So I guess I need to
>figure out why the the mmaps are being blocked.
>
>I'm not sure why selinux would log that as a denied execute, tho.
>  
>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
