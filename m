Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i5D7vNrT013049
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2004 03:57:23 -0400 (EDT)
Received: from smtp800.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i5D7vKkj021439
	for <selinux@tycho.nsa.gov>; Sun, 13 Jun 2004 03:57:20 -0400 (EDT)
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.155.76.36 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 13 Jun 2004 07:57:11 -0000
Received: from highfield ([192.168.0.223] helo=lkcl.net)
	by hyd with esmtp (Exim 4.34)
	id 1BZPEl-0002DR-R6
	for selinux@tycho.nsa.gov; Sun, 13 Jun 2004 07:17:03 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BZPox-00067w-Me
	for selinux@tycho.nsa.gov; Sun, 13 Jun 2004 07:54:27 +0000
Date: Sun, 13 Jun 2004 07:54:27 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: selinux@tycho.nsa.gov
Subject: Re: SELinux on Debian (Sid)
Message-ID: <20040613075427.GZ2861@lkcl.net>
References: <20040609144404.GJ5477@philips.com> <200406121819.57709.russell@coker.com.au> <20040612143714.GA28996@yggdrasil.localdomain> <200406131029.35825.russell@coker.com.au> <20040613012852.GA4210@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040613012852.GA4210@yggdrasil.localdomain>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Jun 12, 2004 at 08:28:52PM -0500, Greg Norris wrote:
> On Sun, Jun 13, 2004 at 10:29:35AM +1000, Russell Coker wrote:
> > On Sun, 13 Jun 2004 00:37, Greg Norris <haphazard@kc.rr.com> wrote:
> > > adric@sasami[~]$ dpkg -l selinux-policy-default | tail -1
> > > iF  selinux-policy 1.12-3         Policy config files and management for
> > 
> > When you upgraded the policy and you were asked for replacing policy files, 
> > did you say "Ignore" or "Always ignore" to the new files?
> 
> Neither... this was my original install, so I wasn't replacing any
> existing policies.  I just selected the policies which seemed relevant,

if i was you i would, as i said, delete the original install and
use russell's 1.12-3 policy.

when the 1.12-1 was released that was the only way that i managed
to get something going that i could work with.

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
