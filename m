Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i71DkwrT007008
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 09:46:58 -0400 (EDT)
Received: from smtp804.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i71Dku0x021155
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2004 13:46:57 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp804.mail.ukl.yahoo.com with SMTP; 1 Aug 2004 13:46:57 -0000
Date: Sun, 1 Aug 2004 14:58:03 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: selinux-policy-default 1.14 is missing _stacks_ of stuff
Message-ID: <20040801135803.GG15205@lkcl.net>
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
 
 there's no mention of SELINUXTYPE in the [sf.net cvs] Makefiles:
 remember i am in a bit of a rush so have replaced
 selinux-policy-default package with sf.net cvs.

 ... but checking the debian/* i find no mention of SELINUXTYPE.

 presumably, therefore /etc/selinux/config is something created
 by the rpm spec files?

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
