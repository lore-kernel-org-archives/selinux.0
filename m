Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5AKdxrT001201
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 16:39:59 -0400 (EDT)
Received: from abyss.simplyaquatics.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5AKdvaH023443
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 16:39:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by abyss.simplyaquatics.com (Postfix) with ESMTP id 4A4C13A4069
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 15:39:58 -0500 (CDT)
Received: from TECRAS1 (simplyaquatics.com [209.192.116.78])
	by abyss.simplyaquatics.com (Postfix) with ESMTP id A59FC3A4069
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 15:39:56 -0500 (CDT)
From: "Ed Street" <edstreet@street-tek.com>
Cc: "'SE-Linux'" <selinux@tycho.nsa.gov>
Subject: RE: [debian] postfix chroot setup from /etc/init.d/postfix isn't working.
Date: Thu, 10 Jun 2004 16:39:54 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
In-Reply-To: <20040610202615.GC2861@lkcl.net>
Message-Id: <20040610203956.A59FC3A4069@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

As stated numerous times in the past write access to etc_t is a horrible
idea.  What would be better is maybe use postfix_etc_t or something similar,
correct me if I'm wrong but are we not already using postfix_etc_t? if so
then maybe a postfix_spool_etc_t.

Ed

-----Original Message-----
From: Luke Kenneth Casson Leighton [mailto:lkcl@lkcl.net] 
Sent: Thursday, June 10, 2004 4:26 PM
To: Ed Street
Cc: 'SE-Linux'
Subject: Re: [debian] postfix chroot setup from /etc/init.d/postfix isn't
working.

On Wed, Jun 09, 2004 at 10:22:21PM -0400, Ed Street wrote:
> Well why ANY app needs write access to /etc is beyond me.  Also are you
> using run_init /etc/init.d/foo ?
 
 yes, i am, and that's part of the problem.

 if you do an ls --context /var/spool/postfix/etc and compare the files
 listed there to ls --context /etc for example (there are others)
 you will find that the contexts are identical.

 therefore, in order for the chroot jail files to be copyable 
 (and overwritable!) from /etc to /var/spool/postfix/etc,
 and from /lib to /var/spool/postfix/lib, it is necessary to
 give initrd_t (which is what run_init drops you into, yes)
 write permission to etc_t (amongst other things).

 if you do that, you get a policy violation (build error) on a
 "make policy" on one of the checks that bans you from doing
 things like give initrd_t access to writing in etc_t or
 etc_runtime_t.

 l.


-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility for acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

---

Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.698 / Virus Database: 455 - Release Date: 6/2/2004
 

---

Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.698 / Virus Database: 455 - Release Date: 6/2/2004
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
