Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA09113
	for <selinux@tycho.nsa.gov>; Fri, 18 Oct 2002 14:14:53 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA08866
	for <selinux@tycho.nsa.gov>; Fri, 18 Oct 2002 18:13:08 GMT
Received: from troncalo.cs.poste.it ([62.241.4.26])
	by jazzswing.ncsc.mil  with ESMTP id SAA08862
	for <selinux@tycho.nsa.gov>; Fri, 18 Oct 2002 18:13:07 GMT
Received: from inwind.it (80.116.229.60) by troncalo.cs.poste.it (5.5.053.1) (authenticated as giorgio.zanin@poste.it)
        id 3D1C311B000ADC0A for selinux@tycho.nsa.gov; Fri, 18 Oct 2002 19:54:34 +0200
Message-ID: <3DB04B4F.10709@inwind.it>
Date: Fri, 18 Oct 2002 19:56:31 +0200
From: Giorgio Zanin <giorgio.zanin@inwind.it>
MIME-Version: 1.0
To: SELinux mailing list <selinux@tycho.nsa.gov>
Subject: a silly question
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

anyone knows where I can collect papers or any technical report, other 
than those under the "Documentation" link in the NSA web site, about 
SELinux?
I'm trying to figure out a sort of formal model of SELinux but in the 
articles I've studied (those on the NSA web site) there are not many 
technical informations. For example it's not clear to me whether a 
process with a type A, changing its type (due to a domain migration, for 
example, or to any other possible way - which are there?) to B, leaves 
permissions granted in A and get just those in B or get those in A and 
those in B (if I'm not wrong the former is the behaviour in canonical TE 
and so it is supposed to be the right one).
Thank you and excuse me for my silly question

Giorgio


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
