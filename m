Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8OIoBrT019837
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 14:50:11 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8OInAxO007002
	for <selinux@tycho.nsa.gov>; Fri, 24 Sep 2004 18:49:10 GMT
Message-ID: <41546C54.20403@gentoo.org>
Date: Fri, 24 Sep 2004 14:49:56 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Daniel J Walsh <dwalsh@redhat.com>, jwcart2@epoch.ncsc.mil,
   SE Linux <selinux@tycho.nsa.gov>,
   "'Christopher J. PeBenito'" <cpebenito@tresys.com>
Subject: Re: Remove unrestricted_admin
References: <200409211526.37810.russell@coker.com.au> <1095884528.11254.6.camel@moss-lions.epoch.ncsc.mil> <4152D07C.9060507@redhat.com> <200409250105.40796.russell@coker.com.au>
In-Reply-To: <200409250105.40796.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

> On Thu, 23 Sep 2004 23:32, Daniel J Walsh <dwalsh@redhat.com> wrote:
> 
>>Remove unrestricted_admin tunable.  This was a bad idea :^(
> 
> 
> -allow sysadm_t fixed_disk_device_t:devfile_class_set rw_file_perms;
> 
> I think that perhaps we should add that line back.
> 
> Of the times that I temporarily enable permissive mode to execute a command, 
> in 99% of them it's because of access to a fixed disk.
> 

*ahem* non-bypassability anyone?

The strict policy is suppose to be getting stricter, this corner case 
shouldn't be considered at all.

Joshua Brindle

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
