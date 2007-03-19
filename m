Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2JEHQHM026955
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 10:17:26 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l2JEHP3K028688
	for <selinux@tycho.nsa.gov>; Mon, 19 Mar 2007 14:17:25 GMT
Subject: Last call for objections to 2 significant policy changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Mon, 19 Mar 2007 14:17:57 +0000
Message-Id: <1174313877.29664.54.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is the last chance for objections to these policy changes:

1.  Removal of the disable transition booleans in the targeted policy.
See this email for the reasons:
http://marc.info/?l=selinux&m=117339324826278&w=2.

2.  Merge sbin_t and ls_exec_t into bin_t.  This comes up from time to
time on the list.  The difference between bin_t and sbin_t was never
really clear, and the set of programs that go in
the /sbin, /bin, /usr/sbin, and /usr/bin directories has never been very
consistent, especially between distributions.

>From what I understand, ls_exec_t's original purpose was to
differentiate it from other binaries so you could only allow ftpd to
exec ls but not the others.  The containment ftpd already has is a
stronger protection than denying ftp from exec'ing misc programs on the
system.  At this time ftp can exec bin_t and sbin_t too.

If there are no objections, I plan on making these changes on Friday
(March 23rd).

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
