Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l6ICZIY9020541
	for <selinux@tycho.nsa.gov>; Wed, 18 Jul 2007 08:35:18 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l6ICZFuQ004365
	for <selinux@tycho.nsa.gov>; Wed, 18 Jul 2007 12:35:15 GMT
Subject: Re: [POLICYREP] [RFC/PATCH 2/3] policy package implementation
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Joshua Brindle <method@manicmethod.com>, selinux@tycho.nsa.gov
In-Reply-To: <1184706680.10625.26.camel@localhost.localdomain>
References: <20070717150336.135143158@manicmethod.com>
	 <20070717150431.660417962@manicmethod.com>
	 <1184686730.3833.11.camel@localhost.localdomain>
	 <469CF0EC.8030704@manicmethod.com>
	 <1184697355.3833.28.camel@localhost.localdomain>
	 <469D2B2B.1080704@manicmethod.com>
	 <1184705762.10625.14.camel@localhost.localdomain>
	 <469D2E2C.5020405@manicmethod.com>
	 <1184706680.10625.26.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 18 Jul 2007 12:32:46 +0000
Message-Id: <1184761966.10118.14.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-07-17 at 17:11 -0400, Karl MacMillan wrote:
> On Tue, 2007-07-17 at 17:01 -0400, Joshua Brindle wrote:
> > Karl MacMillan wrote:
> 
> [...]
> 
> > 
> > It doesn't seem reasonable to essentially reproduce the m4 preprocessing 
> > statements just to keep a single parser. just look at a preprocessed 
> > module and see how nasty it looks:
> > 
> > #line 156537 "tmp/all_interfaces.conf"
> >        
> > #line 1 "policy/modules/services/sendmail.te"
> > 
> >        
> > #line 2
> >       
> > #line 2
> >                 module sendmail 1.3.1;
> > #line 2
> > 
> > #line 2
> >                 require {
> > #line 2
> >                         role system_r;
> > #line 2
> > 
> 
> 1) so what?
> 2) it doesn't have to be that ugly - the repeated line number thing is
> an artifact of M4.

The line number and file name comments are optional in M4 and only
turned on (via M4's -s option) since the current compiler can leverage
them for the file name and line number in error messages.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
