Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA18183
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2001 09:59:26 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA19321
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2001 14:59:18 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id OAA19316
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2001 14:59:17 GMT
Date: Mon, 26 Feb 2001 09:58:19 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Pagano, Art" <art_pagano@tds.com>
cc: "'selinux@tycho.nsa.gov'" <selinux@tycho.nsa.gov>
Subject: Re: Is This a bad thing....
In-Reply-To: <7408C3158945264B85D07250D7A2C8010C7978@satxmail.tds.com>
Message-ID: <Pine.SOL.3.95.1010226095411.21535D-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


> Installing the initial policy configuration. 
> 
> error in the statement ending on line 22875 (token 'user'): syntax error 
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
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
