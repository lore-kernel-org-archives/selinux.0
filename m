Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i98L3ZrT025547
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 17:03:35 -0400 (EDT)
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i98L1sBm026343
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 21:02:26 GMT
Message-ID: <41670081.1010506@redhat.com>
Date: Fri, 08 Oct 2004 17:02:57 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: Greg Norris <haphazard@kc.rr.com>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: need advice for ld_so_cache_t errors
References: <20041001233554.GA26550@yggdrasil.localdomain>	 <20041002043740.GA28765@yggdrasil.localdomain>	 <20041002165041.GB30426@yggdrasil.localdomain>	 <200410040108.35839.russell@coker.com.au>	 <20041004014820.GA25896@yggdrasil.localdomain>	 <20041005003015.GA31681@yggdrasil.localdomain>	 <20041005010057.GA31754@yggdrasil.localdomain> <1097250170.16641.138.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1097250170.16641.138.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------080505010806030405010703"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------080505010806030405010703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:

>On Mon, 2004-10-04 at 21:00, Greg Norris wrote:
>  
>
>>Ok, I've (finally) figured out what's actually failing.  When I strace a 
>>tail command on my selinux box, the following entries seem of interest:
>>
>>   open("/etc/ld.so.cache", O_RDONLY)      = 3
>>   fstat64(3, {st_mode=S_IFREG|0644, st_size=11997, ...}) = 0
>>   old_mmap(NULL, 11997, PROT_READ, MAP_PRIVATE, 3, 0) = -1 EACCES (Permission denied)
>>   close(3)                                = 0
>>
>>   open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = 3
>>   fstat64(3, {st_mode=S_IFREG|0644, st_size=1589840, ...}) = 0
>>   mmap2(NULL, 1589840, PROT_READ, MAP_PRIVATE, 3, 0) = -1 EACCES (Permission denied)
>>   close(3)                                = 0
>>
>>When I strace the same command on my non-selinux box (also running
>>Debian sid), both of the mmaps are successful.  So I guess I need to
>>figure out why the the mmaps are being blocked.
>>
>>I'm not sure why selinux would log that as a denied execute, tho.
>>    
>>
>
>Legacy binary?  Read-only mmap/mprotect requests are now automatically
>translated to read-execute for backward compatibility when executing
>legacy binaries due to the NX support that was added to the upstream
>kernel.  That translation happens before the SELinux hooks are
>encountered, so SELinux just sees it as a read/execute request.
>
>  
>
Ok I am seeing this stuff alot right now.  Mainly when running mozilla 
with java. 

Seems there is a problem with either glib or m_protect.

kernel-2.6.8-1.603
glibc-2.3.3-66


--------------080505010806030405010703
Content-Type: text/plain;
 name="execute"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="execute"

Oct  8 16:57:13 celtics kernel: audit(1097269033.954:10750480): avc:  denied  { execute } for  pid=22541 path=/etc/ld.so.cache dev=dm-0 ino=624955 scontext=user_u:user_r:user_mozilla_t tcontext=system_u:object_r:ld_so_cache_t tclass=file
Oct  8 16:57:13 celtics kernel: audit(1097269033.967:10750749): avc:  denied  { execute } for  pid=22541 path=/tmp/hsperfdata_dwalsh/22541 dev=dm-0 ino=3118259 scontext=user_u:user_r:user_mozilla_t tcontext=user_u:object_r:user_tmp_t tclass=file
Oct  8 16:57:14 celtics kernel: audit(1097269034.118:10751092): avc:  denied  { execute } for  pid=22541 path=/usr/java/jre1.5.0/lib/i386/client/classes.jsa dev=dm-0 ino=2380505 scontext=user_u:user_r:user_mozilla_t tcontext=system_u:object_r:usr_t tclass=file
Oct  8 16:57:14 celtics kernel: audit(1097269034.172:10752097): avc:  denied  { execute } for  pid=22541 path=/usr/lib/locale/locale-archive dev=dm-0 ino=1786056 scontext=user_u:user_r:user_mozilla_t tcontext=root:object_r:locale_t tclass=file
Oct  8 16:57:14 celtics kernel: audit(1097269034.173:10752118): avc:  denied  { execute } for  pid=22541 path=/usr/lib/locale/en_US.utf8/LC_CTYPE dev=dm-0 ino=2032775 scontext=user_u:user_r:user_mozilla_t tcontext=system_u:object_r:locale_t tclass=file

--------------080505010806030405010703--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
