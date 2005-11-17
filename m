Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jAHJAKMA013370
	for <selinux@tycho.nsa.gov>; Thu, 17 Nov 2005 14:10:20 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jAHJ2awh015381
	for <selinux@tycho.nsa.gov>; Thu, 17 Nov 2005 19:02:36 GMT
Subject: Re: Current Reference Policy patch
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <437CA7D7.6090308@redhat.com>
References: <437CA7D7.6090308@redhat.com>
Content-Type: text/plain
Date: Thu, 17 Nov 2005 14:02:44 -0500
Message-Id: <1132254164.7259.61.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2005-11-17 at 10:55 -0500, Daniel J Walsh wrote:
> Need to turn on rpm and not alias to unconfined_t, because the rule
> 
> rpm_t->shell_exec_t->rpm_script_t was causing all terminal windows to 
> run in rpm_script_t in targeted.

Yesterday I disabled that transition in targeted (it was the one causing
the xdm logins to go to rpm_script_t), so do you still want to rpm_t as
non-aliased?

> Allow users to su to root and then suspend the session.
> 
> Pegasus policy was too loose.
> /bin/ksh should be sheel_exec_t
> (.*)?  is the same as .* and causes python to blow up.
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
