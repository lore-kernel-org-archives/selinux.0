Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4JBudRb009346
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 07:56:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4JBsEB2003963
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 11:54:14 GMT
Received: from abyss.simplyaquatics.com (abyss.simplyaquatics.com [69.44.152.139])
	by jazzswing.ncsc.mil  with ESMTP id i4JBsDwi003960
	for <selinux@tycho.nsa.gov>; Wed, 19 May 2004 11:54:13 GMT
From: "Ed Street" <edstreet@street-tek.com>
To: "'Luke Kenneth Casson Leighton'" <lkcl@lkcl.net>,
   "'SE-Linux'" <selinux@tycho.nsa.gov>
Subject: RE: adduser script
Date: Wed, 19 May 2004 07:56:33 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
In-Reply-To: <20040519091721.GA8839@lkcl.net>
Message-Id: <20040519115634.9C18D3A4054@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

That should not be to difficult, just pass a context(s) switch or prompt for
it.

Ed


-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
Behalf Of Luke Kenneth Casson Leighton
Sent: Wednesday, May 19, 2004 5:17 AM
To: SE-Linux
Subject: adduser script

has anyone considered writing an adduser script modification
for selinux that adds users to /etc/selinux/users?

---

Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.687 / Virus Database: 448 - Release Date: 5/16/2004
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
