Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6T8hGrT017041
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 04:43:16 -0400 (EDT)
Received: from smtp803.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i6T8hFCb028318
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 08:43:15 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp803.mail.ukl.yahoo.com with SMTP; 29 Jul 2004 08:43:15 -0000
Date: Thu, 29 Jul 2004 09:54:22 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: modifications to cups policy (maybe debian specific)
Message-ID: <20040729085422.GB6443@lkcl.net>
References: <20040728125206.GA3158@lkcl.net> <200407291634.23922.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200407291634.23922.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 29, 2004 at 04:34:23PM +1000, Russell Coker wrote:
> On Wed, 28 Jul 2004 22:52, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > FHS policy violation in cupsys daemon where certs were stored in
> > /etc/cups has been fixed - in debian version 1.1.20final+rcSomething.
> >
> > i added the following, also removing the /etc/cups/certs references which
> > are set to cupsd_rw_etc_t.
> >
> > 	/var/lib/cups/certs		-d	system_u:object_r:cupsd_var_t
> > 	/var/lib/cups/certs/.*	--	system_u:object_r:cupsd_var_t
> 
> /var/lib/cups/certs     -d      system_u:object_r:cupsd_rw_etc_t
> /var/lib/cups/certs/.*  --      system_u:object_r:cupsd_rw_etc_t
> 
> Add the above to cups.fc and it should be fine.
 
 ... yes... i think you're right.  my brain thought it wanted to
 remove cupsd_rw_etc_t but i don't think that's possible because
 cupsd writes to cups.conf (doesn't it?)

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
