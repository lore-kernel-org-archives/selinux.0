Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4JDauRb010105
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 09:36:56 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4JDYUB2012617
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 13:34:31 GMT
Received: from smtp800.mail.ukl.yahoo.com (smtp800.mail.ukl.yahoo.com [217.12.12.142])
	by jazzswing.ncsc.mil  with SMTP id i4JDYTwi012607
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 13:34:29 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 19 May 2004 13:35:21 -0000
Date: Wed, 19 May 2004 13:32:43 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ed Street <edstreet@street-tek.com>
Cc: "'SE-Linux'" <selinux@tycho.nsa.gov>
Subject: Re: adduser script
Message-ID: <20040519133243.GD4221@lkcl.net>
References: <20040519091721.GA8839@lkcl.net> <20040519115634.9C18D3A4054@abyss.simplyaquatics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040519115634.9C18D3A4054@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 19, 2004 at 07:56:33AM -0400, Ed Street wrote:
> Hello,
> 
> That should not be to difficult, just pass a context(s) switch or prompt for
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

> -----Original Message-----
> From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
> Behalf Of Luke Kenneth Casson Leighton
> Sent: Wednesday, May 19, 2004 5:17 AM
> To: SE-Linux
> Subject: adduser script
> 
> has anyone considered writing an adduser script modification
> for selinux that adds users to /etc/selinux/users?
> 
> ---
> 
> Checked by AVG anti-virus system (http://www.grisoft.com).
> Version: 6.0.687 / Virus Database: 448 - Release Date: 5/16/2004
>  
> 

-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
