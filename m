Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KID2Rb021432
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 14:13:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4KID0AR019974
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 18:13:00 GMT
Received: from moss-huskies.epoch.ncsc.mil (moss-huskies.epoch.ncsc.mil [144.51.25.7])
        by jazzband.ncsc.mil  with ESMTP id i4KICxHn019971 for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 18:12:59 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4KICvWG026063
	for <selinux@tycho.nsa.gov>; Thu, 20 May 2004 14:12:57 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.8/8.12.8/Submit) id i4KICvR4026061
	for selinux@tycho.nsa.gov; Thu, 20 May 2004 14:12:57 -0400
From: Russell Coker <rcoker@redhat.com>
Reply-To: rcoker@redhat.com
To: "Bush, Daniel" <Daniel.Bush@boeing.com>
Subject: Re: Policy compiler issues.
Date: Thu, 20 May 2004 13:22:23 +1000
Cc: "SELinux" <SELinux@tycho.nsa.gov>
References: <E7E29FA7C732D146887C784B34AEF6A0044E3FD7@xch-ne-01.ne.nos.boeing.com>
In-Reply-To: <E7E29FA7C732D146887C784B34AEF6A0044E3FD7@xch-ne-01.ne.nos.boeing.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405201322.23573.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 20 May 2004 08:10, "Bush, Daniel" <Daniel.Bush@boeing.com> wrote:
> It's my
> understanding that whenever the users' list changes (aside from default
> users)in a SELinux system, that the policy files and security labels need
> to be re-compiled. Is there any way around that? Can a user be assigned a
> set of (non-default user) roles without re-compiling the security system?

You can add new users to the policy database or permit existing users to use 
more roles without any significant cost.  You have to build and install a new 
policydb which isn't a significant cost (but may be on embedded systems - I 
never got M4 to work on an iPaQ, and the >3M of storage required is a problem 
when you only have 32M on the system).

If you want to remove a user then you will need to relabel any files that they 
may have created.  That is usually limited to their home 
directory, /tmp, /var/tmp, and /var/run (shouldn't be a huge cost).  Removing 
roles from a user does not necessarily require relabelling any files (but may 
deny that user access to files that they had created if you don't relabel).

>   Another question: Can SELinux be compiled under uClibc? I'm not having
> much luck at that, and I was wondering if something special needed to be
> done, or if anybody had any tips.

What compile errors do you get?  It should work but AFAIK no-one has bothered 
trying to do it before.

-- 
http://apac.redhat.com/disclaimer
See above URL for disclaimer.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
