Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBT32HIi025970
	for <selinux@tycho.nsa.gov>; Tue, 28 Dec 2004 22:02:18 -0500 (EST)
Received: from mxsf11.cluster1.charter.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBT32KLa009819
	for <selinux@tycho.nsa.gov>; Wed, 29 Dec 2004 03:02:21 GMT
Received: from mxip15.cluster1.charter.net (mxip15a.cluster1.charter.net [209.225.28.145])
	by mxsf11.cluster1.charter.net (8.12.11/8.12.11) with ESMTP id iBT32KYk009826
	for <selinux@tycho.nsa.gov>; Tue, 28 Dec 2004 22:02:21 -0500
From: "Robert Potter" <robertp72@charter.net>
To: "'SELinux ML'" <selinux@tycho.nsa.gov>
Cc: "'Nick Gray'" <nick-lists@austin.rr.com>
Subject: RE: system auditing or event logging facilities
Date: Tue, 28 Dec 2004 19:02:13 -0800
Message-ID: <000101c4ed52$cfed67c0$f2167144@Eng21>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1104285346.22401.75.camel@hawaii.grays-systems.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

For auditing and potential certification (like C2), visit InterSect Alliance
for their SNARE product, or look into Secure Auditing for Linux (SAL).

SAL is a DARPA project on SourceForge to develop a kernel level auditing
package for Red Hat Linux that is compliant with the Common Criteria
specifications (C2 level equivalency). It uses encryption to protect logged
data. While it is not ready to meet a C2 cert, you can see details of
progress and a comparison between common criteria and the current software
version at: http://secureaudit.sourceforge.net

You might also ask Trent Jaeger at IBM research for the latest info, as he
reads this list.

Regards,
Rob Potter

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
Behalf Of Nick Gray
Sent: Tuesday, December 28, 2004 5:56 PM
To: SELinux ML
Subject: system auditing or event logging facilities

I am looking into C2/Capp auditing/event logging. Has there been any
work on this in regards to SELinux ?

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
