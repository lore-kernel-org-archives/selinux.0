Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5AN8QrT002668
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 19:08:26 -0400 (EDT)
Received: from abyss.simplyaquatics.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5AN8LP2002713
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 19:08:21 -0400 (EDT)
From: "Ed Street" <edstreet@street-tek.com>
To: "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>
Cc: "'SE-Linux'" <selinux@tycho.nsa.gov>
Subject: RE: [debian] postfix chroot setup from /etc/init.d/postfix isn't working.
Date: Thu, 10 Jun 2004 19:08:23 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
In-Reply-To: <20040610212025.GI2861@lkcl.net>
Message-Id: <20040610230824.1CCD83A404E@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

Yes I'm very assured the email setup is working because I get notification
daily about various things.  Also it's not setup for outbound email to the
open inet, yet.

As for postfix 2.2 I'll look into it an hopefully drop it on.  Now the
issues you have with postfix is that under 2.2 or 2.0.19 under SID?

Ed

-----Original Message-----
From: Luke Kenneth Casson Leighton [mailto:lkcl@lkcl.net] 
Sent: Thursday, June 10, 2004 5:20 PM
To: Ed Street
Cc: 'SE-Linux'
Subject: Re: [debian] postfix chroot setup from /etc/init.d/postfix isn't
working.

On Thu, Jun 10, 2004 at 05:06:44PM -0400, Ed Street wrote:
> Ssh root@support.simplyaquatics.com port 2000 root password is 1234 or
> http://selinux.simplyaquatics.com  this is the public debian test box :)
 
 ah ha!

 root@test-box:~# dpkg -l | grep postfix
 ii  postfix        2.0.19-1       A high-performance mail transport agent
 ii  postfix-tls    2.0.19-1       TLS and SASL support for Postfix

 root@test-box:~# more /etc/default/postfix
 /etc/default/postfix: No such file or directory

 hmm... 


 root@test-box:~# more /etc/motd
 Linux test-box 2.6.5sel2-pax #2 SMP Sat Apr 17 18:04:14 EDT 2004 i686
 GNU/Linux

 hmm some more.

 root@test-box:~# cd /var/spool/postfix 
 -bash: cd: /var/spool/postfix: Permission denied
 root@test-box:~# ls -altr !$
 ls -altr /var/spool/postfix
 ls: /var/spool/postfix: Permission denied

 hm, i can't get any further with that line of enquiry, let's
 try /etc/selinux/file_contexts/program/postfix instead:

	 /var/spool/postfix/etc(/.*)?    system_u:object_r:etc_t
	 /var/spool/postfix/lib(/.*)?    system_u:object_r:lib_t
	 /var/spool/postfix/usr(/.*)?    system_u:object_r:lib_t

 examining the /etc/init.d/postfix file it looks pretty much
 the same as on my system.


 ed, you want to try (read, would you mind) upgrading postfix to
 2.2.thingy?

 
 are you _sure_ that postfix is working??? :)

 btw, you noticed that thomas said that the consensus was to
 set SYNC_CHROOT=""?

 l.
 

---

Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.698 / Virus Database: 455 - Release Date: 6/2/2004
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
