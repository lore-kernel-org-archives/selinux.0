Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5ALN7rT001665
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 17:23:07 -0400 (EDT)
Received: from smtp804.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i5ALN2P2028497
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2004 17:23:02 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 10 Jun 2004 21:23:05 -0000
Date: Thu, 10 Jun 2004 21:20:25 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ed Street <edstreet@street-tek.com>
Cc: "'SE-Linux'" <selinux@tycho.nsa.gov>
Subject: Re: [debian] postfix chroot setup from /etc/init.d/postfix isn't working.
Message-ID: <20040610212025.GI2861@lkcl.net>
References: <20040610205622.GF2861@lkcl.net> <20040610210645.33C6F3A404E@abyss.simplyaquatics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040610210645.33C6F3A404E@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

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

> Ed
> 
> -----Original Message-----
> From: Luke Kenneth Casson Leighton [mailto:lkcl@lkcl.net] 
> Sent: Thursday, June 10, 2004 4:56 PM
> To: Ed Street
> Cc: 'SE-Linux'
> Subject: Re: [debian] postfix chroot setup from /etc/init.d/postfix isn't
> working.
> 
> hi ed,
> 
>  okay, so you have a system which works out-the-box, and i don't.
> 
>  so we should compare notes to work out what the differences are.
> 
> 
> 
> ---
> 
> Checked by AVG anti-virus system (http://www.grisoft.com).
> Version: 6.0.698 / Virus Database: 455 - Release Date: 6/2/2004
>  
> 

-- 
-- 
Information I post is with honesty, integrity, and the expectation that
you will take full responsibility for acting on the information contained,
and that, should you find it to be flawed or even mildly useful, you
will act with both honesty and integrity in return - and tell me.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
