Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA02319
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2001 15:30:22 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA11967
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2001 20:30:00 GMT
Received: from mx2.tds.com (mx2.tds.com [165.159.62.4])
	by jazzswing.ncsc.mil  with ESMTP id UAA11963
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2001 20:29:59 GMT
Received: from mx2.tds.com (localhost.localdomain [127.0.0.1])
	by mx2.tds.com (8.9.3/8.9.3) with ESMTP id MAA01444
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2001 12:30:19 -0800
Received: from cerberus ([165.159.62.50])
	by mx2.tds.com (8.9.3/8.9.3) with SMTP id MAA01428
	for <selinux@tycho.nsa.gov>; Wed, 28 Feb 2001 12:30:19 -0800
Message-ID: <7408C3158945264B85D07250D7A2C8010C797A@satxmail.tds.com>
From: "Pagano, Art" <art_pagano@tds.com>
To: "'Stephen Smalley '" <sds@tislabs.com>,
        "'selinux@tycho.nsa.gov'"
	 <selinux@tycho.nsa.gov>
Subject: RE: Is This a bad thing....
Date: Wed, 28 Feb 2001 12:30:07 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

Well I have been poking around in the initpolicy.conf file amoung others but
haven't been able to  get the kernel to build....

Any more ideas??

Art

-----Original Message-----
From: Stephen Smalley
To: Pagano, Art
Cc: 'selinux@tycho.nsa.gov'
Sent: 2/26/01 6:58 AM
Subject: Re: Is This a bad thing....


> Installing the initial policy configuration. 
> 
> error in the statement ending on line 22875 (token 'user'): syntax
error 
> 
> ../kernel/security/checkpolicy:  error(s) encountered while parsing 
> configuratio 
> n 
> make: *** [initpolicy] Error 1 

Based on this output, I would guess that there is an error in your
policy/users file.  When you edited policy/users for your users,
perhaps you forgot a semicolon.  You can look at the lines around
line 22875 of your policy/policy.conf file to look for the particular
error, and can then fix your policy/users file.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com




--
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
