Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6MEOerT004533
	for <selinux@tycho.nsa.gov>; Thu, 22 Jul 2004 10:24:40 -0400 (EDT)
Received: from flame.hosts.ndo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i6MEOCrx014767
	for <selinux@tycho.nsa.gov>; Thu, 22 Jul 2004 14:24:13 GMT
Received: from th-pm03-19.ndirect.co.uk ([195.7.225.147] helo=lkcl.net)
	by flame.hosts.ndo.com with esmtp (NDO SMTP Pool (Abuse to: abuse@ndo.com))
	id 1BneUs-00087h-00
	for <selinux@tycho.nsa.gov>; Thu, 22 Jul 2004 15:24:34 +0100
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1Bnefc-0001SG-2H
	for selinux@tycho.nsa.gov; Thu, 22 Jul 2004 15:35:40 +0100
Date: Thu, 22 Jul 2004 15:35:40 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SELinux <selinux@tycho.nsa.gov>
Subject: Re: running interpreted scripts in different domains
Message-ID: <20040722143540.GJ3252@lkcl.net>
References: <40FADE92.7060307@gentoo.org> <1090338174.25139.60.camel@moss-lions.epoch.ncsc.mil> <40FD6114.3020808@gentoo.org> <1090355250.25139.130.camel@moss-lions.epoch.ncsc.mil> <40FD814B.2060503@gentoo.org> <20040721230605.GD2848@jmh.mhn.de> <20040722085651.GD3252@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040722085651.GD3252@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 22, 2004 at 09:56:51AM +0100, Luke Kenneth Casson Leighton wrote:
> *system* was used to "represent" the cron system such that if a
> getpwnam was called with "*system*" it would always fail).
> 
> of course, cron _does_ have the concept of system, called system_u :)
 
 duh, i meant selinux does have the concept of system, called system_u.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
