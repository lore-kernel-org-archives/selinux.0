Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iA1K4pXZ029667
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 15:04:51 -0500 (EST)
Received: from oe-im2.bizmailsrvcs.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id iA1K4pVW006251
	for <selinux@tycho.nsa.gov>; Mon, 1 Nov 2004 20:04:51 GMT
From: "Frank Mayer" <mayerf@tresys.com>
To: "'Chad Hanson'" <chanson@TrustedCS.com>,
   "'Darrel Goeddel'" <DGoeddel@TrustedCS.com>, <selinux@tycho.nsa.gov>
Cc: "'Stephen Smalley'" <sds@epoch.ncsc.mil>
Subject: RE: dynamic context transitions
Date: Mon, 1 Nov 2004 15:04:46 -0500
Message-ID: <004301c4c04e$0b8f0180$1e0c010a@columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <36282A1733C57546BE392885C06185924D90DB@chaos.tcs.tcs-sec.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Chad Hanson wrote:
> If these are independent, TE would not be able to control/restrict
> operations from the MLS policy. 

I'm still not clear on why TE needs to control MLS.  It seems to me that both
types of access control should be necessary, neither should be sufficient, in
order to obtain access.    

> The addition of a dynamic transition
> provides an extra ability, only when necessary, to tighten the
> security of a process.

Let me try another approach.  We're in the process of designing language
extensions that will be part of a policy management service (building upon the
binary module work that Karl should release later tonight).  One aspect of these
extension will introduce a name hierarchy  for types.  Implicit in this
hierarchy is the idea that a subordinate type cannot exceed the access
privileges of any of its higher types.  For example, take types 'foo' and
'foo.bar' ("." represents a hierarchy).  In this case, what we're planning (so
far) is that the type foo.bar can have the same or less, but not more, access
permission than the type foo in the policy.  There are many reasons why such a
semantic is useful.  

So if we had such a semantic implemented and enforced now, I would feel a lot
better if the type can only decrease down the hierarchy, and never laterally or
up the hierarchy.  Would this meet the need?  This would certainly be more
defensible in my mind [I know this is somewhat hypothetical since the language
extension does not yet exist, and will be some time in coming].

Frank



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
