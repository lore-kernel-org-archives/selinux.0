Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2AGujRQ018667
	for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2006 11:56:45 -0500
Received: from atlrel9.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2AGtBkb002160
	for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2006 16:55:11 GMT
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.11.136.114])
	by atlrel9.hp.com (Postfix) with ESMTP id 9E5CD38C79
	for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2006 11:56:44 -0500 (EST)
Received: from [16.116.100.149] (unknown [16.116.100.149])
	by smtp2.fc.hp.com (Postfix) with ESMTP id 318B418A0
	for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2006 16:56:44 +0000 (UTC)
Message-ID: <4411AFCB.60401@hp.com>
Date: Fri, 10 Mar 2006 11:56:43 -0500
From: Paul Moore <paul.moore@hp.com>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
Subject: Query MLS info outside of SELinux/LSM?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Is there a way to query the number of MLS sensitivity levels and 
categories outside of the SELinux LSM?  I haven't seen anything, but 
thought I would ask before I started looking at alternatives ... which 
brings me to my next question - would anyone have an objection to adding 
this functionality?

-- 
paul moore
linux security @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
