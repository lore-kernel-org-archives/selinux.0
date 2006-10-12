Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9CJLHf4006479
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 15:21:17 -0400
Received: from atlrel8.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k9CJKaRR022728
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 19:20:37 GMT
Received: from taynzmail03.nz-tay.cpqcorp.net (taynzmail03.nz-tay.cpqcorp.net [16.47.4.103])
	by atlrel8.hp.com (Postfix) with ESMTP id AF636393AB
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 15:20:35 -0400 (EDT)
Received: from kitche.zk3.dec.com (kitche3.zk3.dec.com [16.140.160.165])
	by taynzmail03.nz-tay.cpqcorp.net (Postfix) with ESMTP id 60282670A
	for <selinux@tycho.nsa.gov>; Thu, 12 Oct 2006 15:20:06 -0400 (EDT)
Message-ID: <452E955F.2050407@hp.com>
Date: Thu, 12 Oct 2006 15:19:59 -0400
From: Matt Anderson <mra@hp.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: context_sensitivity_{get|set}
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For my latest CUPS patch I needed to include code that set the
sensitivity of the spool file storing the to that of the client's
context when they queued the job.  I used context_range_get() to
retrieve the MLS range, but then had to use strtok() to get the lower bound.

Is context_sensitivity_get() or context_sensitivity_set() a function
that other consumers might need?  Should it be included in libselinux?

-matt

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
