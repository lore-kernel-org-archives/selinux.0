Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71DhHrT006990
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 09:43:17 -0400 (EDT)
Received: from smtp804.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i71DhF0x021139
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 13:43:15 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 1 Aug 2004 13:43:16 -0000
Date: Sun, 1 Aug 2004 14:54:21 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: selinux-policy-default 1.14 is missing _stacks_ of stuff
Message-ID: <20040801135421.GE15205@lkcl.net>
References: <20040801103252.GC7384@lkcl.net> <200408012254.15553.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408012254.15553.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Aug 01, 2004 at 10:54:15PM +1000, Russell Coker wrote:
> On Sun, 1 Aug 2004 20:32, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > there appears to be quite a lot of things missing from the
> > debian selinux-policy-default package.
> >
> > - the appconfig directory
> > - the targeted directory
> > - the strict directory.
> 
> There is no support for targeted in Debian, only strict and it has the 
> directory name "." .
> 
> > so, i can't use run_init because targeted/contexts/initrc_context
> > doesn't exist.
> 
> Your /etc/selinux/config file should have the following line:
> SELINUXTYPE=.
 
 ah... there isn't an /etc/selinux/config file...

 perhaps that is the cause of the problem?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
