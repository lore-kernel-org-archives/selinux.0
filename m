Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5UBfAgA021028
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 07:41:10 -0400 (EDT)
Received: from free.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5UBdWBs011421
	for <selinux@tycho.nsa.gov>; Thu, 30 Jun 2005 11:39:32 GMT
Date: Thu, 30 Jun 2005 12:49:06 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Ron Kuris <rk@unify.com>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: wish-list item for selinux policy analyss
Message-ID: <20050630114906.GI8415@lkcl.net>
References: <20050630010526.GE8415@lkcl.net> <20050630010443.9261.qmail@web31614.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050630010443.9261.qmail@web31614.mail.mud.yahoo.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Jun 29, 2005 at 06:04:43PM -0700, Casey Schaufler wrote:
> 
> 
> --- Luke Kenneth Casson Leighton <lkcl@lkcl.net>
> wrote:
> 
> > > I think the logic here is backwards.  
> > 
> >  yep.  selinux is "MAC".
> 
> Damn, and here I was, thinking it was "CAM" all along.

 hey, content addressable memory would help enormously here
 because you could use an policy lookup algorithm that would
 on a non-parallelised system be much less efficient yada yada.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
