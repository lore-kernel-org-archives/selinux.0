Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4I9d5Rb029972
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 05:39:07 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4I9afB2029591
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 09:36:41 GMT
Received: from bifrost.lesbell.com.au (ffps.lesbell.com.au [203.35.202.155])
	by jazzswing.ncsc.mil  with ESMTP id i4I9adwi029588
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 09:36:40 GMT
Subject: Re: suggestion to help transition to selinux: dynamic loading of
          libselinux
To: "Chris Babcock" <cbabcock@luthresearch.com>
Cc: selinux@tycho.nsa.gov
Message-ID: <OFC9F6DDFC.10588DF6-ONCA256E98.00360A82@lesbell.com.au>
From: "Les Bell" <lesbell@lesbell.com.au>
Date: Tue, 18 May 2004 19:50:34 +1000
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


"Chris Babcock" <cbabcock@luthresearch.com> wrote:

>>
Does this sound dangerous to anybody else?
<<

Does the design of SELinux depend on the state machine theory of security,
i.e. if a system starts in a secure state, and all transitions are secure,
then the system will remain secure? This design would seem unable to
support that theory, i.e. until the selinux library is loaded, there are no
constraints on the state of the machine. Just a thought. . .

Best,

--- Les Bell, RHCE, CISSP
[http://www.lesbell.com.au]



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
