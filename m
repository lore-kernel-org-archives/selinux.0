Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id mA6ApuKm002509
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2008 05:51:56 -0500
Received: from tyo202.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id mA6AoFgp007857
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2008 10:50:16 GMT
Received: from mailgate3.nec.co.jp ([10.7.69.161])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id mA6AprAK016854
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2008 19:51:53 +0900 (JST)
Received: (from root@localhost) by mailgate3.nec.co.jp (8.11.7/3.7W-MAILGATE-NEC)
	id mA6AprD26158 for selinux@tycho.nsa.gov; Thu, 6 Nov 2008 19:51:53 +0900 (JST)
Received: from mailsv.linux.bs1.fc.nec.co.jp (mailsv.linux.bs1.fc.nec.co.jp [10.34.125.2])
	by mailsv.nec.co.jp (8.13.8/8.13.4) with ESMTP id mA6ApqT0013317
	for <selinux@tycho.nsa.gov>; Thu, 6 Nov 2008 19:51:52 +0900 (JST)
Received: from [10.19.71.82] (unknown [10.19.71.82])
	by mailsv.linux.bs1.fc.nec.co.jp (Postfix) with ESMTP id 92F89E48236
	for <selinux@tycho.nsa.gov>; Thu,  6 Nov 2008 19:51:52 +0900 (JST)
Message-ID: <4912CC48.80405@ak.jp.nec.com>
Date: Thu, 06 Nov 2008 19:51:52 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: SE-PostgreSQL documentation
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Nowaday, I'm working to revise the documentation of SE-PostgreSQL at:
  http://wiki.postgresql.org/wiki/SEPostgreSQL

The SE-PostgreSQL feature is now under reviewing for the upstreamed
PostgreSQL v8.4.x development cycle.
A PostgreSQL folks told me a comprehensive documentation is desirable
while the series of discussion. In addition, it should be on the wiki
due to its maintenancibility.

At the past, I provided "The SE-PostgreSQL Security Guide" as a PDF
document, but some of them got legacy now, so I thought it's a good
time to revise it.

If you can comment anything, please feel free to notice them.
As I'm not a native English user, it's unclear for me the descriptions
are enough correct/simple to understand.

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
