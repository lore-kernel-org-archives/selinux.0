Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i68DIWrT012872
	for <selinux@tycho.nsa.gov>; Thu, 8 Jul 2004 09:18:32 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i68DIUEg000223
	for <selinux@tycho.nsa.gov>; Thu, 8 Jul 2004 13:18:31 GMT
Subject: Re: userhelper_t vs sysadm_userhelper_t
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>
In-Reply-To: <200407081905.08774.russell@coker.com.au>
References: <200407081905.08774.russell@coker.com.au>
Content-Type: text/plain
Message-Id: <1089292697.6414.22.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Thu, 08 Jul 2004 09:18:17 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2004-07-08 at 05:05, Russell Coker wrote:
> I think that as much as possible the policy should refer to the real 
> domain/type names not aliases.  The attached patch fixes this for 
> userhelper_t.

Perhaps this part of the constraint needs to be reconsidered.  What
about the other *_userhelper_t domains?  Why is a special case
constraint required at all (vs. using privrole and privuser) - is
userhelper transitioning directly to program domains in some cases?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
