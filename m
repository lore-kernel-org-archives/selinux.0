Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8N0WAsJ010363
	for <selinux@tycho.nsa.gov>; Mon, 22 Sep 2003 20:32:10 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h8N0UPd0014485
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 00:30:25 GMT
Received: from smtpproxy1.mitre.org (smtpproxy1.mitre.org [192.160.51.75])
	by jazzswing.ncsc.mil  with ESMTP id h8N0UPVY014482
	for <selinux@tycho.nsa.gov>; Tue, 23 Sep 2003 00:30:25 GMT
To: "Frank Mayer" <mayerf@tresys.com>
Cc: <SELinux@tycho.nsa.gov>, guttman@mitre.org (Joshua D. Guttman)
Subject: Re: New release of setools
Reply-To: guttman@mitre.org (Joshua D. Guttman disp: current)
References: <000b01c3814d$bac82690$8100a8c0@columbia.tresys.com>
From: guttman@mitre.org (Joshua D. Guttman)
Date: 22 Sep 2003 20:31:49 -0400
In-Reply-To: <000b01c3814d$bac82690$8100a8c0@columbia.tresys.com>
Message-ID: <nhay8wgxs3u.fsf@malabar.mitre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

"Frank Mayer" <mayerf@tresys.com> writes:

>   The most significant enhancements are in apol (the analysis tool),
>   where we spent a lot of time implementing a pair of partial
>   information flow analysis capabilities, and extending the domain
>   transition analysis.  We also included some new help files
>   describing these analyses.  This help remains brief; we're working
>   on some more scholarly papers about policy analysis.

Frank --

It would be interesting to compare your approach with MITRE's.  You
can read about what we've been doing at
http://www.ccs.neu.edu/home/guttman/selinux.ps 

I hope we can an opportunity to talk over the relationships in our
work some time soon.  

Regards --

        Joshua 
-- 
	Joshua D. Guttman		<guttman@mitre.org>
	MITRE, Mail Stop S119		Office:	+1 781 271 2654
	202 Burlington Rd.		Fax:	+1 781 271 8953
	Bedford, MA 01730-1420 USA	Cell:	+1 781 526 5713



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
