Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5ABlwrT026569
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 07:47:58 -0400 (EDT)
Received: from abyss.simplyaquatics.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5ABltaH003557
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 07:47:56 -0400 (EDT)
From: "Ed Street" <edstreet@street-tek.com>
To: <russell@coker.com.au>
Cc: "'SE-Linux'" <selinux@tycho.nsa.gov>
Subject: RE: [debian] postfix chroot setup from /etc/init.d/postfix isn't working.
Date: Thu, 10 Jun 2004 07:47:41 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <200406101510.31547.russell@coker.com.au>
Message-Id: <20040610114741.2796A3A4066@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Then shouldn't it be postfix_etc_t instead of etc_t?

Ed

-----Original Message-----
From: Russell Coker [mailto:russell@coker.com.au] 
Sent: Thursday, June 10, 2004 1:11 AM
To: Ed Street
Cc: 'Luke Kenneth Casson Leighton'; 'SE-Linux'
Subject: Re: [debian] postfix chroot setup from /etc/init.d/postfix isn't
working.

On Thu, 10 Jun 2004 12:22, "Ed Street" <edstreet@street-tek.com> wrote:
> Well why ANY app needs write access to /etc is beyond me.  Also are you
> using run_init /etc/init.d/foo ?

It's not /etc, it's /var/spool/postfix/etc.  Fortunately LaMont addressed
this 
issue in version 1.1.7-5 by making the files not be copied to the chroot if 
master.cf does not specify any services to be chrooted.

 

---

Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.698 / Virus Database: 455 - Release Date: 6/2/2004
 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
