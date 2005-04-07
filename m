Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j37HXBue028132
	for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2005 13:33:11 -0400 (EDT)
Subject: Re: More patches
From: James Carter <jwcart2@epoch.ncsc.mil>
Reply-To: jwcart2@epoch.ncsc.mil
To: ivg2@cornell.edu
Cc: Daniel J Walsh <dwalsh@redhat.com>, SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1112823549.20840.4.camel@cobra.ivg2.net>
References: <200502032350.40924.russell@coker.com.au>
	 <1108048794.10328.14.camel@moss-lions.epoch.ncsc.mil>
	 <4253CD52.1090206@redhat.com>
	 <1112790317.4187.1.camel@moss-lions.epoch.ncsc.mil>
	 <4253D7BA.6030604@redhat.com> <1112810151.7822.4.camel@cobra.ivg2.net>
	 <42542F02.2020304@redhat.com> <1112811239.3469.4.camel@cobra.ivg2.net>
	 <42543BBD.4090308@redhat.com> <1112814718.3817.6.camel@cobra.ivg2.net>
	 <42544387.6010706@redhat.com>  <1112823549.20840.4.camel@cobra.ivg2.net>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 13:31:49 -0400
Message-Id: <1112895109.6414.5.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged.

On Wed, 2005-04-06 at 17:39 -0400, Ivan Gyurdiev wrote:
> > BTW have you done anything with dmidecode?
> 
> Now attached - small domain for dmidecode that allows
> it to read /dev/mem and gives it rawio privileges.
> 
> Patch for hal to transition to this domain, 
> as well as bringing back the netlink rule for backwards compatibility.
> 
-- 
James Carter <jwcart2@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
