Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kADE0lXH016503
	for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2006 09:00:47 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id kADDxAvm023101
	for <selinux@tycho.nsa.gov>; Mon, 13 Nov 2006 13:59:11 GMT
Subject: Re: MLS policy constraints verification
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Klaus Weidner <klaus@atsec.com>, Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20061111183721.GA629@w-m-p.com>
References: <20061111183721.GA629@w-m-p.com>
Content-Type: text/plain
Date: Mon, 13 Nov 2006 09:02:47 -0500
Message-Id: <1163426567.18181.104.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-11-11 at 12:37 -0600, Klaus Weidner wrote:
> in the ongoing LSPP evaluation project, a review of the constraints
> defined in "policy/mls" in the refpolicy turned up some suspicious
> entries.
> 
> Could people who wrote the policy or have opinions on what it's supposed
> to be please comment?

The constraints are almost all from the old example policy and were
written by TCS since they did the enhanced MLS support.  Since I'm not
familiar with the LSPP requirements, I can't speak to whether or not the
MLS is strict enough to meet the requirements.  Chad, Darrel?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
