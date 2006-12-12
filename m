Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBCJLG4a002565
	for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2006 14:21:17 -0500
Received: from atlrel6.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBCJLlch002422
	for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2006 19:21:48 GMT
Received: from taynzmail03.nz-tay.cpqcorp.net (relay.dec.com [16.47.4.103])
	by atlrel6.hp.com (Postfix) with ESMTP id 6D08536699
	for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2006 14:21:47 -0500 (EST)
Received: from kitche.zk3.dec.com (kitche2.zk3.dec.com [16.140.160.162])
	by taynzmail03.nz-tay.cpqcorp.net (Postfix) with ESMTP id 44DF15562
	for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2006 14:21:49 -0500 (EST)
Message-ID: <457F0145.7020305@hp.com>
Date: Tue, 12 Dec 2006 14:21:41 -0500
From: Matt Anderson <mra@hp.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: matchpathcon() for arbitrary subjects
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm trying to get the CUPS print server to print to a file on the file
system.  In order to do this in a usable way I want to be able to query
the SELinux security server as to what the type of a file would be for a
given directory.  This is essentially what matchpathcon() does, and I
can get that to work.

The part I'm having trouble with is I'm making this call from cupsd with
the context of system_u:system_r:cupsd_t:SystemHigh and getting a
response for that type.  I'd like to make the call from that context,
but asking the server what the result would be for a given user's
context (such as user_u:user_r:user_lpr_t:SystemLow) is this possible
with some other existing function?

-matt

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
