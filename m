Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA22182
	for <selinux@tycho.nsa.gov>; Wed, 8 Jan 2003 13:02:32 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h08I2VI01746
	for <selinux@tycho.nsa.gov>; Wed, 8 Jan 2003 18:02:31 GMT
Received: from mx.nas-smoothtransition.com (nas-vm-159.nas-smoothtransition.com [66.95.157.159] (may be forged))
        by jazzband.ncsc.mil  with ESMTP id h08I2Sf01742 for <selinux@tycho.nsa.gov>; Wed, 8 Jan 2003 18:02:29 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Westerman, Mark'" <Mark.Westerman@csoconline.com>,
        "'Stephen D. Smalley'" <sds@epoch.ncsc.mil>, <guttman@mitre.org>,
        <selinux@tycho.nsa.gov>
Subject: RE: Policy Language
Date: Wed, 8 Jan 2003 13:02:01 -0500
Message-ID: <000a01c2b740$0f11f420$6600a8c0@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <72222DC86846D411ABD300A0C9EB08A1015244A8@csoc-mail-box.csoconline.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> That why I am posting to the list to try and get a feel from the
> people who have created the tools. 

Without comment on the specific proposal (which I haven't studied yet),
I do have a general request: 

I would ask that we only change the policy syntax reluctantly and as
limited as possible, and only for strong need.  Every time the language
changes, it can be a lot or little work for us to sync up our parser for
setools.  Since we have a requirement to maintain backwards
compatibility with older policy syntax, each change can be a lot of
work.

Frank



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
