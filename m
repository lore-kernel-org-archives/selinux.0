Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7ELUVMn024139
	for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2009 17:30:31 -0400
Received: from relay1.gtri.gatech.edu (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7ELU2tl016881
	for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2009 21:30:02 GMT
Received: from apatlisdmail24.core.gtri.org (apatlisdmail24.core.gtri.org [130.207.199.195])
	by relay1.gtri.gatech.edu (Spam Firewall) with ESMTP id C10FF6A4A6D
	for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2009 17:30:28 -0400 (EDT)
Received: from apatlisdmail24.core.gtri.org (apatlisdmail24.core.gtri.org [130.207.199.195]) by relay1.gtri.gatech.edu with ESMTP id 4Idn6ABs6dBBHKge for <selinux@tycho.nsa.gov>; Fri, 14 Aug 2009 17:30:28 -0400 (EDT)
Subject: Not quite MLS.
From: rob myers <rob.myers@gtri.gatech.edu>
To: <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Fri, 14 Aug 2009 17:30:26 -0400
Message-ID: <1250285426.3588.87.camel@rxm-581b.stl.gtri.gatech.edu>
MIME-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I would like to create a login that has access to one category at the
highest sensitivity level, but in another category only has access at a
lower sensitivity level.  For example, on a system where SystemHigh is
s0-s3:c0.c3, one login could be defined as something similar to:
s0-s1:c0.c3, s2:c2.c3, s3:c3, while another login could be defined as
s0-s2:c0.c3, s3:c0.c2 .

Am I correct that MLS policy cannot support this scenario?

Is this possible under any old, current, or developmental SELinux
policy?

Would it be possible to write such a policy with the existing SELinux
user/kernel land?

Thanks for any pointers,

rob.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
