Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5D1SxrT012075
	for <selinux@tycho.nsa.gov>; Sat, 12 Jun 2004 21:28:59 -0400 (EDT)
Received: from ms-smtp-02.rdc-kc.rr.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i5D1SrP2001507
	for <selinux@tycho.nsa.gov>; Sat, 12 Jun 2004 21:28:53 -0400 (EDT)
Received: from sasami.localdomain (CPE-24-31-241-155.kc.rr.com [24.31.241.155])
	by ms-smtp-02.rdc-kc.rr.com (8.12.10/8.12.7) with ESMTP id i5D1Sq9W025521
	for <selinux@tycho.nsa.gov>; Sat, 12 Jun 2004 20:28:55 -0500 (CDT)
Date: Sat, 12 Jun 2004 20:28:52 -0500
From: Greg Norris <haphazard@kc.rr.com>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: SELinux on Debian (Sid)
Message-ID: <20040613012852.GA4210@yggdrasil.localdomain>
References: <20040609144404.GJ5477@philips.com> <200406121819.57709.russell@coker.com.au> <20040612143714.GA28996@yggdrasil.localdomain> <200406131029.35825.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200406131029.35825.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Jun 13, 2004 at 10:29:35AM +1000, Russell Coker wrote:
> On Sun, 13 Jun 2004 00:37, Greg Norris <haphazard@kc.rr.com> wrote:
> > adric@sasami[~]$ dpkg -l selinux-policy-default | tail -1
> > iF  selinux-policy 1.12-3         Policy config files and management for
> 
> When you upgraded the policy and you were asked for replacing policy files, 
> did you say "Ignore" or "Always ignore" to the new files?

Neither... this was my original install, so I wasn't replacing any
existing policies.  I just selected the policies which seemed relevant,

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
