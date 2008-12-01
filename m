Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mB1DYU2e012742
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2008 08:34:30 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id mB1DWLkD017245
	for <selinux@tycho.nsa.gov>; Mon, 1 Dec 2008 13:32:26 GMT
Subject: Re: Extracting constraints and MLS constraints from policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Sanjai Narain <narain@research.telcordia.com>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <492DB764.5050906@research.telcordia.com>
References: <492DB764.5050906@research.telcordia.com>
Content-Type: text/plain
Date: Mon, 01 Dec 2008 08:33:46 -0500
Message-Id: <1228138429.29210.42.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2008-11-26 at 15:53 -0500, Sanjai Narain wrote:
> Hello: Is it possible to extract these? Not sure I saw an option in 
> sesearch for this. Thanks. -- Sanjai

SETools doesn't currently have support for examining any constraints at
this time.  The feature has been low priority for a long time; however,
due to UBAC it will have a higher priority.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
