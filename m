Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4JDj9Rb010190
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 09:45:09 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4JDghB2013510
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 13:42:44 GMT
Received: from abyss.simplyaquatics.com (abyss.simplyaquatics.com [69.44.152.139])
	by jazzswing.ncsc.mil  with ESMTP id i4JDghwi013459
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 13:42:43 GMT
From: "Ed Street" <edstreet@street-tek.com>
To: "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>
Cc: "'SE-Linux'" <selinux@tycho.nsa.gov>
Subject: RE: adduser script
Date: Wed, 19 May 2004 09:44:40 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
In-Reply-To: <20040519133243.GD4221@lkcl.net>
Message-Id: <20040519134441.672D53A4054@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

That should work. One other thing you may want do is give the user a choice
in which role(s) to assign, that would eliminate any typo's and be newbie
friendly, say 1) user_r 2) staff_r 3 sysadm_r q) quit or something similar.
By default any abuser not in the users file is assigned user_r.

Ed

-----Original Message-----
From: Luke Kenneth Casson Leighton [mailto:lkcl@lkcl.net] 
Sent: Wednesday, May 19, 2004 9:33 AM
To: Ed Street
Cc: 'SE-Linux'
Subject: Re: adduser script

On Wed, May 19, 2004 at 07:56:33AM -0400, Ed Street wrote:
> Hello,
> 
> That should not be to difficult, just pass a context(s) switch or prompt
for
> it.

 investigating more, i find a package adduser-ng (adduser next
 generation).

 it has a plugin system which has the ability to pass options up to
 the main commandline usage, and even the /etc/shadow setup is
 done as a plugin.

 ... it's written in perl.

 assuming i can get over my gratuitous and unnecessary lack of respect
 for ptooey^H^H^H^H^Herl, could someone advise me if it's a simple
 enough and acceptable procedure to:

	 - accept an option --selinux-roles="staff sysadm user system"
	   (or maybe staff_r etc. because it will be less perl coding for
	    ME!)

	 - parse the /etc/selinux/users file looking for the string
	   "user [$username] roles"

	 - replace the relevant line with the roles _r
	   (if i can be bothered)

	 - do a syscall to "make -C /etc/selinux install"

 and leave it at that - all pretty much hard-coded.

 - no checking / parsing of the roles because other roles may be
   added by the sysadmin


 thoughts, comments?
 
 how do i do a delete?
 _do_ i have to do a delete?

 if a role is left in the /etc/selinux/users and there is no passwd
 entry, does it matter?

 l.
 

---

Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.687 / Virus Database: 448 - Release Date: 5/16/2004
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
