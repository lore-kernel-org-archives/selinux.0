Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8OF5nrT017991
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 11:05:50 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8OF5krq025600
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 15:05:47 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: Remove unrestricted_admin
Date: Sat, 25 Sep 2004 01:05:40 +1000
Cc: jwcart2@epoch.ncsc.mil, SE Linux <selinux@tycho.nsa.gov>
References: <200409211526.37810.russell@coker.com.au> <1095884528.11254.6.camel@moss-lions.epoch.ncsc.mil> <4152D07C.9060507@redhat.com>
In-Reply-To: <4152D07C.9060507@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200409250105.40796.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 23 Sep 2004 23:32, Daniel J Walsh <dwalsh@redhat.com> wrote:
> Remove unrestricted_admin tunable.  This was a bad idea :^(

-allow sysadm_t fixed_disk_device_t:devfile_class_set rw_file_perms;

I think that perhaps we should add that line back.

Of the times that I temporarily enable permissive mode to execute a command, 
in 99% of them it's because of access to a fixed disk.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
