Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i52478rT001166
	for <selinux@tycho.nsa.gov>; Wed, 2 Jun 2004 00:07:08 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i5346reD017451
	for <selinux@tycho.nsa.gov>; Thu, 3 Jun 2004 00:06:53 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 1 Jun 2004 09:20:26 -0000
Date: Tue, 1 Jun 2004 09:17:52 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: exim (running from cron) attempting to write to logs under system_cron_t
Message-ID: <20040601091752.GQ8312@lkcl.net>
References: <20040601091012.GN8312@lkcl.net> <200406011918.35292.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406011918.35292.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Jun 01, 2004 at 07:18:35PM +1000, Russell Coker wrote:
> On Tue, 1 Jun 2004 19:10, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > hiya russell,
> >
> > what's this one about?
> >
> > allow system_crond_t var_log_t:file { append };
> >         #EXE=/usr/sbin/exim  NAME=mainlog   :  append
> > 		#EXE=/usr/sbin/exim  NAME=mainlog   :  append
> 
> There is no policy for Exim.  Exim needs some patches for best operation with 
> SE Linux, upstream has agreed to them in concept, someone just needs to 
> implement them.  Check the list archives, I think I've summarised what needs 
> to be done if you want to do the coding.

okie.

fuuun :)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
