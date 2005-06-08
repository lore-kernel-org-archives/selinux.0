Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5901ZgA006938
	for <selinux@tycho.nsa.gov>; Wed, 8 Jun 2005 20:01:35 -0400 (EDT)
Received: from glaurung.internal.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j58NsEMV013112
	for <selinux@tycho.nsa.gov>; Wed, 8 Jun 2005 23:54:15 GMT
Received: from glaurung.internal.golden-gryphon.com (srivasta@localhost [127.0.0.1])
	by glaurung.internal.golden-gryphon.com (8.13.4/8.13.4/Debian-3) with ESMTP id j58NnMBh031597
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <selinux@tycho.nsa.gov>; Wed, 8 Jun 2005 18:49:22 -0500
From: Manoj Srivastava <manoj.srivastava@stdc.com>
To: selinux@tycho.nsa.gov
Subject: Re: Labeling confusion with apt-get/dpkg
References: <20050603143639.59205.qmail@web33209.mail.mud.yahoo.com>
	<200506031609.j53G8v1W005959@turing-police.cc.vt.edu>
Date: Wed, 08 Jun 2005 18:49:22 -0500
In-Reply-To: <200506031609.j53G8v1W005959@turing-police.cc.vt.edu> (Valdis
	Kletnieks's message of "Fri, 03 Jun 2005 12:08:50 -0400")
Message-ID: <873brss931.fsf@glaurung.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 03 Jun 2005 12:08:50 -0400, Valdis Kletnieks
<Valdis.Kletnieks@vt.edu> said:  

> Maybe there's 8K lines of changes *total* - but the SELinux patches
> that Fedora puts into the 'pam' RPM total all of....

        Right. The  issue here is integrating SELinux in with the
 current Debian mods, and using a SCM that shall allow the maintainer
 to pull the changes back in. As an arch user, getting to know svn
 better is turning out to be a bad date ...

        manoj
-- 
"Nature loves a vacuum.  Digital doesn't."  DEC sales letter
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@acm.org> 
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
