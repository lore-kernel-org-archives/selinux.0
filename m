Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id NAA10095
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2001 13:33:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id RAA06695
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2001 17:32:39 GMT
Received: from glaurung.green-gryphon.com (cmc3107833-a.mbl1.al.home.com [24.37.208.47])
	by jazzband.ncsc.mil  with ESMTP id RAA06691
	for <selinux@tycho.nsa.gov>; Tue, 25 Sep 2001 17:32:38 GMT
To: selinux@tycho.nsa.gov
Subject: Clarification about distribution terms on the software
From: Manoj Srivastava <manoj.srivastava@stdc.com>
Date: Tue, 25 Sep 2001 12:28:33 -0500
Message-ID: <87vgi75ge6.fsf@glaurung.green-gryphon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 Hi,
	[This is a repost from the address I am subscribed with, and
	hence some people on the internal list shall see this as a
	duplicate. I apologize for the inconvenience]
 
         A number of developers for the Debian Project (http://www.debian.org/)
  have expressed an interest in rolling in a kernel-patch-selinux
  package, for inclusion in the Debian GNU?Linux distribution.
 
 	The criteria for inclusion of a package in the project are
  defined by the ``Debian Free Software Guidelines'' contained in the
  ``Social Contract'' (http://www.debian.org/social_contract). 
 
 	The initial impressions were good: The License terms at
  http://www.nsa.gov/selinux/license.html makes it very clear that the
  license terms are DFSG compliant. 
 
 	The confusion arises as one tries to download the sources, and
  is presented with  http://www.nsa.gov/selinux/src-disclaim.html; one
  is now required to agree to a legal agreement (I am not a lawyer, it
  seems to be a restatement of the standard lack of warranty
  clauses. However, I am not a lawyer).
 
 	One of the questions that arise from this is: Whom does the
  NSA want this agreement from? Me, as a packager, the Debian Project,
  as the distributor, or the end user of the software who is going to
  install it on their machines, and may be impacted by any flaws in the
  process of doing so?  If indeed the end user agreement is required,
  SELinux would not meet the DFSG.
 
 	Arguably, since the software itself is licensed under the GPL,
  on may, after downloading the software, further redistribute it as
  provided for by the GPL.
 
 	However, Debian is not in the business of not adhering to
  upstream author wishes, and we would like to honour the intent, as
  opposed to the letter, of the license.  Given that, the simplest
  process was to come to the horses mouth and ask the authors what
  their intent when putting a click-through legal agreement (which may
  well be binding in the state where jurisdiction lies) on the software
  download? Is agreement of the end users required, or is this only for
  the initial download?  
 
 	manoj

-- 
 No animal should ever jump on the dining room furniture unless
 absolutely certain he can hold his own in conversation. Fran Lebowitz
Manoj Srivastava   <manoj.srivastava@stdc.com>    <srivasta@debian.org> 
1024R/C7261095 print CB D9 F4 12 68 07 E4 05  CC 2D 27 12 1D F5 E8 6E
1024D/BF24424C print 4966 F272 D093 B493 410B  924B 21BA DABB BF24 424C

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
