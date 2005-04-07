Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j37Gdsue027350
	for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2005 12:39:54 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j37GbHEI004668
	for <selinux@tycho.nsa.gov>; Thu, 7 Apr 2005 16:37:19 GMT
Date: Thu, 7 Apr 2005 17:46:45 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: I am attempting to add a secadm_r
Message-ID: <20050407164645.GX19784@lkcl.net>
References: <425553ED.1040703@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <425553ED.1040703@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Apr 07, 2005 at 11:38:21AM -0400, Daniel J Walsh wrote:

> around this, from sysadm_r.   I know that, but when I was at DOD
> a couple of weeks ago they stated that they wanted a separate role from 
> policy management, from the role of the system administrator.  They
> did not care about this being protected, but wanted a way to stop 
> accidentally modifying the machine.  In DOD the System Administrator and
> the Security Administrator are different roles. 
 
 GREAT - if you get this working and can make it "look" like
 the present method by setting secadm_r as an alias to sysadm_r
 so it "looks" like sysadm_r has policy modification rights,
 i would be DELIGHTED.

 i too have a situation where a day-to-day operator is given _far_ too
 much rights - including the right to be able to switch off selinux,
 modify policy etc.

 this is _way_ too trusting of the day-to-day operator, who
 otherwise needs root-style access in order to manage files
 in a special transfer area, and do other things to the box
 that require root-level privileges (such as adding new user
 accounts and setting up new file transfer areas)

 if someone knows of a way to have two logins, one of which requires
 one password to get to root-with-sysadm_r privileges, and one of which
 requires a DIFFERENT password to get to root-with-secadm_r privileges,
 and never the two shall meet, i would be DELIGHTED to hear of such a
 method.

 i have a customer in the process of testing the system i have set up
 for them and i would like to be able to tell them that it is not
 necessary to hammer into the operator that they must not do things like
 disable selinux, edit the policy, i want to be able to tell them the
 operator CANNOT disable selinux, edit the policy - but they can still
 run adduser.

 any assistance greatly appreciated.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
