Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8SMSFrT011591
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 18:28:15 -0400 (EDT)
Received: from monk.area614.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8SMRCuK013980
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 22:27:12 GMT
Subject: Re: [patch] types.fc
From: Colin Walters <walters@verbum.org>
To: jwcart2@epoch.ncsc.mil
Cc: Chris PeBenito <pebenito@gentoo.org>,
   SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1096396552.30810.77.camel@moss-lions.epoch.ncsc.mil>
References: <1095987749.7142.6.camel@gorn.pebenito.net>
	 <1096396552.30810.77.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain
Date: Tue, 28 Sep 2004 18:29:55 -0400
Message-Id: <1096410595.21408.26.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2004-09-28 at 14:35 -0400, James Carter wrote:
> Merged, except for the ifdef around the java sdk stuff.  This is not
> part of Fedora or RHEL (AFAIK), so I don't think that we want the
> ifdef.  

Right, that's just the place that Sun's JDK typically installs to, not
specific to Fedora or RHEL.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
