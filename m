Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4JEXTRb010623
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 10:33:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4JEV4B2018263
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 14:31:04 GMT
Received: from smtp804.mail.ukl.yahoo.com (smtp804.mail.ukl.yahoo.com [217.12.12.141])
	by jazzswing.ncsc.mil  with SMTP id i4JEV3wi018260
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 14:31:03 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 19 May 2004 14:24:15 -0000
Date: Wed, 19 May 2004 14:21:39 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ed Street <edstreet@street-tek.com>
Cc: "'SE-Linux'" <selinux@tycho.nsa.gov>
Subject: Re: adduser script
Message-ID: <20040519142138.GH4221@lkcl.net>
References: <20040519133243.GD4221@lkcl.net> <20040519134441.672D53A4054@abyss.simplyaquatics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040519134441.672D53A4054@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 19, 2004 at 09:44:40AM -0400, Ed Street wrote:
> Hello,
> 
> That should work. One other thing you may want do is give the user a choice
> in which role(s) to assign, that would eliminate any typo's and be newbie
> friendly, say 1) user_r 2) staff_r 3 sysadm_r q) quit or something similar.
> By default any abuser not in the users file is assigned user_r.
 
 ed, looks like tresys have already done the hard work with the seuseradd
 scripts as part of the setools package (in cvs on sf.net at least)

 the seuseradd scripts, however, duplicate the role of adduser, by
 1) calling useradd (which manages /etc/passwd) 2) modifying
 /etc/selinux/users direct.

 what is ideally required is a separate program that doesn't call
 useradd, then it's a trivial task to write a plugin for adduser-ng
 to call that separate program.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
