Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA07585
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 11:40:42 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id PAA26524
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 15:40:25 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id PAA26519
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 15:40:23 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: richard offer <offer@sgi.com>, linux-security-module@wirex.com
Subject: Re: XFS and LSM
Date: Thu, 13 Jun 2002 17:40:11 +0200
Cc: seth@arosa.nl, SE Linux <selinux@tycho.nsa.gov>
References: <20020613081508.DF46C1CBC@lyta.coker.com.au> <597600000.1023980333@changeling.engr.sgi.com>
In-Reply-To: <597600000.1023980333@changeling.engr.sgi.com>
MIME-Version: 1.0
Message-Id: <20020613154011.9D53D6D82@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 13 Jun 2002 16:58, richard offer wrote:
> * frm russell@coker.com.au "06/13/02 10:15:08 +0200" | sed '1,$s/^/* /'
> *
> * I wanted to build a system running the XFS file system and Linux Security
> * Modules (LSM), so I had a look at hacking the patch files to make them
> * work.
> *
> * I found one issue where the patches severely conflict, system call 1217
> * on  IA64 is sys_setxattr for XFS and is sys_security for LSM!
> *
> * One of the projects has to change the system call.
>
> The official IA64 syscall number for sys_security will be 1233, as assigned
> by David Mosberger on May 28 in response to an email I sent him.

OK, could we have another release incorporating the correct number in the 
near future?

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
