Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAOFaLIi020229
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 10:36:21 -0500 (EST)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAOFaOC8028474
	for <selinux@tycho.nsa.gov>; Wed, 24 Nov 2004 15:36:24 GMT
Subject: Re: dynamic context transitions
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "Joshua D. Guttman disp: slinux" <guttman@mitre.org>,
   Amy L Herzog <aherzog@mitre.org>,
   "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
   Chad Hanson <chanson@tcs-sec.com>
In-Reply-To: <41A4A921.9060105@trustedcs.com>
References: <4182959B.4080503@trustedcs.com>
	 <1099328185.21386.140.camel@moss-spartans.epoch.ncsc.mil>
	 <20041112184232.GK15243@golconda.mitre.org>
	 <1100527665.31773.41.camel@moss-spartans.epoch.ncsc.mil>
	 <nhau0rm54ra.fsf@malabar.mitre.org>
	 <1100874782.15944.67.camel@moss-spartans.epoch.ncsc.mil>
	 <419E1F76.9080803@trustedcs.com>
	 <1100884644.15944.181.camel@moss-spartans.epoch.ncsc.mil>
	 <41A4A921.9060105@trustedcs.com>
Content-Type: text/plain
Message-Id: <1101310307.22014.148.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Wed, 24 Nov 2004 10:31:47 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2004-11-24 at 10:30, Darrel Goeddel wrote:
> The prohibition works for us.  Would you like a new patch with these changes?

Yes, please make that change and confirm via testing that it properly
blocks attempts by multi-threaded processes to set their current
context.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
