Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i35NBpRb028090
	for <selinux@tycho.nsa.gov>; Mon, 5 Apr 2004 19:11:51 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i35NBomw004833
	for <selinux@tycho.nsa.gov>; Mon, 5 Apr 2004 23:11:50 GMT
Received: from abyss.simplyaquatics.com (abyss.simplyaquatics.com [69.44.152.139])
        by jazzband.ncsc.mil  with ESMTP id i35NBn4w004830 for <selinux@tycho.nsa.gov>; Mon, 5 Apr 2004 23:11:50 GMT
From: "Ed Street" <edstreet@street-tek.com>
To: "'Rogelio Serrano'" <rogelio@smsglobal.net>, <selinux@tycho.nsa.gov>
Subject: RE: role of pax
Date: Mon, 5 Apr 2004 19:11:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
In-Reply-To: <62a9a88a4e1ed0d0d1cd1c3beb953026@debian>
Message-Id: <20040405231148.2A7563A404F@abyss.simplyaquatics.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

There's a patch that allows PAX to be controlled via selinux policy.  I
think it's available from the gentoo side of the house.

Ed

-----Original Message-----
From: owner-selinux@tycho.nsa.gov [mailto:owner-selinux@tycho.nsa.gov] On
Behalf Of Rogelio Serrano
Sent: Monday, April 05, 2004 5:46 AM
To: selinux@tycho.nsa.gov
Subject: role of pax

Hi i just rebuilt an selinux + pax system on uclibc. Now im 
beginning to consider  taking out pax since it breaks the GNU 
obective-c runtime. What is the significance of pax?

 

---

Checked by AVG anti-virus system (http://www.grisoft.com).
Version: 6.0.648 / Virus Database: 415 - Release Date: 3/31/2004
 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
