Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAOFTvIi020179
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 10:29:58 -0500 (EST)
Received: from tcsfw2.tcs-sec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAOFTwCA028246
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 15:30:00 GMT
Message-ID: <41A4A921.9060105@trustedcs.com>
Date: Wed, 24 Nov 2004 09:30:41 -0600
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: "Joshua D. Guttman disp: slinux" <guttman@mitre.org>,
   Amy L Herzog <aherzog@mitre.org>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@tcs-sec.com>
Subject: Re: dynamic context transitions
References: <4182959B.4080503@trustedcs.com>	 <1099328185.21386.140.camel@moss-spartans.epoch.ncsc.mil>	 <20041112184232.GK15243@golconda.mitre.org>	 <1100527665.31773.41.camel@moss-spartans.epoch.ncsc.mil>	 <nhau0rm54ra.fsf@malabar.mitre.org>	 <1100874782.15944.67.camel@moss-spartans.epoch.ncsc.mil>	 <419E1F76.9080803@trustedcs.com> <1100884644.15944.181.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1100884644.15944.181.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> Unless you have an actual usage scenario for this functionality, I'd
> suggest a simple prohibition of any change in context even by the thread
> group leader if there are any child threads.  That would still allow a
> process to change its context prior to spawning any threads, e.g. to
> shed privileges during startup.  Changing the security attributes of
> other threads without their explicit awareness/consent is undesirable;
> note that SELinux currently prevents setprocattr on another task.

The prohibition works for us.  Would you like a new patch with these changes?

-- 

Darrel

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
