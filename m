Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71AO4rT006256
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 06:24:04 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i71ANW52019589
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 10:23:32 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 1 Aug 2004 10:24:03 -0000
Date: Sun, 1 Aug 2004 11:35:09 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: genhomedircon - bugs in sed stuff with unknown { } characters
Message-ID: <20040801103509.GE7384@lkcl.net>
References: <20040731122721.GN3378@lkcl.net> <200408011932.54960.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408011932.54960.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Aug 01, 2004 at 07:32:54PM +1000, Russell Coker wrote:
> On Sat, 31 Jul 2004 22:27, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > okay, i removed the {s and }s from the genhomedircon's use of sed,
> > and whoopee, off it went, looks like it's working now.
> 
> You need to have a recent version of sed, do you have the latest version 
> installed?
 
  ah.  probably not.

  ... one for the .deb dependencies, methinks?



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
