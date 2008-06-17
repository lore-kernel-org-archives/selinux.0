Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5HIuKOv019548
	for <selinux@tycho.nsa.gov>; Tue, 17 Jun 2008 14:56:20 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m5HIuKeu003455
	for <selinux@tycho.nsa.gov>; Tue, 17 Jun 2008 18:56:20 GMT
Subject: [RFC] rbacsep: eliminate untrusted content types
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Tue, 17 Jun 2008 14:55:36 -0400
Message-Id: <1213728936.11146.108.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

There is a set of types for each role, *_untrusted_content_t and
*_untrusted_content_tmp_t which was from before refpolicy.  The original
premise for their use was so that low integrity data coming out of
network applications would be written out with these types, and then the
role would have to upgrade it before using it.  However, the policy is
kinda half-baked as mozilla, thunderbird, and evolution domains are the
only ones that can even create files with these types, and only if a
boolean is enabled.  I don't think that anyone uses these types.  Both
Dan and myself would like to eliminate these types; are there any
objections?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
