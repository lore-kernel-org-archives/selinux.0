Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i3NCUZRb007456
	for <selinux@tycho.nsa.gov>; Fri, 23 Apr 2004 08:30:36 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i3NCUYdi004100
	for <selinux@tycho.nsa.gov>; Fri, 23 Apr 2004 12:30:34 GMT
Received: from smtp-bedford.mitre.org (smtp-bedford-x.mitre.org [192.160.51.76])
        by jazzband.ncsc.mil  with ESMTP id i3NCUWJP004094 for <selinux@tycho.nsa.gov>; Fri, 23 Apr 2004 12:30:33 GMT
Received: from smtp-bedford.mitre.org (localhost.localdomain [127.0.0.1])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id i3NCUWN26350
	for <selinux@tycho.nsa.gov>; Fri, 23 Apr 2004 08:30:32 -0400
Received: from localhost.localdomain (divan.mitre.org [129.83.10.75])
	by smtp-bedford.mitre.org (8.11.6/8.11.6) with ESMTP id i3NCUWj26345
	for <selinux@tycho.nsa.gov>; Fri, 23 Apr 2004 08:30:32 -0400
Received: from localhost.localdomain (divan [127.0.0.1])
	by localhost.localdomain (8.12.10/8.12.10) with ESMTP id i3NCUV9u025076
	for <selinux@tycho.nsa.gov>; Fri, 23 Apr 2004 08:30:31 -0400
To: selinux@tycho.nsa.gov
Subject: Re: Policy backward compatibility
References: <1081430495.6379.89.camel@moss-spartans.epoch.ncsc.mil>
	<200404121834.03658.russell@coker.com.au>
	<1081862054.21530.51.camel@moss-spartans.epoch.ncsc.mil>
	<1081862565.21530.56.camel@moss-spartans.epoch.ncsc.mil>
	<1081863227.21530.69.camel@moss-spartans.epoch.ncsc.mil>
From: ramsdell@mitre.org (John D. Ramsdell)
Date: 23 Apr 2004 08:30:31 -0400
In-Reply-To: <1081863227.21530.69.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <ogtpt9yswpk.fsf@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley <sds@epoch.ncsc.mil> writes:

> And likewise for any significant use of booleans, since the
> compatibility code just discards the conditional statements entirely
> rather than generating statements based on the initial boolean value...

The poldecond program, which is part of the most recent slat
distribution, was intended to help with this problem.  It removes
conditionals by generating statements based on the initial boolean
values.  Thus, tools that have not been updated to accept boolean
conditions, such as slat, can be used with a policy file that contains
booleans as long as the file has been preprocessed using poldecond.

The poldecond program is part of the slat sources stored in the
selinux project CVS repository on SourceForge in the nsa module.  We
intend to make a tarball and an RPM of this version of the code
available on a MITRE web server soon, although, our internal approval
process seems to be greatly slowing us down.  The slat change log says
that the poldecond program was checked near the end of February!

John

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
