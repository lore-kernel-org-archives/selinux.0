Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h4FFtQI4019018
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 11:55:26 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h4FFtPVG026405
	for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 15:55:25 GMT
Received: from sat.sws.net.au ([202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h4FFtML9026396 for <selinux@tycho.nsa.gov>; Thu, 15 May 2003 15:55:23 GMT
Received: from localhost (localhost [127.0.0.1])
	by sat.sws.net.au (Postfix) with ESMTP id 5A96ABF54
	for <selinux@tycho.nsa.gov>; Fri, 16 May 2003 01:55:20 +1000 (EST)
Received: from sat.sws.net.au ([127.0.0.1])
 by localhost (sat [127.0.0.1:10024]) (amavisd-new) with ESMTP id 24737-01
 for <selinux@tycho.nsa.gov>; Fri, 16 May 2003 01:55:19 +1000 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by sat.sws.net.au (Postfix) with ESMTP id 07413BF53
	for <selinux@tycho.nsa.gov>; Fri, 16 May 2003 01:55:18 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id B5859924A3
	for <selinux@tycho.nsa.gov>; Fri, 16 May 2003 01:55:18 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 5B80D70FE
	for <selinux@tycho.nsa.gov>; Fri, 16 May 2003 01:53:57 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: memory used by SE Linux
Date: Fri, 16 May 2003 01:53:56 +1000
References: <200305152237.44225.russell@coker.com.au>
In-Reply-To: <200305152237.44225.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200305160153.56786.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 15 May 2003 22:37, Russell Coker wrote:
> Here is some raw data about SE Linux memory use on ARM.  I haven't
> previously done any checks on i386 because my i386 machines are so big that
> it doesn't matter.  Eventually I'll probably look into i386 memory usage to
> compare.

I've just dome some new tests with kernel 2.4.19-rmk6-pxa1-hh13.

Here is a table of the size of the bzImage file and the amount of memory free 
(according to the "free" command) when logging in at the serial console 30 
seconds after boot.  For the free memory I have two columns, one for a kernel 
with no security policy loaded, and one for a kernel with.  SE-enforce is a 
kernel compiled without development mode (so it can't boot without policy).  
vanilla is a non-SE kernel so it can't load policy.

kernel     size(b)  mem-free(no policy) mem-free(policy)
vanilla    658648       45152
SE-enforce 704708                       43776
SE-devel   705560       45000           43776

This seems more reasonable.  152K apparently used by the SE kernel code when 
it is doing nothing, and a further 1224K used when loading a 583771 byte 
uncompressed policy, giving a total of 1374K used by SE Linux.

This test isn't as accurate as I would like.  There are lots of things that 
the kernel does which use memory which I have no ability to monitor or 
prevent.  But I think this is a reasonable approximation.

Below is the raw data.  One interesting thing to note is that when booting a 
kernel compiled without "development mode" 8K less kernel memory is used, but 
an extra 8K is apparently used somewhere else to give the same amount of 
memory reported as free.  I expect that this is just due to a race condition, 
and that I can probably repeat all the tests to see a ~8K difference.

vanilla
              total         used         free       shared      buffers
  Mem:        63412        18260        45152            0            0
 Swap:            0            0            0
Total:        63412        18260        45152

enforcing policy:
              total         used         free       shared      buffers
  Mem:        63308        19532        43776            0            0
 Swap:            0            0            0
Total:        63308        19532        43776

devel policy:
              total         used         free       shared      buffers
  Mem:        63300        19524        43776            0            0
 Swap:            0            0            0
Total:        63300        19524        43776

devel no-pol:
              total         used         free       shared      buffers
  Mem:        63300        18300        45000            0            0
 Swap:            0            0            0
Total:        63300        18300        45000

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
