Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hAPIK7Rb015389
	for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2003 13:20:07 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hAPIJXp5015235
	for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2003 18:19:33 GMT
Received: from crisium.vnl.com (crisium.vnl.com [194.46.8.33])
	by jazzswing.ncsc.mil  with ESMTP id hAPIJWt0015230
	for <selinux@tycho.nsa.gov>; Tue, 25 Nov 2003 18:19:33 GMT
Date: Tue, 25 Nov 2003 18:19:57 +0000
From: Dale Amon <amon@vnl.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: Re: Still no authentication from new debian packages
Message-ID: <20031125181957.GN2718@vnl.com>
References: <20031125140255.GI2718@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20031125140255.GI2718@vnl.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Just to add a little more... I've been looking through
the newrole code and probing in /proc. I'm beginning
to think there is something wrong with the version of
login I have because I can't see how I could end up
logged in as root and be in system_u:system_r:local_login_t
(according to id and /proc/self/attr/current) afterwards.

-- 
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
