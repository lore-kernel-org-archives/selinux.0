Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4JFTQRb011263
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 11:29:26 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4JFR1B2023741
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 15:27:01 GMT
Received: from smtp800.mail.ukl.yahoo.com (smtp800.mail.ukl.yahoo.com [217.12.12.142])
	by jazzswing.ncsc.mil  with SMTP id i4JFR0wi023733
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 15:27:00 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 19 May 2004 15:17:37 -0000
Date: Wed, 19 May 2004 15:15:00 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Ed Street <edstreet@street-tek.com>, "'SE-Linux'" <selinux@tycho.nsa.gov>
Subject: Re: adduser script
Message-ID: <20040519151459.GB17846@lkcl.net>
References: <20040519091721.GA8839@lkcl.net> <20040519115634.9C18D3A4054@abyss.simplyaquatics.com> <20040519133243.GD4221@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040519133243.GD4221@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 19, 2004 at 01:32:43PM +0000, Luke Kenneth Casson Leighton wrote:

>  investigating more, i find a package adduser-ng (adduser next
>  generation).
> 
>  it has a plugin system which has the ability to pass options up to
>  the main commandline usage, and even the /etc/shadow setup is
>  done as a plugin.
> 
>  ... it's written in perl.
> 
>  assuming i can get over my gratuitous and unnecessary lack of respect
>  for ptooey^H^H^H^H^Herl, could someone advise me if it's a simple
>  enough and acceptable procedure to:
> 
> 	 - accept an option --selinux-roles="staff sysadm user system"
> 	   (or maybe staff_r etc. because it will be less perl coding for
> 	    ME!)
 
 ... scratch that: the seuser program (by tresys) has, i believe,
 all of the functionality and options necessary.

 therefore, all i have to do is present that functionality by
 way of an adduser-ng plugin.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
