Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4SLw3rT011079
	for <selinux@tycho.nsa.gov>; Fri, 28 May 2004 17:58:03 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4SLw1o9020211
	for <selinux@tycho.nsa.gov>; Fri, 28 May 2004 21:58:01 GMT
Received: from smtp800.mail.ukl.yahoo.com (smtp800.mail.ukl.yahoo.com [217.12.12.142])
        by jazzband.ncsc.mil  with SMTP id i4SLw0In020203 for <selinux@tycho.nsa.gov>; Fri, 28 May 2004 21:58:00 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 28 May 2004 20:11:20 -0000
Date: Fri, 28 May 2004 20:08:40 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: "Dr. Eugene D. Myers" <edm@tycho.ncsc.mil>
Cc: Chris Babcock <cbabcock@luthresearch.com>, mayerf@tresys.com,
   SELinux <selinux@tycho.nsa.gov>
Subject: Re: XP as a base for NetTop
Message-ID: <20040528200840.GB3400@lkcl.net>
References: <20040527080750.GA13687@lkcl.net> <BCDBA110.10B6A%edm@tycho.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BCDBA110.10B6A%edm@tycho.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, May 27, 2004 at 01:43:44PM -0400, Dr. Eugene D. Myers wrote:

> In NetTop, each virtual machine is assigned a specific type (for example,
> vm1_d) and the files that contain the virtual disks are assigned a different
> type (for example, vm1_t).  Each virtual machine type vmX_d (where X is an
> arbitrary number) can only access files (virtual disks) of type vmX_t.
> 
> The restriction means that each virtual machine can only access only its
> virtual disks.
> 
> In NetTop, the SELinux policy is written such that -->Only<-- only a VM can
> access a virtual disk and only its associated virtual disk.  No other
> process (including other VM's) have permission to access a VM's virtual
> disk.  This includes processes that execute with root permission.
> 

 ... so, just because i'm curious, what am i missing.  
 
 i joked that there _is_ a link between linux and this
 secure windows XP: are you saying that that is in fact true?

 that microsoft is recommending that their operating system
 run as an application under a hosted secure OS (SE/Linux)???

 [that sounds like a slashdot "laugh it's funny" story to me]

 or, is it that the SElinux policies are available under windows
 xp (native OS) and that the version of vmware for windows XP
 is in fact being used to run more (secure) windows xp sessions?

 or, other?

 sincerely,

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
