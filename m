Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA05253
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 06:47:46 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id KAA02871
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 10:46:23 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id KAA02867 for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 10:46:21 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Keith Owens <kaos@sgi.com>
Subject: Re: XFS and LSM
Date: Thu, 13 Jun 2002 12:47:31 +0200
Cc: linux-security-module@wirex.com, linux-xfs@oss.sgi.com,
        SE Linux <selinux@tycho.nsa.gov>
References: <5772.1023963428@ocs3.intra.ocs.com.au>
In-Reply-To: <5772.1023963428@ocs3.intra.ocs.com.au>
MIME-Version: 1.0
Message-Id: <20020613104731.CF50F1F09@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 13 Jun 2002 12:17, Keith Owens wrote:
> At 10:15 13-6-2002 +0200, Russell Coker wrote:
> >I wanted to build a system running the XFS file system and Linux Security
> >Modules (LSM), so I had a look at hacking the patch files to make them
> > work.
> >
> >I found one issue where the patches severely conflict, system call 1217 on
> >IA64 is sys_setxattr for XFS and is sys_security for LSM!
>
> The *attr syscall numbers are official, in both Linus and Marcelo
> kernels.  LSM is picking an arbitrary syscall number for testing so
> they will have to find another number - and change user space to match.

OK.  Shouldn't be a big issue.

> Pity Linus did not take my patch that reserves a range of syscall
> numbers for testing and provides a clean interface for determining
> which number to use.  Linus does not consider this to be a problem.

Yes, reserving a separate range for testing would be good, especially if you 
can make it work so that patches don't conflict...


BTW  XFS also changes the quota system in a serious way which breaks SE Linux 
(not LSM).

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
