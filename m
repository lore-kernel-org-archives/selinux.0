Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5AJWarT000508
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 15:32:36 -0400 (EDT)
Received: from abyss.simplyaquatics.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5AJWWP2021740
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 15:32:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by abyss.simplyaquatics.com (Postfix) with ESMTP id 210C73A4066
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 14:32:20 -0500 (CDT)
Received: from TECRAS1 (simplyaquatics.com [209.192.116.78])
	by abyss.simplyaquatics.com (Postfix) with ESMTP id 8DD243A4066
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 14:32:18 -0500 (CDT)
From: "Ed Street" <edstreet@street-tek.com>
Cc: "'SE-Linux'" <selinux@tycho.nsa.gov>
Subject: RE: [debian] postfix chroot setup from /etc/init.d/postfix isn't working.
Date: Thu, 10 Jun 2004 15:32:18 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
In-Reply-To: <200406102220.19165.russell@coker.com.au>
Message-Id: <20040610193218.8DD243A4066@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Well like they say chroot is the poor mans security setup :) Disabling the
chroot jail would be the best solution overall.

Ed

-----Original Message-----
From: Russell Coker [mailto:russell@coker.com.au] 
Sent: Thursday, June 10, 2004 8:20 AM
To: Ed Street
Cc: 'SE-Linux'
Subject: Re: [debian] postfix chroot setup from /etc/init.d/postfix isn't
working.

On Thu, 10 Jun 2004 21:47, "Ed Street" <edstreet@street-tek.com> wrote:
> Then shouldn't it be postfix_etc_t instead of etc_t?

We could do something like that, although it would still require breaking
the 
design aim of "application should not have write access to it's own config 
files".

I think that the ideal solution would be to have a better mechanism of
turning 
off chroot operation.

 

---

Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.698 / Virus Database: 455 - Release Date: 6/2/2004
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
