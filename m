Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i98FkUrT022770
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 11:46:30 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i98FkUZ2009562
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 15:46:30 GMT
Subject: Re: need advice for ld_so_cache_t errors
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Greg Norris <haphazard@kc.rr.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20041005010057.GA31754@yggdrasil.localdomain>
References: <20041001233554.GA26550@yggdrasil.localdomain>
	 <20041002043740.GA28765@yggdrasil.localdomain>
	 <20041002165041.GB30426@yggdrasil.localdomain>
	 <200410040108.35839.russell@coker.com.au>
	 <20041004014820.GA25896@yggdrasil.localdomain>
	 <20041005003015.GA31681@yggdrasil.localdomain>
	 <20041005010057.GA31754@yggdrasil.localdomain>
Content-Type: text/plain
Message-Id: <1097250170.16641.138.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Fri, 08 Oct 2004 11:42:50 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-10-04 at 21:00, Greg Norris wrote:
> Ok, I've (finally) figured out what's actually failing.  When I strace a 
> tail command on my selinux box, the following entries seem of interest:
> 
>    open("/etc/ld.so.cache", O_RDONLY)      = 3
>    fstat64(3, {st_mode=S_IFREG|0644, st_size=11997, ...}) = 0
>    old_mmap(NULL, 11997, PROT_READ, MAP_PRIVATE, 3, 0) = -1 EACCES (Permission denied)
>    close(3)                                = 0
> 
>    open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = 3
>    fstat64(3, {st_mode=S_IFREG|0644, st_size=1589840, ...}) = 0
>    mmap2(NULL, 1589840, PROT_READ, MAP_PRIVATE, 3, 0) = -1 EACCES (Permission denied)
>    close(3)                                = 0
> 
> When I strace the same command on my non-selinux box (also running
> Debian sid), both of the mmaps are successful.  So I guess I need to
> figure out why the the mmaps are being blocked.
> 
> I'm not sure why selinux would log that as a denied execute, tho.

Legacy binary?  Read-only mmap/mprotect requests are now automatically
translated to read-execute for backward compatibility when executing
legacy binaries due to the NX support that was added to the upstream
kernel.  That translation happens before the SELinux hooks are
encountered, so SELinux just sees it as a read/execute request.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
