Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA05629
	for <selinux@tycho.nsa.gov>; Wed, 12 Feb 2003 13:54:05 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA07039
	for <selinux@tycho.nsa.gov>; Wed, 12 Feb 2003 18:51:00 GMT
Received: from hellcat.admin.navo.hpc.mil (hellcat.admin.navo.hpc.mil [204.222.179.34])
	by jazzswing.ncsc.mil  with ESMTP id SAA07035
	for <selinux@tycho.nsa.gov>; Wed, 12 Feb 2003 18:51:00 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: j.logsdon@lancaster.ac.uk, selinux@tycho.nsa.gov
Subject: Re: Simple question
Date: Wed, 12 Feb 2003 12:53:26 -0600
References: <Pine.LNX.4.10.10302121830350.25327-100000@mercury.quantex>
In-Reply-To: <Pine.LNX.4.10.10302121830350.25327-100000@mercury.quantex>
MIME-Version: 1.0
Message-Id: <200302121253.26502.pollard@admin.navo.hpc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 12 February 2003 12:32 pm, j.logsdon@lancaster.ac.uk wrote:
> Hi
>
> In general terms, what does SEL do that I can't do (even if more
> complicated) by Access Control Lists?  If I can control the users and
> groups that can access files (and these are all properly set) what
> advantage do I have in running SEL?

ACLs are under the control of the user. The user choses the other users that
may access the files that the user owns.

SELinux is under the control of the security administrator. This includes the
files that the user owns. Even if the user wants a specific other user to have
access to a file, if that user is not in a domain containing the other user 
(ie, both are in the same domain) then the other user still cannot access the 
file.

> I'm not being rude - just trying to understand the difference and to see
> whether it is really necessary to run a bespoke kernel.

The difference is in mandatory access vs descretionary access.

As far as the system files go, if all are carefully given approprate ACLs, 
then they can be protected. However, if the root accout is hacked, the files
are still vulnerable.

If a SELinux system is hacked, unless the hack itself contains an all powerful
label/domain, the hack still doesn't have access to all of the files.. Only 
those belonging to the domain of the hacked daemon.

Others may have more detailed/correct answers, but this should be the
lowest common denominator.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
