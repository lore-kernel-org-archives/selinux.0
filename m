Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4JBrPRb009302
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 07:53:25 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4JBoxB2003800
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 11:50:59 GMT
Received: from smtp800.mail.ukl.yahoo.com (smtp800.mail.ukl.yahoo.com [217.12.12.142])
	by jazzswing.ncsc.mil  with SMTP id i4JBowwi003794
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 11:50:58 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 19 May 2004 11:53:19 -0000
Received: from highfield ([192.168.0.223]:32817 helo=lkcl.net)
	by lkcl.net with esmtp (Exim 4.24 #1)
	id 1BQPgE-00008n-OE
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 11:56:14 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BQPap-0005zJ-AG
	for selinux@tycho.nsa.gov; Wed, 19 May 2004 11:50:39 +0000
Date: Wed, 19 May 2004 11:50:39 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: is this pretty much it (to patch kdm 3.2.2)?
Message-ID: <20040519115039.GB4221@lkcl.net>
References: <20040519074242.GK7348@lkcl.net> <20040519100822.GA31914@colombo.cip.ifi.lmu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040519100822.GA31914@colombo.cip.ifi.lmu.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, May 19, 2004 at 12:08:22PM +0200, Thomas Bleher wrote:
> * Luke Kenneth Casson Leighton <lkcl@lkcl.net> [2004-05-19 11:06]:
> > is this pretty much all that's required???  compared to the 2.4 stuff
> > it's like tiny.
> > 
> > this is all that the patch to wdm does.  i'm just a little surprised
> > (pleasantly so).
> > 
> > --- client.c.old	2004-05-19 07:40:58.000000000 +0000
> > +++ kdm/backend/client.c	2004-05-19 07:18:01.000000000 +0000
> <snip patch>
> 
> I don't think that even this is required. It should work without
> patching, just using pam_selinux.so.
 
 oh?

 do you have some example usage that i can try out, and does
 anyone have any advice on how to ensure that installation
 of debian packages (pam and selinux and kde) would result
 in pam being automatically updated?

 sincerely,

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
