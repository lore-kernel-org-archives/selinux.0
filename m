Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i919OmrT000037
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 05:24:48 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i919OkEZ023809
	for <selinux@tycho.nsa.gov>; Fri, 1 Oct 2004 09:24:47 GMT
Date: Fri, 1 Oct 2004 10:35:58 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Colin Walters <walters@verbum.org>
Cc: Thomas Bleher <bleher@informatik.uni-muenchen.de>,
   SELinux ML <selinux@tycho.nsa.gov>
Subject: Re: Access to xdm_t
Message-ID: <20041001093558.GB4932@lkcl.net>
References: <20040929163222.GA4125@rom.cip.ifi.lmu.de> <1096561927.4957.15.camel@nexus.verbum.private> <20040930192935.GA6063@lkcl.net> <1096591648.5736.3.camel@nexus.verbum.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1096591648.5736.3.camel@nexus.verbum.private>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Sep 30, 2004 at 08:47:28PM -0400, Colin Walters wrote:

> >  /usr/bin/startkde for example?
> 
> I think the idea with doing it inside ?dm was to keep common
> functionality inside the display manager; also it ensures you get an
> error log even if your session script fails early on (and gdm will offer
> to display the error log for example if your session lasts less than 10
> seconds, which it can really only do if it knows the name of the error
> log).

 if the log file goes into a common directory, that same functionality
 can be achieved.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
