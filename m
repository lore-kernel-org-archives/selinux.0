Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4JKK7gA017517
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 16:20:07 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j4JKFvDf025803
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 20:15:57 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies [144.51.25.7])
	by epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4JKGaRH016644
	for <selinux@tycho.nsa.gov>; Thu, 19 May 2005 16:16:36 -0400 (EDT)
Subject: Re: [RFC]{Patch 0/5] Polyinstantation
From: Chad Sellers <cdselle@tycho.nsa.gov>
To: selinux@tycho.nsa.gov
In-Reply-To: <1115983813.3576.13.camel@moss-spartans.epoch.ncsc.mil>
References: <1115825335.28084.27.camel@moss-huskies.epoch.ncsc.mil>
	 <1115896944.32202.22.camel@moss-spartans.epoch.ncsc.mil>
	 <1115904167.30162.7.camel@moss-huskies.epoch.ncsc.mil>
	 <200505131440.42410.russell@coker.com.au>
	 <1115983813.3576.13.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain
Date: Thu, 19 May 2005 16:17:23 -0400
Message-Id: <1116533843.22044.15.camel@moss-huskies.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I have updated the library in response to Dan's interest in per-user
/tmp directories.  I'll be sending updated versions of the patches along
in another string of emails.

The library now handles polyinstantiation based on selinux policy (as
before), uid, or both.  To accomplish this, security_setupns now takes
an additional argument, the uid.  The choice between these three modes
is made on a per directory basis and specified in the config file.
Additionally, the config file allows specification of a default mode
for member directories, as well as users that are exempt from uid-based
polyinstantiation.  Since the config file is a little more useful now,
I formatted it a little better.  The global options go at the top in
name-value pair format, and the directories with their modes go at the
bottom.

Thanks,
Chad

-- 
Chad Sellers
cdselle@tycho.nsa.gov


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
